

-- -- local areaGeralCima = {
-- --     fromPosition = {x = 4882, y = 5100, z = 6},
-- --     toPosition = {x = 4912, y = 5119, z = 6}
-- -- }

-- -- local areaGeralBaixo = {
-- --     fromPosition = {x = 4882, y = 5100, z = 7},
-- --     toPosition = {x = 4912, y = 5119, z = 7}
-- -- }

-- -- local areaStartMagincia = {
-- --     fromPosition = {x = 4914, y = 5104, z = 7},
-- --     toPosition = {x = 4920, y = 5109, z = 7}
-- -- }

-- -- local areaStartElvenshire = {
-- --     fromPosition = {x = 4914, y = 5111, z = 7},
-- --     toPosition = {x = 4921, y = 5117, z = 7}
-- -- }

-- -- local areaLeverMagincia = {
-- --     fromPosition = {x = 4882, y = 5107, z = 6},
-- --     toPosition = {x = 4890, y = 5113, z = 6}
-- -- }

-- -- local areaLeverElvenshire = {
-- --     fromPosition = {x = 4904, y = 5107, z = 6},
-- --     toPosition = {x = 4911, y = 5112, z = 6}
-- -- }

-- -- local areaCentral = {
-- --     fromPosition = {x = 4891, y = 5105, z = 6},
-- --     toPosition = {x = 4903, y = 5115, z = 6}
-- -- }

-- -- local function isInArea(player, area)
-- --     local playerPos = player:getPosition()
-- --     return playerPos.x >= area.fromPosition.x and playerPos.x <= area.toPosition.x
-- --         and playerPos.y >= area.fromPosition.y and playerPos.y <= area.toPosition.y
-- --         and playerPos.z == area.fromPosition.z
-- -- end

-- -- local function countPlayersInArea(area)
-- --     local count = 0
-- --     for _, player in ipairs(Game.getPlayers()) do
-- --         if isInArea(player, area) then
-- --             count = count + 1
-- --         end
-- --     end
-- --     return count
-- -- end

-- -- local function transportPlayersToPosition(players, position, storageValues)
-- --     for _, player in ipairs(players) do
-- --         player:teleportTo(position)
-- --         for storage, value in pairs(storageValues) do
-- --             player:setStorageValue(storage, value)
-- --         end
-- --     end
-- -- end

-- -- local function collectGoldTokensFromPedestal(pedestalPosition)
-- --     local pedestalTile = Tile(pedestalPosition)
-- --     if not pedestalTile then
-- --         return 0
-- --     end
    
-- --     local pedestalItems = pedestalTile:getItems()
-- --     local goldTokensCount = 0
-- --     for _, item in ipairs(pedestalItems) do
-- --         if item:getId() == 22721 then
-- --             goldTokensCount = goldTokensCount + item:getCount()
-- --         end
-- --     end
    
-- --     return goldTokensCount
-- -- end

-- -- local function collectGoldTokensFromPlayers(players)
-- --     local totalGoldTokens = 0
-- --     for _, player in ipairs(players) do
-- --         local goldTokensCount = player:getItemCount(22721)
-- --         totalGoldTokens = totalGoldTokens + goldTokensCount
-- --         if goldTokensCount > 0 then
-- --             player:removeItem(22721, goldTokensCount)
-- --         end
-- --     end
-- --     return totalGoldTokens
-- -- end

-- -- local function areGoldTokensReady(playersInMagincia, playersInElvenshire)
-- --     -- Verificar se todos os jogadores em Magincia têm pelo menos 1 Gold Token
-- --     for _, player in ipairs(playersInMagincia) do
-- --         if player:getItemCount(22721) < 1 then
-- --             return false
-- --         end
-- --     end
    
-- --     -- Verificar se todos os jogadores em Elvenshire têm pelo menos 1 Gold Token
-- --     for _, player in ipairs(playersInElvenshire) do
-- --         if player:getItemCount(22721) < 1 then
-- --             return false
-- --         end
-- --     end
    
-- --     return true
-- -- end

-- -- local maginciaCreatures = {
-- --     "Magincia Knight",
-- --     "Magincia Mage",
-- --     "Magincia Archer",
-- --     "Magincia Arcanist",
-- --     "Magincia Assassin"
-- -- }

-- -- local elvenshireCreatures = {
-- --     "Elvenshire Knight",
-- --     "Elvenshire Mage",
-- --     "Elvenshire Archer",
-- --     "Elvenshire Arcanist",
-- --     "Elvenshire Assassin"
-- -- }

