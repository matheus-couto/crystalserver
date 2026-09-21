local passeDeBatalha = Action()

function passeDeBatalha.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local storageTimer = Storage.Quest.Crandoria.PasseDeBatalha.TimerMensal
    local storagePasse = Storage.Quest.Crandoria.PasseDeBatalha.Passe
    local currentTime = os.time()
    local currentDate = os.date("*t", currentTime)
    local lastPassTime = player:getStorageValue(storageTimer)
    local lastPassDate = os.date("*t", lastPassTime)
    
    -- Definir a data limite (último dia do mês às 23:59)
    local endOfMonth = os.time({year = currentDate.year, month = currentDate.month + 1, day = 1, hour = 0, min = 0}) - 1
    
    -- Se o jogador já ativou o passe neste mês, não permitir ativação dupla
    if lastPassTime ~= -1 and lastPassDate.year == currentDate.year and lastPassDate.month == currentDate.month then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja ativou o Passe de Batalha deste mes.")
        return true
    end
    
    -- Ativar o passe e definir o tempo limite
    player:setStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Progresso, 1)
    player:setStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Mes, currentDate.month)
    player:setStorageValue(storagePasse, 1)
    player:setStorageValue(storageTimer, currentTime)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Passe de Batalha ativado! Voce tem ate " .. os.date("%d/%m/%Y %H:%M", endOfMonth) .. " para concluir suas missoes.")
    
    -- Remover o item usado
    item:remove(1)
    return true
end

passeDeBatalha:id(9218)
passeDeBatalha:register()
