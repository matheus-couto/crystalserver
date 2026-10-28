local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEAREA)
combat:setArea(createCombatArea(AREA_WAVE4, AREADIAGONAL_WAVE4))

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEAREA)
combat2:setArea(createCombatArea(AREA_WAVE4, AREADIAGONAL_WAVE4))

local condition = Condition(CONDITION_ROOTED)
condition:setParameter(CONDITION_PARAM_TICKS, 2000)
combat2:addCondition(condition)

local condition2 = Condition(CONDITION_OUTFIT)
condition2:setOutfit(6707)
condition2:setParameter(CONDITION_PARAM_TICKS, 2000)
combat2:addCondition(condition2)

function onGetFormulaValues(player, level, maglevel, basePower)
	local min = (calculateBaseDamageHealing(level)) + (maglevel * 1.5) + 25
	local max = (calculateBaseDamageHealing(level)) + (maglevel * 2.5) + 50
	return -min, -max
end

function onGetFormulaValuesS(player, level, maglevel, basePower)
	local min = (calculateBaseDamageHealing(level)) + (maglevel * 1.5) + 25
	local max = (calculateBaseDamageHealing(level)) + (maglevel * 2.5) + 50
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
combat2:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValuesS")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if player then
		local storage = player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso)
		if storage >= 229 then
			local chance = math.random(1, 3)
			if chance < 3 then
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
spell:id(503)
spell:name("Ice Freezing Wave")
spell:words("exevo max frigo hur")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_ICE_WAVE)
spell:level(500)
spell:mana(400)
spell:basePower(45)
spell:needDirection(true)
spell:cooldown(120 * 1000)
spell:groupCooldown(2 * 1000)
spell:vocation("druid;true", "elder druid;true")
spell:register()
