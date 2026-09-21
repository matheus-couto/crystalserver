local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)

local area = createCombatArea(AREA_WAVE10)
combat:setArea(area)

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 4) + (maglevel * 10)
	local max = (level / 4) + (maglevel * 16)
	return -min, -max
end
-----

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points) >= 500 then
		local maxhp = player:getMaxHealth()
		local hpnow = player:getHealth()
		local hp = math.min(maxhp - hpnow, maxhp * 0.2)
		player:addHealth(hp)
		return combat:execute(creature, var)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao possui reputacao o suficiente.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end
end

spell:group("attack")
spell:id(349)
spell:name("Power of Void")
spell:words("exevo mort honor")
spell:needDirection(true)
spell:castSound(SOUND_EFFECT_TYPE_SPELL_FIERCE_BERSERK)
spell:level(200)
spell:mana(500)
spell:isPremium(true)
spell:cooldown(30 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
-- spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()