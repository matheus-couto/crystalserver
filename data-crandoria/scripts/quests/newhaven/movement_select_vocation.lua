-- CRANDORIA EDIT --
local selectVocationNewhaven = MoveEvent()

local function scheduleStarterItems(playerId, attemptsLeft)
	local player = Player(playerId)
	if not player or player:getStorageValue(Storage.Quest.U15_12.newhavenStarterItems) > 0 then
		return
	end

	if player:getVocation():getId() ~= VOCATION_NONE then
		Newhaven.giveStarterItems(player)
		return
	end

	if attemptsLeft <= 0 then
		return
	end

	addEvent(scheduleStarterItems, 1000, playerId, attemptsLeft - 1)
end

function selectVocationNewhaven.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	player:teleportTo(Position(5972, 4543, 7))

	if player:getVocation():getId() == VOCATION_NONE then
		player:sendTutorial(2)
		scheduleStarterItems(player:getId(), 60)
	else
		Newhaven.giveStarterItems(player)
	end

	player:addMapMark(Position(5982, 4533, 7), 11, "Avriel's Shop")
	player:addMapMark(Position(5999, 4530, 7), 3, "Spells")
	player:addMapMark(Position(5981, 4524, 7), 9, "Ferry House")
	player:addMapMark(Position(5995, 4517, 7), 13, "Bank")
	player:addMapMark(Position(6020, 4479, 7), 8, "Corrupted Mines")
	player:addMapMark(Position(5975, 4470, 7), 8, "Muglex Clan Camp")

	player:setStorageValue(Storage.Quest.U15_12.newhavenCitizen, 1)
	player:setStorageValue(Storage.Quest.U15_12.newhavenTutorialHunting, 1)
	player:setStorageValue(Storage.Quest.U15_12.newhavenNewLootTheCorruptor, 1)

	return true
end

selectVocationNewhaven:type("stepin")
selectVocationNewhaven:position(Position(5966, 4541, 7))
selectVocationNewhaven:register()
