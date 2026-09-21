local internalNpcName = "Gold Token Exchanger"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = "Token Trader" 
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 472,
	lookHead = 0,
	lookBody = 114,
	lookLegs = 0,
	lookFeet = 78,
	lookAddons = 3
}

npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{text = 'Que tal negociar alguns Tokens por Astralis Coins?'}
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

-- local function creatureSayCallback(npc, creature, type, message)
-- 	local player = Player(creature)
-- 	local playerId = player:getId()

-- 	if not npcHandler:checkInteraction(npc, creature) then
-- 		return false
-- 	end

-- 	if MsgContains(message, "tokens") then
-- 		npcHandler:say("Eu compro {gold tokens}, {silver tokens}, {arena tokens} e {online tokens}. Voce tambem pode comprar {astralis coins} em troca de seus tokens. Qual moeda voce deseja negociar?", npc, creature)
-- 		npcHandler:setTopic(playerId, 0)
-- 	elseif MsgContains(message, "gold") then
-- 		npcHandler:say("Voce pode {comprar} cada Gold Token por 3 Astralis Coins ou {vender} 3 Gold Tokens por 1 Astralis Coin. O que voce deseja fazer? ({comprar}/{vender})", npc, creature)
-- 		npcHandler:setTopic(playerId, 1)
-- 	elseif MsgContains(message, "silver") then
-- 		npcHandler:say("Voce pode {comprar} cada Silver Token por 2 Astralis Coins ou {vender} 3 Silver Tokens por 1 Astralis Coin. O que voce deseja fazer? ({comprar}/{vender})", npc, creature)
-- 		npcHandler:setTopic(playerId, 2)
-- 	elseif MsgContains(message, "arena") then
-- 		npcHandler:say("Voce pode comprar 1 Astralis Coin por 3 Arena Tokens. Quantos Astralis Coins voce deseja comprar?", npc, creature)
-- 		npcHandler:setTopic(playerId, 3)
-- 	elseif MsgContains(message, "online") then
-- 		npcHandler:say("Voce pode comprar 1 Astralis Coin por 5 Online Tokens. Quantos Online Tokens voce deseja comprar?", npc, creature)
-- 		npcHandler:setTopic(playerId, 4)
-- 	elseif MsgContains(message, "comprar") then
-- 		if npcHandler:getTopic(playerId) == 1 then
-- 			npcHandler:say("Quantos Gold Tokens voce deseja comprar?", npc, creature)
-- 			npcHandler:setTopic(playerId, 11)
-- 		elseif npcHandler:getTopic(playerId) == 2 then
-- 			npcHandler:say("Quantos Silver Tokens voce deseja comprar?", npc, creature)
-- 			npcHandler:setTopic(playerId, 12)
-- 		end
-- 	elseif MsgContains(message, "vender") then
-- 		if npcHandler:getTopic(playerId) == 1 then
-- 			npcHandler:say("Quantos Gold Tokens voce deseja vender?", npc, creature)
-- 			npcHandler:setTopic(playerId, 21)
-- 		elseif npcHandler:getTopic(playerId) == 2 then
-- 			npcHandler:say("Quantos Silver Tokens voce deseja vender?", npc, creature)
-- 			npcHandler:setTopic(playerId, 22)
-- 		end
-- 	else
-- 		local quantidade = tonumber(message)
-- 	end
-- 	return true
-- end

