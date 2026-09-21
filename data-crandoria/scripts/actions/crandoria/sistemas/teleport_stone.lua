
local magicalStone = Action()

-- Define as novas áreas
local area1 = {
    fromPosition = {x = 4927, y = 4960, z = 7},
    toPosition = {x = 4939, y = 4978, z = 7}
}

local area2 = {
    fromPosition = {x = 4930, y = 4961, z = 6},
    toPosition = {x = 4939, y = 4978, z = 6}
}

local area3 = {
    fromPosition = {x = 4927, y = 4964, z = 8},
    toPosition = {x = 4946, y = 4974, z = 8}
}

local area4 = {
    fromPosition = {x = 4942, y = 4967, z = 9},
    toPosition = {x = 4959, y = 4976, z = 9}
}

local area5 = {
    fromPosition = {x = 4988, y = 5121, z = 7},
    toPosition = {x = 5013, y = 5142, z = 7}
}

-- Função para verificar se o jogador está dentro de uma área
local function isInArea(player, area)
    local playerPos = player:getPosition()
    return playerPos.x >= area.fromPosition.x and playerPos.x <= area.toPosition.x
        and playerPos.y >= area.fromPosition.y and playerPos.y <= area.toPosition.y
        and playerPos.z == area.fromPosition.z
end

function magicalStone.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local tile = Tile(pos)
    if tile and tile:hasFlag(TILESTATE_NOLOGOUT) then
        player:sendCancelMessage("Voce nao pode usar este item aqui.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end

    if isInArea(player, area1) or isInArea(player, area2) or isInArea(player, area3) or isInArea(player, area4) or isInArea(player, area5) then
        player:sendCancelMessage("Voce nao pode usar este item aqui.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end

    if not Tile(player:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) and (player:isPzLocked() or player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)) then
        player:sendCancelMessage("Voce nao pode usar este item com Battle ativado.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end

    if player:getSkull() == SKULL_RED or player:getSkull() == SKULL_BLACK then
        player:teleportTo(player:getTown():getTemplePosition(), true)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Back home!')
        return true
    else
        player:teleportTo(player:getTown():getTemplePosition(), true)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Back home!')
        return true
    end
    
end

magicalStone:id(39036)
magicalStone:register()