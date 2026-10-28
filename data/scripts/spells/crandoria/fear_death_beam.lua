local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_DEATHAREA)
combat:setArea(createCombatArea(AREA_BEAM6))

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_DEATHAREA)
combat2:setArea(createCombatArea(AREA_BEAM6))

local condition = Condition(CONDITION_FEARED)
condition:setParameter(CONDITION_PARAM_TICKS, 2000)
combat2:addCondition(condition)

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 6)
	local max = (level / 5) + (maglevel * 10)
	return -min, -max
end

function onGetFormulaValues2(player, level, maglevel)
	local min = (level / 5) + (maglevel * 7)
	local max = (level / 5) + (maglevel * 10)
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

spell:group("attack", "greatbeams")
spell:id(502)
spell:name("Fear Death Beam")
spell:words("exevo nox mort")
spell:level(500)
spell:mana(320)
spell:basePower(250)
spell:isPremium(false)
spell:needDirection(true)
spell:blockWalls(true)
spell:cooldown(60 * 1000)
spell:groupCooldown(2 * 1000, 6 * 1000)
spell:needLearn(false)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
