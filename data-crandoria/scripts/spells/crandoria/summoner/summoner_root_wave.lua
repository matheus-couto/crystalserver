local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ROOTS)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SMALLPLANTS)

local condition = Condition(CONDITION_ROOTED)
condition:setParameter(CONDITION_PARAM_TICKS, 2000)
combat:addCondition(condition)

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 1.1) + 4
	local max = (level / 5) + (maglevel * 1.75) + 12
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local area = createCombatArea(AREA_WAVE5, AREADIAGONAL_WAVE4)
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
spell:id(315)
spell:name("root wave")
spell:words("onora root")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_WRATH_OF_NATURE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_TERRA_STRIKE)
spell:level(700)
spell:mana(500)
spell:isPremium(true)
spell:cooldown(6 * 1000)
spell:needDirection(true)
spell:groupCooldown(2 * 1000, 6 * 1000)
spell:needLearn(false)
spell:vocation("summoner;true", "ancient summoner;true")
spell:register()