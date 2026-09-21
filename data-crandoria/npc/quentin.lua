local internalNpcName = "Quentin"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 57
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

-- -- Wooden Stake Quest
-- local stakeKeyword = keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler,
-- 		text = {
-- 			'A blessed stake to defeat evil spirits? I do know an old prayer which is said to grant sacred power and to be able to bind this power to someone, or something. ...',
-- 			'However, this prayer needs the combined energy of ten priests. Each of them has to say one line of the prayer. ...',
-- 			'I could start with the prayer, but since the next priest has to be in a different location, you probably will have to travel a lot. ...',
-- 			'Is this stake really important enough to you so that you are willing to take this burden?',
-- 		}}, function(player) return player:getStorageValue(Storage.Quest.U7_8.FriendsandTraders.TheBlessedStake) == -1 end
-- 	)
-- 	stakeKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Alright, I guess you need a stake first. Maybe Gamon can help you, the leg of a chair or something could just do. Try asking him for a stake, and if you have one, bring it back to me.', reset = true, ungreet = true}, nil, function(player) player:setStorageValue(Storage.Quest.U7_8.FriendsandTraders.DefaultStart, 1) player:setStorageValue(Storage.Quest.U7_8.FriendsandTraders.TheBlessedStake, 1) end)

-- -- First prayer
-- keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'I guess you couldn\'t convince Gamon to give you a stake, eh?'}, function(player) return player:getStorageValue(Storage.Quest.U7_8.FriendsandTraders.TheBlessedStake) == 1 and player:getItemCount(5941) == 0 end)

-- local stakeKeyword = keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'Yes, I was informed what to do. Are you prepared to receive my line of the prayer?'}, function(player) return player:getStorageValue(Storage.Quest.U7_8.FriendsandTraders.TheBlessedStake) == 1 end)
-- 	stakeKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'So receive my prayer: \'Light shall be near - and darkness afar\'. Now, bring your stake to Tibra in the Carlin church for the next line of the prayer. I will inform her what to do.', reset = true}, nil,
-- 		function(player) player:setStorageValue(Storage.Quest.U7_8.FriendsandTraders.TheBlessedStake, 2) player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE) end
-- 	)
-- 	stakeKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'I will wait for you.', reset = true})

-- keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'You should visit Tibra in the Carlin church now.'}, function(player) return player:getStorageValue(Storage.Quest.U7_8.FriendsandTraders.TheBlessedStake) == 2 end)
-- keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'You already received my line of the prayer.'})


-- -- Adventurer Stone
-- keywordHandler:addKeyword({'adventurer stone'}, StdModule.say, {npcHandler = npcHandler, text = 'Keep your adventurer\'s stone well.'}, function(player) return player:getItemById(16277, true) end)

-- local stoneKeyword = keywordHandler:addKeyword({'adventurer stone'}, StdModule.say, {npcHandler = npcHandler, text = 'Ah, you want to replace your adventurer\'s stone for free?'}, function(player) return player:getStorageValue(Storage.AdventurersGuild.FreeStone.Quentin) ~= 1 end)
-- 	stoneKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Here you are. Take care.', reset = true}, nil, function(player) player:addItem(16277, 1) player:setStorageValue(Storage.AdventurersGuild.FreeStone.Quentin, 1) end)
-- 	stoneKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'No problem.', reset = true})

-- local stoneKeyword = keywordHandler:addKeyword({'adventurer stone'}, StdModule.say, {npcHandler = npcHandler, text = 'Ah, you want to replace your adventurer\'s stone for 30 gold?'})
-- 	stoneKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Here you are. Take care.', reset = true},
-- 		function(player) return player:getMoney() + player:getBankBalance() >= 30 end,
-- 		function(player) if player:removeMoneyBank(30) then player:addItem(16277, 1) end end
-- 	)
-- 	stoneKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Sorry, you don\'t have enough money.', reset = true})
-- 	stoneKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'No problem.', reset = true})

