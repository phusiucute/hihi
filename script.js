// Navbar
function renderUserNav() {
  fetch('/api/user').then(r => r.json()).then(user => {
    let nav = '';
    if (user && user.username) {
      nav = `<span class="fw-bold text-white me-3">Xin chào, ${user.username}</span>
        <a href="upload.html" class="btn btn-success btn-sm rounded-pill me-2 px-4" style="font-weight:500;">Đăng tài liệu</a>
        <button class="btn btn-outline-primary btn-sm rounded-pill px-4" style="font-weight:500;background:#f4f8ff;border:none;color:#158aff;" onclick="logout()">Đăng xuất</button>`;
    } else {
      nav = `<a href="login.html" class="btn btn-light btn-sm rounded-pill me-2 px-4" style="font-weight:500;">Đăng nhập</a>
        <a href="register.html" class="btn btn-warning btn-sm rounded-pill px-4" style="font-weight:500;">Đăng ký</a>`;
    }
    if (document.getElementById('user-nav'))
      document.getElementById('user-nav').innerHTML = nav;
  });
}
function logout() {
  fetch('/api/logout', {method: 'POST'}).then(() => location.href = 'index.html');
}
if (document.getElementById('user-nav')) renderUserNav();

// Chủ đề sidebar - lọc tài liệu
let currentTopic = "all";
document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('[data-topic]').forEach(a => {
    a.onclick = function(e) {
      e.preventDefault();
      document.querySelectorAll('[data-topic]').forEach(x=>x.classList.remove('active'));
      this.classList.add('active');
      currentTopic = this.getAttribute('data-topic');
      loadDocuments();
      // Đổi tiêu đề
      let title = "Tất cả tài liệu";
      if (currentTopic==="12") title = "Tài liệu lớp 12";
      else if (currentTopic==="11") title = "Tài liệu lớp 11";
      else if (currentTopic==="10") title = "Tài liệu lớp 10";
      else if (currentTopic==="other") title = "Tài liệu khác";
      else if (currentTopic==="qa") title = "Hỏi đáp";
      document.getElementById('page-title') && (document.getElementById('page-title').innerText = title);
    }
  });
  loadDocuments();
});

// Load danh sách tài liệu
function loadDocuments() {
  if (!document.getElementById('documents-list')) return;
  fetch('/api/documents').then(r => r.json()).then(list => {
    let html = '';
    for (let doc of list) {
      // Lọc theo chủ đề
      if (currentTopic !== "all") {
        if (currentTopic === "qa" && doc.grade !== "qa") continue;
        else if (currentTopic !== "qa" && doc.grade !== currentTopic) continue;
      }
      html += `<div class="col">
        <div class="card shadow-sm h-100">
          <div class="card-body">
            <h5 class="card-title">${doc.title}</h5>
            <div class="mb-1">
              ${doc.subject && doc.grade!=="qa" && doc.grade!=="other" ? `<span class="badge bg-info badge-subject">${doc.subject}</span>` : ""}
              ${doc.grade && doc.grade!=="other" && doc.grade!=="qa" ? `<span class="badge badge-grade">${doc.grade}</span>` : ""}
              ${doc.grade==="other" ? `<span class="badge bg-secondary">Tài liệu khác</span>` : ""}
              ${doc.grade==="qa" ? `<span class="badge bg-danger">Hỏi đáp</span>` : ""}
            </div>
            ${
              doc.image ? `<img src="/uploads/${doc.image}" class="img-fluid mb-2" style="max-height:120px; border-radius:8px;">` : ''
            }
            <p class="card-text">${doc.description ? doc.description.slice(0, 65) + "..." : ""}</p>
            <div>
              <span class="me-2 emoji-btn" data-docid="${doc.id}" data-react="love" title="Thả tim">❤️ <span class="count">${doc.reactions?.love||0}</span></span>
              <span class="me-2 emoji-btn" data-docid="${doc.id}" data-react="like" title="Like">👍 <span class="count">${doc.reactions?.like||0}</span></span>
              <span class="me-2 emoji-btn" data-docid="${doc.id}" data-react="wow" title="Wow">😮 <span class="count">${doc.reactions?.wow||0}</span></span>
              <span class="me-2 emoji-btn" data-docid="${doc.id}" data-react="smile" title="Funny">😂 <span class="count">${doc.reactions?.smile||0}</span></span>
              <span class="me-2 emoji-btn" data-docid="${doc.id}" data-react="dislike" title="Dislike">👎 <span class="count">${doc.reactions?.dislike||0}</span></span>
            </div>
            <a href="detail.html?id=${doc.id}" class="btn btn-outline-primary btn-sm mt-2">Xem chi tiết</a>
            <span class="float-end text-muted" style="font-size:0.92em;">${doc.username||''}</span>
          </div>
        </div>
      </div>`;
    }
    document.getElementById('documents-list').innerHTML = html || '<p>Chưa có tài liệu nào.</p>';
    // Gắn sự kiện reaction
    document.querySelectorAll('.emoji-btn').forEach(btn=>{
      btn.onclick = function() {
        let docid = this.getAttribute('data-docid');
        let type = this.getAttribute('data-react');
        fetch('/api/reaction', {
          method: 'POST',
          headers: {'Content-Type': 'application/json'},
          body: JSON.stringify({document_id: docid, type})
        }).then(r=>r.json()).then(data=>{
          if (data.status==='ok') loadDocuments();
          else if(data.message) alert(data.message);
        });
      }
    });
  });
}

