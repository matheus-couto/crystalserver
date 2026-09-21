local teleport = Action()

function teleport.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not player then
        return true
    end

    local knight = player:getVocation():getBaseId() == VOCATION.BASE_ID.KNIGHT
    local paladin = player:getVocation():getBaseId() == VOCATION.BASE_ID.PALADIN
    local monk = player:getVocation():getBaseId() == VOCATION.BASE_ID.MONK
    local druid = player:getVocation():getBaseId() == VOCATION.BASE_ID.DRUID
    local sorcerer = player:getVocation():getBaseId() == VOCATION.BASE_ID.SORCERER

    local vocation = config[player:getVocation():getBase():getName():lower()]

    if item:getPosition() == Position(5965, 5547, 6) then
        if player:getStorageValue(Storage.Quest.Crandoria.PiratesQuest.Progresso) == 1 then
            local container = player:addItem(5927, 1)
            if container then
                container:addItem(3029, 5)
                container:addItem(3030, 5)
                container:addItem(3032, 5)
                container:addItem(3033, 5)
                container:addItem(6099, 1)
                player:setStorageValue(Storage.Quest.Crandoria.PiratesQuest.Progresso, 2)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou o tesouro solicitado por Dorian.")
            end
        end
        return true
    elseif item:getPosition() == Position(5964, 5546, 6) then
        if player:getStorageValue(Storage.Quest.Crandoria.PiratesQuest.Progresso) >= 1 then
            if item.itemid == 9363 then
                player:teleportTo(toPosition, true)
                item:transform(item.itemid + 1)
            elseif item.itemid == 9364 then
                if Creature.checkCreatureInsideDoor(player, toPosition) then
                    return true
                end
                if item.itemid == 9364 then
                    item:transform(item.itemid - 1)
                    return true
                end
            end
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
            return true
        end
    elseif item:getPosition() == Position(5930, 5516, 7) then
        if player:getStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso) == 14 then
            if player:getFreeCapacity() >= 300 and player:getFreeBackpackSlots() > 1 then
                local container = player:addItem(5926, 1)
                if container then
                    if knight then
                        container:addItem(35589, 1)
                    elseif paladin then
                        container:addItem(35590, 1)
                    elseif sorcerer then
                        container:addItem(35592, 1)
                    elseif druid then
                        container:addItem(35591, 1)
                    elseif monk then
                        container:addItem(50233, 1)
                    end
                    container:addItem(3043, 20)
                    container:addItem(9099, 1)
                    container:addItem(30061, 1)
                    container:addItem(26186, 1)
                    container:addItem(22721, 5)
                    player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 15)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce obteve o artefato junto a outros tesouros. Fale com Tanaro para completar a missao.")
                    return true
                end
            else
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa de 300 de Cap e ao menos 2 espacos para pegar o tesouro.")
                return true
            end
        elseif player:getStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso) < 14 then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado. Fale com Tanaro para realizar essa quest.")
            return true
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The chest is empty.")
            return true
        end
    end
    return true
end

teleport:aid(13188)
teleport:register()