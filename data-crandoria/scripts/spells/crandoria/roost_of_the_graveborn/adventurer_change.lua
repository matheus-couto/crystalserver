local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_TICKS, 300000)
condition:setParameter(CONDITION_PARAM_BUFF_DAMAGERECEIVED, 75)
condition:setParameter(CONDITION_PARAM_BUFF_DAMAGEDEALT, 125)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local hp = creature:getHealth()

	if hp < 46500 then
		creature:addCondition(condition)
		if creature:getName():lower() == "fiona firstdream" then
			creature:setOutfit(1595)
		elseif creature:getName():lower() == "grendel greenlunch" then
			creature:setOutfit(1596)
		elseif creature:getName():lower() == "nigel neverguess" then
			creature:setOutfit(1823)
		elseif creature:getName():lower() == "percy peacetinker" then
			creature:setOutfit(1594)
		elseif creature:getName():lower() == "yorik youngbook" then
			creature:setOutfit(1593)
		end
	end

	return true
end

spell:name("adventurer change") 
spell:words("###780") 
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()