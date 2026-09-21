-- CRANDORIA EDIT -- NEW --
CrandoriaTaskSystem = {}

function CrandoriaTaskSystem.onKill(player, raceId)
    CrandoriaTaskSystem.processBattlePass(player, raceId)
    CrandoriaTaskSystem.processHaldorQuests(player, raceId)
    CrandoriaTaskSystem.processGerardTask(player, raceId)
    CrandoriaTaskSystem.processHolttenQuest(player, raceId)
end


-- Storages do Battle Pass
local storageProgress = Storage.Quest.Crandoria.PasseDeBatalha.Progresso
local storageHunt = Storage.Quest.Crandoria.PasseDeBatalha.Hunt
local storageHuntCount = Storage.Quest.Crandoria.PasseDeBatalha.HuntCount

local battlePassStages = {
    [2] = { amount = 1000 },
    [6] = { amount = 1000 },
    [10] = { amount = 1000 },
    [14] = { amount = 1500 },
    [23] = { amount = 2500 }
}

function CrandoriaTaskSystem.processBattlePass(player, raceId)


    local progress = player:getStorageValue(storageProgress)

    local stage = battlePassStages[progress]
    if not stage then
        return
    end

    local required = stage.amount

    local hunt = player:getStorageValue(storageHunt)

    if hunt ~= raceId then
        return
    end

    local count = math.max(0, player:getStorageValue(storageHuntCount))
    count = count + 1

    player:setStorageValue(storageHuntCount, count)

    player:sendTextMessage(
        MESSAGE_STATUS_SMALL,
        string.format("[Battle Pass] %d/%d", count, required)
    )

    if count >= required then
        player:setStorageValue(storageProgress, player:getStorageValue(storageProgress) + 1)

        player:sendTextMessage(
            MESSAGE_EVENT_ADVANCE,
            "Voce concluiu a missao do Passe de Batalha! Retorne ao NPC para receber sua recompensa."
        )
    end
end

-- Storages Haldor Tasks

local storageProgressHaldor = Storage.Quest.Crandoria.Viridia.Haldor.Progresso
local raceIdHaldor = Storage.Quest.Crandoria.Estacoes.QuestPrimaveraRaceId
local countHaldor = Storage.Quest.Crandoria.Estacoes.QuestPrimaveraCount


local haldorQuests = {
    [2] = { amount = 25 },
    [6] = { amount = 50 },
    [16] = { amount = 100 },
}

function CrandoriaTaskSystem.processHaldorQuests(player, raceId) -- Haldor
    local progressHaldor = player:getStorageValue(storageProgressHaldor)

    local stage = haldorQuests[progressHaldor]
    if not stage then
        return
    end

    local required = stage.amount

    local hunt = player:getStorageValue(raceIdHaldor)

    if hunt ~= raceId then
        return
    end

    local count = math.max(0, player:getStorageValue(countHaldor))
    count = count + 1

    player:setStorageValue(countHaldor, count)

    player:sendTextMessage(
        MESSAGE_STATUS_SMALL,
        string.format("[Haldor Quest] %d/%d", count, required)
    )

    if count >= required then
        player:setStorageValue(storageProgressHaldor, player:getStorageValue(storageProgressHaldor) + 1)

        player:sendTextMessage(
            MESSAGE_EVENT_ADVANCE,
            "Voce concluiu a missao. Fale com o Almirante Haldor."
        )
    end
end

-- Storages Gerard Task

local storageProgressGerard = Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Progresso
local raceIdGerard = Storage.Quest.Crandoria.Estacoes.QuestPrimaveraRaceId
local countGerard = Storage.Quest.Crandoria.Estacoes.QuestPrimaveraCount

local gerardTask = {
    [1] = { amount = 1000 },
}

function CrandoriaTaskSystem.processGerardTask(player, raceId)

    local progressGerard = player:getStorageValue(storageProgressGerard)

    local stage = gerardTask[progressGerard]
    if not stage then
        return
    end

    local required = stage.amount

    local hunt = player:getStorageValue(raceIdGerard)

    if hunt ~= raceId then
        return
    end

    local count = math.max(0, player:getStorageValue(countGerard))
    count = count + 1

    if player:getStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Timer) > os.time() then

        player:setStorageValue(countGerard, count)

        player:sendTextMessage(
            MESSAGE_STATUS_SMALL,
            string.format("[Task Gerard] %d/%d", count, required)
        )

        if count >= required then
            player:setStorageValue(storageProgressGerard, player:getStorageValue(storageProgressGerard) + 1)

            player:sendTextMessage(
                MESSAGE_EVENT_ADVANCE,
                "Voce concluiu a tarefa de Gerard."
            )
        end
    else
        player:sendTextMessage(
            MESSAGE_EVENT_ADVANCE,
            "O tempo da missao esgotou. Fale com Gerard novamente."
        )
    end
end

local holttenStorage = {
    day = Storage.Quest.Crandoria.QuestHoltten.Dia,
    count = Storage.Quest.Crandoria.QuestHoltten.Contagem,
    total = Storage.Quest.Crandoria.QuestHoltten.ContagemTotal,
    race = Storage.Quest.Crandoria.QuestHoltten.MonsterRace
}

function CrandoriaTaskSystem.processHolttenQuest(player, raceId)

    local now = os.date("*t")
    local day = now.day

    local playerDay = player:getStorageValue(holttenStorage.day)

    -- Jogador não possui missão hoje
    if playerDay ~= day then
        return
    end

    local monsterRace = player:getStorageValue(holttenStorage.race)

    -- Monstro morto não é o da missão
    if monsterRace ~= raceId then
        return
    end

    local count = math.max(0, player:getStorageValue(holttenStorage.count))
    local total = player:getStorageValue(holttenStorage.total)

    if count >= total then
        return
    end

    count = count + 1

    player:setStorageValue(holttenStorage.count, count)

    player:sendTextMessage(
        MESSAGE_STATUS_SMALL,
        string.format("[Holtten Quest] %d/%d", count, total)
    )

end

-- function CrandoriaTaskSystem.processDailyTasks(player, raceId)
-- end