local internalNpcName = "Gertrudes Pascoal"
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
	lookHead = 12,
	lookBody = 34,
	lookLegs = 45,
	lookFeet = 26,
    	lookAddons = 3,
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
npcConfig.currency = 3250

npcConfig.shop = {
	{ name = "exercise sword", clientId = 28552, buy = 25 },
	{ name = "exercise club", clientId = 28554, buy = 25 },
	{ name = "exercise axe", clientId = 28553, buy = 25 },
	{ name = "exercise bow", clientId = 28555, buy = 25 },
	{ name = "exercise rod", clientId = 28556, buy = 25 },
	{ name = "exercise wand", clientId = 28557, buy = 25 },
	{ name = "durable exercise sword", clientId = 35279, buy = 75 },
	{ name = "durable exercise club", clientId = 35281, buy = 75 },
	{ name = "durable exercise axe", clientId = 35280, buy = 75 },
	{ name = "durable exercise bow", clientId = 35282, buy = 75 },
	{ name = "durable exercise rod", clientId = 35283, buy = 75 },
	{ name = "durable exercise wand", clientId = 35284, buy = 75 },
	{ name = "lasting exercise sword", clientId = 35285, buy = 375 },
	{ name = "lasting exercise club", clientId = 35287, buy = 375 },
	{ name = "lasting exercise axe", clientId = 35286, buy = 375 },
	{ name = "lasting exercise bow", clientId = 35288, buy = 375 },
	{ name = "lasting exercise rod", clientId = 35289, buy = 375 },
	{ name = "lasting exercise wand", clientId = 35290, buy = 375 },
	{ name = "amulet of loss", clientId = 3057, buy = 5 },
	{ name = "ovo de pascoa", clientId = 37167, buy = 100 },
	{ name = "obsidian knife", clientId = 5908, buy = 50, },
	{ name = "black candle", clientId = 9099, buy = 25},
	{ name = "sneaky stabber of eliteness", clientId = 9594, buy = 500},
	{ name = "squeezing gear of girlpower", clientId = 9596, buy = 750},
	{ name = "whacking driller of fate", clientId = 9598, buy = 500},
	{ name = "music box", clientId = 16244, buy = 100},
	{ name = "casino ticket", clientId = 637, buy = 15},
	{ name = "mechanical fishing rod", clientId = 9306, buy = 300},
	{ name = "watering can", clientId = 650, buy = 500},
	{ name = "crystal pickaxe", clientId = 9306, buy = 500},
	{ name = "sun catcher", clientId = 25977, buy = 500},
	{ name = "moon mirror", clientId = 25975, buy = 500},
	{ name = "starlight vial", clientId = 25731, buy = 500},
	{ name = "perdao real", clientId = 39136, buy = 25},
	{ name = "crandoria ring", clientId = 18935, buy = 3000},
	{ name = "passe de batalha", clientId = 9218, buy = 1500},
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

npcHandler:setMessage(MESSAGE_GREET, "Roubaram minhas cenouras! Se tiver algumas cenouras especiais para meus coelhos me avise e faremos uma boa {troca}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais! Volte quando tiver algumas cenouras sobrando.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais! Volte quando tiver algumas cenouras sobrando.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)

-- local function creatureSayCallback(npc, creature, type, message)
--     local player = Player(creature)
--     local playerId = player:getId()

--     if not npcHandler:checkInteraction(npc, creature) then
--         return false
--     end

--     if MsgContains(message, "missao") or MsgContains(message, "mission") then
--         npcHandler:say("Que otimo! Nem acredito que voce quer mesmo me ajudar! Eu cultivo cenouras e ha alguns dias um bando de coelhos malditos roubaram toda a minha colheita. Sua missao sera muito simples: Recuperar as {cenouras} que os malditos coelhos roubaram de mim.", npc, creature)
--         npcHandler:setTopic(playerId, 1)
--     elseif MsgContains(message, "cenouras") or MsgContains(message, "carrots") then
--         if npcHandler:getTopic(playerId) < 1 then
--             npcHandler:say("Minhas cenouras sao especiais. Eu cultivo cada uma com muito cuidado para que se tornem as melhores e maiores cenouras que ja se viu no Novo Continente! \z
--             Mas aqueles malditos coelhos roubaram todo o meu carregamento e espalharam as cenouras para todo lugar. Por isso estou recompensando a todos que trouxerem pelo menos 100 cenouras para mim. Voce possui essa quantidade com voce?", npc, creature)
--             npcHandler:setTopic(playerId, 2)
--         elseif npcHandler:getTopic(playerId) == 1 then
--             npcHandler:say("Para cada 100 cenouras especiais que voce trouxer, te recompensarei com um {ovo da pascoa}. Voce deseja trocar 100 cenouras?", npc, creature)
--             npcHandler:setTopic(playerId, 2)
--         end
--     elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
--         if npcHandler:getTopic(playerId) == 2 then
--             if player:getItemCount(3250) >= 100 then
--                 player:removeItem(3250, 100)
--                 player:addItem(37167, 1)
--                 npcHandler:say("Muito obrigada! Aqui esta, como prometido. Um ovo de pascoa! Mas toma cuidado, dizem que ha tantos coelhos tentando pega-los que ao tentar abrir um deles um coelho maldito aparecera quase que instantaneamente na sua frente!", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             else
--                 npcHandler:say("Ei! Voce nao pensa com muita clareza, nao e mesmo? Eu preciso de CEM CENOURAS ESPECIAIS. Entendeu agora? Volte quando tiver pegado todas. ", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             end
--         end
--     end
-- end


-- npcHandler:setMessage(MESSAGE_GREET, "Ola, jovem. Me avise se tiver tempo de me ajudar em uma {missao}.")
-- npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais! Volte quando quiser alguns ovos de pascoa!")
-- npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

-- npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- -- npcType registering the npcConfig table
-- npcType:register(npcConfig)
