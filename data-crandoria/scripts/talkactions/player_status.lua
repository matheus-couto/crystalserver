local playerStatus = TalkAction("!checkplayer")

-- Skull names
local skullNames = {
    [SKULL_NONE]   = "Nenhuma",
    [SKULL_WHITE]  = "White",
    [SKULL_YELLOW] = "Yellow",
    [SKULL_GREEN]  = "Green",
    [SKULL_ORANGE] = "Orange",
    [SKULL_RED]    = "Red",
    [SKULL_BLACK]  = "Black"
}

local function getReputationRank(points)
    if points >= 1000 then
        return "Singular"
    elseif points >= 500 then
        return "Admiravel"
    elseif points >= 275 then
        return "Nobre"
    elseif points >= 175 then
        return "Ilustre"
    elseif points >= 100 then
        return "Respeitavel"
    elseif points >= 50 then
        return "Confiavel"
    elseif points >= 25 then
        return "Notavel"
    elseif points >= 10 then
        return "Amigavel"
    else
        return "Indigente"
    end
end

-------------------------------------------------
-- TEXTOS
-------------------------------------------------
local function getGeneralText(target)
    local vipText = (target:getVipDays() > 0) and "Sim" or "Nao"

    -- local factionText = "Nenhuma"
    -- if target:getStorageValue(Storage.Quest.Crandoria.CrandoriaFactions.HelioxMember) == 1 then
    --     factionText = "Heliox"
    -- elseif target:getStorageValue(Storage.Quest.Crandoria.CrandoriaFactions.ArataxMember) == 1 then
    --     factionText = "Aratax"
    -- end

    local skullText = skullNames[target:getSkull()] or "Nenhuma"

    local bounty = target:getStorageValue(Storage.Quest.Crandoria.PvpStatus.Bounty)
    local bountyText = (bounty and bounty > 0) and bounty or "Nao"

    local tree = target:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Geral)
    local treeText = (tree and tree > 0) and tree or "Zero"

    -- local hardcore = target:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen)
    -- local hardcoreText = (hardcore and hardcore < 1) and "Nao" or "Sim"

    local rep = target:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)

    local rank = getReputationRank(rep)

    local resetStorage = target:getStorageValue(Storage.Quest.Crandoria.Reset.Count)
    local resets = resetStorage > 0 and resetStorage or 0

    return
        "Nome: " .. target:getName() .. "\n" ..
        "Reputacao: " .. rank .. "\n" ..
        "Level: " .. target:getLevel() .. "\n" ..
        "Resets: " .. resets .. "\n" ..
        "VIP: " .. vipText .. "\n" ..
        -- "Hardcore: " .. hardcoreText .. "\n" ..
        -- "Faccao: " .. factionText .. "\n" ..
        "Skull: " .. skullText .. "\n" ..
        "Recompensa: " .. bountyText .. "\n\n" ..

        "Status:\n" ..
        "Vida: " .. target:getMaxHealth() .. "\n" ..
        "Mana: " .. target:getMaxMana() .. "\n" ..
        "Pontos de Arvore: " .. treeText
end

local function getAccessText(target)
    local text = ""

    text = text .. "Altar de Encantamento: " ..
        ((target:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) >= 27) and "Liberado" or "Nao") .. "\n"

    text = text .. "Captain Donahue: " ..
        ((target:getStorageValue(Storage.Quest.Crandoria.CaptainDonahue.Treasure) >= 1) and "Liberado" or "Nao") .. "\n"

    text = text .. "Dragon Pack: " ..
        ((target:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso) >= 11) and "Liberado" or "Nao") .. "\n"

    text = text .. "Forja de Kradok: " ..
        ((target:getStorageValue(Storage.Quest.Crandoria.ForgeSystem.Door) >= 2) and "Liberado" or "Nao") .. "\n"

    text = text .. "Lost Island: " ..
        ((target:getStorageValue(Storage.Quest.Crandoria.AstralisTales.Progresso) >= 2) and "Liberado" or "Nao") .. "\n"

    text = text .. "Teleports Globais: " ..
        ((target:getStorageValue(Storage.Quest.Crandoria.WorldTeleports.Access) >= 1) and "Liberado" or "Nao") .. "\n"

    local tpstorage = target:getStorageValue(Storage.Quest.Crandoria.TeleportRoom.Progresso)
    text = text .. "Teleport Room: " ..
        ((tpstorage < 3 and "Area I") or ((tpstorage >= 3 and tpstorage < 7) and "Areas I e II") or ((tpstorage >= 3 and tpstorage < 7) and "Areas I a III") or (tpstorage == 7 and "Areas I a IV") or (tpstorage >= 8 and "Acesso Total")) .. "\n"

    -- text = text .. "Teleport Runes: " ..
    --     ((target:getStorageValue(Storage.Quest.Crandoria.TeleportRune.Progresso) >= 3) and "Liberado" or "Nao") .. "\n"

    text = text .. "Transmutacao: " ..
        ((target:getStorageValue(Storage.Quest.Crandoria.WarlocksConspiracy.Reward) >= 1) and "Liberado" or "Nao") .. "\n"

    text = text .. "True Asuras Palace: " ..
        ((target:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret) >= 2) and "Liberado" or "Nao") .. "\n"

    text = text .. "Scarlett Etzel: " ..
        ((target:getStorageValue(Storage.AccessBoss.ScarlettAccess) >= 2) and "Liberado" or "Nao") .. "\n"

    text = text .. "Drume: " ..
        ((target:getStorageValue(Storage.AccessBoss.DrumeAccess) >= 2) and "Liberado" or "Nao") .. "\n"

    text = text .. "Grand Master Oberon: " ..
        ((target:getStorageValue(Storage.AccessBoss.OberonAccess) >= 2) and "Liberado" or "Nao") .. "\n"

    text = text .. "Court Warlock: " ..
        ((target:getStorageValue(Storage.Quest.Crandoria.StagBastion.TeleportCourtWarlock) >= 2) and "Liberado" or "Nao")

    return text
