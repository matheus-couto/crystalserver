local internalNpcName = "Lysandra Mirandis"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 929,
	lookHead = 115,
	lookBody = 94,
	lookLegs = 78,
	lookFeet = 114,
	lookAddons = 3
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
    npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
    npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
    npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
    npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
    npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
    npcHandler:onCloseChannel(npc, creature)
end

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

    local knight = player:getVocation():getBaseId() == VOCATION.BASE_ID.KNIGHT
    local paladin = player:getVocation():getBaseId() == VOCATION.BASE_ID.PALADIN
    local monk = player:getVocation():getBaseId() == VOCATION.BASE_ID.MONK
    local druid = player:getVocation():getBaseId() == VOCATION.BASE_ID.DRUID
    local sorcerer = player:getVocation():getBaseId() == VOCATION.BASE_ID.SORCERER
    local baseVocation = Vocation(VOCATION.ID.NONE)

    local level = player:getLevel()

    local storage = math.max(0, player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Geral))
    local storageSorte = math.max(0, player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.LuckLevel))
    local storageTenacidade = math.max(0, player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.LifeLevel))
    local storageMagia = math.max(0, player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.ManaLevel))
    local storageRep = math.max(0, player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.RepLevel))

    local maxHeatlh = 150 + (level * player:getVocation():getHealthGain())
    local newHealth = maxHeatlh * (1 + (0.02 * (storageTenacidade + 1)))

    local maxMana = 55 + (level * player:getVocation():getManaGain())
    local newMana = maxMana * (1 + (0.02 * (storageMagia + 1)))

    if storage < 1 then
        storage = 0
    end

    local pontos = math.floor(level / 50) - storage


    if MsgContains(message, "evoluir") or MsgContains(message, "evolute") then
        if level < 100 then
            npcHandler:say("Sinto muito, mas voce nao possui forca o suficiente para aprimorar seus poderes. Retorne apos atingir o nivel 100.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        else
            if pontos >= 1 then
                npcHandler:say("A cada 50 niveis alcancados voce podera adicionar um ponto da Arvore de Habiliades para aprimorar seus poderes. \z
                Para checar se voce possui pontos disponiveis para evoluir, voce pode utilizar o comando !pontos. Voce tambem precisara de um Livro Sagrado para cada ponto. \z
                Voce pode usar seus pontos para evoluir em {resiliencia}, {magia}, {sorte} e {reputacao}. Qual voce prefere?", npc, creature)
                npcHandler:setTopic(playerId, 1)
            else
                npcHandler:say("Voce nao possui pontos disponiveis. Evolua um pouco mais e retorne depois, jovem.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "resiliencia") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Com mais Resiliencia voce conseguira treinar suas habilidades de combate com mais afinco. Cada ponto de resiliencia concede +0.5% de bonus na velocidade do treino de skills com exercise weapons. \z
            Voce pode obter ate 10 pontos de Reliciencia, ou +5% de bonus para treino de skills.", npc, creature)
            npcHandler:setTopic(playerId, 2)
        end
    elseif MsgContains(message, "magia") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Com aumento de Magia voce conseguira treinar seu Magic Level de forma mais eficaz. Cada ponto de Magia concede +0.5% de bonus na velocidade do treino de Magic Level com exercise weapons. \z
            Voce pode obter ate 10 pontos de Magia, ou +5% de bonus para treino de Magic Level.", npc, creature)
            npcHandler:setTopic(playerId, 3)
        end
    elseif MsgContains(message, "sorte") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Cada ponto de Sorte fornece um aumento de 1% na sua taxa de loot, com maximo de 5 pontos acumulados ou +5% de taxa de loot. \z
            A sorte tambem pode influenciar nas chances de obtencao de recursos em sistemas de coleta. Deseja utilizar um ponto para aumentar sua Sorte?", npc, creature)
            npcHandler:setTopic(playerId, 4)
        end
    elseif MsgContains(message, "rep") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Cada ponto usado em Reputacao aumenta sua reputacao em +25 instantaneamente. Nao ha limite para quantos pontos podem ser usados. \z
            Apesar disso, voce nao pode usar essa opcao caso voce tenha 500 pontos ou mais de reputacao. Deseja utilizar um ponto para aumentar sua Reputacao?", npc, creature)
            npcHandler:setTopic(playerId, 5)
        end
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
        if npcHandler:getTopic(playerId) == 2 then
            if storageTenacidade < 5 then
                if player:removeItem(25745, 1) then
                    player:setStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.LifeLevel, storageTenacidade + 1)
                    player:setStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Geral, storage + 1)
                    updateArvoreDeForcaCache(player)
                    npcHandler:say("Muito bem, que assim seja! Voce recebeu +1 ponto em Tenacidade.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                else
                    npcHandler:say("Voce precisa de um Livro Sagrado para o ritual.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                end
            else
                npcHandler:say("Voce ja adicionou o maximo de pontos de Tenacidade.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 3 then
            if storageTenacidade < 5 then
                if player:removeItem(25745, 1) then
                    player:setStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.ManaLevel, storageMagia + 1)
                    player:setStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Geral, storage + 1)
                    updateArvoreDeForcaCache(player)
                    npcHandler:say("Muito bem, que assim seja! Voce recebeu +1 ponto em Magia.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                else
                    npcHandler:say("Voce precisa de um Livro Sagrado para o ritual.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                end
            else
                npcHandler:say("Voce ja adicionou o maximo de pontos de Magia.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 4 then
            if storageSorte < 5 then
                if player:removeItem(25745, 1) then
                    player:setStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.LuckLevel, storageSorte + 1)
                    player:setStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Geral, storage + 1)
                    updateArvoreDeForcaCache(player)
                    npcHandler:say("Muito bem, que assim seja! Voce recebeu +1 ponto de Sorte.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                else
                    npcHandler:say("Voce precisa de um Livro Sagrado para o ritual.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                end
            else
                npcHandler:say("Voce ja adicionou o maximo de pontos de Sorte.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 5 then
            if storageRep <= 500 then
                if player:removeItem(25745, 1) then
                    player:setStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Geral, storage + 1)
                    player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 25)
                    updateArvoreDeForcaCache(player)
                    player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                    npcHandler:say("Muito bem, que assim seja! Por sacrificar 1 valioso ponto, voce recebeu +25 pontos de Reputacao.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                else
                    npcHandler:say("Voce precisa de um Livro Sagrado para o ritual.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                end
            else
                npcHandler:say("Sua reputacao ja esta num nivel muito elevado.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    end
end

npcConfig.shop = {	-- Sellable items
	{ itemName = "livro sagrado", clientId = 25745, buy = 500000 },
    { itemName = "livro sagrado", clientId = 25745, sell = 10000 }
}

-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType)
end

npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. Fale comigo se voce busca {evoluir} sua forca com sua experiencia de batalha ou {alternar} entre spells da Wheel of Destiny.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais! Volte quando quiser usar a forja.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)






