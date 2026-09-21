local internalNpcName = "Buppor"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 277,
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

	local storage = Game.getStorageValue(GlobalStorage.Crandoria.TibiaCoinsColeta.LimiteDiario)
	if storage < 0 then
		storage = 0
	end

	local valor = 25 - storage

    if MsgContains(message, "lombo") or MsgContains(message, "meat") or MsgContains(message, "carne") or MsgContains(message, "tibia coin") then
		if storage < 25 then
			npcHandler:say("Pago 1 Tibia Coin para cada lombo que voce tiver. No momento tenho espaco para " ..valor.. " no estoque. Quantos deseja vender?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		else
			npcHandler:say("Sinto muito, |PLAYERNAME|, mas nao preciso de mais carne no momento. Volte amanha, talvez um pouco mais cedo.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	else
		if npcHandler:getTopic(playerId) == 1 then
			-- local desiredLevel = getMoneyCount(message)
			local quantidade = tonumber(message)
			if not quantidade then
				npcHandler:say("Desculpe, nao entendi. Apenas me diga o numero de Lombos que deseja vender.", npc, creature)
				npcHandler:setTopic(playerId, 1)
				return true
			end
			if quantidade <= 0 then
				npcHandler:say("Muito engracado...", npc, creature)
				return true
			end
			if quantidade > valor then
				npcHandler:say("Nao posso aceitar tantos lombos assim. So tenho espaco para " .. valorDisponivel .. " no momento.", npc, creature)
				return true
			end
			local itemIdLombo = 32009
			if player:getItemCount(itemIdLombo) < quantidade then
				npcHandler:say("Voce nao tem lombos suficientes.", npc, creature)
				return true
			end
			if quantidade == 1 then
				npcHandler:say("Vendido! Aqui esta, 1 Tibia Coin!", npc, creature)
				player:addTransferableCoins(1)
				player:removeItem(32009, 1)
				Game.setStorageValue(GlobalStorage.Crandoria.TibiaCoinsColeta.LimiteDiario, storage + 1)
				setGlobalStorage(GlobalStorage.Crandoria.TibiaCoinsColeta.CoinsTotal, getGlobalStorage(GlobalStorage.Crandoria.TibiaCoinsColeta.CoinsTotal) + 1)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Quer vender " ..quantidade.." Lombos por " ..quantidade.. " Tibia Coins?", npc, creature)
				player:addTransferableCoins(quantidade)
				player:removeItem(32009, quantidade)
				Game.setStorageValue(GlobalStorage.Crandoria.TibiaCoinsColeta.LimiteDiario, storage + quantidade)
				setGlobalStorage(GlobalStorage.Crandoria.TibiaCoinsColeta.CoinsTotal, getGlobalStorage(GlobalStorage.Crandoria.TibiaCoinsColeta.CoinsTotal) + quantidade)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end
end

npcConfig.shop = {
	{ itemName = "ham", clientId = 3582, buy = 8 },
	{ itemName = "meat", clientId = 3577, buy = 5 },
	{ itemName = "dragon ham", clientId = 3583, buy = 50 },
	{ itemName = "lombo", clientId = 32009, sell = 50000 },
}

npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. Compro {lombo} de porco diariamente. Ou solicite uma {troca} caso queira comprar um pouco de carne.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais! Volte quando quiser negociar.")
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

npcType:register(npcConfig)