end

local function getQuestText(target)
    local text = ""

    text = text .. "Ajudando Alice: " ..
        ((target:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) >= 17) and "Sim" or "Nao") .. "\n"

    text = text .. "Annihilator: " ..
        (((target:getStorageValue(6085) >= 1)
        or (target:getStorageValue(6086) >= 1)
        or (target:getStorageValue(6087) >= 1)
        or (target:getStorageValue(6088) >= 1)) and "Sim" or "Nao") .. "\n"

    text = text .. "Bloody Tusks: " ..
        ((target:getStorageValue(Storage.Quest.U15_10.BloodyTusks.Questline) >= 7) and "Sim" or "Nao") .. "\n"

    -- local haldor = target:getStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso)
    -- text = text .. "Caminho de Ferro: " ..
    --     (((haldor and haldor >= 1 and haldor < 35) and ("Missao " .. haldor)) or ((haldor and haldor >= 35) and "Concluido") or "Nao iniciado") .. "\n"

    local crassus = target:getStorageValue(12699)
    text = text .. "Def. de Crandoria: " ..
        ((crassus and crassus >= 1) and ("Etapa " .. crassus) or "Nao iniciada") .. "\n"

    text = text .. "Demon Helmet: " ..
        ((target:getStorageValue(6030) >= 1) and "Sim" or "Nao") .. "\n"

    text = text .. "Demon Oak: " ..
        ((target:getStorageValue(Storage.Quest.U8_2.TheDemonOak.Done) >= 3) and "Sim" or "Nao") .. "\n"

    text = text .. "Inquisition: " ..
        ((target:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Reward) >= 1) and "Sim" or "Nao") .. "\n"

    text = text .. "No Rest for the Wicked: " ..
        ((target:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Questlog) >= 1) and "Sim" or "Nao") .. "\n"

    text = text .. "O Falso Deus: " ..
        ((target:getStorageValue(Storage.Quest.Crandoria.TheFalseGod.Progresso) >= 9) and "Sim" or "Nao") .. "\n"

    text = text .. "Primal Ordeal: " ..
        ((target:getStorageValue(Storage.Quest.U12_90.PrimalOrdeal.Bosses.ThePrimalMenaceKilled) >= 1) and "Sim" or "Nao") .. "\n"

    text = text .. "Red Path: " ..
        ((target:getStorageValue(Storage.Quest.Crandoria.TheRedPath.Outfit) >= 3) and "Sim" or "Nao") .. "\n"

    text = text .. "Rotten Blood: " ..
        ((target:getStorageValue(Storage.Quest.Crandoria.RottenBloodQuest.BakragoreKilled) >= 1) and "Sim" or "Nao") .. "\n"
    
    text = text .. "Segredo das Asuras: " ..
        ((target:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.Reward) >= 3) and "Sim" or "Nao") .. "\n"

    text = text .. "Soul War: " ..
        ((target:getStorageValue(Storage.Quest.U12_40.SoulWar.QuestReward) >= 1) and "Sim" or "Nao") .. "\n"

    text = text .. "The First Dragon: " ..
        ((target:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso) >= 11) and "Sim" or "Nao") .. "\n"

    text = text .. "Upsidedown Pyramide: " ..
        ((target:getStorageValue(12067) >= 1) and "Sim" or "Nao") .. "\n"

    text = text .. "Wrath of Emperor: " ..
        ((target:getStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission12) >= 1) and "Sim" or "Nao")

    return text
end

-------------------------------------------------
-- JANELAS
-------------------------------------------------
local function sendMainWindow(player, target)
    local window = ModalWindow{
        title = "Informacoes do Jogador",
        message = getGeneralText(target)
    }

    window:addButton("Quests", function()
        sendQuestWindow(player, target)
    end)

    window:addButton("Acessos", function()
        sendAccessWindow(player, target)
    end)

    window:addButton("Ok")
    window:sendToPlayer(player)
end

function sendQuestWindow(player, target)
    local window = ModalWindow{
        title = "Quests",
        message = getQuestText(target)
    }

    window:addButton("Voltar", function()
        sendMainWindow(player, target)
    end)

    window:sendToPlayer(player)
end

function sendAccessWindow(player, target)
    local window = ModalWindow{
        title = "Acessos",
        message = getAccessText(target)
    }

    window:addButton("Voltar", function()
        sendMainWindow(player, target)
    end)

    window:sendToPlayer(player)
end

-------------------------------------------------
-- COMANDO
-------------------------------------------------
function playerStatus.onSay(player, words, param)
    if param == "" then
        player:sendCancelMessage("Use: !checkplayer nome do jogador")
        return true
    end

    local target = Player(param)
    if not target then
        player:sendCancelMessage("Este jogador nao esta online.")
        return true
    end

    sendMainWindow(player, target)
    return true
end

playerStatus:separator(" ")
playerStatus:groupType("normal")
playerStatus:register()
