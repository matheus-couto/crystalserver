local bomberman = Action()

function bomberman.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item:getPosition() == Position(4836, 5104, 7) then
        local playerStartPositions = {
            Position(4837, 5104, 7),
            Position(4838, 5104, 7),
            -- Position(4839, 5104, 7)
        }
        local destinationPositions = {
            Position(3965, 4608, 7),
            Position(3965, 4618, 7),
            -- Position(3975, 4608, 7)
        }

        local itemToCreate = 9827
        local blockingItems = {9835, 9827} 

        local fromPos = Position(3959, 4608, 7)
        local toPos = Position(3971, 4618, 7)

        local exceptions = {
            Position(3965, 4608, 7),
            Position(3964, 4609, 7),
            Position(3965, 4609, 7),
            Position(3966, 4609, 7),
            Position(3965, 4610, 7),
            Position(3965, 4616, 7),
            Position(3965, 4617, 7),
            Position(3965, 4618, 7),
            Position(3964, 4617, 7),
            Position(3966, 4617, 7)
        }

        local function positionsEqual(pos1, pos2)
            return pos1.x == pos2.x and pos1.y == pos2.y and pos1.z == pos2.z
        end
        
        local function isException(pos)
            for _, excPos in ipairs(exceptions) do
                if positionsEqual(pos, excPos) then
                    return true
                end
            end
            return false
        end

        local function hasBlockingItem(tile)
            for _, tileItem in ipairs(tile:getItems() or {}) do
                for _, blockId in ipairs(blockingItems) do
                    if tileItem:getId() == blockId then
                        return true
                    end
                end
            end
            return false
        end

        local spectators = Game.getSpectators(Position(3965, 4613, 7), false, true, 7, 7, 7, 7)
        if #spectators > 0 then
            player:say('Ha uma partida em andamento.', TALKTYPE_MONSTER_SAY)
            return true
        end

        local players = {}
        for i, pos in ipairs(playerStartPositions) do
            local creature = Tile(pos):getTopCreature()
            if not creature or not creature:isPlayer() then
                player:say('Sao necessarios 2 jogadores para jogar.', TALKTYPE_MONSTER_SAY)
                return true
            end
            table.insert(players, creature)
        end
        -- Verifica se todos os IPs são diferentes e se todos têm dinheiro
        for i = 1, #players do
            local ip1 = players[i]:getIp()
            local balance = players[i]:getBankBalance()
            local storageCooldown = players[i]:getStorageValue(Storage.Quest.Crandoria.Bomberman.Cooldown1)
            if balance < 5000 then
                -- players[i]:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa de 25.000 gold no banco para participar.")
                players[i]:say('Voce precisa de 5.000 gold no banco para participar.', TALKTYPE_MONSTER_SAY)
                return true
            end
            if storageCooldown > os.time() then
                local timeLeft = math.floor((storageCooldown - os.time()) / 60)
                local plural = timeLeft == 1 and "minuto" or "minutos"
                players[i]:say("Voce deve esperar " .. timeLeft .. " " .. plural .. " ate a próxima partida nesse modo.", TALKTYPE_MONSTER_SAY)
                return true
            end
            if players[i]:getLevel() < 200 then
                players[i]:say('Todos os jogadores devem possuir nivel 200 ou superior para jogar.', TALKTYPE_MONSTER_SAY)
                return true
            end
            for j = i + 1, #players do
                local ip2 = players[j]:getIp()
                if ip1 == ip2 then
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Apenas um personagem por jogador.")
                    return true
                end
            end
        end

        for x = fromPos.x, toPos.x do
            for y = fromPos.y, toPos.y do
                local pos = Position(x, y, fromPos.z)
                if not isException(pos) then
                    local tile = Tile(pos)
                    if tile and not hasBlockingItem(tile) then
                        Game.createItem(itemToCreate, 1, pos)
                    end
                end
            end
        end

        -- Cobra o dinheiro e teleporta os jogadores
        for i, p in ipairs(players) do
            p:removeMoneyBank(5000)
            p:teleportTo(destinationPositions[i])
            p:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            p:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Batalha iniciada!")
            p:setStorageValue(Storage.Quest.Crandoria.Bomberman.TimerBomb, 0)
            p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Power, 1)
            p:setStorageValue(Storage.Quest.Crandoria.Bomberman.MoreBomb, 1)
            p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Game, 1)
            p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Invulneravel, os.time() + 3)
            p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Cooldown1, os.time() + 60 * 5)
            p:setSpeed(200)
            local tileFlame = Tile(Position(4836, 5103, 7))
            if tileFlame and tileFlame:getItemById(20497) then
                p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Life, 1)
            else
                p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Life, 3)
            end
            addEvent(function()
                if p and p:isPlayer() and isPlayerInArea(Position(3957, 4605, 7), Position(3974, 4621, 7)) then
                    p:teleportTo(Position(4870, 5112, 7))
                    p:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Fim da batalha")
                    p:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
                end
            end, 5 * 60 * 1000)
        end
        return false
    elseif item:getPosition() == Position(4835, 5109, 7) then
        local playerStartPositions = {
            Position(4836, 5109, 7),
            Position(4837, 5109, 7),
            Position(4838, 5109, 7)
        }
        local destinationPositions = {
            Position(3987, 4608, 7),
            Position(3981, 4617, 7),
            Position(3993, 4618, 7)
        }

        local itemsToCreate = {8503, 8504, 8505, 8506} -- itens aleatórios para criar
        local blockingItems = {9835, 9827, 8503, 8504, 8505, 8506} -- itens que bloqueiam a criação
        
        local fromPos = Position(3981, 4608, 7)
        local toPos = Position(3993, 4618, 7)
        
        local exceptions = {
            Position(3981, 4616, 7),
            Position(3981, 4617, 7),
            Position(3981, 4618, 7),
            Position(3982, 4617, 7),
            Position(3993, 4618, 7),
            Position(3993, 4617, 7),
            Position(3993, 4616, 7),
            Position(3992, 4617, 7),
            Position(3987, 4608, 7),
            Position(3987, 4609, 7),
            Position(3987, 4610, 7),
            Position(3986, 4609, 7),
            Position(3988, 4609, 7),
        }
        
        local function positionsEqual(pos1, pos2)
            return pos1.x == pos2.x and pos1.y == pos2.y and pos1.z == pos2.z
        end
        
        local function isException(pos)
            for _, excPos in ipairs(exceptions) do
                if positionsEqual(pos, excPos) then
                    return true
                end
            end
            return false
        end
        
        local function hasBlockingItem(tile)
            for _, tileItem in ipairs(tile:getItems() or {}) do
                for _, blockId in ipairs(blockingItems) do
                    if tileItem:getId() == blockId then
                        return true
                    end
                end
            end
            return false
        end

        local spectators = Game.getSpectators(Position(3987, 4613, 7), false, true, 7, 7, 7, 7)
        if #spectators > 0 then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ha uma partida em andamento.")
            return true
        end

        local players = {}
        for i, pos in ipairs(playerStartPositions) do
            local creature = Tile(pos):getTopCreature()
            if not creature or not creature:isPlayer() then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Sao necessarios 3 jogadores para jogar.")
                return true
            end
            table.insert(players, creature)
        end
        -- Verifica se todos os IPs são diferentes e se todos têm dinheiro
        for i = 1, #players do
            local ip1 = players[i]:getIp()
            local balance = players[i]:getBankBalance()
            local storageCooldown = players[i]:getStorageValue(Storage.Quest.Crandoria.Bomberman.Cooldown2)
            if balance < 5000 then
                players[i]:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa de 5.000 gold no banco para participar.")
                return true
            end
            if storageCooldown > os.time() then
                local timeLeft = math.floor((storageCooldown - os.time()) / 60)
                local plural = timeLeft == 1 and "minuto" or "minutos"
                players[i]:say("Voce deve esperar " .. timeLeft .. " " .. plural .. " ate a próxima partida nesse modo.", TALKTYPE_MONSTER_SAY)
                return true
            end
            if players[i]:getLevel() < 200 then
                players[i]:say('Todos os jogadores devem possuir nivel 200 ou superior para jogar.', TALKTYPE_MONSTER_SAY)
                return true
            end
            for j = i + 1, #players do
                local ip2 = players[j]:getIp()
                if ip1 == ip2 then
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Apenas um personagem por jogador.")
                    return true
                end
            end
        end

        for x = fromPos.x, toPos.x do
            for y = fromPos.y, toPos.y do
                local pos = Position(x, y, fromPos.z)
                if not isException(pos) then
                    local tile = Tile(pos)
                    if tile and not hasBlockingItem(tile) then
                        local chosenItemId = itemsToCreate[math.random(#itemsToCreate)]
                        Game.createItem(chosenItemId, 1, pos)
                    end
                end
            end
        end
        
        -- Cobra o dinheiro e teleporta os jogadores
        for i, p in ipairs(players) do
            p:removeMoneyBank(5000)
            p:teleportTo(destinationPositions[i])
            p:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            p:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Batalha iniciada!")
            p:setStorageValue(Storage.Quest.Crandoria.Bomberman.TimerBomb, 0)
            p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Power, 1)
            p:setStorageValue(Storage.Quest.Crandoria.Bomberman.MoreBomb, 1)
            p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Game, 2)
            p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Invulneravel, os.time() + 3)
            p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Cooldown2, os.time() + 60 * 8)
            p:setSpeed(200)
            local tileFlame = Tile(Position(4835, 5108, 7))
            if tileFlame and tileFlame:getItemById(20497) then
                p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Life, 1)
            else
                p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Life, 3)
            end
            addEvent(function()
                if p and p:isPlayer() and isPlayerInArea(Position(3979, 4605, 7), Position(3997, 4621, 7)) then
                    p:teleportTo(Position(4870, 5112, 7))
                    p:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Fim da batalha")
                    p:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
                end
            end, 8 * 60 * 1000)
        end
        return true
    elseif item:getPosition() == Position(4834, 5114, 7) then
        local playerStartPositions = {
            Position(4835, 5114, 7),
            Position(4836, 5114, 7),
            Position(4837, 5114, 7),
            Position(4838, 5114, 7),
        }
        local destinationPositions = {
            Position(3913, 4608, 7),
            Position(3913, 4618, 7),
            Position(3925, 4618, 7),
            Position(3925, 4608, 7),
        }

        local itemToCreate = 9831
        local blockingItems = {9835, 9827, 9831, 9841} 

        local fromPos = Position(3913, 4608, 7)
        local toPos = Position(3925, 4618, 7)

        local exceptions = {
            Position(3925, 4618, 7),
            Position(3925, 4617, 7),
            Position(3925, 4616, 7),
            Position(3924, 4617, 7),
            Position(3913, 4618, 7),
            Position(3913, 4617, 7),
            Position(3913, 4616, 7),
            Position(3914, 4617, 7),
            Position(3913, 4608, 7),
            Position(3913, 4609, 7),
            Position(3913, 4610, 7),
            Position(3914, 4609, 7),
            Position(3925, 4608, 7),
            Position(3925, 4609, 7),
            Position(3925, 4610, 7),
            Position(3924, 4609, 7),
        }

        local function positionsEqual(pos1, pos2)
            return pos1.x == pos2.x and pos1.y == pos2.y and pos1.z == pos2.z
        end
        
        local function isException(pos)
            for _, excPos in ipairs(exceptions) do
                if positionsEqual(pos, excPos) then
                    return true
                end
            end
            return false
        end

        local function hasBlockingItem(tile)
            for _, tileItem in ipairs(tile:getItems() or {}) do
                for _, blockId in ipairs(blockingItems) do
                    if tileItem:getId() == blockId then
                        return true
                    end
                end
            end
            return false
        end

        local spectators = Game.getSpectators(Position(3919, 4613, 7), false, true, 7, 7, 7, 7)
        if #spectators > 0 then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ha uma partida em andamento.")
            return true
        end

        local players = {}
        for i, pos in ipairs(playerStartPositions) do
            local creature = Tile(pos):getTopCreature()
            if not creature or not creature:isPlayer() then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Sao necessarios 4 jogadores para jogar.")
                return true
            end
            table.insert(players, creature)
        end
        -- Verifica se todos os IPs são diferentes e se todos têm dinheiro
        for i = 1, #players do
            local ip1 = players[i]:getIp()
            local balance = players[i]:getBankBalance()
            local storageCooldown = players[i]:getStorageValue(Storage.Quest.Crandoria.Bomberman.Cooldown3)
            if balance < 5000 then
                players[i]:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa de 5.000 gold no banco para participar.")
                return true
            end
            if storageCooldown > os.time() then
                local timeLeft = math.floor((storageCooldown - os.time()) / 60)
                local plural = timeLeft == 1 and "minuto" or "minutos"
                players[i]:say("Voce deve esperar " .. timeLeft .. " " .. plural .. " ate a próxima partida nesse modo.", TALKTYPE_MONSTER_SAY)
                return true
            end
            if players[i]:getLevel() < 200 then
                players[i]:say('Todos os jogadores devem possuir nivel 200 ou superior para jogar.', TALKTYPE_MONSTER_SAY)
                return true
            end
            for j = i + 1, #players do
                local ip2 = players[j]:getIp()
                if ip1 == ip2 then
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Apenas um personagem por jogador.")
                    return true
                end
            end
        end
        -- Cobra o dinheiro e teleporta os jogadores
        for i, p in ipairs(players) do
            p:removeMoneyBank(5000)
            p:teleportTo(destinationPositions[i])
            p:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            p:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Batalha iniciada!")
            p:setStorageValue(Storage.Quest.Crandoria.Bomberman.TimerBomb, 0)
            p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Power, 1)
            p:setStorageValue(Storage.Quest.Crandoria.Bomberman.MoreBomb, 1)
            p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Game, 3)
            p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Invulneravel, os.time() + 3)
            p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Cooldown3, os.time() + 60 * 10)
            p:setSpeed(200)
            local tileFlame = Tile(Position(4834, 5113, 7))
            if tileFlame and tileFlame:getItemById(20497) then
                p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Life, 1)
            else
                p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Life, 3)
            end
            addEvent(function()
                if p and p:isPlayer() and isPlayerInArea(Position(3911, 4605, 7), Position(3929, 4621, 7)) then
                    p:teleportTo(Position(4870, 5112, 7))
                    p:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Fim da batalha")
                    p:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
                end
            end, 10 * 60 * 1000)
        end
        return true
    elseif item:getPosition() == Position(4836, 5103, 7) then
        if item.itemid == 20497 then
            item:transform(20498)
            return true
        elseif item.itemid == 20498 then
            item:transform(20497)
            return true
        end
    elseif item:getPosition() == Position(4835, 5108, 7) then
        if item.itemid == 20497 then
            item:transform(20498)
            return true
        elseif item.itemid == 20498 then
            item:transform(20497)
            return true
        end
    elseif item:getPosition() == Position(4834, 5113, 7) then
        if item.itemid == 20497 then
            item:transform(20498)
            return true
        elseif item.itemid == 20498 then
            item:transform(20497)
            return true
        end
    end