-- -- local function getRandomCreatureMagincia()
-- --     return maginciaCreatures[math.random(1, #maginciaCreatures)]
-- -- end

-- -- local function getRandomCreatureElvenshire()
-- --     return elvenshireCreatures[math.random(1, #elvenshireCreatures)]
-- -- end

-- -- local alavancaWar = Action()

-- -- local function removeMonstersFromArea(area)
-- --     local monsters = Game.getSpectators(Position(4896, 5110, 7), false, false, 10, 10, 10, 10)
-- --     for _, monster in ipairs(monsters) do
-- --         if monster:isMonster() then
-- --             monster:remove()
-- --         end
-- --     end
-- -- end

-- -- function alavancaWar.onUse(player, item, fromPosition, target, toPosition, isHotkey)
-- --     if item:getPosition() == Position(4914, 5110, 7) then
-- --         local lever1 = Tile(Position(4914, 5108, 7)):getItemById(2773)
-- --         local lever2 = Tile(Position(4914, 5112, 7)):getItemById(2773)

-- --         if not lever1 or not lever2 then
-- --             player:say('Ambos os times devem acionar as alavancas laterais para ativar a alavanca principal.', TALKTYPE_MONSTER_SAY, false, player, Position(4914, 5110, 7))
-- --             return true
-- --         end

-- --         local playersInGame1 = {}
-- --         local playersInGame2 = {}

-- --         for _, player in ipairs(Game.getPlayers()) do
-- --             if isInArea(player, areaGeralCima) then
-- --                 table.insert(playersInGame1, player)
-- --             elseif isInArea(player, areaGeralBaixo) then
-- --                 table.insert(playersInGame2, player)
-- --             end
-- --         end

-- --         if #playersInGame1 > 0 or #playersInGame2 > 0 then
-- --             player:say('Ha uma batalha em andamento agora. Aguardem.', TALKTYPE_MONSTER_SAY, false, player, Position(4914, 5110, 7))
-- --             player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- --             return true
-- --         end

-- --         local playersInMagincia = {}
-- --         local playersInElvenshire = {}

-- --         -- Checar se há jogadores em ambas as áreas
-- --         for _, player in ipairs(Game.getPlayers()) do
-- --             if isInArea(player, areaStartMagincia) then
-- --                 table.insert(playersInMagincia, player)
-- --             elseif isInArea(player, areaStartElvenshire) then
-- --                 table.insert(playersInElvenshire, player)
-- --             end
-- --         end

-- --         if #playersInMagincia > 10 or #playersInElvenshire > 10 then
-- --             player:say('Cada time deve possuir no maximo 10 jogadores.', TALKTYPE_MONSTER_SAY, false, player, Position(4914, 5110, 7))
-- --             player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- --             return true
-- --         end


-- --         local ipCounts = {}
-- --         for _, player in ipairs(playersInMagincia) do
-- --             local ip = player:getIp()
-- --             ipCounts[ip] = (ipCounts[ip] or 0) + 1
-- --         end
-- --         for _, player in ipairs(playersInElvenshire) do
-- --             local ip = player:getIp()
-- --             ipCounts[ip] = (ipCounts[ip] or 0) + 1
-- --         end

-- --         local hasDuplicateIP = false
-- --         for _, count in pairs(ipCounts) do
-- --             if count > 2 then
-- --                 hasDuplicateIP = true
-- --                 break
-- --             end
-- --         end

-- --         -- Se houver jogadores com o mesmo IP, retorne verdadeiro
-- --         if hasDuplicateIP then
-- --             player:say('Proibido utilizar mais de um personagem por IP.', TALKTYPE_MONSTER_SAY, false, player, Position(4914, 5110, 7))
-- --             return true
-- --         end

-- --         -- Verificar se há o mesmo número de jogadores em ambas as áreas
-- --         -- if #playersInMagincia == #playersInElvenshire then
-- --         --     if areGoldTokensReady(playersInMagincia, playersInElvenshire) then
-- --         --         -- Remover um Gold Token de cada jogador em ambos os times
-- --         --         for _, player in ipairs(playersInMagincia) do
-- --         --             player:removeItem(22721, 1)
-- --         --         end
-- --         --         for _, player in ipairs(playersInElvenshire) do
-- --         --             player:removeItem(22721, 1)
-- --         --         end

-- --         --         -- Transportar jogadores para as posições especificadas
-- --         --         transportPlayersToPosition(playersInMagincia, Position(4884, 5110, 6), {
-- --         --             [Storage.Quest.Crandoria.TibiaRoyale.StartMagincia] = 1,
-- --         --             [Storage.Quest.Crandoria.TibiaRoyale.PointsMagincia] = 0
-- --         --         })
                
-- --         --         transportPlayersToPosition(playersInElvenshire, Position(4909, 5110, 6), {
-- --         --             [Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire] = 1,
-- --         --             [Storage.Quest.Crandoria.TibiaRoyale.PointsElvenshire] = 0
-- --         --         })
-- --         --         return true
-- --         --     else
-- --         --         player:say('Cada jogador deve possuir pelo menos um Gold Token em suas mochilas.', TALKTYPE_MONSTER_SAY, false, player, Position(4914, 5110, 7))
-- --         --     end
-- --         -- else
-- --         --     player:say('Ambos os times devem possuir o mesmo numero de jogadores para iniciar a batalha.', TALKTYPE_MONSTER_SAY, false, player, Position(4914, 5110, 7))
-- --         -- end

-- --         if #playersInMagincia == #playersInElvenshire then
-- --             if areGoldTokensReady(playersInMagincia, playersInElvenshire) then
-- --                 for _, player in ipairs(playersInMagincia) do
-- --                     player:removeItem(22721, 1)
-- --                 end
-- --                 for _, player in ipairs(playersInElvenshire) do
-- --                     player:removeItem(22721, 1)
-- --                 end
-- --                 transportPlayersToPosition(playersInMagincia, Position(4884, 5110, 6), {
-- --                     [Storage.Quest.Crandoria.TibiaRoyale.StartMagincia] = 1,
-- --                     [Storage.Quest.Crandoria.TibiaRoyale.PointsMagincia] = 0
-- --                 })
                
-- --                 transportPlayersToPosition(playersInElvenshire, Position(4909, 5110, 6), {
-- --                     [Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire] = 1,
-- --                     [Storage.Quest.Crandoria.TibiaRoyale.PointsElvenshire] = 0
-- --                 })
-- --                 removeMonstersFromArea(areaGeralBaixo)
-- --                 return true
-- --             else
-- --                 player:say('Cada jogador deve possuir pelo menos um Gold Token em suas mochilas.', TALKTYPE_MONSTER_SAY, false, player, Position(4914, 5110, 7))
-- --             end
-- --         elseif #playersInMagincia ~= #playersInElvenshire and (#playersInMagincia < 1 or #playersInElvenshire < 1) then
-- --             if areGoldTokensReady(playersInMagincia, playersInElvenshire) then
-- --                 for _, player in ipairs(playersInMagincia) do
-- --                     player:removeItem(22721, 1)
-- --                 end
-- --                 for _, player in ipairs(playersInElvenshire) do
-- --                     player:removeItem(22721, 1)
-- --                 end
-- --                 transportPlayersToPosition(playersInMagincia, Position(4884, 5110, 6), {
-- --                     [Storage.Quest.Crandoria.TibiaRoyale.StartMagincia] = 5,
-- --                     [Storage.Quest.Crandoria.TibiaRoyale.PointsMagincia] = 0
-- --                 })
                
-- --                 transportPlayersToPosition(playersInElvenshire, Position(4909, 5110, 6), {
-- --                     [Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire] = 5,
-- --                     [Storage.Quest.Crandoria.TibiaRoyale.PointsElvenshire] = 0
-- --                 })
-- --                 removeMonstersFromArea(areaGeralBaixo)
-- --                 return true
-- --             else
-- --                 player:say('Cada jogador deve possuir pelo menos um Gold Token em suas mochilas.', TALKTYPE_MONSTER_SAY, false, player, Position(4914, 5110, 7))
-- --             end
-- --         else
-- --             player:say('Ambos os times devem possuir o mesmo numero de jogadores para iniciar a batalha.', TALKTYPE_MONSTER_SAY, false, player, Position(4914, 5110, 7))
-- --         end

-- --     elseif item:getPosition() == Position(4889, 5107, 6) then
-- --         if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 2 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 2 then
-- --             player:teleportTo(Position(4892, 5110, 6))
-- --             Game.createMonster("Magincia Arcanist", Position(4893, 5113, 7))
-- --             player:say('Os Corvos de Magincia invocaram um Arcanist!', TALKTYPE_MONSTER_SAY, false, player, Position(4908, 5107, 6))
-- --             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) + 1)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 0)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 2)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
-- --             return true
-- --         elseif player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 5 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 5 then
-- --             player:teleportTo(Position(4892, 5110, 6))
-- --             Game.createMonster("Magincia Arcanist", Position(4893, 5113, 7))
-- --             player:say('Os Corvos de Magincia invocaram um Arcanist!', TALKTYPE_MONSTER_SAY, false, player, Position(4908, 5107, 6))
-- --             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) + 1)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 0)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 5)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
-- --             local creatureNameElvenshire = getRandomCreatureElvenshire()
-- --             Game.createMonster(creatureNameElvenshire, Position(4900, 5112, 7))
-- --             player:say("Os Corvos de Elvenshire invocaram um " .. creatureNameElvenshire .. "!", TALKTYPE_MONSTER_SAY, false, player, Position(4885, 5107, 6))
-- --             return true
-- --         end
-- --     elseif item:getPosition() == Position(4889, 5108, 6) then
-- --         if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 2 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 2 then
-- --             player:teleportTo(Position(4892, 5110, 6))
-- --             Game.createMonster("Magincia Mage", Position(4893, 5110, 7))
-- --             player:say('Os Corvos de Magincia invocaram um Mage!', TALKTYPE_MONSTER_SAY, false, player, Position(4908, 5107, 6))
-- --             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) + 1)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 0)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 2)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
-- --             return true
-- --         elseif player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 5 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 5 then
-- --             player:teleportTo(Position(4892, 5110, 6))
-- --             Game.createMonster("Magincia Mage", Position(4893, 5110, 7))
-- --             player:say('Os Corvos de Magincia invocaram um Mage!', TALKTYPE_MONSTER_SAY, false, player, Position(4908, 5107, 6))
-- --             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) + 1)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 0)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 5)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
-- --             local creatureNameElvenshire = getRandomCreatureElvenshire()
-- --             Game.createMonster(creatureNameElvenshire, Position(4900, 5112, 7))
-- --             player:say("Os Corvos de Elvenshire invocaram um " .. creatureNameElvenshire .. "!", TALKTYPE_MONSTER_SAY, false, player, Position(4885, 5107, 6))
-- --             return true
-- --         end
-- --     elseif item:getPosition() == Position(4889, 5109, 6) then
-- --         if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 2 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 2 then
-- --             player:teleportTo(Position(4892, 5110, 6))
-- --             Game.createMonster("Magincia Knight", Position(4894, 5110, 7))
-- --             player:say('Os Corvos de Magincia invocaram um Knight!', TALKTYPE_MONSTER_SAY, false, player, Position(4908, 5107, 6))
-- --             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) + 1)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 0)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 2)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
-- --             return true
-- --         elseif player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 5 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 5 then
-- --             player:teleportTo(Position(4892, 5110, 6))
-- --             Game.createMonster("Magincia Knight", Position(4893, 5110, 7))
-- --             player:say('Os Corvos de Magincia invocaram um Knight!', TALKTYPE_MONSTER_SAY, false, player, Position(4908, 5107, 6))
-- --             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) + 1)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 0)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 5)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
-- --             local creatureNameElvenshire = getRandomCreatureElvenshire()
-- --             Game.createMonster(creatureNameElvenshire, Position(4900, 5112, 7))
-- --             player:say("Os Corvos de Elvenshire invocaram um " .. creatureNameElvenshire .. "!", TALKTYPE_MONSTER_SAY, false, player, Position(4885, 5107, 6))
-- --             return true
-- --         end
-- --     elseif item:getPosition() == Position(4889, 5110, 6) then
-- --         if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 2 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 2 then
-- --             player:teleportTo(Position(4892, 5110, 6))
-- --             Game.createMonster("Magincia Archer", Position(4892, 5110, 7))
-- --             player:say('Os Corvos de Magincia invocaram um Archer!', TALKTYPE_MONSTER_SAY, false, player, Position(4908, 5107, 6))
-- --             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) + 1)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 0)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 2)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
-- --             return true
-- --         elseif player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 5 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 5 then
-- --             player:teleportTo(Position(4892, 5110, 6))
-- --             Game.createMonster("Magincia Archer", Position(4892, 5110, 7))
-- --             player:say('Os Corvos de Magincia invocaram um Archer!', TALKTYPE_MONSTER_SAY, false, player, Position(4908, 5107, 6))
-- --             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) + 1)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 0)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 5)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
-- --             local creatureNameElvenshire = getRandomCreatureElvenshire()
-- --             Game.createMonster(creatureNameElvenshire, Position(4900, 5112, 7))
-- --             player:say("Os Corvos de Elvenshire invocaram um " .. creatureNameElvenshire .. "!", TALKTYPE_MONSTER_SAY, false, player, Position(4885, 5107, 6))
-- --             return true
-- --         end
-- --     elseif item:getPosition() == Position(4889, 5111, 6) then
-- --         if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 2 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 2 then
-- --             player:teleportTo(Position(4892, 5110, 6))
-- --             Game.createMonster("Magincia Assassin", Position(4893, 5108, 7))
-- --             player:say('Os Corvos de Magincia invocaram um Assassin!', TALKTYPE_MONSTER_SAY, false, player, Position(4908, 5107, 6))
-- --             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) + 1)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 0)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 2)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
-- --             return true
-- --         elseif player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 5 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 5 then
-- --             player:teleportTo(Position(4892, 5110, 6))
-- --             Game.createMonster("Magincia Assassin", Position(4893, 5108, 7))
-- --             player:say('Os Corvos de Magincia invocaram um Assassin!', TALKTYPE_MONSTER_SAY, false, player, Position(4908, 5107, 6))
-- --             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) + 1)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 0)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 5)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
-- --             local creatureNameElvenshire = getRandomCreatureElvenshire()
-- --             Game.createMonster(creatureNameElvenshire, Position(4900, 5112, 7))
-- --             player:say("Os Corvos de Elvenshire invocaram um " .. creatureNameElvenshire .. "!", TALKTYPE_MONSTER_SAY, false, player, Position(4885, 5107, 6))
-- --             return true
-- --         end
-- --     elseif item:getPosition() == Position(4904, 5107, 6) then
-- --         if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 2 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 2 then
-- --             player:teleportTo(Position(4902, 5110, 6))
-- --             Game.createMonster("Elvenshire Arcanist", Position(4899, 5107, 7))
-- --             player:say('Os Cervos de Elvenshire invocaram um Arcanist!', TALKTYPE_MONSTER_SAY, false, player, Position(4885, 5107, 6))
-- --             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) + 1)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 0)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 2)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
-- --             return true
-- --         elseif player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 5 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 5 then
-- --             player:teleportTo(Position(4902, 5110, 6))
-- --             Game.createMonster("Elvenshire Arcanist", Position(4899, 5107, 7))
-- --             player:say('Os Cervos de Elvenshire invocaram um Arcanist!', TALKTYPE_MONSTER_SAY, false, player, Position(4885, 5107, 6))
-- --             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) + 1)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 0)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 5)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
-- --             local creatureNameMagincia = getRandomCreatureMagincia()
-- --             Game.createMonster(creatureNameMagincia, Position(4893, 5113, 7))
-- --             player:say("Os Corvos de Magincia invocaram um " .. creatureNameMagincia .. "!", TALKTYPE_MONSTER_SAY, false, player, Position(4908, 5107, 6))
-- --             return true
-- --         end
-- --     elseif item:getPosition() == Position(4904, 5108, 6) then
-- --         if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 2 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 2 then
-- --             player:teleportTo(Position(4902, 5110, 6))
-- --             Game.createMonster("Elvenshire Mage", Position(4898, 5110, 7))
-- --             player:say('Os Cervos de Elvenshire invocaram um Mage!', TALKTYPE_MONSTER_SAY, false, player, Position(4885, 5107, 6))
-- --             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) + 1)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 0)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 2)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
-- --             return true
-- --         elseif player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 5 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 5 then
-- --             player:teleportTo(Position(4902, 5110, 6))
-- --             Game.createMonster("Elvenshire Mage", Position(4898, 5110, 7))
-- --             player:say('Os Cervos de Elvenshire invocaram um Mage!', TALKTYPE_MONSTER_SAY, false, player, Position(4885, 5107, 6))
-- --             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) + 1)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 0)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 5)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
-- --             local creatureNameMagincia = getRandomCreatureMagincia()
-- --             Game.createMonster(creatureNameMagincia, Position(4893, 5113, 7))
-- --             player:say("Os Corvos de Magincia invocaram um " .. creatureNameMagincia .. "!", TALKTYPE_MONSTER_SAY, false, player, Position(4908, 5107, 6))
-- --             return true
-- --         end
-- --     elseif item:getPosition() == Position(4904, 5109, 6) then
-- --         if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 2 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 2 then
-- --             player:teleportTo(Position(4902, 5110, 6))
-- --             Game.createMonster("Elvenshire Knight", Position(4897, 5110, 7))
-- --             player:say('Os Cervos de Elvenshire invocaram um Knight!', TALKTYPE_MONSTER_SAY, false, player, Position(4885, 5107, 6))
-- --             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) + 1)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 0)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 2)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
-- --             return true
-- --         elseif player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 5 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 5 then
-- --             player:teleportTo(Position(4902, 5110, 6))
-- --             Game.createMonster("Elvenshire Knight", Position(4897, 5110, 7))
-- --             player:say('Os Cervos de Elvenshire invocaram um Knight!', TALKTYPE_MONSTER_SAY, false, player, Position(4885, 5107, 6))
-- --             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) + 1)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 0)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 5)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
-- --             local creatureNameMagincia = getRandomCreatureMagincia()
-- --             Game.createMonster(creatureNameMagincia, Position(4893, 5113, 7))
-- --             player:say("Os Corvos de Magincia invocaram um " .. creatureNameMagincia .. "!", TALKTYPE_MONSTER_SAY, false, player, Position(4908, 5107, 6))
-- --             return true
-- --         end
-- --     elseif item:getPosition() == Position(4904, 5110, 6) then
-- --         if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 2 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 2 then
-- --             player:teleportTo(Position(4902, 5110, 6))
-- --             Game.createMonster("Elvenshire Archer", Position(4899, 5110, 7))
-- --             player:say('Os Cervos de Elvenshire invocaram um Archer!', TALKTYPE_MONSTER_SAY, false, player, Position(4885, 5107, 6))
-- --             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) + 1)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 0)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 2)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
-- --             return true
-- --         elseif player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 5 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 5 then
-- --             player:teleportTo(Position(4902, 5110, 6))
-- --             Game.createMonster("Elvenshire Archer", Position(4899, 5110, 7))
-- --             player:say('Os Cervos de Elvenshire invocaram um Archer!', TALKTYPE_MONSTER_SAY, false, player, Position(4885, 5107, 6))
-- --             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) + 1)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 0)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 5)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
-- --             local creatureNameMagincia = getRandomCreatureMagincia()
-- --             Game.createMonster(creatureNameMagincia, Position(4893, 5113, 7))
-- --             player:say("Os Corvos de Magincia invocaram um " .. creatureNameMagincia .. "!", TALKTYPE_MONSTER_SAY, false, player, Position(4908, 5107, 6))
-- --             return true
-- --         end
-- --     elseif item:getPosition() == Position(4904, 5111, 6) then
-- --         if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 2 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 2 then
-- --             player:teleportTo(Position(4902, 5110, 6))
-- --             Game.createMonster("Elvenshire Assassin", Position(4900, 5112, 7))
-- --             player:say('Os Cervos de Elvenshire invocaram um Assassin!', TALKTYPE_MONSTER_SAY, false, player, Position(4885, 5107, 6))
-- --             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) + 1)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 0)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 2)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
-- --             return true
-- --         elseif player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 5 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 5 then
-- --             player:teleportTo(Position(4902, 5110, 6))
-- --             Game.createMonster("Elvenshire Assassin", Position(4900, 5112, 7))
-- --             player:say('Os Cervos de Elvenshire invocaram um Assassin!', TALKTYPE_MONSTER_SAY, false, player, Position(4885, 5107, 6))
-- --             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) + 1)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 0)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 5)
-- --             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
-- --             local creatureNameMagincia = getRandomCreatureMagincia()
-- --             Game.createMonster(creatureNameMagincia, Position(4893, 5113, 7))
-- --             player:say("Os Corvos de Magincia invocaram um " .. creatureNameMagincia .. "!", TALKTYPE_MONSTER_SAY, false, player, Position(4908, 5107, 6))
-- --             return true
-- --         end
-- --     elseif item:getPosition() == Position(4889, 5112, 6) then
-- --         player:teleportTo(Position(4892, 5110, 6))
-- --         local creatureNameMagincia = getRandomCreatureMagincia()
-- --         Game.createMonster(creatureNameMagincia, Position(4893, 5113, 7))
-- --         player:say("Os Corvos de Magincia invocaram um " .. creatureNameMagincia .. "!", TALKTYPE_MONSTER_SAY, false, player, Position(4908, 5107, 6))
-- --         player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 0)
-- --         player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 2)
-- --         player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
-- --         return true
-- --     elseif item:getPosition() == Position(4904, 5112, 6) then
-- --         player:teleportTo(Position(4902, 5110, 6))
-- --         local creatureNameElvenshire = getRandomCreatureElvenshire()
-- --         Game.createMonster(creatureNameElvenshire, Position(4900, 5112, 7))
-- --         player:say("Os Corvos de Elvenshire invocaram um " .. creatureNameElvenshire .. "!", TALKTYPE_MONSTER_SAY, false, player, Position(4885, 5107, 6))
-- --         player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 2)
-- --         player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 0)
-- --         player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
-- --         return true
-- --     elseif item:getPosition(Position(4897, 5110, 6)) then
-- --         if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer) < os.time() then
-- --             local function countMonstersInArea(area, monsterNames)
-- --                 local count = 0
-- --                 for _, monster in ipairs(Game.getSpectators(Position(4896, 5110, 7), false, false, 10, 10, 10, 10)) do
-- --                     if monster:isMonster() then
-- --                         for _, name in ipairs(monsterNames) do
-- --                             if monster:getName():lower() == name:lower() then
-- --                                 count = count + 1
-- --                                 break
-- --                             end
-- --                         end
-- --                     end
-- --                 end
-- --                 return count
-- --             end
        
