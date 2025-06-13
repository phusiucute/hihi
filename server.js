const express = require('express');
const session = require('express-session');
const mysql = require('mysql2/promise');
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const app = express();

const db = mysql.createPool({
  host: 'localhost',
  user: 'root', // chỉnh lại nếu cần
  password: '', // chỉnh lại nếu cần
  database: 'web',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

app.use(express.static(path.join(__dirname, 'public')));
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(session({
  secret: 'super-secret',
  resave: false,
  saveUninitialized: false,
  cookie: { maxAge: 8 * 60 * 60 * 1000 }
}));

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/');
  },
  filename: function (req, file, cb) {
    const ext = path.extname(file.originalname);
    cb(null, Date.now() + '-' + Math.round(Math.random() * 1E9) + ext);
  }
});
const upload = multer({ storage: storage });

if (!fs.existsSync('uploads')) fs.mkdirSync('uploads');

// API đăng ký
app.post('/api/register', async (req, res) => {
  const { username, password } = req.body;
  if (!username || !password) return res.status(400).json({ message: 'Thiếu thông tin!' });
  try {
    const [rows] = await db.query('SELECT * FROM users WHERE username=?', [username]);
    if (rows.length) return res.status(400).json({ message: 'Tài khoản đã tồn tại!' });
    await db.query('INSERT INTO users (username, password) VALUES (?, ?)', [username, password]);
    res.json({ message: 'Đăng ký thành công!' });
  } catch (e) {
    res.status(500).json({ message: 'Lỗi máy chủ', error: e.message });
  }
});

// API đăng nhập
app.post('/api/login', async (req, res) => {
  const { username, password } = req.body;
  if (!username || !password) return res.status(400).json({ message: 'Thiếu thông tin!' });
  try {
    const [rows] = await db.query('SELECT * FROM users WHERE username=? AND password=?', [username, password]);
    if (!rows.length) return res.status(401).json({ message: 'Sai tài khoản hoặc mật khẩu!' });
    req.session.user = { id: rows[0].id, username: rows[0].username };
    res.json({ message: 'Đăng nhập thành công!', username: rows[0].username });
  } catch (e) {
    res.status(500).json({ message: 'Lỗi máy chủ', error: e.message });
  }
});

// API đăng xuất
app.post('/api/logout', (req, res) => {
  req.session.destroy(() => res.json({ message: 'Đăng xuất thành công!' }));
});

// API lấy info user
app.get('/api/user', (req, res) => {
  res.json(req.session.user || {});
});

// API đăng bài mới với nhiều ảnh và link tài liệu
app.post('/api/documents', upload.array('images', 10), async (req, res) => {
  if (!req.session.user) return res.status(401).json({ message: 'Bạn chưa đăng nhập!' });
  const { title, description, grade, subject, doclink } = req.body;
  if (!title || !grade) return res.status(400).json({ message: 'Thiếu thông tin!' });
  try {
    // Lưu bài viết
    const [result] = await db.query(
      `INSERT INTO documents (user_id, title, description, grade, subject, doclink) VALUES (?, ?, ?, ?, ?, ?)`,
      [req.session.user.id, title, description, grade, subject, doclink]
    );
    const docId = result.insertId;

    // Lưu các ảnh
    if (req.files && req.files.length > 0) {
      for (const file of req.files) {
        await db.query(
          `INSERT INTO document_images (document_id, image) VALUES (?, ?)`,
          [docId, file.filename]
        );
      }
    }
    res.json({ message: 'Đăng bài thành công!' });
  } catch (e) {
    res.status(500).json({ message: 'Lỗi máy chủ', error: e.message });
  }
});

// API lấy danh sách tài liệu (kèm 1 ảnh đại diện, doclink, reactions)
app.get('/api/documents', async (req, res) => {
  const [docs] = await db.query(
    `SELECT d.*, u.username FROM documents d JOIN users u ON d.user_id=u.id ORDER BY d.upload_date DESC LIMIT 100`
  );
  for (let doc of docs) {
    // Lấy 1 ảnh đại diện (nếu có)
    const [imgs] = await db.query(
      `SELECT image FROM document_images WHERE document_id=? LIMIT 1`, [doc.id]
    );
    doc.image = imgs.length ? imgs[0].image : null;
    // Lấy reactions
    const [reacs] = await db.query(
      `SELECT type, COUNT(*) as total FROM reactions WHERE document_id=? GROUP BY type`, [doc.id]
    );
    doc.reactions = {};
    for (let r of reacs) doc.reactions[r.type] = r.total;
  }
  res.json(docs);
});

// API lấy chi tiết tài liệu (kèm tất cả ảnh, doclink, comments, reactions)
app.get('/api/documents/:id', async (req, res) => {
  const [docs] = await db.query(
    `SELECT d.*, u.username FROM documents d JOIN users u ON d.user_id=u.id WHERE d.id=?`, [req.params.id]
  );
  if (!docs.length) return res.status(404).json({ message: 'Không tìm thấy!' });
  const [comments] = await db.query(
    `SELECT c.*, u.username FROM comments c JOIN users u ON c.user_id=u.id WHERE c.document_id=? ORDER BY c.comment_date ASC`,
    [req.params.id]
  );
  const [imgs] = await db.query(
    `SELECT image FROM document_images WHERE document_id=?`, [req.params.id]
  );
  const [reacs] = await db.query(
    `SELECT type, COUNT(*) as total FROM reactions WHERE document_id=? GROUP BY type`, [req.params.id]
  );
  docs[0].images = imgs.map(x => x.image);
  docs[0].reactions = {};
  for (let r of reacs) docs[0].reactions[r.type] = r.total;
  res.json({ ...docs[0], comments });
});

// API bình luận
app.post('/api/comments', async (req, res) => {
  if (!req.session.user) return res.status(401).json({ message: 'Bạn chưa đăng nhập!' });
  const { document_id, content } = req.body;
  if (!document_id || !content) return res.status(400).json({ message: 'Thiếu thông tin!' });
  try {
    await db.query(
      `INSERT INTO comments (document_id, user_id, content) VALUES (?, ?, ?)`,
      [document_id, req.session.user.id, content]
    );
    res.json({ message: 'Bình luận thành công!' });
  } catch (e) {
    res.status(500).json({ message: 'Lỗi máy chủ', error: e.message });
  }
});

// API reaction cảm xúc
app.post('/api/reaction', async (req, res) => {
  if (!req.session.user) return res.status(401).json({ message: 'Bạn chưa đăng nhập!' });
  const { document_id, type } = req.body;
  const validTypes = ['love','like','wow','smile','dislike'];
  if (!document_id || !validTypes.includes(type)) return res.status(400).json({ message: 'Dữ liệu không hợp lệ!' });
  try {
    await db.query(
      `INSERT INTO reactions (document_id, user_id, type) VALUES (?, ?, ?)
      ON DUPLICATE KEY UPDATE type=VALUES(type)`, [document_id, req.session.user.id, type]
    );
    res.json({ status: 'ok' });
  } catch (e) {
    res.status(500).json({ message: 'Lỗi máy chủ', error: e.message });
  }
});

// Route fallback cho SPA
app.get(/^\/(?!api|uploads).*/, (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(3000, () => console.log('Server chạy tại http://localhost:3000'));