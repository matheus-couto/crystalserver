-- local internalNpcName = "Frosty"
-- local npcType = Game.createNpcType(internalNpcName)
-- local npcConfig = {}

-- npcConfig.name = internalNpcName
-- npcConfig.description = internalNpcName

-- npcConfig.health = 100
-- npcConfig.maxHealth = npcConfig.health
-- npcConfig.walkInterval = 2000
-- npcConfig.walkRadius = 2

-- npcConfig.outfit = {
-- 	lookType = 1159
-- }

-- npcConfig.flags = {
-- 	floorchange = false
-- }

-- local keywordHandler = KeywordHandler:new()
-- local npcHandler = NpcHandler:new(keywordHandler)
-- local talkState = {}
-- local rtnt = {}

-- npcType.onAppear = function(npc, creature)
-- 	npcHandler:onAppear(npc, creature)
-- end

-- npcType.onDisappear = function(npc, creature)
-- 	npcHandler:onDisappear(npc, creature)
-- end

-- npcType.onSay = function(npc, creature, type, message)
-- 	npcHandler:onSay(npc, creature, type, message)
-- end

-- npcType.onCloseChannel = function(npc, creature)
-- 	npcHandler:onCloseChannel(npc, creature)
-- end

-- npcType.onThink = function(npc, interval)
-- 	npcHandler:onThink(npc, interval)
-- end

-- local sleightInfo = {
-- ['bright percht sleigh'] = {cost = 0, items = {{30192,1}}, mount = 133, storageID = Storage.Percht1},
-- ['cold percht sleigh'] = {cost = 0, items = {{30192,1}}, mount = 132, storageID = Storage.Percht2},
-- ['dark percht sleigh'] = {cost = 0, items = {{30192,1}}, mount = 134, storageID = Storage.Percht3}
-- }

-- local monsterName = {'bright percht sleigh', 'cold percht sleigh', 'dark percht sleigh'}

-- local function creatureSayCallback(npc, creature, type, message)
-- 	local player = Player(creature)
-- 	local playerId = player:getId()

