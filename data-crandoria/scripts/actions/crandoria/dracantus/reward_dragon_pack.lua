local itemList = {
	{id = 3031, minCount = 50, maxCount = 100, chance = 100000},
	{id = 3035, minCount = 15, maxCount = 69, chance = 100000},
	{id = 3043, minCount = 3, maxCount = 10, chance = 50000},
	{id = 7430, minCount = 1, maxCount = 1, chance = 50000}, -- dragonbone staff
	{id = 3392, minCount = 1, maxCount = 1, chance = 30000}, -- royal helmet
	{id = 44603, minCount = 1, maxCount = 1, chance = 8000}, -- guardian gem
	{id = 44604, minCount = 1, maxCount = 1, chance = 5000}, -- greater guardian gem
	{id = 44606, minCount = 1, maxCount = 1, chance = 8000}, -- marksman gem
	{id = 44607, minCount = 1, maxCount = 1, chance = 5000}, -- greater marksman gem
	{id = 44608, minCount = 1, maxCount = 1, chance = 12000}, -- lesser sage gem
	{id = 44609, minCount = 1, maxCount = 1, chance = 8000}, -- sage gem
	{id = 44610, minCount = 1, maxCount = 1, chance = 5000}, -- greater sage gem
	{id = 44612, minCount = 1, maxCount = 1, chance = 8000}, -- mystic gem
	{id = 44613, minCount = 1, maxCount = 1, chance = 5000}, -- greater mystic gem
	{id = 44743, minCount = 1, maxCount = 1, chance = 50000}, -- Nimmersatt's Seal
	{id = 44750, minCount = 1, maxCount = 1, chance = 5000}, -- exalted seal
	{id = 44754, minCount = 1, maxCount = 1, chance = 3000}, -- herald's wings
	{id = 44753, minCount = 1, maxCount = 1, chance = 3000}, -- herald's insignia
	{id = 44752, minCount = 1, maxCount = 1, chance = 1000}, -- crystallized blood
	{id = 44751, minCount = 1, maxCount = 1, chance = 500}, -- gold-scaled sentinel

	-- itens raros: só UM desses 4 pode dropar por abertura, mesmo que a chance de mais de um "acerte"
	{id = 44623, minCount = 1, maxCount = 1, chance = 250, rare = true}, -- arcane dragon robe
	{id = 44621, minCount = 1, maxCount = 1, chance = 250, rare = true}, -- dauntless dragon scale armor
	{id = 44624, minCount = 1, maxCount = 1, chance = 250, rare = true}, -- mystical dragon robe
	{id = 44622, minCount = 1, maxCount = 1, chance = 250, rare = true}, -- unerring dragon scale armor
}

-- Gera o loot dentro do container informado, respeitando min/max e a exclusividade dos raros.
local function generateDragonPackLoot(container)
	local rareDropped = false

	for _, entry in ipairs(itemList) do
		if not (entry.rare and rareDropped) then
			local roll = math.random(1, 100000)
			if roll <= entry.chance then
				local count = math.random(entry.minCount, entry.maxCount)
				container:addItem(entry.id, count)

				if entry.rare then
					rareDropped = true
				end
			end
		end
	end
end

local rewardDragonPack = Action()

function rewardDragonPack.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local storageReward = player:getStorageValue(Storage.Quest.Crandoria.TwentyYearsCook.Reward)
	local storageBoss1 = Game.getStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Maliz)
	local storageBoss2 = Game.getStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Vengar)
	local storageBoss3 = Game.getStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Bruton)
	local storageBoss4 = Game.getStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Greedok)
	local storageBoss5 = Game.getStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Vilear)
	local storageBoss6 = Game.getStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Crultor)
	local storageBoss7 = Game.getStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Despor)
	local cap = player:getFreeCapacity()

	if storageReward >= os.time() then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja coletou essa recompensa recentemente.")
		return true
	end

	if not (storageBoss1 == 2 and storageBoss2 == 2 and storageBoss3 == 2 and storageBoss4 == 2 and storageBoss5 == 2 and storageBoss6 == 2 and storageBoss7 == 2) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ainda nao derrotou todos os bosses do Dragon Pack.")
		return true
	end

	if cap < 500 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa de 500 de cap para obter as recompensas.")
		return true
	end

	local container = player:addItem(2867, 1)
	if container then
		player:setStorageValue(Storage.Quest.Crandoria.TwentyYearsCook.Reward, os.time() + 24 * 60 * 59)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu uma Red Backpack com sua recompensa.")
		generateDragonPackLoot(container)
		return true
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nao foi possivel gerar sua recompensa. Libere espaco no inventario.")
		return true
	end

	return true
