local holdingup = false
local store = ""
local blipryosto = nil
local laatikko = 0 

local laatikkos = {
	{x = 4448.1, y = -4444.9, z = 7.2, heading = 289.41, isOpen = false},
        {x = 4447.1, y = -4442.3, z = 7.2, heading = 294.52, isOpen = false},
        {x = 4436.29, y = -4446.23, z = 4.33, heading = 120.87, isOpen = false},
        {x = 4505.86, y = -4554.82, z = 4.17, heading = 206.01, isOpen = false},
        {x = 4503.49, y = -4555.68, z = 4.17, heading = 200.23, isOpen = false},
        {x = 5064.83, y = -4590.49, z = 2.86, heading = 341.18, isOpen = false},
        {x = 5067.34, y = -4591.46, z = 2.86, heading = 335.89, isOpen = false},
        {x = 5092.61, y = -4683.25, z = 2.41, heading = 249.37, isOpen = false},
        {x = 5092.25, y = -4680.72, z = 2.41, heading = 348.68, isOpen = false},
        {x = 5091.33, y = -4685.08, z = 2.41, heading = 169.33, isOpen = false},
        {x = 5195.98, y = -5133.94, z = 3.36, heading = 259.54, isOpen = false},
        {x = 5195.55, y = -5135.86, z = 3.35, heading = 257.35, isOpen = false},
        {x = 4925.85, y = -5244.16, z = 2.52, heading = 220.34, isOpen = false},
        {x = 4437.59, y = -4445.77, z = 4.33, heading = 294.51, isOpen = false},
        {x = 5330.13, y = -5272.13, z = 33.19, heading = 128.88, isOpen = false},
        {x = 5328.62, y = -5270.17, z = 33.19, heading = 129.18, isOpen = false},
        {x = 5000.66, y = -5165.61, z = 2.76, heading = 288.66, isOpen = false},
        {x = 4999.69, y = -5163.58, z = 2.76, heading = 292.81, isOpen = false},
        {x = 4963.16, y = -5109.25, z = 2.98, heading = 264.34, isOpen = false},
        {x = 4962.6, y = -5107.46, z = 2.98, heading = 346.72, isOpen = false},
        {x = 4960.5, y = -5107.2, z = 2,98, heading = 82.72, isOpen = false},
        {x = 4923.99, y = -5245.35, z = 2.52, heading = 205.28, isOpen = false},
        {x = 5211.62, y = -5126.08, z = 6.21, heading = 281.44, isOpen = false},
        {x = 5211.83, y = -5128.45, z = 6.21, heading = 278.64, isOpen = false},
        {x = 5212.05, y = -5130.95, z = 6.21, heading = 277.69, isOpen = false},

	}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function DrawText3D(x, y, z, text, scale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 215)

	AddTextComponentString(text)
	DrawText(_x, _y)

end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
RegisterNetEvent("mt:missiontext")
AddEventHandler("mt:missiontext", function(text, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time, 1)
end)

RegisterNetEvent('esx_drugheist_ryosto:currentlyrobbing')
AddEventHandler('esx_drugheist_ryosto:currentlyrobbing', function(robb)
	holdingup = true
	store = robb
end)

RegisterNetEvent('esx_drugheist_ryosto:killblip')
AddEventHandler('esx_drugheist_ryosto:killblip', function()
    RemoveBlip(blipryosto)
end)

RegisterNetEvent('esx_drugheist_ryosto:setblip')
AddEventHandler('esx_drugheist_ryosto:setblip', function(position)
    blipryosto = AddBlipForCoord(position.x, position.y, position.z)
    SetBlipSprite(blipryosto , 161)
    SetBlipScale(blipryosto , 2.0)
    SetBlipColour(blipryosto, 4)
    PulseBlip(blipryosto)
end)


RegisterNetEvent('esx_drugheist_ryosto:ryostovalmis')
AddEventHandler('esx_drugheist_ryosto:ryostovalmis', function(robb)
	holdingup = false
	ESX.ShowNotification(_U('ryosto_valmis'))
	store = ""
	incircle = false
end)

