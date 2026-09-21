local internalNpcName = "Gondariel"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 159,
	lookHead = 3,
	lookBody = 58,
	lookLegs = 41,
	lookFeet = 115,
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
        if player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 63 then
            npcHandler:say("Ola, |PLAYERNAME|. Comandante Crassus avisou que voce viria. Como ele deve ter te falado, nossa cidade sobrevive basicamente a base de cultivo e mineracao, mas nao temos muitas pessoas produzindo ultimamente. \z
			Enfim... Estou precisando de 25 Fresh Fruits para meu estoque. Voce pode colhe-las em sua propria fazenda ou diretamente das minhas plantas, ao norte do curral comunitario. Elas produzem a cada 8 horas, mas podem produzir coisas indesejaveis... \z
			O importante sera conseguir todas as Peas! Voce aceita a missao?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 64 then
			if player:removeItem(25692, 25) then
				npcHandler:say("Voce conseguiu! Muito bom. Aqui, leve isso com voce como recompensa, vai te ajudar em algum momento dificil. Acredito que Taburok tambem precise de ajuda com algo. Ele esta logo aqui ao lado.", npc, creature)
				player:addItem(28485, 1, true)
				player:addItem(22724, 15, true)
				player:addExperience(5000000, true)
				player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 65)
			else
				npcHandler:say("Nao se esqueca, preciso de 25 Fresh Fruits! Traga-as para mim e direi a Comandante Crassus que eu estou satisfeito.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Explendido! Estarei esperando aqui. Por favor, traga as 25 Fresh Fruits o quanto antes!", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 64)
			player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.CountGondariel, 0)
			npcHandler:setTopic(playerId, 0)
		end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) and npcHandler:getTopic(playerId) == 1 then
        npcHandler:say("Ah.. Tudo bem.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcConfig.currency = 22724

npcConfig.shop = {
	{ name = "dragonfruit", clientId = 11682, sell = 1},
	{ name = "bunch of winterberries", clientId = 12252, sell = 2},
	{ name = "filled milk churn", clientId = 32198, sell = 1},
	-- { name = "lombo", clientId = 32009, sell = 2},
	{ name = "mystic root", clientId = 11551, sell = 1},
	{ name = "exquisite wood", clientId = 11547, sell = 1},
	{ name = "bass", clientId = 32043, sell = 1},
	{ name = "giant leaf", clientId = 11550, sell = 1},
	{ name = "eldritch fragment", clientId = 4061, sell = 3},
	-- { name = "garrafa de vodka", clientId = 21154, sell = 1},
	-- { name = "garrafa de rum", clientId = 36601, sell = 2},
	-- { name = "garrafa de vinho", clientId = 27461, sell = 5},
}

npcHandler:setMessage(MESSAGE_GREET, "Ola. Teria frutos, leite, peixes grandes ou outros recursos para uma boa {troca}? Ofereco Astralis Coins.")
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

npcType:addDialogOptions("trade", "bye")
npcType:register(npcConfig)