-- -- Healing
-- local function addHealKeyword(text, condition, effect)
-- 	keywordHandler:addKeyword({'heal'}, StdModule.say, {npcHandler = npcHandler, text = text},
-- 		function(player) return player:getCondition(condition) ~= nil end,
-- 		function(player)
-- 			player:removeCondition(condition)
-- 			player:getPosition():sendMagicEffect(effect)
-- 		end
-- 	)
-- end

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId() 

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

    if MsgContains(message, "adventurer stone") or MsgContains(message, "adventurers stone") or MsgContains(message, "adventurer's stone") then
		npcHandler:say("A Adventurer's Stone pode ser usada dentro de templos para te levar ate a Adventurers Guild. Gostaria de adquirir uma Adventurer Stone por 10.000 gold coins?", npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif MsgContains(message, "blessed stake") or MsgContains(message, "blessed wooden stake") then
		npcHandler:say("Se quiser um Blessed Stake, precisarei antes de um Wooden Stake. Voce tem um com voce?", npc, creature)
		npcHandler:setTopic(playerId, 2)
	elseif MsgContains(message, "primeiro dragao") then
		if player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso) == 3 then
			npcHandler:say("Ja ouvi alguns boatos sobre a existencia de tal criatura, mas nunca conheci ninguem que tivesse encontrado com o tal Primeiro Dragao. \z
			Infelizmente nao posso te ajudar. Mas talvez Comandante Crassus saiba alguma coisa. Nao custa tentar...", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
		if npcHandler:getTopic(playerId) == 1 then
			if player:removeMoneyBank(10000) then
				player:addItem(16277)
				npcHandler:say("Aqui esta sua Adventurer's Stone. Obrigado.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao possui dinheiro suficiente.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 2 then
			if player:removeItem(5941, 1) then
				npcHandler:say("Aqui esta seu Blessed Wooden Stake.", npc, creature)
				player:addItem(5942, 1)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Traga o Wooden Stake e eu poderei transforma-lo em um Blessed Wooden Stake.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end
end


keywordHandler:addKeyword({'cura'}, StdModule.say, {npcHandler = npcHandler, text = 'Voce esta machucada, crianca. Deixe-me curar suas feridas.'},
	function(player) return player:getHealth() < 100 end,
	function(player)
		local health = player:getHealth()
		if health < 100 then player:addHealth(100 - health) end
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	end
)
keywordHandler:addKeyword({'cura'}, StdModule.say, {npcHandler = npcHandler, text = 'Voce nao parece tao mal. Me desculpa, mas minhas habilidades de cura so podem ser usadas naqueles que estao em enorme sofrimento.'})

-- Basic
keywordHandler:addKeyword({'pilgrimage'}, StdModule.say, {npcHandler = npcHandler, text = 'Whenever you receive a lethal wound, your vital force is damaged and there is a chance that you lose some of your equipment. With every single of the five {blessings} you have, this damage and chance of loss will be reduced.'})
keywordHandler:addKeyword({'blessings'}, StdModule.say, {npcHandler = npcHandler, text = 'There are five blessings available in five sacred places: the {spiritual} shielding, the spark of the {phoenix}, the {embrace} of Tibia, the fire of the {suns} and the wisdom of {solitude}. Additionally, you can receive the {twist of fate} here.'})
keywordHandler:addKeyword({'spiritual'}, StdModule.say, {npcHandler = npcHandler, text = 'I see you received the spiritual shielding in the whiteflower temple south of Thais.'}, function(player) return player:hasBlessing(1) end)
keywordHandler:addAliasKeyword({'shield'})
keywordHandler:addKeyword({'embrace'}, StdModule.say, {npcHandler = npcHandler, text = 'I can sense that the druids north of Carlin have provided you with the Embrace of Tibia.'}, function(player) return player:hasBlessing(2) end)
keywordHandler:addKeyword({'suns'}, StdModule.say, {npcHandler = npcHandler, text = 'I can see you received the blessing of the two suns in the suntower near Ab\'Dendriel.'}, function(player) return player:hasBlessing(3) end)
keywordHandler:addAliasKeyword({'fire'})
keywordHandler:addKeyword({'phoenix'}, StdModule.say, {npcHandler = npcHandler, text = 'I can sense that the spark of the phoenix already was given to you by the dwarven priests of earth and fire in Kazordoon.'}, function(player) return player:hasBlessing(4) end)
keywordHandler:addAliasKeyword({'spark'})
keywordHandler:addKeyword({'solitude'}, StdModule.say, {npcHandler = npcHandler, text = 'I can sense you already talked to the hermit Eremo on the isle of Cormaya and received this blessing.'}, function(player) return player:hasBlessing(5) end)
keywordHandler:addAliasKeyword({'wisdom'})
keywordHandler:addKeyword({'spiritual'}, StdModule.say, {npcHandler = npcHandler, text = 'You can ask for the blessing of spiritual shielding in the whiteflower temple south of Thais.'})
keywordHandler:addAliasKeyword({'shield'})
keywordHandler:addKeyword({'embrace'}, StdModule.say, {npcHandler = npcHandler, text = 'The druids north of Carlin will provide you with the embrace of Tibia.'})
keywordHandler:addKeyword({'suns'}, StdModule.say, {npcHandler = npcHandler, text = 'You can ask for the blessing of the two suns in the suntower near Ab\'Dendriel.'})
keywordHandler:addAliasKeyword({'fire'})
keywordHandler:addKeyword({'phoenix'}, StdModule.say, {npcHandler = npcHandler, text = 'The spark of the phoenix is given by the dwarven priests of earth and fire in Kazordoon.'})
keywordHandler:addAliasKeyword({'spark'})
keywordHandler:addKeyword({'solitude'}, StdModule.say, {npcHandler = npcHandler, text = 'Talk to the hermit Eremo on the isle of Cormaya about this blessing.'})
keywordHandler:addAliasKeyword({'wisdom'})

npcHandler:setMessage(MESSAGE_GREET, "Ola, nobre alma. Precisa de {cura}, uma {adventurer stone} ou, quem sabe, um {blessed stake}?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)

