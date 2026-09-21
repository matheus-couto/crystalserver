local dailyBet = GlobalEvent("DailyBetSorteio")

function dailyBet.onTime(interval)
    local now = os.date("*t")
    local today = now.day

    -- Verifica se já foi sorteado hoje
    local lastDrawDay = Game.getStorageValue(GlobalStorage.Crandoria.Apostas.Day)
    if lastDrawDay == today then
        return true
    end

    local totalValue = Game.getStorageValue(GlobalStorage.Crandoria.Apostas.Value)
    if totalValue < 1 then
        Game.setStorageValue(GlobalStorage.Crandoria.Apostas.Day, today)
        return true
    end

    local participants = {}

    for _, player in ipairs(Game.getPlayers()) do
        if player:getStorageValue(Storage.Quest.Crandoria.Aposta.Active) == 1
        and player:getStorageValue(Storage.Quest.Crandoria.Aposta.Day) == today then
            table.insert(participants, player)
        end
    end

    if #participants == 0 then
        Game.setStorageValue(GlobalStorage.Crandoria.Apostas.Day, today)
        return true
    end

    -- Se só 1 jogador apostou → devolve as coins
    if #participants == 1 then
        local winner = participants[1]
        winner:addTransferableCoins(25)
        winner:sendTextMessage(MESSAGE_EVENT_ADVANCE, 
            "Voce foi o unico participante da aposta diaria. Suas 25 Tibia Coins foram devolvidas.")
    else
        -- Sorteia vencedor
        local randomIndex = math.random(1, #participants)
        local winner = participants[randomIndex]

        local prize = math.floor(totalValue * 0.9)

        winner:addTransferableCoins(prize)
        winner:sendTextMessage(MESSAGE_EVENT_ADVANCE, 
            "Parabens! Voce venceu a aposta diaria e ganhou ".. prize .." Tibia Coins!")

        Game.broadcastMessage(
            winner:getName() .. " venceu a aposta diaria e levou " .. prize .. " Tibia Coins!",
            MESSAGE_STATUS_WARNING
        )
    end

    -- Limpa storages dos jogadores
    for _, player in ipairs(Game.getPlayers()) do
        player:setStorageValue(Storage.Quest.Crandoria.Aposta.Active, 0)
    end

    -- Marca que já houve sorteio hoje
    Game.setStorageValue(GlobalStorage.Crandoria.Apostas.Day, today)
    Game.setStorageValue(GlobalStorage.Crandoria.Apostas.Value, 0)

    return true
end

dailyBet:time("20:00:00")
dailyBet:register()