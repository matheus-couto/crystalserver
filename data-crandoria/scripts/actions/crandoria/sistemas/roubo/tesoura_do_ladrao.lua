--[[
    Tesoura do Ladrão
    Use no jogador que deseja roubar para iniciar a tentativa de roubo.
]]

local tesouraDoLadrao = Action()

function tesouraDoLadrao.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not target or not target:isPlayer() then
        player:sendCancelMessage("Voce deve usar a tesoura em outro jogador.")
        return true
    end

    local victim = target

    if victim:getGuid() == player:getGuid() then
        player:sendCancelMessage("Voce nao pode roubar a si mesmo.")
        return true
    end

    if player:getStorageValue(RouboConfig.questStorage) ~= RouboConfig.questStorageValue then
        player:sendCancelMessage("Voce nao tem conhecimento de como usar este item.")
        return true
    end

    local cooldown = player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.RouboCooldown)
    if cooldown and cooldown > os.time() then
        local remaining = cooldown - os.time()
        player:sendCancelMessage(string.format("Voce ja roubou alguem recentemente. Tente novamente em %d hora(s).", math.ceil(remaining / 3600)))
        return true
    end

    if isPlayerAlreadyStealing(player:getGuid()) then
        player:sendCancelMessage("Voce ja esta tentando roubar outro jogador.")
        return true
    end

    if math.abs(player:getLevel() - victim:getLevel()) > RouboConfig.maxLevelDifference then
        player:sendCancelMessage("O jogador deve possuir no maximo 200 niveis de diferenca.")
        return true
    end

    local protection = victim:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Protection)
    if protection and protection > os.time() then
        player:sendCancelMessage("Este jogador esta protegido contra roubos no momento.")
        return true
    end

    if not victim:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
        player:sendCancelMessage("Voce so pode roubar jogadores em batalha.")
        return true
    end

    if victim:getTile():hasFlag(TILESTATE_PROTECTIONZONE) then
        player:sendCancelMessage("Voce nao pode roubar jogadores em Protection Zones.")
        return true
    end

    if isPlayerFightingBoss(victim) then
        player:sendCancelMessage("Voce nao pode roubar um jogador que esta enfrentando um boss.")
        return true
    end

    if RoubosAtivos[victim:getGuid()] then
        player:sendCancelMessage("Este jogador ja esta sendo alvo de outra tentativa de roubo.")
        return true
    end

    -- Inicia a tentativa de roubo
    RoubosAtivos[victim:getGuid()] = {
        thiefGuid = player:getGuid(),
        startTime = os.time(),
    }

    victim:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.RouboTimer, os.time())
    victim:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.ThiefId, player:getGuid())

    player:setSkull(SKULL_WHITE)

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format(
        "Voce comecou a tentar roubar %s. Fique a no maximo %d sqm de distancia por %d minutos.",
        victim:getName(), RouboConfig.maxDistance, RouboConfig.checkDuration / 60
    ))
    victim:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format(
        "%s esta tentando te roubar! Use !roubo %s para se defender.",
        player:getName(), player:getName()
    ))

    addEvent(checkRoubo, RouboConfig.checkInterval, victim:getGuid())

    return true
end

tesouraDoLadrao:id(31327)
tesouraDoLadrao:register()
