local internalNpcName = "Herbert"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 132,
	lookHead = 97,
	lookBody = 93,
	lookLegs = 36,
	lookFeet = 93,
	lookAddons = 0
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

	local storage = player:getStorageValue(Storage.Quest.Crandoria.QuestHerbert.Progresso)

	if MsgContains(message, "intruso") then
		if storage < 1 then
			npcHandler:say("Dia apos dia alguem entra em nossos dominios para roubar o nosso ouro. Ladroes imprestaveis... Voce por acaso faz parte disso? \z
			Claro que faz! Todos fazem. Ninguem aqui esta preocupado em nos defender. Estamos buscando pelo ultimo ladrao que passou por aqui. \z
			Ele em breve sentira o peso de nossa {vinganca}.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 1 then
			npcHandler:say("Ainda nao derrotou o criminoso? Entao o que faz aqui?", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 2 then
			npcHandler:say("Hmm.. eu ouvi sobre sua conquista. Realmente, sua palavra tem valor, viajante. Aqui, como combinado. \z
			250.000 gold coins e dois itens que ele havia roubado e ainda possuia. Muito obrigado!", npc, creature)
			player:addMoney(250000, true)
			player:addItem(17828, 1)
			player:addItem(9099, 1)
			player:addExperience(1000000, true)
			player:setStorageValue(Storage.Quest.Crandoria.QuestHerbert.Progresso, 3)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 3 then
			npcHandler:say("Felizmente nao preciso mais da sua ajuda, jovem. Agradeco por tudo.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "vinganca") then
		npcHandler:say("Minha vontade era de quebrar suas duas pernas! Mas eu nao sou um guerreiro, sei que nao posso fazer isso por conta propria. \z
		Mas ei! Por que voce esta aqui ouvindo tudo isso? Escute, se voce nao for aliado ao maldito, eu posso te oferecer uma recompensa em dinheiro para derrota-lo. \z
		Digamos... 250.000 gold coins alem de todo o dinheiro que ele tiver roubado. O que voce acha, teria interesse?", npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif MsgContains(message, "missao") or MsgContains(message, "mission") then
		if storage == 1 then
			npcHandler:say("Ainda nao derrotou o criminoso? Entao o que faz aqui?", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "dan") or MsgContains(message, "bill") or MsgContains(message, "fred") then
		npcHandler:say("Ah... Esses malditos. Ja tivemos tres pessoas banidas daqui: Dan, Bill e Fred. Pelo que ouvi eles se juntaram aos gladiadores da antiga arena. \z
		Mas nao tenho certeza, e nem quero saber! Esses malditos mereciam a morte por tentar nos roubar, sempre foi isso que pensei. Mas alguns aqui nao concordam comigo.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
		if npcHandler:getTopic(playerId) == 1 then
			if player:getLevel() < 300 then
				npcHandler:say("Hmm... pensando bem, voce parece um pouco fraco para essa missao. Retorne apos o nivel 300 e talvez possamos conversar.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Entao temos um acordo! Mas escute bem: eu so te pagarei apos voce derrotar o maldito criminoso, entendeu? Temos olhos e ouvidos em toda a ilha... \z
				Bom, vamos la. Tenho apenas duas informacoes sobre o individuo: As pessoas o chamam de Jesse the Wicked e ele vive escondido em algum lugar nessa ilha. \z
				Essas sao todas as informacoes que tenho em maos. Explore o local, encontre-o e derrote-o. Retorne ate mim quando conseguir.", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.QuestHerbert.Progresso, 1)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Ah! Claro... Um {intruso}...")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
