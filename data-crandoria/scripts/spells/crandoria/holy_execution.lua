-- local combat = Combat()
-- combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
-- combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYAREA)
-- combat:setArea(createCombatArea(AREA_CIRCLE3X3))

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_HOLY)
combat:setArea(createCombatArea(AREA_CIRCLE2X2))

function onGetFormulaValues(player, level, maglevel)
	local level = player:getLevel()
	local handWeapon = player:getSlotItem(CONST_SLOT_LEFT)
	local fist = player:getEffectiveSkillLevel(SKILL_FIST)

	local min = ((level / 4) + (maglevel * 5)) * 1.1
	local max = ((level / 4) + (maglevel * 7)) * 1.1
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
spell:id(348)
spell:name("Holy Execution")
spell:words("exevo san honor")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_FIERCE_BERSERK)
spell:level(200)
spell:mana(430)
spell:isPremium(true)
spell:needWeapon(true)
spell:cooldown(30 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:needTarget(true)
-- spell:vocation("paladin;true", "royal paladin;true")
spell:register()