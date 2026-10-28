local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, 0)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

function onTargetCreature(creature)
	local min = 4000
	local max = 5000

	doTargetCombatHealth(0, creature, COMBAT_HEALING, min, max, CONST_ME_NONE)
	return true
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local hp = creature:getHealth()
	local pos = creature:getPosition()

	if hp < 40000 then
		local chance = math.random(1, 3)
			local summons = creature:getSummons()
			if summons then
				local posSummons = getClosestFreePosition(pos, 1, true)
				local summonPos = summon:getPosition()
				if chance == 1 then
					for _, summon in ipairs(summons) do
						if (summonPos.x - pos.x > 2 or pos.x - summonPos.x > 2) and (summonPos.y - pos.y > 2 or pos.y - summonPos.y > 2) then
							summon:teleportTo(posSummons)
						end
					end
				else
					if (summonPos.x - pos.x < 4 or pos.x - summonPos.x < 4) and (summonPos.y - pos.y < 4 or pos.y - summonPos.y < 4) then
					return combat:execute(creature, var)
				end
			end
		end
	end

	return true
end

spell:name("soulcage spell") 
spell:words("###850") 
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:isSelfTarget(true)
spell:register()