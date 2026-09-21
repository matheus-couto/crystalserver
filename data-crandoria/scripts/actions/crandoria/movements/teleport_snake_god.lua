local teleportSnakeGod = MoveEvent()

function teleportSnakeGod.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    -- if player:getStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission11) == 1 then
    if player:getStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission11) < 2 then
        player:teleportTo(Position(4938, 4580, 12))
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    else
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:say("Voce nao pode acessar a sala do Snake God.", TALKTYPE_MONSTER_SAY)
    end
end

teleportSnakeGod:aid(13011)
teleportSnakeGod:register()