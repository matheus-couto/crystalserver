local internalNpcName = "Wyda"
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
	lookBody = 119,
	lookLegs = 119,
	lookFeet = 126
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

local condition = Condition(CONDITION_FIRE)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:addDamage(60, 2000, -10)

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end


	if MsgContains(message, 'cookie') or MsgContains(message, 'biscoito') then
		if player:getStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.Questline) == 31
				and player:getStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.CookieDelivery.Wyda) ~= 1 then
			npcHandler:say('Voce me trouxe um cookie?', npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
	-- elseif MsgContains(message, 'mission') or MsgContains(message, 'quest') or MsgContains(message, 'missao') then
	-- 	npcHandler:say({
	-- 		"A quest? Well, if you\'re so keen on doing me a favour... Why don\'t you try to find a {blood herb}?",
	-- 		"To be honest, I\'m drowning in blood herbs by now."
	-- 	}, npc, creature)
	-- 	npcHandler:setTopic(playerId, 0)
	-- elseif MsgContains(message, 'bloodherb') or MsgContains(message, 'blood herb') then
	-- 	if player:getStorageValue(Storage.BloodHerbQuest) == 1  then
	-- 		npcHandler:say('Arrr... here we go again.... do you have a #$*§# blood herb for me?', npc, creature)
	-- 		npcHandler:setTopic(playerId, 2)
	-- 	else
	-- 		npcHandler:say({
	-- 			"The blood herb is very rare. This plant would be very useful for me, but I don't know any accessible places to find it.",
	-- 			"To be honest, I'm drowning in blood herbs by now. But if it helps you, well yes.. I guess I could use another blood herb..."
	-- 		}, npc, creature)
	-- 		npcHandler:setTopic(playerId, 0)
	-- 	end
	elseif MsgContains(message, 'yes') or MsgContains(message, 'sim') then
		if npcHandler:getTopic(playerId) == 1 then
			if not player:removeItem(130, 1) then
				npcHandler:say('You have no cookie that I\'d like.', npc, creature)
				npcHandler:setTopic(playerId, 0)
				return true
			end

			player:setStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.CookieDelivery.Wyda, 1)
			player:addCondition(condition)
			if player:getCookiesDelivered() == 10 then
				player:addAchievement('Allow Cookies?')
			end
			npc:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
			npcHandler:say('Well, it\'s a welcome change from all that gingerbread ... AHHH HOW DARE YOU??? FEEL MY WRATH!', npc, creature)
			npcHandler:removeInteraction(npc, creature)
			npcHandler:resetNpc(creature)
		elseif npcHandler:getTopic(playerId) == 2 then
			if player:removeItem(3734, 1) then
				player:setStorageValue(Storage.BloodHerbQuest, 2)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
				local TornTeddyRand = math.random(1, 100)
				if TornTeddyRand <= 70 then
					player:addItem(3454, 1) -- witchesbroom
					npcHandler:say('Thank you -SOOO- much! No, I really mean it! Really! Here, let me give you a reward...', npc, creature)
					npcHandler:setTopic(playerId, 0)
				else
					player:addItem(12617, 1) -- torn teddy
					npcHandler:say('Thank you -SOOO- much! No, I really mean it! Really! Ah, you know what, you can have this old thing...', npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			else
				npcHandler:say('No, you don\'t have any...', npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 3 then
			if player:getItemCount(5894) >= 50 and player:getItemCount(5896) >= 100 and player:getItemCount(5922) >= 25 and player:getItemCount(32594) >= 1 then
				player:removeItem(5894, 50)
				player:removeItem(5896, 100)
				player:removeItem(5922, 25)
				player:removeItem(32594, 1)
				player:addItem(37708, 1)
				player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress, 3)
				npcHandler:say('Deixe-me ver... Morcego... Urso.. Ahm... Ok, orquideas, claro! E onde esta... Ah! Aqui! As Lagrimas de Sangue! O mais importante. Ok, acho que era isso mesmo. \z
				Bom, a verdade e que eu ja tinha uma pocao dessas guardada o tempo todo! Hehehehe. Mas tudo bem, ficarei com os ingredientes frescos e te darei a pocao. Aqui esta.', npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say('Acredito que esteja faltando algum ingrediente com voce. Por favor cheque os ingredientes necessarios entre meus livros de receitas.', npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	elseif MsgContains(message, 'no') then
		if npcHandler:getTopic(playerId) ~= 0 then
			npcHandler:say('Ok...', npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, 'remedio') or MsgContains(message, 'medicine') or MsgContains(message, 'missao') or MsgContains(message, 'mission') then
		if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) == 1 then
			npcHandler:say('Remedio? Escute aqui... Eu sou uma bruxa. Nao fico fazendo pocoes para ajudar os outros. Se eu consigo fazer? Claro que sim! Eu faco qualquer coisa! Mas confesso que ja \z
			nem me lembro mais quais eram os ingredientes do tal remedio. Devo ter anotado aqui em algum lugar. Fique a vontade para procurar. Caso encontre, traga tudo para mim e te ajudarei!', npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress, 2)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) == 2 then
			npcHandler:say('Ja encontrou a receita da pocao e coletou os ingredientes necessarios?', npc, creature)
			npcHandler:setTopic(playerId, 3)
		elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) > 2 then
			npcHandler:say('Eu ja te entreguei o ultimo remedio que eu tinha. Por favor nao me amole mais com essa historia de remedio!', npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
