/*

pSelectItem
pBeruang
pKopi
pRoti
pSnack
pMetal
pKtp
pMask
pRepairKit
pGps
pMetall
pJus
pCash
pProducts
pHeals
pFood
pDrink*/


#define MAX_INVENTORY 				20

new PlayerText:INVNAME[MAX_PLAYERS][6];
new PlayerText:INVINFO[MAX_PLAYERS][11];
new PlayerText:NAMETD[MAX_PLAYERS][MAX_INVENTORY];
new PlayerText:INDEXTD[MAX_PLAYERS][MAX_INVENTORY];
new PlayerText:MODELTD[MAX_PLAYERS][MAX_INVENTORY];
new PlayerText:AMOUNTTD[MAX_PLAYERS][MAX_INVENTORY];
new PlayerText:GARISBAWAH[MAX_PLAYERS][MAX_INVENTORY];
new PlayerText:NOTIFBOX[MAX_PLAYERS][6];

new SampahPlayer[MAX_PLAYERS];
new BukaInven[MAX_PLAYERS];

enum inventoryData
{
	invExists,
	invItem[32 char],
	invModel,
	invTotalQuantity,
	invAmount,
};
new InventoryData[MAX_PLAYERS][MAX_INVENTORY][inventoryData];
enum e_InventoryItems
{
	e_InventoryItem[32], //Nama item
	e_InventoryModel, //Object item
	e_InventoryTotal    //Quantity item
};
//Tambahkan item
new const g_aInventoryItems[][e_InventoryItems] =
{
	{"Uang", 1212, 3},
	{"Hand_Phone", 18867, 3},
	{"Radio", 19942, 3},
	{"Perban", 11736, 3},
	{"Joran", 18632, 2},
	{"Jerigen", 1650, 2},

	{"Mask", 19036, 2},
	{"Repairkit", 1010, 2},
	{"Rokok", 19625, 2},
	{"GPS", 18874, 2},
	{"Logam", 1301, 2},
	{"Kontak", 19894, 2},
	{"Clip", 18644, 2},

	{"Roti", 19883, 3},
	{"Kebab", 2769, 3},
	{"Cappucino", 19835, 3},
	{"Snack", 2821, 3},
	{"Milx_Max", 19570, 2},
	{"Ktp", 1581, 2},
	{"Borax", 1580, 2},

	{"Kanabis", 800, 3},
	{"Marijuana", 1578, 3},
	{"Papeda_Ikan", 19811, 2},
	{"Kopi", 19835, 3},
	{"Sampah", 1265, 2},

	{"Ciki", 19565, 2},
	{"Wool", 2751, 2},
	{"Pakaian", 2399, 2},
	{"Kain", 11747, 2},

	{"Sagu", 1611, 3},
	{"Padi", 862, 2},
	{"Garam", 19570, 3},
	{"Biji_Kopi", 18225, 1},
	{"Gula", 19824, 2},
	{"Ikan", 19630, 2},
	{"Daging", 2804, 2},
	{"Umpan", 19566, 2},
	{"Phone", 18867, 3},
	{"Phone_Book", 18867, 3},
	{"FirstAid", 11738, 2},

	{"Jus", 1546, 1},
	{"Susu", 19570, 2},
	{"Susu_Olahan", 19569, 2},
	{"Minyak", 2969, 3},
	{"Essence", 3015, 1},
	{"Nasgor", 2663, 1},
	{"Jus", 1546, 1},
	("Batu", 905, 3),
	("Batu_Cucian", 2936, 2),
	("Emas", 19941, 4),
	{"Ayam", 2770, 2},
	{"Paket_Ayam", 19566, 2},
	{"Ayam_Potong", 2806, 2},
	{"Susu_Mentah", 19570, 1},

	{"Baking_Soda", 2821, 3},
	{"Asam_Muriatic", 19573, 3},
	{"Uang_Kotor", 1575, 3},
	{"Seed", 859, 2},
	{"Pot", 860, 3},
	{"Ephedrine", 19473, 1},
	{"Meth", 1579, 2},
	{"Materials", 2041, 2},
	{"Vest", 1242, 2}

};
//======= pasang di define =========//

#define DIALOG_GIVE_UANG 1901
#define DIALOG_GIVE_AYAM 1902
#define DIALOG_GIVE_SUSU 1903
#define DIALOG_GIVE_PERBAN 1904
#define DIALOG_GIVE_KTP 1905
#define DIALOG_GIVE_BORAX 1906
#define DIALOG_GIVE_HANDPHONE 1907
#define DIALOG_GIVE_MASK 1908
#define DIALOG_GIVE_REPAIRKIT 1909
#define DIALOG_GIVE_ROKOK 1910
#define DIALOG_GIVE_GPS 1911
#define DIALOG_GIVE_RADIO 1912
#define DIALOG_GIVE_SAMPAH 1913

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) 

    if(dialogid == DIALOG_GIVE_UANG)
    {
        if(!response) return Send(playerid, -1,"{20D61A}BATAL GIVE");
        new IDPLAYER, JUMLAHX;
        if(sscanf(inputtext, "dd", IDPLAYER, JUMLAHX)) return ShowPlayerDialog(playerid, DIALOG_GIVE_UANG, DIALOG_STYLE_INPUT, "INVENTORY GIVE", "MASUKKAN JUMLAH YG INGIN ANDA GIVE DAN ID [ ID JUMLAH ]", "[ GIVE ]", "[ BATAL ]");
        if(!ProxDetectorS(7.0, playerid, IDPLAYER)) return SendClientMessage(playerid, 0xB4B5B7FF,"Pemain terlalu jauh");
        if(JUMLAHX < 1 || JUMLAHX > 10) return SendClientMessage(playerid, 0xB4B5B7FF,"MAX 1 HINGGA 10");
		GivePlayerMoneyEx(playerid, -JUMLAHX, "GIVE UANG");
        GivePlayerMoneyEx(IDPLAYER, JUMLAHX, "GIVE UANG");
        Inventory_Update(playerid);
        Inventory_Update(IDPLAYER);
        SCMF(playerid, -1, "ANDA MEMBERIKAN UANG KE PADA %s SEBANYAK %d", GN(IDPLAYER), JUMLAHX);
        SCMF(IDPLAYER, -1, "ANDA MENERIMA UANG DARI %s SEBANYAK %d", GN(playerid), JUMLAHX);
    }
	if(dialogid == DIALOG_GIVE_AYAM)
    {
        if(!response) return Send(playerid, -1,"{20D61A}BATAL GIVE");
        new IDPLAYER, JUMLAHXZ;
        if(sscanf(inputtext, "dd", IDPLAYER, JUMLAHXZ)) return ShowPlayerDialog(playerid, DIALOG_GIVE_AYAM, DIALOG_STYLE_INPUT, "INVENTORY GIVE", "MASUKAN ID DAN JUMLAH BARANG YG ANDA INGIN KIRIM [ ID JUMLAH ]", "[ GIVE ]", "[ BATAL ]");
        if(!ProxDetectorS(7.0, playerid, IDPLAYER)) return SendClientMessage(playerid, 0xB4B5B7FF,"Pemain terlalu jauh");
        if(JUMLAHXZ < 1 || JUMLAHXZ > 10) return SendClientMessage(playerid, 0xB4B5B7FF,"MAX 1 HINGGA 10");
		PlayerInfo[playerid][pFood] -=JUMLAHXZ;
        PlayerInfo[IDPLAYER][pFood] +=JUMLAHXZ;
        Inventory_Update(playerid);
        Inventory_Update(IDPLAYER);
        SCMF(playerid, -1, "ANDA MEMBERIKAN AYAM KE PADA %s SEBANYAK %d", GN(IDPLAYER), JUMLAHXZ);
        SCMF(IDPLAYER, -1, "ANDA MENERIMA AYAM DARI %s SEBANYAK %d", GN(playerid), JUMLAHXZ);
    }
	if(dialogid == DIALOG_GIVE_SUSU)
    {
        if(!response) return Send(playerid, -1,"{20D61A}BATAL GIVE");
        new IDPLAYER, JUMLAHX;
        if(sscanf(inputtext, "dd", IDPLAYER, JUMLAHX)) return ShowPlayerDialog(playerid, DIALOG_GIVE_SUSU, DIALOG_STYLE_INPUT, "INVENTORY GIVE", "MASUKAN ID DAN JUMLAH BARANG YG ANDA INGIN KIRIM [ ID JUMLAH ]", "[ GIVE ]", "[ BATAL ]");
        if(!ProxDetectorS(7.0, playerid, IDPLAYER)) return SendClientMessage(playerid, 0xB4B5B7FF,"Pemain terlalu jauh");
        if(JUMLAHX < 1 || JUMLAHX > 10) return SendClientMessage(playerid, 0xB4B5B7FF,"MAX 1 HINGGA 10");
		PlayerInfo[playerid][pDrink] -=JUMLAHX;
        PlayerInfo[IDPLAYER][pDrink] +=JUMLAHX;
        Inventory_Update(playerid);
        Inventory_Update(IDPLAYER);
        SCMF(playerid, -1, "ANDA MEMBERIKAN SUSU KE PADA %s SEBANYAK %d", GN(IDPLAYER), JUMLAHX);
        SCMF(IDPLAYER, -1, "ANDA MENERIMA SUSU DARI %s SEBANYAK %d", GN(playerid), JUMLAHX);
    }
	if(dialogid == DIALOG_GIVE_PERBAN)
    {
        if(!response) return Send(playerid, -1,"{20D61A}BATAL GIVE");
        new IDPLAYER, JUMLAHX;
        if(sscanf(inputtext, "dd", IDPLAYER, JUMLAHX)) return ShowPlayerDialog(playerid, DIALOG_GIVE_PERBAN, DIALOG_STYLE_INPUT, "INVENTORY GIVE", "MASUKAN ID DAN JUMLAH BARANG YG ANDA INGIN KIRIM [ ID JUMLAH ]", "[ GIVE ]", "[ BATAL ]");
        if(!ProxDetectorS(7.0, playerid, IDPLAYER)) return SendClientMessage(playerid, 0xB4B5B7FF,"Pemain terlalu jauh");
        if(JUMLAHX < 1 || JUMLAHX > 10) return SendClientMessage(playerid, 0xB4B5B7FF,"MAX 1 HINGGA 10");
		PlayerInfo[playerid][pHeals] -=JUMLAHX;
        PlayerInfo[IDPLAYER][pHeals] +=JUMLAHX;
        Inventory_Update(playerid);
        Inventory_Update(IDPLAYER);
        SCMF(playerid, -1, "ANDA MEMBERIKAN PERBAN KE PADA %s SEBANYAK %d", GN(IDPLAYER), JUMLAHX);
        SCMF(IDPLAYER, -1, "ANDA MENERIMA PERBAN DARI %s SEBANYAK %d", GN(playerid), JUMLAHX);
    }
	if(dialogid == DIALOG_GIVE_KTP)
    {
        if(!response) return Send(playerid, -1,"{20D61A}BATAL GIVE");
        new IDPLAYER, JUMLAHX;
        if(sscanf(inputtext, "dd", IDPLAYER, JUMLAHX)) return ShowPlayerDialog(playerid, DIALOG_GIVE_KTP, DIALOG_STYLE_INPUT, "INVENTORY GIVE", "MASUKAN ID DAN JUMLAH BARANG YG ANDA INGIN KIRIM [ ID JUMLAH ]", "[ GIVE ]", "[ BATAL ]");
        if(!ProxDetectorS(7.0, playerid, IDPLAYER)) return SendClientMessage(playerid, 0xB4B5B7FF,"Pemain terlalu jauh");
        if(JUMLAHX < 1 || JUMLAHX > 10) return SendClientMessage(playerid, 0xB4B5B7FF,"MAX 1 HINGGA 10");
		PlayerInfo[playerid][pKtp] -=JUMLAHX;
        PlayerInfo[IDPLAYER][pKtp] +=JUMLAHX;
        Inventory_Update(playerid);
        Inventory_Update(IDPLAYER);
        SCMF(playerid, -1, "ANDA MEMBERIKAN KTP KE PADA %s SEBANYAK %d", GN(IDPLAYER), JUMLAHX);
        SCMF(IDPLAYER, -1, "ANDA MENERIMA KTP DARI %s SEBANYAK %d", GN(playerid), JUMLAHX);
    }
	if(dialogid == DIALOG_GIVE_BORAX)
    {
        if(!response) return Send(playerid, -1,"{20D61A}BATAL GIVE");
        new IDPLAYER, JUMLAHX;
        if(sscanf(inputtext, "dd", IDPLAYER, JUMLAHX)) return ShowPlayerDialog(playerid, DIALOG_GIVE_BORAX, DIALOG_STYLE_INPUT, "INVENTORY GIVE", "MASUKAN ID DAN JUMLAH BARANG YG ANDA INGIN KIRIM [ ID JUMLAH ]", "[ GIVE ]", "[ BATAL ]");
        if(!ProxDetectorS(7.0, playerid, IDPLAYER)) return SendClientMessage(playerid, 0xB4B5B7FF,"Pemain terlalu jauh");
        if(JUMLAHX < 1 || JUMLAHX > 10) return SendClientMessage(playerid, 0xB4B5B7FF,"MAX 1 HINGGA 10");
		PlayerDrugData[playerid][Drugs] -=JUMLAHX;
        PlayerDrugData[playerid][Drugs] +=JUMLAHX;
        Inventory_Update(playerid);
        Inventory_Update(IDPLAYER);
        SCMF(playerid, -1, "ANDA MEMBERIKAN BORAX KE PADA %s SEBANYAK %d", GN(IDPLAYER), JUMLAHX);
        SCMF(IDPLAYER, -1, "ANDA MENERIMA BORAX DARI %s SEBANYAK %d", GN(playerid), JUMLAHX);
    }
	if(dialogid == DIALOG_GIVE_HANDPHONE)
    {
        if(!response) return Send(playerid, -1,"{20D61A}BATAL GIVE");
        new IDPLAYER, JUMLAHX;
        if(sscanf(inputtext, "dd", IDPLAYER, JUMLAHX)) return ShowPlayerDialog(playerid, DIALOG_GIVE_HANDPHONE, DIALOG_STYLE_INPUT, "INVENTORY GIVE", "MASUKAN ID DAN JUMLAH BARANG YG ANDA INGIN KIRIM [ ID JUMLAH ]", "[ GIVE ]", "[ BATAL ]");
        if(!ProxDetectorS(7.0, playerid, IDPLAYER)) return SendClientMessage(playerid, 0xB4B5B7FF,"Pemain terlalu jauh");
        if(JUMLAHX < 1 || JUMLAHX > 10) return SendClientMessage(playerid, 0xB4B5B7FF,"MAX 1 HINGGA 10");
		PlayerInfo[playerid][pProducts][0] -=JUMLAHX;
        PlayerInfo[playerid][pProducts][0] +=JUMLAHX;
        Inventory_Update(playerid);
        Inventory_Update(IDPLAYER);
        SCMF(playerid, -1, "ANDA MEMBERIKAN HANDPHONE KE PADA %s SEBANYAK %d", GN(IDPLAYER), JUMLAHX);
        SCMF(IDPLAYER, -1, "ANDA MENERIMA HANDPHONE DARI %s SEBANYAK %d", GN(playerid), JUMLAHX);
    }
	if(dialogid == DIALOG_GIVE_MASK)
    {
        if(!response) return Send(playerid, -1,"{20D61A}BATAL GIVE");
        new IDPLAYER, JUMLAHZ;
        if(sscanf(inputtext, "dd", IDPLAYER, JUMLAHZ)) return ShowPlayerDialog(playerid, DIALOG_GIVE_MASK, DIALOG_STYLE_INPUT, "INVENTORY GIVE", "MASUKAN ID DAN JUMLAH BARANG YG ANDA INGIN KIRIM [ ID JUMLAH ]", "[ GIVE ]", "[ BATAL ]");
        if(!ProxDetectorS(7.0, playerid, IDPLAYER)) return SendClientMessage(playerid, 0xB4B5B7FF,"Pemain terlalu jauh");
        if(JUMLAHZ < 1 || JUMLAHZ > 10) return SendClientMessage(playerid, 0xB4B5B7FF,"MAX 1 HINGGA 10");
		PlayerInfo[playerid][pMask] -=JUMLAHZ;
        PlayerInfo[playerid][pMask] +=JUMLAHZ;
        Inventory_Update(playerid);
        Inventory_Update(IDPLAYER);
        SCMF(playerid, -1, "ANDA MEMBERIKAN MASK KE PADA %s SEBANYAK %d", GN(IDPLAYER), JUMLAHZ);
        SCMF(IDPLAYER, -1, "ANDA MENERIMA MASK DARI %s SEBANYAK %d", GN(playerid), JUMLAHZ);
    }
	if(dialogid == DIALOG_GIVE_REPAIRKIT)
    {
		if(!response) return Send(playerid, -1,"{20D61A}BATAL GIVE");
        new IDPLAYER, JUMLAHT;
        if(sscanf(inputtext, "dd", IDPLAYER, JUMLAHT)) return ShowPlayerDialog(playerid, DIALOG_GIVE_REPAIRKIT, DIALOG_STYLE_INPUT, "INVENTORY GIVE", "MASUKAN ID DAN JUMLAH BARANG YG ANDA INGIN KIRIM [ ID JUMLAH ]", "[ GIVE ]", "[ BATAL ]");
        if(!ProxDetectorS(7.0, playerid, IDPLAYER)) return SendClientMessage(playerid, 0xB4B5B7FF,"Pemain terlalu jauh");
        if(JUMLAHT < 1 || JUMLAHT > 10) return SendClientMessage(playerid, 0xB4B5B7FF,"MAX 1 HINGGA 10");
		PlayerInfo[playerid][pRepairKit] -=JUMLAHT;
        PlayerInfo[playerid][pRepairKit] +=JUMLAHT;
        Inventory_Update(playerid);
        Inventory_Update(IDPLAYER);
        SCMF(playerid, -1, "ANDA MEMBERIKAN REPAIRKIT KE PADA %s SEBANYAK %d", GN(IDPLAYER), JUMLAHT);
        SCMF(IDPLAYER, -1, "ANDA MENERIMA REPAIRKIT DARI %s SEBANYAK %d", GN(playerid), JUMLAHT);
    }
	if(dialogid == DIALOG_GIVE_GPS)
    {
        if(!response) return Send(playerid, -1,"{20D61A}BATAL GIVE");
        new IDPLAYER, JUMLAHT;
        if(sscanf(inputtext, "dd", IDPLAYER, JUMLAHT)) return ShowPlayerDialog(playerid, DIALOG_GIVE_GPS, DIALOG_STYLE_INPUT, "INVENTORY GIVE", "MASUKAN ID DAN JUMLAH BARANG YG ANDA INGIN KIRIM [ ID JUMLAH ]", "[ GIVE ]", "[ BATAL ]");
        if(!ProxDetectorS(7.0, playerid, IDPLAYER)) return SendClientMessage(playerid, 0xB4B5B7FF,"Pemain terlalu jauh");
        if(JUMLAHT < 1 || JUMLAHT > 10) return SendClientMessage(playerid, 0xB4B5B7FF,"MAX 1 HINGGA 10");
		PlayerInfo[playerid][pGps] -=JUMLAHT;
        PlayerInfo[playerid][pGps] +=JUMLAHT;
        Inventory_Update(playerid);
        Inventory_Update(IDPLAYER);
        SCMF(playerid, -1, "ANDA MEMBERIKAN GPS KE PADA %s SEBANYAK %d", GN(IDPLAYER), JUMLAHT);
        SCMF(IDPLAYER, -1, "ANDA MENERIMA GPS DARI %s SEBANYAK %d", GN(playerid), JUMLAHT);
    }
	if(dialogid == DIALOG_GIVE_SAMPAH)
    {
        if(!response) return Send(playerid, -1,"{20D61A}BATAL GIVE");
        new IDPLAYER, JUMLAHR;
        if(sscanf(inputtext, "dd", IDPLAYER, JUMLAHR)) return ShowPlayerDialog(playerid, DIALOG_GIVE_SAMPAH, DIALOG_STYLE_INPUT, "INVENTORY GIVE", "MASUKAN ID DAN JUMLAH BARANG YG ANDA INGIN KIRIM [ ID JUMLAH ]", "[ GIVE ]", "[ BATAL ]");
        if(!ProxDetectorS(7.0, playerid, IDPLAYER)) return SendClientMessage(playerid, 0xB4B5B7FF,"Pemain terlalu jauh");
        if(JUMLAHR < 1 || JUMLAHR > 10) return SendClientMessage(playerid, 0xB4B5B7FF,"MAX 1 HINGGA 10");
		SampahPlayer[playerid] -=JUMLAHR;
        SampahPlayer[playerid] +=JUMLAHR;
        Inventory_Update(playerid);
        Inventory_Update(IDPLAYER);
        SCMF(playerid, -1, "ANDA MEMBERIKAN SAMPAH KE PADA %s SEBANYAK %d", GN(IDPLAYER), JUMLAHR);
        SCMF(IDPLAYER, -1, "ANDA MENERIMA SAMPAH DARI %s SEBANYAK %d", GN(playerid), JUMLAHR);
    }



