local internalNpcName = "Miraia"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 150,
	lookHead = 114,
	lookBody = 0,
	lookLegs = 7,
	lookFeet = 132,
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

local topic = {}

-- local config = {
-- 	['ape fur'] = {
-- 		itemId = 5883,
-- 		count = 100,
-- 		storageValue = 1,
-- 		text = {
-- 			'Have you really managed to fulfil the task and brought me 100 pieces of ape fur?',
-- 			'Only ape fur is good enough to touch the feet of our Caliph.',
-- 			'Ahhh, this softness! I\'m impressed, |PLAYERNAME|. You\'re on the best way to earn that turban. Now, please retrieve 100 fish fins.'
-- 		}
-- 	},
-- 	['fish fins'] = {
-- 		itemId = 5895,
-- 		count = 100,
-- 		storageValue = 2,
-- 		text = {
-- 			'Were you able to discover the undersea race and retrieved 100 fish fins?',
-- 			'I really wonder what the explorer society is up to. Actually I have no idea how they managed to dive unterwater.',
-- 			'I never thought you\'d make it, |PLAYERNAME|. Now we only need two enchanted chicken wings to start our waterwalking test!'
-- 		}
-- 	},
-- 	['enchanted chicken wings'] = {
-- 		itemId = 5891,
-- 		count = 2,
-- 		storageValue = 3,
-- 		text = {
-- 			'Were you able to get hold of two enchanted chicken wings?',
-- 			'Enchanted chicken wings are actually used to make boots of haste, so they could be magically extracted again. Djinns are said to be good at that.',
-- 			'Great, thank you very much. Just bring me 100 pieces of blue cloth now and I will happily show you how to make a turban.'
-- 		}
-- 	},
-- 	['blue cloth'] = {
-- 		itemId = 5912,
-- 		count = 100,
-- 		storageValue = 4,
-- 		text = {
-- 			'Ah, have you brought the 100 pieces of blue cloth?',
-- 			'It\'s a great material for turbans.',
-- 			'Ah! Congratulations - I hope this veil will turn out as beautiful as you are. Here, I\'ll do it for you.'
-- 		}
-- 	}
-- }