-- --             local function checkIfTeamWon(players, pointsStorage)
-- --                 local count = 0
-- --                 for _, player in ipairs(players) do
-- --                     if player:getStorageValue(pointsStorage) >= 2 then
-- --                         count = count + 1
-- --                     end
-- --                 end
-- --                 -- Se o número de jogadores com pontos suficientes for igual ao número total de jogadores no time, o time venceu
-- --                 return count == #players
-- --             end

-- --             local function addPointsAndCheckWinner(players, pointsStorage)
-- --                 for _, player in ipairs(players) do
-- --                     if player:getStorageValue(pointsStorage) < 2 then
-- --                         player:setStorageValue(pointsStorage, player:getStorageValue(pointsStorage) + 1)
-- --                     end
-- --                 end
-- --             end

-- --             -- local function removeMonstersFromArea(area)
-- --             --     local monsters = Game.getSpectators(Position(4896, 5110, 7), false, false, 10, 10, 10, 10)
-- --             --     for _, monster in ipairs(monsters) do
-- --             --         if monster:isMonster() then
-- --             --             monster:remove()
-- --             --         end
-- --             --     end
-- --             -- end
        
-- --             -- Verificar se há um time vencedor
-- --             local winnerTeam
-- --             local pointsMaginciaStorage = Storage.Quest.Crandoria.TibiaRoyale.PointsMagincia
-- --             local pointsElvenshireStorage = Storage.Quest.Crandoria.TibiaRoyale.PointsElvenshire
-- --             local pointsPosition = Position(4870, 5113, 7)  -- Posição de mensagem
        
