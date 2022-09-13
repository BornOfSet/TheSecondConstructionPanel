----
----
----
----
----
----
----
----
----
----
Callbacks.TheSecondConstructionPanel = function(data, units)
	local id = data.id
	IssueBuildMobile(units,units[1]:GetPosition(),id,{}) --不符合当前科技等级和阵营等工程师属性字段的单位无法建造
end