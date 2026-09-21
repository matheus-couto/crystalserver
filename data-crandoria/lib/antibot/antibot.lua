ANTIBOT = {
    prefix = "[AntiAfk] ",

    possibleMonsters = {
        { looktype = 276, name = "cat" },
        { looktype = 34, name = "dragon"},
        { looktype = 21, name = "rat"},
        { looktype = 32, name = "dog"},
        -- { looktype = 27, name = "wolf"},
        -- { looktype = 30, name = "spider"},
        { looktype = 15, name = "troll" },
        { looktype = 60, name = "pig" },
        { looktype = 122, name = "bat"},
        { looktype = 28, name = "snake"},
    },

    possibleMonsters2 = {
        { looktype = 19, name = "slime" },
        { looktype = 44, name = "wasp"},
        { looktype = 16, name = "bear"},
        { looktype = 9, name = "necromancer"},
        { looktype = 17, name = "bonelord"},
        { looktype = 219, name = "tarantula"},
        { looktype = 83, name = "scarab" },
        { looktype = 65, name = "mummy" },
    },

    possibleMonsters3 = {
        { looktype = 39, name = "dragon lord" },
        { looktype = 55, name = "behemoth"},
        { looktype = 121, name = "hydra"},
        { looktype = 78, name = "banshee"},
        { looktype = 291, name = "wyrm"},
        { looktype = 236, name = "destroyer"},
        { looktype = 73, name = "hero" },
        { looktype = 330, name = "medusa" },
    },

    possibleMonsters4 = {
        { looktype = 382, name = "draptor" },
        { looktype = 19, name = "slime"},
        { looktype = 585, name = "silencer"},
        { looktype = 300, name = "grim reaper"},
        { looktype = 240, name = "hellhound"},
        { looktype = 231, name = "undead dragon"},
        { looktype = 854, name = "vexclaw" },
        { looktype = 35, name = "demon" },
    },

    fastAnswer = {
        { mensagem = "Ora, temos um genio da matematica aqui, tem que certeza que nao e um robo?"},
        { mensagem = "Pega leve no utani hur, vai acabar enfartando amigo."},
        { mensagem = "Respondeu rapido hein!? rápido ate demais"},
        { mensagem = "Pode substituir o chatGPT com esse raciocinio rapido."},
        { mensagem = "Esse fez curso de matematica no SENAI!"},
        { mensagem = "Stephen Hawkin invejava sua inteligencia!"}
    },

    -- NOVO: parâmetros da detecção estatística de resposta automática.
    -- Nada aqui bane sozinho — só acumula suspeita e alerta a staff (canal 13)
    -- quando os limites são atingidos, pra revisão manual.
    suspicion = {
        fastAnswerThreshold = 3,  -- segundos: responder mais rápido que isso é suspeito
        fastStreakLimit = 5,      -- quantas respostas suspeitas seguidas pra contar 1 ponto de suspeita
        alertThreshold = 3,       -- pontos de suspeita acumulados pra alertar a staff
    },

    playerQuestion = {},
    messages = {
        time = "Voce possui %s para responder a pergunta.",
        chat = "Esse chat so pode ser usado durante a verificacao.",
        howAnswer = "Voce deve responder somente a resposta, por exemplo: Qual o dia de hoje? Resposta: %d",
        correctAnswer = "Voce acertou a pergunta e recebeu 15 minutos de bonus de Xp.",
        incorrectAnswer = "Voce errou a resposta, voce ainda possui %d tentativas.",
        logout = "Voce nao pode deslogar enquanto hover uma verificacao ativa.",
    },
    punishment = {
        try = {
            max = 3,
            reason = "Quantidade excessiva de tentativas.",
            players = {},
        },
        time = {
            maxTime = 180, -- In seconds
            reason = "Nao respondeu a pergunta dentro do tempo estipulado.",
            players = {},
        },
    },
    verification = { 46, 88 }, -- in minutes
    -- verification = { 1, 2 }, -- in minutes
}

-------------- FISHING -------------

local area1 = {
    fromPosition = {x = 5056, y = 5024, z = 7},
    toPosition = {x = 5067, y = 5027, z = 7}
}

local area2 = {
    fromPosition = {x = 5053, y = 5027, z = 7},
    toPosition = {x = 5067, y = 5037, z = 7}
}

local area3 = {
    fromPosition = {x = 4302, y = 4391, z = 7},
    toPosition = {x = 4413, y = 4415, z = 7}
}

local area4 = {
    fromPosition = {x = 4302, y = 4391, z = 6},
    toPosition = {x = 4413, y = 4415, z = 6}
}

local function isInArea(player, area)
    local playerPos = player:getPosition()
    return playerPos.x >= area.fromPosition.x and playerPos.x <= area.toPosition.x
        and playerPos.y >= area.fromPosition.y and playerPos.y <= area.toPosition.y
        and playerPos.z == area.fromPosition.z
end

local function removeSummon(player)
    local summons = player:getSummons()
    for _, summon in ipairs(summons) do
        if summon:getName() == "Anti Afk Orb Anti Noob" or summon:getName() == "" then
            summon:remove()
            player:setStorageValue(Storage.Quest.Crandoria.Antibot.LookType, 0)
        end
    end
end

-------------- FISHING -------------

function ANTIBOT:addTry(playerId)
    local player = Player(playerId)

    if not player then
        return false
    end

    -- CORRIGIDO/SIMPLIFICADO: as duas checagens de "level < 100" com citizen < 1
    -- e citizen >= 1 juntas cobrem TODOS os valores possíveis de citizen — ou
    -- seja, sempre eram equivalentes a só checar o nível. Comportamento idêntico.
    if player:getLevel() < 100 then
        return false
    end

    local tile = Tile(player:getPosition())
    if tile and (tile:getItemById(10145) or tile:getItemById(10146)) then
        ANTIBOT:reset(player:getId())
        return false
    end

    local timeNow = os.time()
    local target = player:getTarget()

    local timeRandom = math.random(38, 75)
    if (target and target:getName() == "Training Monk") then
        ANTIBOT:reset(player:getId())
        player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, timeNow + timeRandom * 60)
        return false
    end

    if not ANTIBOT.punishment.try.players[playerId] then
        ANTIBOT.punishment.try.players[playerId] = 0
    end

    ANTIBOT.punishment.try.players[playerId] = ANTIBOT.punishment.try.players[playerId] + 1

    if ANTIBOT.punishment.try.players[playerId] and ANTIBOT.punishment.try.players[playerId] >= ANTIBOT.punishment.try.max then
        sendChannelMessage(13, TALKTYPE_CHANNEL_O, ANTIBOT.prefix .. ANTIBOT.punishment.try.reason)
        ANTIBOT:addPunishment(playerId)
    end
end

ANTIBOT.punishment.time.isScheduled = ANTIBOT.punishment.time.isScheduled or {}

function ANTIBOT:time(playerId)
    local player = Player(playerId)
    if not player then
        ANTIBOT:reset(playerId)
        return false
    end

    local target = player:getTarget()
    if Tile(player:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) or Tile(player:getPosition()):hasFlag(TILESTATE_PVPZONE) or (target and target:getName() == "Training Monk") then
        ANTIBOT:reset(playerId)
        removeSummon(player)
        return false
    end

        ---------- FISHING ---------

    if isInArea(player, area1) or isInArea(player, area2) then
        player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 48 * 60)
        removeSummon(player)
        return false
    end

        ---------- FISHING ---------
    if player:getIp() == 0 then
        ANTIBOT:reset(playerId)
        removeSummon(player)
        player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 48 * 60)
        return false
    end

    if player:getLevel() < 100 then
        return false
    end

    playerId = player:getId()

    if player:getStorageValue(Storage.Quest.Crandoria.Antibot.Timer) < os.time() then
        if not ANTIBOT.punishment.time.players[playerId] then
            ANTIBOT.punishment.time.players[playerId] = 0
            ANTIBOT:sendQuestions(playerId)
        end
    end

    if ANTIBOT.punishment.time.players[playerId] and ANTIBOT.punishment.time.players[playerId] >= ANTIBOT.punishment.time.maxTime then
        ANTIBOT:addPunishment(playerId)
    else
        if not ANTIBOT.punishment.time.isScheduled[playerId] then
            ANTIBOT.punishment.time.isScheduled[playerId] = true
            addEvent(function()
                local currentPlayer = Player(playerId)
                if not currentPlayer then
                    ANTIBOT.punishment.time.isScheduled[playerId] = false
                    return
                end

                if ANTIBOT.punishment.time.players[playerId] and ANTIBOT.punishment.time.players[playerId] >= 0 and ANTIBOT.punishment.time.players[playerId] < ANTIBOT.punishment.time.maxTime then
                    ANTIBOT.punishment.time.players[playerId] = ANTIBOT.punishment.time.players[playerId] + 1
                    currentPlayer:sendCancelMessage(ANTIBOT.prefix .. ANTIBOT.messages.time:format(string.diff(ANTIBOT.punishment.time.maxTime - ANTIBOT.punishment.time.players[playerId], true)))
                    currentPlayer:say("AFK", TALKTYPE_MONSTER_SAY)
                    local hasAntiAfkOrb = false
                    local summons = currentPlayer:getSummons()
                    for _, summon in ipairs(summons) do
                        if summon:getName() == "Anti Afk Orb Anti Noob" or summon:getName() == "" then
                            hasAntiAfkOrb = true
                            break
                        end
                    end

                    if not hasAntiAfkOrb then
                        ANTIBOT:reset(playerId)
                    end
                    ANTIBOT.punishment.time.isScheduled[playerId] = false
                    ANTIBOT:time(playerId)
                else
                    ANTIBOT.punishment.time.isScheduled[playerId] = false
                end
            end, 1000)
        end
    end

    if ANTIBOT.punishment.time.players[playerId] and ANTIBOT.punishment.time.players[playerId] >= ANTIBOT.punishment.time.maxTime then
        ANTIBOT:addPunishment(playerId)
    end
end

