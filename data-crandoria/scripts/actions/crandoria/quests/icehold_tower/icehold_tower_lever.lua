-- local config = {
-- 	boss = {
-- 		name = "The Obliverator",
-- 		position = Position(5033, 5324, 0)
-- 	},
-- 	requiredLevel = 20,
-- 	timeToFightAgain = 60,
-- 	timeToDefeatBoss = 30 * 60,
-- 	playerPositions = {
-- 		{pos = Position(5033, 5335, 7), teleport = Position(5033, 5332, 7), effect = CONST_ME_TELEPORT},
-- 	},
-- 	specPos = {
-- 		from = Position(5026, 5320, 7),
-- 		to = Position(5040, 5333, 0)
-- 	},
-- 	exit = Position(5032, 5335, 7),
-- 	storage = Storage.Quest.Crandoria.IceholdTower.Timer
-- }

-- local iceholdTowerLever = Action()
-- function iceholdTowerLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
-- 	return { CreateDefaultLeverBoss(player, config),
-- 	Game.createMonster("Deathbringer", Position(5033, 5324, 1)),
-- 	Game.createMonster("Colerian the Barbarian", Position(5033, 5323, 7)),
-- 	Game.createMonster("Barbarian Bloodwalker", Position(5031, 5323, 7)),
-- 	Game.createMonster("Orcus the Cruel", Position(5033, 5322, 6)),
-- 	Game.createMonster("Orc Spearman", Position(5031, 5322, 6)),
-- 	Game.createMonster("Orc Warrior", Position(5035, 5322, 6)),
-- 	Game.createMonster("Spirit of Water", Position(5033, 5323, 4)),
-- 	Game.createMonster("Water Elemental", Position(5031, 5323, 4)),
-- 	Game.createMonster("Spirit of Fire", Position(5033, 5323, 3)),
-- 	Game.createMonster("Fire Elemental", Position(5031, 5323, 3))
-- }
-- end

-- iceholdTowerLever:position({x = 5033, y = 5334, z = 7})
-- iceholdTowerLever:register()

--

-- ESSEEEEE

local config = {
    boss = {
        name = "The Obliverator",
        position = Position(5033, 5324, 0)
    },
    requiredLevel = 20,
    timeToFightAgain = 4 * 60 * 60,
    timeToDefeatBoss = 30 * 60,
    playerPositions = {
        {pos = Position(5033, 5334, 7), teleport = Position(5033, 5331, 7), effect = CONST_ME_TELEPORT},
    },
    specPos = {
        from = Position(5026, 5320, 7),
        to = Position(5040, 5333, 0)
    },
    exit = Position(5032, 5335, 7),
    storage = Storage.Quest.Crandoria.IceholdTower.Timer
}

local iceholdTowerLever = Action() 
local removalTime = 1800 -- Tempo em segundos para remover a pedra 

function iceholdTowerLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local stonePosition = {x = 5033, y = 5334, z = 7}
    local stoneItem = getTileItemById(stonePosition, 1841)
        return {
            CreateDefaultLeverBoss(player, config),
            Game.createMonster("Deathbringer", Position(5033, 5324, 1)),
            Game.createMonster("Colerian the Barbarian", Position(5033, 5323, 7)),
            Game.createMonster("Barbarian Bloodwalker", Position(5031, 5323, 7)),
            Game.createMonster("Orcus the Cruel", Position(5033, 5322, 6)),
            Game.createMonster("Orc Spearman", Position(5031, 5322, 6)),
            Game.createMonster("Orc Warrior", Position(5035, 5322, 6)),
            Game.createMonster("Spirit of Water", Position(5033, 5323, 4)),
            Game.createMonster("Water Elemental", Position(5031, 5323, 4)),
            Game.createMonster("Spirit of Fire", Position(5033, 5323, 3)),
            Game.createMonster("Fire Elemental", Position(5031, 5323, 3)),
            Game.createItem(1841, 1, stonePosition),
            addEvent(function()
                Tile(stonePosition):getItemById(1841):remove()
            end, removalTime * 1000)
        }
end

iceholdTowerLever:position({x = 5033, y = 5333, z = 7})
iceholdTowerLever:register()






