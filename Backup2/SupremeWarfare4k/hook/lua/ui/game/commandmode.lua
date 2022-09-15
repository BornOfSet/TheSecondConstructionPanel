----
local legacy = OnCommandIssued --hook to the og codes 


----
local function PassNextClickTargetPos(command) --我懒得去思考能不能通过全局定义将它放在调用点后面了
	SimCallback({
        Func = 'GetClickLocation',
        Args = {
            pos = command.Target.Position,
        }
    }, false)
end

----

OnCommandIssued = function(command) --the og codes
	legacy(command)
	PassNextClickTargetPos(command) --This is not the same as mouseposition
end

