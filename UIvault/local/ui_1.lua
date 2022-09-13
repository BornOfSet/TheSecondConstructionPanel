----local(objects)----
local UI
local Image

----local(directory)----
local path = '/mods/UIvault/local/ui_1/'

----soies overwritten----
local CreateWindow = import('/lua/maui/window.lua').Window
local CreateBitmap = import('/lua/maui/bitmap.lua').Bitmap
local LayoutHelpers = import('/lua/maui/layouthelpers.lua')

----parameters----
local Border = {
    tl = path .. 'mini-map_brd_ul.dds',
    tr = path .. 'mini-map_brd_ur.dds',
    tm = path .. 'mini-map_brd_horz_um.dds',     
	ml = path .. 'mini-map_brd_vert_l.dds',
    m = path .. 'mini-map_brd_m.dds',
    mr = path .. 'mini-map_brd_vert_r.dds',
    bl = path .. 'mini-map_brd_ll.dds',
    bm = path .. 'mini-map_brd_lm.dds',
    br = path .. 'mini-map_brd_lr.dds',
    borderColor = 'ff099950',
}
	
local Position = {
	Left = 50, 
	Top = 180, 
	Bottom = 360, 
	Right = 240
}
   
----actions----
UI = CreateWindow(GetFrame(0),'Caption',nil,false,false,false,false,'VAULT_ui_1',Position,Border)
Image = CreateBitmap(UI,path .. 'sese.jpg')
LayoutHelpers.FillParent(Image,UI:GetClientGroup())