end

bomberman:aid(13152)
bomberman:register()



-- local bomberman = Action()

-- function bomberman.onUse(player, item, fromPosition, target, toPosition, isHotkey)
--     if item:getPosition() == Position(4836, 5104, 7) then
--         local playerStartPositions = {
--             Position(4837, 5104, 7),
--             Position(4838, 5104, 7),
--             -- Position(4839, 5104, 7)
--         }
--         local destinationPositions = {
--             Position(3965, 4608, 7),
--             Position(3965, 4618, 7),
--             -- Position(3975, 4608, 7)
--         }

--         local spectators = Game.getSpectators(Position(3965, 4613, 7), false, true, 7, 7, 7, 7)
--         if #spectators > 0 then
--             player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ha uma partida em andamento.")
--             return true
--         end

--         local players = {}
--         for i, pos in ipairs(playerStartPositions) do
--             local creature = Tile(pos):getTopCreature()
--             if not creature or not creature:isPlayer() then
--                 player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Sao necessarios 2 jogadores para jogar.")
--                 return true
--             end
--             table.insert(players, creature)
--         end
--         -- Verifica se todos os IPs são diferentes e se todos têm dinheiro
--         for i = 1, #players do
--             local ip1 = players[i]:getIp()
--             local balance = players[i]:getBankBalance()
--             if balance < 25000 then
--                 players[i]:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa de 25.000 gold no banco para participar.")
--                 return true
--             end
--             -- for j = i + 1, #players do
--             --     local ip2 = players[j]:getIp()
--             --     if ip1 == ip2 then
--             --         player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Apenas um personagem por jogador.")
--             --         return true
--             --     end
--             -- end
--         end
--         -- Cobra o dinheiro e teleporta os jogadores
--         for i, p in ipairs(players) do
--             p:removeMoneyBank(25000)
--             p:teleportTo(destinationPositions[i])
--             p:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--             p:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Batalha iniciada!")
--             p:setStorageValue(Storage.Quest.Crandoria.Bomberman.TimerBomb, 0)
--             p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Power, 1)
--             p:setStorageValue(Storage.Quest.Crandoria.Bomberman.MoreBomb, 1)
--             p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Game, 1)
--             p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Invulneravel, os.time() + 3)
--             local tileFlame = Tile(Position(4836, 5103, 7))
--             if tileFlame and tileFlame:getItemById(20497) then
--                 p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Life, 1)
--             else
--                 p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Life, 3)
--             end
--             addEvent(function()
--                 if p and p:isPlayer() and isPlayerInArea(Position(3957, 4605, 7), Position(3974, 4621, 7)) then
--                     p:teleportTo(Position(4870, 5112, 7))
--                     p:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Fim da batalha")
--                     p:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--                 end
--             end, 10 * 60 * 1000)
--         end
--         return true
--     elseif item:getPosition() == Position(4835, 5109, 7) then
--         local playerStartPositions = {
--             Position(4836, 5109, 7),
--             Position(4837, 5109, 7),
--             Position(4838, 5109, 7)
--         }
--         local destinationPositions = {
--             Position(3987, 4608, 7),
--             Position(3981, 4617, 7),
--             Position(3993, 4618, 7)
--         }

