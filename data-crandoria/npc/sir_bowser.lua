local internalNpcName = "Sir Bowser"
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
    lookHead = 0,
    lookBody = 114,
    lookLegs = 75,
    lookFeet = 75,
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

    if MsgContains(message, "osric") or MsgContains(message, "astralis coins") then
		if player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.PlantasSelvagens) == 8 then
            npcHandler:say("O que? Ha ha ha! Nao acredite nesse inseto. Ele me devia apenas 5 Astralis Coins, e me pagou na semana passada! Ha ha ha ha!! Que rapaz maldito...", npc, creature)
			player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.PlantasSelvagens, 9)
			npcHandler:setTopic(playerId, 0)
		end
	end
end

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcConfig.currency = 22724

npcConfig.shop = {
	{ name = "black candle", clientId = 9099, buy = 5 },
	{ name = "espelho do mercador", clientId = 36875, buy = 10 },
	{ name = "exercise stash", clientId = 26186, buy = 20 },
	{ name = "living crystal", clientId = 24964, buy = 30 },
	-- { name = "livro sagrado", clientId = 25745, buy = 12 },
	{ name = "music box", clientId = 16244, buy = 25 },
	{ name = "pocao do reinicio", clientId = 39145, buy = 100 },
	{ name = "small stamina refill", clientId = 20138, buy = 45 },
	{ name = "casino ticket", clientId = 637, buy = 5 },
	{ name = "special casino ticket", clientId = 22706, buy = 100 },
	-- { name = "mighty capsule", clientId = 19397, buy = 150 },
	{ name = "spectral gem", clientId = 36875, buy = 1000 },
	-- { name = "bottle of glooth", clientId = 21145, buy = 50 },
	-- { name = "gema antiga", clientId = 33309, buy = 30 },
	-- { name = "exercise sword", clientId = 28552, buy = 9 },
	-- { name = "exercise club", clientId = 28554, buy = 9 },
	-- { name = "exercise axe", clientId = 28553, buy = 9 },
	-- { name = "exercise bow", clientId = 28555, buy = 9 },
	-- { name = "exercise rod", clientId = 28556, buy = 9 },
	-- { name = "exercise wand", clientId = 28557, buy = 9 },
	-- { name = "durable exercise sword", clientId = 35279, buy = 30 },
	-- { name = "durable exercise club", clientId = 35281, buy = 30 },
	-- { name = "durable exercise axe", clientId = 35280, buy = 30 },
	-- { name = "durable exercise bow", clientId = 35282, buy = 30 },
	-- { name = "durable exercise rod", clientId = 35283, buy = 30 },
	-- { name = "durable exercise wand", clientId = 35284, buy = 30 },
	-- { name = "durable exercise shield", clientId = 44066, buy = 30 },
	{ name = "lasting exercise sword", clientId = 35285, buy = 50 },
	{ name = "lasting exercise club", clientId = 35287, buy = 50 },
	{ name = "lasting exercise axe", clientId = 35286, buy = 50 },
	{ name = "lasting exercise bow", clientId = 35288, buy = 50 },
	{ name = "lasting exercise rod", clientId = 35289, buy = 50 },
	{ name = "lasting exercise wand", clientId = 35290, buy = 50 },
	{ name = "lasting exercise shield", clientId = 44067, buy = 50 },
	-- { name = "mechanical fishing rod", clientId = 9306, buy = 90 },
}