function ANTIBOT:sendQuestions(playerId)
    local player = Player(playerId)

    if not player then
        return false
    end

    if player:getLevel() < 100 then
        ANTIBOT:reset(playerId)
        return false
    end

    -- CORRIGIDO: timeNow/timeRandom não existiam nesse escopo antes (só existiam
    -- dentro de addTry). Sem "local", isso resolvia pra variável GLOBAL, quase
    -- certamente nil, causando erro em runtime ("attempt to perform arithmetic
    -- on a nil value") pra qualquer jogador pego nesses dois "if" abaixo.
    local timeNow = os.time()
    local timeRandom = math.random(38, 75)

        ---------- FISHING E ARAM ---------

    if isInArea(player, area1) or isInArea(player, area2) or isInArea(player, area3) or isInArea(player, area4) then
        player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, timeNow + timeRandom * 60)
        ANTIBOT:reset(playerId)
        return false
    end

        ---------- FISHING ---------
    if player:getIp() == 0 then
        ANTIBOT:reset(playerId)
        player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, timeNow + timeRandom * 60)
        return false
    end

    if player:getStorageValue(Storage.Quest.Crandoria.Antibot.Timer) >= os.time() then
        ANTIBOT:reset(playerId)
        return false
    end

    local tile = Tile(player:getPosition())
    if tile and (tile:getItemById(10145) or tile:getItemById(10146)) then
        ANTIBOT:reset(playerId)
        return false
    end

    local target = player:getTarget()
    if Tile(player:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) or Tile(player:getPosition()):hasFlag(TILESTATE_PVPZONE) or (target and target:getName() == "Training Monk") then
        ANTIBOT:reset(playerId)
        return false
    end
    if target then
        if target:isPlayer() then
            ANTIBOT:reset(playerId)
            player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 5 * 60)
            return false
        else
            if target:getType() then
                if target:getType():isRewardBoss() then
                    ANTIBOT:reset(playerId)
                    player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 5 * 60)
                    return false
                end
            end
        end
    end

    if not player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
        ANTIBOT:reset(playerId)
        return false
    end

    playerId = player:getId()

    local monstroAleatorio = ANTIBOT.possibleMonsters[math.random(1, #ANTIBOT.possibleMonsters)]
    if player:getLevel() >= 500 and player:getLevel() < 750 then
        monstroAleatorio = ANTIBOT.possibleMonsters2[math.random(1, #ANTIBOT.possibleMonsters2)]
    elseif player:getLevel() >= 750 and player:getLevel() < 1000 then
        monstroAleatorio = ANTIBOT.possibleMonsters3[math.random(1, #ANTIBOT.possibleMonsters3)]
    elseif player:getLevel() >= 1000 then
        monstroAleatorio = ANTIBOT.possibleMonsters4[math.random(1, #ANTIBOT.possibleMonsters4)]
    end

    ANTIBOT.playerQuestion[playerId] = { question = "Digite o nome da criatura na qual o seu Afk Orb se transformou e receba 15 minutos de bonus de Xp.", staticAnswer = true, answer = monstroAleatorio.name }

    -- NOVO: marca o instante em que a pergunta foi enviada, pra medir o tempo
    -- de resposta em ANTIBOT:evaluateResponse (chamado pelo script que processa
    -- a resposta do jogador).
    player:setStorageValue(Storage.Quest.Crandoria.Antibot.QuestionSentAt, os.time())

    local position = player:getPosition()
    local summon = Game.createMonster("Anti Afk Orb Anti Noob", position, true, true)
    if summon then
        summon:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        summon:changeSpeed(math.max(player:getSpeed() + ((player:getSpeed() / 10) + 20), 0))
        summon:setMaster(player)
        summon:setMaxHealth((player:getLevel() * 70) + 5000)
        summon:setHealth((player:getLevel() * 70) + 5000)
        summon:setOutfit({ lookType = monstroAleatorio.looktype })
        player:setStorageValue(Storage.Quest.Crandoria.Antibot.LookType, monstroAleatorio.looktype)
        ANTIBOT:startLookTypeRestoreLoop(playerId)
    end

    player:say("AFK", TALKTYPE_MONSTER_SAY)
    player:openChannel(12)
    player:sendChannelMessage(player, ANTIBOT.prefix .. ANTIBOT.messages.howAnswer:format(os.date("%d")), TALKTYPE_CHANNEL_O, 12)
    player:sendChannelMessage(player, ANTIBOT.prefix .. ANTIBOT.playerQuestion[playerId].question, TALKTYPE_CHANNEL_O, 12)
end

-- NOVO: chame esta função a partir do script que processa a resposta do
-- jogador (onSay/talkaction — não incluso no que você me mandou até agora),
-- logo depois de determinar se a resposta estava correta ou não:
--
--     ANTIBOT:evaluateResponse(player:getId(), respostaEstavaCorreta)
--
-- Isso NÃO bane ninguém sozinho, e NÃO avisa o jogador de forma alguma (a
-- detecção é silenciosa de propósito). Ele só acumula pontos de suspeita
-- quando o jogador acerta respostas rápido demais pra ter lido e digitado, e
-- alerta a staff no canal 13 quando o limite é atingido, pra revisão manual.
function ANTIBOT:evaluateResponse(playerId, wasCorrect)
    local player = Player(playerId)
    if not player then
        return false
    end

    local sentAt = player:getStorageValue(Storage.Quest.Crandoria.Antibot.QuestionSentAt)
    local elapsed = nil
    if sentAt and sentAt > 0 then
        elapsed = os.time() - sentAt
    end

    local totalAnswered = math.max(0, player:getStorageValue(Storage.Quest.Crandoria.Antibot.TotalAnswered))
    local correctAnswered = math.max(0, player:getStorageValue(Storage.Quest.Crandoria.Antibot.CorrectAnswered))
    local fastStreak = math.max(0, player:getStorageValue(Storage.Quest.Crandoria.Antibot.FastAnswerStreak))
    local suspicionScore = math.max(0, player:getStorageValue(Storage.Quest.Crandoria.Antibot.SuspicionScore))

    totalAnswered = totalAnswered + 1
    if wasCorrect then
        correctAnswered = correctAnswered + 1
    end

    local isSuspiciouslyFast = wasCorrect and elapsed ~= nil and elapsed <= ANTIBOT.suspicion.fastAnswerThreshold

    if isSuspiciouslyFast then
        fastStreak = fastStreak + 1
    else
        fastStreak = 0
    end

    if fastStreak >= ANTIBOT.suspicion.fastStreakLimit then
        suspicionScore = suspicionScore + 1
        fastStreak = 0 -- reinicia a sequência após contabilizar 1 ponto de suspeita

        if suspicionScore >= ANTIBOT.suspicion.alertThreshold then
            sendChannelMessage(13, TALKTYPE_CHANNEL_O, ANTIBOT.prefix .. string.format(
                "%s acumulou %d pontos de suspeita de automação (respostas rápidas demais repetidas). Revisão manual recomendada. Historico: %d/%d corretas.",
                player:getName(), suspicionScore, correctAnswered, totalAnswered
            ))
        end
    end

    player:setStorageValue(Storage.Quest.Crandoria.Antibot.TotalAnswered, totalAnswered)
    player:setStorageValue(Storage.Quest.Crandoria.Antibot.CorrectAnswered, correctAnswered)
    player:setStorageValue(Storage.Quest.Crandoria.Antibot.FastAnswerStreak, fastStreak)
    player:setStorageValue(Storage.Quest.Crandoria.Antibot.SuspicionScore, suspicionScore)
    player:setStorageValue(Storage.Quest.Crandoria.Antibot.QuestionSentAt, -1)

    return true
end

function ANTIBOT:startLookTypeRestoreLoop(playerId)
    local player = Player(playerId)
    if not player then
        return false
    end

    local playerSummons = player:getSummons()
    for _, summon in ipairs(playerSummons) do
        if summon:getName() == "Anti Afk Orb Anti Noob" or summon:getName() == "" then
            local lookTypeMonster = player:getStorageValue(Storage.Quest.Crandoria.Antibot.LookType)
            if lookTypeMonster and lookTypeMonster > 0 then
                addEvent(function()
                    local currentPlayer = Player(playerId)
                    if not currentPlayer then
                        return
                    end

                    local currentSummons = currentPlayer:getSummons()
                    for _, currentSummon in ipairs(currentSummons) do
                        if currentSummon:getName() == "Anti Afk Orb Anti Noob" or currentSummon:getName() == "" then
                            currentSummon:setOutfit({ lookType = lookTypeMonster })
                            ANTIBOT:startLookTypeRestoreLoop(playerId) -- Reagendar com playerId
                            break
                        end
                    end
                end, 5000)
            end
            break
        end
    end
end

function ANTIBOT:reset(playerId)
    ANTIBOT.punishment.try.players[playerId] = nil
    ANTIBOT.punishment.time.players[playerId] = nil
    ANTIBOT.playerQuestion[playerId] = nil
end

function ANTIBOT:addPunishment(playerId)
    local player = Player(playerId)
    if not player then
        return false
    end

    playerId = player:getId()

    local accountId = getAccountNumberByPlayerName(player:getName())
    if accountId == 0 then
        return false
    end

    local timeNow = os.time()
    removeSummon(player)

    local timeRandom = math.random(38, 75)

    ANTIBOT:reset(playerId)
    player:getPosition():sendMagicEffect(CONST_ME_POFF)
    player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, timeNow + timeRandom * 60)
end

--============================ ANTERIOR A VERSAO 15 ====================================

-- ANTIBOT = {
--     prefix = "[AntiAfk] ",
--     questions = {
--         { question = "Qual o resultado de:  %d + %d  ?  ", staticAnswer = true, answer = "" },
--     },
--     questionModelAdicao = {
--         { titulo = "Qual o resultado da adicao entre %d vezes 1 e %d?"},
--         { titulo = "Quanto e %d somado com %d e multiplicado por 1?"},
--         { titulo = "Qual e o total quando voce adiciona %d e %d?"},
--         { titulo = "Me diga a soma de %d e %d, por favor."},
--         { titulo = "Quanto da a soma de %d mais %d?"},
--         { titulo = "Qual e a totalizacao de %d e %d?"},
--         { titulo = "Se no lugar de multiplicar voce somar %d com %d, quanto voce obtem?"},
--         { titulo = "Voce pode me dizer a soma de %d e %d? Diga quantas vezes quiser."},
--         { titulo = "Quanto e %d acrescido de %d?"},
--         { titulo = "Diga uma ou duas vezes: Qual e o resultado da adicao entre %d e %d?"},
--     },
--     possibleMonsters = {
--         { looktype = 276, name = "cat" },
--         { looktype = 34, name = "dragon"},
--         { looktype = 21, name = "rat"},
--         { looktype = 32, name = "dog"},
--         -- { looktype = 27, name = "wolf"},
--         -- { looktype = 30, name = "spider"},
--         { looktype = 15, name = "troll" },
--         { looktype = 60, name = "pig" },
--         { looktype = 122, name = "bat"},
--         { looktype = 28, name = "snake"},
--     },

--     possibleMonsters2 = {
--         { looktype = 19, name = "slime" },
--         { looktype = 44, name = "wasp"},
--         { looktype = 16, name = "bear"},
--         { looktype = 9, name = "necromancer"},
--         { looktype = 17, name = "bonelord"},
--         { looktype = 219, name = "tarantula"},
--         { looktype = 83, name = "scarab" },
--         { looktype = 65, name = "mummy" },
--     },

--     possibleMonsters3 = {
--         { looktype = 39, name = "dragon lord" },
--         { looktype = 55, name = "behemoth"},
--         { looktype = 121, name = "hydra"},
--         { looktype = 78, name = "banshee"},
--         { looktype = 291, name = "wyrm"},
--         { looktype = 236, name = "destroyer"},
--         { looktype = 73, name = "hero" },
--         { looktype = 330, name = "medusa" },
--     },

--     possibleMonsters4 = {
--         { looktype = 382, name = "draptor" },
--         { looktype = 19, name = "slime"},
--         { looktype = 585, name = "silencer"},
--         { looktype = 300, name = "grim reaper"},
--         { looktype = 240, name = "hellhound"},
--         { looktype = 231, name = "undead dragon"},
--         { looktype = 854, name = "vexclaw" },
--         { looktype = 35, name = "demon" },
--     },


--     -- questionModelMultiplicacao = {
--     --     { titulo = "Qual e o resultado da subtracao de %d por %d?"},
--     --     { titulo = "Quanto e %d menos %d?"},
--     --     { titulo = "Qual e a diferença entre %d e %d?"},
--     --     { titulo = "Me diga o resultado de %d menos %d, por favor."},
--     --     { titulo = "Em qual valor resulta %d menos o numero %d?"},
--     --     { titulo = "Qual e o resultado quando voce subtrai de %d o valor %d?"},
--     --     { titulo = "Qual valor e o resultado de %d subtraindo %d?"},
--     --     { titulo = "Se voce tentar subtrair de %d o numero %d, qual sera o resultado?"},
--     --     { titulo = "Quanto e %d diminuido por %d?"},
--     --     { titulo = "Quanto seria %d menos o valor %d?"},
--     --     { titulo = "Se voce ganhou %d pontos de experiencia e ao morrer perdeu %d pontos de experiencia, qual o valor final positivo ou negativo de experiencia?" }
--     -- },

--     questionModelMultiplicacao = {
--         { titulo = "Qual e o resultado da multiplicacao de %d por %d mais 0?"},
--         { titulo = "Mostre que voce pode ser mais inteligente: Quanto e %d vezes %d?"},
--         { titulo = "Quanto seria %d vezes %d?"},
--         { titulo = "Se sua guild tem %d players e cada um tem %d gold tokens, qual o total de gold tokens da sua guild?"},
--         { titulo = "Se um monstro fornece %d pontos de experiencia, quanto de experiencia voce recebera se matar %d monstros?"},
--         { titulo = "Se em %d dias voce matou %d monstros por dia, quantos monstros voce matou somando todos os dias?"},
--         { titulo = "Qual seria o resultado de %d vezes o numero %d?"},
--         { titulo = "Se voce usa %d potions por minuto em uma hunt, quantas potions voce usa durante %d minutos? O resultado sera a soma de todas as potions usadas."},
--         { titulo = "Quanto e %d multiplicado por %d?"},
--         { titulo = "Qual o valor do resultado de %d multiplicado pelo numero %d? Responda o valor exato, nem mais, nem menos!"},
--         { titulo = "Se no lugar de somar voce multiplicar %d pelo numero inteiro %d qual sera o resultado final?" }
--     },

--     operation =  {
--         { type = "adicao"},
--         { type = "multiplicacao"},
--         { type = "monstro"}
--     },
--     fastAnswer = {
--         { mensagem = "Ora, temos um genio da matematica aqui, tem que certeza que nao e um robo?"},
--         { mensagem = "Pega leve no utani hur, vai acabar enfartando amigo."},
--         { mensagem = "Respondeu rapido hein!? rápido ate demais"},
--         { mensagem = "Pode substituir o chatGPT com esse raciocinio rapido."},
--         { mensagem = "Esse fez curso de matematica no SENAI!"},
--         { mensagem = "Stephen Hawkin invejava sua inteligencia!"}
--     },
--     playerQuestion = {},
--     messages = {
--         time = "Voce possui %s para responder a pergunta.",
--         chat = "Esse chat so pode ser usado durante a verificacao.",
--         howAnswer = "Voce deve responder somente a resposta, por exemplo: Qual o dia de hoje? Resposta: %d",
--         correctAnswer = "Voce acertou a pergunta e recebeu 15 minutos de bonus de Xp.",
--         incorrectAnswer = "Voce errou a resposta, voce ainda possui %d tentativas.",
--         logout = "Voce nao pode deslogar enquanto hover uma verificacao ativa.",
--     },
--     punishment = {
--         try = {
--             max = 3,
--             reason = "Quantidade excessiva de tentativas.",
--             players = {},
--         },
--         time = {
--             maxTime = 180, -- In seconds
--             reason = "Nao respondeu a pergunta dentro do tempo estipulado.",
--             players = {},
--         },
--     },
--     verification = { 46, 88 }, -- in minutes
--     -- verification = { 1, 2 }, -- in minutes
-- }

-- -------------- FISHING -------------

-- local area1 = {
--     fromPosition = {x = 5056, y = 5024, z = 7},
--     toPosition = {x = 5067, y = 5027, z = 7}
-- }

-- local area2 = {
--     fromPosition = {x = 5053, y = 5027, z = 7},
--     toPosition = {x = 5067, y = 5037, z = 7}
-- }

-- local area3 = {
--     fromPosition = {x = 4302, y = 4391, z = 7},
--     toPosition = {x = 4413, y = 4415, z = 7}
-- }

-- local area4 = {
--     fromPosition = {x = 4302, y = 4391, z = 6},
--     toPosition = {x = 4413, y = 4415, z = 6}
-- }

-- local function isInArea(player, area)
--     local playerPos = player:getPosition()
--     return playerPos.x >= area.fromPosition.x and playerPos.x <= area.toPosition.x
--         and playerPos.y >= area.fromPosition.y and playerPos.y <= area.toPosition.y
--         and playerPos.z == area.fromPosition.z
-- end

-- local function removeSummon(player)
--     local summons = player:getSummons()
--     for _, summon in ipairs(summons) do
--         if summon:getName() == "Anti Afk Orb Anti Noob" or summon:getName() == "" then
--             summon:remove()
--             player:setStorageValue(Storage.Quest.Crandoria.Antibot.LookType, 0)
--         end
--     end
-- end

-- -------------- FISHING -------------

-- function ANTIBOT:addTry(playerId)
--     local player = Player(playerId)

--     if not player then
--         return false
--     end

--     if player:getLevel() < 100 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) < 1 then
--         return false
--     end

--     if player:getLevel() < 100 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) >= 1 then
--         return false
--     end
-- -----------------------
--     local tile = Tile(player:getPosition())
--     if tile and (tile:getItemById(10145) or tile:getItemById(10146)) then
--         -- ANTIBOT:reset(playerId)
--         ANTIBOT:reset(player:getId())
--         return false
--     end

-- ---------------------
--     local timeNow = os.time()
--     local target = player:getTarget()

--     local timeRandom = math.random(38, 75)
--     if (target and target:getName() == "Training Monk") then
--         -- ANTIBOT:reset(playerId)
--         ANTIBOT:reset(player:getId())
--         player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, timeNow + timeRandom * 60)
--         return false
--     end


--     -- playerId = player:getId()

--     if not ANTIBOT.punishment.try.players[playerId] then
--         ANTIBOT.punishment.try.players[playerId] = 0
--     end

--     ANTIBOT.punishment.try.players[playerId] = ANTIBOT.punishment.try.players[playerId] + 1

--     if ANTIBOT.punishment.try.players[playerId] and ANTIBOT.punishment.try.players[playerId] >= ANTIBOT.punishment.try.max then
--         sendChannelMessage(13, TALKTYPE_CHANNEL_O, ANTIBOT.prefix .. ANTIBOT.punishment.try.reason)
--         ANTIBOT:addPunishment(playerId)
--     end
-- end

-- ANTIBOT.punishment.time.isScheduled = ANTIBOT.punishment.time.isScheduled or {}

-- function ANTIBOT:time(playerId)
--     local player = Player(playerId)
--     if not player then
--         ANTIBOT:reset(playerId)
--         -- ANTIBOT:reset(player:getId())
--         return false
--     end

--     local target = player:getTarget()
--     if Tile(player:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) or Tile(player:getPosition()):hasFlag(TILESTATE_PVPZONE) or (target and target:getName() == "Training Monk") then
--         ANTIBOT:reset(playerId)
--         removeSummon(player)
--         return false
--     end

--         ---------- FISHING ---------

--     if isInArea(player, area1) or isInArea(player, area2) then
--         player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 48 * 60)
--         removeSummon(player)
--         return false
--     end

    
--         ---------- FISHING ---------
--     if player:getIp() == 0 then
--         ANTIBOT:reset(playerId)
--         removeSummon(player)
--         player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 48 * 60)
--         return false
--     end

--     local target = player:getTarget()

--     if player:getLevel() < 100 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) < 1 then
--         return false
--     end

--     if player:getLevel() < 100 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) >= 1 then
--         return false
--     end

