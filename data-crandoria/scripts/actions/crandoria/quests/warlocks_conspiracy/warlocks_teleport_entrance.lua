

-- local warlocksTeleport = {
--     enter = Position(4661, 5142, 12),  -- Entrada da prisão
--     exit = Position(4672, 5118, 13),   -- Saída da prisão
-- }

-- local leverPositions = {
--     {position = Position(4660, 5143, 12), correctID = 2773},  -- Alavanca na posição 1
--     {position = Position(4660, 5144, 12), correctID = 2772},  -- Alavanca na posição 2
--     {position = Position(4660, 5145, 12), correctID = 2773},  -- Alavanca na posição 3
--     {position = Position(4662, 5143, 12), correctID = 2772},  -- Alavanca na posição 4
--     {position = Position(4662, 5144, 12), correctID = 2772},  -- Alavanca na posição 5
--     {position = Position(4662, 5145, 12), correctID = 2773}   -- Alavanca na posição 6
-- }

-- local function areAllLeverPositionsCorrect()
--     for _, leverInfo in ipairs(leverPositions) do
--         local tile = Tile(leverInfo.position)
--         if tile then
--             local lever = tile:getItemById(leverInfo.correctID)
--             if not lever then
--                 return false
--             end
--         else
--             return false
--         end
--     end
--     return true
-- end

-- local warlocksTeleportAcesso = MoveEvent()

-- function warlocksTeleportAcesso.onStepIn(creature, item, position, fromPosition)
--     local player = creature:getPlayer()
--     if not player then
--         return true
--     end
--     if not areAllLeverPositionsCorrect() then
--         player:teleportTo(fromPosition)
--         player:getPosition():sendMagicEffect(CONST_ME_POFF)
--         player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O portal parece não ter energia suficiente para funcionar.")
--         return false -- Retorna false para impedir que o jogador entre no teleport
--     end
--     player:teleportTo(warlocksTeleport.exit)
--     player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--     return true
-- end


-- warlocksTeleportAcesso:type("stepin")
-- warlocksTeleportAcesso:aid(13000)
-- warlocksTeleportAcesso:register()

local warlocksTeleport = {
    enter = Position(4661, 5142, 12),  -- Entrada da prisão
    exit = Position(4672, 5118, 13),   -- Saída da prisão
}

local leverPositions = {
    {position = Position(4660, 5143, 12), correctID = 2773},  -- Alavanca na posição 1
    {position = Position(4660, 5144, 12), correctID = 2772},  -- Alavanca na posição 2
    {position = Position(4660, 5145, 12), correctID = 2773},  -- Alavanca na posição 3
    {position = Position(4662, 5143, 12), correctID = 2772},  -- Alavanca na posição 4
    {position = Position(4662, 5144, 12), correctID = 2772},  -- Alavanca na posição 5
    {position = Position(4662, 5145, 12), correctID = 2773}   -- Alavanca na posição 6
}

local function areAllLeverPositionsCorrect()
    for _, leverInfo in ipairs(leverPositions) do
        local tile = Tile(leverInfo.position)
        if tile then
            local lever = tile:getItemById(leverInfo.correctID)
            if not lever then
                return false
            end
        else
            return false
        end
    end
    return true
end

local function setRandomLeverIDs()
    for _, leverInfo in ipairs(leverPositions) do
        local tile = Tile(leverInfo.position)
        if tile then
            local lever = tile:getItemById(2772) or tile:getItemById(2773)
            if lever then
                lever:remove()
            end
            local randomID = math.random(2772, 2773)
            Game.createItem(randomID, 1, leverInfo.position)
        end
    end
end

local warlocksTeleportAcesso = MoveEvent()

function warlocksTeleportAcesso.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end
    if not areAllLeverPositionsCorrect() then
        player:teleportTo(fromPosition)
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O portal parece nao ter energia suficiente para funcionar.")
        return false -- Retorna false para impedir que o jogador entre no teleport
    end
    player:teleportTo(warlocksTeleport.exit)
    player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    setRandomLeverIDs() -- Define IDs aleatórios para as alavancas
    return true
end


warlocksTeleportAcesso:type("stepin")
warlocksTeleportAcesso:aid(13000)
warlocksTeleportAcesso:register(onPlayerStepIn)
