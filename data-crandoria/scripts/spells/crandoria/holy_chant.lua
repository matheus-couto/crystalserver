local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYAREA)

local condition = Condition(CONDITION_DAZZLED)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:addDamage(14, 3000, -100)
combat:addCondition(condition)

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 4) * 1.25
	local max = (level / 5) + (maglevel * 6) * 1.25

	if handWeapon and handWeapon.itemid == 43877 then
		-- Aplica um multiplicador de 15% aos valores min e max
		NewMin = min * 1.05
		NewMax = max * 1.1

		return -NewMin, -NewMax

	elseif handWeapon and handWeapon.itemid == 43878 then
		-- Aplica um multiplicador de 15% aos valores min e max
		NewMin = min * 1.1
		NewMax = max * 1.15

		return -NewMin2, -NewMax2

	elseif handWeapon and handWeapon.itemid == 36665 then
		-- Aplica um multiplicador de 15% aos valores min e max
		NewMin = min * 1
		NewMax = max * 1.05

		return -NewMin, -NewMax

	else

		return -min, -max 

	end
end
-----

local arr = {
	{ 0, 0, 0, 0, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 1, 1, 0, 0, 0, 1, 1, 0 },
	{ 1, 1, 1, 0, 3, 0, 1, 1, 1 },
	{ 0, 1, 1, 0, 0, 0, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 0, 0, 0, 0 },
}

local area = createCombatArea(arr)
combat:setArea(area)

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

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

spell:group("attack")
spell:id(302)
spell:name("Holy Chant")
spell:words("exori chant san")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_DIVINE_CALDERA)
spell:level(700)
spell:mana(1200)
spell:isPremium(true)
-- spell:needWeapon(true)
spell:cooldown(20 * 1000)
spell:groupCooldown(4 * 1000)
spell:needLearn(false)
spell:vocation("paladin;true", "royal paladin;true")
spell:register()