--     playerId = player:getId()

--     -- if not ANTIBOT.punishment.time.players[playerId] then
--     --     ANTIBOT.punishment.time.players[playerId] = 0
--     --     ANTIBOT:sendQuestions(playerId)
--     -- end

--     if player:getStorageValue(Storage.Quest.Crandoria.Antibot.Timer) < os.time() then
--         if not ANTIBOT.punishment.time.players[playerId] then
--             ANTIBOT.punishment.time.players[playerId] = 0
--             ANTIBOT:sendQuestions(playerId)
--         end
--     end

--     if ANTIBOT.punishment.time.players[playerId] and ANTIBOT.punishment.time.players[playerId] >= ANTIBOT.punishment.time.maxTime then
--         ANTIBOT:addPunishment(playerId)
--     else
--         if not ANTIBOT.punishment.time.isScheduled[playerId] then
--             ANTIBOT.punishment.time.isScheduled[playerId] = true
--             addEvent(function()
--                 local currentPlayer = Player(playerId)
--                 if not currentPlayer then
--                     ANTIBOT.punishment.time.isScheduled[playerId] = false
--                     return
--                 end
                
--                 if ANTIBOT.punishment.time.players[playerId] and ANTIBOT.punishment.time.players[playerId] >= 0 and ANTIBOT.punishment.time.players[playerId] < ANTIBOT.punishment.time.maxTime then
--                     ANTIBOT.punishment.time.players[playerId] = ANTIBOT.punishment.time.players[playerId] + 1
--                     currentPlayer:sendCancelMessage(ANTIBOT.prefix .. ANTIBOT.messages.time:format(string.diff(ANTIBOT.punishment.time.maxTime - ANTIBOT.punishment.time.players[playerId], true)))
--                     currentPlayer:say("AFK", TALKTYPE_MONSTER_SAY)
--                     local hasAntiAfkOrb = false
--                     local summons = currentPlayer:getSummons()
--                     for _, summon in ipairs(summons) do
--                         if summon:getName() == "Anti Afk Orb Anti Noob" or summon:getName() == "" then
--                             hasAntiAfkOrb = true
--                             break
--                         end
--                     end

--                     if not hasAntiAfkOrb then
--                         ANTIBOT:reset(playerId)
--                     end
--                     ANTIBOT.punishment.time.isScheduled[playerId] = false
--                     ANTIBOT:time(playerId)
--                 else
--                     ANTIBOT.punishment.time.isScheduled[playerId] = false
--                 end
--             end, 1000)
--         end
--     end

--     if ANTIBOT.punishment.time.players[playerId] and ANTIBOT.punishment.time.players[playerId] >= ANTIBOT.punishment.time.maxTime then
--         ANTIBOT:addPunishment(playerId)
--     end

-- end


-- function ANTIBOT:sendQuestions(playerId)
--     local player = Player(playerId)

--     if not player then
--         return false
--     end


--     if player:getLevel() < 100 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) < 1 then
--         ANTIBOT:reset(playerId)
--         return false
--     end

--     if player:getLevel() < 100 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) >= 1 then
--         ANTIBOT:reset(playerId)
--         return false
--     end

--         ---------- FISHING E ARAM ---------

--     if isInArea(player, area1) or isInArea(player, area2) or isInArea(player, area3) or isInArea(player, area4) then
--         player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, timeNow + timeRandom * 60)
--         ANTIBOT:reset(playerId)
--         return false
--     end
    
--         ---------- FISHING ---------
--     if player:getIp() == 0 then
--         ANTIBOT:reset(playerId)
--         player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, timeNow + timeRandom * 60)
--         return false
--     end

--     if player:getStorageValue(Storage.Quest.Crandoria.Antibot.Timer) >= os.time() then
--         ANTIBOT:reset(playerId)
--         return false
--     end

--     local tile = Tile(player:getPosition())
--     if tile and (tile:getItemById(10145) or tile:getItemById(10146)) then
--         ANTIBOT:reset(playerId)
--         return false
--     end

--     local target = player:getTarget()
--     if Tile(player:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) or Tile(player:getPosition()):hasFlag(TILESTATE_PVPZONE) or (target and target:getName() == "Training Monk") then
--         ANTIBOT:reset(playerId)
--         return false
--     end
--     if target then
--         if target:isPlayer() then
--             ANTIBOT:reset(playerId)
--             player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 5 * 60)
--             return false
--         else
--             if target:getType() then
--                 if target:getType():isRewardBoss() then
--                     ANTIBOT:reset(playerId)
--                     player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 5 * 60)
--                     return false
--                 end
--             end
--         end
--     end

--     if not player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
--         ANTIBOT:reset(playerId)
--         return false
--     end

--     playerId = player:getId()

