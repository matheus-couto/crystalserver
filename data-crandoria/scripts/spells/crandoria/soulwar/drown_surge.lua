local damage = 3000
local effect = CONST_ME_SMALLCLOUDS
local damageType = COMBAT_DROWNDAMAGE

local positions = {
    Position(33708, 31659, 14),
    Position(33708, 31660, 14),
    Position(33708, 31661, 14),
    Position(33708, 31662, 14)
}

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
    for _, pos in ipairs(positions) do
        pos:sendMagicEffect(effect)

        local tile = Tile(pos)
        if tile then
            for _, target in ipairs(tile:getCreatures()) do
                if target:isPlayer() or target:getName() == "Poor Soul" then
                    -- Faz o dano funcionar mesmo contra monstros, forçando o ataque
                    local combat = Combat()
                    combat:setParameter(COMBAT_PARAM_TYPE, damageType)
                    combat:setParameter(COMBAT_PARAM_EFFECT, effect)
                    combat:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
                    combat:execute(creature, Variant(target:getPosition()))
                    target:addHealth(-damage)
                end
            end
        end
    end
    return true
end

spell:name("drown surge")
spell:words("###745")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()