stock Inventory_Clear(playerid)
{
	static
	    string[64];

	for(new i = 0; i < MAX_INVENTORY; i++)
	{
	    if (InventoryData[playerid][i][invExists])
	    {
	        InventoryData[playerid][i][invExists] = 0;
	        InventoryData[playerid][i][invModel] = 0;
			InventoryData[playerid][i][invAmount] = 0;
		}
	}
	return 1;
}

stock Inventory_GetItemID(playerid, item[])
{
	for(new i = 0; i < MAX_INVENTORY; i++)
	{
	    if (!InventoryData[playerid][i][invExists])
	        continue;

		if (!strcmp(InventoryData[playerid][i][invItem], item)) return i;
	}
	return -1;
}

stock Inventory_GetFreeID(playerid)
{
	if (Inventory_Items(playerid) >= 20)
		return -1;

	for(new i = 0; i < MAX_INVENTORY; i++)
	{
	    if (!InventoryData[playerid][i][invExists])
	        return i;
	}
	return -1;
}

stock Inventory_Items(playerid)
{
    new count;

    for(new i = 0; i < MAX_INVENTORY; i++) if (InventoryData[playerid][i][invExists]) {
        count++;
	}
	return count;
}
stock Inventory_Count(playerid, item[])
{
	new itemid = Inventory_GetItemID(playerid, item);

	if (itemid != -1)
	    return InventoryData[playerid][itemid][invAmount];

	return 0;
}

stock PlayerHasItem(playerid, item[])
{
	return (Inventory_GetItemID(playerid, item) != -1);
}

stock Inventory_Set(playerid, item[], model, amount)
{
	new itemid = Inventory_GetItemID(playerid, item);

	if (itemid == -1 && amount > 0)
		Inventory_Addset(playerid, item, model, amount);

	else if (amount > 0 && itemid != -1)
	    Inventory_SetQuantity(playerid, item, amount);

	else if (amount < 1 && itemid != -1)
	    Inventory_Remove(playerid, item, -1);

	return 1;
}

stock Inventory_SetQuantity(playerid, item[], quantity)
{
	new
	    itemid = Inventory_GetItemID(playerid, item);

	if (itemid != -1)
	{
	    InventoryData[playerid][itemid][invAmount] = quantity;
	}
	return 1;
}

stock Inventory_Remove(playerid, item[], quantity = 1)
{
	new
		itemid = Inventory_GetItemID(playerid, item);

	if (itemid != -1)
	{
	    for (new i = 0; i < sizeof(g_aInventoryItems); i ++) if (!strcmp(g_aInventoryItems[i][e_InventoryItem], item, true))
		{
		    if (InventoryData[playerid][itemid][invAmount] > 0)
		    {
		        InventoryData[playerid][itemid][invAmount] -= quantity;
			}
			if (quantity == -1 || InventoryData[playerid][itemid][invAmount] < 1)
			{
			    InventoryData[playerid][itemid][invExists] = false;
			    InventoryData[playerid][itemid][invModel] = 0;
			    InventoryData[playerid][itemid][invAmount] = 0;
			}
			else if (quantity != -1 && InventoryData[playerid][itemid][invAmount] > 0)
			{
			    InventoryData[playerid][itemid][invAmount] = quantity;
			}
		}
		return 1;
	}
	return 0;
}
stock Inventory_Addset(playerid, item[], model, amount = 1)
{
	new itemid = Inventory_GetItemID(playerid, item);

	if (itemid == -1)
	{
	    itemid = Inventory_GetFreeID(playerid);

	    if (itemid != -1)
	    {
	   		InventoryData[playerid][itemid][invExists] = true;
		    InventoryData[playerid][itemid][invModel] = model;
			InventoryData[playerid][itemid][invAmount] = amount;

		    strpack(InventoryData[playerid][itemid][invItem], item, 32 char);
		    return itemid;
		}
		return -1;
	}
	else
	{
		InventoryData[playerid][itemid][invAmount] += amount;
	}
	return itemid;
}

stock Inventory_Add(playerid, item[], model)
{
	new
		itemid = Inventory_GetItemID(playerid, item);

	if (itemid == -1)
	{
	    itemid = Inventory_GetFreeID(playerid);

	    if (itemid != -1)
	    {
         	for (new i = 0; i < sizeof(g_aInventoryItems); i ++) if (!strcmp(g_aInventoryItems[i][e_InventoryItem], item, true))
			{
     	 	  	InventoryData[playerid][itemid][invExists] = true;
		        InventoryData[playerid][itemid][invModel] = model;
				InventoryData[playerid][itemid][invAmount] = model;
		        return itemid;
			}
		}
		return -1;
	}
	return itemid;
}

