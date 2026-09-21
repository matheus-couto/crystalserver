local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEATTACK)
combat:setParameter(COMBAT_PARAM_CHAIN_EFFECT, CONST_ME_ICEAREA)

function getChainValue(creature)
	return 2, 3, false
end

combat:setCallback(CALLBACK_PARAM_CHAINVALUE, "getChainValue")


function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 2.5) + 4
	local max = (level / 5) + (maglevel * 4.2) + 12

  if handWeapon and handWeapon.itemid == 36669 then
	  -- Aplica um multiplicador de 15% aos valores min e max
	  NewMin = -min * 1.05
	  NewMax = -max * 1.1

  return NewMin, NewMax

  else

  return -min, -max
end
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(344)
spell:name("Summoner Ice Chain")
spell:words("onora amp frigo")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_ICE_WAVE)
spell:level(200)
spell:mana(140)
spell:isPremium(true)
spell:cooldown(4 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("summoner;true", "ancient summoner;true","elder druid;true")
spell:register()