-- --             local playersInMagincia = {}
-- --             local playersInElvenshire = {}
        
-- --             for _, player in ipairs(Game.getPlayers()) do
-- --                 if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) > 0 then
-- --                     table.insert(playersInMagincia, player)
-- --                 elseif player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) > 0 then
-- --                     table.insert(playersInElvenshire, player)
-- --                 end
-- --             end
        
-- --             local monstersMagincia = countMonstersInArea(areaGeralBaixo, {"Magincia Knight", "Magincia Mage", "Magincia Archer", "Magincia Assassin", "Magincia Arcanist"})
-- --             local monstersElvenshire = countMonstersInArea(areaGeralBaixo, {"Elvenshire Knight", "Elvenshire Mage", "Elvenshire Archer", "Elvenshire Assassin", "Elvenshire Arcanist"})
        
-- --             if monstersMagincia > 0 and monstersElvenshire == 0 then
-- --                 winnerTeam = "Magincia"
-- --             elseif monstersElvenshire > 0 and monstersMagincia == 0 then
-- --                 winnerTeam = "Elvenshire"
-- --             elseif monstersElvenshire > 0 and monstersMagincia > 0 then
-- --                 winnerTeam = "None"
-- --             end

-- --             local function transportAllPlayers(players, destination)
-- --                 for _, player in ipairs(players) do
-- --                     player:teleportTo(destination)
-- --                 end
-- --             end

-- --             local function transportPlayers(players, position)
-- --                 for _, player in ipairs(players) do
-- --                     player:teleportTo(position)
-- --                 end
-- --             end

-- --             local function transportPlayersWin(players, position)
-- --                 for _, player in ipairs(players) do
-- --                     player:teleportTo(position)
-- --                     player:addItem(22720, 1)
-- --                     -- if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.WinPoints) < 1 then
-- --                     --     player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.WinPoints, 1)
-- --                     -- else
-- --                     --     player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.WinPoints, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.WinPoints) + 1)
-- --                     -- end
-- --                 end
-- --             end
        
-- --             -- Se houver um time vencedor
-- --             if winnerTeam then
-- --                 if winnerTeam == "Magincia" then
-- --                     addPointsAndCheckWinner(playersInMagincia, pointsMaginciaStorage)
-- --                     if checkIfTeamWon(playersInMagincia, pointsMaginciaStorage) then
-- --                         transportPlayersWin(playersInMagincia, Position(4870, 5113, 7)) 
-- --                         transportPlayers(playersInElvenshire, Position(4870, 5113, 7))  
-- --                         removeMonstersFromArea(areaGeralBaixo)
-- --                     else
-- --                         transportPlayers(playersInMagincia, Position(4884, 5110, 6))  
-- --                         transportPlayers(playersInElvenshire, Position(4909, 5110, 6))
-- --                         removeMonstersFromArea(areaGeralBaixo)
-- --                     end
-- --                 elseif winnerTeam == "Elvenshire" then
-- --                     addPointsAndCheckWinner(playersInElvenshire, pointsElvenshireStorage)
-- --                     if checkIfTeamWon(playersInElvenshire, pointsElvenshireStorage) then
-- --                         transportPlayers(playersInMagincia, Position(4870, 5113, 7)) 
-- --                         transportPlayersWin(playersInElvenshire, Position(4870, 5113, 7))  
-- --                         removeMonstersFromArea(areaGeralBaixo)
-- --                     else
-- --                         transportPlayers(playersInMagincia, Position(4884, 5110, 6))  
-- --                         transportPlayers(playersInElvenshire, Position(4909, 5110, 6)) 
-- --                         removeMonstersFromArea(areaGeralBaixo)
-- --                     end
-- --                 elseif winnerTeam == "None" then
-- --                     player:say('A batalha ainda nao acabou!', TALKTYPE_MONSTER_SAY, false, player, Position(4897, 5110, 6))
-- --                     player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- --                     return true
-- --                 end
-- --             else
-- --                 -- Não houve vencedor, enviar todos de volta aos locais iniciais
-- --                 transportPlayers(playersInMagincia, Position(4884, 5110, 6))
-- --                 transportPlayers(playersInElvenshire, Position(4909, 5110, 6))
-- --             end
-- --         else
-- --             player:say('Voce deve aguardar no minimo 60 segundos para puxar a alavanca e declarar o vencedor.', TALKTYPE_MONSTER_SAY, false, player, Position(4897, 5110, 6)) 
-- --             return true
-- --         end
-- --     end        
-- -- end

-- -- alavancaWar:aid(12383)
-- -- alavancaWar:register()


-- -- local teleportsTibiaRoyale = MoveEvent()

-- -- function teleportsTibiaRoyale.onStepIn(creature, item, position, fromPosition)
-- --     local player = creature:getPlayer()
-- --     if not player then
-- --         return true
-- --     end

-- --     if item:getPosition() == Position(4870, 5106, 7) then
-- --         player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.PointsMagincia, 0)
-- --         player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.PointsElvenshire, 0)
-- --         player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 0)
-- --         player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 0)
-- --         player:teleportTo(Position(5000, 5000, 6))
-- --         player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce deixou a Arena.")
-- --         return true
-- --     else
-- --         player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.PointsMagincia, 0)
-- --         player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.PointsElvenshire, 0)
-- --         player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 0)
-- --         player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 0)
-- --         player:teleportTo(Position(5000, 5000, 6))
-- --         player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce desistiu da batalha.")
-- --         return true
-- --     end

-- -- end

-- -- teleportsTibiaRoyale:aid(12384)
-- -- teleportsTibiaRoyale:register()




-- local areaGeralCima = {
--     fromPosition = {x = 4882, y = 5100, z = 6},
--     toPosition = {x = 4912, y = 5119, z = 6}
-- }

-- local areaGeralBaixo = {
--     fromPosition = {x = 4882, y = 5100, z = 7},
--     toPosition = {x = 4912, y = 5119, z = 7}
-- }

-- local areaStartMagincia = {
--     fromPosition = {x = 4914, y = 5104, z = 7},
--     toPosition = {x = 4920, y = 5109, z = 7}
-- }

-- local areaStartElvenshire = {
--     fromPosition = {x = 4914, y = 5111, z = 7},
--     toPosition = {x = 4921, y = 5117, z = 7}
-- }

-- local areaLeverMagincia = {
--     fromPosition = {x = 4885, y = 5107, z = 6},
--     toPosition = {x = 4893, y = 5113, z = 6}
-- }

-- local areaLeverElvenshire = {
--     fromPosition = {x = 4902, y = 5107, z = 6},
--     toPosition = {x = 4910, y = 5113, z = 6}
-- }

-- local areaCentral = {
--     fromPosition = {x = 4894, y = 5106, z = 6},
--     toPosition = {x = 4901, y = 5115, z = 6}
-- }

-- local function isInArea(player, area)
--     local playerPos = player:getPosition()
--     return playerPos.x >= area.fromPosition.x and playerPos.x <= area.toPosition.x
--         and playerPos.y >= area.fromPosition.y and playerPos.y <= area.toPosition.y
--         and playerPos.z == area.fromPosition.z
-- end

-- local function countPlayersInArea(area)
--     local count = 0
--     for _, player in ipairs(Game.getPlayers()) do
--         if isInArea(player, area) then
--             count = count + 1
--         end
--     end
--     return count
-- end

-- local function transportPlayersToPosition(players, position, storageValues)
--     for _, player in ipairs(players) do
--         player:teleportTo(position)
--         for storage, value in pairs(storageValues) do
--             player:setStorageValue(storage, value)
--             if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.FightCounter) < 1 then
--                 player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.FightCounter, 1)
--             elseif player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.FightCounter) >= 1 and player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.FightCounter) < 4 then
--                 player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.FightCounter, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.FightCounter) + 1)
--             elseif player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.FightCounter) == 4 then
--                 player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.FightCounter, 0)
--                 player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.FightTimer, os.time() + 5 * 60)
--                 player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "A cada tres batalhas voce devera descansar por 5 minutos para poder batalhar outras vezes.")
--             end
--         end
--     end
-- end

-- local function collectGoldTokensFromPedestal(pedestalPosition)
--     local pedestalTile = Tile(pedestalPosition)
--     if not pedestalTile then
--         return 0
--     end
    
--     local pedestalItems = pedestalTile:getItems()
--     local goldTokensCount = 0
--     for _, item in ipairs(pedestalItems) do
--         if item:getId() == 22721 then
--             goldTokensCount = goldTokensCount + item:getCount()
--         end
--     end
    
--     return goldTokensCount
-- end

-- local function collectGoldTokensFromPlayers(players)
--     local totalGoldTokens = 0
--     for _, player in ipairs(players) do
--         local goldTokensCount = player:getItemCount(22721)
--         totalGoldTokens = totalGoldTokens + goldTokensCount
--         if goldTokensCount > 0 then
--             player:removeItem(22721, goldTokensCount)
--         end
--     end
--     return totalGoldTokens
-- end

-- local function areTimersReady(playersInMagincia, playersInElvenshire)
--     for _, player in ipairs(playersInMagincia) do
--         if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.FightTimer) > os.time() then
--             return false
--         end
--     end
    