stock Inventory_Close(playerid)
{
	if(BukaInven[playerid] == 0)
		return SCM(playerid, -1, "Kamu Belum Membuka Inventory.");

	CancelSelectTextDraw(playerid);
	PlayerInfo[playerid][pSelectItem] = -1;
	PlayerInfo[playerid][pGiveAmount] = 0;
	BukaInven[playerid] = 0;
	for(new a = 0; a < 6; a++)
	{
		PlayerTextDrawHide(playerid, INVNAME[playerid][a]);
	}
	for(new a = 0; a < 11; a++)
	{
		PlayerTextDrawHide(playerid, INVINFO[playerid][a]);
	}
	PlayerTextDrawSetString(playerid, INVINFO[playerid][6], "Jumlah");
	for(new i = 0; i < MAX_INVENTORY; i++)
	{
		PlayerTextDrawHide(playerid, NAMETD[playerid][i]);
		PlayerTextDrawHide(playerid, INDEXTD[playerid][i]);
		PlayerTextDrawColor(playerid, INDEXTD[playerid][i], 859394047);
		PlayerTextDrawHide(playerid, MODELTD[playerid][i]);
		PlayerTextDrawHide(playerid, AMOUNTTD[playerid][i]);
		PlayerTextDrawHide(playerid, GARISBAWAH[playerid][i]);
	}
	return 1;
}

stock Inventory_Show(playerid)
{
	if(!IsPlayerConnected(playerid))
		return 0;

	new str[256], string[256], totalall, quantitybar;
	format(str,1000,"%s", GetName(playerid));
	PlayerTextDrawSetString(playerid, INVNAME[playerid][3], str);
	BarangMasuk(playerid);
	BukaInven[playerid] = 1;
	PlayerPlaySound(playerid, 1039, 0,0,0);
	SelectTextDraw(playerid, -1);
	for(new a = 0; a < 6; a++)
	{
		PlayerTextDrawShow(playerid, INVNAME[playerid][a]);
	}
	for(new a = 0; a < 11; a++)
	{
		PlayerTextDrawShow(playerid, INVINFO[playerid][a]);
	}
	for(new i = 0; i < MAX_INVENTORY; i++)
	{
	    PlayerTextDrawShow(playerid, INDEXTD[playerid][i]);
		PlayerTextDrawShow(playerid, AMOUNTTD[playerid][i]);
		totalall += InventoryData[playerid][i][invTotalQuantity];
		format(str, sizeof(str), "%.1f/850.0", float(totalall));
		PlayerTextDrawSetString(playerid, INVNAME[playerid][4], str);
		quantitybar = totalall * 199/850;
	  	PlayerTextDrawTextSize(playerid, INVNAME[playerid][2], quantitybar, 3.0);
	  	PlayerTextDrawShow(playerid, INVNAME[playerid][2]);
		if(InventoryData[playerid][i][invExists])
		{
			PlayerTextDrawShow(playerid, NAMETD[playerid][i]);
			PlayerTextDrawShow(playerid, GARISBAWAH[playerid][i]);
			PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][i], InventoryData[playerid][i][invModel]);
			//sesuakian dengan object item kalian
			if(InventoryData[playerid][i][invModel] == 18867)
			{
				PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][i], -254.000000, 0.000000, 0.000000, 2.779998);
			}
			else if(InventoryData[playerid][i][invModel] == 16776)
			{
				PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][i], 0.000000, 0.000000, -85.000000, 1.000000);
			}
			else if(InventoryData[playerid][i][invModel] == 1581)
			{
				PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][i], 0.000000, 0.000000, -180.000000, 1.000000);
			}
			PlayerTextDrawShow(playerid, MODELTD[playerid][i]);
			strunpack(string, InventoryData[playerid][i][invItem]);
			format(str, sizeof(str), "%s", string);
			PlayerTextDrawSetString(playerid, NAMETD[playerid][i], str);
			format(str, sizeof(str), "%dx", InventoryData[playerid][i][invAmount]);
			PlayerTextDrawSetString(playerid, AMOUNTTD[playerid][i], str);
		}
		else
		{
			PlayerTextDrawHide(playerid, AMOUNTTD[playerid][i]);
		}
	}
	return 1;
}

forward OnPlayerUseItem(playerid, itemid, name[]);
public OnPlayerUseItem(playerid, itemid, name[])
{
	if(!strcmp(name, "Uang"))
	{
	    SCMF(playerid, -1, "UANG ANDA %i", PlayerInfo[playerid][pCash]);
	    ShowItemBox(playerid, "Uang", "ADD_1x", 1212, 3);
	    Inventory_Update(playerid);
	    Inventory_Close(playerid);
	}
	if(!strcmp(name, "Ayam"))
	{
	    UpdatePlayerSatiety(playerid, PlayerInfo[playerid][pSatiety]+10);
	    PlayerInfo[playerid][pAyam] -=1;
	    SampahPlayer[playerid] +=1;
	    ShowItemBox(playerid, "Ayam", "ADD_1x", 2770, 2);
	    SCM(playerid, -1, "[INFO] : ANDA BERHASIL MEMAKAN AYAM");
	    Inventory_Update(playerid);
	    Inventory_Close(playerid);
	}
	if(!strcmp(name, "Roti"))
	{
		ShowProgressbar(playerid, "Memakan Roti..", 5);
	    UpdatePlayerSatiety(playerid, PlayerInfo[playerid][pSatiety]+10);
	    PlayerInfo[playerid][pRoti] -=1;
	    SampahPlayer[playerid] +=1;
	    ShowItemBox(playerid, "Roti", "ADD_1x", 19883, 3);
	    SCM(playerid, -1, "[INFO] : ANDA BERHASIL MEMAKAN ROTI");
	    Inventory_Update(playerid);
	    Inventory_Close(playerid);
	}
	if(!strcmp(name, "Snack"))
	{
		ShowProgressbar(playerid, "Memakan Snack..", 5);
	    UpdatePlayerSatiety(playerid, PlayerInfo[playerid][pSatiety]+10);
	    PlayerInfo[playerid][pSnack] -=1;
	    SampahPlayer[playerid] +=1;
	    ShowItemBox(playerid, "Snack", "ADD_1x", 2821, 3);
	    SCM(playerid, -1, "[INFO] : ANDA BERHASIL MEMAKAN SNACK");
	    Inventory_Update(playerid);
	    Inventory_Close(playerid);
	}
	if(!strcmp(name, "Susu"))
	{
		ShowProgressbar(playerid, "Meminum Susu..", 5);
	    UpdatePlayerThirst(playerid, PlayerInfo[playerid][pThirst]+10);
	    PlayerInfo[playerid][pBeruang] -=1;
	    SampahPlayer[playerid] +=1;
	    ShowItemBox(playerid, "Susu", "ADD_1x", 19570, 2);
	    SCM(playerid, -1, "[INFO] : ANDA BERHASIL MEMINUM SUSU");
	    Inventory_Update(playerid);
	    Inventory_Close(playerid);
	}
	if(!strcmp(name, "Jus"))
	{
		ShowProgressbar(playerid, "Meminum Jus..", 5);
	    UpdatePlayerThirst(playerid, PlayerInfo[playerid][pThirst]+10);
	    PlayerInfo[playerid][pJus] -=1;
	    SampahPlayer[playerid] +=1;
	    ShowItemBox(playerid, "Jus", "ADD_1x", 1546, 1);
	    SCM(playerid, -1, "[INFO] : ANDA BERHASIL MEMINUM JUS");
	    Inventory_Update(playerid);
	    Inventory_Close(playerid);
	}
	if(!strcmp(name, "Kopi"))
	{
		ShowProgressbar(playerid, "Meminum Kopi..", 5);
	    UpdatePlayerThirst(playerid, PlayerInfo[playerid][pThirst]+10);
	    PlayerInfo[playerid][pKopi] -=1;
	    SampahPlayer[playerid] +=1;
	    ShowItemBox(playerid, "Kopi", "ADD_1x", 19835, 3);
	    SCM(playerid, -1, "[INFO] : ANDA BERHASIL MEMINUM KOPI");
	    Inventory_Update(playerid);
	    Inventory_Close(playerid);
	}
	if(!strcmp(name, "Hand_Phone"))
	{
	    Inventory_Close(playerid);
	for(new i = 0; i < 33; i++) {
		TextDrawShowForPlayer(playerid, KanzlyPhoneTD[i]);
	}
	SetTimer("WaktuServer", 1000, true);
	TextDrawShowForPlayer(playerid, banktd);
	TextDrawShowForPlayer(playerid, mesaagetd);
	TextDrawShowForPlayer(playerid, calltd);
	TextDrawShowForPlayer(playerid, contactstd);
	TextDrawShowForPlayer(playerid, phoneclosetd);
	TextDrawShowForPlayer(playerid, apptd);
	TextDrawShowForPlayer(playerid, twtd);
	TextDrawShowForPlayer(playerid, gpstd);
	TextDrawShowForPlayer(playerid, settingtd);
	TextDrawShowForPlayer(playerid, cameratd);
	SelectTextDraw(playerid, COLOR_LBLUE);
	    ShowItemBox(playerid, "Handphone", "ADD_1x", 18867, 2);
	    Inventory_Update(playerid);
	}
	if(!strcmp(name, "Perban"))
	{
	    new Float:shealth;
	    GetPlayerHealth(playerid, shealth);
	    new heal24hp = 60;
	    new healedhp;
	    if((floatround(shealth) + heal24hp) > 100) healedhp = 100 - floatround(shealth);
	    else healedhp = heal24hp;

	    SetPlayerHealthEx(playerid, (floatround(shealth) + healedhp));
	    PlayerInfo[playerid][pHeals]--;
	    PlayerInfo[playerid][pBolnica] = 0;

	    new gtexthp[17], gtexthpGTS[17];
	    format(gtexthp, sizeof(gtexthp),"~g~+%dhp", healedhp);
	    GameTextForPlayer(playerid, gtexthp, 1500, 1);
	    format(gtexthpGTS, sizeof(gtexthpGTS),"+%dhp", healedhp);
	    SetPlayerChatBubble(playerid, gtexthpGTS ,COLOR_NEWS,15.0,10000);

	    SCMF(playerid, -1, "Anda menggunakan kotak P3K. Kesehatan {33D441}diisi ulang "W"pada {33D441}%d "W"unit", healedhp);
	    ApplyAnimation(playerid,"ped","gum_eat",4.0,0,0,0,0,0,1);
	    SetPlayerAttachedObject(playerid,1,11736,6,0.118999,0.020000,0.026000,-93.699874,-4.799996,88.400108,1.000000,1.000000,1.000000);
	    SetTimerEx("HealUnFr", 1600, false, "d", playerid);
	    ShowItemBox(playerid, "Perban", "ADD_1x", 11736, 3);
	    Inventory_Update(playerid);
	    Inventory_Close(playerid);
	}
	if(!strcmp(name, "Ktp"))
	{
	    Inventory_Update(playerid);
	    Inventory_Close(playerid);
	    ShowItemBox(playerid, "Ktp", "ADD_1x", 1581, 2);
	}
	if(!strcmp(name, "Repairkit"))
	{
	    new vehicleid = GetNearestVehicle(playerid);

	    if(!vehicleid) return SCM(playerid, COLOR_GREY, "Tidak ada kendaraan di sekitar.");

	    new Float: health;
	    GetVehicleHealth(vehicleid, health);

	    if(health == 1000.0) return SCM(playerid, COLOR_GREY, "Transportasi ini utuh.");

	    PlayerInfo[playerid][pRepairKit]--;

	    OnPlayerUpdateAccountsPer(playerid, "pRepairKit", PlayerInfo[playerid][pRepairKit]);

	    RepairVehicle(vehicleid);
	    ShowItemBox(playerid, "Repairkit", "ADD_1x", 1010, 2);
	    Inventory_Update(playerid);
	    Inventory_Close(playerid);
	}
	if(!strcmp(name, "GPS"))
	{
	    SPD(playerid, 154, DIALOG_STYLE_LIST, "GPS", "{ffffff}1. Tempat Umum\n2. Pekerjaan Sampingan\n3. Fraction Goodside\n4. Dealership\n5. Mini-Game\n6. Business Open\n7. Fuel Station Open\n- Tandai Bisnis Terdekat\n- Toko 24/7 Terdekat\n- Bar Terdekat\n- Restoran Terdekat\n- ATM Terdekat \n- Dealership New\n- Area Fish\n- Nearest Garkot\n- Nearest Workshop", "Ya", "Tidak");
        ShowItemBox(playerid, "GPS", "ADD_1x", 18874, 2);
		Inventory_Update(playerid);
	    Inventory_Close(playerid);
	}
	if(!strcmp(name, "Sampah"))
	{
	    SampahPlayer[playerid] -=1;
	    ShowItemBox(playerid, "Sampah", "ADD_1x", 1265, 3);
	    Inventory_Update(playerid);
	    Inventory_Close(playerid);
	}
	return 1;
}

