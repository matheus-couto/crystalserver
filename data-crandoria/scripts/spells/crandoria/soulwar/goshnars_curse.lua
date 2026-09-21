local AREA_FROM_POS = Position(33699, 31659, 14)
local AREA_TO_POS = Position(33716, 31675, 14)
local TRANSFORM_OUTFIT = 242
local TRANSFORM_TIME = 6000 -- 6 segundos
local DAMAGE_MIN = 2000
local DAMAGE_MAX = 3500

-- Criar a área e combate globalmente
local COMBAT_AREA = createCombatArea(AREA_CIRCLE3X3)
local combat = Combat()
combat:setArea(COMBAT_AREA)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)
combat:setFormula(COMBAT_FORMULA_DAMAGE, -DAMAGE_MIN, 0, -DAMAGE_MAX, 0)

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
    if not creature or not creature:isMonster() then
        return false
    end

    -- Encontrar um jogador aleatório na área
    local players = {}
    for x = AREA_FROM_POS.x, AREA_TO_POS.x do
        for y = AREA_FROM_POS.y, AREA_TO_POS.y do
            local pos = Position(x, y, AREA_FROM_POS.z)
            local tile = Tile(pos)
            if tile then
                for _, thing in pairs(tile:getCreatures() or {}) do
                    if thing:isPlayer() then
                        table.insert(players, thing)
                    end
                end
            end
        end
    end

    if #players == 0 then
        return false
    end

    -- Selecionar jogador aleatório
    local player = players[math.random(1, #players)]

    -- Aplicar condição de outfit temporário
    local outfitCondition = Condition(CONDITION_OUTFIT)
    outfitCondition:setParameter(CONDITION_PARAM_TICKS, TRANSFORM_TIME)
    outfitCondition:setParameter(CONDITION_PARAM_SUBID, 2)
    outfitCondition:setOutfit({lookType = TRANSFORM_OUTFIT})
    player:addCondition(outfitCondition)

    -- Mensagem de transformação
    creature:say("Goshnar's Cruelty sets " .. player:getName() .. " on fire!", TALKTYPE_MONSTER_SAY)

    -- Após 6 segundos, causar explosão na posição do jogador (com o monstro como caster)
    addEvent(function()
        if player and player:isPlayer() and creature and creature:isMonster() then
            combat:execute(creature, Variant(player:getPosition()))
        end
    end, TRANSFORM_TIME)

    return true
end

spell:name("goshnar curse")
spell:words("###748")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()
