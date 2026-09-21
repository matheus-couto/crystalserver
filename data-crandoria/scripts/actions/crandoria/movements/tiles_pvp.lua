-- local skullPVP = Action()

-- function skullPVP.onUse(player, item, fromPosition, target, toPosition, isHotkey)
-- 	local timeLeft = math.floor((player:getStorageValue(Storage.Quest.Crandoria.PvpStatus.TimerAntiafk) - os.time()) / 60)

-- 	if Tile(player:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) then
-- 		if player:getStorageValue(Storage.Quest.Crandoria.PvpStatus.Status) < 1 then
-- 			player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status, 2)
-- 			-- player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ativou seu status PVP.")
-- 			player:sendTextMessage(MESSAGE_HOTKEY_PRESSED, "Voce ativou seu status PVP.")
-- 			return true
-- 		elseif player:getStorageValue(Storage.Quest.Crandoria.PvpStatus.Status) == 1 then
-- 			if player:getStorageValue(Storage.Quest.Crandoria.PvpStatus.TimerAntiafk) > os.time() then
-- 				player:sendCancelMessage("Seu status pvp esta ativado pelo encantamento de Pietro e continuara ativo por mais " ..timeLeft.." minutos.")
-- 				return true
-- 			else
-- 				player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status, 2)
-- 			-- player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce desativou seu status PVP.")
-- 				player:sendTextMessage(MESSAGE_HOTKEY_PRESSED, "Voce desativou seu status PVP.")
-- 				return true
-- 			end
-- 		elseif player:getStorageValue(Storage.Quest.Crandoria.PvpStatus.Status) == 2 then
-- 			player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status, 0)
-- 			-- player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce desativou seu status PVP.")
-- 			player:sendTextMessage(MESSAGE_HOTKEY_PRESSED, "Voce desativou seu status PVP.")
-- 			return true
-- 		end
-- 	else
-- 		player:sendCancelMessage("Voce so pode mudar seu status pvp em areas seguras (Protection Zones).")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return true
-- 	end
-- 	return true
-- end

-- skullPVP:id(37749)
-- skullPVP:register()




-- local pvpControl = MoveEvent()

-- function pvpControl.onStepIn(player, item, position, fromPosition)

-- 	local previoustile = Tile(fromPosition)

-- 	if item.itemid == 32627 then
-- 		if previoustile:hasFlag(TILESTATE_PROTECTIONZONE) or previoustile:getItemById(28473) then
-- 			if player:getLevel() < 300 then
-- 				player:teleportTo(fromPosition)
-- 				player:sendTextMessage(MESSAGE_HOTKEY_PRESSED, "Apenas jogadores de nivel 300 ou maior podem acessar areas PvP.")
-- 				return false
-- 			end
-- 			if player:getStorageValue(Storage.Quest.Crandoria.PvpStatus.Status) ~= 2 then
-- 				player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status, 2)
-- 				player:sendTextMessage(MESSAGE_HOTKEY_PRESSED, "Atencao: Voce esta entrando em uma area PvP.")
-- 				return true
-- 			else
-- 				player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.StatusHunt, 1)
-- 				player:sendTextMessage(MESSAGE_HOTKEY_PRESSED, "Atencao: Voce esta entrando em uma area PvP.")
-- 				return true
-- 			end
-- 		end
-- 	else
-- 		if not Tile(fromPosition):hasFlag(TILESTATE_PROTECTIONZONE) then
-- 			if player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.StatusHunt) == 1 then
-- 				player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status, 2)
-- 				player:sendTextMessage(MESSAGE_HOTKEY_PRESSED, "Atencao: Voce esta saindo de uma area PvP.")
-- 				return true
-- 			else
-- 				if player:getStorageValue(Storage.Quest.Crandoria.PvpStatus.TimerAntiafk) > os.time() then
-- 					player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status, 1)
-- 					player:sendTextMessage(MESSAGE_HOTKEY_PRESSED, "Atencao: Voce esta saindo de uma area PvP.")
-- 					return true
-- 				else
-- 					player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status, 0)
-- 					player:sendTextMessage(MESSAGE_HOTKEY_PRESSED, "Atencao: Voce esta saindo de uma area PvP.")
-- 				end
-- 				return true
-- 			end
-- 		end
-- 	end

-- end

-- pvpControl:aid(13036)
-- pvpControl:register()

-- local skullPVP = Action() 

-- function skullPVP.onUse(player, item, fromPosition, target, toPosition, isHotkey)
-- 	local timeLeft = math.floor((player:getStorageValue(Storage.Quest.Crandoria.PvpStatus.TimerAntiafk) - os.time()) / 60)

