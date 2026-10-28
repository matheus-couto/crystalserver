local iceHole = MoveEvent()

function iceHole.onStepIn(creature, item, position, fromPosition)

    local player = creature:getPlayer()
    if not player then
        return true
    end

    local condition = Condition(CONDITION_OUTFIT)
	condition:setOutfit(6707)
	condition:setTicks(2000)
	player:addCondition(condition)

    local conditionDrunk = Condition(CONDITION_DRUNK)
	conditionDrunk:setTicks(10000)
	player:addCondition(conditionDrunk)

    local conditionFreeze = Condition(CONDITION_ROOTED)
	conditionFreeze:setTicks(2000)
	player:addCondition(conditionFreeze)

end

iceHole:id(51883)
iceHole:register()