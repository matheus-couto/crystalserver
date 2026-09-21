local quaraLeaders = {
	["inky"] = Storage.Quest.U8_4.InServiceOfYalahar.QuaraInky,
	["sharptooth"] = Storage.Quest.U8_4.InServiceOfYalahar.QuaraSharptooth,
	["splasher"] = Storage.Quest.U8_4.InServiceOfYalahar.QuaraSplasher,
}

local quaraLeadersKill = CreatureEvent("QuaraLeaders")
function quaraLeadersKill.onKill(creature, target)
	local targetMonster = target:getMonster()
	if not targetMonster then
		return true
	end

	local bossStorage = quaraLeaders[targetMonster:getName():lower()]
	if not bossStorage then
		return true
	end

	local player = creature:getPlayer()
	if player:getStorageValue(bossStorage) < 1 then
		player:setStorageValue(bossStorage, 1)
		player:say("You slayed " .. targetMonster:getName() .. ".", TALKTYPE_MONSTER_SAY)
		player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraState, 2)
		player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Questline, 41)
		-- StorageValue for Questlog 'Mission 07: A Fishy Mission'
		player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission07, 4)
	end
	return true
end

quaraLeadersKill:register()
