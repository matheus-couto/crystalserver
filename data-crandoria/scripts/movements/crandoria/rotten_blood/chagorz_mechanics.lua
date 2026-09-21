local rottenBloodTiles = MoveEvent()
local createdItems = {}

function rottenBloodTiles.onStepIn(creature, item, position, fromPosition)
    local monster = creature:getMonster()
    local player = creature:getPlayer()
    if monster then
        if monster:getName() == "Chagorz" then
            local newItem = Game.createItem(43367, 1, position)
            if newItem then
                -- Adiciona o identificador do novo item à tabela
                table.insert(createdItems, newItem:getId())
                
                -- Programa a remoção do item após um minuto
                addEvent(function(itemID)
                    local itemToRemove = Tile(position):getItemById(itemID)
                    if itemToRemove then
                        itemToRemove:remove()
                    end
                end, 20 * 1000, newItem:getId())
            end
        elseif monster:getName() == "Bakragore" then
            local newItem = Game.createItem(42851, 1, position)
            if newItem then
                table.insert(createdItems, newItem:getId())
                addEvent(function(itemID)
                    local itemToRemove = Tile(position):getItemById(itemID)
                    if itemToRemove then
                        itemToRemove:remove()
                    end
                end, 10 * 1000, newItem:getId())
            end
        end
    end

    local function checkAndRemoveItem(position, itemId)
        local tile = Tile(position)
        if tile then
            local itemToRemove = tile:getItemById(itemId)
            if itemToRemove then
                local creatures = tile:getCreatures()
                local playerOnTile = false
    
                for _, creature in ipairs(creatures) do
                    if creature:isPlayer() then
                        playerOnTile = true
                        break
                    end
                end
    
                if not playerOnTile then
                    -- Inicia a contagem regressiva para remover o item
                    addEvent(function()
                        local tileCheck = Tile(position)
                        if tileCheck then
                            local itemStillThere = tileCheck:getItemById(itemId)
                            if itemStillThere then
                                local creaturesCheck = tileCheck:getCreatures()
                                local playerStillOnTile = false
    
                                for _, creatureCheck in ipairs(creaturesCheck) do
                                    if creatureCheck:isPlayer() then
                                        playerStillOnTile = true
                                        break
                                    end
                                end
    
                                if not playerStillOnTile then
                                    itemStillThere:remove()
                                end
                            end
                        end
                    end, 10 * 1000)
                else
                    -- Se o jogador ainda estiver no tile, verifica novamente após 1 segundo
                    addEvent(checkAndRemoveItem, 1000, position, itemId)
                end
            end
        end
    end

    if player then
        if player:getStorageValue(Storage.Quest.Crandoria.RottenBloodQuest.ChagorzAgony) < os.time() then
            player:setStorageValue(Storage.Quest.Crandoria.RottenBloodQuest.ChagorzAgony, os.time())
        end

        if (os.time() - 15) < player:getStorageValue(Storage.Quest.Crandoria.RottenBloodQuest.ChagorzAgony) then
            local newItem2 = Game.createItem(43367, 1, position)
            if newItem2 then
                -- Adiciona o identificador do novo item à tabela
                table.insert(createdItems, newItem2:getId())
                
                checkAndRemoveItem(position, newItem2:getId())


                -- Programa a remoção do item após um minuto
                -- addEvent(function(itemID)
                --     local itemToRemove = Tile(position):getItemById(itemID)
                --     if itemToRemove then
                --           itemToRemove:remove()
                --     end
                -- end, 10 * 1000, newItem2:getId())
            end
        end
    end

    return true
end

rottenBloodTiles:id(43366)
rottenBloodTiles:register()



rottenBloodAgony = MoveEvent()

