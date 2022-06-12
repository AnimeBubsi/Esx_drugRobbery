local rob = false
local robbers = {}
PlayersCrafting    = {}
local CopsConnected  = 0
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == Config.tyo then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountCops)
end

CountCops()

RegisterCommand(Config.komento, function(source)
TriggerClientEvent('esx_drugheist:loppu', source)
 end)

RegisterServerEvent('esx_drugheist_ryosto:endrob')
AddEventHandler('esx_drugheist_ryosto:endrob', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == Config.tyo then
			TriggerClientEvent('esx:showNotification', xPlayers[i], _U('end'))
			TriggerClientEvent('esx_drugheist_ryosto:killblip', xPlayers[i])
		end
	end
	if(robbers[source])then
		TriggerClientEvent('esx_drugheist_ryosto:ryostocomplete', source)
		robbers[source] = nil
		TriggerClientEvent('esx:showNotification', source, _U('ryosto_has_ended') .. Stores[robb].nimi)
	end
end)

RegisterServerEvent('esx_drugheist_ryosto:lopetus')
AddEventHandler('esx_drugheist_ryosto:lopetus', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == Config.tyo then
			TriggerClientEvent('esx:showNotification', xPlayers[i], _U('ryosto_cancelled'))
			TriggerClientEvent('esx_drugheist_ryosto:killblip', xPlayers[i])
		end
	end
end)

RegisterServerEvent('esx_drugheist_ryosto:rob')
AddEventHandler('esx_drugheist_ryosto:rob', function(robb)

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	if Stores[robb] then

		local store = Stores[robb]

		if (os.time() - store.lastrobbed) < Config.SecBetwNextRob and store.lastrobbed ~= 0 then

            TriggerClientEvent('esx_drugheist_ryosto:togliblip', source)
			TriggerClientEvent('esx:showNotification', source, _U('already_robbed') .. (Config.SecBetwNextRob - (os.time() - store.lastrobbed)) .. _U('seconds'))
			return
		end

		if rob == false then

			rob = true
			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				if xPlayer.job.name == Config.tyo then
					TriggerClientEvent('esx:showNotification', xPlayers[i], _U('rob_in_prog') .. store.nimi)
					TriggerClientEvent('esx_drugheist_ryosto:setblip', xPlayers[i], Stores[robb].position)
                                        TriggerClientEvent('esx:showNotification', source, _U('Poliisi'))
				end
			end

			TriggerClientEvent('esx:showNotification', source, _U('started_to_rob') .. store.nimi .. _U('do_not_move'))
			TriggerClientEvent('esx:showNotification', source, _U('hold_pos'))
			TriggerClientEvent('esx_drugheist_ryosto:currentlyrobbing', source, robb)
            CancelEvent()
			Stores[robb].lastrobbed = os.time()
		else
			TriggerClientEvent('esx:showNotification', source, _U('ryosto_already'))
		end
	end
end)

Items = {
  Config.tavara1,
  Config.tavara,
  Config.tavara3,
  Config.tavara4,
  Config.tavara5,
  Config.tavara6,
  Config.tavara7
}

function RandomItem()
  return Items[math.random(#Items)]
end

function RandomNumber()
	return math.random(Config.MinHuume, Config.MaxHuume)
end

RegisterServerEvent('esx_drugheist_ryosto:saalis')
AddEventHandler('esx_drugheist_ryosto:saalis', function()
  local xPlayer = ESX.GetPlayerFromId(source)
  math.randomseed(GetGameTimer())
  xPlayer.addInventoryItem(RandomItem(), RandomNumber())
end)
ESX.RegisterServerCallback('esx_drugheist_ryosto:aloitus', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(CopsConnected)
end)