forward OnPlayerGiveItem(playerid, itemid, name[]);
public OnPlayerGiveItem(playerid, itemid, name[])
{
	if(!strcmp(name, "Uang"))
	{
	    ShowPlayerDialog(playerid, DIALOG_GIVE_UANG, DIALOG_STYLE_INPUT, "INVENTORY GIVE", "MASUKKAN JUMLAH YG INGIN ANDA GIVE DAN ID [ ID JUMLAH ]", "[ GIVE ]", "[ BATAL ]");
	}
	if(!strcmp(name, "Ayam"))
	{
	    ShowPlayerDialog(playerid, DIALOG_GIVE_AYAM, DIALOG_STYLE_INPUT, "INVENTORY GIVE", "MASUKAN ID DAN JUMLAH BARANG YG ANDA INGIN KIRIM [ ID JUMLAH ]", "[ GIVE ]", "[ BATAL ]");
	}
	if(!strcmp(name, "Susu"))
	{
	    ShowPlayerDialog(playerid, DIALOG_GIVE_SUSU, DIALOG_STYLE_INPUT, "INVENTORY GIVE", "MASUKAN ID DAN JUMLAH BARANG YG ANDA INGIN KIRIM [ ID JUMLAH ]", "[ GIVE ]", "[ BATAL ]");
	}
	if(!strcmp(name, "Perban"))
	{
	    ShowPlayerDialog(playerid, DIALOG_GIVE_PERBAN, DIALOG_STYLE_INPUT, "INVENTORY GIVE", "MASUKAN ID DAN JUMLAH BARANG YG ANDA INGIN KIRIM [ ID JUMLAH ]", "[ GIVE ]", "[ BATAL ]");
	}
	if(!strcmp(name, "Ktp"))
	{
	    ShowPlayerDialog(playerid, DIALOG_GIVE_KTP, DIALOG_STYLE_INPUT, "INVENTORY GIVE", "MASUKAN ID DAN JUMLAH BARANG YG ANDA INGIN KIRIM [ ID JUMLAH ]", "[ GIVE ]", "[ BATAL ]");
	}
	if(!strcmp(name, "Borax"))
	{
	    ShowPlayerDialog(playerid, DIALOG_GIVE_BORAX, DIALOG_STYLE_INPUT, "INVENTORY GIVE", "MASUKAN ID DAN JUMLAH BARANG YG ANDA INGIN KIRIM [ ID JUMLAH ]", "[ GIVE ]", "[ BATAL ]");
	}
	if(!strcmp(name, "Hand_Phone"))
	{
	    ShowPlayerDialog(playerid, DIALOG_GIVE_HANDPHONE, DIALOG_STYLE_INPUT, "INVENTORY GIVE", "MASUKAN ID DAN JUMLAH BARANG YG ANDA INGIN KIRIM [ ID JUMLAH ]", "[ GIVE ]", "[ BATAL ]");
	}
	if(!strcmp(name, "Mask"))
	{
	    ShowPlayerDialog(playerid, DIALOG_GIVE_MASK, DIALOG_STYLE_INPUT, "INVENTORY GIVE", "MASUKAN ID DAN JUMLAH BARANG YG ANDA INGIN KIRIM [ ID JUMLAH ]", "[ GIVE ]", "[ BATAL ]");
	}
	if(!strcmp(name, "Repairkit"))
	{
	    ShowPlayerDialog(playerid, DIALOG_GIVE_REPAIRKIT, DIALOG_STYLE_INPUT, "INVENTORY GIVE", "MASUKAN ID DAN JUMLAH BARANG YG ANDA INGIN KIRIM [ ID JUMLAH ]", "[ GIVE ]", "[ BATAL ]");
	}
	if(!strcmp(name, "GPS"))
	{
	    ShowPlayerDialog(playerid, DIALOG_GIVE_GPS, DIALOG_STYLE_INPUT, "INVENTORY GIVE", "MASUKAN ID DAN JUMLAH BARANG YG ANDA INGIN KIRIM [ ID JUMLAH ]", "[ GIVE ]", "[ BATAL ]");
	}
	if(!strcmp(name, "Sampah"))
	{
	    ShowPlayerDialog(playerid, DIALOG_GIVE_SAMPAH, DIALOG_STYLE_INPUT, "INVENTORY GIVE", "MASUKAN ID DAN JUMLAH BARANG YG ANDA INGIN KIRIM [ ID JUMLAH ]", "[ GIVE ]", "[ BATAL ]");
	}
	return 1;
}

