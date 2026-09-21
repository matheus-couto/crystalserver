--[[
    SISTEMA DE ROUBO - Crystal Server
    Lib compartilhada: config, tabela de estado em memória e funções auxiliares.
    Deve ser carregada antes das actions/talkactions (data/scripts/lib/ carrega primeiro).
]]

-- Tabela de tentativas de roubo ativas, indexada pelo guid da VÍTIMA.
-- RoubosAtivos[vitimaGuid] = { thiefGuid = <guid do ladrão>, startTime = <os.time()> }
RoubosAtivos = RoubosAtivos or {}

RouboConfig = {

    -- Storage que indica que o jogador completou a quest do roubo.
    -- AJUSTE para a storage real já usada na sua questline do Crandoria.
    questStorage = Storage.Quest.Crandoria.IntoTheShaodws.Progresso,
    questStorageValue = 1,

    stealCooldown = 24 * 60 * 60,      -- 24h: cooldown do ladrão após roubo bem-sucedido
    victimProtection = 12 * 60 * 60,   -- 12h: proteção da vítima após ser roubada com sucesso
    selfProtection = 30 * 60,          -- 30 min: proteção ao se defender com !roubo

    maxLevelDifference = 200,
    checkDuration = 5 * 60,            -- 5 minutos de checagem antes de resolver o roubo
    checkInterval = 15 * 1000,         -- aviso/checagem a cada 15s (ms, usado no addEvent)
    maxDistance = 3,                   -- sqm máx. de distância do ladrão até a vítima

    minGoldPercent = 20,
    maxGoldPercent = 50,

    -- Fórmula de chance de sucesso: NÃO especificada em detalhe no pedido original,
    -- montei um modelo simples baseado na diferença de nível. Ajuste os números à vontade.
    baseChance = 20,         -- % de chance base de sucesso
    levelBonusChance = 0.15, -- % adicional por nível de diferença (ladrão - vítima)
    maxChance = 80,          -- % de chance máxima de sucesso

}

function getRouboChebyshevDistance(pos1, pos2)
    if pos1.z ~= pos2.z then
        return 999
    end
    return math.max(math.abs(pos1.x - pos2.x), math.abs(pos1.y - pos2.y))
end

-- Placeholder: precisa ser adaptado ao sistema de boss do seu Crystal Server
-- (bosstiary, tabela própria de boss, raid ativa, etc.)
function isPlayerFightingBoss(player)
    local target = player:getTarget()
    if not target or not target:isMonster() then
        return false
    end
    return target:getType():isRewardBoss()
end

-- Evita que um mesmo ladrão tenha duas tentativas de roubo simultâneas
function isPlayerAlreadyStealing(thiefGuid)
    for _, data in pairs(RoubosAtivos) do
        if data.thiefGuid == thiefGuid then
            return true
        end
    end
    return false
end

function resetThiefSkull(thiefGuid)
    local thief = Player(thiefGuid)
    if thief then
        thief:setSkull(SKULL_NONE)
    end
end

-- Cancela uma tentativa em andamento (ladrão offline, distância excedida, etc.)
function cancelRoubo(victim, victimMessage)
    local data = RoubosAtivos[victim:getGuid()]
    if not data then
        return
    end

    local thief = Player(data.thiefGuid)
    RoubosAtivos[victim:getGuid()] = nil

    victim:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.RouboTimer, -1)
    victim:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.ThiefId, -1)

    if victimMessage then
        victim:sendTextMessage(MESSAGE_EVENT_ADVANCE, victimMessage)
    end
    if thief then
        thief:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Sua tentativa de roubo foi interrompida.")
    end
end

-- Resolve o roubo ao final dos 5 minutos: calcula chance, aplica sucesso ou falha
function resolveRoubo(victimGuid)
    local data = RoubosAtivos[victimGuid]
    if not data then
        return
    end

    local victim = Player(victimGuid)
    local thief = Player(data.thiefGuid)

    RoubosAtivos[victimGuid] = nil

    if victim then
        victim:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.RouboTimer, -1)
        victim:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.ThiefId, -1)
    end

    if not thief then
        return
    end

    if not victim then
        thief:sendTextMessage(MESSAGE_EVENT_ADVANCE, "A vitima nao esta mais disponivel. O roubo falhou.")
        return
    end

    local chance = RouboConfig.baseChance + ((thief:getLevel() - victim:getLevel()) * RouboConfig.levelBonusChance)
    chance = math.max(0, math.min(RouboConfig.maxChance, chance))

    local roll = math.random(1, 100)
    if roll <= chance then
        local victimGold = victim:getMoney()
        local percent = math.random(RouboConfig.minGoldPercent, RouboConfig.maxGoldPercent)
        local amount = math.floor(victimGold * percent / 100)

        if amount > 0 then
            victim:removeMoney(amount)
            thief:addMoney(amount)
        end

        thief:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.RouboCooldown, os.time() + RouboConfig.stealCooldown)
        victim:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Protection, os.time() + RouboConfig.victimProtection)

        thief:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Voce roubou %d gold coins de %s!", amount, victim:getName()))
        victim:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("%s roubou %d gold coins de voce!", thief:getName(), amount))
    else
        thief:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Sua tentativa de roubo falhou.")
        victim:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("%s tentou te roubar, mas falhou.", thief:getName()))
    end
end

-- Checagem periódica (a cada 15s): valida distância, envia aviso, e resolve ao fim de 5 min
function checkRoubo(victimGuid)
    local data = RoubosAtivos[victimGuid]
    if not data then
        return -- já foi cancelado ou resolvido
    end

    local victim = Player(victimGuid)
    local thief = Player(data.thiefGuid)

    if not victim then
        RoubosAtivos[victimGuid] = nil
        if thief then
            thief:sendTextMessage(MESSAGE_EVENT_ADVANCE, "A vitima parece ter fugido. O roubo falhou.")
        end
        return
    end

    if not thief then
        cancelRoubo(victim, "O ladrao parece ter abandonado a tentativa. Voce esta protegido(a).")
        return
    end

    local elapsed = os.time() - data.startTime
    if elapsed >= RouboConfig.checkDuration then
        resolveRoubo(victimGuid)
        return
    end

    local distance = getRouboChebyshevDistance(thief:getPosition(), victim:getPosition())
    if distance > RouboConfig.maxDistance then
        cancelRoubo(victim, "O ladrao se afastou demais. Voce escapou.")
        thief:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce se afastou demais da vitima. O roubo falhou.")
        return
    end

    local remaining = RouboConfig.checkDuration - elapsed
    victim:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format(
        "%s esta tentando te roubar! Use !roubo %s para se defender. (%d segundos restantes)",
        thief:getName(), thief:getName(), remaining
    ))

    thief:setSkull(SKULL_WHITE)
    
    addEvent(checkRoubo, RouboConfig.checkInterval, victimGuid)
end
