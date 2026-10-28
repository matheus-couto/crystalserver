local function hasCreatureInArea(fromPosition, toPosition)
    for x = fromPosition.x, toPosition.x do
        for y = fromPosition.y, toPosition.y do
            local pos = Position(x, y, fromPosition.z)
            local tile = Tile(pos)
            if tile then
                local creature = tile:getTopCreature()
                if creature and creature:isMonster() and not creature:getMaster() then
                    return true
                end
            end
        end
    end
    return false
end


local teleportsDisputaPoder = MoveEvent()

function teleportsDisputaPoder.onStepIn(player, item, position, fromPosition)

    if not player then
        return true
    end

    local rep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)

    if item.itemid == 37000 then
        player:teleportTo(Position(5000, 5000, 6))
        if Game.getStorageValue(GlobalStorage.Crandoria.Eventos.EventoProgramado) > 0 then
            player:sendTextMessage("Voce abandonou um evento de times em andamento e por isso perdeu pontos de reputacao.")
            if rep >= 10 then
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, rep - 10)
            else
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, 0)
            end
            player:say('- Reputacao', TALKTYPE_MONSTER_SAY)
        end
    elseif item.itemid == 37001 then
        local pos = item:getPosition()
        if pos == Position(4328, 6157, 7) then
            if hasCreatureInArea(Position(4319, 6137, 7), Position(4328, 6157, 7)) then
                player:sendCancelMessage("Derrote todos os monstros da sala antes de passar pelo teleport.")
                player:teleportTo(fromPosition)
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            else
                player:teleportTo(Position(4328, 6159, 7))
            end
        elseif pos == Position(4330, 6157, 7) then
            if hasCreatureInArea(Position(4330, 6137, 7), Position(4339, 6157, 7)) then
                player:sendCancelMessage("Derrote todos os monstros da sala antes de passar pelo teleport.")
                player:teleportTo(fromPosition)
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            else
                player:teleportTo(Position(4330, 6159, 7))
            end
        elseif pos == Position(4328, 6184, 7) then
            if hasCreatureInArea(Position(4319, 6159, 7), Position(4328, 6184, 7)) then
                player:sendCancelMessage("Derrote todos os monstros da sala antes de passar pelo teleport.")
                player:teleportTo(fromPosition)
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            else
                player:teleportTo(Position(4328, 6186, 7))
            end
        elseif pos == Position(4330, 6184, 7) then
            if hasCreatureInArea(Position(4330, 6159, 7), Position(4339, 6184, 7)) then
                player:sendCancelMessage("Derrote todos os monstros da sala antes de passar pelo teleport.")
                player:teleportTo(fromPosition)
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            else
                player:teleportTo(Position(4330, 6186, 7))
            end
        elseif pos == Position(4328, 6212, 7) then
            if hasCreatureInArea(Position(4318, 6186, 7), Position(4328, 6212, 7)) then
                player:sendCancelMessage("Derrote todos os monstros da sala antes de passar pelo teleport.")
                player:teleportTo(fromPosition)
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            else
                player:teleportTo(Position(4328, 6214, 7))
            end
        elseif pos == Position(4330, 6212, 7) then
            if hasCreatureInArea(Position(4330, 6186, 7), Position(4340, 6212, 7)) then
                player:sendCancelMessage("Derrote todos os monstros da sala antes de passar pelo teleport.")
                player:teleportTo(fromPosition)
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            else
                player:teleportTo(Position(4330, 6214, 7))
            end
        elseif pos == Position(4328, 6241, 7) then
            if hasCreatureInArea(Position(4317, 6214, 7), Position(4328, 6241, 7)) then
                player:sendCancelMessage("Derrote todos os monstros da sala antes de passar pelo teleport.")
                player:teleportTo(fromPosition)
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            else
                player:teleportTo(Position(4318, 6246, 7))
                player:sendCancelMessage("Derrote o Boss!")
            end
        elseif pos == Position(4330, 6241, 7) then
            if hasCreatureInArea(Position(4330, 6214, 7), Position(4341, 6241, 7)) then
                player:sendCancelMessage("Derrote todos os monstros da sala antes de passar pelo teleport.")
                player:teleportTo(fromPosition)
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            else
                player:teleportTo(Position(4340, 6246, 7))
                player:sendCancelMessage("Derrote o Boss!")
            end
        end
    end
    return true

end

teleportsDisputaPoder:aid(13230)
teleportsDisputaPoder:register()