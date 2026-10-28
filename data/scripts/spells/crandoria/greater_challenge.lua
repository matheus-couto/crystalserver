local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setArea(createCombatArea(AREA_CIRCLE2X2))

function onTargetCreature(creature, target)
	return doChallengeCreature(creature, target)
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	local player = creature:getPlayer()
	if player then
		local storage = player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso)
		if storage >= 229 then
			return combat:execute(creature, variant)
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao sabe como usar essa spell.")
			return false
		end
	end
end

spell:name("Greater Challenge")
spell:words("exeta gran res")
spell:group("support")
spell:vocation("elite knight;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_CHALLENGE)
spell:id(500)
spell:cooldown(4 * 1000)
spell:groupCooldown(2 * 1000)
spell:level(500)
spell:mana(100)
spell:isAggressive(false)
spell:isPremium(true)

spell:register()
