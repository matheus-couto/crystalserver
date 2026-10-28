local internalNpcName = "Tezila"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 160,
	lookHead = 3,
	lookBody = 92,
	lookLegs = 91,
	lookFeet = 128,
}

npcConfig.flags = {
	floorchange = false,
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

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "amber with a bug", clientId = 32624, sell = 41000 },
	{ itemName = "amber with a dragonfly", clientId = 32625, sell = 56000 },
	{ itemName = "amber", clientId = 32626, sell = 20000 },
	{ itemName = "ancient coin", clientId = 24390, sell = 350 },
	{ itemName = "black pearl", clientId = 3027, buy = 560, sell = 280 },
	{ itemName = "blue crystal shard", clientId = 16119, sell = 1500 },
	{ itemName = "blue crystal splinter", clientId = 16124, sell = 400 },
	{ itemName = "bronze goblet", clientId = 5807, buy = 2000 },
	{ itemName = "brown crystal splinter", clientId = 16123, sell = 400 },
	{ itemName = "brown giant shimmering pearl", clientId = 282, sell = 3000 },
	{ itemName = "coral brooch", clientId = 24391, sell = 750 },
	{ itemName = "crunor idol", clientId = 30055, sell = 30000 },
	{ itemName = "cyan crystal fragment", clientId = 16125, sell = 800 },
	{ itemName = "dragon figurine", clientId = 30053, sell = 45000 },
	{ itemName = "gemmed figurine", clientId = 24392, sell = 3500 },
	{ itemName = "giant amethyst", clientId = 32622, sell = 60000 },
	{ itemName = "giant emerald", clientId = 30060, sell = 90000 },
	{ itemName = "giant ruby", clientId = 30059, sell = 70000 },
	{ itemName = "giant sapphire", clientId = 30061, sell = 50000 },
	{ itemName = "giant topaz", clientId = 32623, sell = 80000 },
	{ itemName = "gold ingot", clientId = 9058, sell = 5000 },
	{ itemName = "gold nugget", clientId = 3040, sell = 850 },
	{ itemName = "golden amulet", clientId = 3013, buy = 6600 },
	{ itemName = "golden goblet", clientId = 5805, buy = 5000 },
	{ itemName = "greater guardian gem", clientId = 44604, sell = 10000 },
	{ itemName = "greater marksman gem", clientId = 44607, sell = 10000 },
	{ itemName = "greater mystic gem", clientId = 44613, sell = 10000 },
	{ itemName = "greater sage gem", clientId = 44610, sell = 10000 },
	{ itemName = "green crystal fragment", clientId = 16127, sell = 800 },
	{ itemName = "green crystal shard", clientId = 16121, sell = 1500 },
	{ itemName = "green crystal splinter", clientId = 16122, sell = 400 },
	{ itemName = "green giant shimmering pearl", clientId = 281, sell = 3000 },
	{ itemName = "guardian gem", clientId = 44603, sell = 5000 },
	{ itemName = "lesser guardian gem", clientId = 44602, sell = 1000 },
	{ itemName = "lesser marksman gem", clientId = 44605, sell = 1000 },
	{ itemName = "lesser mystic gem", clientId = 44611, sell = 1000 },
	{ itemName = "lesser sage gem", clientId = 44608, sell = 1000 },
	{ itemName = "lion figurine", clientId = 33781, sell = 10000 },
	{ itemName = "marksman gem", clientId = 44606, sell = 5000 },
	{ itemName = "mystic gem", clientId = 44612, sell = 5000 },
	{ itemName = "onyx chip", clientId = 22193, sell = 400 },
	{ itemName = "opal", clientId = 22194, sell = 500 },
	{ itemName = "ornate locket", clientId = 30056, sell = 18000 },
	{ itemName = "prismatic quartz", clientId = 24962, sell = 450 },
	{ itemName = "rainbow quartz", clientId = 25737, sell = 500 },
	{ itemName = "red crystal fragment", clientId = 16126, sell = 800 },
	{ itemName = "ruby necklace", clientId = 3016, buy = 3560 },
	{ itemName = "sage gem", clientId = 44609, sell = 5000 },
	{ itemName = "silver goblet", clientId = 5806, buy = 3000 },
	{ itemName = "skull coin", clientId = 32583, sell = 12000 },
	{ itemName = "small amethyst", clientId = 3033, buy = 400, sell = 200 },
	{ itemName = "small diamond", clientId = 3028, buy = 600, sell = 300 },
	{ itemName = "small emerald", clientId = 3032, buy = 500, sell = 250 },
	{ itemName = "small enchanted amethyst", clientId = 678, sell = 200 },
	{ itemName = "small enchanted emerald", clientId = 677, sell = 250 },
	{ itemName = "small enchanted ruby", clientId = 676, sell = 250 },
	{ itemName = "small enchanted sapphire", clientId = 675, sell = 250 },
	{ itemName = "small ruby", clientId = 3030, buy = 500, sell = 250 },
	{ itemName = "small sapphire", clientId = 3029, buy = 500, sell = 250 },
	{ itemName = "small topaz", clientId = 9057, sell = 200 },
	{ itemName = "tiger eye", clientId = 24961, sell = 350 },
	{ itemName = "unicorn figurine", clientId = 30054, sell = 50000 },
	{ itemName = "violet crystal shard", clientId = 16120, sell = 1500 },
	{ itemName = "wedding ring", clientId = 3004, buy = 990 },
	{ itemName = "white pearl", clientId = 3026, buy = 320, sell = 160 },
	{ itemName = "white silk flower", clientId = 34008, sell = 9000 },
	{ itemName = "bounty talisman", clientId = 51978, buy = 5000 },
}


