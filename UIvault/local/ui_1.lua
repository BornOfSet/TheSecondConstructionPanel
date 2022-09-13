----
----NOTICE : This file is unnecessary for the gameplay . It creates a window in game with a picture of a cosplay girl , and what I want to stress is that this is implemented through severl lines of really tidy and simple codes after a hard cultivation. I left it here in order to tell you how to quickly create a simple window
----NOTICE : 这个文件其实没啥用。它把Misa呆呆的照片贴在游戏UI里。我觉得这个文件有价值的地方在于，经过我辛苦研究（恬不知耻地划重点），我最终得以用几行十分简单的代码来生成这一可以拖拽，放大缩小的窗口，主要还是得益于游戏Window.lua这一文件里定义的黑箱，我把这个文件留在这里的意义就是让有兴趣的人参考它是如何实现的。我他妈英语差的批爆，只会说EEEEEEEEE。
----The defines of relative functions can be found in the paths shown.
----
----objects----
local UI
local Image

----directory----
local path = '/mods/UIvault/local/ui_1/'

----significant operators imported from external sources----
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
