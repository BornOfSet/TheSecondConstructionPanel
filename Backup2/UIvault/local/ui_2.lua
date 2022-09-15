----soies overwritten----外部导入重要操作符
local CreateWindow = import('/lua/maui/window.lua').Window
local CreateBitmap = import('/lua/maui/bitmap.lua').Bitmap
local LayoutHelpers = import('/lua/maui/layouthelpers.lua')
local CreateSpecialGrid = import('/lua/ui/controls/specialgrid.lua').SpecialGrid
local UIFile = import('/lua/ui/uiutil.lua').UIFile

----local(objects)----
local UI
local existed = {}

----local(directory)----
local path = '/mods/UIvault/local/ui_1/'

----local(sources)----
local function SetIconTextures(ui, id)
	local location = '/icons/units/' .. id .. '_icon.dds'
	if DiskGetFileInfo(UIFile(location, true)) then --这个true代表同样寻找mod内容
		ui:SetTexture(UIFile(location, true)) --主要图标
	else
		ui:SetTexture(UIFile('/icons/units/default_icon.dds')) --设为蓝色默认
	end
	--没有战略图标
end

local function arrayPosition(Position, existed, parent) --不知道为什么它捕获不到我在该函数执行前就定义的Position
	if existed[1] then
		return existed[2]
	else
		local pos = {}
		for k,v in Position do
			pos[k] = parent[k][1] --另存为 注意：Pos.k指的是值为"k"的字符串作为key
		end
		--increasedBorder(pos , -1) --收缩不扩张，绝对会造成排版错误
		pos.Height = pos.Top - pos.Bottom
		pos.Width = pos.Right - pos.Left --计算整体步长
		existed[4] = pos.Left
		existed[1] = true
		return pos --返回副本
	end
end

local function array(pos, total, Image, existed) --所以，在这里我也要额外传入Image和firsttime
	if existed[3] then
		pos.Height = pos.Height / total --计算离散步长
		pos.Width = pos.Width / total
		existed[3] = false --必须从值传递改成引用传递
	end
	local right = pos.Left + pos.Width --重新定义终点边界
	local bottom = pos.Top - pos.Height
	Image.Top:Set(pos.Top) --应用当前缓存
	Image.Bottom:Set(bottom)
	Image.Left:Set(pos.Left)
	Image.Right:Set(right)
	--重新定义起始边界
	if right > pos.Right then
		right = existed[4]
		pos.Top = bottom
	end
	pos.Left = right
	return pos
end

local function linkup(pos, existed)
	existed[2] = pos
end

local function increasedBorder(ui, scale) --这是一个杂项，并不发挥主要作用，但因为傻逼的编译机制，我只能把它放在arrayPosition之前 --之前用来减小图标大小，所以不放在现在的位置，而是在前面
	ui.Top:Set(ui.Top[1] - scale - 15)
	ui.Left:Set(ui.Left[1] - scale + 5)
	ui.Right:Set(ui.Right[1] + scale + 20)
	ui.Bottom:Set(ui.Bottom[1] + scale + 15)
end

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
UI = CreateWindow(GetFrame(0),'Slot',nil,false,false,false,false,'VAULT_ui_2',Position,Border)
for i, v in Position do --重置位置
	UI[i]:Set(v)
end
UI.Images = {} --初始化内嵌图标

UI._closeBtn.OnClick = function(control)
	for k,v in UI.Images do
		if k and v then v:Destroy() end --消灭原来的图标。单纯地设为nil只是除掉了引用，但不影响它们继续存在
	end
	local data = EntityCategoryGetUnitList(categories.TECH2)  --这个行动访问所有已经被加载了的蓝图，并且返回typeclass名称如xsl0001等
	local x = table.getn(data)
	existed[3] = true
	for c,id in data do
		UI.Images[c] = CreateBitmap(UI,path .. 'sese.jpg')
		linkup(array(arrayPosition(Position,existed,UI),math.sqrt(x),UI.Images[c],existed),existed)
		SetIconTextures(UI.Images[c],id) --只有bitmap才有settexture功能
	end
	increasedBorder(UI,15)
	existed = {}
end