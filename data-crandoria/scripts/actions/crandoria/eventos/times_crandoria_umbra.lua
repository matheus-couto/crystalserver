




-- local leverTorres = Action()

-- function leverTorres.onUse(player, item, fromPosition, target, toPosition, isHotkey)
--     local area = {
--         fromPosition = {x = 4898, y = 5183, z = 7},
--         toPosition = {x = 4906, y = 5188, z = 7}
--     }

--     local positionTimeCrandoria = Position(4888, 5171, 7)
--     local positionTimeUmbra = Position(4914, 5171, 7)

--     -- Obter todos os jogadores na área
--     local playersInArea = {}
--     for x = area.fromPosition.x, area.toPosition.x do
--         for y = area.fromPosition.y, area.toPosition.y do
--             local tile = Tile(Position(x, y, area.fromPosition.z))
--             if tile then
--                 for _, creature in ipairs(tile:getCreatures()) do
--                     if creature:isPlayer() then
--                         table.insert(playersInArea, creature)
--                     end
--                 end
--             end
--         end
--     end

--     -- Se não houver jogadores suficientes
--     if #playersInArea < 2 then
--         player:sendTextMessage(MESSAGE_STATUS_WARNING, "Nao ha jogadores suficientes na area.")
--         return true
--     end

--     -- Separar os knights e outros jogadores
--     local knights = {}
--     local others = {}
--     for _, p in ipairs(playersInArea) do
--         if p:getVocation():getBaseId() == VOCATION.BASE_ID.KNIGHT then
--             table.insert(knights, p)
--         else
--             table.insert(others, p)
--         end
--     end

--     -- Ordenar por nível (decrescente)
--     table.sort(knights, function(a, b) return a:getLevel() > b:getLevel() end)
--     table.sort(others, function(a, b) return a:getLevel() > b:getLevel() end)

--     -- Inicializar os dois times
--     local team1 = {}
--     local team2 = {}
--     local sumTeam1 = 0
--     local sumTeam2 = 0

--     -- Colocar os dois knights de maior nível em times diferentes
--     if #knights >= 1 then
--         table.insert(team1, knights[1])
--         sumTeam1 = sumTeam1 + knights[1]:getLevel()
--     end
--     if #knights >= 2 then
--         table.insert(team2, knights[2])
--         sumTeam2 = sumTeam2 + knights[2]:getLevel()
--     end

--     -- Adicionar o restante dos knights (se existirem) à lista de outros jogadores
--     for i = 3, #knights do
--         table.insert(others, knights[i])
--     end

--     -- Distribuir os jogadores restantes de forma balanceada
--     for _, p in ipairs(others) do
--         if sumTeam1 <= sumTeam2 then
--             table.insert(team1, p)
--             sumTeam1 = sumTeam1 + p:getLevel()
--         else
--             table.insert(team2, p)
--             sumTeam2 = sumTeam2 + p:getLevel()
--         end
--     end

--     -- Enviar os jogadores para suas posições de time
--     for _, p in ipairs(team1) do
--         p:teleportTo(positionTimeCrandoria)
--         p:setStorageValue(Storage.Quest.Crandoria.DuasTorres.TimeCrandoria, 1)
--         p:setStorageValue(Storage.Quest.Crandoria.DuasTorres.CooldownTimes, os.time() + 2 * 60 * 60)
--         p:setOutfit({lookType = 128, lookHead = 95, lookBody = 95, lookLegs = 95, lookFeet = 95, lookAddons = 0 })
--     end
--     for _, p in ipairs(team2) do
--         p:teleportTo(positionTimeUmbra)
--         p:setStorageValue(Storage.Quest.Crandoria.DuasTorres.TimeUmbra, 1)
--         p:setStorageValue(Storage.Quest.Crandoria.DuasTorres.CooldownTimes, os.time() + 2 * 60 * 60)
--         p:setOutfit({lookType = 128, lookHead = 114, lookBody = 114, lookLegs = 114, lookFeet = 114, lookAddons = 0 })
--     end

--     -- Mensagem de confirmação
--     player:sendTextMessage(MESSAGE_INFO_DESCR, "Os jogadores foram divididos em dois times de forma balanceada.")
--     return true
-- end

