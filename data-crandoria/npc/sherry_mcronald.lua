local internalNpcName = "Sherry McRonald"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 136,
	lookHead = 78,
	lookBody = 94,
	lookLegs = 19,
	lookFeet = 97,
	lookAddons = 0
}

npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{text = 'Isn\'t this a beautiful day? Perfect for farming.'}
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
        if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) < 1 then
        	npcHandler:say("Donald e eu nos mudamos para ca ha pouco tempo. Moravamos dentro de Crandoria e sempre cultivamos nosso trigo dentro dos muros da cidade. \z
			Porem ha alguns meses Alice, nossa filha, desapareceu por quase tres dias e voltou de dentro da plantacao dizendo coisas {estranhas}. Desde entao ela nao anda bem e parece ter perdido parte de sua memoria.", npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) == 1 then
            npcHandler:say("Nossa fazenda nunca mais foi a mesma depois do que aconteceu com Alice. Por favor, traga o remedio para que ela consiga melhorar logo! A bruxa do pantano sabe como fazer esse remedio.", npc, creature)
            npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) == 2 then
            npcHandler:say("Entao voce conversou com a bruxa? Que otimo, por favor, se voce conseguir a pocao traga para mim o mais rapido possivel!", npc, creature)
            npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) == 3 then
			npcHandler:say("Voce conseguiu o remedio?", npc, creature)
			npcHandler:setTopic(playerId, 3)
		else
			npcHandler:say("Voce conseguiu o remedio?", npc, creature)
			npcHandler:setTopic(playerId, 3)
			player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress, 0)
        end
	elseif MsgContains(message, "estranhas") or MsgContains(message, "strange") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Quando a encontramos na plantacao ela estava falando algo sobre um coelho cruel. Disse tambem que haviam roubado seu tesouro, mas nao sabemos do que ela esta falando... \z
			Xodet nos disse que Wyda, a bruxa que mora no pantano, consegue fazer um remedio que cura quase todos os 'males da cabeca', como ele colocou, mas Donald e eu nao somos guerreiros e ha criaturas\z
			 no caminho que podem nos ferir. Ei, ja sei! Por que voce nao nos ajuda? Voce parece ser forte. Poderia conseguir o remedio com a bruxa no pantano?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		end
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
        if npcHandler:getTopic(playerId) == 2 then
            npcHandler:say("Eu sabia! Sempre existiram pessoas boas em Crandoria! A bruxa, ou Wyda, fica em sua casa no sul do pantano. Tome cuidado com os monstros no caminho! Estaremos esperando pelo seu retorno. Obrigada!", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress, 1)
            npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 3 then
			if player:getItemCount(37708) >= 1 then
				player:removeItem(37708, 1)
				npcHandler:say("Eu nao acredito! Voce conseguiu mesmo o remedio! Estou tao feliz! Vou agora mesmo contar ao Donald e entrega-lo a Alice. Muito obrigada! Por favor, converse com Donald depois, ele te dara uma recompensa pela sua ajuda!", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress, 4)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Entao, por favor, traga-o para mim!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola |PLAYERNAME|! Bem vindo a nossa humilde fazenda. Eu e Donald estamos buscando por alguem para nos ajudar em uma {missao}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Nos agracie com outra visita em breve, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Entao ate mais...")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "bread", clientId = 3600, sell = 2 },
	{ itemName = "cheese", clientId = 3607, buy = 5 },
	{ itemName = "cherry", clientId = 3590, buy = 1 },
	{ itemName = "melon", clientId = 3593, buy = 8 },
	-- { itemName = "pumpkin", clientId = 3594, buy = 10 }
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
