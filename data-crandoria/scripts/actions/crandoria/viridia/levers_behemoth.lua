-- local leversBehemoth = Action()

-- function leversBehemoth.onUse(player, item, fromPosition, target, toPosition, isHotkey)
--     local leverConfig = {
--         levers = {
--             {position = Position(4461, 5328, 13), idOff = 2772, idOn = 2773},
--             {position = Position(4441, 5308, 13), idOff = 2772, idOn = 2773},
--             {position = Position(4481, 5308, 13), idOff = 2772, idOn = 2773}
--         },
--         stone = {
--             position = Position(4462, 5306, 13),
--             id = 1842,
--             removalTime = 10, -- Tempo para virar as alavancas e passar (em segundos)
--             respawnTime = 60 -- Tempo para a pedra retornar (em segundos)
--         },
--         storage = 66611 -- Storage global para monitorar o progresso
--     }

--     -- Verifica se a pedra está presente na posição
--     if not Tile(leverConfig.stone.position):getItemById(leverConfig.stone.id) then
--         -- player:sendTextMessage(MESSAGE_INFO_DESCR, "A pedra já foi removida! Não é possível usar a alavanca.")
--         return false
--     end

--     local function resetLeversAndStone()
--         -- Reativa a pedra
--         if not Tile(leverConfig.stone.position):getItemById(leverConfig.stone.id) then
--             Game.createItem(leverConfig.stone.id, 1, leverConfig.stone.position)
--         end

--         -- Reseta as alavancas
--         for _, lever in ipairs(leverConfig.levers) do
--             local leverTile = Tile(lever.position):getItemById(lever.idOn)
--             if leverTile then
--                 leverTile:transform(lever.idOff)
--             end
--         end

--         -- Reseta o storage global
--         Game.setStorageValue(leverConfig.storage, 0)
--     end

--     local function removeStone()
--         -- Remove a pedra
--         local stoneTile = Tile(leverConfig.stone.position):getItemById(leverConfig.stone.id)
--         if stoneTile then
--             stoneTile:remove()
--         end

--         -- Define um evento para recriar a pedra após o tempo de respawn
--         addEvent(resetLeversAndStone, leverConfig.stone.respawnTime * 1000)
--     end

--     local function checkLevers()
--         -- Verifica se todas as alavancas foram ativadas
--         local activatedCount = 0
--         for _, lever in ipairs(leverConfig.levers) do
--             local leverTile = Tile(lever.position):getItemById(lever.idOn)
--             if leverTile then
--                 activatedCount = activatedCount + 1
--             end
--         end

--         if activatedCount == #leverConfig.levers then
--             -- Todas as alavancas foram ativadas, remove a pedra
--             removeStone()
--             Game.setStorageValue(leverConfig.storage, 0)
--             return true
--         end
--         return false
--     end

--     local function handleLever(player, item, lever)
--         -- Verifica o tempo restante no storage global
--         local currentTime = os.time()
--         local storageTime = Game.getStorageValue(leverConfig.storage) or 0

--         if storageTime < 1 then
--             -- Primeiro uso: define o tempo limite no storage global
--             Game.setStorageValue(leverConfig.storage, currentTime + leverConfig.stone.removalTime)
--         elseif currentTime > storageTime then
--             -- Tempo expirado: reseta tudo
--             resetLeversAndStone()
--             player:say('miss', TALKTYPE_MONSTER_SAY)
--             -- player:sendTextMessage(MESSAGE_INFO_DESCR, "O tempo acabou! As alavancas foram resetadas e a pedra retornou.")
--             return
--         end

--         -- Transforma a alavanca
--         item:transform(lever.idOn)

--         -- Verifica o progresso após ativar a alavanca
--         if not checkLevers() then
--             player:say('CLICK!', TALKTYPE_MONSTER_SAY)
--             -- player:sendTextMessage(MESSAGE_INFO_DESCR, "Você ativou uma alavanca! Ative as outras antes que o tempo acabe.")
--         else
--             player:say('CLICK!', TALKTYPE_MONSTER_SAY)
--             -- player:sendTextMessage(MESSAGE_INFO_DESCR, "A pedra foi removida! Você tem 15 segundos para passar.")
--         end
--     end

--     -- Identifica qual alavanca foi ativada
--     for _, lever in ipairs(leverConfig.levers) do
--         if item:getPosition() == lever.position then
--             handleLever(player, item, lever)
--             return true
--         end
--     end

--     return false
-- end

-- leversBehemoth:aid(13103)
-- leversBehemoth:register()


