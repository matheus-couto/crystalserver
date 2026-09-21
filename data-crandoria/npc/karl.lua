local internalNpcName = "Karl"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 1094,
	lookHead = 58,
	lookBody = 49,
	lookLegs = 70,
	lookFeet = 115,
	lookAddons = 0
}

npcConfig.voices = {
	interval = 30000,
	chance = 25,
	{text = 'Procuro por novatos que queiram ajudar em uma missao muito simples por 50.000 gold coins.'},
	{text = 'Chegou recentemente a Crandoria e esta sem dinheiro? Que tal executar uma tarefa para resolver isso?'},
    {text = 'Fale comigo se for novato e precisar de dinheiro!'}
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

	local storageProgresso = player:getStorageValue(Storage.Quest.Crandoria.EntregasEspeciais.Progresso)
	local storageCooldown = player:getStorageValue(Storage.Quest.Crandoria.EntregasEspeciais.Cooldown)
	local timeLeft = math.floor((player:getStorageValue(Storage.Quest.Crandoria.EntregasEspeciais.Cooldown) - os.time()) / 60)


	if MsgContains(message, "missao") then
		if player:getLevel() < 50 then
			npcHandler:say("Wow! Vamos com calma, eu disse novatos e nao bebes! Ha ha ha ha! Me desculpe, forca do habito... \z
			Voce ainda nao tem nivel o suficiente para transmitir confianca. Volte apos o nivel 50 e poderemos conversar.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.EntregasEspeciais.Progresso, 0)
			npcHandler:setTopic(playerId, 0)
		elseif player:getLevel() > 100 then
			npcHandler:say("Sinto muito jovem. Voce parece forte e essa missao so se aplica a novatos de nivel 50 a 100. \z
			Mas agradeco por sua disposicao!", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.EntregasEspeciais.Progresso, 0)
			npcHandler:setTopic(playerId, 0)
		else
			if storageProgresso < 1 then
				npcHandler:say("Voce parece ter exatamente o que eu preciso para essa missao! Eu faco parte do Grupo de Entregas Especiais de Crandoria, muito importante para o Reino. \z
				Temos como objetivo mover cartas e objetos de extremo valor por um sistema especial de correio integrado a algumas cidades do Novo Continente. \z
				Estou precisando de ajuda para buscar por algumas encomendas que sao enviadas a cada 2 dias para diferentes locais. O que acha? Poderia me ajudar?", npc, creature)
				npcHandler:setTopic(playerId, 1)
			elseif storageProgresso == 1 then
				npcHandler:say("Nao encontrou o pacote? Sinto muito, mas se nao finalizar essa missao, nao poderei confiar que trara os outros pacotes. \z
				O local onde precisa ir na Selva de Jagunda esta marcado em seu mapa. Agora va logo e nao volte sem esse pacote!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			elseif storageProgresso == 2 then
				npcHandler:say("Voce encontrou o pacote? Esta em posse do conteudo?", npc, creature)
				npcHandler:setTopic(playerId, 2)
			elseif storageProgresso == 3 then
				if storageCooldown < os.time() then
					npcHandler:say("Eu preciso que voce colete tres envios em tres cidades diferentes. Eles devem ser coletados na ordem correta, entendeu? \z
					O primeiro esta em Chaos, o segundo em Valkesh e o terceiro em Hakata. Dessa vez voce pegara os pacotes em caixas de correio especiais em cada cidade. \z
					Procure por bueiros em Chaos e Valkesh e por um buraco em Hakata e encontrara o local de cada caixa de correio. Apos pegar todas as tres encomendas retorne ate mim e te pagarei seus 50.000 gold coins.", npc, creature)
					player:setStorageValue(Storage.Quest.Crandoria.EntregasEspeciais.Progresso, 4)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Nao preciso de ajuda por agora. As encomendas chegam a cada 2 dias. Retorne em "..timeLeft.." minutos para executar a missao novamente.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			elseif storageProgresso > 3 and storageProgresso < 7 then
				npcHandler:say("Ainda nao obteve as tres encomendas? O que esta esperando? Por favor, nao demore!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			elseif storageProgresso == 7 then
				npcHandler:say("E entao... voce trouxe os tres pacotes?", npc, creature)
				npcHandler:setTopic(playerId, 3)
			end
		end
	elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Excelente! Mas olhe, antes de te dar tamanha responsabilidade, preciso fazer um teste da sua forca. Nao podemos correr o risco de perder um pacote caso voce seja atacado... \z
			Nao se preocupe, sera algo simples para voce. So preciso que voce pegue o pacote deixado pelo nosso ultimo estagiario. Ele perdeu o pacote em um buraco na Selva de Jagunda, proximo a Hakata. \z
			Aqui, vou marcar o local no seu mapa. Va ate la, derrote os monstros no caminho e recupere o pacote. Simples, nao? Va! Estou te esperando.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.EntregasEspeciais.Progresso, 1)
			player:addMapMark(Position(5482, 5057, 7), MAPMARK_FLAG, "Pacote")
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 2 then
			if player:getItemCount(6092) >= 1 then
				player:removeItem(6092, 1)
				npcHandler:say("Ah... aqui esta. Parece um simples relogio quebrado, certo? Mas ha um bilhete dentro dele e esse bilhete era o que eu realmente queria. \z
				Muito obrigado pela ajuda. Agora que sei que posso realmente confiar em voce, acredito que esteja pronto para buscar os outros pacotes. Nao havera monstros dessa vez. \z
				Me avise quando estiver preparado para sua {missao}.", npc, creature)
				player:addItem(3035, 5)
				player:addExperience(50000, true)
				player:setStorageValue(Storage.Quest.Crandoria.EntregasEspeciais.Progresso, 3)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say('E onde esta o conteudo do pacote, |PLAYERNAME|?', npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 3 then
			if player:getItemCount(145) >= 3 then
				player:removeItem(145, 3)
				player:addItem(3043, 5)
				player:addExperience(1000000)
				npcHandler:say("Um.. dois... tres. Perfeito, |PLAYERNAME|! Aqui, como combinado, seu dinheiro. Retorne em 2 dias e havera mais pacotes para serem buscados.", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.EntregasEspeciais.Progresso, 3)
				player:setStorageValue(Storage.Quest.Crandoria.EntregasEspeciais.Cooldown, os.time() + 48 * 60 * 60)
				local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Nao vejo os tres pacotes, |PLAYERNAME|...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end
end

npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais.")
npcHandler:setMessage(MESSAGE_GREET, 'Ola, jovem aventureiro. Que tal uma {missao}?')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

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

npcType:addDialogOptions("bye")
npcType:register(npcConfig)
