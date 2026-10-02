-- local areaGeralBaixo = {
--     fromPosition = {x = 4882, y = 5100, z = 7},
--     toPosition = {x = 4912, y = 5119, z = 7}
-- }

-- local function isInArea(creature, area)
--     local creaturePos = creature:getPosition()
--     return creaturePos.x >= area.fromPosition.x and creaturePos.x <= area.toPosition.x
--         and creaturePos.y >= area.fromPosition.y and creaturePos.y <= area.toPosition.y
--         and creaturePos.z == area.fromPosition.z
-- end

-- local function countMonstersInArea(area, monsterNames)
--     local count = 0
--     for _, monster in ipairs(Game.getSpectators(Position(4896, 5110, 7), false, false, 10, 10, 10, 10)) do
--         if monster:isMonster() then
--             for _, name in ipairs(monsterNames) do
--                 if monster:getName():lower() == name:lower() then
--                     count = count + 1
--                     break
--                 end
--             end
--         end
--     end
--     return count
-- end

-- local teleportsTibiaRoyale = MoveEvent()

-- function endTibiaRoyale.onUse(player, item, fromPosition, target, toPosition, isHotkey)
--     local player = creature:getPlayer()
--     if not player then
--         return true
--     end

--     local monstersMagincia = countMonstersInArea(areaGeralBaixo, {"Magincia Knight", "Magincia Mage", "Magincia Archer"})
--     local monstersElvenshire = countMonstersInArea(areaGeralBaixo, {"Elvenshire Knight", "Elvenshire Mage", "Elvenshire Archer"})

--     -- Verificar se há apenas monstros de um único time na área
--     if (monstersMagincia > 0 and monstersElvenshire == 0) then
--         if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 2 then
--             if 
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.PointsMagincia,  player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.PointsMagincia) + 1)
--             player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Seu time venceu e recebeu um ponto de vitoria. Prepare-se para a proxima rodada")
--             player:teleportTo(Position(4884, 5110, 6))

--         or (monstersMagincia == 0 and monstersElvenshire > 0) then
--         if player:
--         player:teleportTo(Position)
--         return true
--     else
--         -- Impedir que o jogador entre no teleport e enviar uma mensagem
--         player:teleportTo(fromPosition)
--         player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "A batalha ainda não terminou. Há monstros de ambos os times presentes na área.")
--         return false
--     end

--     if item:getId() == 4911 then

--     elseif item:getId() == 27658 then