local WHITE_TILE_ID = 409
local ORIGINAL_TILE_ID = 32394

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_REDSMOKE)

-- Lista de áreas possíveis
local areaConfigs = {
    {
		fromPos = Position(33700, 31625, 14),
		toPos = Position(33720, 31643, 14),
        excluded = {
            ["33704:31634:14"] = 32396,
            ["33705:31634:14"] = 32382,
            ["33706:31634:14"] = 32387,
            ["33704:31635:14"] = 32384,
            ["33705:31635:14"] = 32386,
            ["33706:31635:14"] = 32391,
            ["33704:31636:14"] = 32393,
            ["33705:31636:14"] = 32390,
            ["33706:31636:14"] = 32392,
        }
    },
    {
		fromPos = Position(33700, 31625, 14),
		toPos = Position(33720, 31643, 14),
        excluded = {
            ["33714:31634:14"] = 32396,
            ["33715:31634:14"] = 32382,
            ["33716:31634:14"] = 32387,
            ["33714:31635:14"] = 32384,
            ["33715:31635:14"] = 32386,
            ["33716:31635:14"] = 32391,
            ["33714:31636:14"] = 32393,
            ["33715:31636:14"] = 32390,
            ["33716:31636:14"] = 32392,
        }
    },
}

local function serializePosition(pos)
    return string.format("%d:%d:%d", pos.x, pos.y, pos.z)
end

local function isExcluded(pos, excludedTable)
    return excludedTable[serializePosition(pos)] ~= nil
end


local function flashExcludedTiles(area)
    for key, originalId in pairs(area.excluded) do
        local x, y, z = key:match("(%d+):(%d+):(%d+)")
        local pos = Position(tonumber(x), tonumber(y), tonumber(z))
        local tile = Tile(pos)
        if tile then
            local item = tile:getItemById(originalId)
            if item then
                item:transform(WHITE_TILE_ID)

                -- Destrói item 33984 se estiver presente no tile
                local destroyItem = tile:getItemById(33984)
                if destroyItem then
                    destroyItem:remove()
                end

                -- Agendamento para retornar ao ID original
                addEvent(function()
                    local t = Tile(pos)
                    local w = t and t:getItemById(WHITE_TILE_ID)
                    if w then
                        w:transform(originalId)
                    end
                end, 8000)
            end
        end
    end
end

-- Só causa dano em players e summons de players
local function shouldHurt(thing)
    if not thing then return false end
    if thing:isPlayer() then
        return true
    elseif thing:isMonster() and thing:getMaster() and thing:getMaster():isPlayer() then
        return true
    end
    return false
end

local function dealAreaDamage(creature, area)
    local min, max = 9500, 10000
    for x = area.fromPos.x, area.toPos.x do
        for y = area.fromPos.y, area.toPos.y do
            local pos = Position(x, y, area.fromPos.z)
            if not isExcluded(pos, area.excluded) then
                local tile = Tile(pos)
                if tile then
                    for _, thing in ipairs(tile:getCreatures()) do
                        if shouldHurt(thing) then
                            doTargetCombatHealth(creature, thing, COMBAT_DEATHDAMAGE, -min, -max, CONST_ME_NONE)
                        end
                    end
                    pos:sendMagicEffect(CONST_ME_REDSMOKE)
                end
            end
        end
    end
end

local function delayedCastSpell(cid, var, area)
    local creature = Creature(cid)
    if creature then
        dealAreaDamage(creature, area)
    end
end

local spell = Spell("instant")
function spell.onCastSpell(creature, var)
    creature:say(" FEEL THE POWER OF MY WRATH!!", TALKTYPE_ORANGE_2)
    local area = areaConfigs[math.random(#areaConfigs)]
    flashExcludedTiles(area)
    addEvent(delayedCastSpell, 8000, creature:getId(), var, area)
    return true
end


spell:name("megalomania doom")
spell:words("###761")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()



