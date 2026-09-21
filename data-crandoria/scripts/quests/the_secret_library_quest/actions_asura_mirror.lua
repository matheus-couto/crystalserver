local goPos = {x = 5297, y = 4993, z = 11}

local asuraMirror = Action()
function asuraMirror.onUse(creature, item, position, fromPosition, pos, target, toPosition)
    local player = creature:getPlayer()
    if not player then
        return
    end

    if player:getLevel() >= 250 then
        position:sendMagicEffect(CONST_ME_TELEPORT)
        player:teleportTo(goPos)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    else
        player:sendCancelMessage('You do not have enough level.')
    end
end

asuraMirror:aid(64019)
asuraMirror:register()