--     for _, player in ipairs(playersInElvenshire) do
--         if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.FightTimer) > os.time() then
--             return false
--         end
--     end
    
--     return true
-- end


-- local function areGoldTokensReady(playersInMagincia, playersInElvenshire)
--     -- Verificar se todos os jogadores em Magincia têm pelo menos 1 Gold Token
--     for _, player in ipairs(playersInMagincia) do
--         if player:getItemCount(22721) < 1 then
--             return false
--         end
--     end
    
--     -- Verificar se todos os jogadores em Elvenshire têm pelo menos 1 Gold Token
--     for _, player in ipairs(playersInElvenshire) do
--         if player:getItemCount(22721) < 1 then
--             return false
--         end
--     end
    
--     return true
-- end

-- local maginciaCreatures = {
--     "Magincia Knight",
--     "Magincia Mage",
--     "Magincia Archer",
--     "Magincia Arcanist",
--     "Magincia Assassin"
-- }

-- local elvenshireCreatures = {
--     "Elvenshire Knight",
--     "Elvenshire Mage",
--     "Elvenshire Archer",
--     "Elvenshire Arcanist",
--     "Elvenshire Assassin"
-- }

-- local function getRandomCreatureMagincia()
--     return maginciaCreatures[math.random(1, #maginciaCreatures)]
-- end

-- local function getRandomCreatureElvenshire()
--     return elvenshireCreatures[math.random(1, #elvenshireCreatures)]
-- end

-- local alavancaWar = Action()

-- local function removeMonstersFromArea(area)
--     local monsters = Game.getSpectators(Position(4896, 5110, 7), false, false, 10, 10, 10, 10)
--     for _, monster in ipairs(monsters) do
--         if monster:isMonster() then
--             monster:remove()
--         end
--     end
-- end

-- function alavancaWar.onUse(player, item, fromPosition, target, toPosition, isHotkey)

--     if item:getPosition() == Position(4914, 5110, 7) then
--         local lever1 = Tile(Position(4914, 5108, 7)):getItemById(2773)
--         local lever2 = Tile(Position(4914, 5112, 7)):getItemById(2773)

--         if not lever1 or not lever2 then
--             player:say('Ambos os times devem acionar as alavancas laterais para ativar a alavanca principal.', TALKTYPE_MONSTER_SAY, false, player, Position(4914, 5110, 7))
--             return true
--         end

--         local playersInGame1 = {}
--         local playersInGame2 = {}

--         for _, player in ipairs(Game.getPlayers()) do
--             if isInArea(player, areaGeralCima) then
--                 table.insert(playersInGame1, player)
--             elseif isInArea(player, areaGeralBaixo) then
--                 table.insert(playersInGame2, player)
--             end
--         end

--         if #playersInGame1 > 0 or #playersInGame2 > 0 then
--             player:say('Ha uma batalha em andamento agora. Aguardem.', TALKTYPE_MONSTER_SAY, false, player, Position(4914, 5110, 7))
--             player:getPosition():sendMagicEffect(CONST_ME_POFF)
--             return true
--         end

--         local playersInMagincia = {}
--         local playersInElvenshire = {}

--         -- Checar se há jogadores em ambas as áreas
--         for _, player in ipairs(Game.getPlayers()) do
--             if isInArea(player, areaStartMagincia) then
--                 table.insert(playersInMagincia, player)
--             elseif isInArea(player, areaStartElvenshire) then
--                 table.insert(playersInElvenshire, player)
--             end
--         end

--         if #playersInMagincia > 10 or #playersInElvenshire > 10 then
--             player:say('Cada time deve possuir no maximo 10 jogadores.', TALKTYPE_MONSTER_SAY, false, player, Position(4914, 5110, 7))
--             player:getPosition():sendMagicEffect(CONST_ME_POFF)
--             return true
--         end


--         local ipCounts = {}
--         for _, player in ipairs(playersInMagincia) do
--             local ip = player:getIp()
--             ipCounts[ip] = (ipCounts[ip] or 0) + 1
--         end
--         for _, player in ipairs(playersInElvenshire) do
--             local ip = player:getIp()
--             ipCounts[ip] = (ipCounts[ip] or 0) + 1
--         end

--         local hasDuplicateIP = false
--         for _, count in pairs(ipCounts) do
--             if count > 2 then
--                 hasDuplicateIP = true
--                 break
--             end
--         end

--         -- Se houver jogadores com o mesmo IP, retorne verdadeiro
--         if hasDuplicateIP then
--             player:say('Proibido utilizar mais de dois personagens por IP.', TALKTYPE_MONSTER_SAY, false, player, Position(4914, 5110, 7))
--             return true
--         end

--         -- Verificar se há o mesmo número de jogadores em ambas as áreas
--         -- if #playersInMagincia == #playersInElvenshire then
--         --     if areGoldTokensReady(playersInMagincia, playersInElvenshire) then
--         --         -- Remover um Gold Token de cada jogador em ambos os times
--         --         for _, player in ipairs(playersInMagincia) do
--         --             player:removeItem(22721, 1)
--         --         end
--         --         for _, player in ipairs(playersInElvenshire) do
--         --             player:removeItem(22721, 1)
--         --         end

--         --         -- Transportar jogadores para as posições especificadas
--         --         transportPlayersToPosition(playersInMagincia, Position(4884, 5110, 6), {
--         --             [Storage.Quest.Crandoria.TibiaRoyale.StartMagincia] = 1,
--         --             [Storage.Quest.Crandoria.TibiaRoyale.PointsMagincia] = 0
--         --         })
                
--         --         transportPlayersToPosition(playersInElvenshire, Position(4909, 5110, 6), {
--         --             [Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire] = 1,
--         --             [Storage.Quest.Crandoria.TibiaRoyale.PointsElvenshire] = 0
--         --         })
--         --         return true
--         --     else
--         --         player:say('Cada jogador deve possuir pelo menos um Gold Token em suas mochilas.', TALKTYPE_MONSTER_SAY, false, player, Position(4914, 5110, 7))
--         --     end
--         -- else
--         --     player:say('Ambos os times devem possuir o mesmo numero de jogadores para iniciar a batalha.', TALKTYPE_MONSTER_SAY, false, player, Position(4914, 5110, 7))
--         -- end

--         if #playersInMagincia == #playersInElvenshire then
--             if areTimersReady(playersInMagincia, playersInElvenshire) then
--                 if areGoldTokensReady(playersInMagincia, playersInElvenshire) then
--                     for _, player in ipairs(playersInMagincia) do
--                         player:removeItem(22721, 1)
--                     end
--                     for _, player in ipairs(playersInElvenshire) do
--                         player:removeItem(22721, 1)
--                     end
--                     transportPlayersToPosition(playersInMagincia, Position(4887, 5110, 6), {
--                         [Storage.Quest.Crandoria.TibiaRoyale.StartMagincia] = 2,
--                         [Storage.Quest.Crandoria.TibiaRoyale.PointsMagincia] = 0
--                     })
                    
--                     transportPlayersToPosition(playersInElvenshire, Position(4907, 5110, 6), {
--                         [Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire] = 2,
--                         [Storage.Quest.Crandoria.TibiaRoyale.PointsElvenshire] = 0
--                     })
--                     removeMonstersFromArea(areaGeralBaixo)
--                     return true
--                 else
--                     player:say('Cada jogador deve possuir pelo menos um Gold Token em suas mochilas.', TALKTYPE_MONSTER_SAY, false, player, Position(4914, 5110, 7))
--                 end
--             else
--                 player:say('Um ou mais jogadores nao aguardou o tempo de 5 minutos para as proximas batalhas.', TALKTYPE_MONSTER_SAY, false, player, Position(4914, 5110, 7))
--             end
--         elseif #playersInMagincia ~= #playersInElvenshire and (#playersInMagincia < 1 or #playersInElvenshire < 1) then
--             if areTimersReady(playersInMagincia, playersInElvenshire) then
--                 if areGoldTokensReady(playersInMagincia, playersInElvenshire) then
--                     for _, player in ipairs(playersInMagincia) do
--                         player:removeItem(22721, 1)
--                     end
--                     for _, player in ipairs(playersInElvenshire) do
--                         player:removeItem(22721, 1)
--                     end
--                     transportPlayersToPosition(playersInMagincia, Position(4887, 5110, 6), {
--                         [Storage.Quest.Crandoria.TibiaRoyale.StartMagincia] = 5,
--                         [Storage.Quest.Crandoria.TibiaRoyale.PointsMagincia] = 0
--                     })
                    
--                     transportPlayersToPosition(playersInElvenshire, Position(4907, 5110, 6), {
--                         [Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire] = 5,
--                         [Storage.Quest.Crandoria.TibiaRoyale.PointsElvenshire] = 0
--                     })
--                     removeMonstersFromArea(areaGeralBaixo)
--                     return true
--                 else
--                     player:say('Cada jogador deve possuir pelo menos um Gold Token em suas mochilas.', TALKTYPE_MONSTER_SAY, false, player, Position(4914, 5110, 7))
--                 end
--             else
--                 player:say('Um ou mais jogadores nao aguardou o tempo de 1 hora para as proximas batalhas.', TALKTYPE_MONSTER_SAY, false, player, Position(4914, 5110, 7))
--             end
--         else
--             player:say('Ambos os times devem possuir o mesmo numero de jogadores para iniciar a batalha.', TALKTYPE_MONSTER_SAY, false, player, Position(4914, 5110, 7))
--         end

--     elseif item:getPosition() == Position(4892, 5107, 6) then
--         if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 2 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 2 then
--             player:teleportTo(Position(4894, 5110, 6))
--             Game.createMonster("Magincia Arcanist", Position(4895, 5107, 7))
--             player:say('Os Corvos de Magincia invocaram um Arcanist!', TALKTYPE_MONSTER_SAY, false, player, Position(4906, 5107, 6))
--             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) + 1)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 0)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 2)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
--             return true
--         elseif player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 5 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 5 then
--             player:teleportTo(Position(4894, 5110, 6))
--             Game.createMonster("Magincia Arcanist", Position(4895, 5107, 7))
--             player:say('Os Corvos de Magincia invocaram um Arcanist!', TALKTYPE_MONSTER_SAY, false, player, Position(4906, 5107, 6))
--             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) + 1)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 0)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 5)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
--             local creatureNameElvenshire = getRandomCreatureElvenshire()
--             Game.createMonster(creatureNameElvenshire, Position(4898, 5110, 7))
--             player:say("Os Corvos de Elvenshire invocaram um " .. creatureNameElvenshire .. "!", TALKTYPE_MONSTER_SAY, false, player, Position(4888, 5107, 6))
--             return true
--         end
--     elseif item:getPosition() == Position(4892, 5108, 6) then
--         if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 2 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 2 then
--             player:teleportTo(Position(4894, 5110, 6))
--             Game.createMonster("Magincia Mage", Position(4895, 5107, 7))
--             player:say('Os Corvos de Magincia invocaram um Mage!', TALKTYPE_MONSTER_SAY, false, player, Position(4906, 5107, 6))
--             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) + 1)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 0)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 2)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
--             return true
--         elseif player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 5 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 5 then
--             player:teleportTo(Position(4894, 5110, 6))
--             Game.createMonster("Magincia Mage", Position(4895, 5107, 7))
--             player:say('Os Corvos de Magincia invocaram um Mage!', TALKTYPE_MONSTER_SAY, false, player, Position(4906, 5107, 6))
--             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) + 1)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 0)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 5)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
--             local creatureNameElvenshire = getRandomCreatureElvenshire()
--             Game.createMonster(creatureNameElvenshire, Position(4898, 5110, 7))
--             player:say("Os Corvos de Elvenshire invocaram um " .. creatureNameElvenshire .. "!", TALKTYPE_MONSTER_SAY, false, player, Position(4888, 5107, 6))
--             return true
--         end
--     elseif item:getPosition() == Position(4892, 5109, 6) then
--         if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 2 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 2 then
--             player:teleportTo(Position(4894, 5110, 6))
--             Game.createMonster("Magincia Knight", Position(4895, 5110, 7))
--             player:say('Os Corvos de Magincia invocaram um Knight!', TALKTYPE_MONSTER_SAY, false, player, Position(4906, 5107, 6))
--             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) + 1)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 0)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 2)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
--             return true
--         elseif player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 5 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 5 then
--             player:teleportTo(Position(4894, 5110, 6))
--             Game.createMonster("Magincia Knight", Position(4895, 5110, 7))
--             player:say('Os Corvos de Magincia invocaram um Knight!', TALKTYPE_MONSTER_SAY, false, player, Position(4906, 5107, 6))
--             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) + 1)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 0)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 5)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
--             local creatureNameElvenshire = getRandomCreatureElvenshire()
--             Game.createMonster(creatureNameElvenshire, Position(4898, 5110, 7))
--             player:say("Os Corvos de Elvenshire invocaram um " .. creatureNameElvenshire .. "!", TALKTYPE_MONSTER_SAY, false, player, Position(4888, 5107, 6))
--             return true
--         end
--     elseif item:getPosition() == Position(4892, 5110, 6) then
--         if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 2 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 2 then
--             player:teleportTo(Position(4894, 5110, 6))
--             Game.createMonster("Magincia Archer", Position(4895, 5113, 7))
--             player:say('Os Corvos de Magincia invocaram um Archer!', TALKTYPE_MONSTER_SAY, false, player, Position(4906, 5107, 6))
--             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) + 1)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 0)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 2)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
--             return true
--         elseif player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 5 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 5 then
--             player:teleportTo(Position(4894, 5110, 6))
--             Game.createMonster("Magincia Archer", Position(4895, 5113, 7))
--             player:say('Os Corvos de Magincia invocaram um Archer!', TALKTYPE_MONSTER_SAY, false, player, Position(4906, 5107, 6))
--             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) + 1)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 0)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 5)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
--             local creatureNameElvenshire = getRandomCreatureElvenshire()
--             Game.createMonster(creatureNameElvenshire, Position(4898, 5110, 7))
--             player:say("Os Corvos de Elvenshire invocaram um " .. creatureNameElvenshire .. "!", TALKTYPE_MONSTER_SAY, false, player, Position(4888, 5107, 6))
--             return true
--         end
--     elseif item:getPosition() == Position(4892, 5111, 6) then
--         if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 2 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 2 then
--             player:teleportTo(Position(4894, 5110, 6))
--             Game.createMonster("Magincia Assassin", Position(4895, 5113, 7))
--             player:say('Os Corvos de Magincia invocaram um Assassin!', TALKTYPE_MONSTER_SAY, false, player, Position(4906, 5107, 6))
--             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) + 1)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 0)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 2)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
--             return true
--         elseif player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 5 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 5 then
--             player:teleportTo(Position(4894, 5110, 6))
--             Game.createMonster("Magincia Assassin", Position(4895, 5113, 7))
--             player:say('Os Corvos de Magincia invocaram um Assassin!', TALKTYPE_MONSTER_SAY, false, player, Position(4906, 5107, 6))
--             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) + 1)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 0)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 5)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
--             local creatureNameElvenshire = getRandomCreatureElvenshire()
--             Game.createMonster(creatureNameElvenshire, Position(4898, 5110, 7))
--             player:say("Os Corvos de Elvenshire invocaram um " .. creatureNameElvenshire .. "!", TALKTYPE_MONSTER_SAY, false, player, Position(4888, 5107, 6))
--             return true
--         end
--     elseif item:getPosition() == Position(4902, 5107, 6) then
--         if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 2 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 2 then
--             player:teleportTo(Position(4900, 5110, 6))
--             Game.createMonster("Elvenshire Arcanist", Position(4898, 5113, 7))
--             player:say('Os Cervos de Elvenshire invocaram um Arcanist!', TALKTYPE_MONSTER_SAY, false, player, Position(4888, 5107, 6))
--             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) + 1)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 0)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 2)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
--             return true
--         elseif player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 5 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 5 then
--             player:teleportTo(Position(4900, 5110, 6))
--             Game.createMonster("Elvenshire Arcanist", Position(4898, 5113, 7))
--             player:say('Os Cervos de Elvenshire invocaram um Arcanist!', TALKTYPE_MONSTER_SAY, false, player, Position(4888, 5107, 6))
--             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) + 1)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 0)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 5)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
--             local creatureNameMagincia = getRandomCreatureMagincia()
--             Game.createMonster(creatureNameMagincia, Position(4895, 5110, 7))
--             player:say("Os Corvos de Magincia invocaram um " .. creatureNameMagincia .. "!", TALKTYPE_MONSTER_SAY, false, player, Position(4906, 5107, 6))
--             return true
--         end
--     elseif item:getPosition() == Position(4902, 5108, 6) then
--         if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 2 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 2 then
--             player:teleportTo(Position(4900, 5110, 6))
--             Game.createMonster("Elvenshire Mage", Position(4898, 5113, 7))
--             player:say('Os Cervos de Elvenshire invocaram um Mage!', TALKTYPE_MONSTER_SAY, false, player, Position(4888, 5107, 6))
--             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) + 1)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 0)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 2)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
--             return true
--         elseif player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 5 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 5 then
--             player:teleportTo(Position(4900, 5110, 6))
--             Game.createMonster("Elvenshire Mage", Position(4898, 5113, 7))
--             player:say('Os Cervos de Elvenshire invocaram um Mage!', TALKTYPE_MONSTER_SAY, false, player, Position(4888, 5107, 6))
--             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) + 1)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 0)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 5)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
--             local creatureNameMagincia = getRandomCreatureMagincia()
--             Game.createMonster(creatureNameMagincia, Position(4895, 5110, 7))
--             player:say("Os Corvos de Magincia invocaram um " .. creatureNameMagincia .. "!", TALKTYPE_MONSTER_SAY, false, player, Position(4906, 5107, 6))
--             return true
--         end
--     elseif item:getPosition() == Position(4902, 5109, 6) then
--         if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 2 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 2 then
--             player:teleportTo(Position(4900, 5110, 6))
--             Game.createMonster("Elvenshire Knight", Position(4898, 5110, 7))
--             player:say('Os Cervos de Elvenshire invocaram um Knight!', TALKTYPE_MONSTER_SAY, false, player, Position(4888, 5107, 6))
--             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) + 1)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 0)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 2)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
--             return true
--         elseif player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 5 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 5 then
--             player:teleportTo(Position(4900, 5110, 6))
--             Game.createMonster("Elvenshire Knight", Position(4898, 5110, 7))
--             player:say('Os Cervos de Elvenshire invocaram um Knight!', TALKTYPE_MONSTER_SAY, false, player, Position(4888, 5107, 6))
--             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) + 1)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 0)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 5)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
--             local creatureNameMagincia = getRandomCreatureMagincia()
--             Game.createMonster(creatureNameMagincia, Position(4895, 5110, 7))
--             player:say("Os Corvos de Magincia invocaram um " .. creatureNameMagincia .. "!", TALKTYPE_MONSTER_SAY, false, player, Position(4906, 5107, 6))
--             return true
--         end
--     elseif item:getPosition() == Position(4902, 5110, 6) then
--         if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 2 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 2 then
--             player:teleportTo(Position(4900, 5110, 6))
--             Game.createMonster("Elvenshire Archer", Position(4898, 5107, 7))
--             player:say('Os Cervos de Elvenshire invocaram um Archer!', TALKTYPE_MONSTER_SAY, false, player, Position(4888, 5107, 6))
--             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) + 1)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 0)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 2)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
--             return true
--         elseif player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 5 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 5 then
--             player:teleportTo(Position(4900, 5110, 6))
--             Game.createMonster("Elvenshire Archer", Position(4898, 5107, 7))
--             player:say('Os Cervos de Elvenshire invocaram um Archer!', TALKTYPE_MONSTER_SAY, false, player, Position(4888, 5107, 6))
--             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) + 1)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 0)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 5)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
--             local creatureNameMagincia = getRandomCreatureMagincia()
--             Game.createMonster(creatureNameMagincia, Position(4895, 5110, 7))
--             player:say("Os Corvos de Magincia invocaram um " .. creatureNameMagincia .. "!", TALKTYPE_MONSTER_SAY, false, player, Position(4906, 5107, 6))
--             return true
--         end
--     elseif item:getPosition() == Position(4902, 5111, 6) then
--         if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 2 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 2 then
--             player:teleportTo(Position(4900, 5110, 6))
--             Game.createMonster("Elvenshire Assassin", Position(4898, 5107, 7))
--             player:say('Os Cervos de Elvenshire invocaram um Assassin!', TALKTYPE_MONSTER_SAY, false, player, Position(4888, 5107, 6))
--             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) + 1)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 0)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 2)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
--             return true
--         elseif player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) == 5 or player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) == 5 then
--             player:teleportTo(Position(4900, 5110, 6))
--             Game.createMonster("Elvenshire Assassin", Position(4898, 5107, 7))
--             player:say('Os Cervos de Elvenshire invocaram um Assassin!', TALKTYPE_MONSTER_SAY, false, player, Position(4888, 5107, 6))
--             -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) + 1)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 0)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 5)
--             player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
--             local creatureNameMagincia = getRandomCreatureMagincia()
--             Game.createMonster(creatureNameMagincia, Position(4895, 5110, 7))
--             player:say("Os Corvos de Magincia invocaram um " .. creatureNameMagincia .. "!", TALKTYPE_MONSTER_SAY, false, player, Position(4906, 5107, 6))
--             return true
--         end
--     elseif item:getPosition() == Position(4892, 5112, 6) then
--         player:teleportTo(Position(4894, 5110, 6))
--         local creatureNameMagincia = getRandomCreatureMagincia()
--         Game.createMonster(creatureNameMagincia, Position(4895, 5110, 7))
--         player:say("Os Corvos de Magincia invocaram um " .. creatureNameMagincia .. "!", TALKTYPE_MONSTER_SAY, false, player, Position(4906, 5107, 6))
--         player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 0)
--         player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 2)
--         player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
--         local creatureNameElvenshire = getRandomCreatureElvenshire()
--         Game.createMonster(creatureNameElvenshire, Position(4898, 5110, 7))
--         player:say("Os Corvos de Elvenshire invocaram um " .. creatureNameElvenshire .. "!", TALKTYPE_MONSTER_SAY, false, player, Position(4888, 5107, 6))
--         return true
--     elseif item:getPosition() == Position(4902, 5112, 6) then
--         player:teleportTo(Position(4900, 5110, 6))
--         local creatureNameElvenshire = getRandomCreatureElvenshire()
--         Game.createMonster(creatureNameElvenshire, Position(4898, 5110, 7))
--         player:say("Os Corvos de Elvenshire invocaram um " .. creatureNameElvenshire .. "!", TALKTYPE_MONSTER_SAY, false, player, Position(4888, 5107, 6))
--         player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 2)
--         player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 0)
--         player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer, os.time() + 30)
--         local creatureNameMagincia = getRandomCreatureMagincia()
--         Game.createMonster(creatureNameMagincia, Position(4895, 5110, 7))
--         player:say("Os Corvos de Magincia invocaram um " .. creatureNameMagincia .. "!", TALKTYPE_MONSTER_SAY, false, player, Position(4906, 5107, 6))
--         return true
--         ------------------ PROBLEMA NA MAQUINA -------------------------
--     -- elseif item:getPosition() == Position(4898, 5110, 6) then
--     --     if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer) < os.time() then
--     --         local function countMonstersInArea(area, monsterNames)
--     --             local count = 0
--     --             for _, monster in ipairs(Game.getSpectators(Position(4896, 5110, 7), false, false, 10, 10, 10, 10)) do
--     --                 if monster:isMonster() then
--     --                     for _, name in ipairs(monsterNames) do
--     --                         if monster:getName():lower() == name:lower() then
--     --                             count = count + 1
--     --                             break
--     --                         end
--     --                     end
--     --                 end
--     --             end
--     --             return count
--     --         end
        
