local AREA_FROM_POS = Position(33699, 31659, 14)
local AREA_TO_POS   = Position(33716, 31675, 14)
local DAMAGE_MIN    = 2500
local DAMAGE_MAX    = 3000
local DELAY_MS      = 6000

local spell = Spell("instant")
function spell.onCastSpell(creature, variant)
    if not creature or not creature:isMonster() then
        return false
    end

    creature:say("Goshnar's Cruelty begins to channel its energy! Prepare!", TALKTYPE_MONSTER_SAY)

    addEvent(function()
        for x = AREA_FROM_POS.x, AREA_TO_POS.x do
            for y = AREA_FROM_POS.y, AREA_TO_POS.y do
                local pos = Position(x, y, AREA_FROM_POS.z)

                -- efeito visual em TODO o retângulo
                pos:sendMagicEffect(CONST_ME_ORANGE_ENERGY_SPARK)

                -- aplicar dano em jogadores naquela tile
                local tile = Tile(pos)
                if tile then
                    for _, spectator in pairs(tile:getCreatures() or {}) do
                        if spectator:isPlayer() then
                            local dmg = math.random(DAMAGE_MIN, DAMAGE_MAX)
                            spectator:addHealth(-dmg)
                        end
                    end
                end
            end
        end
    end, DELAY_MS)

    return true
end

spell:name("goshnar energy burst")
spell:words("###747")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()
