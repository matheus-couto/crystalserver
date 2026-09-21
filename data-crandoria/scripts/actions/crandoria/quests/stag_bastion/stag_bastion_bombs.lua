local config = {
	creatureNames = { "Adlerauge" },

	checkArea = {
		from = Position(5266, 5495, 2),
		to = Position(5284, 5504, 2),
	},

	explosionRadius = 2,
	damagePercent = 0.4,

	markerItemId = 51884,

	warmupDelay = 1000,
	explosionDelay = 2000,

	playerCooldown = 5,
	gameCooldown = 2,
}

-- Area oficial do sistema
local explosionArea = createCombatArea(AREA_CIRCLE2X2)


local function hasCreatureInArea(fromPosition, toPosition, creatureNames)
	for x = fromPosition.x, toPosition.x do
		for y = fromPosition.y, toPosition.y do
			local pos = Position(x, y, fromPosition.z)
			local tile = Tile(pos)

			if tile then
				local creature = tile:getTopCreature()

				if creature and table.contains(creatureNames, creature:getName()) then
					return true
				end
			end
		end
	end

	return false
end


-- Sorteia um ponto no maximo 2 SQMs da posicao informada.
local function getRandomPointNear(playerPosition, radius)
	local x = playerPosition.x + math.random(-radius, radius)
	local y = playerPosition.y + math.random(-radius, radius)

	local position = Position(x, y, playerPosition.z)
	local tile = Tile(position)

	if not tile or tile:hasFlag(TILESTATE_BLOCKSOLID) then
		return playerPosition
	end

	return position
end


-- Verifica se o deslocamento pertence a AREA_CIRCLE2X2.
local function isInsideCircle2x2(dx, dy)
	local maxDistance = config.explosionRadius

	if math.abs(dx) > maxDistance or math.abs(dy) > maxDistance then
		return false
	end

	-- Remove os quatro cantos da matriz 5x5.
	if math.abs(dx) == maxDistance and math.abs(dy) == maxDistance then
		return false
	end

	return true
end


local function explodeAt(position)
	-- Efeito em toda a AREA_CIRCLE2X2
	doAreaCombatHealth(
		0,
		COMBAT_NONE,
		position,
		explosionArea,
		0,
		0,
		CONST_ME_FIREAREA
	)

	local spectators = Game.getSpectators(
		position,
		false,
		true,
		config.explosionRadius,
		config.explosionRadius,
		config.explosionRadius,
		config.explosionRadius
	)

	for _, target in ipairs(spectators) do
		local targetPosition = target:getPosition()

		local dx = targetPosition.x - position.x
		local dy = targetPosition.y - position.y

		if targetPosition.z == position.z and isInsideCircle2x2(dx, dy) then

			local shouldDamage = false

			-- Jogador
			if target:isPlayer() then
				shouldDamage = true

			-- Summon de jogador
			elseif target:isMonster() then
				local master = target:getMaster()

				if master and master:isPlayer() then
					shouldDamage = true
				end
			end

			if shouldDamage then
				local damage = math.floor(
					target:getMaxHealth() * config.damagePercent
				)

				if damage > 0 then
					doTargetCombatHealth(
						0,
						target,
						COMBAT_AGONYDAMAGE,
						-damage,
						-damage,
						CONST_ME_NONE,
						ORIGIN_NONE
					)
				end
			end
		end
	end
end


local bombStag = MoveEvent()

function bombStag.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()

	if not player then
		return true
	end

	local timeNow = os.time()

	local playerStorage = player:getStorageValue(
		Storage.Quest.Crandoria.StagBastion.BombTimerPlayer
	)

	local gameStorage = Game.getStorageValue(
		Storage.Quest.Crandoria.StagBastion.BombTimerGame
	)

	if gameStorage > timeNow or playerStorage > timeNow then
		return true
	end

	if not hasCreatureInArea(
		config.checkArea.from,
		config.checkArea.to,
		config.creatureNames
	) then
		return true
	end

	player:setStorageValue(
		Storage.Quest.Crandoria.StagBastion.BombTimerPlayer,
		timeNow + config.playerCooldown
	)

	Game.setStorageValue(
		Storage.Quest.Crandoria.StagBastion.BombTimerGame,
		timeNow + config.gameCooldown
	)

	-- Guardamos somente o ID do jogador.
	local playerId = player:getId()

	addEvent(function()
		-- Recupera o jogador depois do warmup.
		local targetPlayer = Player(playerId)

		if not targetPlayer then
			return
		end

		-- IMPORTANTE:
		-- A posicao e obtida AGORA, depois dos 1000ms.
		-- Portanto, se o jogador correu para longe do tile
		-- que acionou a armadilha, o alvo sera criado perto dele.
		local currentPlayerPosition = targetPlayer:getPosition()

		local pointInArea = getRandomPointNear(
			currentPlayerPosition,
			config.explosionRadius
		)

		local tile = Tile(pointInArea)

		if not tile then
			return
		end

		-- Criamos o alvo.
		local alvo = Game.createItem(
			config.markerItemId,
			1,
			pointInArea
		)

		targetPlayer:say(
			"TARGETS MARKED. RUN!",
			TALKTYPE_MONSTER_SAY
		)

		-- Guarda a posicao da explosao.
		local explosionPosition = Position(
			pointInArea.x,
			pointInArea.y,
			pointInArea.z
		)

		addEvent(function()
			-- Remove o alvo antes da explosao.
			if alvo then
				alvo:remove()
			else
				-- Fallback: tenta remover qualquer alvo que
				-- ainda esteja no SQM.
				local explosionTile = Tile(explosionPosition)

				if explosionTile then
					local marker = explosionTile:getItemById(
						config.markerItemId
					)

					if marker then
						marker:remove()
					end
				end
			end

			-- Explode exatamente onde o alvo estava.
			explodeAt(explosionPosition)

		end, config.explosionDelay)

	end, config.warmupDelay)

	return true