--     --         -- local function checkIfTeamWon(players, pointsStorage)
--     --         --     local count = 0
--     --         --     for _, player in ipairs(players) do
--     --         --         if player:getStorageValue(pointsStorage) >= 2 then
--     --         --             count = count + 1
--     --         --         end
--     --         --     end
--     --         --     -- Se o número de jogadores com pontos suficientes for igual ao número total de jogadores no time, o time venceu
--     --         --     return count == #players
--     --         --     -- return count
--     --         -- end

--     --         local function checkIfTeamWon(players, pointsStorage)
--     --             local count = 0
--     --             local totalPlayers = #players
            
--     --             -- Verifica se há jogadores no time
--     --             if totalPlayers == 0 then
--     --                 return false
--     --             end
            
--     --             -- Verifica se pelo menos um jogador tem pontos suficientes para vencer
--     --             for _, player in ipairs(players) do
--     --                 if player:getStorageValue(pointsStorage) >= 2 then
--     --                     count = count + 1
--     --                 end
--     --             end
            
--     --             -- Se o número de jogadores com pontos suficientes for igual ao número total de jogadores no time, o time venceu
--     --             return count == totalPlayers
--     --         end

--     --         local function addPointsAndCheckWinner(players, pointsStorage)
--     --             for _, player in ipairs(players) do
--     --                 if player:getStorageValue(pointsStorage) < 2 then
--     --                     player:setStorageValue(pointsStorage, player:getStorageValue(pointsStorage) + 1)
--     --                 end
--     --             end
--     --         end

