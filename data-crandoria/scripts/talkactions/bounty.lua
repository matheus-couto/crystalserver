local huntPlayer = TalkAction("!bounty")

function huntPlayer.onSay(player, words, param)
    -- Verificar se o comando foi usado corretamente
    if param == "" then
        player:sendCancelMessage("Use o comando no formato: !bounty <nome do jogador>, <valor> ou !bounty list.")
        return false
    end

    if param:lower() == "list" then
        local allPlayers = Game.getPlayers()
        local huntedPlayers = {}

        -- Filtrar jogadores com Storage ativo
        for _, p in ipairs(allPlayers) do
            if p:getStorageValue(Storage.Quest.Crandoria.PvpStatus.PvPHuntTimer) > os.time() then
                table.insert(huntedPlayers, {name = p:getName(), bounty = p:getStorageValue(Storage.Quest.Crandoria.PvpStatus.Bounty)})
            end
        end

        -- Verificar se há jogadores caçados online
        if #huntedPlayers == 0 then
            player:sendTextMessage(MESSAGE_STATUS_WARNING, "Nao ha nenhum jogador com premio por sua cabeca no momento.")
            return false
        end

        -- Ordenar lista por valor da recompensa (decrescente)
        table.sort(huntedPlayers, function(a, b) return a.bounty > b.bounty end)

        -- Montar a mensagem da lista
        local msg = ":: Procurado(s) ::\n\n"
        for i, p in ipairs(huntedPlayers) do
            msg = msg .. string.format("%d - %s [Recompensa: %d gold]\n", i, p.name, p.bounty)
        end
        msg = msg .. "\n- CrandoriaOT -"

        -- Exibir a mensagem em uma janela de diálogo
        player:popupFYI(msg)
        return true
    end

    -- Caso contrário, configurar um prêmio pela cabeça de um jogador
    local split = param:split(",")
    if not split[2] then
        player:sendCancelMessage("Use o comando no formato: !bounty <nome do jogador>, <valor>.")
        return false
    end

    local targetName = split[1]:trim()
    local bounty = tonumber(split[2]:trim())

    if not bounty or bounty < 1000000 then
        player:sendCancelMessage("O valor da recompensa deve ser de no minimo 1.000.000 gold coins.")
        return false
    end

    local target = Player(targetName)
    if not target then
        player:sendCancelMessage("O jogador '" .. targetName .. "' nao esta online.")
        return false
    end

    -- Verificar saldo no banco
    if player:getBankBalance() < bounty then
        player:sendCancelMessage("Voce nao possui dinheiro suficiente no banco para oferecer essa recompensa.")
        return false
    end

    if target:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) ~= 1 then
        player:sendCancelMessage("Apenas habitantes de Viridia podem oferecer recompensas por outros habitantes do local.")
        return false
    end

    -- Configurar Storage e deduzir valor do banco
    player:removeMoney(bounty)
    target:setStorageValue(Storage.Quest.Crandoria.PvpStatus.PvPHuntTimer, os.time() + 3 * 24 * 60 * 60) -- 3 dias
    target:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Bounty, bounty)

    -- Mensagens de confirmação
    player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce colocou uma recompensa de " .. bounty .. " gold pela cabeca de " .. target:getName() .. ".")
    target:sendTextMessage(MESSAGE_STATUS_WARNING, "Voce agora e alvo de cacada com uma recompensa de " .. bounty .. " gold!")
    target:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
    return true
end

huntPlayer:separator(" ")
huntPlayer:groupType("normal")
huntPlayer:register()