--     local random = math.random(#ANTIBOT.questions)

--     ANTIBOT.playerQuestion[playerId] = random
--     local resposta = 0
--     local modeloPerguntaAleatoria = math.random(1, 10)
--     local modeloPergunta = ""
--     local operacao = "monstro" -- ANTIBOT.operation[math.random(1,3)].type;
--     --local operacao = ANTIBOT.operation[math.random(1,3)].type
--     local var1 = math.random(0, 5) -- Gerando o primeiro valor aleatório
--     local var2 = math.random(0, 5) -- Gerando o segundo valor aleatório
--     local monstroAleatorio = ANTIBOT.possibleMonsters[math.random(1, #ANTIBOT.possibleMonsters)]
--     if player:getLevel() >= 500 and player:getLevel() < 750 then
--         monstroAleatorio = ANTIBOT.possibleMonsters2[math.random(1, #ANTIBOT.possibleMonsters2)]
--     elseif player:getLevel() >= 750 and player:getLevel() < 1000 then
--         monstroAleatorio = ANTIBOT.possibleMonsters3[math.random(1, #ANTIBOT.possibleMonsters3)]
--     elseif player:getLevel() >= 1000 then
--         monstroAleatorio = ANTIBOT.possibleMonsters4[math.random(1, #ANTIBOT.possibleMonsters4)]
--     end


--     if operacao == "adicao" then
--         resposta = var1 + var2;
--         modeloPergunta = string.format(ANTIBOT.questionModelAdicao[modeloPerguntaAleatoria].titulo, var1, var2);
--     end
--     if operacao == "multiplicacao" then
--         resposta = var1 * var2;
--         modeloPergunta = string.format(ANTIBOT.questionModelMultiplicacao[modeloPerguntaAleatoria].titulo, var1, var2);
--     end
--     if operacao == "monstro" then
--         ANTIBOT.playerQuestion[playerId] = { question = "Digite o nome da criatura na qual o seu Afk Orb se transformou e receba 15 minutos de bonus de Xp.", staticAnswer = true, answer = monstroAleatorio.name }    
--     -- else
--     --     ANTIBOT.playerQuestion[playerId] = { question = modeloPergunta, staticAnswer = true, answer = tostring(resposta) }
--     end
    



--     local position = player:getPosition()
--     local summon = Game.createMonster("Anti Afk Orb Anti Noob", position, true, true)
--     if summon then
--         summon:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--         summon:changeSpeed(math.max(player:getSpeed() + ((player:getSpeed() / 10) + 20), 0))
--         summon:setMaster(player)
--         summon:setMaxHealth((player:getLevel() * 70) + 5000)
--         summon:setHealth((player:getLevel() * 70) + 5000)
--         if operacao == "monstro" then
--           summon:setOutfit({lookType = monstroAleatorio.looktype })
--           player:setStorageValue(Storage.Quest.Crandoria.Antibot.LookType, monstroAleatorio.looktype)
--           ANTIBOT:startLookTypeRestoreLoop(playerId)
--         end
--     end

--     player:say("AFK", TALKTYPE_MONSTER_SAY)
--     player:openChannel(12)
--     player:sendChannelMessage(player, ANTIBOT.prefix .. ANTIBOT.messages.howAnswer:format(os.date("%d")), TALKTYPE_CHANNEL_O, 12)
--     player:sendChannelMessage(player, ANTIBOT.prefix .. ANTIBOT.playerQuestion[playerId].question, TALKTYPE_CHANNEL_O, 12)
-- end

-- function ANTIBOT:startLookTypeRestoreLoop(playerId)
--     local player = Player(playerId)
--     if not player then
--         return false
--     end
    
--     local playerSummons = player:getSummons()
--     for _, summon in ipairs(playerSummons) do
--         if summon:getName() == "Anti Afk Orb Anti Noob" or summon:getName() == "" then
--             local lookTypeMonster = player:getStorageValue(Storage.Quest.Crandoria.Antibot.LookType)
--             if lookTypeMonster and lookTypeMonster > 0 then
--                 addEvent(function()
--                     local currentPlayer = Player(playerId)
--                     if not currentPlayer then
--                         return
--                     end
                    
--                     local currentSummons = currentPlayer:getSummons()
--                     for _, currentSummon in ipairs(currentSummons) do
--                         if currentSummon:getName() == "Anti Afk Orb Anti Noob" or currentSummon:getName() == "" then
--                             currentSummon:setOutfit({ lookType = lookTypeMonster })
--                             ANTIBOT:startLookTypeRestoreLoop(playerId) -- Reagendar com playerId
--                             break
--                         end
--                     end
--                 end, 5000)
--             end
--             break
--         end
--     end
-- end

-- function ANTIBOT:reset(playerId)
--     ANTIBOT.punishment.try.players[playerId] = nil
--     ANTIBOT.punishment.time.players[playerId] = nil
--     ANTIBOT.playerQuestion[playerId] = nil
-- end

-- function ANTIBOT:addPunishment(playerId)
--     local player = Player(playerId)
--     if not player then
--         return false
--     end

--     playerId = player:getId()

--     local accountId = getAccountNumberByPlayerName(player:getName())
--     if accountId == 0 then
--         return false
--     end

--     local timeNow = os.time()
--     removeSummon(player)

--     local timeRandom = math.random(38, 75)

--     ANTIBOT:reset(playerId)
--     player:getPosition():sendMagicEffect(CONST_ME_POFF)
--     player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, timeNow + timeRandom * 60)

-- end





--------- ANTERIOR A 01 / 03 / 2026 -----------------------



-- ANTIBOT = {
--     prefix = "[AntiAfk] ",
--     questions = {
--         { question = "Qual o resultado de:  %d + %d  ?  ", staticAnswer = true, answer = "" },
--         -- { question = "Qual o ano que começou o COVID-19?", staticAnswer = true, answer = "2019" },
--         -- { question = "Qual seu skill atual de Sword?", skill = true, answer = SKILL_SWORD },
--         -- { question = "Qual seu skill atual de Club?", skill = true, answer = SKILL_CLUB },
--         -- { question = "Qual seu skill atual de Distance?", skill = true, answer = SKILL_DISTANCE },
--         -- { question = "Qual seu level atual?", answer = "level" },
--         -- { question = "Qual o dia de hoje?", answer = "day" },
--     },
--     questionModelAdicao = {
--         { titulo = "Qual o resultado da adicao entre %d vezes 1 e %d?"},
--         { titulo = "Quanto e %d somado com %d e multiplicado por 1?"},
--         { titulo = "Qual e o total quando voce adiciona %d e %d?"},
--         { titulo = "Me diga a soma de %d e %d, por favor."},
--         { titulo = "Quanto da a soma de %d mais %d?"},
--         { titulo = "Qual e a totalizacao de %d e %d?"},
--         { titulo = "Se no lugar de multiplicar voce somar %d com %d, quanto voce obtem?"},
--         { titulo = "Voce pode me dizer a soma de %d e %d? Diga quantas vezes quiser."},
--         { titulo = "Quanto e %d acrescido de %d?"},
--         { titulo = "Diga uma ou duas vezes: Qual e o resultado da adicao entre %d e %d?"},
--     },
--     possibleMonsters = {
--         { looktype = 276, name = "cat" },
--         { looktype = 34, name = "dragon"},
--         { looktype = 21, name = "rat"},
--         { looktype = 32, name = "dog"},
--         -- { looktype = 27, name = "wolf"},
--         -- { looktype = 30, name = "spider"},
--         { looktype = 15, name = "troll" },
--         { looktype = 60, name = "pig" },
--         { looktype = 122, name = "bat"},
--         { looktype = 28, name = "snake"},
--     },

--     possibleMonsters2 = {
--         { looktype = 19, name = "slime" },
--         { looktype = 44, name = "wasp"},
--         { looktype = 16, name = "bear"},
--         { looktype = 9, name = "necromancer"},
--         { looktype = 17, name = "bonelord"},
--         { looktype = 219, name = "tarantula"},
--         { looktype = 83, name = "scarab" },
--         { looktype = 65, name = "mummy" },
--     },

--     possibleMonsters3 = {
--         { looktype = 39, name = "dragon lord" },
--         { looktype = 55, name = "behemoth"},
--         { looktype = 121, name = "hydra"},
--         { looktype = 78, name = "banshee"},
--         { looktype = 291, name = "wyrm"},
--         { looktype = 236, name = "destroyer"},
--         { looktype = 73, name = "hero" },
--         { looktype = 330, name = "medusa" },
--     },

--     possibleMonsters4 = {
--         { looktype = 382, name = "draptor" },
--         { looktype = 19, name = "slime"},
--         { looktype = 585, name = "silencer"},
--         { looktype = 300, name = "grim reaper"},
--         { looktype = 240, name = "hellhound"},
--         { looktype = 231, name = "undead dragon"},
--         { looktype = 854, name = "vexclaw" },
--         { looktype = 35, name = "demon" },
--     },


--     -- questionModelMultiplicacao = {
--     --     { titulo = "Qual e o resultado da subtracao de %d por %d?"},
--     --     { titulo = "Quanto e %d menos %d?"},
--     --     { titulo = "Qual e a diferença entre %d e %d?"},
--     --     { titulo = "Me diga o resultado de %d menos %d, por favor."},
--     --     { titulo = "Em qual valor resulta %d menos o numero %d?"},
--     --     { titulo = "Qual e o resultado quando voce subtrai de %d o valor %d?"},
--     --     { titulo = "Qual valor e o resultado de %d subtraindo %d?"},
--     --     { titulo = "Se voce tentar subtrair de %d o numero %d, qual sera o resultado?"},
--     --     { titulo = "Quanto e %d diminuido por %d?"},
--     --     { titulo = "Quanto seria %d menos o valor %d?"},
--     --     { titulo = "Se voce ganhou %d pontos de experiencia e ao morrer perdeu %d pontos de experiencia, qual o valor final positivo ou negativo de experiencia?" }
--     -- },

--     questionModelMultiplicacao = {
--         { titulo = "Qual e o resultado da multiplicacao de %d por %d mais 0?"},
--         { titulo = "Mostre que voce pode ser mais inteligente: Quanto e %d vezes %d?"},
--         { titulo = "Quanto seria %d vezes %d?"},
--         { titulo = "Se sua guild tem %d players e cada um tem %d gold tokens, qual o total de gold tokens da sua guild?"},
--         { titulo = "Se um monstro fornece %d pontos de experiencia, quanto de experiencia voce recebera se matar %d monstros?"},
--         { titulo = "Se em %d dias voce matou %d monstros por dia, quantos monstros voce matou somando todos os dias?"},
--         { titulo = "Qual seria o resultado de %d vezes o numero %d?"},
--         { titulo = "Se voce usa %d potions por minuto em uma hunt, quantas potions voce usa durante %d minutos? O resultado sera a soma de todas as potions usadas."},
--         { titulo = "Quanto e %d multiplicado por %d?"},
--         { titulo = "Qual o valor do resultado de %d multiplicado pelo numero %d? Responda o valor exato, nem mais, nem menos!"},
--         { titulo = "Se no lugar de somar voce multiplicar %d pelo numero inteiro %d qual sera o resultado final?" }
--     },

--     operation =  {
--         { type = "adicao"},
--         { type = "multiplicacao"},
--         { type = "monstro"}
--     },
--     fastAnswer = {
--         { mensagem = "Ora, temos um genio da matematica aqui, tem que certeza que nao e um robo?"},
--         { mensagem = "Pega leve no utani hur, vai acabar enfartando amigo."},
--         { mensagem = "Respondeu rapido hein!? rápido ate demais"},
--         { mensagem = "Pode substituir o chatGPT com esse raciocinio rapido."},
--         { mensagem = "Esse fez curso de matematica no SENAI!"},
--         { mensagem = "Stephen Hawkin invejava sua inteligencia!"}
--     },
--     playerQuestion = {},
--     messages = {
--         time = "Voce possui %s para responder a pergunta.",
--         chat = "Esse chat so pode ser usado durante a verificacao.",
--         howAnswer = "Voce deve responder somente a resposta, por exemplo: Qual o dia de hoje? Resposta: %d",
--         correctAnswer = "Voce acertou a pergunta. Obrigado.",
--         incorrectAnswer = "Voce errou a resposta, voce ainda possui %d tentativas.",
--         logout = "Voce nao pode deslogar enquanto hover uma verificacao ativa.",
--     },
--     punishment = {
--         try = {
--             max = 3,
--             reason = "Quantidade excessiva de tentativas.",
--             players = {},
--         },
--         time = {
--             maxTime = 900, -- In seconds
--             reason = "Nao respondeu a pergunta dentro do tempo estipulado.",
--             players = {},
--         },
--     },
--     verification = { 36, 59 }, -- in minutes
--     -- verification = { 1, 2 }, -- in minutes
-- }

-- -------------- FISHING -------------

-- local area1 = {
--     fromPosition = {x = 5056, y = 5024, z = 7},
--     toPosition = {x = 5067, y = 5027, z = 7}
-- }

-- local area2 = {
--     fromPosition = {x = 5053, y = 5027, z = 7},
--     toPosition = {x = 5067, y = 5037, z = 7}
-- }

-- local area3 = {
--     fromPosition = {x = 4302, y = 4391, z = 7},
--     toPosition = {x = 4413, y = 4415, z = 7}
-- }

-- local area4 = {
--     fromPosition = {x = 4302, y = 4391, z = 6},
--     toPosition = {x = 4413, y = 4415, z = 6}
-- }

-- local function isInArea(player, area)
--     local playerPos = player:getPosition()
--     return playerPos.x >= area.fromPosition.x and playerPos.x <= area.toPosition.x
--         and playerPos.y >= area.fromPosition.y and playerPos.y <= area.toPosition.y
--         and playerPos.z == area.fromPosition.z
-- end

-- -------------- FISHING -------------

-- function ANTIBOT:addTry(playerId)
--     local player = Player(playerId)

--     if not player then
--         return false
--     end

--     if player:getLevel() < 100 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) < 1 then
--         return false
--     end

--     if player:getLevel() < 100 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) >= 1 then
--         return false
--     end
-- -----------------------
--     local tile = Tile(player:getPosition())
--     if tile and (tile:getItemById(10145) or tile:getItemById(10146)) then
--         -- ANTIBOT:reset(playerId)
--         ANTIBOT:reset(player:getId())
--         return false
--     end

-- ---------------------
--     local target = player:getTarget()

--     if player:getStorageValue(Storage.Quest.Crandoria.PasseAntiafk) > os.time() and player:getStorageValue(Storage.Quest.Crandoria.PvpStatus.Status) > 0 then
--         ANTIBOT:reset(player:getId())
--         player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 25 * 60)
--         return false
--     end


--     if (target and target:getName() == "Training Monk") then
--         -- ANTIBOT:reset(playerId)
--         ANTIBOT:reset(player:getId())
--         player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 20 * 60)
--         return false
--     end


--     -- playerId = player:getId()

--     if not ANTIBOT.punishment.try.players[playerId] then
--         ANTIBOT.punishment.try.players[playerId] = 0
--     end

--     ANTIBOT.punishment.try.players[playerId] = ANTIBOT.punishment.try.players[playerId] + 1

--     if ANTIBOT.punishment.try.players[playerId] and ANTIBOT.punishment.try.players[playerId] >= ANTIBOT.punishment.try.max then
--         sendChannelMessage(13, TALKTYPE_CHANNEL_O, ANTIBOT.prefix .. ANTIBOT.punishment.try.reason)
--         ANTIBOT:addPunishment(playerId)
--     end
-- end

-- ANTIBOT.punishment.time.isScheduled = ANTIBOT.punishment.time.isScheduled or {}

-- function ANTIBOT:time(playerId)
--     local player = Player(playerId)
--     if not player then
--         ANTIBOT:reset(playerId)
--         -- ANTIBOT:reset(player:getId())
--         return false
--     end

--         ---------- FISHING ---------

--     if isInArea(player, area1) or isInArea(player, area2) then
--         player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 20 * 60)
--         return false
--     end

    
--         ---------- FISHING ---------
--     if player:getIp() == 0 then
--         ANTIBOT:reset(playerId)
--         player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 20 * 60)
--         return false
--     end
-- -----------------------
--     local tile = Tile(player:getPosition())
--     if tile and (tile:getItemById(10145) or tile:getItemById(10146)) then
--         ANTIBOT:reset(playerId)
--         -- ANTIBOT:reset(player:getId())
--         return false
--     end
-- ------------------------
--     local target = player:getTarget()

--     if player:getLevel() < 100 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) < 1 then
--         return false
--     end

--     if player:getLevel() < 100 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) >= 1 then
--         return false
--     end