--     --         local winnerTeam
--     --         local pointsMaginciaStorage = Storage.Quest.Crandoria.TibiaRoyale.PointsMagincia
--     --         local pointsElvenshireStorage = Storage.Quest.Crandoria.TibiaRoyale.PointsElvenshire
--     --         local pointsPosition = Position(4870, 5113, 7)  -- Posição de mensagem
        
--     --         local playersInMagincia = {}
--     --         local playersInElvenshire = {}
        
--     --         for _, player in ipairs(Game.getPlayers()) do
--     --             if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) > 0 then
--     --                 table.insert(playersInMagincia, player)
--     --             elseif player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) > 0 then
--     --                 table.insert(playersInElvenshire, player)
--     --             end
--     --         end
        
--     --         local monstersMagincia = countMonstersInArea(areaGeralBaixo, {"Magincia Knight", "Magincia Mage", "Magincia Archer", "Magincia Assassin", "Magincia Arcanist"})
--     --         local monstersElvenshire = countMonstersInArea(areaGeralBaixo, {"Elvenshire Knight", "Elvenshire Mage", "Elvenshire Archer", "Elvenshire Assassin", "Elvenshire Arcanist"})
        
--     --         if monstersMagincia > 0 and monstersElvenshire == 0 then
--     --             winnerTeam = "Magincia"
--     --         elseif monstersElvenshire > 0 and monstersMagincia == 0 then
--     --             winnerTeam = "Elvenshire"
--     --         elseif monstersElvenshire > 0 and monstersMagincia > 0 then
--     --             winnerTeam = "None"
--     --         end

--     --         local function transportAllPlayers(players, destination)
--     --             for _, player in ipairs(players) do
--     --                 player:teleportTo(destination)
--     --             end
--     --         end

--     --         local function transportPlayers(players, position)
--     --             for _, player in ipairs(players) do
--     --                 player:teleportTo(position)
--     --             end
--     --         end

--     --         local function transportPlayersWin(players, position)
--     --             for _, player in ipairs(players) do
--     --                 player:teleportTo(position)
--     --                 player:addItem(22720, 1)
--     --             end
--     --         end
        
