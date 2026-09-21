local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setArea(createCombatArea(AREA_SQUARE1X1))

function onTargetCreature(creature, target)
	return doChallengeCreature(creature, target, 8000)
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	local master = creature:getMaster()
	creature:say('exeta res', TALKTYPE_MONSTER_SAY)
	if master then
		local storageSpell = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell)
		master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, storageSpell + 1)
	end
	
	return combat:execute(creature, variant)
end

spell:name("challenge merc")
spell:words("###772")
spell:blockWalls(true)
spell:needLearn(true)
spell:register()
