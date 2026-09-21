local internalNpcName = "Naga Queen"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookTypeEx = 38266,
	lookHead = 0,
	lookBody = 114,
	lookLegs = 84,
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

    if MsgContains(message, "missao") or MsgContains(message, "mission") then
        if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 22 then
            npcHandler:say("Entao era voce o humano de quem meus bravos suditos estavam falando? Voce nao me parece tao forte e capaz como dizem. Que favor fez a eles? \z
            Com certeza foram tarefas muito faceis... Eu posso te conceder capacidades alem do imaginavel, SE... voce provar o seu valor. Mas voce parece meio perdido... \z
            E agora? Veio ate mim em busca de uma nova missao? Acha mesmo que esta preparado para os desafios que tenho a oferecer?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 23 then
            npcHandler:say("O bau possui um tamanho reduzido, vermelho e estara no lado norte do Salao. Abra-o, pegue qualquer coisa que tiver dentro dele e retorne. Va logo! O que esta esperando?", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 24 then
            npcHandler:say("Bom... como se saiu contra meus guardas? Ha ha ha... Nao se preocupe. Eu precisava testar um pouco mais a sua forca antes de ter certeza que pode nos ajudar. \z
            Como voce ja percebeu, temos alguns problemas 'politicos' que levaram a consequencias severas. Nao me tornei estatua atoa... E eu gostaria de saber se voce poderia me ajudar com isso. \z
            Nao busco me tornar Naga novamente, isso seria impossivel. Mas quero pelo menos manter os rebeldes sob controle para que nao causem mais problemas. Voce pode me ajudar com isso?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 25 then
            npcHandler:say("O que esta esperando? Entre no vortex, passe pelo labirinto e derrote Sihrazz para que possamos conter os rebeldes!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 26 then
            npcHandler:say("Soube que derrotou a Sombra de Sihrazz. Impressionante! Mas  sabendo que era apenas sua sombra, isso significa que ele ainda retornara... De qualquer forma sua missao esta cumprida. \z
            Como recompensa permitirei sua entrada na sala dos altares de {encantamento}, onde voce podera encantar uma arma Eldritch utilizando algumas gemas com ingredientes. \z
            Voce entendera mais lendo o livro na sala do altar. Escolha o item com sabedoria!", npc, creature)
            player:addExperience(player:getLevel() * 15000)
            player:addItem(3043, 50)
            player:addItem(33309, 1)
            player:addItem(17514, 1)
            player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 27)
            local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
            player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 8)
            player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "encantamento") then
        npcHandler:say("Voce pode encantar armas Eldritch e tranforma-las em Gilded Eldritch. Para isso voce precisara de algumas gemas encontradas nessa ilha. \z
        Apos receber acesso a sala de Encantamento, basta levar sua arma e as gemas para a sala e realizar o processo. Simples e rapido. Mas antes, voce deve merecer essa honra...", npc, creature)
        npcHandler:setTopic(playerId, 0)
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Veremos... vamos comecar com algo facil. Algo que qualquer um poderia fazer. Va ate o Salao Real, no topo do Palacio, e pegue o que estiver dentro do meu bau. \z
            O bau possui um tamanho reduzido, vermelho e estara no lado norte do Salao. Abra-o, pegue qualquer coisa que tiver dentro dele e retorne. Va logo! O que esta esperando?", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 23)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 2 then
            npcHandler:say("Gosto muito dessa confianca. Mas confianca nao sera o suficiente para esse desafio, entao preste atencao! Preciso que voce derrote Sihrazz, o lider dos rebeldes. \z
            Ele esta escondido no final do Labirinto das Nagas, onde costumavamos realizar jogos antes da revolta. Para chegar ate Sihrazz voce precisara abrir os portoes de saida norte do Labirinto. \z
            Nao sei que tipo de mecanismo estao usando para travar os portoes, mas provavelmente voce encontrara alguma pista no local. Entre no vortex ao lado para acessar o local. Boa sorte!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 25)
            npcHandler:setTopic(playerId, 0)
        end
    end

end


npcHandler:setMessage(MESSAGE_GREET, "Ola, jovem  humano.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Boa sorte!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