end

bombStag:aid(13216)
bombStag:register()

-- local config = {
-- 	creatureNames = { "Adlerauge" },
-- 	checkArea = {
-- 		from = Position(5266, 5495, 2),
-- 		to = Position(5284, 5504, 2),
-- 	},
-- 	explosionRadius = 2, -- raio do ponto aleatório em relação ao jogador, e raio da própria explosão
-- 	damagePercent = 0.4,
-- 	markerItemId = 51884,
-- 	warmupDelay = 1000,    -- tempo entre o passo e o alvo aparecer no chão
-- 	explosionDelay = 3000, -- tempo entre o alvo aparecer e a explosão (bate com o tempo de vida do item 51884)
-- 	playerCooldown = 5,    -- segundos: cooldown individual por jogador
-- 	gameCooldown = 2,      -- segundos: cooldown global (evita bombas em sequência muito rápida no mesmo local)
-- }

-- local function hasCreatureInArea(fromPosition, toPosition, creatureNames)
-- 	for x = fromPosition.x, toPosition.x do
-- 		for y = fromPosition.y, toPosition.y do
-- 			local pos = Position(x, y, fromPosition.z)
-- 			local tile = Tile(pos)
-- 			if tile then
-- 				local creature = tile:getTopCreature()
-- 				if creature and table.contains(creatureNames, creature:getName()) then
-- 					return true
-- 				end
-- 			end
-- 		end
-- 	end
-- 	return false
-- end

-- -- Sorteia um ponto próximo ao jogador; se o tile sorteado não for válido
-- -- (bloqueado/inexistente), cai de volta pra posição do próprio jogador.
-- local function getRandomPointNear(position, radius)
-- 	local x = position.x + math.random(-radius, radius)
-- 	local y = position.y + math.random(-radius, radius)
-- 	local pos = Position(x, y, position.z)

-- 	local tile = Tile(pos)
-- 	if not tile or tile:hasFlag(TILESTATE_BLOCKSOLID) then
-- 		return position
-- 	end

-- 	return pos
-- end

-- -- local function explodeAt(position)
-- -- 	position:sendMagicEffect(CONST_ME_FIREAREA)

-- -- 	-- Atinge TODOS os jogadores na área da explosão, não só quem pisou no sqm original
-- -- 	local spectators = Game.getSpectators(position, false, true, config.explosionRadius, config.explosionRadius, config.explosionRadius, config.explosionRadius)
-- -- 	for _, target in ipairs(spectators) do
-- -- 		local damage = math.floor(target:getMaxHealth() * config.damagePercent)
-- -- 		if damage > 0 then
-- -- 			doTargetCombatHealth(0, target, COMBAT_AGONYDAMAGE, -damage, -damage, CONST_ME_NONE, ORIGIN_NONE)
-- -- 		end
-- -- 	end
-- -- end

-- local function explodeAt(position)
-- 	position:sendMagicEffect(CONST_ME_FIREAREA)

-- 	local spectators = Game.getSpectators(position, false, true, config.explosionRadius, config.explosionRadius, config.explosionRadius, config.explosionRadius)

-- 	for _, target in ipairs(spectators) do
-- 		if target:isPlayer() then
-- 			local damage = math.floor(target:getMaxHealth() * config.damagePercent)

-- 			if damage > 0 then
-- 				doTargetCombatHealth(0, target, COMBAT_AGONYDAMAGE, -damage, -damage, CONST_ME_NONE, ORIGIN_NONE)
-- 			end
-- 		elseif target:isMonster() then
-- 			local master = target:getMaster()

-- 			if master and master:isPlayer() then
-- 				local damage = math.floor(target:getMaxHealth() * config.damagePercent)

