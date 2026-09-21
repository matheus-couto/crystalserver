-- local leversDwarves = Action()

-- -- Configuração das alavancas e sequência correta
-- local levers = {
--     {leverPosition = Position(4530, 5543, 11), leverSideA = 30408, leverSideB = 30409, correctState = 30409},
--     {leverPosition = Position(4530, 5541, 11), leverSideA = 30412, leverSideB = 30413, correctState = 30412},
--     {leverPosition = Position(4532, 5543, 11), leverSideA = 30410, leverSideB = 30411, correctState = 30411},
--     {leverPosition = Position(4532, 5541, 11), leverSideA = 30414, leverSideB = 30415, correctState = 30415},
--     {leverPosition = Position(4531, 5539, 11), leverSideA = 8913, leverSideB = 8914, correctState = 8914}
-- }

-- -- Posição da ponte
-- local bridgePosition = Position(4531, 5537, 11)
-- local bridgeItemId = 5770
-- local bridgeDuration = 10 * 1000 -- 10 segundos

-- -- Verifica se todas as alavancas estão na posição correta
-- local function areLeversCorrect()
--     for _, lever in ipairs(levers) do
--         local tile = Tile(lever.leverPosition)
--         if not tile then
--             return false
--         end

--         local leverItem = tile:getItemById(lever.leverSideA) or tile:getItemById(lever.leverSideB)
--         if not leverItem or leverItem:getId() ~= lever.correctState then
--             return false
--         end
--     end
--     return true
-- end

-- -- Altera as alavancas para um estado aleatório
-- local function randomizeLevers()
--     for _, lever in ipairs(levers) do
--         local tile = Tile(lever.leverPosition)
--         if tile then
--             local leverItem = tile:getItemById(lever.leverSideA) or tile:getItemById(lever.leverSideB)
--             if leverItem then
--                 local newId = math.random(0, 1) == 0 and lever.leverSideA or lever.leverSideB
--                 leverItem:transform(newId)
--             end
--         end
--     end
-- end

-- -- Função principal
-- function leversDwarves.onUse(player, item, fromPosition, target, toPosition, isHotkey)
--     -- Alterar o estado da alavanca usada
--     for _, lever in ipairs(levers) do
--         if lever.leverPosition == item:getPosition() then
--             local newId = item:getId() == lever.leverSideA and lever.leverSideB or lever.leverSideA
--             item:transform(newId)

--             -- Aguardar atualização do estado da alavanca antes de verificar
--             addEvent(function()
--                 if areLeversCorrect() then
--                     -- Criar a ponte
--                     local tile = Tile(bridgePosition)
--                     if tile and not tile:getItemById(bridgeItemId) then
--                         Game.createItem(bridgeItemId, 1, bridgePosition)
--                         player:sendTextMessage(MESSAGE_STATUS_WARNING, "A ponte foi criada e estará disponível por 10 segundos!")
--                     end

--                     -- Remover a ponte após o tempo definido e randomizar as alavancas
--                     addEvent(function()
--                         local tile = Tile(bridgePosition)
--                         if tile then
--                             local bridgeItem = tile:getItemById(bridgeItemId)
--                             if bridgeItem then
--                                 bridgeItem:remove()
--                             end
--                         end
--                         randomizeLevers()
--                         player:sendTextMessage(MESSAGE_STATUS_WARNING, "A ponte desapareceu, e as alavancas foram embaralhadas!")
--                     end, bridgeDuration)
--                 end
--             end, 200) -- 200ms de atraso para garantir a atualização do estado da alavanca
--             break
--         end
--     end

--     return true
-- end

-- -- Registrar a ação
-- leversDwarves:aid(13094)
-- leversDwarves:register()




local leversDwarves = Action()

function leversDwarves.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    local levers = {
        {leverPosition = Position(4530, 5543, 11), leverSideA = 30408, leverSideB = 30409, correctState = 30409},
        {leverPosition = Position(4530, 5541, 11), leverSideA = 30412, leverSideB = 30413, correctState = 30412},
        {leverPosition = Position(4532, 5543, 11), leverSideA = 30410, leverSideB = 30411, correctState = 30411},
        {leverPosition = Position(4532, 5541, 11), leverSideA = 30414, leverSideB = 30415, correctState = 30415},
    }

    local function randomizeLevers()
        for _, lever in ipairs(levers) do
            local tile = Tile(lever.leverPosition)
            if tile then
                local leverItem = tile:getItemById(lever.leverSideA) or tile:getItemById(lever.leverSideB)
                if leverItem then
                    local newId = math.random(0, 1) == 0 and lever.leverSideA or lever.leverSideB
                    leverItem:transform(newId)
                end
            end
        end
    end



    if item:getPosition() == Position(4531, 5539, 11) then
        if item.itemid == 8913 then
            for _, lever in ipairs(levers) do
                local tile = Tile(lever.leverPosition)
                if not tile then
                    return false
                end
        
                local leverItem = tile:getItemById(lever.leverSideA) or tile:getItemById(lever.leverSideB)
                if not leverItem or leverItem:getId() ~= lever.correctState then
                    return false
                else

                    Game.createItem(5770, 1, Position(4531, 5537, 11))
                    randomizeLevers()
                    addEvent(function()
                        local tile = Tile(Position(4531, 5537, 11))
                        if tile then
                            local bridgeItem = tile:getItemById(5770)
                            if bridgeItem then
                                bridgeItem:transform(21477)
                            end
                        end
                        -- player:sendTextMessage(MESSAGE_STATUS_WARNING, "A ponte desapareceu, e as alavancas foram embaralhadas!")
                    end, 10 * 1000)
                end
            end
        elseif item.itemid == 8914 then
            item:transform(8913)
            return true
        end
    else
        if item.itemid == 30408 then
            item:transform(30409)
            return true
        elseif item.itemid == 30412 then
            item:transform(30413)
            return true
        elseif item.itemid == 30410 then
            item:transform(30411)
            return true
        elseif item.itemid == 30414 then
            item:transform(30415)
            return true
        elseif item.itemid == 30409 then
            item:transform(30408)
            return true
        elseif item.itemid == 30413 then
            item:transform(30412)
            return true
        elseif item.itemid == 30411 then
            item:transform(30410)
            return true
        elseif item.itemid == 30415 then
            item:transform(30414)
            return true
        end
    end
end


leversDwarves:aid(13094)
leversDwarves:register()