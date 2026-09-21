-- local destination = {
-- 	[12344] = Position(5035, 5335, 7), -- EK

-- }

-- local teleport = MoveEvent()



-- function teleport.onStepIn(creature, item, position, fromPosition)
-- 	local player = creature:getPlayer()
-- 	if not player then
-- 		return true
-- 	end

-- 	local teleport = destination[item.actionid]
-- 	if teleport and player:getStorageValue(Storage.Quest.U11_80.TheSecretLibrary.FalconBastion.OberonCrandoriaTimer) < os.time() then
-- 		player:teleportTo(Position(4830, 4502, 9))
-- 		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
-- 		-- player:setStorageValue(Storage.Quest.U11_80.TheSecretLibrary.FalconBastion.OberonCrandoriaTimer, os.time() + 20 * 60 * 60)
-- 		return true
-- 	else
-- 		player:teleportTo(fromPosition)
-- 		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
-- 		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are still tired from your last battle.")
-- 	return true
-- 	end
-- end

-- teleport:type("stepin")

-- for index, value in pairs(destination) do
-- 	teleport:aid(index)
-- end

-- teleport:register()
