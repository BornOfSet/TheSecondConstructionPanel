----***************************
--Localization means 'localizing the hook entrance to mod folder's local codes'
--本地化就是说，本来这些代码都是跑在hook文件夹中的，或者，按道理来说，是应该运行在hook当中的。Hook相当于游戏本体，在游戏本体之外的地方写代码，假如没有东西去调用它们，它们又怎么跑得起来呢？这就是我的思路，所以我在hook中指出，要运行localization，这样我在mod中定义的本地文件才能工作
--当然，这不是必要的，只是为了满足我的强迫症和中二病罢了。你完全可以在hook中写下所有文件，但我觉得这样把负责不同方面的代码揉在一起，很不直观，所以我拆开来，这样也利于看懂MOD结构
--
local path = '/mods/UIvault/local/'
-- doscript(path .. 'ui_1.lua')
-- doscript(path .. 'ui_2.lua')
doscript(path .. 'ui_3.lua')
--doscript(path .. 'ui_4.lua')
