


----------------------------------------------------------------------------------

local config = {
	storage = 12441, -- Storage para verificar se o jogador pode pegar novamente.
	actionId = 12251, -- action id do baú.
	timeToReward = 24, -- Tempo em horas pra pegar o bau novamente.
	itemsList = {
		{id = 3035, count = 50, chance = 90}, 
		{id = 3043, count = 1, chance = 10},
	},
	itemsList2 = {
		{id = 3035, count = 50, chance = 45},
		{id = 3043, count = 1, chance = 35},
		{id = 3043, count = 5, chance = 2},
		{id = 3043, count = 2, chance = 10},
		{id = 22721, count = 1, chance = 1},
		{id = 22516, count = 1, chance = 1},
	},
	itemsList3 = {
		{id = 3043, count = 1, chance = 31},
		{id = 3043, count = 5, chance = 22},
		{id = 3043, count = 2, chance = 26},
		{id = 28552, count = 500, chance = 1},
		{id = 28553, count = 500, chance = 1},
		{id = 28554, count = 500, chance = 1},
		{id = 28555, count = 500, chance = 1},
		{id = 28556, count = 500, chance = 1},
		{id = 28557, count = 500, chance = 1},
		{id = 50293, count = 500, chance = 1},
		{id = 16244, count = 1, chance = 1},
		{id = 22721, count = 1, chance = 5},
		{id = 22516, count = 1, chance = 7},
		{id = 637, count = 1, chance = 1},
	},
	itemsList4 = {
		{id = 3043, count = 1, chance = 11},
		{id = 3043, count = 5, chance = 20},
		{id = 3043, count = 2, chance = 34},
		{id = 28552, count = 500, chance = 2},
		{id = 28553, count = 500, chance = 2},
		{id = 28554, count = 500, chance = 2},
		{id = 28555, count = 500, chance = 2},
		{id = 28556, count = 500, chance = 2},
		{id = 28557, count = 500, chance = 2},
		{id = 50293, count = 500, chance = 2},
		{id = 16244, count = 1, chance = 2},
		{id = 22721, count = 3, chance = 4},
		{id = 22516, count = 3, chance = 7},
		{id = 637, count = 1, chance = 1},
		{id = 23682, count = 1, chance = 1},
	},


	itemsListVip = {
		{id = 3043, count = 1, chance = 90},
		{id = 3043, count = 3, chance = 10},
	},
	itemsListVip2 = {
		{id = 3043, count = 1, chance = 55},
		{id = 3043, count = 5, chance = 2},
		{id = 3043, count = 2, chance = 35},
		{id = 22721, count = 1, chance = 1},
		{id = 22516, count = 1, chance = 1},
	},
	itemsListVip3 = {
		{id = 3043, count = 5, chance = 32},
		{id = 3043, count = 2, chance = 36},
		{id = 26186, count = 1, chance = 18},
		{id = 16244, count = 1, chance = 1},
		{id = 22721, count = 1, chance = 5},
		{id = 22516, count = 1, chance = 7},
		{id = 637, count = 1, chance = 1},
	},
	itemsListVip4 = {
		{id = 3043, count = 10, chance = 10},
		{id = 3043, count = 5, chance = 20},
		{id = 3043, count = 2, chance = 15},
		{id = 26186, count = 1, chance = 30},
		{id = 16244, count = 1, chance = 2},
		{id = 22721, count = 3, chance = 6},
		{id = 22516, count = 3, chance = 8},
		{id = 637, count = 1, chance = 7},
		{id = 22706, count = 1, chance = 1},
		{id = 23682, count = 1, chance = 1},
	},

}

