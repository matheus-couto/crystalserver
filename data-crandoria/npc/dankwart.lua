local internalNpcName = "Dankwart"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 128,
	lookHead = 39,
	lookBody = 58,
	lookLegs = 58,
	lookFeet = 115,
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

	if MsgContains(message, 'missao') or MsgContains(message, 'mission') then
		if player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 88 then
			npcHandler:say({
			'Voce nao parece um guerreiro muito forte... Sera que dara conta do recado? Estou precisando de 20 fish fins para organizar um jantar para os moradores da cidade. ...',
			'Sera que voce daria conta dessa tarefa?'
			}, npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 89 then
			if player:removeItem(5895, 20) then
				npcHandler:say({
				'Muito bom! Realmente nao podemos subestimar a eficiencia dos Guerreiros de Crandoria. Muito obrigado pela sua ajuda. Irei notificar ao Comandante Crassus.',
				}, npc, creature)
				player:addExperience(5000000, true)
				player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 90)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say({
				'Preciso de 20 Fish Fins. Por favor, traga-os para mim.',
				}, npc, creature)
			end
		end
	elseif MsgContains(message, "ginger floyd") then
		if player:getStorageValue(Storage.Quest.Crandoria.NilluxQuest.Progresso) == 3 then
			npcHandler:say({
			'Ginger Floyd? Sim, ele esteve aqui ha poucos dias. Ele disse que havia conversado com alguem sobre a possibilidade de montar um esconderijo em uma cidade segura. \z
			Eu o vi saindo da cidade pelo oeste quando eu estava indo para casa. Talvez tenha pegado o tapete para algum lugar seguro.',
			}, npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.NilluxQuest.Progresso, 4)
		end
	elseif MsgContains(message, 'yes') or MsgContains(message, 'sim') then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say({
			'Ok. Confio essa missao a voce, jovem |PLAYERNAME|.',
			}, npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 89)
		end
	end
end

npcConfig.shop = {
	{ itemName = "bread", clientId = 3600, buy = 4 },
	{ itemName = "cheese", clientId = 3607, buy = 6 },
	{ itemName = "ham", clientId = 3582, buy = 8 },
	{ itemName = "meat", clientId = 3577, buy = 5 },
	{ itemName = "mug of mead", clientId = 2880, buy = 5, count = 16 },
	{ itemName = "mug of tea", clientId = 2880, buy = 3, count = 17 }
}

npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. Se quiser comprar comida ou bebida basta dizer e faremos uma {troca}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

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
