local teleportConfig = {
		creatureNames = {"Spectre of the Shadows", "Stalker of the Shadows", "Whisper of the Shadows"}
	}

local teleportBossConfig = {
    bossNames = {"Lianna the Venomous Shadow", "Tharkor the Double Shadow", "Kouda the Burning Shadow", "Banno the Silent Shadow", "Vargo the Blood Shadow", "Iokrah the Moon Shadow"}
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


local teleportDoom = MoveEvent()

local function countPlayersInArea(fromPos, toPos)
    local count = 0
    for x = fromPos.x, toPos.x do
        for y = fromPos.y, toPos.y do
            for z = fromPos.z, toPos.z do
                local tile = Tile(Position(x, y, z))
                if tile then
                    local creature = tile:getTopCreature()
                    if creature and creature:isPlayer() then
                        count = count + 1
                    end
                end
            end
        end
    end
    return count
end

function teleportDoom.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)

    if item:getPosition() == Position(5042, 5144, 14) then
        if hasCreatureInArea(Position(5000, 5136, 14), Position(5042, 5166, 14), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrote todos os monstros das sombras antes de acessar a sala.")
            player:teleportTo(fromPosition)
            return true
        else
            if hasCreatureInArea(Position(5044, 5140, 14), Position(5061, 5155, 14), teleportBossConfig.bossNames) then
                if countPlayersInArea(Position(5044, 5140, 14), Position(5061, 5155, 14)) < 10 then
                    player:teleportTo(Position(5044, 5144, 14))
                    player:getPosition():sendMagicEffect(CONST_ME_ORANGETELEPORT)
                    return true
                else
                    player:sendCancelMessage("O limite de jogadores na sala foi atingido.")
                    player:teleportTo(fromPosition)
                    return true
                end
            else
                player:sendCancelMessage("Nao ha nenhum chefe na sala.")
                player:teleportTo(fromPosition)
                return true
            end
        end
    elseif item:getPosition() == Position(5039, 5161, 14) then
        if hasCreatureInArea(Position(5000, 5136, 14), Position(5042, 5166, 14), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrote todos os monstros das sombras antes de acessar a sala")
            player:teleportTo(fromPosition)
            return true
        else
            if hasCreatureInArea(Position(5041, 5158, 14), Position(5060, 5174, 14), teleportBossConfig.bossNames) then
                if countPlayersInArea(Position(5041, 5158, 14), Position(5060, 5174, 14)) < 10 then
                    player:teleportTo(Position(5041, 5164, 14))
                    player:getPosition():sendMagicEffect(CONST_ME_ORANGETELEPORT)
                    return true
                else
                    player:sendCancelMessage("O limite de jogadores na sala foi atingido.")
                    player:teleportTo(fromPosition)
                    return true
                end
            else
                player:sendCancelMessage("Nao ha nenhum chefe na sala.")
                player:teleportTo(fromPosition)
                return true
            end
        end
    elseif item:getPosition() == Position(5029, 5166, 14) then
        if hasCreatureInArea(Position(5000, 5136, 14), Position(5042, 5166, 14), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrote todos os monstros das sombras antes de acessar a sala")
            player:teleportTo(fromPosition)
            return true
        else
            if hasCreatureInArea(Position(5021, 5168, 14), Position(5038, 5184, 14), teleportBossConfig.bossNames) then
                if countPlayersInArea(Position(5021, 5168, 14), Position(5038, 5184, 14)) < 10 then
                    player:teleportTo(Position(5029, 5168, 14))
                    player:getPosition():sendMagicEffect(CONST_ME_ORANGETELEPORT)
                    return true
                else
                    player:sendCancelMessage("O limite de jogadores na sala foi atingido.")
                    player:teleportTo(fromPosition)
                    return true
                end
            else
                player:sendCancelMessage("Nao ha nenhum chefe na sala.")
                player:teleportTo(fromPosition)
                return true
            end
        end
    elseif item:getPosition() == Position(5010, 5165, 14) then
        if hasCreatureInArea(Position(5000, 5136, 14), Position(5042, 5166, 14), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrote todos os monstros das sombras antes de acessar a sala")
            player:teleportTo(fromPosition)
            return true
        else
            if hasCreatureInArea(Position(5000, 5166, 14), Position(5016, 5183, 14), teleportBossConfig.bossNames) then
                if countPlayersInArea(Position(5000, 5166, 14), Position(5016, 5183, 14)) < 10 then
                    player:teleportTo(Position(5006, 5168, 14))
                    player:getPosition():sendMagicEffect(CONST_ME_ORANGETELEPORT)
                    return true
                else
                    player:sendCancelMessage("O limite de jogadores na sala foi atingido.")
                    player:teleportTo(fromPosition)
                    return true
                end
            else
                player:sendCancelMessage("Nao ha nenhum chefe na sala.")
                player:teleportTo(fromPosition)
                return true
            end
        end
    elseif item:getPosition() == Position(5000, 5154, 14) then
        if hasCreatureInArea(Position(5000, 5136, 14), Position(5042, 5166, 14), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrote todos os monstros das sombras antes de acessar a sala")
            player:teleportTo(fromPosition)
            return true
        else
            if hasCreatureInArea(Position(4982, 5149, 14), Position(4999, 5164, 14), teleportBossConfig.bossNames) then
                if countPlayersInArea(Position(4982, 5149, 14), Position(4999, 5164, 14)) < 10 then
                    player:teleportTo(Position(4998, 5154, 14))
                    player:getPosition():sendMagicEffect(CONST_ME_ORANGETELEPORT)
                    return true
                else
                    player:sendCancelMessage("O limite de jogadores na sala foi atingido.")
                    player:teleportTo(fromPosition)
                    return true
                end
            else
                player:sendCancelMessage("Nao ha nenhum chefe na sala.")
                player:teleportTo(fromPosition)
                return true
            end
        end
    elseif item:getPosition() == Position(5006, 5136, 14) then
        if hasCreatureInArea(Position(5000, 5136, 14), Position(5042, 5166, 14), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrote todos os monstros das sombras antes de acessar a sala")
            player:teleportTo(fromPosition)
            return true
        else
            if hasCreatureInArea(Position(4994, 5119, 14), Position(5012, 5135, 14), teleportBossConfig.bossNames) then
                if countPlayersInArea(Position(4994, 5119, 14), Position(5012, 5135, 14)) < 10 then
                    player:teleportTo(Position(5006, 5134, 14))
                    player:getPosition():sendMagicEffect(CONST_ME_ORANGETELEPORT)
                    return true
                else
                    player:sendCancelMessage("O limite de jogadores na sala foi atingido.")
                    player:teleportTo(fromPosition)
                    return true
                end
            else
                player:sendCancelMessage("Nao ha nenhum chefe na sala.")
                player:teleportTo(fromPosition)
                return true
            end
        end
    end
end


teleportDoom:aid(13165)
teleportDoom:register()