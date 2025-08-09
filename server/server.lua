ESX = exports['es_extended']:getPasTROSharedObject()

local Inventory = exports.ox_inventory


local chances = {
    ['copper'] = 30,
    ['emerald'] = 15,
    ['sapphire'] = 10,
    ['ruby'] = 20,
    ['iron'] = 25,
    -- [variable] = chance integer
}
 


RegisterServerEvent('miner_zet:mine')
AddEventHandler('miner_zet:mine', function(mina)
    local xPlayer = ESX.GetPlayerFromId(source)
    local results = {}
        
    for j,v in pairs(Config.MineZones[mina].Drop) do
        for i = 1, v.Prob do
            table.insert(results, j)
        end
    end
    
    local random = math.random(#results)
    local resultado = results[random]

    xPlayer.addInventoryItem(Config.MineZones[mina].Drop[resultado].Name, math.random(Config.MineZones[mina].Drop[resultado].dropmin,Config.MineZones[mina].Drop[resultado].dropmax))
    local amount = Config.MineZones[mina].Drop[resultado].exp
    exports.OT_skills:addXP(source, 'mining', amount)
    TriggerClientEvent('okokNotify:Alert', source, "Minería", "Has ganado "..amount.." EXP", 5000, 'info')
    print(random)
    print(results[random])

    --[[local xPlayer = ESX.GetPlayerFromId(source)
    random = math.random(1,100)
    random_pick = math.random(1,5)
    for Mineral,h in pairs(Config.MineZones[mina].Drop) do
        print(h[random_pick])
        print(Config.MineZones[mina].Drop[random_pick].Name)
        if random > Config.MineZones[mina].Drop[random_pick].Prob then
            random_pick = math.random(1,5)
        else
            if Config.MineZones[mina].Drop[random_pick].Active and random < Config.MineZones[mina].Drop[random_pick].Prob then
                xPlayer.addInventoryItem(Config.MineZones[mina].Drop[random_pick].Name, math.random(Config.MineZones[mina].Drop[random_pick].dropmin,Config.MineZones[mina].Drop[random_pick].dropmax))
                local amount = Config.MineZones[mina].Drop[random_pick].exp
                exports.OT_skills:addXP(source, 'mining', amount)
                TriggerClientEvent('okokNotify:Alert', source, "Minería", "Has ganado "..amount.." EXP", 5000, 'info')
                break
            end
        end
    end]]--
end)


RegisterCommand('addminer', function(source)
    exports.OT_skills:addXP(source, 'mining', 20)
end)


RegisterNetEvent("miner_zet:mineRock", function(data, mina)
    print(mina)
    math.randomseed(os.time())
    local cfg = Config.Mining
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local jackhammer =xPlayer.getInventoryItem('jackhammer').count
        local pickaxe = xPlayer.getInventoryItem('pickaxe').count
        local shovel = xPlayer.getInventoryItem('shovel').count




        if jackhammer >= 1 then 
            local time = cfg[1].Time
            local animation = {
                dict = 'amb@world_human_const_drill@male@drill@base',
                clip = 'base'
            }
            local props = {
                model = 'prop_tool_jackham',
                bone = 28422,
                pos = vec3(0.05, 0.00, 0.00),
                rot = vec3(0.0, 0.0, 0.0)
            }
                TriggerClientEvent("miner_zet:progressBar", source, time, data, animation, props, mina)
            
                print('j')
                Wait(time)
        elseif pickaxe >= 1 then 
            local time = cfg[2].Time
            local reward = math.random(cfg[2].MinReward, cfg[2].MaxReward)
            local animation = {
                dict = 'melee@large_wpn@streamed_core',
                clip = 'ground_attack_0'
            }
            local props = {
                model = 'prop_tool_pickaxe',
                bone = 28422,
                pos = vec3(0.05, 0.00, 0.00),
                rot = vec3(-70.0, 30.0, 0.0)
            }
                -- TriggerEvent('dream-miner:sound', 'pickaxe', 0.5)
                TriggerClientEvent("miner_zet:progressBar", source, time, data, animation, props, mina)
                Wait(time)

        elseif shovel >= 1 then 
            local time = cfg[3].Time
            local reward = math.random(cfg[3].MinReward, cfg[3].MaxReward)
            local animation = {
                dict = 'amb@world_human_gardener_plant@male@base',
                clip = 'base'
            }
            local props = {
                model = 'prop_cs_trowel',
                bone = 28422,
                pos = vec3(0.00, 0.00, 0.00),
                rot = vec3(0.0, 0.0, -1.5)
            }
                TriggerClientEvent("miner_zet:progressBar", source, time, data, animation, props, mina)
                Wait(time)
        else 
            NoTools()
        end
    end
end)

function NoTools()
    local cfg = Config.Notifications[1]
    lib.notify(source, cfg.MineNoTools)
end 