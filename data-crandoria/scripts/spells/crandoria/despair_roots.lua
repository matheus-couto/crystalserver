local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ROOTS)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SMALLPLANTS)

local condition = Condition(CONDITION_ROOTED)
condition:setParameter(CONDITION_PARAM_TICKS, 2000)
combat:addCondition(condition)

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 6)
	local max = (level / 5) + (maglevel * 12)

	if handWeapon and handWeapon.itemid == 43885 then
		-- Aplica um multiplicador de 15% aos valores min e max
		NewMin = min * 1.05
		NewMax = max * 1.1

	return NewMin, NewMax

	elseif handWeapon and handWeapon.itemid == 43886 then
		-- Aplica um multiplicador de 15% aos valores min e max
		NewMin2 = min * 1.15
		NewMax2 = max * 1.15

	return NewMin2, NewMax2

	else

	return -min, -max
end
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local arr = {
	{ 0, 0, 1, 0, 0, 0, 1, 0, 0 },
	{ 0, 1, 0, 0, 1, 0, 0, 1, 0 },
	{ 1, 0, 0, 1, 1, 1, 0, 0, 1 },
	{ 0, 0, 1, 1, 0, 1, 1, 0, 0 },
	{ 0, 1, 1, 0, 3, 0, 1, 1, 0 },
	{ 0, 0, 1, 1, 0, 1, 1, 0, 0 },
	{ 1, 0, 0, 1, 1, 1, 0, 0, 1 },
	{ 0, 1, 0, 0, 1, 0, 0, 1, 0 },
	{ 0, 0, 1, 0, 0, 0, 1, 0, 0 },
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
spell:id(303)
spell:name("Despair Roots")
spell:words("exevo gran root tera")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_WRATH_OF_NATURE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_TERRA_STRIKE)
spell:level(700)
spell:mana(4000)
spell:isPremium(true)
spell:isSelfTarget(true)
spell:cooldown(20 * 1000)
spell:groupCooldown(4 * 1000, 20 * 1000)
spell:needLearn(false)
spell:vocation("druid;true", "elder druid;true")
spell:register()