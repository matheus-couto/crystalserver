local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GROUNDSHAKER)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_USECHARGES, 1)
-- combat:setArea(createCombatArea(AREA_SQUARE1X1))
local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 5000)
condition:setFormula(-0.45, 0, -0.75, 0)
combat:addCondition(condition)

local area = {
	{0, 0, 1, 0, 0},
	{0, 1, 1, 1, 0},
	{1, 1, 3, 1, 1},
	{0, 1, 1, 1, 0},
	{0, 0, 1, 0, 0}
}

combat:setArea(createCombatArea(area))

function onGetFormulaValues(player, skill, attack, factor)
	local level = player:getLevel()
	local handWeapon = player:getSlotItem(CONST_SLOT_LEFT)
	local fist = player:getEffectiveSkillLevel(SKILL_FIST)

	local min = (((level / 4) + (skill + 2 * attack) * 2.55) * 1.1) + (((attack / 6) * (fist)) / 100)
	local max = (((level / 4) + (skill + 2 * attack) * 4) * 1.1) + (((attack / 6) * (fist)) / 100)

	return -min, -max

end
-----

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points) >= 500 then
		return combat:execute(creature, var)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao possui reputacao o suficiente.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end
end

spell:group("attack")
spell:id(347)
spell:name("Knight's Doom")
spell:words("exori honor")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_FIERCE_BERSERK)
spell:level(200)
spell:mana(400)
spell:isPremium(true)
spell:needWeapon(true)
spell:cooldown(30 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
-- spell:vocation("knight;true", "elite knight;true")
spell:register()