--         local spectators = Game.getSpectators(Position(3987, 4613, 7), false, true, 7, 7, 7, 7)
--         if #spectators > 0 then
--             player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ha uma partida em andamento.")
--             return true
--         end

--         local players = {}
--         for i, pos in ipairs(playerStartPositions) do
--             local creature = Tile(pos):getTopCreature()
--             if not creature or not creature:isPlayer() then
--                 player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Sao necessarios 3 jogadores para jogar.")
--                 return true
--             end
--             table.insert(players, creature)
--         end
--         -- Verifica se todos os IPs são diferentes e se todos têm dinheiro
--         for i = 1, #players do
--             local ip1 = players[i]:getIp()
--             local balance = players[i]:getBankBalance()
--             if balance < 25000 then
--                 players[i]:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa de 25.000 gold no banco para participar.")
--                 return true
--             end
--             -- for j = i + 1, #players do
--             --     local ip2 = players[j]:getIp()
--             --     if ip1 == ip2 then
--             --         player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Apenas um personagem por jogador.")
--             --         return true
--             --     end
--             -- end
--         end
--         -- Cobra o dinheiro e teleporta os jogadores
--         for i, p in ipairs(players) do
--             p:removeMoneyBank(25000)
--             p:teleportTo(destinationPositions[i])
--             p:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--             p:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Batalha iniciada!")
--             p:setStorageValue(Storage.Quest.Crandoria.Bomberman.TimerBomb, 0)
--             p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Power, 1)
--             p:setStorageValue(Storage.Quest.Crandoria.Bomberman.MoreBomb, 1)
--             p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Game, 2)
--             p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Invulneravel, os.time() + 3)
--             local tileFlame = Tile(Position(4835, 5108, 7))
--             if tileFlame and tileFlame:getItemById(20497) then
--                 p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Life, 1)
--             else
--                 p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Life, 3)
--             end
--             addEvent(function()
--                 if p and p:isPlayer() and isPlayerInArea(Position(3979, 4605, 7), Position(3997, 4621, 7)) then
--                     p:teleportTo(Position(4870, 5112, 7))
--                     p:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Fim da batalha")
--                     p:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--                 end
--             end, 10 * 60 * 1000)
--         end
--         return true
--     elseif item:getPosition() == Position(4834, 5114, 7) then
--         local playerStartPositions = {
--             Position(4835, 5114, 7),
--             Position(4836, 5114, 7),
--             Position(4837, 5114, 7),
--             Position(4838, 5114, 7),
--         }
--         local destinationPositions = {
--             Position(3913, 4608, 7),
--             Position(3913, 4618, 7),
--             Position(3925, 4618, 7),
--             Position(3925, 4608, 7),
--         }

