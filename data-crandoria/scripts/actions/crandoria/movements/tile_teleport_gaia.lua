local destination = {
    [12386] = Position(5813, 4520, 14), -- Sistema de poison
}

local poison = MoveEvent()

function poison.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    player:getPosition():sendMagicEffect(CONST_ME_SMALLPLANTS)
    player:say('LEAVE, MORTAL!', TALKTYPE_MONSTER_SAY, false, player, player:getPosition())
    player:teleportTo(Position(5813, 4520, 14))
    player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    player:addHealth(-500, COMBAT_EARTHDAMAGE)
    player:getPosition():sendMagicEffect(CONST_ME_SMALLPLANTS)
    player:say('LEAVE, MORTAL!', TALKTYPE_MONSTER_SAY, false, player, player:getPosition())
    return true

end

poison:type("stepin")

poison:aid(12386)
poison:register()
