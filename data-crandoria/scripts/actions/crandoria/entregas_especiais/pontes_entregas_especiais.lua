local leverEntregasEspeciais = Action()

-- CONFIGURAÇÕES GERAIS
local LEVER_RIGHT = 2773
local LEVER_LEFT = 2772
local BRIDGE_ID = 5770
local BRIDGE_TIME = 15 * 1000 -- 15 segundos

-- CONJUNTOS DE ALAVANCAS
local leverSets = {
    {
        requiredLeverId = LEVER_RIGHT, -- CONJUNTO 1
        levers = {
            Position(5081, 4471, 8),
            Position(5082, 4471, 8),
            Position(5081, 4473, 8),
            Position(5082, 4473, 8)
        },
        bridgePos = Position(5083, 4472, 8)
    },
    {
        requiredLeverId = LEVER_LEFT, -- CONJUNTO 2 (ESQUERDA)
        levers = {
            Position(5374, 4690, 8),
            Position(5375, 4690, 8),
            Position(5374, 4693, 8),
            Position(5375, 4693, 8)
        },
        bridgePos = Position(5376, 4692, 8)
    },
    {
        requiredLeverId = LEVER_RIGHT, -- CONJUNTO 3
        levers = {
            Position(5526, 5140, 8),
            Position(5527, 5140, 8),
            Position(5526, 5143, 8),
            Position(5527, 5143, 8)
        },
        bridgePos = Position(5529, 5142, 8)
    }
}

-- FUNÇÃO: compara posições
local function positionEquals(p1, p2)
    return p1.x == p2.x and p1.y == p2.y and p1.z == p2.z
end

-- FUNÇÃO: retorna o conjunto da alavanca usada
local function getLeverSet(fromPosition)
    for _, set in ipairs(leverSets) do
        for _, pos in ipairs(set.levers) do
            if positionEquals(pos, fromPosition) then
                return set
            end
        end
    end
    return nil
end

-- FUNÇÃO: checa se todas as alavancas estão na posição correta
local function allLeversActivated(set)
    for _, pos in ipairs(set.levers) do
        local tile = Tile(pos)
        if not tile or not tile:getItemById(set.requiredLeverId) then
            return false
        end
    end
    return true
end

-- FUNÇÃO: randomiza alavancas do conjunto
local function randomizeLevers(set)
    for _, pos in ipairs(set.levers) do
        local tile = Tile(pos)
        if tile then
            local lever = tile:getItemById(LEVER_RIGHT) or tile:getItemById(LEVER_LEFT)
            if lever then
                lever:transform(math.random(0, 1) == 1 and LEVER_RIGHT or LEVER_LEFT)
            end
        end
    end
end

function leverEntregasEspeciais.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local set = getLeverSet(fromPosition)
    if not set then
        return true
    end

    -- alterna a alavanca usada
    item:transform(item.itemid == LEVER_RIGHT and LEVER_LEFT or LEVER_RIGHT)

    -- checa ativação
    if not allLeversActivated(set) then
        return true
    end

    -- cria ponte
    if not Tile(set.bridgePos):getItemById(BRIDGE_ID) then
        Game.createItem(BRIDGE_ID, 1, set.bridgePos)
        set.bridgePos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
    end

    -- remove ponte e randomiza
    addEvent(function()
        local tile = Tile(set.bridgePos)
        if tile then
            local bridge = tile:getItemById(BRIDGE_ID)
            if bridge then
                bridge:transform(4597)
                set.bridgePos:sendMagicEffect(CONST_ME_POFF)
            end
        end
        randomizeLevers(set)
    end, BRIDGE_TIME)

    return true
end

leverEntregasEspeciais:aid(13179)
leverEntregasEspeciais:register()

-- local leverEntregasEspeciais = Action()

-- -- CONFIGURAÇÕES GERAIS
-- local LEVER_RIGHT = 2773
-- local LEVER_LEFT = 2772
-- local BRIDGE_ID = 5770
-- local BRIDGE_TIME = 15 * 1000 -- 15 segundos

-- -- CONJUNTOS DE ALAVANCAS
-- local leverSets = {
--     {
--         levers = {
--             Position(5081, 4471, 8),
--             Position(5082, 4471, 8),
--             Position(5081, 4473, 8),
--             Position(5082, 4473, 8)
--         },
--         bridgePos = Position(5083, 4472, 8)
--     },
--     {
--         levers = {
--             Position(5374, 4690, 8),
--             Position(5375, 4690, 8),
--             Position(5374, 4693, 8),
--             Position(5375, 4693, 8)
--         },
--         bridgePos = Position(5376, 4692, 8)
--     },
--     {
--         levers = {
--             Position(5526, 5140, 8),
--             Position(5527, 5140, 8),
--             Position(5526, 5143, 8),
--             Position(5527, 5143, 8)
--         },
--         bridgePos = Position(5529, 5142, 8)
--     }
-- }

-- -- FUNÇÃO: verifica se posição pertence ao conjunto
-- local function positionEquals(p1, p2)
--     return p1.x == p2.x and p1.y == p2.y and p1.z == p2.z
-- end

-- -- FUNÇÃO: retorna o conjunto da alavanca usada
-- local function getLeverSet(fromPosition)
--     for _, set in ipairs(leverSets) do
--         for _, pos in ipairs(set.levers) do
--             if positionEquals(pos, fromPosition) then
--                 return set
--             end
--         end
--     end
--     return nil
-- end

-- -- FUNÇÃO: checa se todas as alavancas do conjunto estão ativas
-- local function allLeversActivated(set)
--     for _, pos in ipairs(set.levers) do
--         local tile = Tile(pos)
--         if not tile or not tile:getItemById(LEVER_RIGHT) then
--             return false
--         end
--     end
--     return true
-- end

-- -- FUNÇÃO: randomiza alavancas do conjunto
-- local function randomizeLevers(set)
--     for _, pos in ipairs(set.levers) do
--         local tile = Tile(pos)
--         if tile then
--             local lever = tile:getItemById(LEVER_RIGHT) or tile:getItemById(LEVER_LEFT)
--             if lever then
--                 lever:transform(math.random(0, 1) == 1 and LEVER_RIGHT or LEVER_LEFT)
--             end
--         end
--     end
-- end

-- function leverEntregasEspeciais.onUse(player, item, fromPosition, target, toPosition, isHotkey)
--     local set = getLeverSet(fromPosition)
--     if not set then
--         return true
--     end

--     -- alterna a alavanca usada
--     item:transform(item.itemid == LEVER_RIGHT and LEVER_LEFT or LEVER_RIGHT)

--     -- checa se todas estão ativadas
--     if not allLeversActivated(set) then
--         return true
--     end

--     -- cria ponte
--     if not Tile(set.bridgePos):getItemById(BRIDGE_ID) then
--         Game.createItem(BRIDGE_ID, 1, set.bridgePos)
--         set.bridgePos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
--     end

--     -- remove ponte e randomiza alavancas
--     addEvent(function()
--         local tile = Tile(set.bridgePos)
--         if tile then
--             local bridge = tile:getItemById(BRIDGE_ID)
--             if bridge then
--                 bridge:transform(4597)
--                 set.bridgePos:sendMagicEffect(CONST_ME_POFF)
--             end
--         end

--         randomizeLevers(set)
--     end, BRIDGE_TIME)

--     return true
-- end

-- leverEntregasEspeciais:aid(13179)
-- leverEntregasEspeciais:register()