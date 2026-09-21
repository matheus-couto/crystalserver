local config = {
	storage = 12970, -- Storage para verificar se o jogador pode pegar novamente.
	actionId = 13113, -- action id do baú.
	timeToReward = 24, -- Tempo em horas pra pegar o bau novamente.
	
	itemsListFree = {
		{id = 3035, count = 20, chance = 90}, 
		{id = 3035, count = 50, chance = 10},
	},
	itemsListVip = {
		{id = 3035, count = 20, chance = 75}, 
		{id = 3035, count = 50, chance = 20},
		{id = 3043, count = 2, chance = 5},
	},

	itemsListFree2 = {
		{id = 3035, count = 20, chance = 61},
		{id = 3035, count = 50, chance = 35},
		{id = 9099, count = 1, chance = 1},
		{id = 3043, count = 1, chance = 3},
	},
	itemsListVip2 = {
		{id = 3035, count = 20, chance = 52},
		{id = 3035, count = 50, chance = 40},
		{id = 9099, count = 1, chance = 2},
		{id = 3043, count = 1, chance = 6},
	},

	itemsListFree3 = {
		{id = 3035, count = 20, chance = 47},
		{id = 3035, count = 50, chance = 45},
		{id = 9099, count = 1, chance = 1},
		{id = 3043, count = 1, chance = 5},
		{id = 39136, count = 1, chance = 2},
	},
	itemsListVip3 = {
		{id = 3035, count = 20, chance = 10 },
		{id = 3035, count = 50, chance = 75},
		{id = 9099, count = 1, chance = 3},
		{id = 3043, count = 1, chance = 10},
		{id = 39136, count = 1, chance = 2},
	},

	itemsListFree4 = {
		{id = 3035, count = 20, chance = 27},
		{id = 3035, count = 50, chance = 49},
		{id = 9099, count = 1, chance = 1},
		{id = 3043, count = 1, chance = 20},
		{id = 39136, count = 1, chance = 2},
		{id = 11587, count = 1, chance = 1},
	},
	itemsListVip4 = {
		{id = 3035, count = 20, chance = 5 },
		{id = 3035, count = 50, chance = 37},
		{id = 9099, count = 1, chance = 3},
		{id = 3043, count = 20, chance = 48},
		{id = 26186, count = 1, chance = 2},
		{id = 39136, count = 1, chance = 2},
		{id = 11587, count = 1, chance = 2},
		{id = 25745, count = 1, chance = 1},
	},

}

local dailyRewardViridia = Action()

function dailyRewardViridia.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local function generateItemList(player)
		local itemList = config.itemsListFree

		if player:getLevel() >= 50 and player:getLevel() < 200 then
			itemList = config.itemsListFree2
		elseif player:getLevel() >= 200 and player:getLevel() < 300 then
			itemList = config.itemsListFree3
		elseif player:getLevel() >= 300 then
			itemList = config.itemsListFree4
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

		if player:getLevel() >= 50 and player:getLevel() < 200 then
			itemList = config.itemsListVip2
		elseif player:getLevel() >= 200 and player:getLevel() < 300 then
			itemList = config.itemsListVip3
		elseif player:getLevel() >= 300 then
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

	local generateList = generateItemList(player)
	local generateListVip = generateItemListVip(player)
	local storageBoost = player:getStorageValue(Storage.Quest.Crandoria.NewDailyReward.BoostCount)
	local activeBoost = player:getExpBoostStamina()
	local house = player:getHouse()
	local streak = player:getStorageValue(Storage.Quest.Crandoria.NewDailyReward.Streak)
	local streakTimer = player:getStorageValue(Storage.Quest.Crandoria.NewDailyReward.StreakTimer)

	local function getMinutes(seconds)
		return math.floor(seconds/60)
	end

	if DailyReward.isRewardTaken(player) then
		player:sendError("Voce ja obteve sua recompensa hoje.")
		return false
	end

	if player:getVipDays() > 0 then

		while #generateList == 0 and #generateListVip == 0 do
			generateListVip = generateItemListVip(player)
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
	
		while #generateList == 0 and #generateListVip == 0 do
			generateList = generateItemList(player)
			-- generateListVip = generateItemListVip(player)
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
	end

end



dailyRewardViridia:aid(13113)
dailyRewardViridia:register()


	