local WHITE_TILE_ID = 409
local ORIGINAL_TILE_ID = 410

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_REDSMOKE)

-- Lista de áreas possíveis
local areaConfigs = {
    {
		fromPos = Position(33698, 31588, 14),
		toPos = Position(33720, 31610, 14),
        excluded = {
            ["33708:31597:14"] = true,
            ["33709:31597:14"] = true,
            ["33710:31597:14"] = true,
            ["33708:31601:14"] = true,
            ["33709:31601:14"] = true,
            ["33710:31601:14"] = true,
            ["33707:31598:14"] = true,
            ["33707:31599:14"] = true,
            ["33707:31600:14"] = true,
            ["33711:31598:14"] = true,
            ["33711:31599:14"] = true,
            ["33711:31600:14"] = true,
        }
    },
    {
		fromPos = Position(33698, 31588, 14),
		toPos = Position(33720, 31610, 14),
        excluded = {
            ["33704:31597:14"] = true,
            ["33705:31597:14"] = true,
            ["33706:31597:14"] = true,
            ["33704:31598:14"] = true,
            ["33705:31598:14"] = true,
            ["33706:31598:14"] = true,
            ["33704:31599:14"] = true,
            ["33705:31599:14"] = true,
            ["33706:31599:14"] = true,
            ["33704:31600:14"] = true,
            ["33705:31600:14"] = true,
            ["33706:31600:14"] = true,
            ["33704:31601:14"] = true,
            ["33705:31601:14"] = true,
            ["33706:31601:14"] = true,
        }
    },
    {
		fromPos = Position(33698, 31588, 14),
		toPos = Position(33720, 31610, 14),
        excluded = {
            ["33705:31594:14"] = true,
            ["33706:31594:14"] = true,
            ["33707:31594:14"] = true,
            ["33715:31595:14"] = true,
            ["33715:31601:14"] = true,
            ["33715:31602:14"] = true,
            ["33709:31599:14"] = true,
            ["33704:31602:14"] = true,
            ["33705:31603:14"] = true,
        }
    },
    {
		fromPos = Position(33698, 31588, 14),
		toPos = Position(33720, 31610, 14),
        excluded = {
            ["33706:31595:14"] = true,
            ["33707:31595:14"] = true,
            ["33712:31597:14"] = true,
            ["33713:31597:14"] = true,
            ["33706:31601:14"] = true,
            ["33707:31601:14"] = true,
            ["33712:31604:14"] = true,
            ["33713:31604:14"] = true,
        }
    }
}

local function serializePosition(pos)
    return string.format("%d:%d:%d", pos.x, pos.y, pos.z)
end

local function isExcluded(pos, excludedTable)
    return excludedTable[serializePosition(pos)] == true
end

