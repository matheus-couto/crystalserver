local TENTACLE_NAME = "Tentugly Tentacle"

local tentaclePositions = {
    Position(5933, 5517, 7),
    Position(5935, 5515, 7),
    Position(5936, 5518, 7),
    Position(5937, 5512, 7),
    Position(5938, 5514, 7),
    Position(5938, 5521, 7),
    Position(5941, 5512, 7),
    Position(5941, 5521, 7),
    Position(5942, 5517, 7),
    Position(5944, 5514, 7),
    Position(5944, 5520, 7)
}

local MAX_SPAWN = 3

local function isTentacleAt(pos)
    local tile = Tile(pos)
    if not tile then
        return false
    end

    local creature = tile:getTopCreature()
    return creature and creature:isMonster() and creature:getName() == TENTACLE_NAME
end

local combat = Combat()
local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
    if not creature or not creature:isMonster() then
        return false
    end

    local chosen = {}
    local countFree = 0

    -- ÚNICO LOOP
    for _, pos in ipairs(tentaclePositions) do
        if not isTentacleAt(pos) then
            countFree = countFree + 1

            if #chosen < MAX_SPAWN then
                chosen[#chosen + 1] = pos
            else
                -- substituição aleatória
                local r = math.random(countFree)
                if r <= MAX_SPAWN then
                    chosen[r] = pos
                end
            end
        end
    end

    -- Spawn
    for i = 1, #chosen do
        Game.createMonster(TENTACLE_NAME, chosen[i], true, true)
    end

    return true
end

spell:name("Tentugly Random Tentacles")
spell:words("###768")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(false)
spell:needDirection(false)
spell:register()