local config = {
	['ape fur'] = {
		itemId = 5883,
		count = 100,
		storageValue = 1,
		text = {
			'Voce realmente conseguiu cumprir a tarefa e trouxe 100 unidades de ape fur?',
			'Somente pelos de macaco sao dignos de tocar os pes do nosso Califa.',
			'Ahhh, que maciez! Estou impressionado, |PLAYERNAME|. Voce esta no caminho certo para conquistar esse turbante. Agora, por favor, traga 100 barbatanas de peixe.'
		}
	},
	['fish fins'] = {
		itemId = 5895,
		count = 100,
		storageValue = 2,
		text = {
			'Voce conseguiu descobrir a raca submarina e trazer 100 fish fins?',
			'Eu realmente me pergunto o que a sociedade de exploradores esta fazendo. Na verdade, nao faco ideia de como eles conseguiram mergulhar debaixo d\'agua.',
			'Nunca pensei que voce conseguiria, |PLAYERNAME|. Agora so precisamos de duas asas de galinha encantadas para comecar nosso teste de caminhar sobre a agua!'
		}
	},
	['enchanted chicken wings'] = {
		itemId = 5891,
		count = 2,
		storageValue = 3,
		text = {
			'Voce conseguiu obter duas enchanted chicken wings?',
			'Enchanted chicken wings sao usadas para fabricar botas de velocidade, entao sua magia pode ser extraida novamente. Dizem que os djinns sao bons nisso.',
			'Excelente, muito obrigado. Agora traga 100 pedacos de tecido azul e terei prazer em lhe mostrar como fazer um turbante.'
		}
	},
	['blue cloth'] = {
		itemId = 5912,
		count = 100,
		storageValue = 4,
		text = {
			'Ah, voce trouxe os 100 blue pieces of cloth?',
			'E um excelente material para turbantes.',
			'Ah! Parabens! Espero que este veu fique tao bonito quanto voce. Aqui, vou faze-lo para voce.'
		}
	}
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local storageVirtude = player:getStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso)

	if MsgContains(message, 'outfit') then
		npcHandler:say(player:getSex() == PLAYERSEX_FEMALE and 'Hehe, gostaria de usar um veu bonito como o meu? Bom... eu poderia te ajudar com isso, mas voce precisaria cumprir uma task para mim antes.' or 'Nao, definitivalemte nao. Se quiser um addon, va falar com Razan.', npc, creature)
	elseif MsgContains(message, 'task') then
		if player:getSex() == PLAYERSEX_MALE then
			npcHandler:say('Nao tenho nenhum trabalho pra voce no momento...', npc, creature)
			return true
		end
		if player:getStorageValue(Storage.Quest.U7_8.OutfitQuest.SecondOrientalAddon) < 1 then
			npcHandler:say('Voce gostaria de provar que merece usar tal adorno?', npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
	elseif config[message] and npcHandler:getTopic(playerId) == 0 then
		if player:getStorageValue(Storage.Quest.U7_8.OutfitQuest.SecondOrientalAddon) == config[message].storageValue then
			npcHandler:say(config[message].text[1], npc, creature)
			npcHandler:setTopic(playerId, 3)
			topic[playerId] = message
		else
			npcHandler:say(config[message].text[2], npc, creature)
		end
	elseif MsgContains(message, 'missao') or MsgContains(message, 'mission') or MsgContains(message, 'heart') then
		if storageVirtude == 17 then
			npcHandler:say('UM WRITHING HEART? Por favor, me diga que voce tem um. Eu preciso muito dele para dar de presente para alguem... \z
			Sabe, Kaleb precisa muito de um desses para que possa ajudar sua familia e disse que dara um desconto vitalicio em dromedarios para quem ajuda-lo. \z
			Como minha familia cria dromedarios eu vou ganhar muito com isso e, claro, ele ficara muito feliz. Nao acha uma boa causa? Eu acho que realmente mereco o Writhing Heart.', npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	-- elseif MsgContains(message, 'scarab cheese') then
	-- 	if player:getStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission03) == 1 then
	-- 		npcHandler:say('Let me cover my nose before I get this for you... Would you REALLY like to buy scarab cheese for 100 gold?', npc, creature)
	-- 	elseif player:getStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission03) == 2 then
	-- 		npcHandler:say('Oh the last cheese molded? Would you like to buy another one for 100 gold?', npc, creature)
	-- 	end
	-- 	npcHandler:setTopic(playerId, 4)
	elseif MsgContains(message, 'yes') or MsgContains(message, 'sim') then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say({
				'Muito bem, entao preste atencao aos seguintes requisitos. Estamos precisando urgentemente de ape fur, ja que o Califa pediu um tapete novo para o banheiro...',
				'Portanto, traga-me 100 unidades de Ape Fur. Em segundo lugar, chegou aos nossos ouvidos que a sociedade de exploradores descobriu uma nova raca submarina de homens-peixe...',
				'Dizem que as nadadeiras deles permitem que humanos caminhem sobre a água! Por favor, traga-nos 100 dessas nadadeiras (Fish Fin)...',
				'Em terceiro lugar, caso o plano de caminhar sobre a agua falhe, precisaremos de Enchanted Chicken Wings para evitar que os testadores se afoguem. Traga-me duas, por favor...',
				'Por fim, mas nao menos importante, basta aparecer com 100 Blue Pieces of Cloth, e terei o prazer de lhe ensinar como fazer um turbante...',
				'Voce entendeu tudo o que eu disse e esta disposto a realizar esta tarefa?'
			}, npc, creature)
			npcHandler:setTopic(playerId, 2)
		elseif npcHandler:getTopic(playerId) == 2 then
			if player:getStorageValue(Storage.Quest.U7_8.OutfitQuest.DefaultStart) ~= 1 then
				player:setStorageValue(Storage.Quest.U7_8.OutfitQuest.DefaultStart, 1)
			end
			player:setStorageValue(Storage.Quest.U7_8.OutfitQuest.SecondOrientalAddon, 1)
			npcHandler:say('Excelente! Retorne quando tiver coletado 100 unidades de pelo (fur).', npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 3 then
			local targetMessage = config[topic[playerId]]
			if not player:removeItem(targetMessage.itemId, targetMessage.count) then
				npcHandler:say('Que mentira deslavada!', npc, creature)
				npcHandler:setTopic(playerId, 0)
				return true
			end
			player:setStorageValue(Storage.Quest.U7_8.OutfitQuest.SecondOrientalAddon, player:getStorageValue(Storage.Quest.U7_8.OutfitQuest.SecondOrientalAddon) + 1)
			if player:getStorageValue(Storage.Quest.U7_8.OutfitQuest.SecondOrientalAddon) == 5 then
				player:addOutfitAddon(146, 2)
				player:addOutfitAddon(150, 2)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			end
			npcHandler:say(targetMessage.text[3], npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 4 then
			if player:getMoney() + player:getBankBalance() >= 100 then
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission03, 2)
				player:addItem(169, 1)
				player:removeMoneyBank(100)
				npcHandler:say('Aqui esta.', npc, creature)
			else
				npcHandler:say('Voce nao tem dinheiro o suficiente.', npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
		end
	elseif (MsgContains(message, 'no') or MsgContains(message, 'nao')) and npcHandler:getTopic(playerId) ~= 0 then
		npcHandler:say('Que pena.', npc, creature)
		npcHandler:setTopic(playerId, 0)
	end
	return true
end

local function onReleaseFocus(npc, creature)
	local playerId = creature:getId()
	topic[playerId] = nil
end

keywordHandler:addKeyword({'drink'}, StdModule.say, {npcHandler = npcHandler, text = 'I can offer you lemonade, camel milk, and water. If you\'d like to see my offers, ask me for a {trade}.'})
keywordHandler:addKeyword({'food'}, StdModule.say, {npcHandler = npcHandler, text = 'Are you looking for food? I have bread, cheese, ham, and meat. If you\'d like to see my offers, ask me for a {trade}.'})

npcHandler:setMessage(MESSAGE_GREET, 'Daraman\'s blessings, |PLAYERNAME|. Welcome to the Enlightened Oasis. Sit down, have a {drink} or some {food}!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Daraman\'s blessings. Come back soon.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_REMOVE_INTERACTION, onReleaseFocus)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "bread", clientId = 3600, buy = 4 },
	{ itemName = "cheese", clientId = 3607, buy = 6 },
	{ itemName = "ham", clientId = 3582, buy = 8 },
	{ itemName = "ice cube", clientId = 7441, sell = 250 },
	{ itemName = "meat", clientId = 3577, buy = 5 },
	{ itemName = "mug of lemonade", clientId = 2880, buy = 3, count = 12 },
	{ itemName = "mug of milk", clientId = 2880, buy = 5, count = 9 },
	{ itemName = "mug of water", clientId = 2880, buy = 2, count = 1 },
	{ itemName = "scarab cheese", clientId = 169, buy = 100 }
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

npcType:register(npcConfig)
