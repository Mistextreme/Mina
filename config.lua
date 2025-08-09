Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DEL'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

Config = {}

Config.jobrequirement = false --whether work requires a job
Config.jobname = 'miner' --name of the job that is required

Config.RockSpawn = 20 -- Rock respawn time in minute


Config.Mining = {
    {
        --Jackhammer
        Time = 5000,
        MinReward = 10,
        MaxReward = 15,
    },
    {
        --Pickaxe
        Time = 10000,
        MinReward = 5,
        MaxReward = 10,
    },
    {
        --Shovel
        Time = 15000,
        MinReward = 1,
        MaxReward = 5,
    }
}

Config.MineZones = {
	['Mina_1'] = {
        type = "circle",
        zona = "explotacion_mina", 
        level = 1, 
        coords = vector3(2951.18, 2797.34, 39.5), 
        name = "Mina básica", 
        Blip = {color = 39, type = 652},
        color = 25, 
        sprite = 496, 
        radius = 33,
        Drop = {
            -- copper = true,
            ['copper'] = { 
                Name = 'copper',
                Active = true, 
                dropmin = 1,
                dropmax = 1,
                exp = 2,
                Prob = 40,
            },
            ['emerald'] = { 
                Name = 'emerald',
                Active = true, 
                dropmin = 1,
                dropmax = 1,
                exp = 2,
                Prob = 10,
            },
            ['gold'] = { 
                Name = 'gold',
                Active = true, 
                dropmin = 1,
                dropmax = 1,
                exp = 2,
                Prob = 10,
            },
            ['ruby'] = { 
                Name = 'ruby',
                Active = true, 
                dropmin = 1,
                dropmax = 1,
                exp = 2,
                Prob = 10,
            },
            ['iron'] = { 
                Name = 'iron',
                Active = true, 
                dropmin = 1,
                dropmax = 1,
                exp = 2,
                Prob = 30,
            }, 
        },
        
    },
    ['Mina_2'] = {
        type = "circle", 
        zona = "mina_cueva",
        level = 10, 
        coords = vector3(-446.65, 2080.09, 120.23), 
        name = "Mina Media", 
        Blip = {color = 39, type = 652},
        color = 25, 
        sprite = 496, 
        radius = 29,
        Drop = {
            -- copper = true,
            ['sulfur'] = { 
                Name = 'sulfur',
                Active = true, 
                dropmin = 1,
                dropmax = 2,
                exp = 0,
                Prob = 40,
            },
            ['diamond'] = { 
                Name = 'ruby',
                Active = true, 
                dropmin = 1,
                dropmax = 2,
                exp = 0,
                Prob = 30,
            }, 
            ['gold'] = { 
                Name = 'gold',
                Active = false, 
                dropmin = 1,
                dropmax = 1,
                exp = 0,
                Prob = 30,
            }, 
        },
    },
    ['Mina_3'] = {
        type = "circle", 
        zona = "mina_cueva",
        level = 20, 
        coords = vector3(-523.84, 1894.95, 123.35), 
        name = "Mina Avanzada", 
        Blip = {color = 39, type = 652},
        color = 25, 
        sprite = 496, 
        radius = 43,
        Drop = {
            -- copper = true,
            ['copper'] = { 
                Name = 'copper',
                Active = true, 
                dropmin = 1,
                dropmax = 2,
                exp = 0,
                Prob = 30,
            },
            ['iron'] = { 
                Name = 'iron',
                Active = true, 
                dropmin = 1,
                dropmax = 2,
                exp = 0,
                Prob = 30,
            }, 
            ['steel'] = { 
                Name = 'steel',
                Active = true, 
                dropmin = 1,
                dropmax = 2,
                exp = 0,
                Prob = 40,
            }, 
        },
    },
}

Config.miner = {
	['BossSpawn'] = { 
		Pos = {x = 2950.07, y = 2745.89, z = 43.42, h = 17.35}, 
		Type  = 's_m_m_dockwork_01', --model ped
    },  
    ['BossSpawn2'] = {
		Pos = {x = -600.35, y = 2091.81, z = 131.42, h = 336.23}, 
		Type  = 's_m_m_dockwork_01', --model ped
    }, 
}


Config.Notifications = {
    {
        -- Notification when you try to mine and don't have any tools
        MineNoTools = {
            title = 'Minando',
            description = 'No tienes herramientas para usar',
            type = 'error',
            position = 'top-right'
        }
    }
}

Config.Clothes = {
        male = {
            ['tshirt_1'] = 59,  ['tshirt_2'] = 1,
            ['torso_1'] = 5,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 5,
            ['pants_1'] = 8,   ['pants_2'] = 0,
            ['shoes_1'] = 12,   ['shoes_2'] = 3,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['helmet_1'] = 0,  ['helmet_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        },
        female = {
            ['tshirt_1'] = 36,  ['tshirt_2'] = 1,
            ['torso_1'] = 73,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 14,
            ['pants_1'] = 74,   ['pants_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['chain_1'] = -1,    ['chain_2'] = 0,
            ['helmet_1'] = 0,  ['helmet_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        }    
}