-- 	if sleightInfo[message] ~= nil then
-- 		if (getPlayerStorageValue(creature, sleightInfo[message].storageID) == 1) then
-- 				npcHandler:say('Voce ja possui essa montaria!', npc, creature)
-- 				npcHandler:resetNpc()
-- 		else
-- 		local itemsTable = sleightInfo[message].items
-- 		local items_list = ''
-- 			if table.maxn(itemsTable) > 0 then
-- 				for i = 1, table.maxn(itemsTable) do
-- 					local item = itemsTable[i]
-- 					items_list = items_list .. item[2] .. ' ' .. ItemType(item[1]):getName()
-- 					if i ~= table.maxn(itemsTable) then
-- 						items_list = items_list .. ', '
-- 					end
-- 				end
-- 			end
-- 		local text = ''
-- 			if (sleightInfo[message].cost > 0) then
-- 				text = sleightInfo[message].cost .. ' gp'
-- 			elseif table.maxn(sleightInfo[message].items) then
-- 				text = items_list
-- 			elseif (sleightInfo[message].cost > 0) and table.maxn(sleightInfo[message].items) then
-- 				text = items_list .. ' and ' .. sleightInfo[message].cost .. ' gp'
-- 			end
-- 			npcHandler:say('Para o ' .. message .. ' voce precisara de ' .. text .. '. Voce tem o item com voce?', npc, creature)
-- 			rtnt[playerId] = message
-- 			talkState[playerId] = sleightInfo[message].storageID
-- 			return true
-- 		end
-- 	elseif message:lower() == 'percht' then
-- 		npcHandler:say('Nasty creatures especially their queen that sits frozzen on her throne beneath this island.', npc, creature)
-- 	elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
-- 		if (talkState[playerId] >= Storage.Percht1 and talkState[playerId] <= Storage.Percht3) then
-- 			local items_number = 0
-- 			if table.maxn(sleightInfo[rtnt[playerId]].items) > 0 then
-- 				for i = 1, table.maxn(sleightInfo[rtnt[playerId]].items) do
-- 					local item = sleightInfo[rtnt[playerId]].items[i]
-- 					if (getPlayerItemCount(creature,item[1]) >= item[2]) then
-- 						items_number = items_number + 1
-- 					end
-- 				end
-- 			end
-- 			if(player:removeMoneyBank(sleightInfo[rtnt[playerId]].cost) and (items_number == table.maxn(sleightInfo[rtnt[playerId]].items))) then
-- 				if table.maxn(sleightInfo[rtnt[playerId]].items) > 0 then
-- 					for i = 1, table.maxn(sleightInfo[rtnt[playerId]].items) do
-- 						local item = sleightInfo[rtnt[playerId]].items[i]
-- 						doPlayerRemoveItem(creature,item[1],item[2])
-- 					end
-- 				end
-- 				doPlayerAddMount(creature, sleightInfo[rtnt[playerId]].mount)
-- 				setPlayerStorageValue(creature,sleightInfo[rtnt[playerId]].storageID,1)
-- 				npcHandler:say('Ai esta voce!', npc, creature)
-- 			else
-- 				npcHandler:say('Voce nao possui os itens necessarios!', npc, creature)
-- 			end
-- 			rtnt[playerId] = nil
-- 			talkState[playerId] = 0
-- 			npcHandler:resetNpc()
-- 			return true
-- 		end
-- 	elseif MsgContains(message, "mount") or MsgContains(message, "mounts") or MsgContains(message, "montaria") or MsgContains(message, "sleigh") or MsgContains(message, "sleighs") then
-- 		npcHandler:say('Eu posso te oferecer uma das montarias: {' .. table.concat(monsterName, "}, {") .. '}.', npc, creature)
-- 		rtnt[playerId] = nil
-- 		talkState[playerId] = 0
-- 		npcHandler:resetNpc()
-- 		return true
-- 	elseif MsgContains(message, "help") or MsgContains(message, "ajuda") then
-- 		npcHandler:say('Apenas me diga sobre qual {montaria} voce gostaria de saber mais.', npc, creature)
-- 		rtnt[playerId] = nil
-- 		talkState[playerId] = 0
-- 		npcHandler:resetNpc()
-- 		return true
-- 	else
-- 		if talkState[playerId] ~= nil then
-- 			if talkState[playerId] > 0 then
-- 			npcHandler:say('Retorne quando tiver os itens.', npc, creature)
-- 			rtnt[playerId] = nil
-- 			talkState[playerId] = 0
-- 			npcHandler:resetNpc()
-- 			return true
-- 			end
-- 		end
-- 	end
-- 	return true
-- end

-- keywordHandler:addKeyword({'carrot'}, StdModule.say, {npcHandler = npcHandler, text = "What about 'no' do you not understand, hrm? You are more annoying than any {percht} around here! Not to mention those bothersome {bunnies} who try to graw away my nose!"})
-- keywordHandler:addKeyword({'percht skull'}, StdModule.say, {npcHandler = npcHandler, text = "Well why didn't you say that rightaway, if you give me such a skull I can give you one of my {sleighs}."})
-- keywordHandler:addKeyword({'bunnies'}, StdModule.say, {npcHandler = npcHandler, text = "Always trying to eat my nose!"})

-- npcHandler:setMessage(MESSAGE_GREET, "Ola, viajante das neves. Fale comigo se estiver interessado em uma nova {montaria} especial. Ou, talvez, voce queira {melhorar} sua montaria...")

-- npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
-- npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- -- npcType registering the npcConfig table
-- npcType:register(npcConfig)


local internalNpcName = "Frosty"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
    lookType = 1159
}

npcConfig.flags = {
    floorchange = false
}

-- local keywordHandler = KeywordHandler:new()
-- local npcHandler = NpcHandler:new(keywordHandler)
-- local talkState = {}
-- local rtnt = {}

-- npcType.onAppear = function(npc, creature)
--     npcHandler:onAppear(npc, creature)
-- end

-- npcType.onDisappear = function(npc, creature)
--     npcHandler:onDisappear(npc, creature)
-- end

-- npcType.onSay = function(npc, creature, type, message)
--     npcHandler:onSay(npc, creature, type, message)
-- end

-- npcType.onCloseChannel = function(npc, creature)
--     npcHandler:onCloseChannel(npc, creature)
-- end

-- npcType.onThink = function(npc, interval)
--     npcHandler:onThink(npc, interval)
-- end

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

