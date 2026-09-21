-- CRANDORIA EDIT --

local config = {
	[20272] = {
		targetId = 20302, -- Target ID.
		bossName = 'Zavarash', -- boss name
		keyPlayerPosition = Position(5934, 5062, 11), -- Where the player should be.
		newPosition = Position(5850, 5084, 12), -- Position to teleport
		bossPosition = Position(5857, 5092, 12), -- Boss Position
		centerPosition = Position(5857, 5092, 12), -- Center Room
		exitPosition = Position(5935, 5063, 11), -- Exit Position
		rangeX = 20, -- Range in X
		rangeY = 20, -- Range in Y
		time = 15, -- time in minutes to remove the player
	},
	[20273] = {
		targetId = 20306, -- Target ID.
		bossName = 'Prince Drazzak', -- boss name
		keyPlayerPosition = Position(5944, 5062, 11), -- Where the player should be.
		newPosition = Position(5850, 4997, 12), -- Position to teleport
		bossPosition = Position(5858, 5004, 12), -- Boss Position
		centerPosition = Position(5858, 5004, 12), -- Center Room
		exitPosition = Position(5945, 5063, 11), -- Exit Position
		rangeX = 20,
		rangeY = 20,
		time = 15, -- time in minutes to remove the player
	},
	[20270] = {
		targetId = 20304, -- Target ID.
		bossName = 'Terofar', -- boss name
		keyPlayerPosition = Position(5939, 5062, 11),  -- Where the player should be.
		newPosition = Position(5891, 5084, 12), -- Position to teleport
		bossPosition = Position(5898, 5092, 12), -- Boss Position
		centerPosition = Position(5898, 5092, 12), -- Center Room
		exitPosition = Position(5940, 5063, 11), -- Exit Position
		rangeX = 20,
		rangeY = 20,
		time = 15, -- time in minutes to remove the player
	}
}

local function roomIsOccupied(centerPosition, rangeX, rangeY)
	local spectators = Game.getSpectators(centerPosition, false, false, rangeX, rangeX, rangeY, rangeY)
	return #spectators ~= 0
end

local function clearBossRoom(playerId, centerPosition, rangeX, rangeY, exitPosition, stonePosition)
	-- Limpa jogadores e monstros da sala
	local spectators = Game.getSpectators(centerPosition, false, false, rangeX, rangeX, rangeY, rangeY)
	for _, spectator in ipairs(spectators) do
		if spectator:isPlayer() and spectator.uid == playerId then
			spectator:teleportTo(exitPosition)
			exitPosition:sendMagicEffect(CONST_ME_TELEPORT)
		elseif spectator:isMonster() then
			spectator:remove()
		end
	end

	-- Remove a pedra de bloqueio na posição especificada
	local stone = Tile(stonePosition):getItemById(1841)
	if stone then
		stone:remove()
	end
end

local keys = Action()

function keys.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local tmpConfig = config[item.itemid]
	if not tmpConfig or target.itemid ~= tmpConfig.targetId then
		return true
	end

	local creature = Tile(tmpConfig.keyPlayerPosition):getTopCreature()
	if not creature or not creature:isPlayer() then
		return true
	end

	-- Verifica se a sala está ocupada
	if roomIsOccupied(tmpConfig.centerPosition, tmpConfig.rangeX, tmpConfig.rangeY) then
		player:sendCancelMessage("Ha alguém na sala.")
		return true
	end

	-- Cria o chefe e teletransporta os jogadores
	local monster = Game.createMonster(tmpConfig.bossName, tmpConfig.bossPosition)
	if not monster then
		return true
	end

	-- Teletransporta jogadores para a nova posição
	local playerPositionsToTeleport = {
		tmpConfig.keyPlayerPosition,
		Position(tmpConfig.keyPlayerPosition.x, tmpConfig.keyPlayerPosition.y + 1, tmpConfig.keyPlayerPosition.z),
		Position(tmpConfig.keyPlayerPosition.x, tmpConfig.keyPlayerPosition.y + 2, tmpConfig.keyPlayerPosition.z),
		Position(tmpConfig.keyPlayerPosition.x, tmpConfig.keyPlayerPosition.y + 3, tmpConfig.keyPlayerPosition.z),
		Position(tmpConfig.keyPlayerPosition.x, tmpConfig.keyPlayerPosition.y + 4, tmpConfig.keyPlayerPosition.z)
	}
	for _, pos in ipairs(playerPositionsToTeleport) do
		local playerAtPos = Tile(pos):getTopCreature()
		if playerAtPos and playerAtPos:isPlayer() then
			playerAtPos:teleportTo(tmpConfig.newPosition)
			playerAtPos:setStorageValue(tmpConfig.storage)
			playerAtPos:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		end
	end

	-- Mensagens ao jogador
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Voce e seus aliados entraram na sala do chefe!')
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Vocês tem quinze minutos para derrota-lo e saquear, ou perderao essa chance.')

	-- Criação da pedra na posição chave
	local stone = Game.createItem(1841, 1, tmpConfig.keyPlayerPosition)
	if stone then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Uma pedra bloqueia a entrada.')
	end

	-- Limpa a sala e remove a pedra após o tempo especificado
	addEvent(clearBossRoom, 60 * tmpConfig.time * 1000, player:getId(), tmpConfig.centerPosition, tmpConfig.rangeX, tmpConfig.rangeY, tmpConfig.exitPosition, tmpConfig.keyPlayerPosition)
	item:remove()
	return true