--         local spectators = Game.getSpectators(Position(3919, 4613, 7), false, true, 7, 7, 7, 7)
--         if #spectators > 0 then
--             player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ha uma partida em andamento.")
--             return true
--         end

--         local players = {}
--         for i, pos in ipairs(playerStartPositions) do
--             local creature = Tile(pos):getTopCreature()
--             if not creature or not creature:isPlayer() then
--                 player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Sao necessarios 4 jogadores para jogar.")
--                 return true
--             end
--             table.insert(players, creature)
--         end
--         -- Verifica se todos os IPs são diferentes e se todos têm dinheiro
--         for i = 1, #players do
--             local ip1 = players[i]:getIp()
--             local balance = players[i]:getBankBalance()
--             if balance < 25000 then
--                 players[i]:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa de 25.000 gold no banco para participar.")
--                 return true
--             end
--             -- for j = i + 1, #players do
--             --     local ip2 = players[j]:getIp()
--             --     if ip1 == ip2 then
--             --         player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Apenas um personagem por jogador.")
--             --         return true
--             --     end
--             -- end
--         end
--         -- Cobra o dinheiro e teleporta os jogadores
--         for i, p in ipairs(players) do
--             p:removeMoneyBank(25000)
--             p:teleportTo(destinationPositions[i])
--             p:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--             p:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Batalha iniciada!")
--             p:setStorageValue(Storage.Quest.Crandoria.Bomberman.TimerBomb, 0)
--             p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Power, 1)
--             p:setStorageValue(Storage.Quest.Crandoria.Bomberman.MoreBomb, 1)
--             p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Game, 3)
--             p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Invulneravel, os.time() + 3)
--             local tileFlame = Tile(Position(4834, 5113, 7))
--             if tileFlame and tileFlame:getItemById(20497) then
--                 p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Life, 1)
--             else
--                 p:setStorageValue(Storage.Quest.Crandoria.Bomberman.Life, 3)
--             end
--             addEvent(function()
--                 if p and p:isPlayer() and isPlayerInArea(Position(3911, 4605, 7), Position(3929, 4621, 7)) then
--                     p:teleportTo(Position(4870, 5112, 7))
--                     p:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Fim da batalha")
--                     p:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--                 end
--             end, 10 * 60 * 1000)
--         end
--         return true
--     elseif item:getPosition() == Position(4836, 5103, 7) then
--         if item.itemid == 20497 then
--             item:transform(20498)
--             return true
--         elseif item.itemid == 20498 then
--             item:transform(20497)
--             return true
--         end
--     elseif item:getPosition() == Position(4835, 5108, 7) then
--         if item.itemid == 20497 then
--             item:transform(20498)
--             return true
--         elseif item.itemid == 20498 then
--             item:transform(20497)
--             return true
--         end
--     elseif item:getPosition() == Position(4834, 5113, 7) then
--         if item.itemid == 20497 then
--             item:transform(20498)
--             return true
--         elseif item.itemid == 20498 then
--             item:transform(20497)
--             return true
--         end
--     end
-- end

-- bomberman:aid(13152)
-- bomberman:register()