-- local sleightInfo = {
--     ['bright percht sleigh'] = {cost = 0, items = {{30192,1}}, mount = 133, storageID = Storage.Percht1},
--     ['cold percht sleigh'] = {cost = 0, items = {{30192,1}}, mount = 132, storageID = Storage.Percht2},
--     ['dark percht sleigh'] = {cost = 0, items = {{30192,1}}, mount = 134, storageID = Storage.Percht3}
-- }


-- local monsterName = {'bright percht sleigh', 'cold percht sleigh', 'dark percht sleigh'}


local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

	if MsgContains(message, "montaria") then
		npcHandler:say("Posso te oferecer tres montarias diferentes: {bright percht sleigh}, {cold percht sleigh} e {dark percht sleigh}. Qual voce prefere?", npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif MsgContains(message, "bright percht sleigh") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Para obter a montaria bright percht sleigh voce precisa entregar uma Percht Skull. Voce possui uma com voce?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		end
	elseif MsgContains(message, "cold percht sleigh") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Para obter a montaria cold percht sleigh voce precisa entregar uma Percht Skull. Voce possui uma com voce?", npc, creature)
			npcHandler:setTopic(playerId, 3)
		end
	elseif MsgContains(message, "dark percht sleigh") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Para obter a montaria dark percht sleigh voce precisa entregar uma Percht Skull. Voce possui uma com voce?", npc, creature)
			npcHandler:setTopic(playerId, 4)
		end
	elseif MsgContains(message, "outfit") then
		npcHandler:say("Deseja receber o Percht Outfit como recompensa por derrotar a Percht Queen?", npc, creature)
		npcHandler:setTopic(playerId, 11)
	elseif MsgContains(message, "addon") then
		npcHandler:say("Deseja receber os addons do Percht Outfit como recompensa por derrotar a Percht Queen?", npc, creature)
		npcHandler:setTopic(playerId, 12)
	elseif MsgContains(message, "primeiro") then
		if npcHandler:getTopic(playerId) == 13 then
			if player:getBosstiaryKills("The Percht Queen") > 4 then
				npcHandler:say("Aqui esta seu addon.", npc, creature)
				player:addOutfitAddon(1161, 1)
                player:addOutfitAddon(1162, 1)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao derrotou a Percht Queen vezes o suficiente.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	elseif MsgContains(message, "segundo") then
		if npcHandler:getTopic(playerId) == 13 then
			if player:getBosstiaryKills("The Percht Queen") > 9 then
				npcHandler:say("Aqui esta seu addon.", npc, creature)
				player:addOutfitAddon(1161, 2)
                player:addOutfitAddon(1162, 2)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao derrotou a Percht Queen vezes o suficiente.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
		if npcHandler:getTopic(playerId) == 2 then
			if player:getStorageValue(Storage.Percht1) < 1 then
				if player:removeItem(30192, 1) then
					player:addMount(133)
					player:setStorageValue(Storage.Percht1, 1)
					npcHandler:say("Muito bem, aqui esta sua nova montaria!", npc, creature)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Voce nao possui o item necessario.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			elseif player:getStorageValue(Storage.Percht1) == 1 then
				npcHandler:say("Voce ja possui essa montaria. Gostaria de evoluir seu Bright Percht Sleigh?", npc, creature)
				npcHandler:setTopic(playerId, 5)
			elseif player:getStorageValue(Storage.Percht1) == 2 then
				npcHandler:say("Voce ja possui a segunda versao dessa montaria. Gostaria de evoluir seu Bright Percht Sleigh Variant?", npc, creature)
				npcHandler:setTopic(playerId, 8)
			elseif player:getStorageValue(Storage.Percht1) == 3 then
				npcHandler:say("Voce ja possui a melhor versao dessa montaria.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 3 then
			if player:getStorageValue(Storage.Percht2) < 1 then
				if player:removeItem(30192, 1) then
					player:addMount(132)
					player:setStorageValue(Storage.Percht2, 1)
					npcHandler:say("Muito bem, aqui esta sua nova montaria!", npc, creature)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Voce nao possui o item necessario.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			elseif player:getStorageValue(Storage.Percht2) == 1 then
				npcHandler:say("Voce ja possui essa montaria. Gostaria de evoluir seu Cold Percht Sleigh?", npc, creature)
				npcHandler:setTopic(playerId, 6)
			elseif player:getStorageValue(Storage.Percht2) == 2 then
				npcHandler:say("Voce ja possui a segunda versao dessa montaria. Gostaria de evoluir seu Cold Percht Sleigh Variant?", npc, creature)
				npcHandler:setTopic(playerId, 9)
			elseif player:getStorageValue(Storage.Percht2) == 3 then
				npcHandler:say("Voce ja possui a melhor versao dessa montaria.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 4 then
			if player:getStorageValue(Storage.Percht3) < 1 then
				if player:removeItem(30192, 1) then
					player:addMount(134)
					player:setStorageValue(Storage.Percht3, 1)
					npcHandler:say("Muito bem, aqui esta sua nova montaria!", npc, creature)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Voce nao possui o item necessario.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			elseif player:getStorageValue(Storage.Percht3) == 1 then
				npcHandler:say("Voce ja possui essa montaria. Gostaria de evoluir seu Dark Percht Sleigh?", npc, creature)
				npcHandler:setTopic(playerId, 7)
			elseif player:getStorageValue(Storage.Percht3) == 2 then
				npcHandler:say("Voce ja possui a segunda versao dessa montaria. Gostaria de evoluir seu Dark Percht Sleigh Variant?", npc, creature)
				npcHandler:setTopic(playerId, 10)
			elseif player:getStorageValue(Storage.Percht3) == 3 then
				npcHandler:say("Voce ja possui a melhor versao dessa montaria.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 5 then
			if player:removeItem(30192, 1) then
				player:removeMount(133)
				player:addMount(148)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				player:setStorageValue(Storage.Percht1, 2)
				npcHandler:say("Muito bem, aqui esta sua nova montaria!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao possui o item necessario.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 6 then
			if player:removeItem(30192, 1) then
				player:removeMount(132)
				player:addMount(147)
				player:setStorageValue(Storage.Percht2, 2)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				npcHandler:say("Muito bem, aqui esta sua nova montaria!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao possui o item necessario.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 7 then
			if player:removeItem(30192, 1) then
				player:removeMount(134)
				player:addMount(149)
				player:setStorageValue(Storage.Percht3, 2)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				npcHandler:say("Muito bem, aqui esta sua nova montaria!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao possui o item necessario.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 8 then
			if player:removeItem(30192, 1) then
				player:removeMount(148)
				player:addMount(151)
				player:setStorageValue(Storage.Percht1, 3)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				npcHandler:say("Muito bem, aqui esta sua nova montaria!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao possui o item necessario.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 9 then
			if player:removeItem(30192, 1) then
				player:removeMount(147)
				player:addMount(150)
				player:setStorageValue(Storage.Percht2, 3)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				npcHandler:say("Muito bem, aqui esta sua nova montaria!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao possui o item necessario.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 10 then
			if player:removeItem(30192, 1) then
				player:removeMount(149)
				player:addMount(152)
				player:setStorageValue(Storage.Percht3, 3)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				npcHandler:say("Muito bem, aqui esta sua nova montaria!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao possui o item necessario.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 11 then
			-- if player:getStorageValue
			if player:getBosstiaryKills("The Percht Queen") > 0 then
				if player:hasOutfit(1161) then
					npcHandler:say("Voce ja possui este outfit.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Aqui esta seu Percht Outfit.", npc, creature)
					player:addOutfit(1161, 0)
					player:addOutfit(1162, 0)
					npcHandler:setTopic(playerId, 0)
				end
			else
				npcHandler:say("Sinto mutio, mas voce nao derrotou a Percht Queen e, portanto, nao podera obter o outfit.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 12 then
			npcHandler:say("Voce deseja o {primeiro} ou o {segundo} addon?", npc, creature)
			npcHandler:setTopic(playerId, 13)
		end
	end

end

-- keywordHandler:addKeyword({'carrot'}, StdModule.say, {npcHandler = npcHandler, text = "What about 'no' do you not understand, hrm? You are more annoying than any {percht} around here! Not to mention those bothersome {bunnies} who try to graw away my nose!"})
-- keywordHandler:addKeyword({'percht skull'}, StdModule.say, {npcHandler = npcHandler, text = "Well why didn't you say that rightaway, if you give me such a skull I can give you one of my {sleighs}."})
-- keywordHandler:addKeyword({'bunnies'}, StdModule.say, {npcHandler = npcHandler, text = "Always trying to eat my nose!"})

npcHandler:setMessage(MESSAGE_GREET, "Ola, viajante das neves. Fale comigo se estiver interessado em uma nova {montaria} especial.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
