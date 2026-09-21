local internalNpcName = "Donald McRonald"
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
	lookHead = 22,
	lookBody = 94,
	lookLegs = 79,
	lookFeet = 117,
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

    if MsgContains(message, "ajuda") or MsgContains(message, "help") then
		if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) < 3 then
			npcHandler:say("Eu e minha esposa nos mudamos recentemente para essa fazenda. Nossa filha esta passando por problemas pois teve uma experiencia traumatica. \z
			Eu nao gosto muito de falar sobre, mas Sherry podera te explicar melhor. Seria otimo se voce pudesse falar com ela e nos ajudar a resolver nosso problema...", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) == 4 then
			npcHandler:say("Sherry me contou sobre o remedio. Te agradeco imensamente! Alice ja esta melhorando e sua memoria esta voltando. Ela disse que depois \z
			quer falar com voce sobre o que aconteceu. Ela parece querer sua ajuda, mas ainda esta fraca. Volte amanha e fale com ela em seu quarto, ela ja estara melhor. \z
			Mas de antemao eu gostaria de te dar uma recompensa por ter salvado sua vida. Aqui, algumas das nossas melhores colheitas!", npc, creature)
			player:addItem(11682, 5)
			player:addItem(11460, 50)
			player:addItem(11683, 100)
			player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress, 5)
			player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.MedicineTimer, os.time() + 24 * 60 * 60)
		elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) > 4 then
			npcHandler:say("Muito obrigado pela sua ajuda!", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	end



end

npcHandler:setMessage(MESSAGE_GREET, "Ola. Quer alguma coisa? Digo... Err. Desculpe meus modos, mas esta dificil achar {ajuda} hoje em dia. Posso ajudar?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Nos visite quando quiser, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Entao ate mais...")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "beetroot", clientId = 8017, buy = 2 },
	{ itemName = "bunch of wheat", clientId = 3605, buy = 1 },
	{ itemName = "carrot", clientId = 3595, buy = 3 },
	{ itemName = "cheese", clientId = 3607, buy = 5 },
	{ itemName = "corncob", clientId = 3597, buy = 3 },
	{ itemName = "cucumber", clientId = 8014, buy = 3 },
	{ itemName = "dead spider", clientId = 3988, sell = 2 }
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

npcType:addDialogOptions("bye")

npcType:register(npcConfig)