local TOKENS = {
    gold = { id = 22721, buy = 2, sell = 3 },
    silver = { id = 22516, buy = 1, sell = 3 },
    arena = { id = 22720, sell = 3 },
    online = { id = 22723, sell = 20 },
    astralis = { id = 22724 }
}

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()
    local msg = message:lower()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

    -- =========================
    -- MENU INICIAL
    -- =========================
    if MsgContains(msg, "tokens") then
        npcHandler:say(
            "Eu negocio {gold}, {silver}, {arena} e {online} tokens. Qual voce deseja trocar?",
            npc, creature
        )
        npcHandler:setTopic(playerId, 0)

    -- =========================
    -- ESCOLHA DO TOKEN
    -- =========================
    elseif MsgContains(msg, "gold") then
        npcHandler:say(
            "Gold Tokens: {comprar} por 2 Astralis Coins ou {vender} 3 Gold Tokens por 1 Astralis Coin. Qual voce deseja?",
            npc, creature
        )
        npcHandler:setTopic(playerId, 1)

    elseif MsgContains(msg, "silver") then
        npcHandler:say(
            "Silver Tokens: {comprar} por 1 Astralis Coin ou {vender} 3 Silver Tokens por 1 Astralis Coin. Qual voce deseja?",
            npc, creature
        )
        npcHandler:setTopic(playerId, 2)

    elseif MsgContains(msg, "arena") then
        npcHandler:say("Quantos Arena Tokens voce deseja vender? (3 Arena Tokens = 1 Astralis Coin)", npc, creature)
        npcHandler:setTopic(playerId, 3)

    elseif MsgContains(msg, "online") then
        npcHandler:say("Quantos Online Tokens voce deseja vender? (10 Online Tokens = 1 Astralis Coin)", npc, creature)
        npcHandler:setTopic(playerId, 4)

    -- =========================
    -- COMPRAR
    -- =========================
    elseif MsgContains(msg, "comprar") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Quantos Gold Tokens voce deseja comprar?", npc, creature)
            npcHandler:setTopic(playerId, 11)
        elseif npcHandler:getTopic(playerId) == 2 then
            npcHandler:say("Quantos Silver Tokens voce deseja comprar?", npc, creature)
            npcHandler:setTopic(playerId, 12)
        end

    -- =========================
    -- VENDER
    -- =========================
    elseif MsgContains(msg, "vender") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Quantos Gold Tokens voce deseja vender?", npc, creature)
            npcHandler:setTopic(playerId, 21)
        elseif npcHandler:getTopic(playerId) == 2 then
            npcHandler:say("Quantos Silver Tokens voce deseja vender?", npc, creature)
            npcHandler:setTopic(playerId, 22)
        end

    -- =========================
    -- QUANTIDADE
    -- =========================
    else
        local amount = tonumber(msg)
        if not amount or amount <= 0 then
            npcHandler:say("Informe uma quantidade valida.", npc, creature)
            return true
        end

        local topic = npcHandler:getTopic(playerId)

        -- COMPRAR GOLD
        if topic == 11 then
            local cost = amount * TOKENS.gold.buy
            if player:getItemCount(TOKENS.astralis.id) < cost then
                npcHandler:say("Voce nao tem Astralis Coins suficientes.", npc, creature)
                return true
            end

            player:removeItem(TOKENS.astralis.id, cost)
            player:addItem(TOKENS.gold.id, amount)
            -- npcHandler:say("Troca realizada com sucesso!", npc, creature)
			npcHandler:say("Trato feito! Voce comprou "..amount.." Gold Tokens por "..cost.." Astralis Coins.", npc, creature)

        -- COMPRAR SILVER
        elseif topic == 12 then
            local cost = amount * TOKENS.silver.buy
            if player:getItemCount(TOKENS.astralis.id) < cost then
                npcHandler:say("Voce nao tem Astralis Coins suficientes.", npc, creature)
                return true
            end

            player:removeItem(TOKENS.astralis.id, cost)
            player:addItem(TOKENS.silver.id, amount)
            -- npcHandler:say("Troca realizada com sucesso!", npc, creature)
			npcHandler:say("Trato feito! Voce comprou "..amount.." Silver Tokens por "..cost.." Astralis Coins.", npc, creature)

        -- VENDER GOLD
        elseif topic == 21 then
            if amount % TOKENS.gold.sell ~= 0 then
                npcHandler:say("A quantidade deve ser multipla de 3.", npc, creature)
                return true
            end

            if player:getItemCount(TOKENS.gold.id) < amount then
                npcHandler:say("Voce nao possui Gold Tokens suficientes.", npc, creature)
                return true
            end

            local astralis = amount / TOKENS.gold.sell
            player:removeItem(TOKENS.gold.id, amount)
            player:addItem(TOKENS.astralis.id, astralis)
            -- npcHandler:say("Troca realizada com sucesso!", npc, creature)
			npcHandler:say("Trato feito! Voce vendeu "..amount.." Gold Tokens por "..astralis.." Astralis Coins.", npc, creature)

        -- VENDER SILVER
        elseif topic == 22 then
            if amount % TOKENS.silver.sell ~= 0 then
                npcHandler:say("A quantidade deve ser multipla de 3.", npc, creature)
                return true
            end

            if player:getItemCount(TOKENS.silver.id) < amount then
                npcHandler:say("Voce nao possui Silver Tokens suficientes.", npc, creature)
                return true
            end

            local astralis = amount / TOKENS.silver.sell
            player:removeItem(TOKENS.silver.id, amount)
            player:addItem(TOKENS.astralis.id, astralis)
            -- npcHandler:say("Troca realizada com sucesso!", npc, creature)
			npcHandler:say("Trato feito! Voce vendeu "..amount.." Silver Tokens por "..astralis.." Astralis Coins.", npc, creature)

        -- VENDER ARENA
        elseif topic == 3 then
            if amount % TOKENS.arena.sell ~= 0 then
                npcHandler:say("A quantidade deve ser multipla de 3.", npc, creature)
                return true
            end

            if player:getItemCount(TOKENS.arena.id) < amount then
                npcHandler:say("Voce nao possui Arena Tokens suficientes.", npc, creature)
                return true
            end

            player:removeItem(TOKENS.arena.id, amount)
            player:addItem(TOKENS.astralis.id, amount / 3)
			local value = amount / 3
            -- npcHandler:say("Troca realizada com sucesso!", npc, creature)
			npcHandler:say("Trato feito! Voce vendeu "..amount.." Arena Tokens por "..value.." Astralis Coins.", npc, creature)

        -- VENDER ONLINE
        elseif topic == 4 then
            if amount % TOKENS.online.sell ~= 0 then
                npcHandler:say("A quantidade deve ser multipla de 20.", npc, creature)
                return true
            end

            if player:getItemCount(TOKENS.online.id) < amount then
                npcHandler:say("Voce nao possui Online Tokens suficientes.", npc, creature)
                return true
            end

            player:removeItem(TOKENS.online.id, amount)
            player:addItem(TOKENS.astralis.id, amount / 5)
			local value = amount / 5
            npcHandler:say("Troca realizada com sucesso!", npc, creature)
			npcHandler:say("Trato feito! Voce vendeu "..amount.." Online Tokens por "..value.." Astralis Coins.", npc, creature)
        end

        npcHandler:setTopic(playerId, 0)
    end
    return true
end

npcHandler:setMessage(MESSAGE_GREET, "Ola. Eu negocio {tokens} por Astralis Coins.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus, |PLAYERNAME|.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcConfig.currency = 22724

-- npcConfig.shop = {
-- 	{ itemName = "gold token", clientId = 22721, buy = 5 },
-- 	{ itemName = "gold token", clientId = 22721, sell = 1 },
-- 	{ itemName = "silver token", clientId = 22516, sell = 1 },
-- 	{ itemName = "arena token", clientId = 22720, sell = 1 },
-- }

-- npcConfig.shop = {
-- 	{ itemName = "gold token", clientId = 22721, buy = 150000 },
-- 	{ itemName = "gold token", clientId = 22721, sell = 25000 },
-- 	{ itemName = "arena token", clientId = 22720, sell = 25000 },
	

-- }
-- On buy npc shop message
-- npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
-- 	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
-- end
-- -- On sell npc shop message
-- npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
-- 	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
-- end
-- -- On check npc shop message (look item)
-- npcType.onCheckItem = function(npc, player, clientId, subType)
-- end
npcType:addDialogOptions("bye")
npcType:register(npcConfig)