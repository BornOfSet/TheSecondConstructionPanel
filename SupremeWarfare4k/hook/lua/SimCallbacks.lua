----
---- I put those complicated hook stuff in dedicated folders so it won't ruin the simplicity of my ui codes
----
----TODO : group command
----TODO : BoxFormationSpawn
----
----
----
----
----
Callbacks.TheSecondConstructionPanel = function(data, units)
	local id = data.id
	IssueBuildMobile(units,units[1]:GetPosition(),id,{}) --不符合当前科技等级和阵营等工程师属性字段的单位无法建造
end
