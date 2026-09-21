local jackRabbit = MoveEvent()

function jackRabbit.onStepIn(creature, item, position, fromPosition)
    if item:getPosition() == Position(4668, 4699, 14) then
        if creature:isMonster() and creature:getName() == "Jack the Rabbit" then
            creature:getPosition():sendMagicEffect(CONST_ME_POFF)
            creature:remove()

            -- Define a área delimitada
            local fromX, fromY, fromZ = 4655, 4695, 14
            local toX, toY, toZ = 4670, 4703, 14

            -- Itera sobre todos os jogadores
            for _, player in ipairs(Game.getPlayers()) do
                -- Verifica se o jogador está na área delimitada
                if player:getPosition().x >= fromX and player:getPosition().x <= toX and
                player:getPosition().y >= fromY and player:getPosition().y <= toY and
                player:getPosition().z == fromZ then
                    -- Altera o valor da storage
                    player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress, 7)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O Coelho passou correndo pela porta, mas voce nao sabe como abri-la.")
                end
            end
        end
    elseif item:getPosition() == Position(4491, 4604, 15) then
        if creature:isMonster() and creature:getName() == "Jack the Rabbit" then
            creature:getPosition():sendMagicEffect(CONST_ME_POFF)
            creature:remove()
            local stonePosition = {x = 4469, y = 4609, z = 15}
            Tile(stonePosition):getItemById(1842):remove()
            addEvent(function()
                Game.createItem(1842, 1, stonePosition)
            end, 5 * 60 * 1000)

            local fromX2, fromY2, fromZ2 = 4485, 4599, 15
            local toX2, toY2, toZ2 = 4499, 4611, 15

            for _, player in ipairs(Game.getPlayers()) do
                -- Verifica se o jogador está na área delimitada
                if player:getPosition().x >= fromX2 and player:getPosition().x <= toX2 and player:getPosition().y >= fromY2 and player:getPosition().y <= toY2 and player:getPosition().z == fromZ2 then
                    player:say("O Coelho entrou num portal e parecia estar indo ate o castelo ao lado!", TALKTYPE_MONSTER_SAY)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O Coelho entrou num portal e parecia estar indo ate o castelo ao lado!")
                end
            end
        end
        -- player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O Coelho entrou no buraco e parecia estar indo ate o castelo ao lado!")
    elseif item:getPosition() == Position(4707, 4824, 15) then
        if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor) > 10 then
            player:teleportTo(Position(4695, 4835, 15))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        else
            player:teleportTo(fromPosition)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa do poder das 10 fadas para enfrentar este monstro.")
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
        end
    end
end

jackRabbit:aid(12373)
jackRabbit:register()