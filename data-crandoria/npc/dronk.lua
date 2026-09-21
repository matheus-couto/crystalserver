local internalNpcName = "Dronk"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = "Drako"

npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1444,
	lookHead = 0,
	lookBody = 114,
	lookLegs = 132,
	lookFeet = 78,
	lookAddons = 3
}

npcConfig.flags = {
	floorchange = false
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

    local storage = player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso)
	local storageCount = player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.DragonCounter)

    if MsgContains(message, "mission") or MsgContains(message, "missao") then
		if storage < 1 then
			if player:getLevel() < 400 then
				npcHandler:say("Escute, filho. Nesse mundo ha diversos desafios a serem enfrentados e barreiras a serem quebradas. Sim... \z
				Mas nao podemos ter pressa. A pressa so nos leva a uma morte precoce nesse mundo tao perigoso. Voce nao ve? Mas nao desanime. \z
				Passe por mais alguns desafios, evolua um pouco mais, talvez apos o nivel 400 voce consiga enfrentar os desafios dessa ilha.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce parece experiente o bastante para aceitar missoes perigosas e jovem o bastante para nao temer a morte. \z
				Talvez sua jornada possa mudar para sempre seu destino, te levando a uma busca por um valioso {artefato} vivo...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
				elseif storage == 1 then
			if storageCount < 500 then
				npcHandler:say("Voce ainda nao derrotou os 500 dragoes da ilha.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Muito bem, meu jovem! Voce pode ser mais forte do que parece. Isso sera otimo para nossos proximos passos. \z
				Acredito que nao teremos problemas tao grandes para conseguir o que precisamos para obter os segredos do Primeiro Dragao. \z
				Me avise quando quiser iniciar a nossa {missao}.", npc, creature)
				player:addExperience(2500000, true)
				player:setStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso, 2)
				player:setStorageValue(Storage.Quest.U11_02.TheFirstDragon.DragonCounter, 0)
				npcHandler:setTopic(playerId, 0)
			end
		elseif storage == 1 then
			if storageCount < 500 then
				npcHandler:say("Voce ainda nao derrotou os 500 dragoes da ilha.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Muito bem, meu jovem! Voce pode ser mais forte do que parece. Isso sera otimo para nossos proximos passos. \z
				Acredito que nao teremos problemas tao grandes para conseguir o que precisamos para obter os segredos do Primeiro Dragao. \z
				Me avise quando quiser iniciar a nossa {missao}.", npc, creature)
				player:addExperience(2500000, true)
				player:setStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso, 2)
				player:setStorageValue(Storage.Quest.U11_02.TheFirstDragon.DragonCounter, 0)
				npcHandler:setTopic(playerId, 0)
			end
		elseif storage == 2 then
			npcHandler:say("Estive tentando encontrar uma forma de acessar os aposentos do First Dragon, mas nao obtive sucesso ainda. \z
			Talvez voce possa me ajudar. Veja se alguem em Crandoria sabe de alguma coisa sobre o 'Primeiro Dragao' e como chegar ate ele. \z
			Rumores, lendas... qualquer coisa serve. Se voce conseguir algo relevante, retorne ate mim.", npc, creature)
			player:setStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso, 3)
			npcHandler:setTopic(playerId, 0)
		elseif storage >= 3 and storage < 5 then
			npcHandler:say("Preciso que descubra alguma informacao que nos ajude a chegar ao Primeiro Dragao. \z
			Procure por informacoes em Crandoria e retorne quando tiver sucesso em sua busca.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 5 then
			npcHandler:say("Um ritual, certo? Entendo... Bom, nao vamos perder tempo. Obtenha os itens de cada um dos guardioes. \z
			Cada um dos guardioes pode ser encontrado em alavancas especiais na ilha. Voce pode levar mais dois companheiros com voce. \z
			Enquanto isso, buscarei por alguma informacao sobre como poderemos executar o ritual. Retorne quando tiver conseguido os itens.", npc, creature)
			player:setStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso, 6)
			player:addExperience(2500000, true)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 6 then
			npcHandler:say("Voce trouxe os quatro itens de cada um dos dragoes guardioes?", npc, creature)
			npcHandler:setTopic(playerId, 3)
		elseif storage == 7 then
			npcHandler:say("Pise na plataforma verde ao lado para que possamos ralizar o ritual.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 8 then
			npcHandler:say("Bom, parece que o ritual funcionou, mas so temos uma forma de comprovar: encontrando o Primeiro Dragao. \z
			Aqui, fique com este frasco. Se coneguir derrota-lo, voce deve usar o frasco para coletar seu espirito. Faca isso logo apos derrota-lo, nao demore. \z
			Va! A entrada para seus dominios esta entre os Verdant Dragons. Traga-me seu espirito e te ajudarei a alcancar os dragoes mais poderosos.", npc, creature)
			player:setStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso, 9)
			player:addItem(44527, 1)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 9 then
			npcHandler:say("O que esta esperando? Derrote o Primeiro Dragao e obtenha seu espirito logo apos sua morte.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 10 then
			npcHandler:say("E entao. Voce conseguiu coletar o espirito do Primeiro Dragao?", npc, creature)
			npcHandler:setTopic(playerId, 4)
		elseif storage == 11 then
			npcHandler:say("Nao tenho mais missoes para voce, por enquanto.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "artefato") or MsgContains(message, "artifact") then
		npcHandler:say("O artefato ao qual me refiro seria basicamente o espirito do First Dragon, o primeiro dragao a pisar nas terras do Novo Continente. \z
		Se aceitar a tarefa de buscar por esse poderoso artefato, posso te contar o segredo de como chegar as profundezas secretas dessa ilha, guardada por dragoes poderosos que voce nunca viu. \z
		Mas ja aviso que nao sera nada facil concluir esse desafio. Voce acha que tem o necessario para isso?", npc, creature)
		npcHandler:setTopic(playerId, 1)
    elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Hum... Apesar da minha experiencia nao sei dizer se seu animo seria bom ou ruim nessa missao... \z
			Talvez possamos fazer um teste da sua forca antes de comecarmos, apenas para ver se voce pode encarar o desafio. \z
			Facamos o seguinte: Derrote 500 dragoes na ilha. Crimson, Verdant, Blizzard ou Haunted, nao importa. Derrote 500 e retorne a mim.", npc, creature)
            player:setStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso, 1)
			player:setStorageValue(Storage.Quest.U11_02.TheFirstDragon.DragonCounter, 0)
            npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 3 then
			if player:getItemCount(24939) >= 1 and player:getItemCount(24940) >= 1 and player:getItemCount(24941) >= 1 and player:getItemCount(24942) >= 1 then
				player:removeItem(24939, 1)
				player:removeItem(24940, 1)
				player:removeItem(24941, 1)
				player:removeItem(24942, 1)
				player:addExperience(5000000, true)
				player:addOutfit(1722)
				player:addOutfit(1723)
				player:setStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso, 7)
				player:setStorageValue(Storage.Quest.U11_02.TheFirstDragon.DragonCounter, 0)
				local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
				npcHandler:say("Esta tudo aqui! Muito bem. Agora estamos prontos para fazer nosso Ritual. Pelo que eu li nao sera algo dificil. \z
				Ja deixei tudo preparado. Agora, por favor, pise na plataforma ao lado.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 4 then
			if player:getItemCount(44528) >= 1 then
				player:removeItem(44528, 1)
				npcHandler:say("Incrivel... Eu posso sentir a essencia do dragao nesse frasco! Confesso que por um momento duvidei que voce conseguiria. \z
				Bom, como combinado, vou te ajudar a encontrar o caminho secreto que leva as profundezas da ilha. Aqui, tudo que precisa esta nesse documento. \z
				Mas ja vou avisando... o local pode ser extremamente perigoso e voce encontrara desafios ainda maiores do os que encontrou ate agora. Boa sorte!", npc, creature)
				player:setStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso, 11)
				player:addExperience(8000000, true)
				player:addItem(48278, 1)
				local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 5)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("E onde esta o frasco com o espirito? Estou esperando.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ah! Ola, jovem.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