--     if (target and target:getName() == "Training Monk") then
--         ANTIBOT:reset(playerId)
--         player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 20 * 60)
--         -- ANTIBOT:reset(player:getId())
--         return false
--     end


--     playerId = player:getId()

--     -- if not ANTIBOT.punishment.time.players[playerId] then
--     --     ANTIBOT.punishment.time.players[playerId] = 0
--     --     ANTIBOT:sendQuestions(playerId)
--     -- end

--     if player:getStorageValue(Storage.Quest.Crandoria.Antibot.Timer) < os.time() then
--         if not ANTIBOT.punishment.time.players[playerId] then
--             ANTIBOT.punishment.time.players[playerId] = 0
--             ANTIBOT:sendQuestions(playerId)
--         end
--     end

--     if ANTIBOT.punishment.time.players[playerId] and ANTIBOT.punishment.time.players[playerId] >= ANTIBOT.punishment.time.maxTime then
--         ANTIBOT:addPunishment(playerId)
--     else
--         if not ANTIBOT.punishment.time.isScheduled[playerId] then
--             ANTIBOT.punishment.time.isScheduled[playerId] = true
--             addEvent(function()
--                 local currentPlayer = Player(playerId)
--                 if not currentPlayer then
--                     ANTIBOT.punishment.time.isScheduled[playerId] = false
--                     return
--                 end
                
--                 if ANTIBOT.punishment.time.players[playerId] and ANTIBOT.punishment.time.players[playerId] >= 0 and ANTIBOT.punishment.time.players[playerId] < ANTIBOT.punishment.time.maxTime then
--                     ANTIBOT.punishment.time.players[playerId] = ANTIBOT.punishment.time.players[playerId] + 1
--                     currentPlayer:sendCancelMessage(ANTIBOT.prefix .. ANTIBOT.messages.time:format(string.diff(ANTIBOT.punishment.time.maxTime - ANTIBOT.punishment.time.players[playerId], true)))
--                     currentPlayer:say("ANTIAFK", TALKTYPE_MONSTER_SAY)
--                     local hasAntiAfkOrb = false
--                     local summons = currentPlayer:getSummons()
--                     for _, summon in ipairs(summons) do
--                         if summon:getName() == "Anti Afk Orb Anti Noob" or summon:getName() == "" then
--                             hasAntiAfkOrb = true
--                             break
--                         end
--                     end

--                     -- if ANTIBOT.punishment.time.players[playerId] > 180 then -- A CADA SEG A PARTIR DE UM TEMPO
--                     --     if (ANTIBOT.punishment.time.players[playerId] % 5 == 0) then -- A CADA 5S
--                     --         player:setStamina(player:getStamina() - 1)
--                     --     end
--                     -- end

--                     -- if not hasAntiAfkOrb then
--                     --     if player:getSkull() == SKULL_WHITE or player:getSkull() == SKULL_RED or player:getSkull() == SKULL_BLACK then
--                     --         if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
--                     --             player:teleportTo(Position(4553, 5411, 7))
--                     --         else
--                     --             player:teleportTo(Position(4934, 4974, 6))
--                     --         end
--                     --         player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--                     --         ANTIBOT:reset(playerId)
--                     --     else
--                     --         if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
--                     --             player:teleportTo(Position(4553, 5411, 7))
--                     --         else
--                     --             player:teleportTo(Position(4934, 4974, 6))
--                     --         end
--                     --         player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--                     --         ANTIBOT:reset(playerId)
--                     --     end
--                     -- end


--                     if not hasAntiAfkOrb then
--                         if player:getSkull() == SKULL_WHITE or player:getSkull() == SKULL_RED or player:getSkull() == SKULL_BLACK then
--                             if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
--                                 local addTimeValue = player:getStorageValue(Storage.Quest.Crandoria.Prison.AddTime)
--                                 local maxAddTimeValue = 21600
--                                 local calculatedAddTime = addTimeValue * 15 * 60
--                                 local enterCooldown = os.time() - player:getStorageValue(Storage.Quest.Crandoria.Prison.EnterCooldown)
--                                 local prisonTimer = player:getStorageValue(Storage.Quest.Crandoria.Prison.Timer)
--                                 local adjustedAddTime = math.min(calculatedAddTime, maxAddTimeValue)

                                
--                                 player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--                                 player:setStorageValue(Storage.Quest.Crandoria.Prison.AddTime, addTimeValue + 1)
--                                 player:setStorageValue(Storage.Quest.Crandoria.Prison.Timer, os.time() + 30 * 60 + adjustedAddTime)
--                                 player:setStorageValue(Storage.Quest.Crandoria.Prison.EnterCooldown, os.time())
--                                 if player:getSkull() == SKULL_WHITE or player:getSkull() == SKULL_RED or player:getSkull() == SKULL_BLACK then
--                                     player:teleportTo(Position(4564, 5419, 7))
--                                 else
--                                     player:teleportTo(Position(4564, 5404, 7))
--                                 end
--                             else
--                                 player:teleportTo(Position(4934, 4974, 6))
--                             end
--                             player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--                             player:setStorageValue(Storage.Quest.Crandoria.Prison.QuestionIndex, 2)
--                             ANTIBOT:reset(playerId)
--                         else
--                             if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
--                                 player:teleportTo(Position(4564, 5419, 7))
--                             else
--                                 player:teleportTo(Position(4934, 4974, 6))
--                             end
--                             player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--                             player:setStorageValue(Storage.Quest.Crandoria.Prison.QuestionIndex, 1)
--                             ANTIBOT:reset(playerId)
--                         end
--                     end




--                     -- position:sendMagicEffect(CONST_ME_POFF)
--                     ANTIBOT.punishment.time.isScheduled[playerId] = false
--                     ANTIBOT:time(playerId)
--                 else
--                     ANTIBOT.punishment.time.isScheduled[playerId] = false
--                 end
--             end, 1000)
--         end
--     end

--     if ANTIBOT.punishment.time.players[playerId] and ANTIBOT.punishment.time.players[playerId] >= ANTIBOT.punishment.time.maxTime then
--         ANTIBOT:addPunishment(playerId)
--     end

-- end


-- function ANTIBOT:sendQuestions(playerId)
--     local player = Player(playerId)

--     if not player then
--         return false
--     end

--     if player:getLevel() < 2000 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) < 1 then
--         ANTIBOT:reset(playerId)
--         return false
--     end

--     if player:getLevel() < 2000 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) >= 1 then
--         ANTIBOT:reset(playerId)
--         return false
--     end

--     local ring = player:getSlotItem(CONST_SLOT_RING)
--     if ring and ring.itemid == 12670 then
--         player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Anti Afk desativado por possuir Star Ring.")
--         ANTIBOT:reset(playerId)
--         return false
--     end

--     if player:getStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffAfk) > os.time() then
--         player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Anti Afk desativado pela Sociedade de Astralis. Tenha um bom up!")
--         ANTIBOT:reset(playerId)
--         return false
--     end 

--         ---------- FISHING E ARAM ---------

--     if isInArea(player, area1) or isInArea(player, area2) or isInArea(player, area3) or isInArea(player, area4) then
--         player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 20 * 60)
--         ANTIBOT:reset(playerId)
--         return false
--     end
    
--         ---------- FISHING ---------
--     if player:getIp() == 0 then
--         ANTIBOT:reset(playerId)
--         player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 20 * 60)
--         return false
--     end

--     if player:getStorageValue(Storage.Quest.Crandoria.PasseAntiafk) > os.time() then
--         ANTIBOT:reset(player:getId())
--         player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 25 * 60)
--         return false
--     end

--     -- ULTIMO EDIT
--     -- if player:getStorageValue(Storage.Quest.Crandoria.Antibot.Timer) >= os.time() then
--     --     ANTIBOT:reset(playerId)
--     --     return false
--     -- end

--     if player:getStorageValue(Storage.Quest.Crandoria.Antibot.Timer) >= os.time() then
--         ANTIBOT:reset(playerId)
--         return false
--     end

--     local tile = Tile(player:getPosition())
--     if tile and (tile:getItemById(10145) or tile:getItemById(10146)) then
--         ANTIBOT:reset(playerId)
--         return false
--     end

--     local target = player:getTarget()
--     if Tile(player:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) or Tile(player:getPosition()):hasFlag(TILESTATE_PVPZONE) or (target and target:getName() == "Training Monk") then
--         ANTIBOT:reset(playerId)
--         return false
--     end
--     if target then
--         if target:isPlayer() then
--             ANTIBOT:reset(playerId)
--             player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 5 * 60)
--             return false
--         else
--             if target:getType() then
--                 if target:getType():isRewardBoss() then
--                     ANTIBOT:reset(playerId)
--                     player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 5 * 60)
--                     return false
--                 end
--             end
--         end
--     end

--     if not player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
--         ANTIBOT:reset(playerId)
--         return false
--     end

--     playerId = player:getId()