stock CreatePlayerInv(playerid)
{
    GARISBAWAH[playerid][0] = CreatePlayerTextDraw(playerid, 125.000, 170.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, GARISBAWAH[playerid][0], 39.000, 3.000);
	PlayerTextDrawAlignment(playerid, GARISBAWAH[playerid][0], 1);
	PlayerTextDrawColor(playerid, GARISBAWAH[playerid][0], 1097458175);
	PlayerTextDrawSetShadow(playerid, GARISBAWAH[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, GARISBAWAH[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, GARISBAWAH[playerid][0], 255);
	PlayerTextDrawFont(playerid, GARISBAWAH[playerid][0], 4);
	PlayerTextDrawSetProportional(playerid, GARISBAWAH[playerid][0], 1);

	GARISBAWAH[playerid][1] = CreatePlayerTextDraw(playerid, 165.000, 170.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, GARISBAWAH[playerid][1], 39.000, 3.000);
	PlayerTextDrawAlignment(playerid, GARISBAWAH[playerid][1], 1);
	PlayerTextDrawColor(playerid, GARISBAWAH[playerid][1], 1097458175);
	PlayerTextDrawSetShadow(playerid, GARISBAWAH[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, GARISBAWAH[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, GARISBAWAH[playerid][1], 255);
	PlayerTextDrawFont(playerid, GARISBAWAH[playerid][1], 4);
	PlayerTextDrawSetProportional(playerid, GARISBAWAH[playerid][1], 1);

	GARISBAWAH[playerid][2] = CreatePlayerTextDraw(playerid, 205.000, 170.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, GARISBAWAH[playerid][2], 39.000, 3.000);
	PlayerTextDrawAlignment(playerid, GARISBAWAH[playerid][2], 1);
	PlayerTextDrawColor(playerid, GARISBAWAH[playerid][2], 1097458175);
	PlayerTextDrawSetShadow(playerid, GARISBAWAH[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, GARISBAWAH[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, GARISBAWAH[playerid][2], 255);
	PlayerTextDrawFont(playerid, GARISBAWAH[playerid][2], 4);
	PlayerTextDrawSetProportional(playerid, GARISBAWAH[playerid][2], 1);

	GARISBAWAH[playerid][3] = CreatePlayerTextDraw(playerid, 245.000, 170.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, GARISBAWAH[playerid][3], 39.000, 3.000);
	PlayerTextDrawAlignment(playerid, GARISBAWAH[playerid][3], 1);
	PlayerTextDrawColor(playerid, GARISBAWAH[playerid][3], 1097458175);
	PlayerTextDrawSetShadow(playerid, GARISBAWAH[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, GARISBAWAH[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, GARISBAWAH[playerid][3], 255);
	PlayerTextDrawFont(playerid, GARISBAWAH[playerid][3], 4);
	PlayerTextDrawSetProportional(playerid, GARISBAWAH[playerid][3], 1);

	GARISBAWAH[playerid][4] = CreatePlayerTextDraw(playerid, 286.000, 170.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, GARISBAWAH[playerid][4], 39.000, 3.000);
	PlayerTextDrawAlignment(playerid, GARISBAWAH[playerid][4], 1);
	PlayerTextDrawColor(playerid, GARISBAWAH[playerid][4], 1097458175);
	PlayerTextDrawSetShadow(playerid, GARISBAWAH[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, GARISBAWAH[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, GARISBAWAH[playerid][4], 255);
	PlayerTextDrawFont(playerid, GARISBAWAH[playerid][4], 4);
	PlayerTextDrawSetProportional(playerid, GARISBAWAH[playerid][4], 1);

	GARISBAWAH[playerid][5] = CreatePlayerTextDraw(playerid, 125.000, 226.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, GARISBAWAH[playerid][5], 39.000, 3.000);
	PlayerTextDrawAlignment(playerid, GARISBAWAH[playerid][5], 1);
	PlayerTextDrawColor(playerid, GARISBAWAH[playerid][5], 1097458175);
	PlayerTextDrawSetShadow(playerid, GARISBAWAH[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, GARISBAWAH[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, GARISBAWAH[playerid][5], 255);
	PlayerTextDrawFont(playerid, GARISBAWAH[playerid][5], 4);
	PlayerTextDrawSetProportional(playerid, GARISBAWAH[playerid][5], 1);

	GARISBAWAH[playerid][6] = CreatePlayerTextDraw(playerid, 165.000, 226.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, GARISBAWAH[playerid][6], 39.000, 3.000);
	PlayerTextDrawAlignment(playerid, GARISBAWAH[playerid][6], 1);
	PlayerTextDrawColor(playerid, GARISBAWAH[playerid][6], 1097458175);
	PlayerTextDrawSetShadow(playerid, GARISBAWAH[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, GARISBAWAH[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, GARISBAWAH[playerid][6], 255);
	PlayerTextDrawFont(playerid, GARISBAWAH[playerid][6], 4);
	PlayerTextDrawSetProportional(playerid, GARISBAWAH[playerid][6], 1);

	GARISBAWAH[playerid][7] = CreatePlayerTextDraw(playerid, 205.000, 226.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, GARISBAWAH[playerid][7], 39.000, 3.000);
	PlayerTextDrawAlignment(playerid, GARISBAWAH[playerid][7], 1);
	PlayerTextDrawColor(playerid, GARISBAWAH[playerid][7], 1097458175);
	PlayerTextDrawSetShadow(playerid, GARISBAWAH[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, GARISBAWAH[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, GARISBAWAH[playerid][7], 255);
	PlayerTextDrawFont(playerid, GARISBAWAH[playerid][7], 4);
	PlayerTextDrawSetProportional(playerid, GARISBAWAH[playerid][7], 1);

	GARISBAWAH[playerid][8] = CreatePlayerTextDraw(playerid, 245.000, 226.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, GARISBAWAH[playerid][8], 39.000, 3.000);
	PlayerTextDrawAlignment(playerid, GARISBAWAH[playerid][8], 1);
	PlayerTextDrawColor(playerid, GARISBAWAH[playerid][8], 1097458175);
	PlayerTextDrawSetShadow(playerid, GARISBAWAH[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, GARISBAWAH[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, GARISBAWAH[playerid][8], 255);
	PlayerTextDrawFont(playerid, GARISBAWAH[playerid][8], 4);
	PlayerTextDrawSetProportional(playerid, GARISBAWAH[playerid][8], 1);

	GARISBAWAH[playerid][9] = CreatePlayerTextDraw(playerid, 286.000, 226.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, GARISBAWAH[playerid][9], 39.000, 3.000);
	PlayerTextDrawAlignment(playerid, GARISBAWAH[playerid][9], 1);
	PlayerTextDrawColor(playerid, GARISBAWAH[playerid][9], 1097458175);
	PlayerTextDrawSetShadow(playerid, GARISBAWAH[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, GARISBAWAH[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, GARISBAWAH[playerid][9], 255);
	PlayerTextDrawFont(playerid, GARISBAWAH[playerid][9], 4);
	PlayerTextDrawSetProportional(playerid, GARISBAWAH[playerid][9], 1);

	GARISBAWAH[playerid][10] = CreatePlayerTextDraw(playerid, 125.000, 282.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, GARISBAWAH[playerid][10], 39.000, 3.000);
	PlayerTextDrawAlignment(playerid, GARISBAWAH[playerid][10], 1);
	PlayerTextDrawColor(playerid, GARISBAWAH[playerid][10], 1097458175);
	PlayerTextDrawSetShadow(playerid, GARISBAWAH[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, GARISBAWAH[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, GARISBAWAH[playerid][10], 255);
	PlayerTextDrawFont(playerid, GARISBAWAH[playerid][10], 4);
	PlayerTextDrawSetProportional(playerid, GARISBAWAH[playerid][10], 1);

	GARISBAWAH[playerid][11] = CreatePlayerTextDraw(playerid, 165.000, 282.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, GARISBAWAH[playerid][11], 39.000, 3.000);
	PlayerTextDrawAlignment(playerid, GARISBAWAH[playerid][11], 1);
	PlayerTextDrawColor(playerid, GARISBAWAH[playerid][11], 1097458175);
	PlayerTextDrawSetShadow(playerid, GARISBAWAH[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, GARISBAWAH[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, GARISBAWAH[playerid][11], 255);
	PlayerTextDrawFont(playerid, GARISBAWAH[playerid][11], 4);
	PlayerTextDrawSetProportional(playerid, GARISBAWAH[playerid][11], 1);

	GARISBAWAH[playerid][12] = CreatePlayerTextDraw(playerid, 205.000, 282.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, GARISBAWAH[playerid][12], 39.000, 3.000);
	PlayerTextDrawAlignment(playerid, GARISBAWAH[playerid][12], 1);
	PlayerTextDrawColor(playerid, GARISBAWAH[playerid][12], 1097458175);
	PlayerTextDrawSetShadow(playerid, GARISBAWAH[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, GARISBAWAH[playerid][12], 0);
	PlayerTextDrawBackgroundColor(playerid, GARISBAWAH[playerid][12], 255);
	PlayerTextDrawFont(playerid, GARISBAWAH[playerid][12], 4);
	PlayerTextDrawSetProportional(playerid, GARISBAWAH[playerid][12], 1);

	GARISBAWAH[playerid][13] = CreatePlayerTextDraw(playerid, 245.000, 282.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, GARISBAWAH[playerid][13], 39.000, 3.000);
	PlayerTextDrawAlignment(playerid, GARISBAWAH[playerid][13], 1);
	PlayerTextDrawColor(playerid, GARISBAWAH[playerid][13], 1097458175);
	PlayerTextDrawSetShadow(playerid, GARISBAWAH[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, GARISBAWAH[playerid][13], 0);
	PlayerTextDrawBackgroundColor(playerid, GARISBAWAH[playerid][13], 255);
	PlayerTextDrawFont(playerid, GARISBAWAH[playerid][13], 4);
	PlayerTextDrawSetProportional(playerid, GARISBAWAH[playerid][13], 1);

	GARISBAWAH[playerid][14] = CreatePlayerTextDraw(playerid, 286.000, 282.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, GARISBAWAH[playerid][14], 39.000, 3.000);
	PlayerTextDrawAlignment(playerid, GARISBAWAH[playerid][14], 1);
	PlayerTextDrawColor(playerid, GARISBAWAH[playerid][14], 1097458175);
	PlayerTextDrawSetShadow(playerid, GARISBAWAH[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, GARISBAWAH[playerid][14], 0);
	PlayerTextDrawBackgroundColor(playerid, GARISBAWAH[playerid][14], 255);
	PlayerTextDrawFont(playerid, GARISBAWAH[playerid][14], 4);
	PlayerTextDrawSetProportional(playerid, GARISBAWAH[playerid][14], 1);

	GARISBAWAH[playerid][15] = CreatePlayerTextDraw(playerid, 125.000, 338.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, GARISBAWAH[playerid][15], 39.000, 3.000);
	PlayerTextDrawAlignment(playerid, GARISBAWAH[playerid][15], 1);
	PlayerTextDrawColor(playerid, GARISBAWAH[playerid][15], 1097458175);
	PlayerTextDrawSetShadow(playerid, GARISBAWAH[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, GARISBAWAH[playerid][15], 0);
	PlayerTextDrawBackgroundColor(playerid, GARISBAWAH[playerid][15], 255);
	PlayerTextDrawFont(playerid, GARISBAWAH[playerid][15], 4);
	PlayerTextDrawSetProportional(playerid, GARISBAWAH[playerid][15], 1);

	GARISBAWAH[playerid][16] = CreatePlayerTextDraw(playerid, 165.000, 338.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, GARISBAWAH[playerid][16], 39.000, 3.000);
	PlayerTextDrawAlignment(playerid, GARISBAWAH[playerid][16], 1);
	PlayerTextDrawColor(playerid, GARISBAWAH[playerid][16], 1097458175);
	PlayerTextDrawSetShadow(playerid, GARISBAWAH[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, GARISBAWAH[playerid][16], 0);
	PlayerTextDrawBackgroundColor(playerid, GARISBAWAH[playerid][16], 255);
	PlayerTextDrawFont(playerid, GARISBAWAH[playerid][16], 4);
	PlayerTextDrawSetProportional(playerid, GARISBAWAH[playerid][16], 1);

	GARISBAWAH[playerid][17] = CreatePlayerTextDraw(playerid, 205.000, 338.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, GARISBAWAH[playerid][17], 39.000, 3.000);
	PlayerTextDrawAlignment(playerid, GARISBAWAH[playerid][17], 1);
	PlayerTextDrawColor(playerid, GARISBAWAH[playerid][17], 1097458175);
	PlayerTextDrawSetShadow(playerid, GARISBAWAH[playerid][17], 0);
	PlayerTextDrawSetOutline(playerid, GARISBAWAH[playerid][17], 0);
	PlayerTextDrawBackgroundColor(playerid, GARISBAWAH[playerid][17], 255);
	PlayerTextDrawFont(playerid, GARISBAWAH[playerid][17], 4);
	PlayerTextDrawSetProportional(playerid, GARISBAWAH[playerid][17], 1);

	GARISBAWAH[playerid][18] = CreatePlayerTextDraw(playerid, 245.000, 338.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, GARISBAWAH[playerid][18], 39.000, 3.000);
	PlayerTextDrawAlignment(playerid, GARISBAWAH[playerid][18], 1);
	PlayerTextDrawColor(playerid, GARISBAWAH[playerid][18], 1097458175);
	PlayerTextDrawSetShadow(playerid, GARISBAWAH[playerid][18], 0);
	PlayerTextDrawSetOutline(playerid, GARISBAWAH[playerid][18], 0);
	PlayerTextDrawBackgroundColor(playerid, GARISBAWAH[playerid][18], 255);
	PlayerTextDrawFont(playerid, GARISBAWAH[playerid][18], 4);
	PlayerTextDrawSetProportional(playerid, GARISBAWAH[playerid][18], 1);

	GARISBAWAH[playerid][19] = CreatePlayerTextDraw(playerid, 286.000, 338.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, GARISBAWAH[playerid][19], 39.000, 3.000);
	PlayerTextDrawAlignment(playerid, GARISBAWAH[playerid][19], 1);
	PlayerTextDrawColor(playerid, GARISBAWAH[playerid][19], 1097458175);
	PlayerTextDrawSetShadow(playerid, GARISBAWAH[playerid][19], 0);
	PlayerTextDrawSetOutline(playerid, GARISBAWAH[playerid][19], 0);
	PlayerTextDrawBackgroundColor(playerid, GARISBAWAH[playerid][19], 255);
	PlayerTextDrawFont(playerid, GARISBAWAH[playerid][19], 4);
	PlayerTextDrawSetProportional(playerid, GARISBAWAH[playerid][19], 1);

	INVNAME[playerid][0] = CreatePlayerTextDraw(playerid, 118.000, 96.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INVNAME[playerid][0], 213.000, 253.000);
	PlayerTextDrawAlignment(playerid, INVNAME[playerid][0], 1);
	PlayerTextDrawColor(playerid, INVNAME[playerid][0], 690964479);
	PlayerTextDrawSetShadow(playerid, INVNAME[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, INVNAME[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, INVNAME[playerid][0], 255);
	PlayerTextDrawFont(playerid, INVNAME[playerid][0], 4);
	PlayerTextDrawSetProportional(playerid, INVNAME[playerid][0], 1);

	INVNAME[playerid][1] = CreatePlayerTextDraw(playerid, 125.000, 115.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INVNAME[playerid][1], 199.000, 3.000);
	PlayerTextDrawAlignment(playerid, INVNAME[playerid][1], 1);
	PlayerTextDrawColor(playerid, INVNAME[playerid][1], 255);
	PlayerTextDrawSetShadow(playerid, INVNAME[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, INVNAME[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, INVNAME[playerid][1], 255);
	PlayerTextDrawFont(playerid, INVNAME[playerid][1], 4);
	PlayerTextDrawSetProportional(playerid, INVNAME[playerid][1], 1);

	INVNAME[playerid][2] = CreatePlayerTextDraw(playerid, 126.000, 115.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INVNAME[playerid][2], 165.000, 3.000);
	PlayerTextDrawAlignment(playerid, INVNAME[playerid][2], 1);
	PlayerTextDrawColor(playerid, INVNAME[playerid][2], 1097458175);
	PlayerTextDrawSetShadow(playerid, INVNAME[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, INVNAME[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, INVNAME[playerid][2], 255);
	PlayerTextDrawFont(playerid, INVNAME[playerid][2], 4);
	PlayerTextDrawSetProportional(playerid, INVNAME[playerid][2], 1);

	INVNAME[playerid][3] = CreatePlayerTextDraw(playerid, 126.000, 105.000, "Atsuko Tadashiu");
	PlayerTextDrawLetterSize(playerid, INVNAME[playerid][3], 0.140, 0.898);
	PlayerTextDrawAlignment(playerid, INVNAME[playerid][3], 1);
	PlayerTextDrawColor(playerid, INVNAME[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, INVNAME[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, INVNAME[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, INVNAME[playerid][3], 150);
	PlayerTextDrawFont(playerid, INVNAME[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, INVNAME[playerid][3], 1);

	INVNAME[playerid][4] = CreatePlayerTextDraw(playerid, 324.000, 105.000, "100/300");
	PlayerTextDrawLetterSize(playerid, INVNAME[playerid][4], 0.140, 0.699);
	PlayerTextDrawAlignment(playerid, INVNAME[playerid][4], 3);
	PlayerTextDrawColor(playerid, INVNAME[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, INVNAME[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, INVNAME[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, INVNAME[playerid][4], 150);
	PlayerTextDrawFont(playerid, INVNAME[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, INVNAME[playerid][4], 1);

	INVNAME[playerid][5] = CreatePlayerTextDraw(playerid, 295.000, 104.000, "H");
	PlayerTextDrawLetterSize(playerid, INVNAME[playerid][5], 0.200, 0.898);
	PlayerTextDrawAlignment(playerid, INVNAME[playerid][5], 3);
	PlayerTextDrawColor(playerid, INVNAME[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, INVNAME[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, INVNAME[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, INVNAME[playerid][5], 150);
	PlayerTextDrawFont(playerid, INVNAME[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, INVNAME[playerid][5], 1);

    INVINFO[playerid][0] = CreatePlayerTextDraw(playerid, 347.000, 168.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INVINFO[playerid][0], 55.000, 117.000);
	PlayerTextDrawAlignment(playerid, INVINFO[playerid][0], 1);
	PlayerTextDrawColor(playerid, INVINFO[playerid][0], 690964479);
	PlayerTextDrawSetShadow(playerid, INVINFO[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, INVINFO[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, INVINFO[playerid][0], 255);
	PlayerTextDrawFont(playerid, INVINFO[playerid][0], 4);
	PlayerTextDrawSetProportional(playerid, INVINFO[playerid][0], 1);

	INVINFO[playerid][1] = CreatePlayerTextDraw(playerid, 352.000, 174.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INVINFO[playerid][1], 45.000, 18.000);
	PlayerTextDrawAlignment(playerid, INVINFO[playerid][1], 1);
	PlayerTextDrawColor(playerid, INVINFO[playerid][1], 859394047);
	PlayerTextDrawSetShadow(playerid, INVINFO[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, INVINFO[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, INVINFO[playerid][1], 255);
	PlayerTextDrawFont(playerid, INVINFO[playerid][1], 4);
	PlayerTextDrawSetProportional(playerid, INVINFO[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, INVINFO[playerid][1], 1);

	INVINFO[playerid][2] = CreatePlayerTextDraw(playerid, 352.000, 195.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INVINFO[playerid][2], 45.000, 18.000);
	PlayerTextDrawAlignment(playerid, INVINFO[playerid][2], 1);
	PlayerTextDrawColor(playerid, INVINFO[playerid][2], 859394047);
	PlayerTextDrawSetShadow(playerid, INVINFO[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, INVINFO[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, INVINFO[playerid][2], 255);
	PlayerTextDrawFont(playerid, INVINFO[playerid][2], 4);
	PlayerTextDrawSetProportional(playerid, INVINFO[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, INVINFO[playerid][2], 1);

	INVINFO[playerid][3] = CreatePlayerTextDraw(playerid, 352.000, 216.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INVINFO[playerid][3], 45.000, 18.000);
	PlayerTextDrawAlignment(playerid, INVINFO[playerid][3], 1);
	PlayerTextDrawColor(playerid, INVINFO[playerid][3], 859394047);
	PlayerTextDrawSetShadow(playerid, INVINFO[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, INVINFO[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, INVINFO[playerid][3], 255);
	PlayerTextDrawFont(playerid, INVINFO[playerid][3], 4);
	PlayerTextDrawSetProportional(playerid, INVINFO[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, INVINFO[playerid][3], 1);

	INVINFO[playerid][4] = CreatePlayerTextDraw(playerid, 352.000, 237.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INVINFO[playerid][4], 45.000, 18.000);
	PlayerTextDrawAlignment(playerid, INVINFO[playerid][4], 1);
	PlayerTextDrawColor(playerid, INVINFO[playerid][4], 859394047);
	PlayerTextDrawSetShadow(playerid, INVINFO[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, INVINFO[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, INVINFO[playerid][4], 255);
	PlayerTextDrawFont(playerid, INVINFO[playerid][4], 4);
	PlayerTextDrawSetProportional(playerid, INVINFO[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, INVINFO[playerid][4], 1);

	INVINFO[playerid][5] = CreatePlayerTextDraw(playerid, 352.000, 258.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INVINFO[playerid][5], 45.000, 18.000);
	PlayerTextDrawAlignment(playerid, INVINFO[playerid][5], 1);
	PlayerTextDrawColor(playerid, INVINFO[playerid][5], 859394047);
	PlayerTextDrawSetShadow(playerid, INVINFO[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, INVINFO[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, INVINFO[playerid][5], 255);
	PlayerTextDrawFont(playerid, INVINFO[playerid][5], 4);
	PlayerTextDrawSetProportional(playerid, INVINFO[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, INVINFO[playerid][5], 1);

	INVINFO[playerid][6] = CreatePlayerTextDraw(playerid, 375.000, 179.000, "Amount");
	PlayerTextDrawLetterSize(playerid, INVINFO[playerid][6], 0.150, 0.898);
	PlayerTextDrawAlignment(playerid, INVINFO[playerid][6], 2);
	PlayerTextDrawColor(playerid, INVINFO[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, INVINFO[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, INVINFO[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, INVINFO[playerid][6], 150);
	PlayerTextDrawFont(playerid, INVINFO[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, INVINFO[playerid][6], 1);

	INVINFO[playerid][7] = CreatePlayerTextDraw(playerid, 375.000, 199.000, "Use");
	PlayerTextDrawLetterSize(playerid, INVINFO[playerid][7], 0.150, 0.898);
	PlayerTextDrawAlignment(playerid, INVINFO[playerid][7], 2);
	PlayerTextDrawColor(playerid, INVINFO[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, INVINFO[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, INVINFO[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, INVINFO[playerid][7], 150);
	PlayerTextDrawFont(playerid, INVINFO[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, INVINFO[playerid][7], 1);

	INVINFO[playerid][8] = CreatePlayerTextDraw(playerid, 375.000, 220.000, "Give");
	PlayerTextDrawLetterSize(playerid, INVINFO[playerid][8], 0.150, 0.898);
	PlayerTextDrawAlignment(playerid, INVINFO[playerid][8], 2);
	PlayerTextDrawColor(playerid, INVINFO[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, INVINFO[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, INVINFO[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, INVINFO[playerid][8], 150);
	PlayerTextDrawFont(playerid, INVINFO[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, INVINFO[playerid][8], 1);

	INVINFO[playerid][9] = CreatePlayerTextDraw(playerid, 375.000, 242.000, "Drop");
	PlayerTextDrawLetterSize(playerid, INVINFO[playerid][9], 0.150, 0.898);
	PlayerTextDrawAlignment(playerid, INVINFO[playerid][9], 2);
	PlayerTextDrawColor(playerid, INVINFO[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, INVINFO[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, INVINFO[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, INVINFO[playerid][9], 150);
	PlayerTextDrawFont(playerid, INVINFO[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, INVINFO[playerid][9], 1);

	INVINFO[playerid][10] = CreatePlayerTextDraw(playerid, 375.000, 263.000, "Close");
	PlayerTextDrawLetterSize(playerid, INVINFO[playerid][10], 0.150, 0.898);
	PlayerTextDrawAlignment(playerid, INVINFO[playerid][10], 2);
	PlayerTextDrawColor(playerid, INVINFO[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, INVINFO[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, INVINFO[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, INVINFO[playerid][10], 150);
	PlayerTextDrawFont(playerid, INVINFO[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, INVINFO[playerid][10], 1);

	NAMETD[playerid][0] = CreatePlayerTextDraw(playerid, 128.000, 121.000, "Uang");
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][0], 0.128, 0.699);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][0], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][0], 150);
	PlayerTextDrawFont(playerid, NAMETD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][0], 1);

	NAMETD[playerid][1] = CreatePlayerTextDraw(playerid, 168.000, 121.000, "Uang");
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][1], 0.128, 0.699);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][1], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][1], 150);
	PlayerTextDrawFont(playerid, NAMETD[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][1], 1);

	NAMETD[playerid][2] = CreatePlayerTextDraw(playerid, 208.000, 121.000, "Uang");
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][2], 0.128, 0.699);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][2], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][2], 150);
	PlayerTextDrawFont(playerid, NAMETD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][2], 1);

	NAMETD[playerid][3] = CreatePlayerTextDraw(playerid, 248.000, 121.000, "Uang");
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][3], 0.128, 0.699);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][3], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][3], 150);
	PlayerTextDrawFont(playerid, NAMETD[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][3], 1);

	NAMETD[playerid][4] = CreatePlayerTextDraw(playerid, 287.000, 121.000, "Uang");
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][4], 0.128, 0.699);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][4], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][4], 150);
	PlayerTextDrawFont(playerid, NAMETD[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][4], 1);

	NAMETD[playerid][5] = CreatePlayerTextDraw(playerid, 128.000, 176.000, "Uang");
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][5], 0.128, 0.699);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][5], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][5], 150);
	PlayerTextDrawFont(playerid, NAMETD[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][5], 1);

	NAMETD[playerid][6] = CreatePlayerTextDraw(playerid, 168.000, 176.000, "Uang");
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][6], 0.128, 0.699);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][6], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][6], 150);
	PlayerTextDrawFont(playerid, NAMETD[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][6], 1);

	NAMETD[playerid][7] = CreatePlayerTextDraw(playerid, 208.000, 176.000, "Uang");
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][7], 0.128, 0.699);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][7], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][7], 150);
	PlayerTextDrawFont(playerid, NAMETD[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][7], 1);

	NAMETD[playerid][8] = CreatePlayerTextDraw(playerid, 248.000, 176.000, "Uang");
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][8], 0.128, 0.699);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][8], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][8], 150);
	PlayerTextDrawFont(playerid, NAMETD[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][8], 1);

	NAMETD[playerid][9] = CreatePlayerTextDraw(playerid, 287.000, 176.000, "Uang");
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][9], 0.128, 0.699);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][9], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][9], 150);
	PlayerTextDrawFont(playerid, NAMETD[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][9], 1);

	NAMETD[playerid][10] = CreatePlayerTextDraw(playerid, 128.000, 232.000, "Uang");
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][10], 0.128, 0.699);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][10], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][10], 150);
	PlayerTextDrawFont(playerid, NAMETD[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][10], 1);

	NAMETD[playerid][11] = CreatePlayerTextDraw(playerid, 168.000, 232.000, "Uang");
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][11], 0.128, 0.699);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][11], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][11], -1);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][11], 150);
	PlayerTextDrawFont(playerid, NAMETD[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][11], 1);

	NAMETD[playerid][12] = CreatePlayerTextDraw(playerid, 208.000, 232.000, "Uang");
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][12], 0.128, 0.699);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][12], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][12], -1);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][12], 0);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][12], 150);
	PlayerTextDrawFont(playerid, NAMETD[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][12], 1);

	NAMETD[playerid][13] = CreatePlayerTextDraw(playerid, 248.000, 232.000, "Uang");
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][13], 0.128, 0.699);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][13], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][13], -1);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][13], 0);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][13], 150);
	PlayerTextDrawFont(playerid, NAMETD[playerid][13], 1);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][13], 1);

	NAMETD[playerid][14] = CreatePlayerTextDraw(playerid, 287.000, 232.000, "Uang");
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][14], 0.128, 0.699);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][14], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][14], -1);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][14], 0);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][14], 150);
	PlayerTextDrawFont(playerid, NAMETD[playerid][14], 1);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][14], 1);

	NAMETD[playerid][15] = CreatePlayerTextDraw(playerid, 128.000, 287.000, "Uang");
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][15], 0.128, 0.699);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][15], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][15], -1);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][15], 0);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][15], 150);
	PlayerTextDrawFont(playerid, NAMETD[playerid][15], 1);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][15], 1);

	NAMETD[playerid][16] = CreatePlayerTextDraw(playerid, 168.000, 287.000, "Uang");
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][16], 0.128, 0.699);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][16], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][16], -1);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][16], 0);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][16], 150);
	PlayerTextDrawFont(playerid, NAMETD[playerid][16], 1);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][16], 1);

	NAMETD[playerid][17] = CreatePlayerTextDraw(playerid, 208.000, 287.000, "Uang");
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][17], 0.128, 0.699);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][17], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][17], -1);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][17], 0);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][17], 0);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][17], 150);
	PlayerTextDrawFont(playerid, NAMETD[playerid][17], 1);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][17], 1);

	NAMETD[playerid][18] = CreatePlayerTextDraw(playerid, 248.000, 287.000, "Uang");
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][18], 0.128, 0.699);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][18], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][18], -1);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][18], 0);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][18], 0);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][18], 150);
	PlayerTextDrawFont(playerid, NAMETD[playerid][18], 1);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][18], 1);

	NAMETD[playerid][19] = CreatePlayerTextDraw(playerid, 287.000, 287.000, "Uang");
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][19], 0.128, 0.699);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][19], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][19], -1);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][19], 0);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][19], 0);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][19], 150);
	PlayerTextDrawFont(playerid, NAMETD[playerid][19], 1);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][19], 1);

	INDEXTD[playerid][0] = CreatePlayerTextDraw(playerid, 125.000, 120.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][0], 39.000, 51.000);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][0], 859394047);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][0], 255);
	PlayerTextDrawFont(playerid, INDEXTD[playerid][0], 4);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][0], 1);

	INDEXTD[playerid][1] = CreatePlayerTextDraw(playerid, 165.000, 120.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][1], 39.000, 51.000);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][1], 859394047);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][1], 255);
	PlayerTextDrawFont(playerid, INDEXTD[playerid][1], 4);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][1], 1);

	INDEXTD[playerid][2] = CreatePlayerTextDraw(playerid, 205.000, 120.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][2], 39.000, 51.000);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][2], 859394047);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][2], 255);
	PlayerTextDrawFont(playerid, INDEXTD[playerid][2], 4);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][2], 1);

	INDEXTD[playerid][3] = CreatePlayerTextDraw(playerid, 245.000, 120.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][3], 39.000, 51.000);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][3], 859394047);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][3], 255);
	PlayerTextDrawFont(playerid, INDEXTD[playerid][3], 4);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][3], 1);

	INDEXTD[playerid][4] = CreatePlayerTextDraw(playerid, 285.000, 120.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][4], 39.000, 51.000);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][4], 859394047);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][4], 255);
	PlayerTextDrawFont(playerid, INDEXTD[playerid][4], 4);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][4], 1);

	INDEXTD[playerid][5] = CreatePlayerTextDraw(playerid, 125.000, 176.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][5], 39.000, 51.000);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][5], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][5], 859394047);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][5], 255);
	PlayerTextDrawFont(playerid, INDEXTD[playerid][5], 4);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][5], 1);

	INDEXTD[playerid][6] = CreatePlayerTextDraw(playerid, 165.000, 176.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][6], 39.000, 51.000);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][6], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][6], 859394047);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][6], 255);
	PlayerTextDrawFont(playerid, INDEXTD[playerid][6], 4);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][6], 1);

	INDEXTD[playerid][7] = CreatePlayerTextDraw(playerid, 205.000, 176.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][7], 39.000, 51.000);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][7], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][7], 859394047);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][7], 255);
	PlayerTextDrawFont(playerid, INDEXTD[playerid][7], 4);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][7], 1);

	INDEXTD[playerid][8] = CreatePlayerTextDraw(playerid, 245.000, 176.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][8], 39.000, 51.000);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][8], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][8], 859394047);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][8], 255);
	PlayerTextDrawFont(playerid, INDEXTD[playerid][8], 4);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][8], 1);

	INDEXTD[playerid][9] = CreatePlayerTextDraw(playerid, 285.000, 176.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][9], 39.000, 51.000);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][9], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][9], 859394047);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][9], 255);
	PlayerTextDrawFont(playerid, INDEXTD[playerid][9], 4);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][9], 1);

	INDEXTD[playerid][10] = CreatePlayerTextDraw(playerid, 125.000, 232.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][10], 39.000, 51.000);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][10], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][10], 859394047);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][10], 255);
	PlayerTextDrawFont(playerid, INDEXTD[playerid][10], 4);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][10], 1);

	INDEXTD[playerid][11] = CreatePlayerTextDraw(playerid, 165.000, 232.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][11], 39.000, 51.000);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][11], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][11], 859394047);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][11], 255);
	PlayerTextDrawFont(playerid, INDEXTD[playerid][11], 4);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][11], 1);

	INDEXTD[playerid][12] = CreatePlayerTextDraw(playerid, 205.000, 232.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][12], 39.000, 51.000);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][12], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][12], 859394047);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][12], 0);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][12], 255);
	PlayerTextDrawFont(playerid, INDEXTD[playerid][12], 4);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][12], 1);

	INDEXTD[playerid][13] = CreatePlayerTextDraw(playerid, 245.000, 232.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][13], 39.000, 51.000);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][13], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][13], 859394047);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][13], 0);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][13], 255);
	PlayerTextDrawFont(playerid, INDEXTD[playerid][13], 4);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][13], 1);

	INDEXTD[playerid][14] = CreatePlayerTextDraw(playerid, 285.000, 232.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][14], 39.000, 51.000);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][14], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][14], 859394047);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][14], 0);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][14], 255);
	PlayerTextDrawFont(playerid, INDEXTD[playerid][14], 4);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][14], 1);

	INDEXTD[playerid][15] = CreatePlayerTextDraw(playerid, 125.000, 288.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][15], 39.000, 51.000);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][15], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][15], 859394047);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][15], 0);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][15], 255);
	PlayerTextDrawFont(playerid, INDEXTD[playerid][15], 4);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][15], 1);

	INDEXTD[playerid][16] = CreatePlayerTextDraw(playerid, 165.000, 288.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][16], 39.000, 51.000);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][16], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][16], 859394047);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][16], 0);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][16], 255);
	PlayerTextDrawFont(playerid, INDEXTD[playerid][16], 4);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][16], 1);

	INDEXTD[playerid][17] = CreatePlayerTextDraw(playerid, 205.000, 288.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][17], 39.000, 51.000);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][17], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][17], 859394047);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][17], 0);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][17], 0);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][17], 255);
	PlayerTextDrawFont(playerid, INDEXTD[playerid][17], 4);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][17], 1);

	INDEXTD[playerid][18] = CreatePlayerTextDraw(playerid, 245.000, 288.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][18], 39.000, 51.000);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][18], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][18], 859394047);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][18], 0);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][18], 0);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][18], 255);
	PlayerTextDrawFont(playerid, INDEXTD[playerid][18], 4);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][18], 1);

	INDEXTD[playerid][19] = CreatePlayerTextDraw(playerid, 285.000, 288.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][19], 39.000, 51.000);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][19], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][19], 859394047);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][19], 0);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][19], 0);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][19], 255);
	PlayerTextDrawFont(playerid, INDEXTD[playerid][19], 4);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][19], 1);

	MODELTD[playerid][0] = CreatePlayerTextDraw(playerid, 129.000, 129.000, "_");
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][0], 30.000, 35.000);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][0], 0);
	PlayerTextDrawFont(playerid, MODELTD[playerid][0], 5);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][0], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][0], 1212);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][0], 0.000, 0.000, 0.000, 1.000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][0], 0, 0);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][0], 1);

	MODELTD[playerid][1] = CreatePlayerTextDraw(playerid, 169.000, 129.000, "_");
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][1], 30.000, 35.000);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][1], 0);
	PlayerTextDrawFont(playerid, MODELTD[playerid][1], 5);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][1], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][1], 1212);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][1], 0.000, 0.000, 0.000, 1.000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][1], 0, 0);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][1], 1);

	MODELTD[playerid][2] = CreatePlayerTextDraw(playerid, 209.000, 129.000, "_");
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][2], 30.000, 35.000);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][2], 0);
	PlayerTextDrawFont(playerid, MODELTD[playerid][2], 5);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][2], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][2], 1212);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][2], 0.000, 0.000, 0.000, 1.000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][2], 0, 0);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][2], 1);

	MODELTD[playerid][3] = CreatePlayerTextDraw(playerid, 249.000, 129.000, "_");
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][3], 30.000, 35.000);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][3], 0);
	PlayerTextDrawFont(playerid, MODELTD[playerid][3], 5);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][3], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][3], 1212);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][3], 0.000, 0.000, 0.000, 1.000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][3], 0, 0);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][3], 1);

	MODELTD[playerid][4] = CreatePlayerTextDraw(playerid, 289.000, 129.000, "_");
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][4], 30.000, 35.000);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][4], 0);
	PlayerTextDrawFont(playerid, MODELTD[playerid][4], 5);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][4], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][4], 1212);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][4], 0.000, 0.000, 0.000, 1.000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][4], 0, 0);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][4], 1);

	MODELTD[playerid][5] = CreatePlayerTextDraw(playerid, 129.000, 185.000, "_");
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][5], 30.000, 35.000);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][5], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][5], 0);
	PlayerTextDrawFont(playerid, MODELTD[playerid][5], 5);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][5], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][5], 1212);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][5], 0.000, 0.000, 0.000, 1.000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][5], 0, 0);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][5], 1);

	MODELTD[playerid][6] = CreatePlayerTextDraw(playerid, 169.000, 185.000, "_");
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][6], 30.000, 35.000);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][6], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][6], 0);
	PlayerTextDrawFont(playerid, MODELTD[playerid][6], 5);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][6], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][6], 1212);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][6], 0.000, 0.000, 0.000, 1.000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][6], 0, 0);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][6], 1);

	MODELTD[playerid][7] = CreatePlayerTextDraw(playerid, 209.000, 185.000, "_");
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][7], 30.000, 35.000);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][7], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][7], 0);
	PlayerTextDrawFont(playerid, MODELTD[playerid][7], 5);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][7], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][7], 1212);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][7], 0.000, 0.000, 0.000, 1.000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][7], 0, 0);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][7], 1);

	MODELTD[playerid][8] = CreatePlayerTextDraw(playerid, 249.000, 185.000, "_");
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][8], 30.000, 35.000);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][8], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][8], 0);
	PlayerTextDrawFont(playerid, MODELTD[playerid][8], 5);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][8], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][8], 1212);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][8], 0.000, 0.000, 0.000, 1.000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][8], 0, 0);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][8], 1);

	MODELTD[playerid][9] = CreatePlayerTextDraw(playerid, 289.000, 185.000, "_");
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][9], 30.000, 35.000);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][9], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][9], 0);
	PlayerTextDrawFont(playerid, MODELTD[playerid][9], 5);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][9], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][9], 1212);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][9], 0.000, 0.000, 0.000, 1.000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][9], 0, 0);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][9], 1);

	MODELTD[playerid][10] = CreatePlayerTextDraw(playerid, 129.000, 241.000, "_");
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][10], 30.000, 35.000);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][10], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][10], 0);
	PlayerTextDrawFont(playerid, MODELTD[playerid][10], 5);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][10], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][10], 1212);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][10], 0.000, 0.000, 0.000, 1.000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][10], 0, 0);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][10], 1);

	MODELTD[playerid][11] = CreatePlayerTextDraw(playerid, 169.000, 241.000, "_");
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][11], 30.000, 35.000);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][11], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][11], -1);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][11], 0);
	PlayerTextDrawFont(playerid, MODELTD[playerid][11], 5);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][11], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][11], 1212);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][11], 0.000, 0.000, 0.000, 1.000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][11], 0, 0);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][11], 1);

	MODELTD[playerid][12] = CreatePlayerTextDraw(playerid, 209.000, 241.000, "_");
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][12], 30.000, 35.000);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][12], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][12], -1);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][12], 0);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][12], 0);
	PlayerTextDrawFont(playerid, MODELTD[playerid][12], 5);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][12], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][12], 1212);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][12], 0.000, 0.000, 0.000, 1.000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][12], 0, 0);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][12], 1);

	MODELTD[playerid][13] = CreatePlayerTextDraw(playerid, 249.000, 241.000, "_");
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][13], 30.000, 35.000);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][13], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][13], -1);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][13], 0);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][13], 0);
	PlayerTextDrawFont(playerid, MODELTD[playerid][13], 5);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][13], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][13], 1212);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][13], 0.000, 0.000, 0.000, 1.000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][13], 0, 0);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][13], 1);

	MODELTD[playerid][14] = CreatePlayerTextDraw(playerid, 289.000, 241.000, "_");
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][14], 30.000, 35.000);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][14], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][14], -1);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][14], 0);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][14], 0);
	PlayerTextDrawFont(playerid, MODELTD[playerid][14], 5);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][14], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][14], 1212);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][14], 0.000, 0.000, 0.000, 1.000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][14], 0, 0);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][14], 1);

	MODELTD[playerid][15] = CreatePlayerTextDraw(playerid, 129.000, 297.000, "_");
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][15], 30.000, 35.000);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][15], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][15], -1);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][15], 0);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][15], 0);
	PlayerTextDrawFont(playerid, MODELTD[playerid][15], 5);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][15], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][15], 1212);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][15], 0.000, 0.000, 0.000, 1.000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][15], 0, 0);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][15], 1);

	MODELTD[playerid][16] = CreatePlayerTextDraw(playerid, 169.000, 297.000, "_");
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][16], 30.000, 35.000);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][16], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][16], -1);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][16], 0);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][16], 0);
	PlayerTextDrawFont(playerid, MODELTD[playerid][16], 5);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][16], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][16], 1212);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][16], 0.000, 0.000, 0.000, 1.000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][16], 0, 0);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][16], 1);

	MODELTD[playerid][17] = CreatePlayerTextDraw(playerid, 209.000, 297.000, "_");
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][17], 30.000, 35.000);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][17], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][17], -1);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][17], 0);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][17], 0);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][17], 0);
	PlayerTextDrawFont(playerid, MODELTD[playerid][17], 5);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][17], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][17], 1212);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][17], 0.000, 0.000, 0.000, 1.000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][17], 0, 0);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][17], 1);

	MODELTD[playerid][18] = CreatePlayerTextDraw(playerid, 249.000, 297.000, "_");
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][18], 30.000, 35.000);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][18], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][18], -1);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][18], 0);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][18], 0);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][18], 0);
	PlayerTextDrawFont(playerid, MODELTD[playerid][18], 5);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][18], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][18], 1212);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][18], 0.000, 0.000, 0.000, 1.000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][18], 0, 0);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][18], 1);

	MODELTD[playerid][19] = CreatePlayerTextDraw(playerid, 289.000, 297.000, "_");
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][19], 30.000, 35.000);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][19], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][19], -1);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][19], 0);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][19], 0);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][19], 0);
	PlayerTextDrawFont(playerid, MODELTD[playerid][19], 5);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][19], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][19], 1212);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][19], 0.000, 0.000, 0.000, 1.000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][19], 0, 0);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][19], 1);

	AMOUNTTD[playerid][0] = CreatePlayerTextDraw(playerid, 126.000, 162.000, "10000x");
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][0], 0.119, 0.598);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][0], 150);
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][0], 1);

	AMOUNTTD[playerid][1] = CreatePlayerTextDraw(playerid, 166.000, 162.000, "10000x");
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][1], 0.119, 0.598);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][1], 150);
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][1], 1);

	AMOUNTTD[playerid][2] = CreatePlayerTextDraw(playerid, 206.000, 162.000, "10000x");
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][2], 0.119, 0.598);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][2], 150);
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][2], 1);

	AMOUNTTD[playerid][3] = CreatePlayerTextDraw(playerid, 246.000, 162.000, "10000x");
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][3], 0.119, 0.598);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][3], 150);
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][3], 1);

	AMOUNTTD[playerid][4] = CreatePlayerTextDraw(playerid, 286.000, 162.000, "10000x");
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][4], 0.119, 0.598);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][4], 150);
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][4], 1);

	AMOUNTTD[playerid][5] = CreatePlayerTextDraw(playerid, 126.000, 218.000, "10000x");
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][5], 0.119, 0.598);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][5], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][5], 150);
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][5], 1);

	AMOUNTTD[playerid][6] = CreatePlayerTextDraw(playerid, 166.000, 218.000, "10000x");
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][6], 0.119, 0.598);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][6], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][6], 150);
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][6], 1);

	AMOUNTTD[playerid][7] = CreatePlayerTextDraw(playerid, 206.000, 218.000, "10000x");
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][7], 0.119, 0.598);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][7], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][7], 150);
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][7], 1);

	AMOUNTTD[playerid][8] = CreatePlayerTextDraw(playerid, 246.000, 218.000, "10000x");
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][8], 0.119, 0.598);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][8], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][8], 150);
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][8], 1);

	AMOUNTTD[playerid][9] = CreatePlayerTextDraw(playerid, 286.000, 218.000, "10000x");
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][9], 0.119, 0.598);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][9], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][9], 150);
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][9], 1);

	AMOUNTTD[playerid][10] = CreatePlayerTextDraw(playerid, 126.000, 274.000, "10000x");
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][10], 0.119, 0.598);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][10], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][10], 150);
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][10], 1);

	AMOUNTTD[playerid][11] = CreatePlayerTextDraw(playerid, 166.000, 274.000, "10000x");
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][11], 0.119, 0.598);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][11], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][11], -1);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][11], 150);
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][11], 1);

	AMOUNTTD[playerid][12] = CreatePlayerTextDraw(playerid, 206.000, 274.000, "10000x");
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][12], 0.119, 0.598);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][12], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][12], -1);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][12], 0);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][12], 150);
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][12], 1);

	AMOUNTTD[playerid][13] = CreatePlayerTextDraw(playerid, 246.000, 274.000, "10000x");
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][13], 0.119, 0.598);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][13], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][13], -1);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][13], 0);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][13], 150);
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][13], 1);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][13], 1);

	AMOUNTTD[playerid][14] = CreatePlayerTextDraw(playerid, 286.000, 274.000, "10000x");
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][14], 0.119, 0.598);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][14], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][14], -1);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][14], 0);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][14], 150);
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][14], 1);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][14], 1);

	AMOUNTTD[playerid][15] = CreatePlayerTextDraw(playerid, 126.000, 330.000, "10000x");
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][15], 0.119, 0.598);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][15], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][15], -1);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][15], 0);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][15], 150);
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][15], 1);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][15], 1);

	AMOUNTTD[playerid][16] = CreatePlayerTextDraw(playerid, 166.000, 330.000, "10000x");
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][16], 0.119, 0.598);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][16], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][16], -1);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][16], 0);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][16], 150);
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][16], 1);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][16], 1);

	AMOUNTTD[playerid][17] = CreatePlayerTextDraw(playerid, 206.000, 330.000, "10000x");
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][17], 0.119, 0.598);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][17], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][17], -1);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][17], 0);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][17], 0);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][17], 150);
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][17], 1);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][17], 1);

	AMOUNTTD[playerid][18] = CreatePlayerTextDraw(playerid, 246.000, 330.000, "10000x");
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][18], 0.119, 0.598);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][18], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][18], -1);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][18], 0);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][18], 0);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][18], 150);
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][18], 1);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][18], 1);

	AMOUNTTD[playerid][19] = CreatePlayerTextDraw(playerid, 286.000, 330.000, "10000x");
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][19], 0.119, 0.598);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][19], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][19], -1);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][19], 0);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][19], 0);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][19], 150);
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][19], 1);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][19], 1);

	NOTIFBOX[playerid][0] = CreatePlayerTextDraw(playerid, 391.000000, 347.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, NOTIFBOX[playerid][0], 4);
	PlayerTextDrawLetterSize(playerid, NOTIFBOX[playerid][0], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, NOTIFBOX[playerid][0], 43.500000, 47.000000);
	PlayerTextDrawSetOutline(playerid, NOTIFBOX[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, NOTIFBOX[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, NOTIFBOX[playerid][0], 1);
	PlayerTextDrawColor(playerid, NOTIFBOX[playerid][0], 859394047);// TANDA
	PlayerTextDrawBackgroundColor(playerid, NOTIFBOX[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, NOTIFBOX[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, NOTIFBOX[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, NOTIFBOX[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, NOTIFBOX[playerid][0], 0);

	NOTIFBOX[playerid][1] = CreatePlayerTextDraw(playerid, 391.000000, 347.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, NOTIFBOX[playerid][1], 4);
	PlayerTextDrawLetterSize(playerid, NOTIFBOX[playerid][1], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, NOTIFBOX[playerid][1], 43.500000, 47.000000);
	PlayerTextDrawSetOutline(playerid, NOTIFBOX[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, NOTIFBOX[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, NOTIFBOX[playerid][1], 1);
	PlayerTextDrawColor(playerid, NOTIFBOX[playerid][1], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, NOTIFBOX[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, NOTIFBOX[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, NOTIFBOX[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, NOTIFBOX[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, NOTIFBOX[playerid][1], 0);

	NOTIFBOX[playerid][2] = CreatePlayerTextDraw(playerid, 391.000000, 347.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, NOTIFBOX[playerid][2], 4);
	PlayerTextDrawLetterSize(playerid, NOTIFBOX[playerid][2], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, NOTIFBOX[playerid][2], 1.500000, 47.000000);
	PlayerTextDrawSetOutline(playerid, NOTIFBOX[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, NOTIFBOX[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, NOTIFBOX[playerid][2], 1);
	PlayerTextDrawColor(playerid, NOTIFBOX[playerid][2], 1687547391);
	PlayerTextDrawBackgroundColor(playerid, NOTIFBOX[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, NOTIFBOX[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, NOTIFBOX[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, NOTIFBOX[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, NOTIFBOX[playerid][2], 0);

	NOTIFBOX[playerid][3] = CreatePlayerTextDraw(playerid, 394.000000, 386.000000, "NASI GORENG");
	PlayerTextDrawFont(playerid, NOTIFBOX[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, NOTIFBOX[playerid][3], 0.150000, 0.800000);
	PlayerTextDrawTextSize(playerid, NOTIFBOX[playerid][3], 494.500000, 98.500000);
	PlayerTextDrawSetOutline(playerid, NOTIFBOX[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, NOTIFBOX[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, NOTIFBOX[playerid][3], 1);
	PlayerTextDrawColor(playerid, NOTIFBOX[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, NOTIFBOX[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, NOTIFBOX[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, NOTIFBOX[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, NOTIFBOX[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, NOTIFBOX[playerid][3], 0);

	NOTIFBOX[playerid][4] = CreatePlayerTextDraw(playerid, 394.000000, 347.000000, "1X");
	PlayerTextDrawFont(playerid, NOTIFBOX[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, NOTIFBOX[playerid][4], 0.150000, 0.800000);
	PlayerTextDrawTextSize(playerid, NOTIFBOX[playerid][4], 494.500000, 98.500000);
	PlayerTextDrawSetOutline(playerid, NOTIFBOX[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, NOTIFBOX[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, NOTIFBOX[playerid][4], 1);
	PlayerTextDrawColor(playerid, NOTIFBOX[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, NOTIFBOX[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, NOTIFBOX[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, NOTIFBOX[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, NOTIFBOX[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, NOTIFBOX[playerid][4], 0);

	NOTIFBOX[playerid][5] = CreatePlayerTextDraw(playerid, 394.000000, 350.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, NOTIFBOX[playerid][5], 5);
	PlayerTextDrawLetterSize(playerid, NOTIFBOX[playerid][5], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, NOTIFBOX[playerid][5], 35.000000, 38.000000);
	PlayerTextDrawSetOutline(playerid, NOTIFBOX[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, NOTIFBOX[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, NOTIFBOX[playerid][5], 1);
	PlayerTextDrawColor(playerid, NOTIFBOX[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, NOTIFBOX[playerid][5], 0);
	PlayerTextDrawBoxColor(playerid, NOTIFBOX[playerid][5], 255);
	PlayerTextDrawUseBox(playerid, NOTIFBOX[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, NOTIFBOX[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, NOTIFBOX[playerid][5], 0);
	PlayerTextDrawSetPreviewModel(playerid, NOTIFBOX[playerid][5], 1212);
	PlayerTextDrawSetPreviewRot(playerid, NOTIFBOX[playerid][5], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, NOTIFBOX[playerid][5], 1, 1);
	return 1;
}

stock BarangMasuk(playerid)
{
	Inventory_Set(playerid,"Uang", 1212, PlayerInfo[playerid][pCash]);
	Inventory_Set(playerid, "Ayam", 2770, PlayerInfo[playerid][pAyam]);
	Inventory_Set(playerid, "Susu", 19570, PlayerInfo[playerid][pBeruang]);
	Inventory_Set(playerid, "Kopi", 19835, PlayerInfo[playerid][pKopi]);
	Inventory_Set(playerid, "Roti", 19883, PlayerInfo[playerid][pRoti]);
	Inventory_Set(playerid, "Snack", 2821, PlayerInfo[playerid][pSnack]);
	Inventory_Set(playerid, "Metal", 2041, PlayerInfo[playerid][pMetal]);
	Inventory_Set(playerid, "Perban", 11736, PlayerInfo[playerid][pHeals]);
	Inventory_Set(playerid, "Ktp", 1581, PlayerInfo[playerid][pKtp]);
	Inventory_Set(playerid, "Hand_Phone", 18867, PlayerInfo[playerid][pProducts][0]);
	Inventory_Set(playerid, "Mask", 19036, PlayerInfo[playerid][pMask]);
	Inventory_Set(playerid, "Repairkit", 1010, PlayerInfo[playerid][pRepairKit]);
	Inventory_Set(playerid, "GPS", 18874, PlayerInfo[playerid][pGps]);
	Inventory_Set(playerid, "Logam", 1301, PlayerInfo[playerid][pMetall]);
	Inventory_Set(playerid,"Jus", 1546, PlayerInfo[playerid][pJus]);
	Inventory_Set(playerid, "Sampah", 1265, SampahPlayer[playerid]);
	Inventory_Update(playerid);
}

stock Inventory_Update(playerid)
{
	new str[256], string[256], totalall, quantitybar;
	for(new i = 0; i < MAX_INVENTORY; i++)
	{
	    totalall += InventoryData[playerid][i][invTotalQuantity];
		format(str, sizeof(str), "%.1f/850.0", float(totalall));
		PlayerTextDrawSetString(playerid, INVNAME[playerid][4], str);
		quantitybar = totalall * 199/850;
	    PlayerTextDrawTextSize(playerid, INVNAME[playerid][2], quantitybar, 13.0);
		if(InventoryData[playerid][i][invExists])
		{
			//sesuakian dengan object item kalian
			strunpack(string, InventoryData[playerid][i][invItem]);
			format(str, sizeof(str), "%s", string);
			PlayerTextDrawSetString(playerid, NAMETD[playerid][i], str);
			format(str, sizeof(str), "%d", InventoryData[playerid][i][invAmount]);
			PlayerTextDrawSetString(playerid, AMOUNTTD[playerid][i], str);
		}
		else
		{
			PlayerTextDrawHide(playerid, AMOUNTTD[playerid][i]);
			PlayerTextDrawHide(playerid, MODELTD[playerid][i]);
			PlayerTextDrawHide(playerid, NAMETD[playerid][i]);
		}
	}
}

stock MenuStore_SelectRow(playerid, row)
{
	PlayerInfo[playerid][pSelectItem] = row;
    PlayerTextDrawHide(playerid,INDEXTD[playerid][row]);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][row], -7232257);
	PlayerTextDrawShow(playerid,INDEXTD[playerid][row]);
}

stock MenuStore_UnselectRow(playerid)
{
	if(PlayerInfo[playerid][pSelectItem] != -1)
	{
		new row = PlayerInfo[playerid][pSelectItem];
		PlayerTextDrawHide(playerid,INDEXTD[playerid][row]);
		PlayerTextDrawColor(playerid, INDEXTD[playerid][row], 960053503);
		PlayerTextDrawShow(playerid,INDEXTD[playerid][row]);
	}

	PlayerInfo[playerid][pSelectItem] = -1;
}

stock ShowItemBox(playerid, string[], total[], model, time)
{
    new validtime = time*1000;
    PlayerTextDrawSetString(playerid, NOTIFBOX[playerid][4], string);
    PlayerTextDrawSetString(playerid, NOTIFBOX[playerid][3], total);
    PlayerTextDrawSetPreviewModel(playerid, NOTIFBOX[playerid][5], model);
    if(model == 18867)
    {
        PlayerTextDrawSetPreviewRot(playerid, NOTIFBOX[playerid][5], -271.000000, 0.000000, 0.000000, 2.029999);
    }
    else if(model == 2958)
    {
        PlayerTextDrawSetPreviewRot(playerid, NOTIFBOX[playerid][5], 0.000000, 0.000000, -85.000000, 2.029999);
    }
    else if(model == 2703)
    {
        PlayerTextDrawSetPreviewRot(playerid, NOTIFBOX[playerid][5], -80.000000, 0.000000, -12.000000, 2.779998);
    }
    for(new i = 0; i < 6; i++)
    {
        PlayerTextDrawShow(playerid, NOTIFBOX[playerid][i]);
    }
    SetTimerEx("HideItemBox", validtime, false, "d", playerid);
    return 1;
}

publics: HideItemBox(playerid)
{
    for(new i = 0; i < 6; i++)
    {
        PlayerTextDrawHide(playerid, NOTIFBOX[playerid][i]);
    }
    return 1;
}

hook OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)

	for(new i = 0; i < MAX_INVENTORY; i++)
	{
		if(playertextid == MODELTD[playerid][i])
		{
			if(InventoryData[playerid][i][invExists])
			{
			    MenuStore_UnselectRow(playerid);
				MenuStore_SelectRow(playerid, i);
			    new name[48];
            	strunpack(name, InventoryData[playerid][PlayerInfo[playerid][pSelectItem]][invItem]);
			}
		}
	}
	if(playertextid == INVINFO[playerid][2])
	{
		new id = PlayerInfo[playerid][pSelectItem];

		if(id == -1)
		{
		    SendClientMessage(playerid, 0xAFAFAFFF, "ERROR: You aren't selecting any item");
			Inventory_Close(playerid);
		}
		else
		{
			new string[64];
		    strunpack(string, InventoryData[playerid][id][invItem]);

		    if(!PlayerHasItem(playerid, string))
		    {
		   		SendClientMessage(playerid, 0xAFAFAFFF, "ERROR: You don't have any items on you");
                Inventory_Show(playerid);
			}
			else
			{
				CallLocalFunction("OnPlayerUseItem", "dds", playerid, id, string);
			}
		}
	}
	else if(playertextid == INVINFO[playerid][5])
	{
		Inventory_Close(playerid);
	}
	else if(playertextid == INVINFO[playerid][3])
	{
		new id = PlayerInfo[playerid][pSelectItem];

		if(id == -1)
		{
		    SendClientMessage(playerid, 0xAFAFAFFF, "ERROR: You aren't selecting any item");
			Inventory_Close(playerid);
		}
		else
		{
			new string[64];
		    strunpack(string, InventoryData[playerid][id][invItem]);

		    if(!PlayerHasItem(playerid, string))
		    {
		   		SendClientMessage(playerid, 0xAFAFAFFF, "ERROR: You don't have any items on you");
                Inventory_Show(playerid);
			}
			else
			{
				CallLocalFunction("OnPlayerGiveItem", "dds", playerid, id, string);
			}
		}
	}
	
//===== pasang di CMD =====//

CMD:openinv(playerid, params[])
{
    Inventory_Show(playerid);
    return 1;
}