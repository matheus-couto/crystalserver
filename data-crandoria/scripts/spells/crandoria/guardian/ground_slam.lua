local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_STONES)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_USECHARGES, 1)

local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GROUNDSHAKER)
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)

function onGetFormulaValues(player, skill, attack, factor)
	local level = player:getLevel()
	local fist = player:getEffectiveSkillLevel(SKILL_FIST)
	local squareRoot = math.sqrt(level)

	local min = ((((level / 5) + (skill + attack) * 0.55) * 1.1) + (((attack / 2) * (fist * 0.9)) / 100) + (squareRoot)) * 0.67
	local max = ((((level / 5) + (skill + attack) * 1) * 1.1) + (((attack / 2) * (fist * 0.9)) / 100) + (squareRoot)) * 0.67

	return -min, -max
end

function onGetFormulaValuess(player, maglevel, attack, factor)
	local level = player:getLevel()
	local fist = player:getEffectiveSkillLevel(SKILL_FIST)
	local squareRoot = math.sqrt(level)
	
	local min = (((level / 5) + (maglevel * 3.5) * 1.1) + (((attack / 2) * (fist * 0.9)) / 100) + (squareRoot)) * 0.4
	local max = (((level / 4) + (maglevel * 6) * 1.3) + (((attack / 2) * (fist * 0.9)) / 100) + (squareRoot)) * 0.4

	return -min, -max
end
-----

local arr = {
	{ 0, 0, 1, 0, 0 },
	{ 0, 0, 1, 0, 0 },
	{ 0, 0, 1, 0, 0 },
	{ 0, 0, 1, 0, 0 },
	{ 0, 0, 3, 0, 0 },
}

local area = createCombatArea(arr)
combat:setArea(area)
combat1:setArea(area)

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")
combat1:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValuess")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	combat:execute(creature, var)
	combat1:execute(creature, var)
	return true
end

spell:group("attack")
spell:id(307)
spell:name("Ground Slam")
spell:words("exori nox")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_BERSERK)
spell:level(50)
spell:mana(145)
spell:needDirection(true)
spell:isPremium(true)
-- spell:needWeapon(true)
spell:cooldown(4 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("guardian;true", "celestial guardian;true")
spell:register()