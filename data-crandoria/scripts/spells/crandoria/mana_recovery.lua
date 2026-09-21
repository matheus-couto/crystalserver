local combat = Combat()
local cooldown = 60000 -- milis

combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local condition = Condition(CONDITION_REGENERATION)
condition:setParameter(CONDITION_PARAM_TICKS, cooldown)
condition:setParameter(CONDITION_PARAM_MANAGAIN, 40)
condition:setParameter(CONDITION_PARAM_MANATICKS, 3000) -- 3sec
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, true)
combat:addCondition(condition)

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:name("Mana Recovery")
spell:words("unera gran")
spell:group("healing")
spell:vocation("knight;true", "elite knight;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_INTENSE_RECOVERY)
spell:id(335)
spell:cooldown(120000)
spell:groupCooldown(1000)
spell:level(60)

spell:isSelfTarget(true)
spell:isAggressive(false)
spell:isPremium(true)
spell:needLearn(false)
spell:register()