--     local random = math.random(#ANTIBOT.questions)

--     ANTIBOT.playerQuestion[playerId] = random
--     local resposta = 0
--     local modeloPerguntaAleatoria = math.random(1, 10)
--     local modeloPergunta = ""
--     local operacao = "monstro" -- ANTIBOT.operation[math.random(1,3)].type;
--     --local operacao = ANTIBOT.operation[math.random(1,3)].type
--     local var1 = math.random(0, 5) -- Gerando o primeiro valor aleatório
--     local var2 = math.random(0, 5) -- Gerando o segundo valor aleatório
--     local monstroAleatorio = ANTIBOT.possibleMonsters[math.random(1, #ANTIBOT.possibleMonsters)]
--     if player:getLevel() >= 500 and player:getLevel() < 750 then
--         monstroAleatorio = ANTIBOT.possibleMonsters2[math.random(1, #ANTIBOT.possibleMonsters2)]
--     elseif player:getLevel() >= 750 and player:getLevel() < 1000 then
--         monstroAleatorio = ANTIBOT.possibleMonsters3[math.random(1, #ANTIBOT.possibleMonsters3)]
--     elseif player:getLevel() >= 1000 then
--         monstroAleatorio = ANTIBOT.possibleMonsters4[math.random(1, #ANTIBOT.possibleMonsters4)]
--     end


--     if operacao == "adicao" then
--         resposta = var1 + var2;
--         modeloPergunta = string.format(ANTIBOT.questionModelAdicao[modeloPerguntaAleatoria].titulo, var1, var2);
--     end
--     if operacao == "multiplicacao" then
--         resposta = var1 * var2;
--         modeloPergunta = string.format(ANTIBOT.questionModelMultiplicacao[modeloPerguntaAleatoria].titulo, var1, var2);
--     end
--     if operacao == "monstro" then
--         ANTIBOT.playerQuestion[playerId] = { question = "Digite o nome da criatura na qual o seu Anti Afk Orb se transformou.", staticAnswer = true, answer = monstroAleatorio.name }    
--     -- else
--     --     ANTIBOT.playerQuestion[playerId] = { question = modeloPergunta, staticAnswer = true, answer = tostring(resposta) }
--     end
    



--     local position = player:getPosition()
--     local summon = Game.createMonster("Anti Afk Orb Anti Noob", position, true, true)
--     if summon then
--         summon:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--         summon:changeSpeed(math.max(player:getSpeed() + ((player:getSpeed() / 10) + 20), 0))
--         summon:setMaster(player)
--         summon:setMaxHealth((player:getLevel() * 70) + 5000)
--         summon:setHealth((player:getLevel() * 70) + 5000)
--         if operacao == "monstro" then
--           summon:setOutfit({lookType = monstroAleatorio.looktype })
--           player:setStorageValue(Storage.Quest.Crandoria.Antibot.LookType, monstroAleatorio.looktype)
--           ANTIBOT:startLookTypeRestoreLoop(playerId)
--         end
--     end

--     player:say("ANTIAFK", TALKTYPE_MONSTER_SAY)
--     player:openChannel(12)
--     player:sendChannelMessage(player, ANTIBOT.prefix .. ANTIBOT.messages.howAnswer:format(os.date("%d")), TALKTYPE_CHANNEL_O, 12)
--     player:sendChannelMessage(player, ANTIBOT.prefix .. ANTIBOT.playerQuestion[playerId].question, TALKTYPE_CHANNEL_O, 12)
--     -- player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + (60 - ((player:getLevel() / 50) + (player:getStamina() / 300))) * 60)
--     -- player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 2 * 60)
--     -- addEvent(sendChannelMessage, 500, 12, TALKTYPE_CHANNEL_O, ANTIBOT.prefix .. ANTIBOT.messages.howAnswer:format(os.date("%d")))
--     -- addEvent(sendChannelMessage, 800, 12, TALKTYPE_CHANNEL_O, ANTIBOT.prefix .. ANTIBOT.playerQuestion[playerId].question)
-- end

-- function ANTIBOT:startLookTypeRestoreLoop(playerId)
--     local player = Player(playerId)
--     if not player then
--         return false
--     end
    
--     local playerSummons = player:getSummons()
--     for _, summon in ipairs(playerSummons) do
--         if summon:getName() == "Anti Afk Orb Anti Noob" or summon:getName() == "" then
--             local lookTypeMonster = player:getStorageValue(Storage.Quest.Crandoria.Antibot.LookType)
--             if lookTypeMonster and lookTypeMonster > 0 then
--                 addEvent(function()
--                     local currentPlayer = Player(playerId)
--                     if not currentPlayer then
--                         return
--                     end
                    
--                     local currentSummons = currentPlayer:getSummons()
--                     for _, currentSummon in ipairs(currentSummons) do
--                         if currentSummon:getName() == "Anti Afk Orb Anti Noob" or currentSummon:getName() == "" then
--                             currentSummon:setOutfit({ lookType = lookTypeMonster })
--                             ANTIBOT:startLookTypeRestoreLoop(playerId) -- Reagendar com playerId
--                             break
--                         end
--                     end
--                 end, 5000)
--             end
--             break
--         end
--     end
-- end

-- function ANTIBOT:reset(playerId)
--     ANTIBOT.punishment.try.players[playerId] = nil
--     ANTIBOT.punishment.time.players[playerId] = nil
--     ANTIBOT.playerQuestion[playerId] = nil
-- end

-- function ANTIBOT:addPunishment(playerId)
--     local player = Player(playerId)
--     if not player then
--         return false
--     end

--     playerId = player:getId()

--     local accountId = getAccountNumberByPlayerName(player:getName())
--     if accountId == 0 then
--         return false
--     end

--     -- local resultId = db.storeQuery("SELECT 1 FROM `account_bans` WHERE `account_id` = " .. accountId)
--     -- if resultId ~= false then
--     --     result.free(resultId)
--     --     return false
--     -- end

--     local timeNow = os.time()


--     if ANTIBOT.punishment.try.players[playerId] and ANTIBOT.punishment.try.players[playerId] >= ANTIBOT.punishment.try.max and player:getLevel() >= 100 and (player:getSkull() == SKULL_WHITE or player:getSkull() == SKULL_RED or player:getSkull() == SKULL_BLACK) then
--         if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
--             local addTimeValue = player:getStorageValue(Storage.Quest.Crandoria.Prison.AddTime)
--             local maxAddTimeValue = 21600
--             local calculatedAddTime = addTimeValue * 15 * 60
--             local enterCooldown = os.time() - player:getStorageValue(Storage.Quest.Crandoria.Prison.EnterCooldown)
--             local prisonTimer = player:getStorageValue(Storage.Quest.Crandoria.Prison.Timer)
--             local adjustedAddTime = math.min(calculatedAddTime, maxAddTimeValue)

--             player:teleportTo(Position(4564, 5419, 7))
--             player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--             player:setStorageValue(Storage.Quest.Crandoria.Prison.AddTime, addTimeValue + 1)
--             player:setStorageValue(Storage.Quest.Crandoria.Prison.Timer, os.time() + 30 * 60 + adjustedAddTime)
--             player:setStorageValue(Storage.Quest.Crandoria.Prison.EnterCooldown, os.time())
--         else
--             player:teleportTo(Position(4934, 4974, 6))
--         end
--         player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--         player:setStorageValue(Storage.Quest.Crandoria.Prison.QuestionIndex, 2)
--         player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickPrison, os.time() + 24 * 60 * 60)
--         local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
-- 		local repnew = math.min(0, storageRep - 15)
-- 		player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, repnew)
-- 		player:say("- Reputacao", TALKTYPE_MONSTER_SAY)
--     elseif ANTIBOT.punishment.time.players[playerId] and ANTIBOT.punishment.time.players[playerId] >= ANTIBOT.punishment.time.maxTime and player:getLevel() >= 100 and (player:getSkull() == SKULL_WHITE or player:getSkull() == SKULL_RED or player:getSkull() == SKULL_BLACK) then
--         if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
--             local addTimeValue = player:getStorageValue(Storage.Quest.Crandoria.Prison.AddTime)
--             local maxAddTimeValue = 21600
--             local calculatedAddTime = addTimeValue * 15 * 60
--             local enterCooldown = os.time() - player:getStorageValue(Storage.Quest.Crandoria.Prison.EnterCooldown)
--             local prisonTimer = player:getStorageValue(Storage.Quest.Crandoria.Prison.Timer)
--             local adjustedAddTime = math.min(calculatedAddTime, maxAddTimeValue)

--             player:teleportTo(Position(4564, 5419, 7))
--             player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--             player:setStorageValue(Storage.Quest.Crandoria.Prison.AddTime, addTimeValue + 1)
--             player:setStorageValue(Storage.Quest.Crandoria.Prison.Timer, os.time() + 30 * 60 + adjustedAddTime)
--             player:setStorageValue(Storage.Quest.Crandoria.Prison.EnterCooldown, os.time())
--         else
--             player:teleportTo(Position(4934, 4974, 6))
--         end
--         player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--         player:setStorageValue(Storage.Quest.Crandoria.Prison.QuestionIndex, 2)
--         player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickPrison, os.time() + 24 * 60 * 60)
--         local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
-- 		local repnew = math.min(0, storageRep - 15)
-- 		player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, repnew)
-- 		player:say("- Reputacao", TALKTYPE_MONSTER_SAY)
--     elseif ANTIBOT.punishment.try.players[playerId] and player:getLevel() >= 100 and ANTIBOT.punishment.try.players[playerId] >= ANTIBOT.punishment.try.max then
--         if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
--             local addTimeValue = player:getStorageValue(Storage.Quest.Crandoria.Prison.AddTime)
--             local maxAddTimeValue = 21600
--             local calculatedAddTime = addTimeValue * 15 * 60
--             local enterCooldown = os.time() - player:getStorageValue(Storage.Quest.Crandoria.Prison.EnterCooldown)
--             local prisonTimer = player:getStorageValue(Storage.Quest.Crandoria.Prison.Timer)
--             local adjustedAddTime = math.min(calculatedAddTime, maxAddTimeValue)

--             player:teleportTo(Position(4564, 5404, 7))
--             player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--             player:setStorageValue(Storage.Quest.Crandoria.Prison.AddTime, addTimeValue + 1)
--             player:setStorageValue(Storage.Quest.Crandoria.Prison.Timer, os.time() + 30 * 60 + adjustedAddTime)
--             player:setStorageValue(Storage.Quest.Crandoria.Prison.EnterCooldown, os.time())
--         else
--             player:teleportTo(Position(4934, 4974, 6))
--         end
--         player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--         player:setStorageValue(Storage.Quest.Crandoria.Prison.QuestionIndex, 1)
--         player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickPrison, os.time() + 24 * 60 * 60)
--         local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
-- 		local repnew = math.min(0, storageRep - 15)
-- 		player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, repnew)
-- 		player:say("- Reputacao", TALKTYPE_MONSTER_SAY)
--     elseif ANTIBOT.punishment.time.players[playerId] and player:getLevel() >= 100 and ANTIBOT.punishment.time.players[playerId] >= ANTIBOT.punishment.time.maxTime then
--         if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
--             local addTimeValue = player:getStorageValue(Storage.Quest.Crandoria.Prison.AddTime)
--             local maxAddTimeValue = 21600
--             local calculatedAddTime = addTimeValue * 15 * 60
--             local enterCooldown = os.time() - player:getStorageValue(Storage.Quest.Crandoria.Prison.EnterCooldown)
--             local prisonTimer = player:getStorageValue(Storage.Quest.Crandoria.Prison.Timer)
--             local adjustedAddTime = math.min(calculatedAddTime, maxAddTimeValue)

--             player:teleportTo(Position(4564, 5404, 7))
--             player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--             player:setStorageValue(Storage.Quest.Crandoria.Prison.AddTime, addTimeValue + 1)
--             player:setStorageValue(Storage.Quest.Crandoria.Prison.Timer, os.time() + 30 * 60 + adjustedAddTime)
--             player:setStorageValue(Storage.Quest.Crandoria.Prison.EnterCooldown, os.time())
--         else
--             player:teleportTo(Position(4934, 4974, 6))
--         end
--         player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--         player:setStorageValue(Storage.Quest.Crandoria.Prison.QuestionIndex, 1)
--         player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickPrison, os.time() + 24 * 60 * 60)
--         local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
-- 		local repnew = math.min(0, storageRep - 15)
-- 		player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, repnew)
-- 		player:say("- Reputacao", TALKTYPE_MONSTER_SAY)
--     end

--     local summons = player:getSummons()
--     for _, summon in ipairs(summons) do
--         if summon:getName() == "Anti Afk Orb Anti Noob" or summon:getName() == "" then
--             summon:remove()
--             player:setStorageValue(Storage.Quest.Crandoria.Antibot.LookType, 0)
--         end
--     end

--     ANTIBOT:reset(playerId)
--     -- ANTIBOT:reset(player:getId())
--     -- player:save()
--     player:getPosition():sendMagicEffect(CONST_ME_POFF)
--     player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 30 * 60)
--     -- player:remove()
-- end





-------------------- ANTERIOR A 05/01/2026 -------------------------------


