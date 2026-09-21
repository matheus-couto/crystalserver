local config = {
	{ position = { x = 33615, y = 31422, z = 10 }, destination = { x = 33681, y = 31596, z = 14 } }, -- hunt infernal demon
	{ position = { x = 33618, y = 31422, z = 10 }, destination = { x = 33775, y = 31598, z = 14 } }, -- hunt rotten
	{ position = { x = 33621, y = 31422, z = 10 }, destination = { x = 33775, y = 31630, z = 14 } }, -- hunt bony sea devil
	{ position = { x = 33624, y = 31422, z = 10 }, destination = { x = 33675, y = 31667, z = 14 } }, -- hunt cloak 
	{ position = { x = 33627, y = 31422, z = 10 }, destination = { x = 33777, y = 31662, z = 14 } }, -- hunt many faces
	{ position = { x = 33950, y = 31109, z = 8 }, destination = { x = 33780, y = 31634, z = 14 } }, -- goshnar's spite entrance
	{ position = { x = 33937, y = 31217, z = 11 }, destination = { x = 33782, y = 31665, z = 14 } }, -- goshnar's greed entrance
	{ position = { x = 34022, y = 31091, z = 11 }, destination = { x = 33685, y = 31599, z = 14 } }, -- goshnar's malice entrance
	{ position = { x = 33856, y = 31884, z = 5 }, destination = { x = 33857, y = 31865, z = 6 } }, -- goshnar's cruelty entrance
	{ position = { x = 33889, y = 31873, z = 3 }, destination = { x = 33830, y = 31881, z = 4 } }, -- 1st to 2nd floor cloak
	{ position = { x = 33829, y = 31880, z = 4 }, destination = { x = 33856, y = 31890, z = 5 } }, -- 2nd to 3rd floor cloak
}

local portal = { position = { x = 33914, y = 31032, z = 12 }, destination = { x = 33780, y = 31601, z = 14 } } -- goshnar's hatred entrance

local soulWarEntrances = MoveEvent()
function soulWarEntrances.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	if player:getLevel() < 250 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need at least level 250 to enter.")
		player:teleportTo(fromPosition, true)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return false
	end

	for index, data in pairs(config) do
		if Position(data.position) == player:getPosition() then
			-- Remo��o condicional para o portal de �ndice 4 (hunt cloak)
			if index == 4 then
				local itemId = 33891
				local count = player:getItemCount(itemId)
				if count > 0 then
					player:removeItem(itemId, count)
				end
			end

			player:setStorageValue(Storage.Quest.U12_40.SoulWar.TimerDeathHatred, 0)
			player:setStorageValue(Storage.Quest.U12_40.SoulWar.TormentCount, 0)
			player:teleportTo(Position(data.destination))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			return true
		end
	end
end

soulWarEntrances:type("stepin")
for _, data in pairs(config) do
	soulWarEntrances:position(data.position)
end
soulWarEntrances:register()

-- local soulWarEntrances = MoveEvent()
-- function soulWarEntrances.onStepIn(creature, item, position, fromPosition)
-- 	local player = creature:getPlayer()
-- 	if not player then
-- 		return false
-- 	end
-- 	if player:getLevel() < 250 then
-- 		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need at least level 250 to enter.")
-- 		player:teleportTo(fromPosition, true)
-- 		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
-- 		return false
-- 	end
-- 	for value in pairs(config) do
-- 		if Position(config[value].position) == player:getPosition() then
-- 			player:teleportTo(Position(config[value].destination))
-- 			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
-- 			return true
-- 		end
-- 	end
-- end

-- soulWarEntrances:type("stepin")
-- for value in pairs(config) do
-- 	soulWarEntrances:position(config[value].position)
-- end
-- soulWarEntrances:register()

local portalHatred = Action()
function portalHatred.onUse(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end
	if player:getLevel() < 250 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need at least level 250 to enter.")
		player:teleportTo(fromPosition, true)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return false
	end
	doSendMagicEffect(item:getPosition(), CONST_ME_TELEPORT)
	player:teleportTo(Position(portal.destination))
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

portalHatred:position(portal.position)
portalHatred:register()
