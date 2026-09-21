-- Definição dos efeitos de silence (5 segundos)
local exhaustAttackGroup = Condition(CONDITION_SPELLGROUPCOOLDOWN)
exhaustAttackGroup:setParameter(CONDITION_PARAM_SUBID, 1)
exhaustAttackGroup:setParameter(CONDITION_PARAM_TICKS, 5000)

local exhaustHealGroup = Condition(CONDITION_SPELLGROUPCOOLDOWN)
exhaustHealGroup:setParameter(CONDITION_PARAM_SUBID, 2)
exhaustHealGroup:setParameter(CONDITION_PARAM_TICKS, 5000)

local exhaustSupportGroup = Condition(CONDITION_SPELLGROUPCOOLDOWN)
exhaustSupportGroup:setParameter(CONDITION_PARAM_SUBID, 3)
exhaustSupportGroup:setParameter(CONDITION_PARAM_TICKS, 5000)

local exhaustFourthGroup = Condition(CONDITION_SPELLGROUPCOOLDOWN)
exhaustFourthGroup:setParameter(CONDITION_PARAM_SUBID, 4)
exhaustFourthGroup:setParameter(CONDITION_PARAM_TICKS, 5000)

local exhaustFifthGroup = Condition(CONDITION_SPELLGROUPCOOLDOWN)
exhaustFifthGroup:setParameter(CONDITION_PARAM_SUBID, 5)
exhaustFifthGroup:setParameter(CONDITION_PARAM_TICKS, 5000)

local exhaustSixthGroup = Condition(CONDITION_SPELLGROUPCOOLDOWN)
exhaustSixthGroup:setParameter(CONDITION_PARAM_SUBID, 6)
exhaustSixthGroup:setParameter(CONDITION_PARAM_TICKS, 5000)

local exhaustSeventhGroup = Condition(CONDITION_SPELLGROUPCOOLDOWN)
exhaustSeventhGroup:setParameter(CONDITION_PARAM_SUBID, 7)
exhaustSeventhGroup:setParameter(CONDITION_PARAM_TICKS, 5000)

-- Função para aplicar o silence nos jogadores atingidos
local function applySilence(target)
    if not target or not target:isPlayer() then
        return
    end
    target:addCondition(exhaustAttackGroup)
    target:addCondition(exhaustHealGroup)
    target:addCondition(exhaustSupportGroup)
    target:addCondition(exhaustFourthGroup)
    target:addCondition(exhaustFifthGroup)
    target:addCondition(exhaustSixthGroup)
    target:addCondition(exhaustSeventhGroup)
end

-- Configuração do combate
local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_LIFEDRAIN)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GHOST_SMOKE)
combat:setArea(createCombatArea(AREA_CIRCLE2X2))

-- Dano e efeito nos alvos
function onTargetCreature(creature, target)
    local damageMin = -500
    local damageMax = -1500

    doTargetCombatHealth(creature, target, COMBAT_LIFEDRAIN, damageMin, damageMax, CONST_ME_DRAWBLOOD)

    -- Aplica silence se for player
    applySilence(target)
    return true
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

-- Spell principal
local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
    return combat:execute(creature, variant)
end

spell:name("silence explosion")
spell:words("###764")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()