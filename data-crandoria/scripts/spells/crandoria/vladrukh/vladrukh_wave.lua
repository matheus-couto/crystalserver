local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)

local area = createCombatArea(AREA_SQUAREWAVE7)
combat:setArea(area)

function bloodPoolWaveTargetCallback(creature, target)
	if target:isMonster() and target:getName():lower() == "blood pool" then
		target:remove()
		creature:addHealth(4000)
		creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		return false
	end
	return true
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "bloodPoolWaveTargetCallback")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:name("blood pool wave") -- use esse mesmo nome no "name" da entrada em monster.attacks
spell:words("###776") -- ajuste se seu fork exigir um identificador único diferente
spell:isAggressive(true)
spell:blockWalls(true)
spell:register()