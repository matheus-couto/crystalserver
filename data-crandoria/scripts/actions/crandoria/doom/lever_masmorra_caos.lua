local leverMasmorra = Action()

function leverMasmorra.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    -- posição da alavanca
    local leverPos = item:getPosition()

    -- posição do jogador esperado (y+1 da alavanca)
    local firstPos = Position(leverPos.x, leverPos.y + 1, leverPos.z)
    local tpPos = Position(5023, 5105, 14) -- posição de destino

    -- checa se o jogador que puxou tem o item
    if player:getItemCount(35580) < 1 then
        player:sendCancelMessage("Voce precisa de uma Golden Skull para ativar a alavanca.")
        leverPos:sendMagicEffect(CONST_ME_POFF)
        return true
    end

    if player:getPosition() ~= firstPos then
        player:sendCancelMessage("Posicione-se no local adequado.")
        leverPos:sendMagicEffect(CONST_ME_POFF)
        return true
    end

    -- pega os jogadores em y+1, y+2, y+3
    for i = 1, 3 do
        local pos = Position(leverPos.x, leverPos.y + i, leverPos.z)
        local creature = Tile(pos):getTopCreature()
        if creature and creature:isPlayer() then
            creature:teleportTo(tpPos)
            tpPos:sendMagicEffect(CONST_ME_TELEPORT)
        end
    end

    -- remove o item só do jogador que puxou
    player:removeItem(35580, 1)

    return true
end

leverMasmorra:aid(13163)
leverMasmorra:register()