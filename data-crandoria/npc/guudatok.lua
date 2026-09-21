local internalNpcName = "Guudatok"
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
	lookHead = 4,
	lookBody = 42,
	lookLegs = 35,
	lookFeet = 68,
	lookAddons = 2
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
        if player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 73 then
            npcHandler:say("Ha ha! Entao voce agora tambem esta minerando? Comandante Crassus sempre nos surpreendendo com seus recrutas... Bom, tudo bem entao! Eu preciso de um Cobalt Ridge, nao tem segredo. Traga um deles para mim e ficarei contente. Aceita o desafio?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 74 then
			if player:removeItem(39037, 1) then
				player:addItem(4061, 1, true)
				player:addItem(22724, 15, true)
				player:addExperience(5000000, true)
				npcHandler:say("Muito obrigado pelo Cobalt Ridge. Aqui, leve este Eldritch Fragment como recompensa. Vai ser util em algum momento da sua jornada. Filandrel, o alquimista, estava precisando de ajuda com algo. Ele fica em sua casa numa pequena ilha a oeste da cidade. Fale com ele e veja do que ele precisa.", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 75)
			else
				npcHandler:say("Preciso de apenas 1 Cobalt Ridge. Traga-o para mim.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Excelente. Entre nas minas e fique o quanto quiser. So nao esqueca da sua picareta! He he he.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 74)
			npcHandler:setTopic(playerId, 0)
		end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) and npcHandler:getTopic(playerId) == 1 then
        npcHandler:say("Tudo bem, sem problemas.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcConfig.currency = 39037

npcConfig.shop = {
	{ name = "astralis coin", clientId = 22724, buy = 10 },
	-- { name = "bar of gold", clientId = 14112, buy = 50 },
	{ name = "eldritch fragment", clientId = 4061, buy = 300 },
	{ name = "worker helmet", clientId = 11700, buy = 150 },
	{ name = "gold token", clientId = 22721, buy = 20 },
	{ name = "small stamina refill", clientId = 20138, buy = 100 },
	-- { id = 4049, clientId = 4049, buy = 35 },
}

npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. Gostaria de fazer uma {troca} de alguns Cobalt Ridges?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais! Volte quando quiser usar a forja.")
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