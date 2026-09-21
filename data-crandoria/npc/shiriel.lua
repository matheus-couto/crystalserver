local internalNpcName = "Shiriel"
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
	lookHead = 1,
	lookBody = 103,
	lookLegs = 0,
	lookFeet = 95
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
        if player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 99 then
            npcHandler:say({'Sabe, |PLAYERNAME|... os elfos que vivem em Elvenshire hoje sao pacificos. Ate muito pacificos. Por isso acho muito dificil conseguir alguns recursos importantes que geralmente so se consegue por batalhas. ...', 
            'Eu preciso de 15 Pieces of Draconian Steel e 15 Pieces of Royal Steel para consertar alguns dos meus equipamentos de alquimia. Voce poderia me ajudar com esses itens?',
			}, npc, creature)
            npcHandler:setTopic(playerId, 1)
		elseif player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 100 then
			if player:removeItem(5887, 15) and player:removeItem(5889, 15) then
				npcHandler:say("Voce foi mais rapido do que eu esperava. Incrivel! Muito obrigado. Diga ao Comandante Crassus que estou mais que satisfeito!", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 101)
				player:addExperience(5000000)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Preciso de 15 Pieces of Draconian Steel e 15 Pieces of Royal Steel. Por favor, traga tudo para mim.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
        end
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Maravilha! Ficarei aguardando. Agradeco pela sua ajuda.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 100)
			npcHandler:setTopic(playerId, 0)
		end
    end
end


npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcConfig.shop = {
	{ itemName = "avalanche rune", clientId = 3161, buy = 57 },
	{ itemName = "blank rune", clientId = 3147, buy = 10 },
	{ itemName = "chameleon rune", clientId = 3178, buy = 210 },
	{ itemName = "convince creature rune", clientId = 3177, buy = 80 },
	{ itemName = "cure poison rune", clientId = 3153, buy = 65 },
	{ itemName = "destroy field rune", clientId = 3148, buy = 15 },
	{ itemName = "durable exercise rod", clientId = 35283, buy = 1250000, count = 1800 },
	{ itemName = "durable exercise wand", clientId = 35284, buy = 1250000, count = 1800 },
	{ itemName = "empty potion flask", clientId = 283, sell = 5 },
	{ itemName = "empty potion flask", clientId = 284, sell = 5 },
	{ itemName = "empty potion flask", clientId = 285, sell = 5 },
	{ itemName = "energy field rune", clientId = 3164, buy = 38 },
	{ itemName = "energy wall rune", clientId = 3166, buy = 85 },
	{ itemName = "exercise rod", clientId = 28556, buy = 347222, count = 500 },
	{ itemName = "exercise wand", clientId = 28557, buy = 347222, count = 500 },
	{ itemName = "explosion rune", clientId = 3200, buy = 31 },
	{ itemName = "fire bomb rune", clientId = 3192, buy = 147 },
	{ itemName = "fire field rune", clientId = 3188, buy = 28 },
	{ itemName = "fire wall rune", clientId = 3190, buy = 61 },
	{ itemName = "great fireball rune", clientId = 3191, buy = 57 },
	{ itemName = "great health potion", clientId = 239, buy = 240 },
	{ itemName = "great mana potion", clientId = 238, buy = 173 },
	{ itemName = "great spirit potion", clientId = 7642, buy = 278 },
	{ itemName = "health potion", clientId = 266, buy = 53 },
	{ itemName = "heavy magic missile rune", clientId = 3198, buy = 12 },
	{ itemName = "intense healing rune", clientId = 3152, buy = 95 },
	{ itemName = "lasting exercise rod", clientId = 35289, buy = 10000000, count = 14400 },
	{ itemName = "lasting exercise wand", clientId = 35290, buy = 10000000, count = 14400 },
	{ itemName = "light magic missile rune", clientId = 3174, buy = 4 },
	{ itemName = "mana potion", clientId = 268, buy = 60 },
	{ itemName = "moonlight rod", clientId = 3070, buy = 1000 },
	{ itemName = "necrotic rod", clientId = 3069, buy = 5000 },
	{ itemName = "poison field rune", clientId = 3172, buy = 21 },
	{ itemName = "poison wall rune", clientId = 3176, buy = 52 },
	{ itemName = "snakebite rod", clientId = 3066, buy = 500 },
	{ itemName = "spellbook", clientId = 3059, buy = 150 },
	{ itemName = "spellwand", clientId = 651, sell = 299 },
	{ itemName = "stalagmite rune", clientId = 3179, buy = 12 },
	{ itemName = "strong health potion", clientId = 236, buy = 125 },
	{ itemName = "strong mana potion", clientId = 237, buy = 118 },
	{ itemName = "sudden death rune", clientId = 3155, buy = 135 },
	{ itemName = "terra rod", clientId = 3065, buy = 10000 },
	{ itemName = "ultimate healing rune", clientId = 3160, buy = 175 },
	{ itemName = "ultimate health potion", clientId = 7643, buy = 398 },
	{ itemName = "vial", clientId = 2874, sell = 5 },
	{ itemName = "wand of cosmic energy", clientId = 3073, buy = 10000 },
	{ itemName = "wand of decay", clientId = 3072, buy = 5000 },
	{ itemName = "wand of dragonbreath", clientId = 3075, buy = 1000 },
	{ itemName = "wand of vortex", clientId = 3074, buy = 500 }
}
 
-- Greeting message
keywordHandler:addGreetKeyword({"ashari"}, {npcHandler = npcHandler, text = "Saudacoes, |PLAYERNAME|."})
--Farewell message
keywordHandler:addFarewellKeyword({"asgha thrazi"}, {npcHandler = npcHandler, text = "Ate mais, |PLAYERNAME|."})

npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

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