-- npcConfig.shop = {
-- 	{ name = "black candle", clientId = 9099, buy = 25 },
-- 	{ name = "Caixa de Pandora", clientId = 4050, buy = 600 },
-- 	{ name = "chaotic jinx", clientId = 23677, buy = 600 },
-- 	{ name = "espelho do mercador", clientId = 36875, buy = 25 },
-- 	{ name = "exercise stash", clientId = 26186, buy =  75},
-- 	{ name = "Kit de Encantamento", clientId = 17514, buy = 200 },
-- 	{ name = "living crystal", clientId = 24964, buy =  100},
-- 	{ name = "livro sagrado", clientId = 25745, buy = 20 },
-- 	{ name = "music box", clientId = 16244, buy = 500 },
-- 	{ name = "pocao do reinicio", clientId = 39145, buy =  50},
-- 	{ name = "small stamina refill", clientId = 20138, buy = 75 },
-- 	{ name = "special casino ticket", clientId = 22706, buy = 350 },
-- 	{ name = "mighty capsule", clientId = 19397, buy = 250 },
-- 	{ name = "spectral gem", clientId = 36875, buy = 1000 },
-- 	{ name = "durable exercise sword", clientId = 35279, buy = 50 },
-- 	{ name = "durable exercise club", clientId = 35281, buy = 50 },
-- 	{ name = "durable exercise axe", clientId = 35280, buy = 50 },
-- 	{ name = "durable exercise bow", clientId = 35282, buy = 50 },
-- 	{ name = "durable exercise rod", clientId = 35283, buy = 50 },
-- 	{ name = "durable exercise wand", clientId = 35284, buy = 50 },
-- 	{ name = "durable exercise shield", clientId = 44066, buy = 50 },
-- 	{ name = "lasting exercise sword", clientId = 35285, buy = 280 },
-- 	{ name = "lasting exercise club", clientId = 35287, buy = 280 },
-- 	{ name = "lasting exercise axe", clientId = 35286, buy = 280 },
-- 	{ name = "lasting exercise bow", clientId = 35288, buy = 280 },
-- 	{ name = "lasting exercise rod", clientId = 35289, buy = 280 },
-- 	{ name = "lasting exercise wand", clientId = 35290, buy = 280 },
-- 	{ name = "lasting exercise shield", clientId = 44067, buy = 280 },
-- 	{ name = "golden skull", clientId = 35580, buy = 500 },
-- 	-- { name = "mechanical fishing rod", clientId = 9306, buy = 150},
-- }

-- npcConfig.shop = {
-- 	{ name = "black candle", clientId = 9099, buy = 25 },
-- 	{ name = "Caixa de Pandora", clientId = 4050, buy = 600 },
-- 	{ name = "chaotic jinx", clientId = 23677, buy = 600 },
-- 	{ name = "espelho do mercador", clientId = 36875, buy = 25 },
-- 	{ name = "exercise stash", clientId = 26186, buy =  75},
-- 	{ name = "Kit de Encantamento", clientId = 17514, buy = 200 },
-- 	{ name = "living crystal", clientId = 24964, buy =  100},
-- 	{ name = "livro sagrado", clientId = 25745, buy = 20 },
-- 	{ name = "music box", clientId = 16244, buy = 500 },
-- 	{ name = "pocao do reinicio", clientId = 39145, buy =  50},
-- 	{ name = "small stamina refill", clientId = 20138, buy = 75 },
-- 	{ name = "special casino ticket", clientId = 22706, buy = 350 },
-- 	{ name = "mighty capsule", clientId = 19397, buy = 250 },
-- 	{ name = "spectral gem", clientId = 36875, buy = 1000 },
-- 	{ name = "durable exercise sword", clientId = 35279, buy = 50 },
-- 	{ name = "durable exercise club", clientId = 35281, buy = 50 },
-- 	{ name = "durable exercise axe", clientId = 35280, buy = 50 },
-- 	{ name = "durable exercise bow", clientId = 35282, buy = 50 },
-- 	{ name = "durable exercise rod", clientId = 35283, buy = 50 },
-- 	{ name = "durable exercise wand", clientId = 35284, buy = 50 },
-- 	{ name = "durable exercise shield", clientId = 44066, buy = 50 },
-- 	{ name = "lasting exercise sword", clientId = 35285, buy = 280 },
-- 	{ name = "lasting exercise club", clientId = 35287, buy = 280 },
-- 	{ name = "lasting exercise axe", clientId = 35286, buy = 280 },
-- 	{ name = "lasting exercise bow", clientId = 35288, buy = 280 },
-- 	{ name = "lasting exercise rod", clientId = 35289, buy = 280 },
-- 	{ name = "lasting exercise wand", clientId = 35290, buy = 280 },
-- 	{ name = "lasting exercise shield", clientId = 44067, buy = 280 },
-- 	{ name = "golden skull", clientId = 35580, buy = 500 },
-- 	-- { name = "mechanical fishing rod", clientId = 9306, buy = 150},
-- }

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

npcHandler:setMessage(MESSAGE_GREET, "Saudacoes, amigo! Eu vendo alguns itens especiais em troca de Astralis coins.")

npcType:addDialogOptions("trade", "bye")
npcType:register(npcConfig)


