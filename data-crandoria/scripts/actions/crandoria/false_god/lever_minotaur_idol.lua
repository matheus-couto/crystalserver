

local playerPositions = {
    Position(4748, 4495, 15),
    Position(4747, 4495, 15),
    Position(4746, 4495, 15),
    Position(4745, 4495, 15),
    Position(4744, 4495, 15)
}

local teleportPosition = Position(4751, 4495, 15)
local kickPosition = Position(4749, 4491, 15)

local roomFrom = Position(4751, 4492, 15)
local roomTo   = Position(4773, 4499, 15)

local statues = {
    {pos = Position(4752, 4492, 15), id = 25300},
    {pos = Position(4754, 4492, 15), id = 25300},
    {pos = Position(4756, 4492, 15), id = 25300},
    {pos = Position(4758, 4492, 15), id = 25300},
    {pos = Position(4760, 4492, 15), id = 25300},
    {pos = Position(4762, 4492, 15), id = 25300},
    {pos = Position(4764, 4492, 15), id = 25300},
    {pos = Position(4766, 4492, 15), id = 25300},
    {pos = Position(4768, 4492, 15), id = 25300},
    {pos = Position(4770, 4492, 15), id = 25300},
    {pos = Position(4772, 4492, 15), id = 25300},

    {pos = Position(4752, 4498, 15), id = 25301},
    {pos = Position(4754, 4498, 15), id = 25301},
    {pos = Position(4756, 4498, 15), id = 25301},
    {pos = Position(4758, 4498, 15), id = 25301},
    {pos = Position(4760, 4498, 15), id = 25301},
    {pos = Position(4762, 4498, 15), id = 25301},
    {pos = Position(4764, 4498, 15), id = 25301},
    {pos = Position(4766, 4498, 15), id = 25301},
    {pos = Position(4768, 4498, 15), id = 25301},
    {pos = Position(4770, 4498, 15), id = 25301},
    {pos = Position(4772, 4498, 15), id = 25301},
}

-- Função para checar jogadores na área
local function hasPlayerInArea(fromPosition, toPosition)
    for x = fromPosition.x, toPosition.x do
        for y = fromPosition.y, toPosition.y do
            local pos = Position(x, y, fromPosition.z)
            local tile = Tile(pos)
            if tile then
                local c = tile:getTopCreature()
                if c and c:isPlayer() then
                    return true
                end
            end
        end
    end
    return false
end

-- Cria estatutas
local function recreateStatues()
    for _, data in pairs(statues) do
        Game.createItem(data.id, 1, data.pos)
        data.pos:sendMagicEffect(CONST_ME_AVATAR_APPEAR)
    end
end

-- Remove jogadores da sala após 10 minutos
local function kickPlayers()
    for x = roomFrom.x, roomTo.x do
        for y = roomFrom.y, roomTo.y do
            local pos = Position(x, y, roomFrom.z)
            local tile = Tile(pos)
            if tile then
                local creature = tile:getTopCreature()
                if creature and creature:isPlayer() then
                    creature:teleportTo(kickPosition)
                    kickPosition:sendMagicEffect(CONST_ME_TELEPORT)
                end
            end
        end
    end
end

-- Remove estátuas e cria monstros
local function spawnMonsters()
    for _, data in pairs(statues) do
        local tile = Tile(data.pos)
        if tile then
            local item = tile:getItemById(data.id)
            if item then
                item:remove()
            end
        end
        Game.createMonster("Minotaur Idol", data.pos)
    end

    addEvent(recreateStatues, 15 * 1000)
end

local function removeMinotaurIdols()
    for x = roomFrom.x, roomTo.x do
        for y = roomFrom.y, roomTo.y do
            local pos = Position(x, y, roomFrom.z)
            local tile = Tile(pos)
            if tile then
                local creature = tile:getTopCreature()
                if creature and creature:isMonster() and creature:getName():lower() == "minotaur idol" then
                    creature:remove()
                    pos:sendMagicEffect(CONST_ME_POFF)
                end
            end
        end
    end
end

local leverMinotaurIdol = Action()

function leverMinotaurIdol.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    if hasPlayerInArea(roomFrom, roomTo) then
        player:sendCancelMessage("Ha outros jogadores na sala.")
        return true
    end

    removeMinotaurIdols()

    for _, pos in ipairs(playerPositions) do
        local tile = Tile(pos)
        if tile then
            local creature = tile:getTopCreature()
            if creature and creature:isPlayer() then
                creature:teleportTo(teleportPosition)
                teleportPosition:sendMagicEffect(CONST_ME_TELEPORT)
            end
        end
    end

    addEvent(spawnMonsters, 3 * 1000)
    
    addEvent(kickPlayers, 10 * 60 * 1000)

    return true
end

leverMinotaurIdol:aid(13174)
leverMinotaurIdol:register()