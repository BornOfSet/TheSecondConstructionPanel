----soies overwritten----外部导入重要操作符
local CreateWindow = import('/lua/maui/window.lua').Window
local Button = import('/lua/maui/button.lua').Button
local UIFile = import('/lua/ui/uiutil.lua').UIFile

local CreateButton = Class(Button){

    IconTextures = function(self, texture, path)
		self:SetTexture(texture) --Bitmap.__init(self, parent, normal) --按钮类在初始化实例时访问位图类（它的父级）并调用其设置纹理的函数来为其（子级）设置实例（self）的纹理
        --事实上，即使没有该位图纹理，在按钮处理鼠标悬浮和点击事件时，只要对应插槽有纹理，那就会自动补齐缺少的纹理。当然，前提是，该按钮的深度没有被阻挡。笑死，这个BUG想了我半天，绷不住了
		self.mNormal = texture
        self.mActive = path .. 'dk.jpg'
        self.mHighlight = path .. 'hl.jpg'
        self.mDisabled = texture
		self.Depth:Set(10) --被窗口遮挡的情况下按钮无法响应鼠标
    end,
	
	OnClick = function(self, modifiers) --它是一个父级函数，因为显而易见地，我们没有给任何self定义存在.OnCLick字段。它由self调用，并且将self作为变量输入，实则是从元表中找到该函数，并且将自身输入给它
		local selection = GetSelectedUnits()
		if selection then --当不选中任何单位时，这里返回Nil
			local engs = EntityCategoryFilterDown(categories.ENGINEER,selection) --当不选中任何工程单位时，这里返回{}
			if engs[1] then
				SimCallback({Func = 'TheSecondConstructionPanel',Args = {id = self.correspondedID}},true) --Call which one ? Pass what ? Pass the selected ones ?
			end			
			
			-- LOG(categories.ENGINEER) --INFO: userdata: EntityCategory at 187ADE10 = EntityCategory at 0x187ADE10
			-- LOG(engs) --INFO: table: 1E856988
			-- for k,v in engs do --INFO: 1\000table: 1D72BAA0 --INFO: 2\000table: 15611CF8
				-- LOG(k,v)
			-- end			
			
		end
	end
}

----local(objects)----
local UI
local existed = {}

----local(directory)----
local path = '/mods/UIvault/local/ui_4/'

----local(sources)----
local function SetBtnTextures(ui, id)
	local location = '/icons/units/' .. id .. '_icon.dds'
	ui:IconTextures(UIFile(location, true),path) --优先级问题，需要给定path。我觉得不定义成局部变量可以解决该问题，反正文件全局环境也不共用不是吗？但我想它看起来更工整，我是强迫症
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
UI = CreateWindow(GetFrame(0),'Game',nil,false,false,false,false,'VAULT_ui_3',Position,Border)
for i, v in Position do --重置位置
	UI[i]:Set(v)
end
UI.Images = {} --初始化内嵌图标

UI._closeBtn.OnClick = function(control)
	for k,v in UI.Images do
		if k and v then v:Destroy() end --消灭原来的图标。单纯地设为nil只是除掉了引用，但不影响它们继续存在
	end
	local data = EntityCategoryGetUnitList(categories.TECH1 * categories.AEON)  --这个行动访问所有已经被加载了的蓝图，并且返回typeclass名称如xsl0001等
	local x = table.getn(data)
	x = math.sqrt(x) --横纵均匀排布
	existed[3] = true
	for c,id in data do
		UI.Images[c] = CreateButton(UI) --错过唯一自动设置纹理的机会，需要往后手动设置
		linkup(array(arrayPosition(Position,existed,UI),x,UI.Images[c],existed),existed) --排版
		SetBtnTextures(UI.Images[c],id) --手动设置纹理
		UI.Images[c].correspondedID = id
	end
	increasedBorder(UI,15)
	existed = {}
end