end

keys:id(20270, 20273, 20272)
keys:register()

-- local function roomIsOccupied(centerPosition, rangeX, rangeY)
-- 	local spectators = Game.getSpectators(centerPosition, false, false, rangeX, rangeX, rangeY, rangeY)
-- 	if #spectators ~= 0 then
-- 		return true
-- 	end
-- 	return false
-- end

-- local function clearBossRoom(playerId, centerPosition, rangeX, rangeY, exitPosition)
-- 	local spectators, spectator = Game.getSpectators(centerPosition, false, false, rangeX, rangeX, rangeY, rangeY)
-- 	for i = 1, #spectators do
-- 		spectator = spectators[i]
-- 		if spectator:isPlayer() and spectator.uid == playerId then
-- 			spectator:teleportTo(exitPosition)
-- 			exitPosition:sendMagicEffect(CONST_ME_TELEPORT)
-- 		end
-- 		if spectator:isMonster() then
-- 			spectator:remove()
-- 		end
-- 	end
-- end

-- local keys = Action()

-- function keys.onUse(player, item, fromPosition, target, toPosition, isHotkey)
-- 	local tmpConfig = config[item.itemid]
-- 	if not tmpConfig then
-- 		return true
-- 	end

-- 	if target.itemid ~= tmpConfig.targetId then
-- 		return true
-- 	end

-- 	local creature = Tile(tmpConfig.keyPlayerPosition):getTopCreature()
-- 	if not creature or not creature:isPlayer() then
-- 		return true
-- 	end

-- 	-- Lista de posições exatas dos jogadores a serem teleportados
-- 	local playerPositionsToTeleport = {
-- 		tmpConfig.keyPlayerPosition, -- Posição do jogador que ativou a chave
-- 		Position(tmpConfig.keyPlayerPosition.x, tmpConfig.keyPlayerPosition.y + 1, tmpConfig.keyPlayerPosition.z), -- Posição do jogador 1
-- 		Position(tmpConfig.keyPlayerPosition.x, tmpConfig.keyPlayerPosition.y + 2, tmpConfig.keyPlayerPosition.z), -- Posição do jogador 2
-- 		Position(tmpConfig.keyPlayerPosition.x, tmpConfig.keyPlayerPosition.y + 3, tmpConfig.keyPlayerPosition.z), -- Posição do jogador 3
-- 		Position(tmpConfig.keyPlayerPosition.x, tmpConfig.keyPlayerPosition.y + 4, tmpConfig.keyPlayerPosition.z)  -- Posição do jogador 4
-- 	}

-- 	-- Verifica se a sala está ocupada
-- 	if roomIsOccupied(tmpConfig.centerPosition, tmpConfig.rangeX, tmpConfig.rangeY) then
-- 		player:sendCancelMessage("Ha alguem na sala.")
-- 		return true
-- 	end

-- 	-- Cria o chefe e teletransporta os jogadores
-- 	local monster = Game.createMonster(tmpConfig.bossName, tmpConfig.bossPosition)
-- 	if not monster then
-- 		return true
-- 	end

-- 	-- Envia mensagens aos jogadores
-- 	for _, pos in ipairs(playerPositionsToTeleport) do
-- 		local playerAtPos = Tile(pos):getTopCreature()
-- 		if playerAtPos and playerAtPos:isPlayer() then
-- 			playerAtPos:teleportTo(tmpConfig.newPosition)
-- 			playerAtPos:setStorageValue(tmpConfig.storage)
-- 			playerAtPos:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
-- 		end
-- 	end

-- 	-- Envia mensagem ao jogador que ativou a chave
-- 	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Você e seus aliados entraram em uma cela de prisão de demônios antigas!')
-- 	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Vocês têm quinze minutos para derrotar e saquear este chefe, caso contrário, perderão essa chance.')

-- 	-- Agenda a limpeza da sala do chefe após um certo tempo
-- 	addEvent(clearBossRoom, 60 * tmpConfig.time * 1000, player:getId(), tmpConfig.centerPosition, tmpConfig.rangeX, tmpConfig.rangeY, tmpConfig.exitPosition)
-- 	item:remove()
-- 	return true
-- end

-- -- Associa IDs de itens à função 'onUse'
-- keys:id(20270, 20273, 20272)

-- -- Registra a manipulação de ação 'keys'
-- keys:register()
