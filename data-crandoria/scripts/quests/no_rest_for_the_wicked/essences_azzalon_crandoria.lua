local essenceAzzalon = Action()

function essenceAzzalon.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    if not player then
        return true
    end

    local storageQuest = player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Questlog)
    local storageEssences = player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Essences)

    local playerCount = player:getItemCount(49909)
    local maxEssences = 51200 - playerCount
    local essenceNumber = math.min(playerCount, maxEssences)
    local newValue = storageEssences + essenceNumber

    if storageQuest < 2 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao sabe o que fazer com isso.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end

    if playerCount < 1 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "As essencias devem estar no inventario para que sejam absorvidas.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    else
        if storageEssences >= 51200 then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja atingiu o valor maximo de essencias absorvidas.")
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            return true
        else
            player:removeItem(49909, essenceNumber)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce absorveu as essencias, totalizando "..newValue.." essencias absorvidas.")
            player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Essences, newValue)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
            return true
        end
    end

end

essenceAzzalon:id(49909)
essenceAzzalon:register()