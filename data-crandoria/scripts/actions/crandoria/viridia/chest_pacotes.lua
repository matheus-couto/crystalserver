-- local teleportIlha = Action()

-- function teleportIlha.onUse(player, item, fromPosition, target, toPosition, isHotkey)

-- 	local donate16 = player:getStorageValue(Storage.Quest.Crandoria.Donates.Donate16)
-- 	local donate30 = player:getStorageValue(Storage.Quest.Crandoria.Donates.Donate30)
-- 	local donate50 = player:getStorageValue(Storage.Quest.Crandoria.Donates.Donate50)
-- 	local donate100 = player:getStorageValue(Storage.Quest.Crandoria.Donates.Donate100)
-- 	local donate200 = player:getStorageValue(Storage.Quest.Crandoria.Donates.Donate200)
-- 	local donate300 = player:getStorageValue(Storage.Quest.Crandoria.Donates.Donate300)
-- 	local donate500 = player:getStorageValue(Storage.Quest.Crandoria.Donates.Donate500)
-- 	local premioTC = player:getStorageValue(Storage.Quest.Crandoria.PremioTC)

-- 	if donate16 == 5 or donate30 == 5 or donate50 == 5 or donate100 == 5 or donate200 == 5 or donate300 == 5 or donate500 == 5 or premioTC == 5 then
-- 		if item:getPosition() == Position(4540, 5429, 3) then
-- 			player:teleportTo(Position(4966, 5088, 7))
-- 			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
-- 			return true
-- 		elseif item:getPosition() == Position(5000, 5006, 5) then
-- 			player:teleportTo(Position(4952, 5087, 7))
-- 			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
-- 			return true
-- 		end
-- 	else
-- 		player:teleportTo(fromPosition)
-- 		player:sendCancelMessage("Voce nao tem permissao para acessar essa area.")
-- 		return true
-- 	end


-- end

-- teleportIlha:aid(13136)
-- teleportIlha:register()