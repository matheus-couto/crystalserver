local internalNpcName = "Duncan"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 151,
	lookHead = 38,
	lookBody = 23,
	lookLegs = 0,
	lookFeet = 116,
	lookAddons = 1
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

	local storage = Storage.Quest.U7_8.OutfitQuest.PirateSabreAddon

	if MsgContains(message, 'task') then
		if player:getStorageValue(Storage.Quest.U7_8.OutfitQuest.PirateBaseOutfit) < 2 then
			npcHandler:say('Voce nao tem nem roupas de pirata adequadas, como ja quer um sabre? Volte quanto Raymond Striker ja tiver te dado roupas mais adequadas para um pirata.', npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.U7_8.OutfitQuest.PirateBaseOutfit) == 2 then
			npcHandler:say('Precisa de um sabre para se tornar um pirata de verdade? Eu sei de alguem que pode te ajudar, mas para te passar a informacao eu vou querer alguns itens em troca, para minha loja. Esta preparado para essa missao?', npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif player:getStorageValue(Storage.Quest.U7_8.OutfitQuest.PirateBaseOutfit) == 3 then
			npcHandler:say('Nao perca tempo. Va ate Morgan, em Chaos, e diga a ele a palavra {revenge} e ele te ajudara com o sabre dos piratas.', npc, creature)
			npcHandler:setTopic(playerId, 0)
		else
			npcHandler:say('Ja te ajudei com tudo o que podia, jovem. Sinto muito, mas agora voce esta por conta propria.', npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, 'yes') or MsgContains(message, 'sim') then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say('Excelente, marujo! Preciso de 100 Eye Patches, 100 Peg Legs e 100 Hooks. Voce possui todos os itens com voce?', npc, creature)
			npcHandler:setTopic(playerId, 2)
		elseif npcHandler:getTopic(playerId) == 2 then
			npcHandler:say('Otimo. Se voce me der todos os itens eu te passarei uma palavra chave, voce deve passar essa palavra chave para Morgan, em Chaos. Ele te dara seu sabre apos isso. Voce aceita esses termos?', npc, creature)
			npcHandler:setTopic(playerId, 3)
		elseif npcHandler:getTopic(playerId) == 3 then
			if player:getItemCount(6097) >= 100 and player:getItemCount(6098) >= 100 and player:getItemCount(6126) >= 100 then
				player:removeItem(6097, 100)
				player:removeItem(6098, 100)
				player:removeItem(6126, 100)
				npcHandler:say('Tenha cuidado com as palavras que te direi. Lembre-se, ao encontrar com Morgan, diga a ele {revenge}. Ele sabera o que dizer depois disso. Obrigado pela ajuda, marujo!', npc, creature)
				player:setStorageValue(Storage.Quest.U7_8.OutfitQuest.PirateBaseOutfit, 3)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say('Esta querendo me enganar? Quem voce pensa que eu sou, marujo? Volte aqui quando tiver todos os itens!', npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	elseif MsgContains(message, 'no') or MsgContains(message, 'nao') then
		if npcHandler:getTopic(playerId) == 2 then
			npcHandler:say('Entao nao perca meu tempo, marujo! Busque por todos os itens e depois volte ate meu barco.', npc, creature)
			npcHandler:setTopic(playerId, 0)
		else
			npcHandler:say('Sem problemas. Volte quando mudar de ideia', npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "pirate tapestry", clientId = 5615, buy = 40 }
}
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

npcType:register(npcConfig)
