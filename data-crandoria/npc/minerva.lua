local internalNpcName = "Minnerva"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 54,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
    	lookAddons = 0,
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

    if MsgContains(message, "fantasia") or MsgContains(message, "costume") then
		npcHandler:say("Posso te conceder o Royal Pumpkin {outfit} e seus {addons} em troca de algumas aboboras... Qual voce deseja obter?", npc, creature)
		npcHandler:setTopic(playerId, 1)
		
	elseif MsgContains(message, "outfit") then
		if npcHandler:getTopic(playerId) == 1 then
			if player:hasOutfit(759) or player:hasOutfit(760) then
				npcHandler:say("Voce ja possui este outfit.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Para te conceder o outfit Royal Pumpkin precisarei de 50 aboboras. Voce possui os itens?", npc, creature)
				npcHandler:setTopic(playerId, 2)
			end
		end
	elseif MsgContains(message, "addon") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("O {primeiro} addon vai te custar 100 aboboras, enquanto o segundo saira por 150 aboboras. Qual voce deseja obter?", npc, creature)
			npcHandler:setTopic(playerId, 3)
		end
	elseif MsgContains(message, "primeiro") or MsgContains(message, "first") then
		if npcHandler:getTopic(playerId) == 3 then
			if player:hasOutfit(759, 1) or player:hasOutfit(760, 1) then
				npcHandler:say("Voce ja possui este addon.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				if player:getItemCount(3594) >= 100 then
					player:removeItem(3594, 100)
					player:addOutfitAddon(759, 1)
					player:addOutfitAddon(760, 1)
					npcHandler:say("Muito bem, aqui esta seu primeiro addon!", npc, creature)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Voce nao possui todas as aboboras necessarias.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			end
		end
	elseif MsgContains(message, "segundo") or MsgContains(message, "second") then
		if npcHandler:getTopic(playerId) == 3 then
			if player:hasOutfit(759, 2) or player:hasOutfit(760, 2) then
				npcHandler:say("Voce ja possui este addon.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				if player:getItemCount(3594) >= 150 then
					player:removeItem(3594, 150)
					player:addOutfitAddon(759, 2)
					player:addOutfitAddon(760, 2)
					npcHandler:say("Muito bem, aqui esta seu segundo addon!", npc, creature)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Voce nao possui todas as aboboras necessarias.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			end
		end
	elseif MsgContains(message, "montaria") or MsgContains(message, "mount") then
		npcHandler:say("Posso te oferecer a montaria Cerberus Champion em troca de 200 das suas Pumpkins. Essa montaria fornece +30 de velocidade de movimento. Uma das mais rapidas que existem! Voce gostaria de obte-la?", npc, creature)
		npcHandler:setTopic(playerId, 5)
	elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 2 then
			if player:getItemCount(3594) >= 50 then
				player:removeItem(3594, 50)
				player:addOutfit(759)
				player:addOutfit(760)
				npcHandler:say("Aqui esta sua nova fantasia!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao possui todas as aboboras necessarias.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 5 then
			if player:getItemCount(3594) >= 200 then
				if player:hasMount(146) then
					npcHandler:say("Voce ja possui essa montaria.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				else
					player:removeItem(3594, 200)
					player:addMount(146)
					npcHandler:say("Aqui esta sua nova montaria!", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			else
				npcHandler:say("Voce nao possui todas as aboboras necessarias.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) then
        npcHandler:say("Tudo bem, boa sorte...", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcConfig.currency = 3594

npcConfig.shop = {
	{ name = "exercise sword", clientId = 28552, buy = 20 },
	{ name = "exercise club", clientId = 28554, buy = 20 },
	{ name = "exercise axe", clientId = 28553, buy = 20 },
	{ name = "exercise bow", clientId = 28555, buy = 20 },
	{ name = "exercise rod", clientId = 28556, buy = 20 },
	{ name = "exercise wand", clientId = 28557, buy = 20 },
	{ name = "durable exercise sword", clientId = 35279, buy = 50 },
	{ name = "durable exercise club", clientId = 35281, buy = 50 },
	{ name = "durable exercise axe", clientId = 35280, buy = 50 },
	{ name = "durable exercise bow", clientId = 35282, buy = 50 },
	{ name = "durable exercise rod", clientId = 35283, buy = 50 },
	{ name = "durable exercise wand", clientId = 35284, buy = 50 },
	{ name = "black candle", clientId = 9099, buy = 30},
	{ name = "music box", clientId = 16244, buy = 80},
	{ name = "casino ticket", clientId = 637, buy = 5},
	{ name = "sun catcher", clientId = 25977, buy = 200},
	{ name = "moon mirror", clientId = 25975, buy = 200},
	{ name = "perdao real", clientId = 39136, buy = 10},
    { name = "bag you desire", clientId = 34109, buy = 375 },
	{ name = "primal bag", clientId = 39546, buy = 425 },
	{ name = "eldritch you desire", clientId = 29351, buy = 500 },
	{ name = "cobra you desire", clientId = 22739, buy =  200 },
	{ name = "falcon you desire", clientId = 31633, buy =  250 },
	{ name = "lion you desire", clientId = 36827, buy =  225 },
	{ name = "medalha de honra", clientId = 9219, buy =  100 },


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


npcHandler:setMessage(MESSAGE_GREET, "Ola, jovem alma. Nao vou te impedir de estragar meu feitico com suas aboboras, mas posso te oferecer uma boa {troca} por elas ou, quem sabe, prefira uma {fantasia} ou uma nova {montaria}...")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais! Volte quando quiser usar a forja.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