// Đăng nhập
const loginForm = document.getElementById('loginForm');
if (loginForm) {
  loginForm.onsubmit = async (e) => {
    e.preventDefault();
    const username = document.getElementById('username').value.trim();
    const password = document.getElementById('password').value.trim();
    const res = await fetch('/api/login', {
      method: 'POST',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({username, password})
    });
    const data = await res.json();
    document.getElementById('loginMsg').textContent = data.message || '';
    if (res.ok) setTimeout(() => window.location = 'index.html', 600);
  }
}

// Đăng ký
const registerForm = document.getElementById('registerForm');
if (registerForm) {
  registerForm.onsubmit = async (e) => {
    e.preventDefault();
    const username = document.getElementById('regUsername').value.trim();
    const password = document.getElementById('regPassword').value.trim();
    const res = await fetch('/api/register', {
      method: 'POST',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({username, password})
    });
    const data = await res.json();
    document.getElementById('registerMsg').textContent = data.message || '';
    if (res.ok) setTimeout(() => window.location = 'login.html', 1000);
  }
}

// Upload tài liệu
// Đăng bài mới (với nhiều ảnh + link tài liệu)
const uploadForm = document.getElementById('uploadForm');
if (uploadForm) {
  uploadForm.onsubmit = async (e) => {
    e.preventDefault();
    const formData = new FormData();
    formData.append('title', document.getElementById('title').value.trim());
    formData.append('description', document.getElementById('description').value.trim());
    formData.append('grade', document.getElementById('grade').value);
    formData.append('subject', document.getElementById('subject')?.value || '');
    formData.append('doclink', document.getElementById('doclink').value.trim());
    const images = document.getElementById('images').files;
    for (let i = 0; i < images.length; i++) {
      formData.append('images', images[i]);
    }
    const res = await fetch('/api/documents', {method: 'POST', body: formData});
    const data = await res.json();
    document.getElementById('uploadMsg').textContent = data.message || '';
    if (res.ok) setTimeout(() => window.location = 'index.html', 1200);
  }
}

// Trang chi tiết tài liệu
if (window.location.pathname.endsWith('detail.html')) {
  const params = new URLSearchParams(window.location.search);
  const id = params.get('id');
  if (id) {
    fetch(`/api/documents/${id}`).then(r => r.json()).then(doc => {
      let html = `<div class="text-center fs-4 mb-2">${doc.id || ''}</div>`;
      // GALLERY ẢNH
      if (doc.images && doc.images.length > 0) {
        html += `<img src="/uploads/${doc.images[0]}" class="img-preview mb-3">`;
      }
      html += `
        <div class="mb-2">
          ${doc.subject && doc.grade!=="qa" && doc.grade!=="other" ? `<span class="badge badge-subject">${doc.subject}</span>` : ""}
          ${doc.grade && doc.grade!=="other" && doc.grade!=="qa" ? `<span class="badge badge-grade">${doc.grade}</span>` : ""}
        </div>
        <div class="mb-2" style="font-weight: bold;">
          Chủ đề: <span class="fw-normal">${doc.topic||''}</span> |
          Người đăng: <span class="fw-normal">${doc.username}</span> |
          Ngày: <span class="fw-normal">${doc.upload_date?.replace('T',' ').slice(0,19)||''}</span>
        </div>
        <div class="mb-2">${doc.description || ''}</div>
      `;
      // Link tài liệu
      if (doc.doclink) {
        html += `<a class="btn btn-outline-success mb-3" href="${doc.doclink}" target="_blank">Xem tài liệu</a>`;
      }
      // Reaction hàng ngang
      html += `<div class="emoji-row">`;
      html += `<span class="emoji-btn" data-docid="${doc.id}" data-react="love" title="Thả tim">❤️ <span class="count">${doc.reactions?.love||0}</span></span>`;
      html += `<span class="emoji-btn" data-docid="${doc.id}" data-react="like" title="Like">👍 <span class="count">${doc.reactions?.like||0}</span></span>`;
      html += `<span class="emoji-btn" data-docid="${doc.id}" data-react="wow" title="Wow">😮 <span class="count">${doc.reactions?.wow||0}</span></span>`;
      html += `<span class="emoji-btn" data-docid="${doc.id}" data-react="smile" title="Funny">😂 <span class="count">${doc.reactions?.smile||0}</span></span>`;
      html += `<span class="emoji-btn" data-docid="${doc.id}" data-react="dislike" title="Dislike">👎 <span class="count">${doc.reactions?.dislike||0}</span></span>`;
      html += `</div>`;
      document.getElementById('doc-detail').innerHTML = html;
      // Sự kiện reaction
      document.querySelectorAll('.emoji-btn').forEach(btn=>{
        btn.onclick = function() {
          let docid = this.getAttribute('data-docid');
          let type = this.getAttribute('data-react');
          fetch('/api/reaction', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({document_id: docid, type})
          }).then(r=>r.json()).then(data=>{
            if (data.status==='ok') location.reload();
            else if(data.message) alert(data.message);
          });
        }
      });
      // Bình luận
      let cmtHtml = '';
      for (let c of (doc.comments || [])) {
        cmtHtml += `<div class="comment-box"><b>${c.username}:</b> ${c.content} <i style="font-size:0.95em;" class="text-muted">(${c.comment_date?.replace('T',' ').slice(0,19)||''})</i></div>`;
      }
      document.getElementById('comments-list').innerHTML = cmtHtml || 'Chưa có bình luận nào.';
    });
  }
  // Xử lý gửi bình luận
  const commentForm = document.getElementById('commentForm');
  commentForm.onsubmit = async (e) => {
    e.preventDefault();
    const content = document.getElementById('commentContent').value.trim();
    if (!content) return;
    const res = await fetch('/api/comments', {
      method: 'POST',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({document_id: id, content})
    });
    const data = await res.json();
    if (res.ok) location.reload();
    else alert(data.message);
  }
}