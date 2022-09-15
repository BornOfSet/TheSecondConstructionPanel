----
----
----
----
local clicklocationtemp = {}   
----
----
----
----
----
----
Callbacks.TheSecondConstructionPanel = function(data, units)
	local id = data.id
	if not clicklocationtemp[1] then
		return
	end
	for k,v in units do
		IssueBuildMobile({v},clicklocationtemp[1],id,{}) --不符合当前科技等级和阵营等工程师属性字段的单位无法建造
		--Thank you for expanding my brain XD --Although it looks like they're going to build units for each individual of them , in fact the buildings at the same location would be calculated as a single one , and thus they're synced in co-constructing
	end
	clicklocationtemp[1] = nil
	--IssueBuildFactory(units , id , 1) --这个命令同样对移动单位生效，尽管它们很可能没有相关的骨骼，但单位是直接创建在它们所处位置的，且不执行关于footprint的判断，所以单位可以重合，ACU不用走开，围墙可以造在质量矿上，海军工厂也可以造在陆地上。指令列表处理是游戏引擎内嵌的，这个函数包括挂起当前建造指令，直到单位停止移动为止；若当前地方已经有单位，挂起该进程直到单位离开
	--它其实就是小胖的逻辑，因此，小胖“移动中建造”和“移动不撤销建造指令”是不可能做到的，理论上，这很简单，只要在函数里面添加一个判断机制就行，但实际上，你无法访问其中的原理
end



Callbacks.GetClickLocation = function(data)
	local location = data.pos
	clicklocationtemp[1] = location
end