local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local knight = player:getVocation():getBaseId() == VOCATION.BASE_ID.KNIGHT
    local paladin = player:getVocation():getBaseId() == VOCATION.BASE_ID.PALADIN
    local monk = player:getVocation():getBaseId() == VOCATION.BASE_ID.MONK
    local druid = player:getVocation():getBaseId() == VOCATION.BASE_ID.DRUID
    local sorcerer = player:getVocation():getBaseId() == VOCATION.BASE_ID.SORCERER

	local storage = player:getStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso)

	local value1 = 100000 -- ek
	local value2 = 100000 -- paladin
	local value3 = 100000 -- sorcerer
	local value4 = 100000 -- ed
	local value5 = 100000 -- monk

	if knight then
		value1 = 50000
		value2 = 50000
	elseif paladin then
		value2 = 50000
		value3 = 50000
	elseif sorcerer then
		value3 = 50000
		value4 = 50000
	elseif druid then
		value4 = 50000
		value5 = 50000
	elseif monk then
		value5 = 50000
		value1 = 50000
	end

	if MsgContains(message, "missao") or MsgContains(message, "mission") or MsgContains(message, "bonificacao") or MsgContains(message, "bonus") then
		if storage == 2 then
			npcHandler:say("Ah, entao Mordecai te mandou aqui pela bonificacao. Sim, estamos dando um bonus de acordo com as vocacoes dos Defensores de Crandoria. \z
			Para Knights, "..value1.." gold coins. Para Paladins, "..value2.." gold coins. Para Sorcerers, "..value3.." gold coins. Para Druids, "..value4.." gold coins. Para Monks, "..value5.." gold coins. \z
			E entao, qual a sua vocacao?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
	elseif MsgContains(message, "knight") then
		if knight then
			player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 3)
			player:addItem(3043, 5)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 5 Crystal Coins.")
		elseif paladin then
			player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 4)
			player:addItem(3043, 5)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 5 Crystal Coins.")
		else
			player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 5)
			player:addItem(3043, 10)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 10 Crystal Coins.")
		end
		npcHandler:say("Ah, verdade? Nao parece... se me perguntassem eu nao acertaria. Mas enfim, aqui esta. Anvillux agradece pelos seus servicos como Defensor de Crandoria e do Novo Continente!", npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "paladin") then
		if paladin then
			player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 3)
			player:addItem(3043, 5)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 5 Crystal Coins.")
		elseif sorcerer then
			player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 4)
			player:addItem(3043, 5)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 5 Crystal Coins.")
		else
			player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 5)
			player:addItem(3043, 10)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 10 Crystal Coins.")
		end
		npcHandler:say("Ah, verdade? Nao parece... se me perguntassem eu nao acertaria. Mas enfim, aqui esta. Anvillux agradece pelos seus servicos como Defensor de Crandoria e do Novo Continente!", npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "sorcerer") then
		if sorcerer then
			player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 3)
			player:addItem(3043, 5)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 5 Crystal Coins.")
		elseif druid then
			player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 4)
			player:addItem(3043, 5)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 5 Crystal Coins.")
		else
			player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 5)
			player:addItem(3043, 10)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 10 Crystal Coins.")
		end
		npcHandler:say("Ah, verdade? Nao parece... se me perguntassem eu nao acertaria. Mas enfim, aqui esta. Anvillux agradece pelos seus servicos como Defensor de Crandoria e do Novo Continente!", npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "druid") then
		if druid then
			player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 3)
			player:addItem(3043, 5)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 5 Crystal Coins.")
		elseif monk then
			player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 4)
			player:addItem(3043, 5)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 5 Crystal Coins.")
		else
			player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 5)
			player:addItem(3043, 10)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 10 Crystal Coins.")
		end
		npcHandler:say("Ah, verdade? Nao parece... se me perguntassem eu nao acertaria. Mas enfim, aqui esta. Anvillux agradece pelos seus servicos como Defensor de Crandoria e do Novo Continente!", npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "monk") then
		if monk then
			player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 3)
			player:addItem(3043, 5)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 5 Crystal Coins.")
		elseif knight then
			player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 4)
			player:addItem(3043, 5)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 5 Crystal Coins.")
		else
			player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 5)
			player:addItem(3043, 10)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 10 Crystal Coins.")
		end
		npcHandler:say("Ah, verdade? Nao parece... se me perguntassem eu nao acertaria. Mas enfim, aqui esta. Anvillux agradece pelos seus servicos como Defensor de Crandoria e do Novo Continente!", npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Muito bem, entao preste atencao: Ha seis virtudes igualmente importantes que voce precisa dominar no seu caminho, independente de sua vocacao. \z
			Sao elas: Honra, Coragem, Sacrificio, Honestidade, Humildade e Justica. Quando conseguir dominar as seis virtudes, sera superior a grande maioria dos guerreiros dessas terras. \z
			E para iniciar sua jornada, pedirei por algo simples que sera extremamente necessario em sua jornada: traga para mim um Writhing Heart, obtido do boss The Unwelcome. Simples, certo? Ficarei esperando.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 1)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 2 then
			if player:getItemCount(32599) >= 1 then
				player:removeItem(32599, 1)
				player:addExperience(2500000, true)
				player:addMoney(185000, true)
				npcHandler:say("Ah! Excelente! Nao se preocupe, te pagarei seu valor exato, aqui. Este coracao sera necessario para sua proxima missao, que sera tambem o inicio do seu caminho pelas Virtudes. \z
				Me avise quando estiver pronto para essa {missao}.", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 2)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao esta com o coracao? Parece que se confundiu...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "O banco de Anvillux te da as boas vindas!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_TRADE, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType) end

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("trade", "bye")

npcType:register(npcConfig)
