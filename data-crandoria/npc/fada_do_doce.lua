local internalNpcName = "Fada do Doce"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 1747,
	lookHead = 16,
	lookBody = 2,
	lookLegs = 54,
	lookFeet = 93,
	lookAddons = 3,
}

npcConfig.flags = {
	floorchange = false,
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

    local storage = player:getStorageValue(Storage.Quest.Crandoria.Candia.Progresso)
	local level = player:getLevel()

    if MsgContains(message, "mission") or MsgContains(message, "missao") then
		if level < 100 then
			npcHandler:say("Voce nao possui nivel o suficiente. Retorne apos o nivel 100 e talvez possa ajudar Candia.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		else
			if storage < 1 then
				npcHandler:say("As criaturas de Candia estao acumulando suas fontes de acucar de maneira desproporcional e transformando todas em moedas de chocolate (Dark e Milk Chocolate Coins). \z
				Na falta de acucar para minhas receitas, preciso de alguem que me ajude a pegar essas moedas. No momento preciso de 10 unidades de cada uma delas. O que acha? Aceita esse desafio?", npc, creature)
				npcHandler:setTopic(playerId, 1)
			elseif storage == 1 then
				npcHandler:say("Voce trouxe as moedas de chocolate?", npc, creature)
				npcHandler:setTopic(playerId, 2)
			elseif storage == 2 then
				if level >= 150 then
					npcHandler:say("Um casal de criaturas de Candia se auto intitulam Pai e Mae dos habitantes daqui. Recentemente eles roubaram duas coisas importantes de mim: \z
					Um Pastry Dragon que estava na minha familia ha anos e minha sobremesa favorita: o Taiyaki Ice Cream. Se derrota-los e obtiver os itens para mim, te darei uma boa recompensa.", npc, creature)
					player:setStorageValue(Storage.Quest.Crandoria.Candia.Progresso, 3)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Acho que essa missao pode ser muito dificil para voce. Retorne apos o nivel 150.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			elseif storage == 3 then
				npcHandler:say("Voce conseguiu pegar o Pastry Dragon e o Taiyaki Ice Cream de volta?", npc, creature)
				npcHandler:setTopic(playerId, 3)
			end
		end
	elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
		if npcHandler:getTopic(playerId) == 1 then	
			player:setStorageValue(Storage.Quest.Crandoria.Candia.Progresso, 1)
			npcHandler:say("Certo. Derrote as criaturas no subsolo e obtenha as moedas de chocolate. Nao se preocupe com eles, sao imortais, em algum momento retornarao. \z
			Depois eu ensinarei a eles uma licao, mas agora nao posso parar com meu trabalho. Estarei aguardando pelo seu retorno.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 2 then	
			if player:getItemCount(48249) >= 10 and player:getItemCount(48250) >= 10 then
				player:removeItem(48249, 10)
				player:removeItem(48250, 10)
				player:setStorageValue(Storage.Quest.Crandoria.Candia.Progresso, 2)
				player:addExperience(100000, true)
				npcHandler:say("Humm... Eu adoro o cheiro de chocolate dessas moedas. Muito obrigada! Sabe, talvez voce possa me ajudar com outra {missao}. Uma um pouco mais perigosa...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Sinto muito, mas preciso de 10 Milk Chocolate Coins e 10 Dark Chocolate Coins.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 3 then	
			if player:getItemCount(48256) >= 1 and player:getItemCount(48273) >= 1 then
				player:removeItem(48256, 1)
				player:removeItem(48273, 1)
				player:addItem(3043, 10)
				player:setStorageValue(Storage.Quest.Crandoria.Candia.Progresso, 4)
				player:addExperience(1000000, true)
				local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
				player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 5)
				player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
				npcHandler:say("Que noticia excepcional! Eu nao acredito. Agradeco muitissimo pela sua grande ajuda! Aqui, pegue estas moedas, elas nao tem utilidade aqui. \z
				Alem disso, caso queira, direi a Coco para negociar alguns de seus artigos com voce. Ela vende diversos itens em troca das moedas de chocolate das criaturas da ilha. \z
				Fique a vontade para explorar Candia o quanto quiser!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao trouxe os itens. Onde estao?", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcHandler:setMessage(MESSAGE_GREET, "Ola, humano. O que te traz a nossa ilha?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais!")

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