end

rewardDragonPack:aid(13207)
rewardDragonPack:register()

-- local itemList = {
-- 	{id = 3031, minCount = 50, maxCount = 100, chance = 100000},
-- 	{id = 3035, minCount = 15, maxCount = 69, chance = 100000},
-- 	{id = 3043, minCount = 3, maxCount = 10, chance = 50000},
-- 	{id = 7430, minCount = 1, maxCount = 1, chance = 50000}, -- dragonbone staff
-- 	{id = 3392, minCount = 1, maxCount = 1, chance = 30000}, -- royal helmet
-- 	{id = 44603, minCount = 1, maxCount = 1, chance = 8000}, -- guardian gem
-- 	{id = 44604, minCount = 1, maxCount = 1, chance = 5000}, -- greater guardian gem
-- 	{id = 44606, minCount = 1, maxCount = 1, chance = 8000}, -- marksman gem
-- 	{id = 44607, minCount = 1, maxCount = 1, chance = 5000}, -- greater marksman gem
-- 	{id = 44608, minCount = 1, maxCount = 1, chance = 12000}, -- lesser sage gem
-- 	{id = 44609, minCount = 1, maxCount = 1, chance = 8000}, -- sage gem
-- 	{id = 44610, minCount = 1, maxCount = 1, chance = 5000}, -- greater sage gem
-- 	{id = 44612, minCount = 1, maxCount = 1, chance = 8000}, -- mystic gem
-- 	{id = 44613, minCount = 1, maxCount = 1, chance = 5000}, -- greater ystic gem
-- 	{id = 44743, minCount = 1, maxCount = 1, chance = 50000}, -- Nimmersatt's Seal
-- 	{id = 44750, minCount = 1, maxCount = 1, chance = 5000}, -- exalted seal
-- 	{id = 44754, minCount = 1, maxCount = 1, chance = 3000}, -- herald's wings
-- 	{id = 44753, minCount = 1, maxCount = 1, chance = 3000}, -- hearld's insignea
-- 	{id = 44752, minCount = 1, maxCount = 1, chance = 1000}, -- crystallized blood
-- 	{id = 44751, minCount = 1, maxCount = 1, chance = 500}, -- gold-scaled sentinela
-- 	{id = 44623, minCount = 1, maxCount = 1, chance = 250}, -- arcane dragon robe
-- 	{id = 44621, minCount = 1, maxCount = 1, chance = 250}, -- dauntless dragon scale armor
-- 	{id = 44624, minCount = 1, maxCount = 1, chance = 250}, -- mystical dragon robe
-- 	{id = 44622, minCount = 1, maxCount = 1, chance = 250}, -- unerring dragonn scale armor
-- }

-- local rewardDragonPack = Action()
 
-- function rewardDragonPack.onUse(player, item, fromPosition, target, toPosition, isHotkey)

-- 	local storageReward = player:getStorageValue(Storage.Quest.Crandoria.TwentyYearsCook.Reward)
-- 	local storageBoss1 = Game.getStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Maliz)
-- 	local storageBoss2 = Game.getStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Vengar)
-- 	local storageBoss3 = Game.getStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Bruton)
-- 	local storageBoss4 = Game.getStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Greedok)
-- 	local storageBoss5 = Game.getStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Vilear)
-- 	local storageBoss6 = Game.getStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Crultor)
-- 	local storageBoss7 = Game.getStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Despor)

-- 	local cap = player:getFreeCapacity()

-- 	if storageReward < os.time() then
-- 		if storageBoss1 == 2 and storageBoss2 == 2 and storageBoss3 == 2 and storageBoss4 == 2 and storageBoss5 == 2 and storageBoss6 == 2 and storageBoss7 == 2 then
-- 			if cap < 500 then
-- 				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa de 500 de cap para obter as recompensas.")
-- 				return true
-- 			else
-- 				local container = player:addItem(2867, 1)
-- 				local chance = math.random(1, 100000)
-- 				local count = math.random(minCount, maxCount)
-- 				if container then
-- 					container:addItem(XXX, count)
-- 				end
-- 			end
-- 		end
-- 	end
-- end

-- rewardDragonPack:aid(13207)
-- rewardDragonPack:register()