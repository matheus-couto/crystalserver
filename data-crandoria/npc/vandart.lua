local internalNpcName = "Lady Vandart"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 139,
	lookHead = 77,
	lookBody = 114,
	lookLegs = 94,
	lookFeet = 115,
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
    local storage = player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso)

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

    if MsgContains(message, "bandidos") or MsgContains(message, "mission") or MsgContains(message, "missao") then
        if storage < 1 then
            npcHandler:say({"Eles vem de todos os lugares e, quando temos sorte, conseguimos expulsa-los direto para Umbra! Malditos, asquerosos... Vermes insolentes!... Me desculpe... A vida em Hakata esta dificil.",
            "Por isso me enviaram de Crandoria para ca. Tenho tentado proteger a cidade desses malditos criminosos, mas minhas forcas nao sao o suficiente. Ha tres {lideres} que precisam ser pegos para que possamos ter paz.",
            "Pelo que dizem eles nunca foram muito inteligentes, mas ja conseguiram roubar e enganar o reino algumas vezes. Preciso de alguem que possa encontra-los e me dizer onde ele esta. Voce aceita essa missao?"}, npc, creature)
            npcHandler:setTopic(playerId, 1)
        elseif storage == 1 then
            npcHandler:say("Ainda nao encontrou Hidrox? Pelas minhas informacoes ele continua preso pelas Amazonas no arquipelago de Astralis, a oeste de Elvenshire.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage > 1 and storage < 8 then
            npcHandler:say("Ja encontrou Hidrox preso no campo das Amazonas? Convenca-o de que voce esta do lado dele e tente descobrir o paradeiro de seus comparsas!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 9 then
            npcHandler:say("Entao de acordo com Hidrox, Sr Pig esta perto de Chaos? Incrivel! Encontre-o e tente obter tambem a localizacao de Rocket Tank com ele. Sei que voce vai conseguir!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 10 then
            npcHandler:say("Encontrou com Sr Pig? Entendo... Entao Chaos avistou Rocket Tank em algum lugar. Nao se preocupe, obtenha a carta e traga-a para mim. Veremos onde podemos encontrar o ultimo dos comparsas!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 11 then
            npcHandler:say("Voce esta com a carta?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif storage == 12 then
            npcHandler:say("Leve a carta e os codigos escritos nela ate Sr Pig e tente descobrir o que eles significam. Com certeza dessa forma encontraremos Rocket Tank e pegaremos todos eles de uma so vez!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 13 then
            npcHandler:say("UMBRA? Eu jamais colocarei meus pes naquele lugar! Entenderei se voce tambem nao quiser ir ate la, mas caso seja louco o suficiente para arriscar, por favor encontre Rocket Tank e nos traga informacoes sobre ele.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 14 then
            npcHandler:say("Agora que voce tem sua localizacao, nao preciso saber mais nada. Deixo por sua conta em risco. Voce prefere {investigar} mais a fundo, ou {capturar} todos de uma vez?", npc, creature)
            npcHandler:setTopic(playerId, 3)
        elseif storage == 15 or storage == 16 then
            npcHandler:say("Agora que voce terminou de investigar todas as intencoes dos criminosos, va ate o Comandante Crassus e reporte a ele suas localizacoes para que possamos prende-los.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso, 16)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 17 then
            npcHandler:say("Pelo que eu soube Sr Pig e Rocket Tank ja estao presos na prisao de Crandoria. Espero que nunca mais saiam de la! Aqui, pegue esses itens como recompensa. Espero que te ajude na sua jornada. Muito obrigada.", npc, creature)
            player:addItem(20138, 1, true)
            player:addItem(22721, 10, true)
            player:addExperience(2000000, true)
            player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso, 18)
            local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
            player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 5)
            player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 18 then
            npcHandler:say("Muito obrigada por toda a sua ajuda!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "lideres") then
        npcHandler:say("Pelo que eu soube, eles sao tres: Pig, o Ardiloso, Rocket Tank, o Ladrao, e Hidrox, o Oportunista. Precisamos urgentemente encontra-los e dete-los, para que nao tenhamos mais problemas em Hakata ou em qualquer outro lugar. Voce pode me ajudar?", npc, creature)
        npcHandler:setTopic(playerId, 1)
    elseif MsgContains(message, "investigar") then
        npcHandler:say("Excelente! Entao continue a investigacao e retorne quando descobrir tudo o que esta acontecendo.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    elseif MsgContains(message, "capturar") then
        npcHandler:say("Maravilha! Concordo com voce. Va ate o Comandante Crassus, em Crandoria, e diga a ele que vamos captura-los.", npc, creature)
        player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso, 16)
        npcHandler:setTopic(playerId, 0)
    elseif MsgContains(message, "cookie") then
        if player:getStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao) == 5 then
            if player:getItemCount(3598) >= 5 then
                player:removeItem(3598, 5)
                npcHandler:say("Cinco cookies pra mim? Isso... eu nem sei o que dizer. Muito obrigada! Voce melhorou o meu dia!", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao, 6)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Alguns cookies cairiam muito bem... Mas eu tenho muita fome, talvez 5 ou mais poderiam resolver meu problema.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say({"Magnifico! Muito obrigada. Infelizmente eu tenho apenas uma pista sobre um dos lideres: Hidrox, o Oportunista. Meus informantes disseram que ele foi capturado por algumas Amazonas perto de Elvenshire.",
            "Eu soube que ele foi pego por tentar arrombar algumas caixas com suprimentos das guerreiras. Encontre-o, mas nao lute contra ele. Quero que voce tente convence-lo a entregar a localizacao dos outros dois lideres.",
            "Como ele ja foi capturado, acredito que nao precisamos nos preocupar. Finja que voce busca por um amigo, engane-o assim como eles fazem com todos. Voce pode ate aprender algumas coisas com ele. Se descobrir algo retorne ate mim!"}, npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso, 1)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getItemCount(6113) >= 1 then
                npcHandler:say("Deixe-me ver! Hmm... hmm... como eu imaginava. Eles possuem um papel que descreve o local do esconderijo de Rocket Tank, mas esta em codigos... Leve a carta para Sr Pig. Tente fazer com que ele te conte a localizacao do ultimo comparsa!", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso, 12)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("E onde ela esta? Por favor, traga-a para mim!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    end
end



npcHandler:setMessage(MESSAGE_GREET, "Ola. Precisamos estar sempre atentos e combater os {bandidos} do Novo Continente.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
