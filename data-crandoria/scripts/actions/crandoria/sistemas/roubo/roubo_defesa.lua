--[[
    !roubo nome do ladrão
    Usado pela vítima para se defender de uma tentativa de roubo em andamento.
]]

local rouboDefesa = TalkAction("!roubo")

function rouboDefesa.onSay(player, words, param)
    if param == "" then
        player:sendCancelMessage("Use: !roubo nome do ladrao")
        return false
    end

    local data = RoubosAtivos[player:getGuid()]
    if not data then
        player:sendCancelMessage("Voce nao esta sendo alvo de nenhuma tentativa de roubo.")
        return false
    end

    local thief = Player(data.thiefGuid)
    if not thief or thief:getName():lower() ~= param:lower() then
        player:sendCancelMessage("Nome incorreto. Tente novamente antes que seja tarde demais!")
        return false
    end

    RoubosAtivos[player:getGuid()] = nil
    player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.RouboTimer, -1)
    player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.ThiefId, -1)
    player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Protection, os.time() + RouboConfig.selfProtection)

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format(
        "Você se defendeu do roubo de %s! Esta protegido(a) por %d minutos.",
        thief:getName(), RouboConfig.selfProtection / 60
    ))
    thief:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format(
        "%s percebeu sua tentativa e se defendeu. O roubo falhou.",
        player:getName()
    ))

    return false
end

rouboDefesa:separator(" ")
rouboDefesa:groupType("normal")
rouboDefesa:register()
