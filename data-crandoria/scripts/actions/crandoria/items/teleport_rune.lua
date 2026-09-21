-- local area1 = {
--     fromPosition = {x = 4930, y = 4961, z = 6},
--     toPosition = {x = 4939, y = 4978, z = 6}
-- }

-- local area2 = {
--     fromPosition = {x = 4926, y = 4961, z = 7},
--     toPosition = {x = 4939, y = 4977, z = 7}
-- }

-- local area3 = {
--     fromPosition = {x = 4927, y = 4964, z = 8},
--     toPosition = {x = 4946, y = 4974, z = 8}
-- }

-- local area4 = {
--     fromPosition = {x = 4942, y = 4967, z = 9},
--     toPosition = {x = 4959, y = 4976, z = 9}
-- }

-- local function isInArea(player, area)
--     local playerPos = player:getPosition()
--     return playerPos.x >= area.fromPosition.x and playerPos.x <= area.toPosition.x
--         and playerPos.y >= area.fromPosition.y and playerPos.y <= area.toPosition.y
--         and playerPos.z == area.fromPosition.z
-- end

-- local rune = Action()

-- function rune.onUse(player, item, fromPosition, target, toPosition, isHotkey)

-- 	local gotoX = player:getStorageValue(Storage.Quest.Crandoria.TeleportRune.PosX)
-- 	local gotoY = player:getStorageValue(Storage.Quest.Crandoria.TeleportRune.PosY)

-- 	if player:getStorageValue(Storage.Quest.Crandoria.TeleportRune.Progresso) < 3 then
-- 		player:sendTextMessage(MESSAGE_LOOK, "Voce nao domina a arte do teletransporte.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end

-- 	if player:getSoul() < 100 then
-- 		player:sendTextMessage(MESSAGE_LOOK, "Voce precisa de 100 Soul Points para se teletransportar.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end

-- 	if player:getStorageValue(Storage.Quest.Crandoria.TeleportRune.Timer) > os.time() then
-- 		player:sendTextMessage(MESSAGE_LOOK, "Voce ainda esta cansado do seu ultimo teletransporte.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end

-- 	if isInArea(player, area1) or isInArea(player, area2) or isInArea(player, area3) or isInArea(player, area4) then
-- 		player:sendTextMessage(MESSAGE_LOOK, "Voce nao pode usar esse item para sair da prisao.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end

-- 	if player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
-- 		player:sendTextMessage(MESSAGE_LOOK, "Voce nao pode usar essa runa estando em estado de batalha.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end

-- 	if player:getSkull() == WHITE_SKULL or player:getSkull() == RED_SKULL or player:getSkull() == BLACK_SKULL then
-- 		player:sendTextMessage(MESSAGE_LOOK, "Voce nao pode usar essa runa com uma Skull ativada.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end

-- 	if player:getTile():getHouse() then
-- 		player:sendTextMessage(MESSAGE_LOOK, "Voce nao pode usar essa runa enquanto estiver dentro de uma casa.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end

-- 	if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
-- 		player:sendTextMessage(MESSAGE_LOOK, "Cidadaos de Viridia nao podem se teletransportar.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end


-- 	if player:getStorageValue(Storage.Quest.Crandoria.TeleportRune.PosX) < 1 then
-- 		player:sendTextMessage(MESSAGE_LOOK, "Voce nao possui nenhum local marcado.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end

-- 	local house = player:getHouse()

-- 	if house then
-- 		if house:getTown():getId() == 13 then
-- 			player:sendTextMessage(MESSAGE_LOOK, "Jogadores amaldicoados nao podem se teletransportar com runas magicas.")
-- 			player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 			return false
-- 		end
-- 	end	

-- 	player:teleportTo(Position(gotoX, gotoY, 7))
-- 	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
-- 	player:setStorageValue(Storage.Quest.Crandoria.TeleportRune.PosX, 0)
-- 	player:setStorageValue(Storage.Quest.Crandoria.TeleportRune.PosY, 0)
-- 	player:setStorageValue(Storage.Quest.Crandoria.TeleportRune.PosZ, 0)
-- 	player:setStorageValue(Storage.Quest.Crandoria.TeleportRune.Timer, os.time() + 15 * 60)
-- 	player:addSoul(-100)
-- 	item:remove(1)
-- 	return true
	

-- end

-- rune:id(3235)
-- rune:register()


-- local rune2 = Action()

-- function rune2.onUse(player, item, fromPosition, target, toPosition, isHotkey)

-- 	local gotoX = player:getStorageValue(Storage.Quest.Crandoria.TeleportRune.PosX)
-- 	local gotoY = player:getStorageValue(Storage.Quest.Crandoria.TeleportRune.PosY)


-- 	if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
-- 		player:sendTextMessage(MESSAGE_LOOK, "Cidadaos de Viridia nao podem se teletransportar.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end

-- 	if player:getSoul() < 100 then
-- 		player:sendTextMessage(MESSAGE_LOOK, "Voce precisa de 100 Soul Points para se teletransportar.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end

-- 	if player:getStorageValue(Storage.Quest.Crandoria.TeleportRune.Timer) > os.time() then
-- 		player:sendTextMessage(MESSAGE_LOOK, "Voce ainda esta cansado do seu ultimo teletransporte.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end

-- 	if player:getStorageValue(Storage.Quest.Crandoria.TeleportRune.Progresso) < 3 then
-- 		player:sendTextMessage(MESSAGE_LOOK, "Voce nao domina a arte do teletransporte.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end

-- 	if isInArea(player, area1) or isInArea(player, area2) or isInArea(player, area3) or isInArea(player, area4) then
-- 		player:sendTextMessage(MESSAGE_LOOK, "Voce nao pode usar esse item para sair da prisao.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end

-- 	if player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
-- 		player:sendTextMessage(MESSAGE_LOOK, "Voce nao pode usar essa runa estando em estado de batalha.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end

-- 	if player:getSkull() == WHITE_SKULL or player:getSkull() == RED_SKULL or player:getSkull() == BLACK_SKULL then
-- 		player:sendTextMessage(MESSAGE_LOOK, "Voce nao pode usar essa runa com uma Skull ativada.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end

-- 	if player:getTile():getHouse() then
-- 		player:sendTextMessage(MESSAGE_LOOK, "Voce nao pode usar essa runa enquanto estiver dentro de uma casa.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end


-- 	if player:getStorageValue(Storage.Quest.Crandoria.TeleportRune.PosX) < 1 then
-- 		player:sendTextMessage(MESSAGE_LOOK, "Voce nao possui nenhum local marcado.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end

-- 	player:teleportTo(Position(gotoX, gotoY, 7))
-- 	player:addSoul(-100)
-- 	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
-- 	player:setStorageValue(Storage.Quest.Crandoria.TeleportRune.PosX, 0)
-- 	player:setStorageValue(Storage.Quest.Crandoria.TeleportRune.PosY, 0)
-- 	player:setStorageValue(Storage.Quest.Crandoria.TeleportRune.PosZ, 0)
-- 	player:setStorageValue(Storage.Quest.Crandoria.TeleportRune.Timer, os.time() + 15 * 60)
-- 	return true
-- end

-- rune2:id(24969)
-- rune2:register()

