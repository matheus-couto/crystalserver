local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLHOLY)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
combat2:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLHOLY)

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 2000)
combat:addCondition(condition)

function onGetFormulaValues(player, level, maglevel, basePower)
	local min = (calculateBaseDamageHealing(level)) + (maglevel * 2.25) + 20
	local max = (calculateBaseDamageHealing(level)) + (maglevel * 3.5) + 35
	return -min, -max
end

function onGetFormulaValues2(player, level, maglevel, basePower)
	local min = (calculateBaseDamageHealing(level)) + (maglevel * 2.25) + 20
	local max = (calculateBaseDamageHealing(level)) + (maglevel * 3.5) + 35
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
combat2:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues2")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if player then
		local storage = player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso)
		if storage >= 229 then
			local chance = math.random(1, 2)
			if chance == 1 then
				return combat:execute(creature, var)
			else
				return combat2:execute(creature, var)
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao sabe como usar essa spell.")
			return false
		end
	end
end

spell:group("attack")
spell:id(501)
spell:name("Paralyze Missile")
spell:words("exori ani san")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_DIVINE_MISSILE)
spell:level(500)
spell:mana(80)
spell:basePower(80)
spell:isPremium(true)
spell:range(4)
spell:needCasterTargetOrDirection(true)
spell:blockWalls(true)
spell:cooldown(8 * 1000)
spell:groupCooldown(2 * 1000)
spell:vocation("paladin;true", "royal paladin;true")
spell:register()
