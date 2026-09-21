-- local diseasedTrio = {
-- 	["diseased bill"] = Storage.Quest.U8_4.InServiceOfYalahar.DiseasedBill,
-- 	["diseased dan"] = Storage.Quest.U8_4.InServiceOfYalahar.DiseasedDan,
-- 	["diseased fred"] = Storage.Quest.U8_4.InServiceOfYalahar.DiseasedFred,
-- }

-- local diseasedTrioKill = CreatureEvent("DiseasedTrio")
-- function diseasedTrioKill.onKill(creature, target)
-- 	local targetMonster = target:getMonster()
-- 	if not targetMonster then
-- 		return true
-- 	end

-- 	local bossStorage = diseasedTrio[targetMonster:getName():lower()]
-- 	if not bossStorage then
-- 		return true
-- 	end

-- 	local player = creature:getPlayer()
-- 	if player:getStorageValue(bossStorage) < 1 then
-- 		player:setStorageValue(bossStorage, 1)
-- 		player:say("You slayed " .. targetMonster:getName() .. ".", TALKTYPE_MONSTER_SAY)
-- 	end

-- 	if player:getStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DiseasedDan) == 1 and player:getStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DiseasedBill) == 1 and player:getStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DiseasedFred) == 1 and player:getStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.AlchemistFormula) ~= 1 then
-- 		player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.AlchemistFormula, 0)
-- 	end
-- 	return true
-- end

-- diseasedTrioKill:register()
