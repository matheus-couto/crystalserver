local leverRedPath = Action()

function leverRedPath.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local leverPosition = item:getPosition()

    -- Calcular posição da lâmpada
    local lampX = leverPosition.x + 3
    local lampY = leverPosition.y + 1
    local lampZ = leverPosition.z -- assumindo que a lâmpada está na mesma altura que a alavanca

    -- Obter a lâmpada na posição calculada
    local lamp = Tile(Position(lampX, lampY, lampZ)):getItemById(17412)
    local lamp2 = Tile(Position(lampX, lampY, lampZ)):getItemById(17411)
    local lampPosition = Tile(Position(lampX, lampY, lampZ))

    if player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers) < 1 then
        player:sendCancelMessage("Fale com Frigard para acessar as alavancas.")
    elseif player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers) >= 1 then
        if item:getPosition() == Position(6102, 5239, 8) then
            if player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers) == 1 then
                if lamp then
                    lamp:transform(17411)
                    player:setStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers, 2)
                    player:say('Primeira alavanca ativada.', TALKTYPE_MONSTER_SAY, false, player, Position(6102, 5239, 8))
                    addEvent(function()
                        local litLamp = lampPosition:getItemById(17411)
                        if litLamp then
                            litLamp:transform(17412) -- Transforme a lâmpada de volta ao seu estado original
                        end
                    end, 5 * 60 * 1000) -- 1 minuto em milissegundos
                elseif lamp2 then
                    player:setStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers, 2)
                    player:say('Primeira alavanca ativada.', TALKTYPE_MONSTER_SAY, false, player, Position(6102, 5239, 8))
                    addEvent(function()
                        local litLamp = lampPosition:getItemById(17411)
                        if litLamp then
                            litLamp:transform(17412) 
                        end
                    end, 5 * 60 * 1000) 
                else
                end
            elseif player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers) > 1 then
                player:sendCancelMessage("Voce ja ativou essa alavanca.")
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            end
        elseif item:getPosition() == Position(6044, 5240, 8) then
            if player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers) == 2 then
                if lamp then
                    lamp:transform(17411)
                    player:setStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers, 3)
                    player:say('Segunda alavanca ativada.', TALKTYPE_MONSTER_SAY, false, player, Position(6044, 5240, 8))
                    addEvent(function()
                        local litLamp = lampPosition:getItemById(17411)
                        if litLamp then
                            litLamp:transform(17412) 
                        end
                    end, 5 * 60 * 1000) 
                elseif lamp2 then
                    player:setStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers, 3)
                    player:say('Segunda alavanca ativada.', TALKTYPE_MONSTER_SAY, false, player, Position(6044, 5240, 8))
                    addEvent(function()
                        local litLamp = lampPosition:getItemById(17411)
                        if litLamp then
                            litLamp:transform(17412) 
                        end
                    end, 5 * 60 * 1000) 
                end
            elseif player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers) < 2 then
                player:sendCancelMessage("Voce esqueceu de alguma alavanca.")
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            elseif player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers) > 2 then
                player:sendCancelMessage("Voce ja ativou essa alavanca.")
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            end
        elseif item:getPosition() == Position(6045, 5297, 8) then
            if player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers) == 3 then
                if lamp then
                    lamp:transform(17411)
                    player:setStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers, 4)
                    player:say('Terceira alavanca ativada.', TALKTYPE_MONSTER_SAY, false, player, Position(6045, 5297, 8))
                    addEvent(function()
                        local litLamp = lampPosition:getItemById(17411)
                        if litLamp then
                            litLamp:transform(17412) 
                        end
                    end, 5 * 60 * 1000) 
                elseif lamp2 then
                    player:setStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers, 4)
                    player:say('Terceira alavanca ativada.', TALKTYPE_MONSTER_SAY, false, player, Position(6045, 5297, 8))
                    addEvent(function()
                        local litLamp = lampPosition:getItemById(17411)
                        if litLamp then
                            litLamp:transform(17412) 
                        end
                    end, 5 * 60 * 1000) 
                end
            elseif player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers) < 3 then
                player:sendCancelMessage("Voce esqueceu de alguma alavanca.")
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            else
                player:sendCancelMessage("Voce ja ativou essa alavanca.")
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            end
        elseif item:getPosition() == Position(6080, 5309, 8) then
            if player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers) == 4 then
                if lamp then
                    lamp:transform(17411)
                    player:setStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers, 5)
                    player:say('Quarta lavanca ativada.', TALKTYPE_MONSTER_SAY, false, player, Position(6080, 5309, 8))
                    addEvent(function()
                        local litLamp = lampPosition:getItemById(17411)
                        if litLamp then
                            litLamp:transform(17412) 
                        end
                    end, 5 * 60 * 1000) 
                elseif lamp2 then
                    player:setStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers, 5)
                    player:say('Quarta alavanca ativada.', TALKTYPE_MONSTER_SAY, false, player, Position(6080, 5309, 8))
                    addEvent(function()
                        local litLamp = lampPosition:getItemById(17411)
                        if litLamp then
                            litLamp:transform(17412) 
                        end
                    end, 5 * 60 * 1000) 
                end
            elseif player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers) < 4 then
                player:sendCancelMessage("Voce esqueceu de alguma alavanca.")
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            else
                player:sendCancelMessage("Voce ja ativou essa alavanca.")
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            end
        elseif item:getPosition() == Position(6078, 5333, 8) then
            if player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers) == 5 then
                if lamp then
                    lamp:transform(17411)
                    player:setStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers, 6)
                    player:say('Quinta alavanca ativada.', TALKTYPE_MONSTER_SAY, false, player, Position(6078, 5333, 8))
                    addEvent(function()
                        local litLamp = lampPosition:getItemById(17411)
                        if litLamp then
                            litLamp:transform(17412) 
                        end
                    end, 5 * 60 * 1000) 
                elseif lamp2 then
                    player:setStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers, 6)
                    player:say('Quinta alavanca ativada.', TALKTYPE_MONSTER_SAY, false, player, Position(6078, 5333, 8))
                    addEvent(function()
                        local litLamp = lampPosition:getItemById(17411)
                        if litLamp then
                            litLamp:transform(17412) 
                        end
                    end, 5 * 60 * 1000) 
                end
            elseif player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers) < 5 then
                player:sendCancelMessage("Voce esqueceu de alguma alavanca.")
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            else
                player:sendCancelMessage("Voce ja ativou essa alavanca.")
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            end
        elseif item:getPosition() == Position(6112, 5349, 8) then
            if player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers) == 6 then
                if lamp then
                    lamp:transform(17411)
                    player:setStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers, 7)
                    player:say('Sexta alavanca ativada.', TALKTYPE_MONSTER_SAY, false, player, Position(6112, 5349, 8))
                    addEvent(function()
                        local litLamp = lampPosition:getItemById(17411)
                        if litLamp then
                            litLamp:transform(17412) 
                        end
                    end, 5 * 60 * 1000) 
                elseif lamp2 then
                    player:setStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers, 7)
                    player:say('Sexta alavanca ativada.', TALKTYPE_MONSTER_SAY, false, player, Position(6112, 5349, 8))
                    addEvent(function()
                        local litLamp = lampPosition:getItemById(17411)
                        if litLamp then
                            litLamp:transform(17412) 
                        end
                    end, 5 * 60 * 1000) 
                end
            elseif player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers) < 6 then
                player:sendCancelMessage("Voce esqueceu de alguma alavanca.")
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            else
                player:sendCancelMessage("Voce ja ativou essa alavanca.")
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            end
        elseif item:getPosition() == Position(6176, 5321, 8) then
            if player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers) == 7 then
                if lamp then
                    lamp:transform(17411)
                    player:setStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers, 8)
                    player:say('Setima alavanca ativada.', TALKTYPE_MONSTER_SAY, false, player, Position(6176, 5321, 8))
                    addEvent(function()
                        local litLamp = lampPosition:getItemById(17411)
                        if litLamp then
                            litLamp:transform(17412) 
                        end
                    end, 5 * 60 * 1000)
                elseif lamp2 then
                    player:setStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers, 8)
                    player:say('Setima alavanca ativada.', TALKTYPE_MONSTER_SAY, false, player, Position(6176, 5321, 8))
                    addEvent(function()
                        local litLamp = lampPosition:getItemById(17411)
                        if litLamp then
                            litLamp:transform(17412) 
                        end
                    end, 5 * 60 * 1000)  
                end
            elseif player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers) < 7 then
                player:sendCancelMessage("Voce esqueceu de alguma alavanca.")
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            else
                player:sendCancelMessage("Voce ja ativou essa alavanca.")
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            end
        elseif item:getPosition() == Position(6185, 5291, 8) then
            if player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers) == 8 then
                if lamp then
                    lamp:transform(17411)
                    player:setStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers, 9)
                    player:say('Oitava alavanca ativada.', TALKTYPE_MONSTER_SAY, false, player, Position(6185, 5291, 8))
                    addEvent(function()
                        local litLamp = lampPosition:getItemById(17411)
                        if litLamp then
                            litLamp:transform(17412) 
                        end
                    end, 5 * 60 * 1000) 
                elseif lamp2 then
                    player:setStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers, 9)
                    player:say('Oitava alavanca ativada.', TALKTYPE_MONSTER_SAY, false, player, Position(6185, 5291, 8))
                    addEvent(function()
                        local litLamp = lampPosition:getItemById(17411)
                        if litLamp then
                            litLamp:transform(17412) 
                        end
                    end, 5 * 60 * 1000) 
                end
            elseif player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers) < 8 then
                player:sendCancelMessage("Voce esqueceu de alguma alavanca.")
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            else
                player:sendCancelMessage("Voce ja ativou essa alavanca.")
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            end
        elseif item:getPosition() == Position(6175, 5253, 8) then
            if player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers) == 9 then
                if lamp then
                    lamp:transform(17411)
                    player:setStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers, 10)
                    player:say('Nona alavanca ativada.', TALKTYPE_MONSTER_SAY, false, player, Position(6175, 5253, 8))
                    addEvent(function()
                        local litLamp = lampPosition:getItemById(17411)
                        if litLamp then
                            litLamp:transform(17412) 
                        end
                    end, 5 * 60 * 1000) 
                elseif lamp2 then
                    player:setStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers, 10)
                    player:say('Nona alavanca ativada.', TALKTYPE_MONSTER_SAY, false, player, Position(6175, 5253, 8))
                    addEvent(function()
                        local litLamp = lampPosition:getItemById(17411)
                        if litLamp then
                            litLamp:transform(17412) 
                        end
                    end, 5 * 60 * 1000) 
                end
            elseif player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers) < 9 then
                player:sendCancelMessage("Voce esqueceu de alguma alavanca.")
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            else
                player:sendCancelMessage("Voce ja ativou essa alavanca.")
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            end
        elseif item:getPosition() == Position(6141, 5244, 8) then
            if player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers) == 10 then
                if lamp then
                    lamp:transform(17411)
                    player:setStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers, 11)
                    player:say('Ultima alavanca ativada.', TALKTYPE_MONSTER_SAY, false, player, Position(6141, 5244, 8))
                    addEvent(function()
                        local litLamp = lampPosition:getItemById(17411)
                        if litLamp then
                            litLamp:transform(17412) 
                        end
                    end, 5 * 60 * 1000) 
                elseif lamp2 then
                    player:setStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers, 11)
                    player:say('Ultima alavanca ativada.', TALKTYPE_MONSTER_SAY, false, player, Position(6141, 5244, 8))
                    addEvent(function()
                        local litLamp = lampPosition:getItemById(17411)
                        if litLamp then
                            litLamp:transform(17412) 
                        end
                    end, 5 * 60 * 1000) 
                end
            elseif player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers) < 10 then
                player:sendCancelMessage("Voce esqueceu de alguma alavanca.")
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            else
                player:sendCancelMessage("Voce ja ativou essa alavanca.")
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            end
        end
    end
end


leverRedPath:aid(12321)
leverRedPath:register()