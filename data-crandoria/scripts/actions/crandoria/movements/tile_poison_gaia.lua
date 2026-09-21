local destination = {
    [12298] = Position(5000, 5000, 7), -- Sistema de poison
}

local poison = MoveEvent()

function poison.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local condition = Condition(CONDITION_POISON)
    condition:setParameter(CONDITION_PARAM_DELAYED, 1)
    condition:addDamage(15, 3000, 1000)
    condition:addDamage(10, 3000, 900)
    condition:addDamage(10, 3000, 800)

    local poisonPosition = destination[item.actionid]
    if poisonPosition then
	player:addHealth(-800, COMBAT_EARTHDAMAGE)
        player:addCondition(condition)
        player:getPosition():sendMagicEffect(CONST_ME_PLANTATTACK)
        player:say('TSSSS', TALKTYPE_MONSTER_SAY, false, player, player:getPosition())
    end
    return true
end

poison:type("stepin")

for index, value in pairs(destination) do
    poison:aid(index)
end

poison:register()