local function generateItemList(player)
	local itemList = config.itemsList
	if player:getLevel() >= 100 and player:getLevel() < 300 then
		itemList = config.itemsList2
	elseif player:getLevel() >= 300 and player:getLevel() < 500 then
		itemList = config.itemsList3
	elseif player:getLevel() >= 500 then
		itemList = config.itemsList4
	end

	local finalList = {}
	for _, item in ipairs(itemList) do
		if math.random(100) <= item.chance then
			finalList[#finalList + 1] = item
		end
	end
	return finalList
end

local function generateItemListVip(player)
	local itemList = config.itemsListVip
	if player:getLevel() >= 100 and player:getLevel() < 300 then
		itemList = config.itemsListVip2
	elseif player:getLevel() >= 300 and player:getLevel() < 500 then
		itemList = config.itemsListVip3
	elseif player:getLevel() >= 500 then
		itemList = config.itemsListVip4
	end

	local finalListVip = {}
	for _, item in ipairs(itemList) do
		if math.random(100) <= item.chance then
			finalListVip[#finalListVip + 1] = item
		end
	end
	return finalListVip
end

-- local rewardChestVIP = Action()

-- function rewardChestVIP.onUse(player, item, fromPosition, target, toPosition, isHotkey)
-- 	local generateListVip = generateItemListVip(player)

-- 	local storageBoost = player:getStorageValue(Storage.Quest.Crandoria.NewDailyReward.BoostCount)
-- 	if storageBoost < 0 then
-- 		storageBoost = 0
-- 		player:setStorageValue(Storage.Quest.Crandoria.NewDailyReward.BoostCount, 0)
-- 	end

-- 	local streak = player:getStorageValue(Storage.Quest.Crandoria.NewDailyReward.Streak)
-- 	if streak < 0 then
-- 		streak = 0
-- 	end

-- 	local streakTimer = player:getStorageValue(Storage.Quest.Crandoria.NewDailyReward.StreakTimer)
-- 	if streakTimer < 0 then
-- 		streakTimer = 0
-- 	end

-- 	if player:getVipDays() <= 0 then
-- 		player:say("Apenas jogadores VIP podem pegar recompensas neste bau.", TALKTYPE_MONSTER_SAY)
-- 		return false
-- 	end

-- 	if DailyReward.isRewardTaken(player) then
-- 		player:sendError("You have already collected your daily reward.")
-- 		return false
-- 	end

-- 	while #generateListVip == 0 do
-- 		generateListVip = generateItemListVip(player)
-- 	end

-- 	for _, item in ipairs(generateListVip) do
-- 		if player:addItem(item.id, item.count) then
-- 			player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
-- 				string.format("Otimo! Voce recebeu %d %s(s).", item.count, ItemType(item.id):getName()))
-- 			player:sendDailyRewardCollectionState(DAILY_REWARD_COLLECTED)
-- 			player:setDailyReward(DAILY_REWARD_COLLECTED)
-- 			player:setNextRewardTime(GetDailyRewardLastServerSave() + DailyReward.serverTimeThreshold)
-- 			player:setStorageValue(DailyReward.storages.avoidDouble, GetDailyRewardLastServerSave())
-- 			break
-- 		end
-- 	end

-- 	-- STREAK
-- 	if streakTimer > os.time() then
-- 		streak = streak + 1
-- 	else
-- 		streak = 1
-- 	end

-- 	player:setStorageValue(Storage.Quest.Crandoria.NewDailyReward.Streak, streak)
-- 	player:setStorageValue(Storage.Quest.Crandoria.NewDailyReward.StreakTimer, os.time() + 36 * 60 * 60)

-- 	return true
-- end

-- rewardChestVIP:aid(13022)
-- rewardChestVIP:register()



-- ----------------------------------------------------------------------------------

local config = {
	storage = 12441, -- Storage para verificar se o jogador pode pegar novamente.
	actionId = 12251, -- action id do baú.
	timeToReward = 24, -- Tempo em horas pra pegar o bau novamente.
	itemsList = {
		{id = 3035, count = 50, chance = 90}, 
		{id = 3043, count = 1, chance = 10},
	},
	itemsList2 = {
		{id = 3035, count = 50, chance = 45},
		{id = 3043, count = 1, chance = 35},
		{id = 3043, count = 5, chance = 2},
		{id = 3043, count = 2, chance = 10},
		{id = 22721, count = 1, chance = 1},
		{id = 22516, count = 1, chance = 1},
	},
	itemsList3 = {
		{id = 3043, count = 1, chance = 31},
		{id = 3043, count = 5, chance = 22},
		{id = 3043, count = 2, chance = 27},
		{id = 28552, count = 500, chance = 1},
		{id = 28553, count = 500, chance = 1},
		{id = 28554, count = 500, chance = 1},
		{id = 28555, count = 500, chance = 1},
		{id = 28556, count = 500, chance = 1},
		{id = 28557, count = 500, chance = 1},
		{id = 16244, count = 1, chance = 1},
		{id = 22721, count = 1, chance = 5},
		{id = 22516, count = 1, chance = 7},
		{id = 637, count = 1, chance = 1},
	},
	itemsList4 = {
		{id = 3043, count = 1, chance = 11},
		{id = 3043, count = 5, chance = 20},
		{id = 3043, count = 2, chance = 36},
		{id = 28552, count = 500, chance = 2},
		{id = 28553, count = 500, chance = 2},
		{id = 28554, count = 500, chance = 2},
		{id = 28555, count = 500, chance = 2},
		{id = 28556, count = 500, chance = 2},
		{id = 28557, count = 500, chance = 2},
		{id = 16244, count = 1, chance = 2},
		{id = 22721, count = 3, chance = 4},
		{id = 22516, count = 3, chance = 7},
		{id = 637, count = 1, chance = 1},
		{id = 23682, count = 1, chance = 1},
	},


	itemsListVip = {
		{id = 3043, count = 1, chance = 90},
		{id = 3043, count = 3, chance = 10},
	},
	itemsListVip2 = {
		{id = 3043, count = 1, chance = 55},
		{id = 3043, count = 5, chance = 2},
		{id = 3043, count = 2, chance = 35},
		{id = 22721, count = 1, chance = 1},
		{id = 22516, count = 1, chance = 1},
	},
	itemsListVip3 = {
		{id = 3043, count = 5, chance = 32},
		{id = 3043, count = 2, chance = 36},
		{id = 26186, count = 1, chance = 18},
		{id = 16244, count = 1, chance = 1},
		{id = 22721, count = 1, chance = 5},
		{id = 22516, count = 1, chance = 7},
		{id = 637, count = 1, chance = 1},
	},
	itemsListVip4 = {
		{id = 3043, count = 10, chance = 10},
		{id = 3043, count = 5, chance = 20},
		{id = 3043, count = 2, chance = 15},
		{id = 26186, count = 1, chance = 30},
		{id = 16244, count = 1, chance = 2},
		{id = 22721, count = 3, chance = 6},
		{id = 22516, count = 3, chance = 8},
		{id = 637, count = 1, chance = 7},
		{id = 22706, count = 1, chance = 1},
		{id = 23682, count = 1, chance = 1},
	},

}

local function generateItemList(player)
	local itemList = config.itemsList

	if player:getLevel() >= 100 and player:getLevel() < 300 then
		itemList = config.itemsList2
	elseif player:getLevel() >= 300 and player:getLevel() < 500 then
		itemList = config.itemsList3
	elseif player:getLevel() >= 500 then
		itemList = config.itemsList4
	end

	
	local finalList = {}
	for _, item in ipairs(itemList) do
		local itemRand = math.random(100) -- random chance for each individual item listed in the list
		if itemRand <= item.chance then
			finalList[#finalList + 1] = item -- insert item into a new index of finalList
		end
	end
	return finalList
end

local function generateItemListVip(player)
	local itemList = config.itemsListVip

	if player:getLevel() >= 100 and player:getLevel() < 300 then
		itemList = config.itemsListVip2
	elseif player:getLevel() >= 300 and player:getLevel() < 500 then
		itemList = config.itemsListVip3
	elseif player:getLevel() >= 500 then
		itemList = config.itemsListVip4
	end

	local finalListVip = {}
	for _, item in ipairs(itemList) do
		local itemRand = math.random(100) -- random chance for each individual item listed in the list
		if itemRand <= item.chance then
			finalListVip[#finalListVip + 1] = item -- insert item into a new index of finalList
		end
	end
	return finalListVip
end

local function getMinutes(seconds)
	return math.floor(seconds/60)
end

local rewardChest = Action()

function rewardChest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local generateList = generateItemList(player)
	local generateListVip = generateItemListVip(player)
	local storageBoost = player:getStorageValue(Storage.Quest.Crandoria.NewDailyReward.BoostCount)
	local activeBoost = player:getExpBoostStamina()
	local house = player:getHouse()

	-- while #generateList == 0 do
	-- 	generateList = generateItemList(player)
	-- end

	while #generateList == 0 and #generateListVip == 0 do
		generateList = generateItemList(player)
		-- generateListVip = generateItemListVip(player)
	end

	-- if player:getStorageValue(config.storage) > os.time() then
	-- 	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Voce precisa esperar por %d minutos para pegar sua recompensa!", getMinutes(player:getStorageValue(config.storage) - os.time())))
	-- 	return true
	-- end

	if DailyReward.isRewardTaken(player) then
		player:sendError("You have already collected your daily reward.")
		return false
	end
	
	local timeMath = GetDailyRewardLastServerSave() - player:getNextRewardTime()
	if player:getNextRewardTime() < GetDailyRewardLastServerSave() then
		if player:getStorageValue(DailyReward.storages.notifyReset) ~= GetDailyRewardLastServerSave() then
			player:setStorageValue(DailyReward.storages.notifyReset, GetDailyRewardLastServerSave())
		end
	end

	for _, item in ipairs(generateList) do
		if player:addItem(item.id, item.count) then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format('Parabens, voce ganhou %d %s(s).', item.count, ItemType(item.id):getName()))
			if player:getPreyCards() < 1 then
				player:addPreyCards(1, true)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu uma Prey Card por nao possuir nenhuma.")
			end
			-- player:setStorageValue(config.storage, os.time() + config.timeToReward * 60 * 60)
			player:sendDailyRewardCollectionState(DAILY_REWARD_COLLECTED)
			player:setStorageValue(DailyReward.storages.avoidDouble, GetDailyRewardLastServerSave())
			player:setDailyReward(DAILY_REWARD_COLLECTED)
			player:setNextRewardTime(GetDailyRewardLastServerSave() + DailyReward.serverTimeThreshold)
			return true
		end
	end

	return true
end

rewardChest:aid(12251)
rewardChest:register()

local rewardChestVIP = Action()

function rewardChestVIP.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local generateList = generateItemList(player)
	local generateListVip = generateItemListVip(player)
	local storageBoost = player:getStorageValue(Storage.Quest.Crandoria.NewDailyReward.BoostCount)
	local activeBoost = player:getExpBoostStamina()
	local house = player:getHouse()
	local streak = player:getStorageValue(Storage.Quest.Crandoria.NewDailyReward.Streak)
	local streakTimer = player:getStorageValue(Storage.Quest.Crandoria.NewDailyReward.StreakTimer)

	local rewardItems = {
		{itemId = 26186, itemName = "Exercise Stash"},
		-- {itemId = 20138, itemName = "Small Stamina Refill"},
		{itemId = 9099, itemName = "Black Candle"},
		{itemId = 23682, itemName = "VIP Coins"},
		{itemId = 20139, itemName = "Full Stamina Refill"},
		-- {itemId = 22706, itemName = "Special Casino Ticket"},
		{itemId = 14112, itemName = "Bar of Gold"},
		{itemId = 36727, itemName = "Wealth Duplex"},
		{itemId = 36726, itemName = "Charm Upgrade"},
		{itemId = 36728, itemName = "Bestiary Betterment"},
	}
	
	local function getRandomItemToTrade()
		local randomReward = math.random(1, #rewardItems)
		return rewardItems[randomReward].itemId
	end

	while #generateList == 0 and #generateListVip == 0 do
		generateListVip = generateItemListVip(player)
	end

	if player:getVipDays() > 0 then
		-- if player:getStorageValue(config.storage) > os.time() then
		-- 	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Voce precisa esperar por %d minutos para pegar sua recompensa!", getMinutes(player:getStorageValue(config.storage) - os.time())))
		-- 	return false
		-- end

		if DailyReward.isRewardTaken(player) then
			player:sendError("You have already collected your daily reward.")
			return false
		end
		
		local timeMath = GetDailyRewardLastServerSave() - player:getNextRewardTime()
		if player:getNextRewardTime() < GetDailyRewardLastServerSave() then
			if player:getStorageValue(DailyReward.storages.notifyReset) ~= GetDailyRewardLastServerSave() then
				player:setStorageValue(DailyReward.storages.notifyReset, GetDailyRewardLastServerSave())
			end
		end


		for _, item in ipairs(generateListVip) do
			if player:addItem(item.id, item.count) then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format('Otimo! Voce recebeu %d %s(s).', item.count, ItemType(item.id):getName()))
				-- player:setStorageValue(config.storage, os.time() + config.timeToReward) -- 24h
				-- player:setStorageValue(config.storage, os.time() + 24 * 60 * 60) -- 24h
				player:sendDailyRewardCollectionState(DAILY_REWARD_COLLECTED)
				player:setStorageValue(DailyReward.storages.avoidDouble, GetDailyRewardLastServerSave())
				player:setDailyReward(DAILY_REWARD_COLLECTED)
				player:setNextRewardTime(GetDailyRewardLastServerSave() + DailyReward.serverTimeThreshold)
				if player:getPreyCards() < 3 then
					player:addPreyCards(1, true)
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu uma Prey Card por possuir um total de cards menor que 3")
				end
				if streak < 0 then
					player:setStorageValue(Storage.Quest.Crandoria.NewDailyReward.Streak, 1)
					player:setStorageValue(Storage.Quest.Crandoria.NewDailyReward.StreakTimer, os.time() + 36 * 60 * 60) -- 36h
					player:say("Sua contagem de dias consecutivos foi iniciada.", TALKTYPE_MONSTER_SAY)
				elseif streak > 0 then
					local randomItem = getRandomItemToTrade()
					if streakTimer > os.time() then
						player:setStorageValue(Storage.Quest.Crandoria.NewDailyReward.Streak, streak + 1)
						if (streak + 1) % 7 == 0 then
							player:addItem(randomItem, 1)
							player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format('Voce coletou sua recompensa diaria por %d dias seguidos e recebeu 1 %s como premio especial.', streak + 1, ItemType(randomItem):getName()))
							-- player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Voce coletou sua recompensa diaria por %d dias seguidos e recebeu um premio especial como recompensa!", newStreak))
							player:setStorageValue(Storage.Quest.Crandoria.NewDailyReward.StreakTimer, os.time() + 36 * 60 * 60) -- 36h
						else
							player:setStorageValue(Storage.Quest.Crandoria.NewDailyReward.Streak, streak + 1)
							player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Voce ja pegou sua recompensa diaria por %d dias seguidos!", streak + 1))
							player:setStorageValue(Storage.Quest.Crandoria.NewDailyReward.StreakTimer, os.time() + 36 * 60 * 60) -- 36h
						end
					else
						player:setStorageValue(Storage.Quest.Crandoria.NewDailyReward.Streak, 1)
						player:setStorageValue(Storage.Quest.Crandoria.NewDailyReward.StreakTimer, os.time() + 36 * 60 * 60) -- 36h
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Sua contagem de dias consecutivos foi iniciada.")
					end
				end

				if storageBoost < 1 then
					player:setStorageValue(Storage.Quest.Crandoria.NewDailyReward.BoostCount, 1)
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Faltam 6 dias para voce ganhar um Xp Boost de 1 hora.")
					return true
				elseif storageBoost >= 1 and storageBoost < 5 then
					player:setStorageValue(Storage.Quest.Crandoria.NewDailyReward.BoostCount, storageBoost + 1)
					player:setStorageValue(Storage.Quest.Crandoria.NewDailyReward.Streak, streak + 1)
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Faltam %d dias para receber um Xp Boost de 1 hora!", 6 - storageBoost))
					return true
				elseif storageBoost == 5 then
					player:setStorageValue(Storage.Quest.Crandoria.NewDailyReward.BoostCount, 6)
					player:setStorageValue(Storage.Quest.Crandoria.NewDailyReward.Streak, streak + 1)
					-- player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Falta %d dia para receber um Xp Boost de 1 hora!", 6 - storageBoost))
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Falta 1 dia para voce ganhar um Xp Boost de 1 hora.")
					return true
				elseif storageBoost == 6 then
					if house then
						if house:getTown():getId() == 13 then
							player:say('Donos de Cabanas amaldicoadas nao podem receber Exp Boost.', TALKTYPE_MONSTER_SAY)
							player:getPosition():sendMagicEffect(CONST_ME_POFF)
						else
							if activeBoost > 0 then
								player:say('Voce possui um Xp Boost ativo, entao podera pegar seu boost gratis com sua proxima Daily Reward.', TALKTYPE_MONSTER_SAY)
								player:getPosition():sendMagicEffect(CONST_ME_POFF)
								return true
							else
								player:setStorageValue(Storage.Quest.Crandoria.NewDailyReward.BoostCount, 0)
								player:say('Sua hora de 50% de bonus de experiencia foi iniciado!', TALKTYPE_MONSTER_SAY)
								player:setStoreXpBoost(50)
								player:setExpBoostStamina(activeBoost + 60 * 60)
								return true
							end
						end
					else
						if activeBoost > 0 then
							player:say('Voce possui um Xp Boost ativo, entao podera pegar seu boost gratis amanha.', TALKTYPE_MONSTER_SAY)
							player:getPosition():sendMagicEffect(CONST_ME_POFF)
							return true
						else
							player:setStorageValue(Storage.Quest.Crandoria.NewDailyReward.BoostCount, 0)
							player:say('Sua hora de 50% de bonus de experiencia foi iniciado!', TALKTYPE_MONSTER_SAY)
							player:setStoreXpBoost(50)
							player:setExpBoostStamina(activeBoost + 60 * 60)
							return true
						end
					end
					return true
				end
			end
		end

	else
		player:say("Apenas jogadores VIP podem pegar recompensas neste bau.", TALKTYPE_MONSTER_SAY)
		return false
	end
	return true
end

rewardChestVIP:aid(13022) 
rewardChestVIP:register()