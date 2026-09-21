

-- local firstSQM = Position(5634, 5270, 6) -- Ajuste para a posição do primeiro SQM
-- local secondSQM = Position(5590, 5248, 6) -- Ajuste para a posição do segundo SQM

-- local sqmViridiaTimer = MoveEvent()

-- function sqmViridiaTimer.onStepIn(player, item, position, fromPosition)
--     -- Identificar o SQM em que o jogador está

-- 	if player:getStorageValue(Storage.Quest.Crandoria.Viridia.EventoBemVindos.Loot) < os.time() then
-- 		player:setStorageValue(Storage.Quest.Crandoria.Viridia.EventoBemVindos.Loot, os.time() + 5 * 24 * 60 * 60)
-- 	end

-- 	if player:getStorageValue(Storage.Quest.Crandoria.Viridia.EventoBemVindos.Skills) < os.time() then
-- 		player:setStorageValue(Storage.Quest.Crandoria.Viridia.EventoBemVindos.Skills, os.time() + 5 * 24 * 60 * 60)
-- 	end

--     if player:getStorageValue(Storage.Quest.Crandoria.Viridia.EventoBemVindos.Exp) < os.time() then
-- 		player:setStorageValue(Storage.Quest.Crandoria.Viridia.EventoBemVindos.Exp, os.time() + 5 * 24 * 60 * 60)
-- 	end

-- 	player:setStorageValue(Storage.Quest.Crandoria.TeleportRoom.Passe, os.time() + 5 * 24 * 60 * 60)
-- 	player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu 5 dias de boost de Exp e Skills e 5 dias de acesso ilimitado a TP Room de Crandoria.")

-- end

-- sqmViridiaTimer:aid(13088)
-- sqmViridiaTimer:register()


-- -- -- local firstSQM = Position(5000, 5000, 6) -- Ajuste para a posição do primeiro SQM
-- -- -- local secondSQM = Position(5000, 5000, 7) -- Ajuste para a posição do segundo SQM

-- -- -- local sqmViridiaTimer = MoveEvent()

-- -- -- function sqmViridiaTimer.onStepIn(player, item, position, fromPosition)

-- -- -- 	if item:getPosition() == Position(5634, 5270, 6) then
-- -- -- 		player:setStorageValue()

-- -- -- end

-- -- -- sqmViridiaTimer:aid(13088)
-- -- -- sqmViridiaTimer:register()


-- -- -- local firstSQM = Position(5000, 5000, 6) -- Ajuste para a posição do primeiro SQM
-- -- -- local secondSQM = Position(5000, 5000, 7) -- Ajuste para a posição do segundo SQM

-- -- -- local sqmViridiaTimer = MoveEvent()

-- -- -- function sqmViridiaTimer.onStepIn(player, item, position, fromPosition)
-- -- --     -- Identificar o SQM em que o jogador está
	
-- -- -- 	local function convertToTimestamp(dateStr)
-- -- -- 		local day, month, year, hour, min = dateStr:match("(%d+)/(%d+)/(%d+) (%d+):(%d+)")
-- -- -- 		return os.time({year = tonumber(year), month = tonumber(month), day = tonumber(day), hour = tonumber(hour), min = tonumber(min)})
-- -- -- 	end
	
-- -- -- 	-- Função para armazenar a data atual como timestamp
-- -- -- 	local function getCurrentTimestamp()
-- -- -- 		return os.time()
-- -- -- 	end

-- -- -- 	local function onStepInFirstSQM(player)
-- -- -- 		local currentTimestamp = getCurrentTimestamp()
-- -- -- 		player:setStorageValue(Storage.Quest.Crandoria.Viridia.Torneio.TimerTile, currentTimestamp)
-- -- -- 		player:sendTextMessage(MESSAGE_INFO_DESCR, "Jornada iniciada: " .. os.date("%d/%m/%Y %H:%M", currentTimestamp))
-- -- -- 	end

-- -- -- 	local function onStepInSecondSQM(player)
-- -- -- 		local storedTimestamp = player:getStorageValue(Storage.Quest.Crandoria.Viridia.Torneio.TimerTile)
-- -- -- 		if storedTimestamp == -1 or storedTimestamp == nil then
-- -- -- 			player:sendTextMessage(MESSAGE_STATUS_WARNING, "Seu personagem foi criado ha muito tempo, portanto nao pode acessar o Torneio.")
-- -- -- 			player:teleportTo(fromPosition) 
-- -- -- 			return true
-- -- -- 		end
	
-- -- -- 		-- Data/hora limite (em timestamp)
-- -- -- 		local limitTimestamp = convertToTimestamp("17/01/2025 20:00") -- Hora
	
-- -- -- 		-- Comparar timestamps
-- -- -- 		if storedTimestamp < limitTimestamp then
-- -- -- 			player:sendTextMessage(MESSAGE_STATUS_WARNING, "Voce nao pode passar, pois criou seu personagem antes de " .. os.date("%d/%m/%Y %H:%M", limitTimestamp))
-- -- -- 			player:teleportTo(fromPosition) 
-- -- -- 		else
-- -- -- 			player:sendTextMessage(MESSAGE_INFO_DESCR, "Esta preparado para o modo Hardcore?")
-- -- -- 		end
-- -- -- 	end

-- -- -- 	local player = creature:getPlayer()
-- -- --     if not player then 
-- -- -- 		return true 
-- -- -- 	end

-- -- --     if position == firstSQM then
-- -- --         onStepInFirstSQM(player)
-- -- --     elseif position == secondSQM then
-- -- --         onStepInSecondSQM(player)
-- -- --     end
-- -- --     return true
-- -- -- end

-- -- -- sqmViridiaTimer:aid(13088)
-- -- -- sqmViridiaTimer:register()





-- -- -- local fountain = Action()

-- -- -- function fountain.onUse(player, item, fromPosition, target, toPosition, isHotkey)

-- -- -- 	local stamina = player:getStamina()
-- -- --     if stamina >= 2400 then
-- -- --         player:sendCancelMessage("A fonte so pode ser usada para personagens com Stamina menor que 40:00h.")
-- -- --         return true
-- -- --     end

-- -- --     player:setStamina(2400)
-- -- --     player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
-- -- --     player:sendCancelMessage("Sua stamina foi quase totalmente recuperada.")
-- -- --     return true
-- -- -- end

-- -- -- fountain:aid(13088)
-- -- -- fountain:register()


