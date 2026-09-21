local teleportConfig = {
		creatureNames = {"Srezz Yellow Eyes", "Tazhadur", "Mozradek", "Tirecz", "Thawing Dragon Lord", "The Ravager", "Death Priest Shargon", "Unaz the Mean", "Bullwark", "The Lord of the Lice", "Professor Maxxen", "Ravenous Hunger"}
	}

local function hasCreatureInArea(fromPosition, toPosition, creatureNames)
    for x = fromPosition.x, toPosition.x do
        for y = fromPosition.y, toPosition.y do
            local pos = Position(x, y, fromPosition.z)
            local tile = Tile(pos)
            if tile then
                local creature = tile:getTopCreature()
                if creature and table.contains(creatureNames, creature:getName()) then
                    return true
                end
            end
        end
    end
    return false
end

local areas = {
    {fromPosition = Position(4160, 5123, 6), toPosition = Position(4177, 5139, 6)},
    {fromPosition = Position(4160, 5105, 6), toPosition = Position(4177, 5122, 6)},
    {fromPosition = Position(4160, 5087, 5), toPosition = Position(4177, 5103, 5)},

}

local function getPlayersInArea(area)
    local players = {}
    for x = area.fromPosition.x, area.toPosition.x do
        for y = area.fromPosition.y, area.toPosition.y do
            local pos = Position(x, y, area.fromPosition.z)
            local tile = Tile(pos)
            if tile then
                local creature = tile:getTopCreature()
                if creature and creature:isPlayer() then
                    table.insert(players, creature)
                end
            end
        end
    end
    return players
end

-- local function checkAndTeleportPlayers()
--     for _, area in ipairs(areas) do
--         local playersInArea = getPlayersInArea(area)
--         for _, player in ipairs(playersInArea) do
--             local timerStorage = player:getStorageValue(Storage.Quest.Crandoria.Viridia.Arena.TimerSala)
--             if timerStorage < os.time() then
--                 player:teleportTo(Position(4657, 5251, 12))
--                 player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
-- 		        player:setStorageValue(Storage.Quest.Crandoria.Viridia.Arena.TimerGeral, 7 * 24 * 60 * 60)
--             end 
--         end 
--     end
-- end

local teleporstArenadoCaos = MoveEvent()

local accessedIPs = {}

function teleporstArenadoCaos.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)

	local playerIP = player:getIp()
	

	if item:getPosition() == Position(4629, 5265, 12) then
        if hasCreatureInArea(Position(4618, 5259, 12), Position(4630, 5272, 12), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrote o Boss para acessar o teleport.")
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            return true
        else
            player:teleportTo(Position(4634, 5266, 12))
            return true
        end
    elseif item:getPosition() == Position(4642, 5265, 12) then
        if hasCreatureInArea(Position(4631, 5259, 12), Position(4644, 5272, 12), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrote o Boss para acessar o teleport.")
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            return true
        else
            player:teleportTo(Position(4646, 5266, 12))
            return true
        end
    elseif item:getPosition() == Position(4655, 5265, 12) then
        if hasCreatureInArea(Position(4644, 5260, 12), Position(4656, 5271, 12), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrote o Boss para acessar o teleport.")
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            return true
        else
            player:teleportTo(Position(4659, 5266, 12))
            return true
        end
    elseif item:getPosition() == Position(4668, 5265, 12) then
        if hasCreatureInArea(Position(4657, 5260, 12), Position(4669, 5271, 12), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrote o Boss para acessar o teleport.")
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            return true
        else
            player:teleportTo(Position(4672, 5266, 12))
            return true
        end
    elseif item:getPosition() == Position(4681, 5265, 12) then
        if hasCreatureInArea(Position(4670, 5259, 12), Position(4681, 5271, 12), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrote o Boss para acessar o teleport.")
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            return true
        else
            player:teleportTo(Position(4685, 5266, 12))
            return true
        end
    elseif item:getPosition() == Position(4694, 5265, 12) then
        if hasCreatureInArea(Position(4683, 5260, 12), Position(4696, 5272, 12), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrote o Boss para acessar o teleport.")
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            return true
        else
            player:teleportTo(Position(4620, 5280, 12))
            return true
        end
    elseif item:getPosition() == Position(4629, 5279, 12) then
        if hasCreatureInArea(Position(4617, 5273, 12), Position(4630, 5286, 12), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrote o Boss para acessar o teleport.")
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            return true
        else
            player:teleportTo(Position(4633, 5280, 12))
            return true
        end
    elseif item:getPosition() == Position(4642, 5279, 12) then
        if hasCreatureInArea(Position(4631, 5273, 12), Position(4643, 5286, 12), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrote o Boss para acessar o teleport.")
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            return true
        else
            player:teleportTo(Position(4646, 5280, 12))
            return true
        end
    elseif item:getPosition() == Position(4655, 5279, 12) then
        if hasCreatureInArea(Position(4644, 5273, 12), Position(4656, 5286, 12), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrote o Boss para acessar o teleport.")
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            return true
        else
            player:teleportTo(Position(4659, 5280, 12))
            return true
        end
    elseif item:getPosition() == Position(4668, 5279, 12) then
        if hasCreatureInArea(Position(4658, 5274, 12), Position(4669, 5286, 12), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrote o Boss para acessar o teleport.")
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            return true
        else
            player:teleportTo(Position(4672, 5280, 12))
            return true
        end
    elseif item:getPosition() == Position(4681, 5279, 12) then
        if hasCreatureInArea(Position(4670, 5274, 12), Position(4682, 5286, 12), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrote o Boss para acessar o teleport.")
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            return true
        else
            player:teleportTo(Position(4685, 5280, 12))
            return true
        end
    elseif item:getPosition() == Position(4694, 5279, 12) then
        if hasCreatureInArea(Position(4683, 5273, 12), Position(4695, 5285, 12), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrote o Boss para acessar o teleport.")
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            return true
        else
            player:setStorageValue()
            player:teleportTo(Position(4657, 5253, 12))
            player:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.ArenaTimer, 7 * 24 * 60 * 60)
            player:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Progresso, 11)
            return true
        end
    end
end

teleporstArenadoCaos:aid(13099)
teleporstArenadoCaos:register()





