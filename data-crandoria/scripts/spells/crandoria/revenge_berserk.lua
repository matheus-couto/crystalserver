local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_USECHARGES, 1)

local condition = Condition(CONDITION_BLEEDING)
condition:setParameter(CONDITION_PARAM_DELAYED, 10)
condition:addDamage(14, 2000, -100)
combat:addCondition(condition)

function table.contains(table, element)
	for _, value in pairs(table) do
		if value == element then
			return true
		end
	end
	return false
end

function onGetFormulaValues(player, skill, attack, factor)
	local level = player:getLevel()
	local handWeapon = player:getSlotItem(CONST_SLOT_LEFT)
	local fist = player:getEffectiveSkillLevel(SKILL_FIST)

	local min = (((level / 5) + (skill + 2 * attack) * 1.8) * 1.1) + (((attack / 6) * (fist)) / 100)
	local max = (((level / 5) + (skill + 2 * attack) * 3.5) * 1.1) + (((attack / 6) * (fist)) / 100)

	local life = (player:getHealth() / player:getMaxHealth()) * 100

	local newMin, newMax

	if life >= 80 then
		newMin = min * 1
		newMax = max * 1
	elseif life < 80 and life >= 60 then
		newMin = min * 1.03
		newMax = max * 1.03
	elseif life < 60 and life >= 40 then
		newMin = min * 1.06
		newMax = max * 1.06
	elseif life < 40 and life >= 20 then
		newMin = min * 1.09
		newMax = max * 1.09
	elseif life < 20 then
		newMin = min * 1.12
		newMax = max * 1.12
	end

    return -newMin, -newMax

end
-----

local arr = {
	{ 1, 0, 1, 0, 1 },
	{ 0, 1, 1, 1, 0 },
	{ 1, 1, 3, 1, 1 },
	{ 0, 1, 1, 1, 0 },
	{ 1, 0, 1, 0, 1 },
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
spell:id(301)
spell:name("Revenge Berserk")
spell:words("exori gran rev")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_FIERCE_BERSERK)
spell:level(700)
spell:mana(425)
spell:isPremium(true)
spell:needWeapon(true)
spell:cooldown(8 * 1000)
spell:groupCooldown(4 * 1000)
spell:needLearn(false)
spell:vocation("knight;true", "elite knight;true")
spell:register()