-- leverTorres:aid(13118)
-- leverTorres:register()

local leverTorres = Action()

function leverTorres.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local area = {
        fromPosition = {x = 4898, y = 5183, z = 7},
        toPosition = {x = 4906, y = 5188, z = 7}
    }

    local positionTimeCrandoria = Position(4888, 5171, 7)
    local positionTimeUmbra = Position(4914, 5171, 7)

    -- Obter todos os jogadores na área
    local playersInArea = {}
    for x = area.fromPosition.x, area.toPosition.x do
        for y = area.fromPosition.y, area.toPosition.y do
            local tile = Tile(Position(x, y, area.fromPosition.z))
            if tile then
                for _, creature in ipairs(tile:getCreatures()) do
                    if creature:isPlayer() then
                        table.insert(playersInArea, creature)
                    end
                end
            end
        end
    end

    if #playersInArea < 2 then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "Nao ha jogadores suficientes na area.")
        return true
    end

    -- Separar vocações
    local knights = {}
    local druids = {}
    local others = {}

    for _, p in ipairs(playersInArea) do
        local baseId = p:getVocation():getBaseId()
        if baseId == VOCATION.BASE_ID.KNIGHT then
            table.insert(knights, p)
        elseif baseId == VOCATION.BASE_ID.DRUID then
            table.insert(druids, p)
        else
            table.insert(others, p)
        end
    end

    -- Ordenar por level (decrescente)
    table.sort(knights, function(a, b) return a:getLevel() > b:getLevel() end)
    table.sort(druids, function(a, b) return a:getLevel() > b:getLevel() end)
    table.sort(others, function(a, b) return a:getLevel() > b:getLevel() end)

    local team1, team2 = {}, {}
    local sumTeam1, sumTeam2 = 0, 0

    -- Knights
    if knights[1] then
        table.insert(team1, knights[1])
        sumTeam1 = sumTeam1 + knights[1]:getLevel()
    end
    if knights[2] then
        table.insert(team2, knights[2])
        sumTeam2 = sumTeam2 + knights[2]:getLevel()
    end
    for i = 3, #knights do
        table.insert(others, knights[i])
    end

    -- Druids
    if druids[1] then
        table.insert(team1, druids[1])
        sumTeam1 = sumTeam1 + druids[1]:getLevel()
    end
    if druids[2] then
        table.insert(team2, druids[2])
        sumTeam2 = sumTeam2 + druids[2]:getLevel()
    end
    for i = 3, #druids do
        table.insert(others, druids[i])
    end

    -- Balanceamento restante
    for _, p in ipairs(others) do
        if sumTeam1 <= sumTeam2 then
            table.insert(team1, p)
            sumTeam1 = sumTeam1 + p:getLevel()
        else
            table.insert(team2, p)
            sumTeam2 = sumTeam2 + p:getLevel()
        end
    end

    -- Teleporte e ajustes
    for _, p in ipairs(team1) do
        p:teleportTo(positionTimeCrandoria)
        p:setStorageValue(Storage.Quest.Crandoria.DuasTorres.TimeCrandoria, 1)
        p:setStorageValue(Storage.Quest.Crandoria.DuasTorres.CooldownTimes, os.time() + 2 * 60 * 60)
        p:setOutfit({lookType = 128, lookHead = 95, lookBody = 95, lookLegs = 95, lookFeet = 95})
    end

    for _, p in ipairs(team2) do
        p:teleportTo(positionTimeUmbra)
        p:setStorageValue(Storage.Quest.Crandoria.DuasTorres.TimeUmbra, 1)
        p:setStorageValue(Storage.Quest.Crandoria.DuasTorres.CooldownTimes, os.time() + 2 * 60 * 60)
        p:setOutfit({lookType = 128, lookHead = 114, lookBody = 114, lookLegs = 114, lookFeet = 114})
    end

    player:sendTextMessage(MESSAGE_INFO_DESCR, "Os jogadores foram divididos em dois times balanceados (Knight + Druid garantidos).")
    return true
end

leverTorres:aid(13118)
leverTorres:register()