local leversBehemoth = Action()

function leversBehemoth.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local leverConfig = {
        levers = {
            {position = Position(4461, 5328, 13), idOff = 2772, idOn = 2773},
            {position = Position(4441, 5308, 13), idOff = 2772, idOn = 2773},
            {position = Position(4481, 5308, 13), idOff = 2772, idOn = 2773}
        },
        stone = {
            position = Position(4462, 5306, 13),
            id = 1842,
            removalTime = 15, -- Tempo para virar as alavancas e passar (em segundos)
            respawnTime = 30 -- Tempo para a pedra retornar (em segundos)
        },
        storage = 66611 -- Storage global para monitorar o progresso
    }

    -- Verifica se a pedra está presente na posição
    if not Tile(leverConfig.stone.position):getItemById(leverConfig.stone.id) then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "A pedra já foi removida! Não é possível usar a alavanca.")
        return false
    end

    local function resetLeversAndStone()
        -- Reativa a pedra
        if not Tile(leverConfig.stone.position):getItemById(leverConfig.stone.id) then
            Game.createItem(leverConfig.stone.id, 1, leverConfig.stone.position)
        end

        -- Reseta as alavancas
        for _, lever in ipairs(leverConfig.levers) do
            local leverTile = Tile(lever.position):getItemById(lever.idOn)
            if leverTile then
                leverTile:transform(lever.idOff)
            end
        end

        -- Reseta o storage global
        Game.setStorageValue(leverConfig.storage, 0)
    end

    local function removeStone()
        -- Remove a pedra
        local stoneTile = Tile(leverConfig.stone.position):getItemById(leverConfig.stone.id)
        if stoneTile then
            stoneTile:remove()
        end

        -- Define um evento para recriar a pedra após o tempo de respawn
        addEvent(resetLeversAndStone, leverConfig.stone.respawnTime * 1000)
    end

    local function autoResetLevers()
        -- Reseta as alavancas automaticamente
        for _, lever in ipairs(leverConfig.levers) do
            local leverTile = Tile(lever.position):getItemById(lever.idOn)
            if leverTile then
                leverTile:transform(lever.idOff)
            end
        end

        -- Reseta o storage global
        Game.setStorageValue(leverConfig.storage, 0)

        player:sendTextMessage(MESSAGE_INFO_DESCR, "O tempo acabou! As alavancas foram resetadas.")
    end

    local function checkLevers()
        -- Verifica se todas as alavancas foram ativadas
        local activatedCount = 0
        for _, lever in ipairs(leverConfig.levers) do
            local leverTile = Tile(lever.position):getItemById(lever.idOn)
            if leverTile then
                activatedCount = activatedCount + 1
            end
        end

        if activatedCount == #leverConfig.levers then
            -- Todas as alavancas foram ativadas, remove a pedra
            removeStone()
            Game.setStorageValue(leverConfig.storage, 0)
            return true
        end
        return false
    end

    local function handleLever(player, item, lever)
        -- Verifica o tempo restante no storage global
        local currentTime = os.time()
        local storageTime = Game.getStorageValue(leverConfig.storage) or 0

        if storageTime < 1 then
            -- Primeiro uso: define o tempo limite no storage global
            Game.setStorageValue(leverConfig.storage, currentTime + leverConfig.stone.removalTime)
            -- Define um evento para resetar automaticamente as alavancas quando o tempo acabar
            addEvent(autoResetLevers, leverConfig.stone.removalTime * 1000)
        elseif currentTime > storageTime then
            -- Tempo expirado: reseta tudo
            autoResetLevers()
            return
        end

        -- Transforma a alavanca
        item:transform(lever.idOn)

        -- Verifica o progresso após ativar a alavanca
        if not checkLevers() then
            player:say('CLICK!', TALKTYPE_MONSTER_SAY)
            -- player:sendTextMessage(MESSAGE_INFO_DESCR, "Você ativou uma alavanca! Ative as outras antes que o tempo acabe.")
        else
            player:say('CLICK!', TALKTYPE_MONSTER_SAY)
            -- player:sendTextMessage(MESSAGE_INFO_DESCR, "A pedra foi removida! Você tem 15 segundos para passar.")
        end
    end

    -- Identifica qual alavanca foi ativada
    for _, lever in ipairs(leverConfig.levers) do
        if item:getPosition() == lever.position then
            handleLever(player, item, lever)
            return true
        end
    end

    return false
end

leversBehemoth:aid(13103)
leversBehemoth:register()