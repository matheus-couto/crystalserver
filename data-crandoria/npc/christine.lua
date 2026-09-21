local internalNpcName = "Christine"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 140,
	lookHead = 2,
	lookBody = 23,
	lookLegs = 2,
	lookFeet = 115,
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

    if MsgContains(message, "missao") or MsgContains(message, "mission") then
        if player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 69 then
            npcHandler:say("Ah, claro! Comandante Crassus te enviou, nao foi? Tudo bem. Escute aqui, eu nao vou te pedir por frutas, esta bem? Preciso de alguem que de conta de lutar por mim. \z
			Perdi minha Gearwheel Chain ha algum tempo e nao me sinto protegida sem ela. Por favor, va ate os monstros da usina ao sul do arquipelago e consiga um novo Gearwheel Chain para mim. Voce pode me ajudar com isso?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 70 then
			if player:removeItem(21170, 1) then
				player:addItem(23682, 1, true)
				player:addItem(4049, 1, true)
				player:addItem(22724, 15, true)
				player:addExperience(5000000, true)
				npcHandler:say("Exatamente o que eu precisava para me sentir mais segura ao sair da padaria sozinha a noite. Muito obrigada! Aqui, leve isso como agradecimento. Kradok, o anao que vive em cima das minas, parecia precisar de ajuda com algo.", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 71)
			else
				npcHandler:say("Por favor, traga 1 Gearwheel Chain para mim! Preciso desse amuleto para me sentir segura novamente.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Confio em voce, |PLAYERNAME|! Por favor, nao demore.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 70)
			npcHandler:setTopic(playerId, 0)
		end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) and npcHandler:getTopic(playerId) == 1 then
        npcHandler:say("Tudo bem, sem problemas.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "bread", clientId = 3600, buy = 3 },
	{ itemName = "brown bread", clientId = 3602, buy = 3 },
	{ itemName = "cheese", clientId = 3607, buy = 5 },
	{ itemName = "mug of milk", clientId = 2880, buy = 2, count = 6 },
	{ itemName = "party cake", clientId = 6279, buy = 50 }
	-- { name = "small stamina refill", clientId = 20138, buy = 25 },
	-- { name = "casino ticket", clientId = 637, buy = 2 },
	-- { name = "black candle", clientId = 9099, buy = 5},
	-- { name = "blueberry cupcake", clientId = 28484, buy = 20},
	-- { name = "carrion casserole", clientId = 29414, buy = 2},
	-- { name = "carrot cake", clientId = 9087, buy = 12},
	-- { name = "carrot pie", clientId = 29409, buy = 9},
	-- { name = "lemon cupcake", clientId = 28486, buy = 18},
	-- { name = "strawberry cupcake", clientId = 28485, buy = 10},
	-- { name = "veggie casserole", clientId = 9084, buy = 18},
	-- { name = "demonic candy ball", clientId = 11587, buy = 3},
	-- { name = "astralis coin", clientId = 22724, buy = 3},
	-- { name = "worker legs", clientId = 32097, buy = 300},


}

npcHandler:setMessage(MESSAGE_GREET, "Ah, ola... Interessado em comprar alguns paes? Talvez um queijo...")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
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

npcType:addDialogOptions("trade", "bye")
npcType:register(npcConfig)