-- 	if Tile(player:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) then
-- 		if player:getStorageValue(Storage.Quest.Crandoria.PvpStatus.Status) < 1 then
-- 			player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status, 2)
-- 			-- player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ativou seu status PVP.")
-- 			player:sendTextMessage(MESSAGE_HOTKEY_PRESSED, "Voce ativou seu status PVP.")
-- 			return true
-- 		elseif player:getStorageValue(Storage.Quest.Crandoria.PvpStatus.Status) == 1 then
-- 			if player:getStorageValue(Storage.Quest.Crandoria.PvpStatus.TimerAntiafk) > os.time() then
-- 				player:sendCancelMessage("Seu status pvp esta ativado pelo encantamento de Pietro e continuara ativo por mais " ..timeLeft.." minutos.")
-- 				return true
-- 			else
-- 				player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status, 2)
-- 			-- player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce desativou seu status PVP.")
-- 				player:sendTextMessage(MESSAGE_HOTKEY_PRESSED, "Voce desativou seu status PVP.")
-- 				return true
-- 			end
-- 		elseif player:getStorageValue(Storage.Quest.Crandoria.PvpStatus.Status) == 2 then
-- 			player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status, 0)
-- 			-- player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce desativou seu status PVP.")
-- 			player:sendTextMessage(MESSAGE_HOTKEY_PRESSED, "Voce desativou seu status PVP.")
-- 			return true
-- 		end
-- 	else
-- 		player:sendCancelMessage("Voce so pode mudar seu status pvp em areas seguras (Protection Zones).")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return true
-- 	end
-- 	return true
-- end

-- skullPVP:id(37749)
-- skullPVP:register()




local pvpControl = MoveEvent()

function pvpControl.onStepIn(player, item, position, fromPosition)

	local previoustile = Tile(fromPosition)

	-- if os.date("%A") ~= "Friday" and os.date("%A") ~= "Saturday" and os.date("%A") ~= "Sunday" then
	if item.itemid == 32627 then
		if previoustile:getItemById(28473) then
			if player:getLevel() < 100 then
				player:teleportTo(fromPosition)
				player:sendTextMessage(MESSAGE_HOTKEY_PRESSED, "Apenas jogadores de nivel 100 ou maior podem acessar Areas Obscuras.")
				return false
			end
			if player:getStorageValue(Storage.Quest.Crandoria.PvpStatus.Status) < 1 then
				player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status, 2)
				player:sendTextMessage(MESSAGE_HOTKEY_PRESSED, "Atencao: Voce esta entrando em uma Area Obscura.")
				return true
			else
				player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status, 2)
				player:sendTextMessage(MESSAGE_HOTKEY_PRESSED, "Atencao: Voce esta entrando em uma area Area Obscura.")
				return true
			end
		end
	elseif item.itemid == 28473 then
		if previoustile:getItemById(32627) then
			if player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status) == 1 then
				if player:getSkull() == SKULL_RED or player:getSkull() == SKULL_BLACK then
					player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status, 1)
					player:sendTextMessage(MESSAGE_HOTKEY_PRESSED, "Atencao: Voce esta saindo de uma Area Obscura.")
					return true
				else
					player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status, 1)
					player:sendTextMessage(MESSAGE_HOTKEY_PRESSED, "Atencao: Voce esta saindo de uma Area Obscura.")
					return true
				end
			elseif player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status) == 2 then
				player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status, 1)
				player:sendTextMessage(MESSAGE_HOTKEY_PRESSED, "Atencao: Voce esta saindo de uma Area Obscura.")
				return true
			end
		end
	end
end

pvpControl:aid(13036)
pvpControl:register()

local pvpControlHuntsPvP = MoveEvent()

function pvpControlHuntsPvP.onStepIn(player, item, position, fromPosition)
	
	local previoustile = Tile(fromPosition)

	if item.itemid == 32627 then
		if previoustile:getItemById(28473) then
			if player:getLevel() < 100 then
				player:teleportTo(fromPosition)
				player:sendTextMessage(MESSAGE_HOTKEY_PRESSED, "Apenas jogadores de nivel 100 ou maior podem acessar Areas Obscuras.")
				return false
			end
			if player:getStorageValue(Storage.Quest.Crandoria.PvpStatus.Status) < 1 then
				player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status, 2)
				player:sendTextMessage(MESSAGE_HOTKEY_PRESSED, "Atencao: Voce esta entrando em uma Area Obscura.")
				return true
			else
				player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status, 2)
				player:sendTextMessage(MESSAGE_HOTKEY_PRESSED, "Atencao: Voce esta entrando em uma Area Obscura.")
				return true
			end
		end
	elseif item.itemid == 28473 then
		if previoustile:getItemById(32627) then
			if player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status) == 1 then
				if player:getSkull() == SKULL_RED or player:getSkull() == SKULL_BLACK then
					player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status, 1)
					player:sendTextMessage(MESSAGE_HOTKEY_PRESSED, "Atencao: Voce esta saindo de uma Area Obscura.")
					return true
				else
					player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status, 1)
					player:sendTextMessage(MESSAGE_HOTKEY_PRESSED, "Atencao: Voce esta saindo de uma Area Obscura.")
					return true
				end
			elseif player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status) == 2 then
				player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status, 1)
				player:sendTextMessage(MESSAGE_HOTKEY_PRESSED, "Atencao: Voce esta saindo de uma Area Obscura.")
				return true
			end
		end
	end
end

pvpControlHuntsPvP:aid(13037)
pvpControlHuntsPvP:register()