local function applyContinuousDamage(playerId, hpDamage, itemPosition)
    local player = Player(playerId)
    local tile = player:getPosition():getTile()
    local ItemOn = tile:getItemById(43367)
    if player then
        if not player:isRemoved() and player:getPosition() == itemPosition and ItemOn then
            player:addHealth(-hpDamage)
            player:getPosition():sendMagicEffect(CONST_ME_AGONY)
            addEvent(applyContinuousDamage, 1500, player:getId(), hpDamage, itemPosition)  -- Reaplica o dano a cada segundo
        end
    end
end

function rottenBloodAgony.onStepIn(creature, item, position, fromPosition)
    local monster = creature:getMonster()
    local player = creature:getPlayer()
    local hpDamage = creature:getMaxHealth() * 0.03
    if creature:isPlayer() then
        player:addHealth(-hpDamage)
        player:getPosition():sendMagicEffect(CONST_ME_AGONY)
        player:setStorageValue(Storage.Quest.Crandoria.RottenBloodQuest.ChagorzAgony, os.time())
        addEvent(applyContinuousDamage, 1500, player:getId(), hpDamage, position)
    elseif creature:isMonster() then
        if monster:getName() == "Chagorz" or monster:getName() == "Bakragore" then
            monster:addHealth(1000)
            monster:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
        else
            return true
        end
    end
end

rottenBloodAgony:id(43367)
rottenBloodAgony:register()


-- local rottenBloodTiles = MoveEvent()
-- local createdItems = {}

-- function rottenBloodTiles.onStepIn(creature, item, position, fromPosition)
--     local monster = creature:getMonster()
--     local player = creature:getPlayer()
--     if monster then
--         if monster:getName() == "Chagorz" then
--             local newItem = Game.createItem(43367, 1, position)
--             if newItem then
--                 -- Adiciona o identificador do novo item à tabela
--                 table.insert(createdItems, newItem:getId())
                
--                 -- Programa a remoção do item após um minuto
--                 addEvent(function(itemID)
--                     local itemToRemove = Tile(position):getItemById(itemID)
--                     if itemToRemove then
--                         itemToRemove:remove()
--                     end
--                 end, 20 * 1000, newItem:getId())
--             end
--         elseif monster:getName() == "Bakragore" then
--             local newItem = Game.createItem(42851, 1, position)
--             if newItem then
--                 table.insert(createdItems, newItem:getId())
--                 addEvent(function(itemID)
--                     local itemToRemove = Tile(position):getItemById(itemID)
--                     if itemToRemove then
--                         itemToRemove:remove()
--                     end
--                 end, 20 * 1000, newItem:getId())
--             end
--         end
--     end

--     if player then
--         if (os.time() - 15) < player:getStorageValue(Storage.Quest.Crandoria.RottenBloodQuest.ChagorzAgony) then
--             local newItem2 = Game.createItem(43367, 1, position)
--             if newItem2 then
--                 -- Adiciona o identificador do novo item à tabela
--                 table.insert(createdItems, newItem2:getId())
                
--                 -- Programa a remoção do item após um minuto
--                 addEvent(function(itemID)
--                     local itemToRemove = Tile(position):getItemById(itemID)
--                     if itemToRemove then
--                         itemToRemove:remove()
--                     end
--                 end, 20 * 1000, newItem2:getId())
--             end
--         end
--     end

--     return true
-- end

-- rottenBloodTiles:id(43366)
-- rottenBloodTiles:register()

-- rottenBloodAgony = MoveEvent()

-- function rottenBloodAgony.onStepIn(creature, item, position, fromPosition)
--     local monster = creature:getMonster()
--     local player = creature:getPlayer()
--     if player then
--         player:addHealth(-1000)
--         player:getPosition():sendMagicEffect(CONST_ME_AGONY)
--         player:setStorageValue(Storage.Quest.Crandoria.RottenBloodQuest.ChagorzAgony, os.time())
--     end

--     if monster then
--         if monster:getName() == "Chagorz" then
--             monster:addHealth(5000)
--             monster:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
--         else
--             return true
--         end
--     end
-- end

-- rottenBloodAgony:id(43367)
-- rottenBloodAgony:register()