-- ANTIBOT = {
--     prefix = "[AntiAfk] ",
--     questions = {
--         { question = "Qual o resultado de:  %d + %d  ?  ", staticAnswer = true, answer = "" },
--         -- { question = "Qual o ano que começou o COVID-19?", staticAnswer = true, answer = "2019" },
--         -- { question = "Qual seu skill atual de Sword?", skill = true, answer = SKILL_SWORD },
--         -- { question = "Qual seu skill atual de Club?", skill = true, answer = SKILL_CLUB },
--         -- { question = "Qual seu skill atual de Distance?", skill = true, answer = SKILL_DISTANCE },
--         -- { question = "Qual seu level atual?", answer = "level" },
--         -- { question = "Qual o dia de hoje?", answer = "day" },
--     },
--     questionModelAdicao = {
--         { titulo = "Qual o resultado da adicao entre %d vezes 1 e %d?"},
--         { titulo = "Quanto e %d somado com %d e multiplicado por 1?"},
--         { titulo = "Qual e o total quando voce adiciona %d e %d?"},
--         { titulo = "Me diga a soma de %d e %d, por favor."},
--         { titulo = "Quanto da a soma de %d mais %d?"},
--         { titulo = "Qual e a totalizacao de %d e %d?"},
--         { titulo = "Se no lugar de multiplicar voce somar %d com %d, quanto voce obtem?"},
--         { titulo = "Voce pode me dizer a soma de %d e %d? Diga quantas vezes quiser."},
--         { titulo = "Quanto e %d acrescido de %d?"},
--         { titulo = "Diga uma ou duas vezes: Qual e o resultado da adicao entre %d e %d?"},
--     },
--     possibleMonsters = {
--         { looktype = 276, name = "cat" },
--         { looktype = 34, name = "dragon"},
--         { looktype = 21, name = "rat"},
--         { looktype = 32, name = "dog"},
--         -- { looktype = 27, name = "wolf"},
--         -- { looktype = 30, name = "spider"},
--         { looktype = 15, name = "troll" },
--         { looktype = 60, name = "pig" },
--         { looktype = 122, name = "bat"},
--         { looktype = 28, name = "snake"},
--     },

--     possibleMonsters2 = {
--         { looktype = 19, name = "slime" },
--         { looktype = 44, name = "wasp"},
--         { looktype = 16, name = "bear"},
--         { looktype = 9, name = "necromancer"},
--         { looktype = 17, name = "bonelord"},
--         { looktype = 219, name = "tarantula"},
--         { looktype = 83, name = "scarab" },
--         { looktype = 65, name = "mummy" },
--     },

--     possibleMonsters3 = {
--         { looktype = 39, name = "dragon lord" },
--         { looktype = 55, name = "behemoth"},
--         { looktype = 121, name = "hydra"},
--         { looktype = 78, name = "banshee"},
--         { looktype = 291, name = "wyrm"},
--         { looktype = 236, name = "destroyer"},
--         { looktype = 73, name = "hero" },
--         { looktype = 330, name = "medusa" },
--     },

--     possibleMonsters4 = {
--         { looktype = 382, name = "draptor" },
--         { looktype = 19, name = "slime"},
--         { looktype = 585, name = "silencer"},
--         { looktype = 300, name = "grim reaper"},
--         { looktype = 240, name = "hellhound"},
--         { looktype = 231, name = "undead dragon"},
--         { looktype = 854, name = "vexclaw" },
--         { looktype = 35, name = "demon" },
--     },


--     -- questionModelMultiplicacao = {
--     --     { titulo = "Qual e o resultado da subtracao de %d por %d?"},
--     --     { titulo = "Quanto e %d menos %d?"},
--     --     { titulo = "Qual e a diferença entre %d e %d?"},
--     --     { titulo = "Me diga o resultado de %d menos %d, por favor."},
--     --     { titulo = "Em qual valor resulta %d menos o numero %d?"},
--     --     { titulo = "Qual e o resultado quando voce subtrai de %d o valor %d?"},
--     --     { titulo = "Qual valor e o resultado de %d subtraindo %d?"},
--     --     { titulo = "Se voce tentar subtrair de %d o numero %d, qual sera o resultado?"},
--     --     { titulo = "Quanto e %d diminuido por %d?"},
--     --     { titulo = "Quanto seria %d menos o valor %d?"},
--     --     { titulo = "Se voce ganhou %d pontos de experiencia e ao morrer perdeu %d pontos de experiencia, qual o valor final positivo ou negativo de experiencia?" }
--     -- },

--     questionModelMultiplicacao = {
--         { titulo = "Qual e o resultado da multiplicacao de %d por %d mais 0?"},
--         { titulo = "Mostre que voce pode ser mais inteligente: Quanto e %d vezes %d?"},
--         { titulo = "Quanto seria %d vezes %d?"},
--         { titulo = "Se sua guild tem %d players e cada um tem %d gold tokens, qual o total de gold tokens da sua guild?"},
--         { titulo = "Se um monstro fornece %d pontos de experiencia, quanto de experiencia voce recebera se matar %d monstros?"},
--         { titulo = "Se em %d dias voce matou %d monstros por dia, quantos monstros voce matou somando todos os dias?"},
--         { titulo = "Qual seria o resultado de %d vezes o numero %d?"},
--         { titulo = "Se voce usa %d potions por minuto em uma hunt, quantas potions voce usa durante %d minutos? O resultado sera a soma de todas as potions usadas."},
--         { titulo = "Quanto e %d multiplicado por %d?"},
--         { titulo = "Qual o valor do resultado de %d multiplicado pelo numero %d? Responda o valor exato, nem mais, nem menos!"},
--         { titulo = "Se no lugar de somar voce multiplicar %d pelo numero inteiro %d qual sera o resultado final?" }
--     },

--     operation =  {
--         { type = "adicao"},
--         { type = "multiplicacao"},
--         { type = "monstro"}
--     },
--     fastAnswer = {
--         { mensagem = "Ora, temos um genio da matematica aqui, tem que certeza que nao e um robo?"},
--         { mensagem = "Pega leve no utani hur, vai acabar enfartando amigo."},
--         { mensagem = "Respondeu rapido hein!? rápido ate demais"},
--         { mensagem = "Pode substituir o chatGPT com esse raciocinio rapido."},
--         { mensagem = "Esse fez curso de matematica no SENAI!"},
--         { mensagem = "Stephen Hawkin invejava sua inteligencia!"}
--     },
--     playerQuestion = {},
--     messages = {
--         time = "Voce possui %s para responder a pergunta.",
--         chat = "Esse chat so pode ser usado durante a verificacao.",
--         howAnswer = "Voce deve responder somente a resposta, por exemplo: Qual o dia de hoje? Resposta: %d",
--         correctAnswer = "Voce acertou a pergunta. Obrigado.",
--         incorrectAnswer = "Voce errou a resposta, voce ainda possui %d tentativas.",
--         logout = "Voce nao pode deslogar enquanto hover uma verificacao ativa.",
--     },
--     punishment = {
--         try = {
--             max = 3,
--             reason = "Quantidade excessiva de tentativas.",
--             players = {},
--         },
--         time = {
--             maxTime = 900, -- In seconds
--             reason = "Nao respondeu a pergunta dentro do tempo estipulado.",
--             players = {},
--         },
--     },
--     verification = { 1, 2 }, -- in minutes
-- }

-- -------------- FISHING -------------

-- local area1 = {
--     fromPosition = {x = 5056, y = 5024, z = 7},
--     toPosition = {x = 5067, y = 5027, z = 7}
-- }

-- local area2 = {
--     fromPosition = {x = 5053, y = 5027, z = 7},
--     toPosition = {x = 5067, y = 5037, z = 7}
-- }

-- local area3 = {
--     fromPosition = {x = 4302, y = 4391, z = 7},
--     toPosition = {x = 4413, y = 4415, z = 7}
-- }

-- local area4 = {
--     fromPosition = {x = 4302, y = 4391, z = 6},
--     toPosition = {x = 4413, y = 4415, z = 6}
-- }

-- local function isInArea(player, area)
--     local playerPos = player:getPosition()
--     return playerPos.x >= area.fromPosition.x and playerPos.x <= area.toPosition.x
--         and playerPos.y >= area.fromPosition.y and playerPos.y <= area.toPosition.y
--         and playerPos.z == area.fromPosition.z
-- end

-- -------------- FISHING -------------

-- function ANTIBOT:addTry(playerId)
--     local player = Player(playerId)

--     if not player then
--         return false
--     end

--     if player:getLevel() < 500 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) < 1 then
--         return false
--     end

--     if player:getLevel() < 100 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) >= 1 then
--         return false
--     end
-- -----------------------
--     local tile = Tile(player:getPosition())
--     if tile and (tile:getItemById(10145) or tile:getItemById(10146)) then
--         -- ANTIBOT:reset(playerId)
--         ANTIBOT:reset(player:getId())
--         return false
--     end

-- ---------------------
--     local target = player:getTarget()

--     if player:getStorageValue(Storage.Quest.Crandoria.PasseAntiafk) > os.time() and player:getStorageValue(Storage.Quest.Crandoria.PvpStatus.Status) > 0 then
--         ANTIBOT:reset(player:getId())
--         player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 25 * 60)
--         return false
--     end


--     if (target and target:getName() == "Training Monk") then
--         -- ANTIBOT:reset(playerId)
--         ANTIBOT:reset(player:getId())
--         player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 20 * 60)
--         return false
--     end


--     -- playerId = player:getId()

--     if not ANTIBOT.punishment.try.players[playerId] then
--         ANTIBOT.punishment.try.players[playerId] = 0
--     end

--     ANTIBOT.punishment.try.players[playerId] = ANTIBOT.punishment.try.players[playerId] + 1

--     if ANTIBOT.punishment.try.players[playerId] and ANTIBOT.punishment.try.players[playerId] >= ANTIBOT.punishment.try.max then
--         sendChannelMessage(13, TALKTYPE_CHANNEL_O, ANTIBOT.prefix .. ANTIBOT.punishment.try.reason)
--         ANTIBOT:addPunishment(playerId)
--     end
-- end

-- ANTIBOT.punishment.time.isScheduled = ANTIBOT.punishment.time.isScheduled or {}

-- function ANTIBOT:time(playerId)
--     local player = Player(playerId)
--     if not player then
--         ANTIBOT:reset(playerId)
--         -- ANTIBOT:reset(player:getId())
--         return false
--     end

--         ---------- FISHING ---------

--     if isInArea(player, area1) or isInArea(player, area2) then
--         player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 20 * 60)
--         return false
--     end

    
--         ---------- FISHING ---------
--     if player:getIp() == 0 then
--         ANTIBOT:reset(playerId)
--         player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 20 * 60)
--         return false
--     end
-- -----------------------
--     local tile = Tile(player:getPosition())
--     if tile and (tile:getItemById(10145) or tile:getItemById(10146)) then
--         ANTIBOT:reset(playerId)
--         -- ANTIBOT:reset(player:getId())
--         return false
--     end
-- ------------------------
--     local target = player:getTarget()

--     if player:getLevel() < 500 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) < 1 then
--         return false
--     end

--     if player:getLevel() < 100 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) >= 1 then
--         return false
--     end

--     if (target and target:getName() == "Training Monk") then
--         ANTIBOT:reset(playerId)
--         player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 20 * 60)
--         -- ANTIBOT:reset(player:getId())
--         return false
--     end


--     playerId = player:getId()

--     -- if not ANTIBOT.punishment.time.players[playerId] then
--     --     ANTIBOT.punishment.time.players[playerId] = 0
--     --     ANTIBOT:sendQuestions(playerId)
--     -- end

--     if player:getStorageValue(Storage.Quest.Crandoria.Antibot.Timer) < os.time() then
--         if not ANTIBOT.punishment.time.players[playerId] then
--             ANTIBOT.punishment.time.players[playerId] = 0
--             ANTIBOT:sendQuestions(playerId)
--         end
--     end

--     if ANTIBOT.punishment.time.players[playerId] and ANTIBOT.punishment.time.players[playerId] >= ANTIBOT.punishment.time.maxTime then
--         ANTIBOT:addPunishment(playerId)
--     else
--         if not ANTIBOT.punishment.time.isScheduled[playerId] then
--             ANTIBOT.punishment.time.isScheduled[playerId] = true
--             addEvent(function()
--                 if ANTIBOT.punishment.time.players[playerId] and ANTIBOT.punishment.time.players[playerId] >= 0 and ANTIBOT.punishment.time.players[playerId] < ANTIBOT.punishment.time.maxTime then
--                     ANTIBOT.punishment.time.players[playerId] = ANTIBOT.punishment.time.players[playerId] + 1
--                     player:sendCancelMessage(ANTIBOT.prefix .. ANTIBOT.messages.time:format(string.diff(ANTIBOT.punishment.time.maxTime - ANTIBOT.punishment.time.players[playerId], true)))
--                     player:say("ANTIAFK", TALKTYPE_MONSTER_SAY)
--                     local hasAntiAfkOrb = false
--                     local summons = player:getSummons()
--                     for _, summon in ipairs(summons) do
--                         if summon:getName() == "Anti Afk Orb Anti Noob" or summon:getName() == ""  then
--                             hasAntiAfkOrb = true
--                             break
--                         end
--                     end

--                     -- if ANTIBOT.punishment.time.players[playerId] > 180 then -- A CADA SEG A PARTIR DE UM TEMPO
--                     --     if (ANTIBOT.punishment.time.players[playerId] % 5 == 0) then -- A CADA 5S
--                     --         player:setStamina(player:getStamina() - 1)
--                     --     end
--                     -- end

--                     -- if not hasAntiAfkOrb then
--                     --     if player:getSkull() == SKULL_WHITE or player:getSkull() == SKULL_RED or player:getSkull() == SKULL_BLACK then
--                     --         if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
--                     --             player:teleportTo(Position(4553, 5411, 7))
--                     --         else
--                     --             player:teleportTo(Position(4934, 4974, 6))
--                     --         end
--                     --         player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--                     --         ANTIBOT:reset(playerId)
--                     --     else
--                     --         if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
--                     --             player:teleportTo(Position(4553, 5411, 7))
--                     --         else
--                     --             player:teleportTo(Position(4934, 4974, 6))
--                     --         end
--                     --         player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--                     --         ANTIBOT:reset(playerId)
--                     --     end
--                     -- end


--                     if not hasAntiAfkOrb then
--                         if player:getSkull() == SKULL_WHITE or player:getSkull() == SKULL_RED or player:getSkull() == SKULL_BLACK then
--                             if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
--                                 local addTimeValue = player:getStorageValue(Storage.Quest.Crandoria.Prison.AddTime)
--                                 local maxAddTimeValue = 21600
--                                 local calculatedAddTime = addTimeValue * 15 * 60
--                                 local enterCooldown = os.time() - player:getStorageValue(Storage.Quest.Crandoria.Prison.EnterCooldown)
--                                 local prisonTimer = player:getStorageValue(Storage.Quest.Crandoria.Prison.Timer)
--                                 local adjustedAddTime = math.min(calculatedAddTime, maxAddTimeValue)

                                
--                                 player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--                                 player:setStorageValue(Storage.Quest.Crandoria.Prison.AddTime, addTimeValue + 1)
--                                 player:setStorageValue(Storage.Quest.Crandoria.Prison.Timer, os.time() + 30 * 60 + adjustedAddTime)
--                                 player:setStorageValue(Storage.Quest.Crandoria.Prison.EnterCooldown, os.time())
--                                 if player:getSkull() == SKULL_WHITE or player:getSkull() == SKULL_RED or player:getSkull() == SKULL_BLACK then
--                                     player:teleportTo(Position(4564, 5419, 7))
--                                 else
--                                     player:teleportTo(Position(4564, 5404, 7))
--                                 end
--                             else
--                                 player:teleportTo(Position(4934, 4974, 6))
--                             end
--                             player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--                             player:setStorageValue(Storage.Quest.Crandoria.Prison.QuestionIndex, 2)
--                             ANTIBOT:reset(playerId)
--                         else
--                             if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
--                                 player:teleportTo(Position(4564, 5419, 7))
--                             else
--                                 player:teleportTo(Position(4934, 4974, 6))
--                             end
--                             player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--                             player:setStorageValue(Storage.Quest.Crandoria.Prison.QuestionIndex, 1)
--                             ANTIBOT:reset(playerId)
--                         end
--                     end




--                     -- position:sendMagicEffect(CONST_ME_POFF)
--                     ANTIBOT.punishment.time.isScheduled[playerId] = false
--                     ANTIBOT:time(playerId)
--                 else
--                     ANTIBOT.punishment.time.isScheduled[playerId] = false
--                 end
--             end, 1000)
--         end
--     end

