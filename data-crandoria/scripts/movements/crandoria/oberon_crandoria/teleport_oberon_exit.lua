-- local destination = {
-- 	[12345] = Position(5035, 5335, 7), -- EK

-- }

-- local teleport = MoveEvent()



-- function teleport.onStepIn(creature, item, position, fromPosition)
-- 	local player = creature:getPlayer()
-- 	if not player then
-- 		return true
-- 	end

-- 	local teleport = destination[item.actionid]
-- 		if teleport then
-- 			player:setStorageValue(Storage.Quest.U11_80.TheSecretLibrary.FalconBastion.OberonCrandoriaTimer, os.time() + 20 * 60 * 60)
-- 			player:teleportTo(Position(4762, 4439, 9))
--         		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
-- 		    return true
-- 		end
-- end

-- teleport:type("stepin")

-- for index, value in pairs(destination) do
-- 	teleport:aid(index)
-- end

-- teleport:register()
