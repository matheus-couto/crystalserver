local internalNpcName = "Ginger Floyd"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 432,
	lookHead = 94,
	lookBody = 23,
	lookLegs = 75,
	lookFeet = 26,
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

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

    local storage = player:getStorageValue(Storage.Quest.Crandoria.NilluxQuest.Progresso)
    local storageTimer = player:getStorageValue(Storage.Quest.Crandoria.NilluxQuest.Timer)
    local storageTimerPotion = player:getStorageValue(Storage.Quest.Crandoria.NilluxQuest.TimerPotion)
    local timeLeft = math.floor((player:getStorageValue(Storage.Quest.Crandoria.NilluxQuest.Timer) - os.time()) / 60)

    if MsgContains(message, "nillux") then
        if storage == 6 then
            npcHandler:say("Ah! Mais um curioso... Escute, vou dizer a mesma coisa que eu digo a todo mundo. Primeiramente, essa pocao possui duracao de apenas 15 dias. \z
            Outra coisa: Voce quer uma pocao? Tera que pagar por ela. E nao sera barato! Eu sei o valor do meu trabalho como melhor alquimista do Novo Continente. \z
            Alem disso, voce tera que trazer todos os ingredientes. Nao tem conversa, esse sera o combinado. Entendido?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        elseif storage == 7 then
            if storageTimer > os.time() then
                npcHandler:say("Preciso preparar todos os meus equipamentos antes de produzir uma nova pocao, caso contrario pode haver alguma contaminacao. \z
                Preciso de pelo menos uma semana entre cada producao. Por favor, aguarde por mais "..timeLeft.." minutos para que eu possa fazer outra Nillux..", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Cada pocao custara 10 Gold Tokens, alem dos segunites ingredientes: 5 Coral Branches, 25 Demonic Essences, 1 Grimace e 3 Crawler's Essence. Voce tem tudo com voce?", npc, creature)
                npcHandler:setTopic(playerId, 2)
            end
        elseif storage == 8 then
            if storageTimerPotion > os.time() then
                npcHandler:say("Que pressa! Tenha calma, eu disse que preciso de 5 minutos. Estou quase la.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                player:addItem(28495, 1)
                player:setStorageValue(Storage.Quest.Crandoria.NilluxQuest.Progresso, 7)
                player:setStorageValue(Storage.Quest.Crandoria.NilluxQuest.Timer, os.time() + 7 * 24 * 60 * 60)
                npcHandler:say("Aqui esta. Apesar de ser rapido esse processo acaba com meus equipamentos. Preciso de uma semana para refazer e organizar alguns deles.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Certo. Agora que resolvemos isso, vamos ao valor e aos ingredientes. Cada pocao custara 10 Gold Tokens, alem dos segunites ingredientes: \z
            5 Coral Branches, 25 Demonic Essences, 1 Grimace e 3 Crawler's Essence. Voce tem tudo com voce?", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.NilluxQuest.Progresso, 7)
            npcHandler:setTopic(playerId, 2)
        elseif npcHandler:getTopic(playerId) == 1 then
            if player:getItemCount(22721) >= 10 and player:getItemCount(39406) >= 5 and player:getItemCount(6499) >= 25 and player:getItemCount(32593) >= 1 and player:getItemCount(33982) >= 3 then
                player:removeItem(39406, 5)
                player:removeItem(6499, 25)
                player:removeItem(32593, 1)
                player:removeItem(33982, 3)
                player:removeItem(22721, 10)
                npcHandler:say("Muito bem. Trato feito! Me chame em 5 minutos. Irei produzir sua pocao agora mesmo.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.NilluxQuest.TimerPotion, os.time() + 5 * 60)
                player:setStorageValue(Storage.Quest.Crandoria.NilluxQuest.Progresso, 8)
                npcHandler:setTopic(playerId, 0)
            end
        end
    end
end

npcHandler:setMessage(MESSAGE_GREET, "Ola, jovem alma. Voce gostaria de trabalhar com um pouco de {alquimia}?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