-- 				if damage > 0 then
-- 					doTargetCombatHealth(0, target, COMBAT_AGONYDAMAGE, -damage, -damage, CONST_ME_NONE, ORIGIN_NONE)
-- 				end
-- 			end
-- 		end
-- 	end
-- end

-- local bombStag = MoveEvent()

-- function bombStag.onStepIn(creature, item, position, fromPosition)
-- 	local player = creature:getPlayer()
-- 	if not player then
-- 		return true
-- 	end

-- 	local timeNow = os.time()
-- 	local playerStorage = player:getStorageValue(Storage.Quest.Crandoria.StagBastion.BombTimerPlayer)
-- 	local gameStorage = Game.getStorageValue(Storage.Quest.Crandoria.StagBastion.BombTimerGame)

-- 	if gameStorage > timeNow or playerStorage > timeNow then
-- 		return true
-- 	end

-- 	if not hasCreatureInArea(config.checkArea.from, config.checkArea.to, config.creatureNames) then
-- 		return true
-- 	end

-- 	player:setStorageValue(Storage.Quest.Crandoria.StagBastion.BombTimerPlayer, timeNow + config.playerCooldown)
-- 	Game.setStorageValue(Storage.Quest.Crandoria.StagBastion.BombTimerGame, timeNow + config.gameCooldown)

-- 	local pointInArea = getRandomPointNear(position, config.explosionRadius)

-- 	addEvent(function()
-- 		Game.createItem(config.markerItemId, 1, pointInArea)
-- 		player:say('TARGETS MARKED. RUN!', TALKTYPE_MONSTER_SAY)

-- 		addEvent(function()
-- 			explodeAt(pointInArea)
-- 		end, config.explosionDelay)
-- 	end, config.warmupDelay)

-- 	return true
-- end

-- bombStag:aid(13216)
-- bombStag:register()

-- -- local config = {
-- --     creatureNames = {"Adlerauge"}
-- -- }

-- -- local function hasCreatureInArea(fromPosition, toPosition, creatureNames)
-- --     for x = fromPosition.x, toPosition.x do
-- --         for y = fromPosition.y, toPosition.y do
-- --             local pos = Position(x, y, fromPosition.z)
-- --             local tile = Tile(pos)
-- --             if tile then
-- --                 local creature = tile:getTopCreature()
-- --                 if creature and table.contains(creatureNames, creature:getName()) then
-- --                     return true
-- --                 end
-- --             end
-- --         end
-- --     end
-- --     return false
-- -- end

-- -- local bombStag = MoveEvent()

-- -- function bombStag.onStepIn(creature, item, position, fromPosition)
-- --     local player = creature:getPlayer()
-- --     if not player then
-- --         return true
-- --     end

-- --     local playerStorage = player:getStorageValue(Storage.Quest.Crandoria.StagBastion.BomTimerPlayer)
-- --     local gameStorage = Game.getStorageValue(Storage.Quest.Crandoria.StagBastion.BombTimerGame)
-- --     local timeNow = os.time()


-- --     local formPos = Position(Position().x - 2, Position().y - 2, Position().z)
-- --     local toPos = Position(Position().x + 2, Position().y + 2, Position().z)

-- --     if gameStorage > timeNow or playerStorage > timeNow then
-- --         return true
-- --     end

-- --     if hasCreatureInArea(Position(5266, 5495, 2), Position(5284, 5504, 2), config.creatureNames) then
-- --         local pointInArea = -- criar uma forma de inserir um ponto aleatorio
-- --         local damage = player:getMaxHealth() * 0.4 -- isso deve ser feito para cada jogador atingido, entao provavelmente dessa forma ainda nao sera o suficiente a nao ser para quem pisou
-- --         addEvent(function()
-- --             Game.createItem(51884, 1, pointInArea)
-- --             player:say('TARGETS MARKED. RUN!', TALKTYPE_MONSTER_SAY)
-- --             addEvent(function()
-- --                 -- criar uma explosao partindo de um ponto aleatorio proximo ao personagem de acordo com a area fromPos e toPos ou de uma forma melhor. com a área = AREA_CIRCLE2X2, efeito = CONST_ME_FIREAREA, dano aplicado por: doTargetCombatHealth(cid, target, type, min, max, effect[, origin = ORIGIN_SPELL]) sendo o dano equivalente a 40% da vida maxima do alvo com dano Ahony = COMBAT_AGONYDAMAGE
-- --                 player:setStorageValue(Storage.Quest.Crandoria.StagBastion.BomTimerPlayer, timeNow + 5)
-- --                 Game.setStorageValue(Storage.Quest.Crandoria.StagBastion.BombTimerGame, timeNow + 2)
-- --             end, 3000) -- o item 51884 sumirá sozinho apos 3 segundos. Faz parte da configuracao no items.xml. Nada para se preocupar sobre isso
-- --         end, 1000)
-- --     else
-- --         return true
-- --     end

-- -- end

-- -- bombStag:aid(13216)
-- -- bombStag:register()