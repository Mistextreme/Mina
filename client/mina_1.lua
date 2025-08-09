ESX = exports['es_extended']:getPasTROSharedObject()

local PlayerData = {}
local JobStarted = false
local Level = 1
local Pickaxe = 1
local Experience = 0
local firsthelp = false
local Login = false
local ClientRocks = {}
local spawnedRocks = 0
local Objects = {}
local has_pickaxe = false
local mineActive = false
local isMining = false
local isPointInside = false
local en_punto = isPointInside
local StartJobPed = {}
local targetList = {}
local Blips = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
	CreateBossBlip(true)
	Login = true
end)

function CreateBossBlip(type)
	if type then
		RemoveBlip(StartJobBlip)
		StartJobBlip = AddBlipForCoord(Config.miner['BossSpawn'].Pos.x, Config.miner['BossSpawn'].Pos.y, Config.miner['BossSpawn'].Pos.z)
		
		SetBlipSprite (StartJobBlip, 408)
		SetBlipDisplay(StartJobBlip, 4)
		SetBlipScale  (StartJobBlip, 0.8)
		SetBlipColour (StartJobBlip, 0)
		SetBlipAsShortRange(StartJobBlip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Miner Work')
		EndTextCommandSetBlipName(StartJobBlip)

		RemoveBlip(StartJobBlip2)
		StartJobBlip2 = AddBlipForCoord(Config.miner['BossSpawn2'].Pos.x, Config.miner['BossSpawn2'].Pos.y, Config.miner['BossSpawn2'].Pos.z)
		
		SetBlipSprite (StartJobBlip2, 408)
		SetBlipDisplay(StartJobBlip2, 4)
		SetBlipScale  (StartJobBlip2, 0.8)
		SetBlipColour (StartJobBlip2, 0)
		SetBlipAsShortRange(StartJobBlip2, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Miner Work')
		EndTextCommandSetBlipName(StartJobBlip2)
	else
		RemoveBlip(StartJobBlip)
		RemoveBlip(StartJobBlip2)
	end
end




lib.registerContext({
	id = 'menu_inicial',
	title = 'Minería',
	options = {
		{
			title = 'Empezar a minar',
			description = 'Empezar a miar',
			arrow = true,
			event = 'miner_zet:entrar',
			args = {value1 = 'enter'}
		},
		{
			title = 'Dejar de minar',
			description = 'Dejar de miar',
			arrow = true,
			event = 'miner_zet:salir',
			args = {value1 = 'salir'}
		}
	},
})


RegisterNetEvent('miner_zet:entrar')
AddEventHandler('miner_zet:entrar', function(mina)
	JobStarted = true
	exports['okokNotify']:Alert("Minero","Buena suerte!", 5000, 'info')
	local skill = exports.OT_skills:getSkill('mining')
	print(skill.level)
	print(skill.xp)
	for mina,y in pairs(Config.MineZones) do

	
		if skill.level >= Config.MineZones[mina].level then
			MineBlip = AddBlipForCoord(Config.MineZones[mina].coords.x, Config.MineZones[mina].coords.y, Config.MineZones[mina].coords.z)
			SetBlipSprite(MineBlip, Config.MineZones[mina].Blip.type)
			SetBlipDisplay(MineBlip, 4)
			SetBlipScale  (MineBlip, 0.8)
			SetBlipColour (MineBlip, Config.MineZones[mina].Blip.color)
			SetBlipAsShortRange(MineBlip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.MineZones[mina].name)
			EndTextCommandSetBlipName(MineBlip)
			table.insert(Blips, MineBlip)
			print(MineBlip)
			-- print()
			StartMining(mina)
		end
	end
end)

RegisterNetEvent('miner_zet:salir')
AddEventHandler('miner_zet:salir', function(mina)
	exports['okokNotify']:Alert("Minero","Buen trabajo, hasta la próxima!", 5000, 'info')
	for blip,h in pairs(Blips) do
		print(h)
		JobStarted = false
		RemoveBlip(h)
		Blips[h] = nil
	end
end)

Target_start = function(StartJobPed)
    -- print(isMining)

    local startJobOpt = {{
        name = 'ox:option1',
        icon = 'fa-solid fa-hammer',
        label = 'Hablar',
        onSelect = function(data)
			lib.showContext('menu_inicial')

        end 
    }}
    exports.ox_target:addLocalEntity(StartJobPed, startJobOpt)
end


Citizen.CreateThread(function()
	if not Config.jobrequirement then
		CreateBossBlip(true)
	end
	local ped_hash = GetHashKey(Config.miner['BossSpawn'].Type)
	RequestModel(ped_hash)
	while not HasModelLoaded(ped_hash) do
		Citizen.Wait(1)
	end	
	BossNPC = CreatePed(1, ped_hash, Config.miner['BossSpawn'].Pos.x, Config.miner['BossSpawn'].Pos.y, Config.miner['BossSpawn'].Pos.z-1, Config.miner['BossSpawn'].Pos.h, false, true)
	SetBlockingOfNonTemporaryEvents(BossNPC, true)
	SetPedDiesWhenInjured(BossNPC, false)
	SetPedCanPlayAmbientAnims(BossNPC, true)
	SetPedCanRagdollFromPlayerImpact(BossNPC, false)
	SetEntityInvincible(BossNPC, true)
	FreezeEntityPosition(BossNPC, true)

	local ped_hash = GetHashKey(Config.miner['BossSpawn2'].Type)
	RequestModel(ped_hash)


	PickaxeObjectNPC = CreateObject(GetHashKey('prop_tool_pickaxe'), Config.miner['BossSpawn'].Pos.x, Config.miner['BossSpawn'].Pos.y, Config.miner['BossSpawn'].Pos.z, true, true, true)
	SetEntityCollision(PickaxeObjectNPC , false)
	AttachEntityToEntity(PickaxeObjectNPC, BossNPC, GetPedBoneIndex(BossNPC, 57005), 0.15, 0.05, 0.0, -65.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
	
	while not HasModelLoaded(ped_hash) do
		Citizen.Wait(1)
	end	
	BossNPC2 = CreatePed(1, ped_hash, Config.miner['BossSpawn2'].Pos.x, Config.miner['BossSpawn2'].Pos.y, Config.miner['BossSpawn2'].Pos.z-1, Config.miner['BossSpawn2'].Pos.h, false, true)
	SetBlockingOfNonTemporaryEvents(BossNPC2, true)
	SetPedDiesWhenInjured(BossNPC2, false)
	SetPedCanPlayAmbientAnims(BossNPC2, true)
	SetPedCanRagdollFromPlayerImpact(BossNPC2, false)
	SetEntityInvincible(BossNPC2, true)
	FreezeEntityPosition(BossNPC2, true)

	PickaxeObjectNPC = CreateObject(GetHashKey('prop_tool_pickaxe'), Config.miner['BossSpawn2'].Pos.x, Config.miner['BossSpawn2'].Pos.y, Config.miner['BossSpawn2'].Pos.z, true, true, true)
	SetEntityCollision(PickaxeObjectNPC , false)
	AttachEntityToEntity(PickaxeObjectNPC, BossNPC2, GetPedBoneIndex(BossNPC, 57005), 0.15, 0.05, 0.0, -65.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)

	StartJobPed = {BossNPC, BossNPC2}

	Target_start(StartJobPed)
	
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(ClientRocks) do
			ESX.Game.DeleteObject(v)
		end
	end
end)
function StartSpawn(mina)
    CreateThread(function()
        while true do
            Wait(700)
            local coords = GetEntityCoords(PlayerPedId())
    
            if #(coords - Config.MineZones[mina].coords) < 50 then
                SpawnRocks(mina)
            end
        end
    end)
end

RegisterNetEvent("miner_zet:progressBar", function(time, data, animation, props, mina)
    if lib.progressCircle({
      duration = time,
      label = 'Minando...',
      disable = {move = true},
      position = 'bottom',
      anim = animation,
      prop = props,
    }) 
    then 
        local ped = PlayerPedId()
        ClearPedTasks(ped)
        DeleteEntity(data.entity)

        spawnedRocks = spawnedRocks - 1
        StartSpawn(mina)

        TriggerEvent('miner_zet:sound', 'breakrock', 0.3)
        isMining = false

        mineActive = false

        local coords = GetEntityCoords(ped)

        local rock1 = CreateObject(GetHashKey('prop_rock_5_smash3'), coords.x+0.3, coords.y+0.1, coords.z, true, true, true)
        local rock2 = CreateObject(GetHashKey('prop_rock_5_smash3'), coords.x-0.5, coords.y-0.3, coords.z, true, true, true)
        local rock3 = CreateObject(GetHashKey('prop_rock_5_smash3'), coords.x+0.3, coords.y-0.4, coords.z, true, true, true)

        SetEntityCollision(rock1, false)
        SetEntityCollision(rock2, false)
        SetEntityCollision(rock3, false)

        PlaceObjectOnGroundProperly(rock1)
        PlaceObjectOnGroundProperly(rock2)
        PlaceObjectOnGroundProperly(rock3)

        FreezeEntityPosition(rock1, true)
        FreezeEntityPosition(rock2, true)
        FreezeEntityPosition(rock3, true)

        objectCoords1 = GetEntityCoords(rock1) 
        objectCoords2 = GetEntityCoords(rock2) 
        objectCoords3 = GetEntityCoords(rock3) 

        local done = 0

        while true do
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
                if objectCoords1 and (GetDistanceBetweenCoords(coords,objectCoords1.x, objectCoords1.y, objectCoords1.z, false) < 0.5) then	
                    DrawText3Ds(objectCoords1.x, objectCoords1.y, objectCoords1.z, 'Presiona [~r~E~w~] para recoger el material')
                    if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
                        done = done + 1
                        objectCoords1 = nil
                        DeleteEntity(rock1)
                        TriggerServerEvent('miner_zet:mine', mina)
                    end
                elseif objectCoords2 and (GetDistanceBetweenCoords(coords,objectCoords2.x, objectCoords2.y, objectCoords2.z, false) < 0.5) then
                    DrawText3Ds(objectCoords2.x, objectCoords2.y, objectCoords2.z, 'Presiona [~r~E~w~] para recoger el material')
                    if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
                        done = done + 1
                        objectCoords2 = nil
                        DeleteEntity(rock2)
                        TriggerServerEvent('miner_zet:mine', mina)
                    end
                elseif objectCoords3 and (GetDistanceBetweenCoords(coords,objectCoords3.x, objectCoords3.y, objectCoords3.z, false) < 0.5) then
                    DrawText3Ds(objectCoords3.x, objectCoords3.y, objectCoords3.z, 'Presiona [~r~E~w~] para recoger el material')
                    if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
                        done = done + 1
                        objectCoords3 = nil
                        DeleteEntity(rock3)
                        TriggerServerEvent('miner_zet:mine', mina)
                    end
                end
                if done == 3 then
                    if not firsthelp then
						exports['okokNotify']:Alert("Minero","Con estos materiales puedes ir a la fundición y conseguir los minerales procesados!", 5000, 'info')
                        -- exports.pNotify:SendNotification({text = "<b>Boss</b></br>You can sell the materials by going to the man who holds the stone", timeout = 4500})
                        firsthelp = true
                    end
                    break
                end
            
            Citizen.Wait(0)
        end
    end
end)



local rockNames = {'prop_rock_2_a'}

CreateTargets = function(mina)
    -- print(isMining)
    local rockOptions = {{
        name = 'ox:option1',
        icon = 'fa-solid fa-hammer',
        label = 'Minar roca',
        onSelect = function(data)
        if isMining then return end 
        isMining = true
        -- print(isMining)
        TriggerServerEvent("miner_zet:mineRock", data, mina)
        end 
    }}
    local target = exports.ox_target:addModel(rockNames, rockOptions)
	table.insert(targetList, target)
end


function SpawnRocks(mina)
	while spawnedRocks < 25 do
        if en_punto then
            Wait(0)
            local rocasCoords = GenerateRockCoords(mina)
            local rock = CreateObject(GetHashKey('prop_rock_2_a'), rocasCoords, false)
            SetEntityHeading(rock, math.random(1,360) + 0.0)
            FreezeEntityPosition(rock, true)
            table.insert(ClientRocks, rock)

            spawnedRocks = spawnedRocks + 1
        else
            break
        end
	end
end

function StartMining(mina)
    -- for mina,y in pairs(Config.MineZones) do
        print(mina)

        -- local time = cfg[1].Time
	if JobStarted then
        local mina_loc = CircleZone:Create(Config.MineZones[mina].coords, Config.MineZones[mina].radius, {
            name= Config.MineZones[mina].name,
            useZ=true,
            debugPoly=false
          })
          mina_loc:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
            en_punto = isPointInside
            if isPointInside then
            StartSpawn(mina)
            CreateTargets(mina)
            print('dentro')
			if Config.MineZones[mina].zona == "mina_cueva" then
				exports['okokNotify']:Alert("Minero","Ve con cuidado, hay deslizamientos últimamente, asegúrate de que tu pico esté en buen estado para poder salir!", 5000, 'info')
			end
            else
                print('fuera')
				removeTargets()
                DeleteRock()
            end
        end)
	end
        
    -- end
end

removeTargets = function()
	for k,v in pairs(targetList) do 
		exports.ox_target:removeZone(v)
		targetList[k] = nil
	end
end

function DeleteRock()
    while spawnedRocks > 0 do
        if not en_punto then
            Wait(0)
            for k, v in pairs(ClientRocks) do
                ESX.Game.DeleteObject(v)
                spawnedRocks = spawnedRocks - 1
            end
        end
	end
    table.remove(ClientRocks, obj)
    spawnedRocks = 0
end

function ValidateRockCoord(rockCoord, mina)
	if spawnedRocks > 0 then
		local validate = true

		for k, v in pairs(ClientRocks) do
			if #(rockCoord - GetEntityCoords(v)) < 5 then
				validate = false
			end
		end

		if #(rockCoord - Config.MineZones[mina].coords) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateRockCoords(mina)
	while true do
		Wait(0)

		local rockCoordX, rockCoordY

        local neg_dist = -1*Config.MineZones[mina].radius+10
        local pos_dist = Config.MineZones[mina].radius-10

		math.randomseed(GetGameTimer())
		local modX = math.random(neg_dist, pos_dist)

		Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(neg_dist, pos_dist)

		rockCoordX = Config.MineZones[mina].coords.x + modX
		rockCoordY = Config.MineZones[mina].coords.y + modY

		local coordZ = GetCoordZ(rockCoordX, rockCoordY)
		local coord = vector3(rockCoordX, rockCoordY, coordZ)

		if ValidateRockCoord(coord, mina) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 48.0, 49.0, 50.0, 51.0, 52.0, 53.0, 54.0, 55.0, 56.0, 57.0, 58.0,119.0, 120.0, 121.0, 122.0, 123.0, 124.0}

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 43.0
end

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end


loadDict = function(dict, anim)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
    return dict
end

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

RegisterNetEvent('miner_zet:sound')
AddEventHandler('miner_zet:sound', function(name, vol)
    SendNUIMessage({
        transactionType     = 'playSound',
        transactionFile     = name,
        transactionVolume   = vol
    })
end)