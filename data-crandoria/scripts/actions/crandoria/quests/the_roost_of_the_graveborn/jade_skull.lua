local dragonJadeSkull = Action()

function dragonJadeSkull.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    local storage = player:getStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Progresso)
    local pos = player:getPosition()
    local x = pos.x
    local y = pos.y
    local z = pos.z

    if storage < 1 then
        return false
    elseif storage == 1 then
        if x < 4342 or x > 4643 or y < 4775 or y > 5148 then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce esta longe do Dragon Ancestor Spirit. Va para a superficie de Dracantus para iniciar sua busca.")
            pos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
            return false
        else
            if z == 7 then
                if y > 4880 then
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Caminhe pela superficie de Dracantus em direcao a regiao norte da ilha.")
                    pos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
                    return false
                else
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesse as catacumbas dos Haunted Dragons na parte noroeste de Dracantus.")
                    pos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
                    return false
                end
            elseif z == 8 then
                if x < 4418 or x > 4550 or y < 4795 or y > 4935 then
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce esta longe do Dragon Ancestor Spirit. Va para a superficie de Dracantus para iniciar sua busca.")
                    pos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
                    return false
                else
                    if x < 4439 or x > 4442 or y < 4868 or y > 4875 then
                        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce esta perto...")
                        pos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
                        return false
                    else
                        player:teleportTo(Position(4436, 4892, 9))
                        pos:sendMagicEffect(CONST_ME_TELEPORT)
                        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou a sala do Dragon Ancestor Spirit.")
                        player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Progresso, 2)
                        return false
                    end
                end
            else
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce esta longe do Dragon Ancestor Spirit. Va para a superficie de Dracantus para iniciar sua busca.")
                pos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
                return false
            end
        end
    elseif storage >= 2 then
        if x >= 4439 and x <= 4442 and y >= 4868 and y <= 4875 and z == 8 then
            player:teleportTo(Position(4436, 4892, 9))
            pos:sendMagicEffect(CONST_ME_TELEPORT)
        else
            if storage == 2 then
                if isPlayerInArea(Position(4423, 4948, 9), Position(4427, 4951, 9)) then
                    player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Progresso, 3)
                    player:addItem(52709, 1)
                    player:addItem(52708, 1)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou o Grupo de Aventureiros e o Fatal Bug. Reporte ao Dragon Ancestor Spirit.")
                    pos:sendMagicEffect(221)
                    return true
                end
            elseif storage == 4 then
                if isPlayerInArea(Position(4455, 5002, 9), Position(4457, 5004, 9)) then
                    player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Progresso, 5)
                    player:addItem(52709, 1)
                    player:addItem(52708, 1)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou o Eldritch Dragon Lord. Reporte ao Dragon Ancestor Spirit.")
                    pos:sendMagicEffect(221)
                end
            elseif storage == 6 then
                if isPlayerInArea(Position(4555, 4846, 9), Position(4559, 4848, 9)) then
                    player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Progresso, 7)
                    player:addItem(52709, 1)
                    player:addItem(52708, 1)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou o Ice Horror. Reporte ao Dragon Ancestor Spirit.")
                    pos:sendMagicEffect(221)
                end  
            elseif storage == 8 then  
                if isPlayerInArea(Position(4533, 4964, 9), Position(4535, 4966, 9)) then
                    player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Progresso, 9)
                    player:addItem(52709, 1)
                    player:addItem(52708, 1)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou The Gravedigger. Reporte ao Dragon Ancestor Spirit.")
                    pos:sendMagicEffect(221)
                end  
            end
        end
    end
    return false
end

dragonJadeSkull:id(51976)
dragonJadeSkull:register()