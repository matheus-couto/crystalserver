local internalNpcName = "Pig, o Ardiloso"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 667,
	lookHead = 34,
	lookBody = 114,
	lookLegs = 114,
	lookFeet = 75,
    	lookAddons = 0,
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

    local storage = player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso)

    if MsgContains(message, "missao") or MsgContains(message, "mission") then
        if storage == 8 then
            npcHandler:say({"Nao acredito! Hidrox foi pego? Ha ha ha! Venci a aposta! Digo, digo... Minha nossa... meu amigo Hidrox... Cof cof... Bom, uma pena, mas fazer o que? A vida nunca foi facil pra nos.",
            "Mas agora entendi tudo. Eu ja sei porque ele te mandou aqui. Na verdade ele quer minha ajuda para descobrir quem entregou sua localizacao para as Amazonas. Eu acho que consigo ajudar, mas precisarei de voce.",
            "Ja adianto para voce que nao sera nada facil... Voce aceita essa missao?"}, npc, creature)
            npcHandler:setTopic(playerId, 1) 
        elseif storage == 10 then
            npcHandler:say("Encontre a carta com as informacoes sobre Rocket Tank na torre de vigia de Chaos. Lembre-se: Utilize os mesmos outfits e as mesmas cores dos guardas, ou eles vao te capturar!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 11 or storage == 12 then
            npcHandler:say("Se esta de volta acredito que tenha conseguido entrar na torre e pegar a carta. A carta com as informacoes esta com voce?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif storage == 13 or storage == 14 then
            npcHandler:say("Procure por Rocket Tank em Umbra e diga a ele a senha {rulo}. Lembre-se da dica sobre seu paradeiro: Procure por agua em meio ao sangue.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 15 then
            npcHandler:say("HA! Entao ele te contou? Ha ha ha ha... Finalmente nos livramos daquele imbecil! Mas devo confessar, foi muito bom fingir que eu era amigo dele. Afinal de contas essa sempre foi minha especialidade...", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 16 or storage == 17 then
            npcHandler:say("Nao tenho nada para voce agora.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 18 then
            npcHandler:say("Insolente! Idiota! Eu devia acabar com voce! Quando eu sair daqui usarei todos os meus recursos para acabar com tudo que voce construiu!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say({"Haha idiota... Digo... Muito bem, vamos a sua missao. Escute, temos um segredo para conseguirmos passar livremente pelo Novo Continente sem sermos notados... Voce so precisa mentir, fingir, enganar!",
            "E sera assim que voce conseguira nos ajudar... Inicialmente, vamos buscar por Rocket Tank, nosso outro parceiro. Ele foi avistado por tropas de Chaos e por isso preciso de voce. Eles sempre enviam essas informacoes em cartas.",
            "Voce deve entrar na torre vestindo roupas de cavaleiros, como as dos guardas de Chaos, e tambem as mesmas cores. Dessa forma ninguem percebera voce ou suas intencoes. Entre na torre, pegue a carta e traga-a ate mim!"}, npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso, 10)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:removeItem(6113, 1) then
                npcHandler:say({"Muito bem, deixe-me ver... hum... Bom, parece que Rocket Tank esta atualmente em Umbra. Nao acho que voce vai encontra-lo facilmente, mas nunca se sabe... Eis a pista que posso te dar: Procure por agua em meio ao sangue.",
                "Va ate ele e, ao encontra-lo, diga a ele a senha {rulo}. Ele vai entender tudo. Boa sorte!"}, npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso, 13)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Escute aqui, eu sou Pig, o Ardiloso. Eu engano as pessoas, mas nao gosto quando tentam me enganar! Traga a carta para mim.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end 
        end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) then
        if npcHandler:getTopic(playerId) == 1 or npcHandler:getTopic(playerId) == 2 then
            npcHandler:say("Entao o que voce esta fazendo aqui? Nao desperdice meu tempo!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "O que voce quer?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
