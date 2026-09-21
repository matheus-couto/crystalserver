local teleportBomberman = MoveEvent()

function teleportBomberman.onStepIn(player, item, position, fromPosition)
    if item:getPosition() == Position(3965, 4607, 7) or item:getPosition() == Position(3965, 4619, 7) then
        local area1 = {
            fromPosition = Position(3959, 4608, 7),
            toPosition = Position(3971, 4618, 7)
        }
    
        local exitPosition1 = Position(4870, 5112, 7) 
        local winnerPosition1 = Position(4870, 5113, 7)
        
        player:teleportTo(exitPosition1)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce abandonou a partida.")

        -- Aguarda um pequeno tempo antes de verificar se há apenas 1 jogador na arena
        addEvent(function()
            local alivePlayers = {}

            for x = area1.fromPosition.x, area1.toPosition.x do
                for y = area1.fromPosition.y, area1.toPosition.y do
                    local tile = Tile(Position(x, y, area1.fromPosition.z))
                    if tile then
                        local creature = tile:getTopCreature()
                        if creature and creature:isPlayer() then
                            table.insert(alivePlayers, creature)
                        end
                    end
                end
            end

            if #alivePlayers == 1 then
                local winner = alivePlayers[1]
                winner:teleportTo(winnerPosition1)
                winner:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
                winner:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce venceu a partida de Bomberman!")
                winner:addItem(3035, 50)
                if winner:getStorageValue(Storage.Quest.Crandoria.Bomberman.Game) == 1 then
                    if winner:getStorageValue(Storage.Quest.Crandoria.Bomberman.TimerToken1) < os.time() then
                        winner:setStorageValue(Storage.Quest.Crandoria.Bomberman.TimerToken1, os.time() + 60 * 60 * 20)
                        winner:addItem(22720, 1)
                    end
                end
            end
        end, 100)
    elseif item:getPosition() == Position(3980, 4617, 7) or item:getPosition() == Position(3987, 4607, 7) or item:getPosition() == Position(3993, 4619, 7) then
        local area2 = {
            fromPosition = Position(3981, 4608, 7),
            toPosition = Position(3993, 4618, 7)
        }
    
        local exitPosition2 = Position(4870, 5112, 7) 
        local winnerPosition2 = Position(4870, 5113, 7)
        
        player:teleportTo(exitPosition2)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce abandonou a partida.")

        -- Aguarda um pequeno tempo antes de verificar se há apenas 1 jogador na arena
        addEvent(function()
            local alivePlayers = {}

            for x = area1.fromPosition.x, area1.toPosition.x do
                for y = area1.fromPosition.y, area1.toPosition.y do
                    local tile = Tile(Position(x, y, area1.fromPosition.z))
                    if tile then
                        local creature = tile:getTopCreature()
                        if creature and creature:isPlayer() then
                            table.insert(alivePlayers, creature)
                        end
                    end
                end
            end

            if #alivePlayers == 1 then
                local winner = alivePlayers[1]
                winner:teleportTo(winnerPosition2)
                winner:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
                winner:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce venceu a partida de Bomberman!")
                if winner:getStorageValue(Storage.Quest.Crandoria.Bomberman.Game) == 2 then
                    if winner:getStorageValue(Storage.Quest.Crandoria.Bomberman.TimerToken2) < os.time() then
                        winner:setStorageValue(Storage.Quest.Crandoria.Bomberman.TimerToken2, os.time() + 60 * 60 * 12)
                        winner:addItem(22720, 1)
                    end
                end
            end
        end, 100)
    elseif item:getPosition() == Position(3912, 4608, 7) or item:getPosition() == Position(3912, 4617, 7) or item:getPosition() == Position(3925, 4619, 7) or item:getPosition() == Position(3925, 4607, 7) then
        local area3 = {
            fromPosition = Position(3913, 4608, 7),
            toPosition = Position(3925, 4618, 7)
        }
    
        local exitPosition3 = Position(4870, 5112, 7) 
        local winnerPosition3 = Position(4870, 5113, 7)
        
        player:teleportTo(exitPosition3)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce abandonou a partida.")

        -- Aguarda um pequeno tempo antes de verificar se há apenas 1 jogador na arena
        addEvent(function()
            local alivePlayers = {}

            for x = area1.fromPosition.x, area1.toPosition.x do
                for y = area1.fromPosition.y, area1.toPosition.y do
                    local tile = Tile(Position(x, y, area1.fromPosition.z))
                    if tile then
                        local creature = tile:getTopCreature()
                        if creature and creature:isPlayer() then
                            table.insert(alivePlayers, creature)
                        end
                    end
                end
            end

            if #alivePlayers == 1 then
                local winner = alivePlayers[1]
                winner:teleportTo(winnerPosition3)
                winner:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
                winner:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce venceu a partida de Bomberman!")
                if winner:getStorageValue(Storage.Quest.Crandoria.Bomberman.Game) == 3 then
                    if winner:getStorageValue(Storage.Quest.Crandoria.Bomberman.TimerToken3) < os.time() then
                        winner:setStorageValue(Storage.Quest.Crandoria.Bomberman.TimerToken3, os.time() + 60 * 60 * 6)
                        winner:addItem(22720, 1)
                    end
                end
            end
        end, 100)
    end

    return true
end

teleportBomberman:aid(13153)
teleportBomberman:register()



-- local teleportBomberman = MoveEvent()

-- function teleportBomberman.onStepIn(player, item, position, fromPosition)

--     local area1 = {
--         fromPosition = {x = 3959, y = 4608, z = 7},
--         toPosition = {x = 3971, y = 4618, z = 7}
--     }

--     if item:getPosition() == Position(3912, 4608, 7) or item:getPosition() == Position(3912, 4617, 7) or item:getPosition() == Position(3925, 4619, 7) or item:getPosition() == Position(3925, 4607, 7) then
--         -- se quando o jogador entrar no teleport sobrar apenas um jogador na área, o jogador que ficou é declarado o vencedor e é teleportado para a posição Position(4870, 5113, 7)

-- teleportBomberman:aid(13153)
-- teleportBomberman:register()