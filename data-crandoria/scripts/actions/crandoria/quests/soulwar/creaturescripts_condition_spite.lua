local poolofTears = MoveEvent()

function poolofTears.onStepIn(creature, item, position, fromPosition)

	if not creature:isPlayer() then
		return true
	end

	local player = creature

	-- Condição para fraqueza a energy (-25%)
	local energyWeakness = Condition(CONDITION_ATTRIBUTES)
	energyWeakness:setParameter(CONDITION_PARAM_TICKS, 10000)
	energyWeakness:setParameter(CONDITION_PARAM_BUFF, false)
	energyWeakness:setParameter(CONDITION_PARAM_SUBID, 1)
	energyWeakness:setParameter(CONDITION_PARAM_ABSORB_ENERGYPERCENT, -25)

	-- Condição para mudar outfit
	local outfitCondition = Condition(CONDITION_OUTFIT)
	outfitCondition:setParameter(CONDITION_PARAM_TICKS, 10000)
	outfitCondition:setParameter(CONDITION_PARAM_SUBID, 2)
	outfitCondition:setOutfit({lookType = 286}) -- use table, é mais seguro

	player:addCondition(energyWeakness)
	player:addCondition(outfitCondition)

	return true
end

poolofTears:id(33876)
poolofTears:register()