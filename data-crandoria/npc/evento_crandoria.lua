local internalNpcName = "Bem Vindo ao CrandoriaOT"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 1252,
	lookHead = 33,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
    	lookAddons = 3,
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

local accessedIPs = {}

local function creatureSayCallback(npc, creature, type, message)



    local player = Player(creature)
    local playerId = player:getId()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

    if MsgContains(message, "jornada") or MsgContains(message, "missao") or MsgContains(message, "mission") then
        if accessedIPs[playerIP] and accessedIPs[playerIP] ~= player:getGuid() then
            npcHandler:say("Voce so pode realizar essa missao com um personagem.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        else
            if player:getStorageValue(Storage.Quest.Crandoria.BemVindoQuest.Progresso) < 1 then
                npcHandler:say("Sua jornada nao sera longa, mas vai te fornecer uma boa recompensa e possibilitar que voce conheca melhor o Novo Continente, onde Crandoria e outras cidades se encontram. \z
                Esta pronto para iniciar?", npc, creature)
                npcHandler:setTopic(playerId, 1)
            elseif player:getStorageValue(Storage.Quest.Crandoria.BemVindoQuest.Progresso) == 1 or player:getStorageValue(Storage.Quest.Crandoria.BemVindoQuest.Progresso) == 2 then
                npcHandler:say("Voce trouxe as 10 meats?", npc, creature)
                npcHandler:setTopic(playerId, 2)
            elseif player:getStorageValue(Storage.Quest.Crandoria.BemVindoQuest.Progresso) == 3 then
                npcHandler:say("Sua proxima missao sera conhecer melhor o Bill Looter, o principal comprador de loots de Crandoria. Mas voce nao ira de maos vazias. Voce devera conseguir uma Scale Armor e levar para ele. \z
                Quando conseguir a armadura, leve ate Bill e diga 'loot'. Sua loja fica a leste (direita) do templo. Voce podera dropar uma Scale Armor no cemiterio a oeste da cidade ou pela Tp Room.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.BemVindoQuest.Progresso, 4)
                npcHandler:setTopic(playerId, 0)
            elseif player:getStorageValue(Storage.Quest.Crandoria.BemVindoQuest.Progresso) == 4 then
                npcHandler:say("Leve uma Scale Armor para Bill, o comprador de Loot. Depois retorne ate mim.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            elseif player:getStorageValue(Storage.Quest.Crandoria.BemVindoQuest.Progresso) == 5 then
                npcHandler:say("Muito bem. Provavelmente agora voce ja conhece Crandoria um pouco melhor. Sua proxima missao sera conhecer as principais cidades do Novo Continente: Elvenshire, Hakata, Valkesh, Anvillux e Icehold. \z
                No templo de cada uma dessas cidades ha um bau de madeira que voce podera abrir para obter uma recompensa. Apos passar por todas as cidades e abrir os baus, retorne ate mim. \z
                As cidades podem ser acessadas pelo tapete magico, que fica sobre o portao norte de Crandoria, ou pelo barco do Captain Whitepatch, localizado na praia ao sul do templo. Espero por voce.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.BemVindoQuest.Progresso, 6)
                npcHandler:setTopic(playerId, 0)
            elseif player:getStorageValue(Storage.Quest.Crandoria.BemVindoQuest.Progresso) == 6 then
                npcHandler:say("Abra os baus localizados nos templos das cidades de Valkesh (barco), Elvenshire (barco), Icehold (barco), Hakata (barco) e Anvillux (tapete). Retorne quando os 5 baus forem abertos.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            elseif player:getStorageValue(Storage.Quest.Crandoria.BemVindoQuest.Progresso) == 7 then
                npcHandler:say("Muito bem! Agora que voce conhece melhor o Novo Continente, esta pronto para sua jornada. Procure por Comandante Crassus, no templo. Ele te dara varias missoes e recompensas. \z
                E como ultima recompensa de boas vindas, vou completar sua Stamina e te entregar mais um puco de gold que te ajudara nesse inicio. Aqui esta.", npc, creature)
                player:setStamina(2520)
                player:addItem(3035, 50)
                player:setStorageValue(Storage.Quest.Crandoria.BemVindoQuest.Progresso, 8)
                npcHandler:setTopic(playerId, 0)
            elseif player:getStorageValue(Storage.Quest.Crandoria.BemVindoQuest.Progresso) == 8 then
                npcHandler:say("Voce ja finalizou suas missoes de boas vindas.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Maravilha! Para comecar, preciso de um pouco de carne. Traga-me 10 meats. Voce pode obte-las derrotando rotworms nos esgotos, ou pode encontrar Frodo, na loja de alimentos. \z
            Se encontrar Frodo, basta dizer 'carne' e ele te dara as 10 meats sem custo algum. Estarie esperando.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.BemVindoQuest.Progresso, 1)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getItemCount(3577) >= 10 then
                player:removeItem(3577, 10)
                player:addExperience(3000)
                player:addItem(3035, 5)
                npcHandler:say("Otimo! Essa carne sera suficiente para o jantar de inauguracao de hoje. Aqui, pegue sua primeira recompensa. Quando estiver pronto, ja tenho uma nova {missao} para voce!", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.BemVindoQuest.Progresso, 3)
                accessedIPs[playerIP] = player:getGuid()
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao esta com toda a carne que pedi. Preciso de 10 meats.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) and npcHandler:getTopic(playerId) == 1 then
        npcHandler:say("Sem problemas.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Apenas durante a inauguracao do CrandoriaOT, voce tera a chance de participar de uma {jornada}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais. E seja bem vindo!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