--     if ANTIBOT.punishment.time.players[playerId] and ANTIBOT.punishment.time.players[playerId] >= ANTIBOT.punishment.time.maxTime then
--         ANTIBOT:addPunishment(playerId)
--     end

-- end


-- function ANTIBOT:sendQuestions(playerId)
--     local player = Player(playerId)

--     if not player then
--         return false
--     end
--     if player:getLevel() < 500 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) < 1 then
--         return false
--     end

--     if player:getLevel() < 100 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) >= 1 then
--         return false
--     end


--         ---------- FISHING E ARAM ---------

--     if isInArea(player, area1) or isInArea(player, area2) or isInArea(player, area3) or isInArea(player, area4) then
--         player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 20 * 60)
--         ANTIBOT:reset(playerId)
--         return false
--     end
    
--         ---------- FISHING ---------
--     if player:getIp() == 0 then
--         ANTIBOT:reset(playerId)
--         player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 20 * 60)
--         return false
--     end

--     if player:getStorageValue(Storage.Quest.Crandoria.PasseAntiafk) > os.time() then
--         ANTIBOT:reset(player:getId())
--         player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 25 * 60)
--         return false
--     end

-- 	-- ULTIMO EDIT
--     -- if player:getStorageValue(Storage.Quest.Crandoria.Antibot.Timer) >= os.time() then
--     --     ANTIBOT:reset(playerId)
--     --     return false
--     -- end

--     if player:getStorageValue(Storage.Quest.Crandoria.Antibot.Timer) >= os.time() then
--         ANTIBOT:reset(playerId)
--         return false
--     end

--     local tile = Tile(player:getPosition())
--     if tile and (tile:getItemById(10145) or tile:getItemById(10146)) then
--         ANTIBOT:reset(playerId)
--         return false
--     end

--     local target = player:getTarget()
--     if Tile(player:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) or Tile(player:getPosition()):hasFlag(TILESTATE_PVPZONE) or (target and target:getName() == "Training Monk") then
--         ANTIBOT:reset(playerId)
--         return false
--     end
--     if target then
--         if target:isPlayer() then
--             ANTIBOT:reset(playerId)
--             player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 5 * 60)
--             return false
--         else
--             if target:getType() then
--                 if target:getType():isRewardBoss() then
--                     ANTIBOT:reset(playerId)
--                     player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 5 * 60)
--                     return false
--                 end
--             end
--         end
--     end

--     if not player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
--         ANTIBOT:reset(playerId)
--         return false
--     end

--     playerId = player:getId()

--     random = math.random(#ANTIBOT.questions)

--     ANTIBOT.playerQuestion[playerId] = random
--     local resposta = 0;
--     local modeloPerguntaAleatoria = math.random(1,10);
--     local modeloPergunta = "";
--     local operacao = "monstro"-- ANTIBOT.operation[math.random(1,3)].type;
--     --local operacao = ANTIBOT.operation[math.random(1,3)].type
--     local var1 = math.random(0, 5) -- Gerando o primeiro valor aleatório
--     local var2 = math.random(0, 5) -- Gerando o segundo valor aleatório
--     local monstroAleatorio = ANTIBOT.possibleMonsters[math.random(1,8)]
--     if player:getLevel() >= 500 and player:getLevel() < 750 then
--         monstroAleatorio = ANTIBOT.possibleMonsters2[math.random(1,8)]
--     elseif player:getLevel() >= 750 and player:getLevel() < 1000 then
--         monstroAleatorio = ANTIBOT.possibleMonsters3[math.random(1,8)]
--     elseif player:getLevel() >= 1000 then
--         monstroAleatorio = ANTIBOT.possibleMonsters4[math.random(1,8)]
--     end


--     if operacao == "adicao" then
--         resposta = var1 + var2;
--         modeloPergunta = string.format(ANTIBOT.questionModelAdicao[modeloPerguntaAleatoria].titulo, var1, var2);
--     end
--     if operacao == "multiplicacao" then
--         resposta = var1 * var2;
--         modeloPergunta = string.format(ANTIBOT.questionModelMultiplicacao[modeloPerguntaAleatoria].titulo, var1, var2);
--     end
--     if operacao == "monstro" then
--         ANTIBOT.playerQuestion[playerId] = { question = "Digite o nome da criatura na qual o seu Anti Afk Orb se transformou.", staticAnswer = "true", answer = monstroAleatorio.name  }    
--     -- else
--     --     ANTIBOT.playerQuestion[playerId] = { question = modeloPergunta, staticAnswer = "true",  answer = tostring(resposta) }
--     end
    



--     local position = player:getPosition()
--     local summon = Game.createMonster("Anti Afk Orb Anti Noob", position, true, true)
--     if summon then
--         summon:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--         summon:changeSpeed(math.max(player:getSpeed() + ((player:getSpeed() / 10) + 20), 0))
--         summon:setMaster(player)
--         summon:setMaxHealth((player:getLevel() * 70) + 5000)
--         summon:setHealth((player:getLevel() * 70) + 5000)
--         if operacao == "monstro" then
--           summon:setOutfit({lookType = monstroAleatorio.looktype })
--           player:setStorageValue(Storage.Quest.Crandoria.Antibot.LookType, monstroAleatorio.looktype)
--           ANTIBOT:startLookTypeRestoreLoop(playerId)
--         end
--     end

--     player:say("ANTIAFK", TALKTYPE_MONSTER_SAY)
--     player:openChannel(12)
--     player:sendChannelMessage(player, ANTIBOT.prefix .. ANTIBOT.messages.howAnswer:format(os.date("%d")), TALKTYPE_CHANNEL_O, 12)
--     player:sendChannelMessage(player, ANTIBOT.prefix .. ANTIBOT.playerQuestion[playerId].question, TALKTYPE_CHANNEL_O, 12)
--     -- player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + (60 - ((player:getLevel() / 50) + (player:getStamina() / 300))) * 60)
--     -- player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 2 * 60)
--     -- addEvent(sendChannelMessage, 500, 12, TALKTYPE_CHANNEL_O, ANTIBOT.prefix .. ANTIBOT.messages.howAnswer:format(os.date("%d")))
--     -- addEvent(sendChannelMessage, 800, 12, TALKTYPE_CHANNEL_O, ANTIBOT.prefix .. ANTIBOT.playerQuestion[playerId].question)
-- end

-- -- OTIMIZAÇÃO: Removido loop recursivo infinito que causava memory leak
-- -- O outfit é restaurado apenas uma vez quando necessário
-- function ANTIBOT:startLookTypeRestoreLoop(playerId)
--     local player = Player(playerId)
--     if not player then
--         return
--     end
    
--     local playerSummons = player:getSummons()
--     for _, summon in ipairs(playerSummons) do
--         if summon:getName() == "Anti Afk Orb Anti Noob" then
--             local lookTypeMonster = player:getStorageValue(Storage.Quest.Crandoria.Antibot.LookType)
--             if lookTypeMonster and lookTypeMonster > 0 then
--                 summon:setOutfit({ lookType = lookTypeMonster })
--             end
--             break
--         end
--     end
-- end

-- function ANTIBOT:reset(playerId)
--     ANTIBOT.punishment.try.players[playerId] = nil
--     ANTIBOT.punishment.time.players[playerId] = nil
--     ANTIBOT.playerQuestion[playerId] = nil
-- end

-- -- OTIMIZAÇÃO: Função helper para teleportar jogador e aplicar punição
-- local function applyPunishment(player, questionIndex)
--     local isCitizen = player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1
    
--     if isCitizen then
--         local addTimeValue = player:getStorageValue(Storage.Quest.Crandoria.Prison.AddTime)
--         local calculatedAddTime = addTimeValue * 15 * 60
--         local adjustedAddTime = math.min(calculatedAddTime, 21600)
        
--         local position = questionIndex == 2 and Position(4564, 5419, 7) or Position(4564, 5404, 7)
--         player:teleportTo(position)
--         player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--         player:setStorageValue(Storage.Quest.Crandoria.Prison.AddTime, addTimeValue + 1)
--         player:setStorageValue(Storage.Quest.Crandoria.Prison.Timer, os.time() + 30 * 60 + adjustedAddTime)
--         player:setStorageValue(Storage.Quest.Crandoria.Prison.EnterCooldown, os.time())
--     else
--         player:teleportTo(Position(4934, 4974, 6))
--         player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--     end
    
--     player:setStorageValue(Storage.Quest.Crandoria.Prison.QuestionIndex, questionIndex)
--     player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickPrison, os.time() + 24 * 60 * 60)
-- end

-- function ANTIBOT:addPunishment(playerId)
--     local player = Player(playerId)
--     if not player then
--         return false
--     end

--     playerId = player:getId()

--     local accountId = getAccountNumberByPlayerName(player:getName())
--     if accountId == 0 then
--         return false
--     end

--     local timeNow = os.time()
--     local hasSkull = player:getSkull() == SKULL_WHITE or player:getSkull() == SKULL_RED or player:getSkull() == SKULL_BLACK
--     local isHighLevel = player:getLevel() > 100


--     -- OTIMIZAÇÃO: Refatorado código duplicado usando função helper
--     -- Cachear getSummons() uma única vez
--     local summons = player:getSummons()
    
--     if ANTIBOT.punishment.try.players[playerId] and ANTIBOT.punishment.try.players[playerId] >= ANTIBOT.punishment.try.max and isHighLevel then
--         if hasSkull then
--             applyPunishment(player, 2)
--         else
--             applyPunishment(player, 1)
--         end
--     elseif ANTIBOT.punishment.time.players[playerId] and ANTIBOT.punishment.time.players[playerId] >= ANTIBOT.punishment.time.maxTime and isHighLevel then
--         if hasSkull then
--             applyPunishment(player, 2)
--         else
--             applyPunishment(player, 1)
--         end
--     end

--     -- Remover Anti Afk Orb
--     for _, summon in ipairs(summons) do
--         if summon:getName() == "Anti Afk Orb Anti Noob" or summon:getName() == "" then
--             summon:remove()
--             player:setStorageValue(Storage.Quest.Crandoria.Antibot.LookType, 0)
--         end
--     end

--     ANTIBOT:reset(playerId)
--     -- ANTIBOT:reset(player:getId())
--     -- player:save()
--     player:getPosition():sendMagicEffect(CONST_ME_POFF)
--     player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 30 * 60)
--     -- player:remove()
-- end