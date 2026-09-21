local combat = Combat()

-- Função para selecionar um elemento aleatoriamente
local function getRandomElement()
    local elements = {
        {type = COMBAT_ICEDAMAGE, effect = CONST_ME_ICEATTACK, distanceEffect = CONST_ANI_SMALLICE},
        {type = COMBAT_FIREDAMAGE, effect = CONST_ME_FIREATTACK, distanceEffect = CONST_ANI_FIRE}
    }

    -- Seleciona um elemento aleatório
    local randomElement = elements[math.random(#elements)]
    return randomElement.type, randomElement.effect, randomElement.distanceEffect
end

-- Definir a callback da spell de chain
function getChainValue(creature)
    return 2, 3, false -- Mantenha os valores da chain (2 saltos, distância de 3, sem dano em si mesmo)
end

-- Função de combate que seleciona o elemento aleatório
local function executeRandomCombat(creature, var)
    local damageType, effect, distanceEffect = getRandomElement()

    -- Definir os parâmetros do combate com base no elemento sorteado
    combat:setParameter(COMBAT_PARAM_TYPE, damageType)
    combat:setParameter(COMBAT_PARAM_EFFECT, effect)
    combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, distanceEffect)

    -- Executa o combate com os parâmetros aleatórios
    return combat:execute(creature, var)
end

combat:setCallback(CALLBACK_PARAM_CHAINVALUE, "getChainValue")

-- Definir o comportamento da spell
local spell = Spell("instant")

function spell.onCastSpell(creature, var)
    return executeRandomCombat(creature, var)
end

spell:name("fire ice chain")
spell:words("###6080")
spell:needLearn(true)
spell:cooldown("2000")
spell:isSelfTarget(true)
spell:register()