local function flashExcludedTiles(area)
    for key in pairs(area.excluded) do
        local x,y,z = key:match("(%d+):(%d+):(%d+)")
        local pos = Position(tonumber(x), tonumber(y), tonumber(z))
        local tile = Tile(pos)
        if tile then
            local item = tile:getItemById(ORIGINAL_TILE_ID)
            if item then
                item:transform(WHITE_TILE_ID)
                addEvent(function()
                    local t = Tile(pos)
                    local w = t and t:getItemById(WHITE_TILE_ID)
                    if w then w:transform(ORIGINAL_TILE_ID) end
                end, 5000)
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
    local min, max = 7000, 9000
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
    creature:say("A MALICIOUS SOUL FLOOD IS IMMINENT!", TALKTYPE_ORANGE_2)
    local area = areaConfigs[math.random(#areaConfigs)]
    flashExcludedTiles(area)
    addEvent(delayedCastSpell, 5000, creature:getId(), var, area)
    return true
end


spell:name("goshnars malice death")
spell:words("###739")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()


-- local WHITE_TILE_ID = 409
-- local ORIGINAL_TILE_ID = 410

-- local combat = Combat()
-- combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
-- combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)

-- -- Lista de áreas possíveis
-- local areaConfigs = {
--     {
-- 		fromPos = Position(33698, 31588, 14),
-- 		toPos = Position(33720, 31610, 14),
--         excluded = {
--             ["33708:31597:14"] = true,
--             ["33709:31597:14"] = true,
--             ["33710:31597:14"] = true,
--             ["33708:31601:14"] = true,
--             ["33709:31601:14"] = true,
--             ["33710:31601:14"] = true,
--             ["33707:31598:14"] = true,
--             ["33707:31599:14"] = true,
--             ["33707:31600:14"] = true,
--             ["33711:31598:14"] = true,
--             ["33711:31599:14"] = true,
--             ["33711:31600:14"] = true,
--         }
--     },
--     {
-- 		fromPos = Position(33698, 31588, 14),
-- 		toPos = Position(33720, 31610, 14),
--         excluded = {
--             ["33704:31597:14"] = true,
--             ["33705:31597:14"] = true,
--             ["33706:31597:14"] = true,
--             ["33704:31598:14"] = true,
--             ["33705:31598:14"] = true,
--             ["33706:31598:14"] = true,
--             ["33704:31599:14"] = true,
--             ["33705:31599:14"] = true,
--             ["33706:31599:14"] = true,
--             ["33704:31600:14"] = true,
--             ["33705:31600:14"] = true,
--             ["33706:31600:14"] = true,
--             ["33704:31601:14"] = true,
--             ["33705:31601:14"] = true,
--             ["33706:31601:14"] = true,
--         }
--     },
--     {
-- 		fromPos = Position(33698, 31588, 14),
-- 		toPos = Position(33720, 31610, 14),
--         excluded = {
--             ["33705:31594:14"] = true,
--             ["33706:31594:14"] = true,
--             ["33707:31594:14"] = true,
--             ["33715:31595:14"] = true,
--             ["33715:31601:14"] = true,
--             ["33715:31602:14"] = true,
--             ["33709:31599:14"] = true,
--             ["33704:31602:14"] = true,
--             ["33705:31603:14"] = true,
--         }
--     },
--     {
-- 		fromPos = Position(33698, 31588, 14),
-- 		toPos = Position(33720, 31610, 14),
--         excluded = {
--             ["33706:31595:14"] = true,
--             ["33707:31595:14"] = true,
--             ["33712:31597:14"] = true,
--             ["33713:31597:14"] = true,
--             ["33706:31601:14"] = true,
--             ["33707:31601:14"] = true,
--             ["33712:31604:14"] = true,
--             ["33713:31604:14"] = true,
--         }
--     }
-- }

-- local function serializePosition(pos)
--     return string.format("%d:%d:%d", pos.x, pos.y, pos.z)
-- end

-- local function isExcluded(pos, excludedTable)
--     return excludedTable[serializePosition(pos)] == true
-- end

-- local function flashExcludedTiles(area)
--     for key, _ in pairs(area.excluded) do
--         local x, y, z = key:match("(%d+):(%d+):(%d+)")
--         local pos = Position(tonumber(x), tonumber(y), tonumber(z))
--         local tile = Tile(pos)
--         if tile then
--             local item = tile:getItemById(ORIGINAL_TILE_ID)
--             if item then
--                 item:transform(WHITE_TILE_ID)
--                 addEvent(function()
--                     local tileNow = Tile(pos)
--                     local whiteItem = tileNow and tileNow:getItemById(WHITE_TILE_ID)
--                     if whiteItem then
--                         whiteItem:transform(ORIGINAL_TILE_ID)
--                     end
--                 end, 5000)
--             end
--         end
--     end
-- end

-- local function dealAreaDamage(creature, area)
--     local min, max = 7000, 9000
--     for x = area.fromPos.x, area.toPos.x do
--         for y = area.fromPos.y, area.toPos.y do
--             local pos = Position(x, y, area.fromPos.z)
--             if not isExcluded(pos, area.excluded) then
--                 local tile = Tile(pos)
--                 if tile then
--                     for _, thing in ipairs(tile:getCreatures()) do
--                         if thing:isPlayer() or thing:isMonster() then
--                             doTargetCombatHealth(creature, thing, COMBAT_DEATHDAMAGE, -min, -max, CONST_ME_NONE)
--                         end
--                     end
--                     pos:sendMagicEffect(CONST_ME_REDSMOKE)
--                 end
--             end
--         end
--     end
-- end

-- local function delayedCastSpell(cid, var, area)
--     local creature = Creature(cid)
--     if not creature then return end
--     dealAreaDamage(creature, area)
-- end

-- local spell = Spell("instant")

-- function spell.onCastSpell(creature, var)
--     creature:say("A MALICIOUS SOUL FLOOD IS IMMINENT!", TALKTYPE_ORANGE_2)
    
--     local area = areaConfigs[math.random(#areaConfigs)]
--     flashExcludedTiles(area)
--     addEvent(delayedCastSpell, 5000, creature:getId(), var, area)

--     return true
-- end

-- spell:name("goshnars malice death")
-- spell:words("###739")
-- spell:isAggressive(true)
-- spell:blockWalls(true)
-- spell:needLearn(true)
-- spell:register()


