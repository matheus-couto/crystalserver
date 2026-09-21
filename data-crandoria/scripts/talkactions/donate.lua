local donate = TalkAction("!donate")

function donate.onSay(player, words, param)

    local msgDefault =
        "Utilize o comando no formato:\n\n" ..
        "!donate <valor>"

    if param == "" then
        player:popupFYI(msgDefault)
        -- player:sendCancelMessage("Use o comando no formato: !donate <valor>.")
        return false
    end

    local msgValorreal =
        "Por favor, informe um valor valido para doacao."

    local value = tonumber(param:trim())

    if not value or value <= 0 then
        player:popupFYI(msgValorreal)
        -- player:sendCancelMessage("Por favor, informe um valor valido para doacao.")
        return false
    end

    local msgValor5 =
        "Valor minimo para doacao: 5 reais."

    if value < 5 then
        player:popupFYI(msgValor5)
        -- player:sendCancelMessage("O valor minimo para doacao e de 5 reais.")
        return false
    end

    -- Insert into database
    local query = string.format("INSERT INTO `donates` (`player_id`, `player`, `valor`) VALUES (%d, %s, %d)",
        player:getGuid(),
        db.escapeString(player:getName()),
        value
    )

    local title = "CrandoriaOT - Doacoes"
    local messageSuccess = [[Caro jogador,
Doando ao servidor voce recebera uma bonificacao em forma de Tibia Coins que poderao ser usadas para comprar recursos na Store. Ao doar voce concorda que o valor nao retornara a voce de nenhuma forma apos o recebimento das Tibia Coins. Voce concorda e deseja continuar?

]]
    
    player:sendRulesModalWindow(title, messageSuccess, function(player, agreed)
        if agreed then
            local success = db.query(query)
                    if success then
                        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Obrigado! Sua solicitacao de doacao de %d foi recebida. Voce vai receber um label com o link de pagamento no seu inventario.", value))
                        print(string.format("Donation Registered: Player: %s, Value: %d", player:getName(), value))
                    else
                        player:sendCancelMessage("Ocorreu um erro ao registrar sua doacao. Por favor, contate a administracao.")
                        print(string.format("Donation Error: Failed to insert for Player: %s", player:getName()))
                    end
            return true
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Doacao cancelada.")
            return true
        end
    end)
    
    -- local success = db.query(query)

    -- if success then
    --     player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Obrigado! Sua solicitacao de doacao de %d foi recebida. Voce vai receber um label com o link de pagamento no seu inventario.", value))
    --     print(string.format("Donation Registered: Player: %s, Value: %d", player:getName(), value))
    -- else
    --     player:sendCancelMessage("Ocorreu um erro ao registrar sua doacao. Por favor, contate a administracao.")
    --     print(string.format("Donation Error: Failed to insert for Player: %s", player:getName()))
    -- end

    return true
end

donate:separator(" ")
donate:groupType("normal")
donate:register()