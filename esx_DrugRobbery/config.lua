Config = {}

Config.Locale = 'fi' -- locale there is fi.lua but you can do your own if you want :)
-- Blip
Config.useblip = true -- Use blip
Config.blipSprite = 140 -- Change if you want (blips )
Config.blipScale = 0.8 -- Change if you want (size of blip)
Config.blipColour = 2 -- Change if you want (Colour of blip)
Config.useblip2 = true 

-- Discord logs
Config.webhook = 'https://discord.com/api/webhooks/987082303102681158/PCyNmO6aSGg73n77I2XK4BrCW9kcRi6eZDfWdWinIRpY-exwQYgo1GqNZ740CA1CjiS3' -- Your dc webhook
Config.botname = 'ValorRp' -- bots name
-- Backback
Config.treppu = false -- true if need bag false if dont need bag
Config.reppu = {40, 41, 44, 45} -- bags numbers

Config.RequiredCopsRob = 0 -- police needed for robbery
-- Item Amounts
Config.MinHuume = 2 -- min drug
Config.MaxHuume = 6 -- Max drug

Config.tavara1 = 'coke' -- Item 1
Config.tavara2 = 'amfe_pooch' -- Item 2
Config.tavara3 = 'amfe' -- Item 3
Config.tavara4 = 'cannabis' -- Item 4
Config.tavara5 = 'marijuana' -- Item 5
Config.tavara6 = 'coke_pooch' -- Item 6
Config.tavara7 = 'Opium' -- Item 7
-- If you want to add items or delete items you have to go to Server/sv_esx_drugheist.lua and goto line 110-116 and if you want to add new item you have to put Config.tavara8 and put it also in config.lua. If you want delete items just delete those lines :)


Config.tyo = 'police' -- Job who get an alarm
-- Command
Config.komento = "lopeta" -- Command what stop robbery
Config.animaatio = true -- use animation when do command

Config.SecBetwNextRob = 3600 --1 hour

Config.EnableMarker = true

Stores = {
	["Saari"] = {
		position = { ['x'] = 4428.2, ['y'] = -4451.7, ['z'] = 7.2 },       
		nimi = "Saari", -- Name
		lastrobbed = 0
	}
}






-- Sry for bad english i hope you understand my dog water english - Bubsi :D