--     --         -- Se houver um time vencedor
--     --         if winnerTeam then
--     --             if winnerTeam == "Magincia" then
--     --                 addPointsAndCheckWinner(playersInMagincia, pointsMaginciaStorage)
--     --                 if checkIfTeamWon(playersInMagincia, pointsMaginciaStorage) then
--     --                     transportPlayersWin(playersInMagincia, Position(4870, 5113, 7)) 
--     --                     transportPlayers(playersInElvenshire, Position(4870, 5113, 7))  
--     --                     removeMonstersFromArea(areaGeralBaixo)
--     --                 else
--     --                     transportPlayers(playersInMagincia, Position(4887, 5110, 6))  
--     --                     transportPlayers(playersInElvenshire, Position(4907, 5110, 6))
--     --                     removeMonstersFromArea(areaGeralBaixo)
--     --                 end
--     --             elseif winnerTeam == "Elvenshire" then
--     --                 addPointsAndCheckWinner(playersInElvenshire, pointsElvenshireStorage)
--     --                 if checkIfTeamWon(playersInElvenshire, pointsElvenshireStorage) then
--     --                     transportPlayers(playersInMagincia, Position(4870, 5113, 7)) 
--     --                     transportPlayersWin(playersInElvenshire, Position(4870, 5113, 7))  
--     --                     removeMonstersFromArea(areaGeralBaixo)
--     --                 else
--     --                     transportPlayers(playersInMagincia, Position(4887, 5110, 6))  
--     --                     transportPlayers(playersInElvenshire, Position(4907, 5110, 6)) 
--     --                     removeMonstersFromArea(areaGeralBaixo)
--     --                 end
--     --             elseif winnerTeam == "None" then
--     --                 player:say('A batalha ainda nao acabou!', TALKTYPE_MONSTER_SAY, false, player, Position(4897, 5110, 6))
--     --                 player:getPosition():sendMagicEffect(CONST_ME_POFF)
--     --                 return true
--     --             end
--     --         else
--     --             -- Não houve vencedor, enviar todos de volta aos locais iniciais
--     --             transportPlayers(playersInMagincia, Position(4887, 5110, 6))
--     --             transportPlayers(playersInElvenshire, Position(4907, 5110, 6))
--     --         end
--     --     else
--     --         player:say('Voce deve aguardar no minimo 30 segundos para puxar a alavanca e declarar o vencedor.', TALKTYPE_MONSTER_SAY, false, player, Position(4897, 5110, 6)) 
--     --         return true
--     --     end
--     -- end      


--     ----------------------------- SO UMA RODADA PLAYER X PLAYER -- MAQUINA FUNCIONANDO --------------------
--     elseif item:getPosition() == Position(4898, 5110, 6) then
--         if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.LeverTimer) < os.time() then
--             local function countMonstersInArea(area, monsterNames)
--                 local count = 0
--                 for _, monster in ipairs(Game.getSpectators(Position(4896, 5110, 7), false, false, 10, 10, 10, 10)) do
--                     if monster:isMonster() then
--                         for _, name in ipairs(monsterNames) do
--                             if monster:getName():lower() == name:lower() then
--                                 count = count + 1
--                                 break
--                             end
--                         end
--                     end
--                 end
--                 return count
--             end

--             local function checkIfTeamWon(players, pointsStorage)
--                 local count = 0
--                 local totalPlayers = #players

--                 -- Verifica se há jogadores no time
--                 if totalPlayers == 0 then
--                     return false
--                 end

--                 -- Verifica se pelo menos um jogador tem pontos suficientes para vencer
--                 for _, player in ipairs(players) do
--                     if player:getStorageValue(pointsStorage) >= 2 then
--                         count = count + 1
--                     end
--                 end

--                 -- Se o número de jogadores com pontos suficientes for igual ao número total de jogadores no time, o time venceu
--                 return count == totalPlayers
--             end

--             local function addPointsAndCheckWinner(players, pointsStorage)
--                 for _, player in ipairs(players) do
--                     if player:getStorageValue(pointsStorage) < 2 then
--                         player:setStorageValue(pointsStorage, player:getStorageValue(pointsStorage) + 1)
--                     end
--                 end
--             end

--             local winnerTeam
--             local pointsMaginciaStorage = Storage.Quest.Crandoria.TibiaRoyale.PointsMagincia
--             local pointsElvenshireStorage = Storage.Quest.Crandoria.TibiaRoyale.PointsElvenshire
--             local pointsPosition = Position(4870, 5113, 7)  -- Posição de mensagem

--             local playersInMagincia = {}
--             local playersInElvenshire = {}

--             local pointsMachineMagincia = player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.PointsMachineMagincia) or 0
--             local pointsMachineElvenshire = player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.PointsMachineElvenshire) or 0

--             for _, player in ipairs(Game.getPlayers()) do
--                 if player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia) > 0 then
--                     table.insert(playersInMagincia, player)
--                 elseif player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire) > 0 then
--                     table.insert(playersInElvenshire, player)
--                 end
--             end

--             local monstersMagincia = countMonstersInArea(areaGeralBaixo, {"Magincia Knight", "Magincia Mage", "Magincia Archer", "Magincia Assassin", "Magincia Arcanist"})
--             local monstersElvenshire = countMonstersInArea(areaGeralBaixo, {"Elvenshire Knight", "Elvenshire Mage", "Elvenshire Archer", "Elvenshire Assassin", "Elvenshire Arcanist"})

--             if monstersMagincia > 0 and monstersElvenshire == 0 then
--                 winnerTeam = "Magincia"
--             elseif monstersElvenshire > 0 and monstersMagincia == 0 then
--                 winnerTeam = "Elvenshire"
--             elseif monstersElvenshire > 0 and monstersMagincia > 0 then
--                 winnerTeam = "None"
--             end

--             local function transportAllPlayers(players, destination)
--                 for _, player in ipairs(players) do
--                     player:teleportTo(destination)
--                 end
--             end

--             local function transportPlayers(players, position)
--                 for _, player in ipairs(players) do
--                     player:teleportTo(position)
--                 end
--             end

--             local function transportPlayersWin(players, position)
--                 for _, player in ipairs(players) do
--                     player:teleportTo(position)
--                     player:addItem(22720, 1)
--                     player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.PointsMagincia, 0)
--                     player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.PointsElvenshire, 0)
--                     player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartMagincia, 0)
--                     player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.StartElvenshire, 0)
--                 end
--             end

--             local function addPointsToMachine(winnerTeam)
--                 if winnerTeam == "Magincia" then
--                     pointsMachineMagincia = pointsMachineMagincia + 1
--                     player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.PointsMachineMagincia, pointsMachineMagincia)
--                 elseif winnerTeam == "Elvenshire" then
--                     pointsMachineElvenshire = pointsMachineElvenshire + 1
--                     player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.PointsMachineElvenshire, pointsMachineElvenshire)
--                 end
--             end

--             -- Se houver um time vencedor
--             if winnerTeam then
--                 if winnerTeam == "Magincia" then
--                     addPointsAndCheckWinner(playersInMagincia, pointsMaginciaStorage)
--                     addPointsToMachine(winnerTeam)
--                     if checkIfTeamWon(playersInMagincia, pointsMaginciaStorage) or pointsMachineMagincia >= 2 then
--                         transportPlayersWin(playersInMagincia, Position(4870, 5113, 7))
--                         transportPlayers(playersInElvenshire, Position(4870, 5113, 7))
--                         removeMonstersFromArea(areaGeralBaixo)
--                     else
--                         transportPlayers(playersInMagincia, Position(4887, 5110, 6))
--                         transportPlayers(playersInElvenshire, Position(4907, 5110, 6))
--                         removeMonstersFromArea(areaGeralBaixo)
--                     end
--                 elseif winnerTeam == "Elvenshire" then
--                     addPointsAndCheckWinner(playersInElvenshire, pointsElvenshireStorage)
--                     addPointsToMachine(winnerTeam)
--                     if checkIfTeamWon(playersInElvenshire, pointsElvenshireStorage) or pointsMachineElvenshire >= 2 then
--                         transportPlayers(playersInMagincia, Position(4870, 5113, 7))
--                         transportPlayersWin(playersInElvenshire, Position(4870, 5113, 7))
--                         removeMonstersFromArea(areaGeralBaixo)
--                     else
--                         transportPlayers(playersInMagincia, Position(4887, 5110, 6))
--                         transportPlayers(playersInElvenshire, Position(4907, 5110, 6))
--                         removeMonstersFromArea(areaGeralBaixo)
--                     end
--                 elseif winnerTeam == "None" then
--                     player:say('A batalha ainda nao acabou!', TALKTYPE_MONSTER_SAY, false, player, Position(4897, 5110, 6))
--                     player:getPosition():sendMagicEffect(CONST_ME_POFF)
--                     return true
--                 end
--             else
--                 -- Não houve vencedor, enviar todos de volta aos locais iniciais
--                 transportPlayers(playersInMagincia, Position(4887, 5110, 6))
--                 transportPlayers(playersInElvenshire, Position(4907, 5110, 6))
--             end
--         else
--             player:say('Voce deve aguardar no minimo 30 segundos para puxar a alavanca e declarar o vencedor.', TALKTYPE_MONSTER_SAY, false, player, Position(4897, 5110, 6))
--             return true
--         end
--     end


-- end

-- alavancaWar:aid(12383)
-- alavancaWar:register()


local teleportsTibiaRoyale = MoveEvent()

function teleportsTibiaRoyale.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if item:getPosition() == Position(4870, 5106, 7) then
		player:setStorageValue(Storage.Quest.Crandoria.TibiaAram.TimeChaos, 0)
		player:setStorageValue(Storage.Quest.Crandoria.TibiaAram.TimeAnvillux, 0)
        player:setStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral, 0)
        player:teleportTo(Position(5000, 5000, 6))
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce deixou a Arena.")
        return true
    else
		player:setStorageValue(Storage.Quest.Crandoria.TibiaAram.TimeChaos, 0)
		player:setStorageValue(Storage.Quest.Crandoria.TibiaAram.TimeAnvillux, 0)
        player:setStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral, 0)
        player:teleportTo(Position(5000, 5000, 6))
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce desistiu da batalha.")
        return true
    end

end

teleportsTibiaRoyale:aid(12384)
teleportsTibiaRoyale:register()
