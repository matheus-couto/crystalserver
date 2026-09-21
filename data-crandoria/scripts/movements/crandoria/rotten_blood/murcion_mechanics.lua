-- local rottenBloodTiles = MoveEvent()
-- local createdItems = {}

-- function rottenBloodTiles.onStepIn(creature, item, position, fromPosition)
--     local monster = creature:getMonster() 
--     local player = creature:getPlayer()
--     if monster then
--         if monster:getName() == "Murcion" then
--             local newItem = Game.createItem(42851, 1, position)
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
--         elseif monster:getName() == "Ichgahal" then
--             local newItem = Game.createItem(43294, 1, position)
--             if newItem then
--                 table.insert(createdItems, newItem:getId())
--                 addEvent(function(itemID)
--                     local itemToTransform = Tile(position):getItemById(itemID)
--                     if itemToTransform then
--                         itemToTransform:remove()
--                         local newItem2 = Game.createItem(43295, 1, position)
--                         if newItem2 then
--                             table.insert(createdItems, newItem2:getId())
--                             addEvent(function(itemID2)
--                                 local itemToRemove = Tile(position):getItemById(itemID2)
--                                 if itemToRemove then
--                                     itemToRemove:remove()
--                                 end
--                             end, 10 * 1000, newItem2:getId())
--                         end
--                     end
--                 end, 10 * 1000, newItem:getId())
--             end
--         end
--     end

--     return true
-- end

-- rottenBloodTiles:id(42852)
-- rottenBloodTiles:register()

-- rottenBloodAgony = MoveEvent()

-- function rottenBloodAgony.onStepIn(creature, item, position, fromPosition)
--     local monster = creature:getMonster()
--     local player = creature:getPlayer()
--     if player then
--         player:addHealth(-500)
--         player:getPosition():sendMagicEffect(CONST_ME_AGONY)
--     end

--     if monster then
--         if monster:getName() == "Murcion" then
--             monster:addHealth(5000)
--             monster:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
--         elseif monster:getName() == "Bakragore" then
--             monster:addHealth(500)
--             monster:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
--         else
--             return true
--         end
--     end
-- end

-- rottenBloodAgony:id(42851)
-- rottenBloodAgony:register()

-- local IchgahalAgony = MoveEvent()

-- function IchgahalAgony.onStepIn(creature, item, position, fromPosition)
--     local monster = creature:getMonster()
--     local player = creature:getPlayer()
--     local condition = Condition(CONDITION_LESSERHEX)
--     condition:setParameter(CONDITION_PARAM_TICKS, 15 * 1000)

--     if player then
--         player:addHealth(-200)
--         player:getPosition():sendMagicEffect(CONST_ME_AGONY)
--         player:addCondition(condition)
--         item:remove()
--     end
-- end

-- IchgahalAgony:id(43294)
-- IchgahalAgony:register()

-- local IchgahalAgony2 = MoveEvent()

-- function IchgahalAgony2.onStepIn(creature, item, position, fromPosition)
--     local monster = creature:getMonster()
--     local player = creature:getPlayer()
--     local condition1 = Condition(CONDITION_GREATERHEX)
--     condition:setParameter(CONDITION_PARAM_TICKS, 15 * 1000)

--     if player then
--         player:addHealth(-500)
--         player:getPosition():sendMagicEffect(CONST_ME_AGONY)
--         player:addCondition(condition1)
--         item:transform(43296)
--         item:remove()
--     end
-- end

-- IchgahalAgony2:id(43295)
-- IchgahalAgony2:register()