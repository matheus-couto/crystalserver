local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 6000)
condition:setFormula(-0.95, 0, -0.95, 0)
combat:addCondition(condition)

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 10)
	local max = (level / 5) + (maglevel * 14)
	if handWeapon and handWeapon.itemid == 43882 then
		-- Aplica um multiplicador de 15% aos valores min e max
		NewMin = min * 1.1
		NewMax = max * 1.15

	return NewMin, NewMax

	elseif handWeapon and handWeapon.itemid == 43883 then
		-- Aplica um multiplicador de 15% aos valores min e max
		NewMin2 = min * 1.2
		NewMax2 = max * 1.2

	return NewMin2, NewMax2

	else

	return -min, -max
end
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local arr = {
	{ 0, 0, 1, 0, 1, 0, 1, 0, 0 },
	{ 0, 1, 0, 1, 1, 1, 0, 1, 0 },
	{ 1, 0, 1, 0, 1, 0, 1, 0, 1 },
	{ 0, 1, 0, 1, 1, 1, 0, 1, 0 },
	{ 1, 0, 1, 1, 3, 1, 1, 0, 1 },
	{ 0, 1, 0, 1, 1, 1, 1, 1, 0 },
	{ 1, 0, 1, 0, 1, 0, 1, 0, 1 },
	{ 0, 1, 0, 1, 1, 1, 0, 1, 0 },
	{ 0, 0, 1, 0, 1, 0, 1, 0, 0 },
}

local area = createCombatArea(arr)
combat:setArea(area)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if player:getStorageValue(Storage.Quest.Crandoria.Spells.Spell1) < 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to learn this spell first.")
		return false
	else
		return combat:execute(creature, var)
	end
end

spell:group("attack", "focus")
spell:id(304)
spell:name("Death Hug")
spell:words("exevo gran mort vex")
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_DEATH_STRIKE)
spell:level(700)
spell:mana(4000)
spell:isSelfTarget(true)
spell:isPremium(true)
spell:cooldown(20 * 1000)
spell:groupCooldown(4 * 1000, 20 * 1000)
spell:needLearn(false)
spell:vocation("sorcerer;true", "Master sorcerer;true")
spell:register()