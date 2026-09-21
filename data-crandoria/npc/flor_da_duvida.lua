local internalNpcName = "Flor da Duvida"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookTypeEx = 3872
}

npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 60000,
	chance = 50,
	{text = 'Voce tem certeza que quer seguir esee caminho?'}
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

    if MsgContains(message, "mission") or MsgContains(message, "missao") then
		if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) <= 9 then
			npcHandler:say("Espera ai, quem te mandou aqui? Eu nao sei de onde voce veio, mas nao confio em voce!", npc, creature)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) >= 10 then
			if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor) < 1 then
				npcHandler:say({"Foi o Gato quem te enviou, estou certa? Bom, isso pode ser melhor do que eu esperava... Escute aqui, crianca, tenha em mente que esta sera uma missao perigosa e muito importante!",
				"Ha anos eu guardo o portal que da acesso ao Mundo da Natureza Morta. Esse lugar ja foi lar de muitas criaturas magicas, mas apos uma terrivel maldicao ele se transformou em um local de horror e desolacao.",
				"Para tentar salvar a vida das fadas que ainda estao tentando limpar o local, preciso de alguem corajoso que possa levar para elas uma bencao que estou preparando. Para entregar a bencao voce devera apenas tocar as fadas presentes no local.",
				"A urgencia de cada fada sera diferente, por isso voce devera respeitar uma ordem para abencoar todas as fadas. Nao sera dificil, voce vai ver! Siga",
				"Apos passar a bencao para cada fada, elas te entregarao parte de seu poder. Com o poder total das 10 fadas que estao ali, voce tera forca suficiente para enfrentar a criatura que comanda todas as outras. Preciso que voce derrote-a e capture", 
				"alguma parte de seu corpo, para que eu possa preparar um novo encantamento e assim tentar reverter a maldicao. Voce aceita o desafio?"}, npc, creature)
				npcHandler:setTopic(playerId, 1)
			elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor) > 0 and player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor) < 11 then
				npcHandler:say("Por favor, nao perca tempo! Voce precisa ajudar as 10 fadas que vivem nos fundos do Mundo da Natureza Morta. Retorne quando tiver ajudado cada uma delas e tiver derrotado o terrivel monstro que domina o lugar.", npc, creature)
				npcHandler:setTopic(playerId, 0)	
			elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor) == 11 then
				if player:getItemCount(12235) < 1 then
					npcHandler:say("Muito bom! Voce conseguiu ajudar 10 fadas que habitam aquele lugar. Agora basta derrotar o terrivel monstro que guarda as profundezas do local e obter uma parte do seu corpo para mim. Por favor, nao demore!", npc, creature)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Voce conseguiu derrotar o terrivel monstro? Trouxe algo que comprove isso?", npc, creature)
					npcHandler:setTopic(playerId, 2)
				end
			end
		end
	elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 1 then
			player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor, 1)
			npcHandler:say("Otimo! Para acessar o local basta seguir o corredor em meio a montanha logo atras de mim e descer no buraco escondido no fundo. Lembre-se: Voce deve tocar em cada uma das 10 fadas uma vez e, depois disso, \z
			podera enfrentar um terrivel monstro que se encontra no fundo do local e que dizem ser o responsavel pela maldicao jogada ali. Por favor, retorne com a vitoria em maos! Estarei esperando por voce.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 2 then
			if player:removeItem(12235, 1) then
				npcHandler:say("Maravilha! Eu gostaria de dizer que nao duvidei de voce, mas meu proprio nome nao me deixa mentir nao e mesmo? ", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress, player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) + 1)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("E onde esta a prova de que voce o derrotou? Eu devo simplesmente acreditar e dizer a todos para entrarem naquele buraco? Traga-me algo dele. Uma orelha, uma mao, qualquer coisa!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end
end

keywordHandler:addKeyword({'coelho', 'rabbit'}, StdModule.say, {npcHandler = npcHandler, text = ''})



npcHandler:setMessage(MESSAGE_GREET, "Preciso de alguem confiavel que me ajude em uma perigosa {missao}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