Citizen.CreateThread(function()
	for k,v in pairs(Stores)do
		local ve = v.position

		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 140)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('shop_ryosto'))
		EndTextCommandSetBlipName(blip)
	end
end)

animazione = false
incircle = false
soundid = GetSoundId()

function drawTxt(x, y, scale, text, red, green, blue, alpha)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(0.64, 0.64)
	SetTextColour(red, green, blue, alpha)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
    DrawText(0.155, 0.935)
end

local reppu = nil

Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(1000)
	  TriggerEvent('skinchanger:getSkin', function(skin)
		reppu = skin['bags_1']
	  end)
	  Citizen.Wait(1000)
	end
end)

Citizen.CreateThread(function()
      
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(Stores)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if not holdingup then
					DrawMarker(27, v.position.x, v.position.y, v.position.z-0.9, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 255, 0, 0, 200, 0, 0, 0, 0)

					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						if (incircle == false) then
							DisplayHelpText(_U('press_to_rob'))
						end
						incircle = true
						if IsPedShooting(GetPlayerPed(-1)) then
                                                if Config.treppu then
							    if reppu == 40 or reppu == 41 or reppu == 44 or reppu == 45 then
							        ESX.TriggerServerCallback('esx_drugheist_ryosto:aloitus', function(CopsConnected)
								        if CopsConnected >= Config.RequiredCopsRob then
							                TriggerServerEvent('esx_drugheist_ryosto:rob', k)
										else
									        TriggerEvent('esx:showNotification', _U('min_two_police') .. Config.RequiredCopsRob .. _U('min_two_police2'))
								        end
							        end)		
						        else
							        TriggerEvent('esx:showNotification', _U('need_bag'))
								end
							else
								ESX.TriggerServerCallback('esx_drugheist_ryosto:aloitus', function(CopsConnected)
									if CopsConnected >= Config.RequiredCopsRob then
										TriggerServerEvent('esx_drugheist_ryosto:rob', k)
									else
										TriggerEvent('esx:showNotification', _U('min_two_police') .. Config.RequiredCopsRob .. _U('min_two_police2'))
									end
								end)	
							end	
                        end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
						incircle = false
					end		
				end
			end
		end
		if holdingup then
			drawTxt(0.3, 1.4, 0.45, _U('tlaatikko') .. ' :~r~ ' .. laatikko .. '/' .. Config.Maxlaatikko, 185, 185, 185, 255)

			for i,v in pairs(laatikkos) do 
				if(GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 10.0) and not v.isOpen and Config.EnableMarker then 
					DrawMarker(20, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 0.6, 0.6, 0.6, 0, 255, 0, 200, 1, 1, 0, 0)
				end
				if(GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 0.75) and not v.isOpen then 
					DrawText3D(v.x, v.y, v.z, '~w~[~g~E~w~] ' .. _U('press_to_collect'), 0.6)
					if IsControlJustPressed(0, 38) then
						animazione = true
					    SetEntityCoords(GetPlayerPed(-1), v.x, v.y, v.z-0.95)
					    SetEntityHeading(GetPlayerPed(-1), v.heading)
						v.isOpen = true 
                                            ExecuteCommand("e mechanic4")
					    TriggerEvent("mt:missiontext", _U('collectinprogress'), 3000)
					    DrawSubtitleTimed(5000, 1)
					    Citizen.Wait(5000)
					    ClearPedTasksImmediately(GetPlayerPed(-1))
					    TriggerServerEvent('esx_drugheist_ryosto:saalis')
					    PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					    laatikko = laatikko+1
					    animazione = false

						if laatikko == Config.Maxlaatikko then 
						    for i,v in pairs(laatikkos) do 
								v.isOpen = false
								laatikko = 0
							end
							TriggerServerEvent('esx_drugheist_ryosto:endrob', store)
						    holdingup = false
						    StopSound(soundid)
						end
					end
				end	
			end
local pos2 = Stores[store].position

					end

		Citizen.Wait(0)
	end
end)

