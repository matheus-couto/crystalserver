local chestEventos = Action()

function chestEventos.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    local storageBossGlobal = player:getStorageValue(Storage.Quest.Crandoria.EventoProgramado.BossGlobal)
    local storageReward = player:getStorageValue(Storage.Quest.Crandoria.EventoProgramado.RewardArtefato)
    local storageRewardDisputa = player:getStorageValue(Storage.Crandoria.EventoProgramago.RewardDisputa)

    local day = os.date("%A")

    if day == "Saturday" then
        if storageBossGlobal == 1 then
            if player:getFreeBackpackSlots() >= 1 and player:getFreeCapacity() >= 10000 then
                local bag = player:addItem(8861, 1)
                if bag then
                    bag:addItem(3043, 10)
                    bag:addItem(637, 1)
                    player:addPreyCards(3)
                    player:sendTextMessage("Voce obteve suas recompensas por ter participado da luta contra Hellsin.")
                end
                player:setStorageValue(Storage.Quest.Crandoria.EventoProgramado.BossGlobal, 0)
            else
                player:sendTextMessage("Voce precisa de 1 espaco livre no inventario e pelo menos 100 de Capacidade.")
            end
        elseif storageBossGlobal == 2 then
            if player:getFreeBackpackSlots() >= 1 and player:getFreeCapacity() >= 10000 then
                local bag = player:addItem(8861, 1)
                if bag then
                    bag:addItem(3043, 25)
                    bag:addItem(22706, 1)
                    bag:addItem(11372, 1)
                    player:addPreyCards(5)
                    player:sendTextMessage("Voce obteve suas recompensas por ter ajudado a derrotar Hellsin. Parabens!")
                end
                player:setStorageValue(Storage.Quest.Crandoria.EventoProgramado.BossGlobal, 0)
            else
                player:sendTextMessage("Voce precisa de 1 espaco livre no inventario e pelo menos 100 de Capacidade.")
            end
        else
            player:sendTextMessage("Voce nao tem recompensas de eventos para obter.")
        end
        return true
    elseif day == "Wednesday" then
        if storageReward == 1 then
            if player:getFreeBackpackSlots() >= 1 and player:getFreeCapacity() >= 20000 then
                local bag = player:addItem(8861, 1)
                if bag then
                    bag:addItem(637, 1)
                    bag:addItem(637, 1)
                    bag:addItem(9099, 1)
                    bag:addItem(20138, 1)
                end
                player:setStorageValue(Storage.Quest.Crandoria.EventoProgramado.RewardArtefato, 0)
                player:sendTextMessage("Voce obteve suas recompensas por participar do evento Artefato Perdido.")
            else
                player:sendTextMessage("Voce precisa de 1 espaco livre no inventario e pelo menos 200 de Capacidade.")
            end
        elseif storageReward == 2 then
            if player:getFreeBackpackSlots() >= 1 and player:getFreeCapacity() >= 20000 then
                local bag = player:addItem(8860, 1)
                if bag then
                    bag:addItem(637, 1)
                    bag:addItem(637, 1)
                    bag:addItem(22706, 1)
                    bag:addItem(9099, 1)
                    bag:addItem(20138, 1)
                    bag:addItem(22771, 1)
                    bag:addItem(26186, 1)
                    bag:addItem(11372, 1)
                end
                player:setStorageValue(Storage.Quest.Crandoria.EventoProgramado.RewardArtefato, 0)
                player:sendTextMessage("Voce obteve suas recompensas por vencer o evento Artefato Perdido. Parabens!")
            else
                player:sendTextMessage("Voce precisa de 1 espaco livre no inventario e pelo menos 200 de Capacidade.")
            end
        end
    elseif day == "Sunday" then
        if storageRewardDisputa == 1 then
            if player:getFreeBackpackSlots() >= 1 and player:getFreeCapacity() >= 10000 then
                player:addPreyCards(3)
                local bag = player:addItem(8861, 1)
                if bag then
                    bag:addItem(22721, 10)
                    bag:addItem(22516, 10)
                end
                player:setStorageValue(Storage.Crandoria.EventoProgramago.RewardDisputa, 0)
                player:sendTextMessage("Voce recebeu 10 Gold Tokens, 10 Silver Tokens e 3 Prey Cards por ter participado do evento.")
            else
                player:sendTextMessage("Voce precisa de 1 espaco livre no inventario e pelo menos 100 de Capacidade.")
            end
        elseif storageRewardDisputa == 2 then
            if player:getFreeBackpackSlots() >= 1 and player:getFreeCapacity() >= 20000 then
                player:addPreyCards(3)
                local bag = player:addItem(8861, 1)
                if bag then
                    bag:addItem(22721, 10)
                    bag:addItem(22516, 10)
                end
                player:setStorageValue(Storage.Quest.Crandoria.DonateRewards.PalacioAccesso, os.time() + 7 * 24 * 60 * 60)
                player:setStorageValue(Storage.Crandoria.EventoProgramago.RewardDisputa, 0)
                player:sendTextMessage("Voce recebeu 10 Gold Tokens, 10 Silver Tokens e 3 Prey Cards por ter participado do evento, alem de 7 dias de acesso ao Palacio dos Nobres por ter vencido.")
            else
                player:sendTextMessage("Voce precisa de 1 espaco livre no inventario e pelo menos 100 de Capacidade.")
            end
        end
    end

    return true
end

chestEventos:uid(14513)
chestEventos:register()