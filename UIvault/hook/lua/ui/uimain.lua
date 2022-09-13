local background = StartGameUI
StartGameUI = function()
	background()
	doscript('/mods/UIvault/local/localization.lua')
end
--I'd like to see a clean and tidy code layout . I hate hooking too much into the og game files , because I have OCD XD
--Don't change this hook to uimain.lua . Uimain.lua is made by game and lobby , however , it's only in the game that GetFrame() works
