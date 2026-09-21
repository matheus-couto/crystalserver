local tilesMasmorraCaos = MoveEvent()

-- Lista de posições dos tiles da masmorra
local trapTiles = {
	Position(4815, 5165, 11),
	Position(4815, 5177, 11),
	Position(4869, 5169, 11),
	Position(4866, 5192, 11),
	Position(4850, 5232, 11),
	Position(4833, 5233, 11),
	-- adicione todas as posições dos tiles da sua masmorra
}

-- Configuração dos canhões
-- cada entrada: { pos = posição do canhão, dir = direção que ele atira }
-- dir: NORTH = 0, EAST = 1, SOUTH = 2, WEST = 3
local cannonConfig = {
	{ pos = Position(4827, 5163, 11), dir = 2 }, 
	{ pos = Position(4831, 5163, 11), dir = 2 },
	{ pos = Position(4840, 5163, 11), dir = 2 },
	{ pos = Position(4852, 5163, 11), dir = 2 },
	{ pos = Position(4838, 5177, 11), dir = 2 },
	{ pos = Position(4843, 5177, 11), dir = 2 },
	{ pos = Position(4824, 5195, 11), dir = 2 },
	{ pos = Position(4831, 5195, 11), dir = 2 },
	{ pos = Position(4852, 5195, 11), dir = 2 },
	{ pos = Position(4826, 5214, 11), dir = 2 },
	{ pos = Position(4831, 5214, 11), dir = 2 },
	{ pos = Position(4834, 5214, 11), dir = 2 },
	{ pos = Position(4838, 5214, 11), dir = 2 },
	{ pos = Position(4843, 5214, 11), dir = 2 },
	{ pos = Position(4850, 5214, 11), dir = 2 },
	{ pos = Position(4827, 5244, 11), dir = 2 },
	{ pos = Position(4829, 5244, 11), dir = 2 },
	{ pos = Position(4831, 5244, 11), dir = 2 },
	{ pos = Position(4835, 5244, 11), dir = 2 },
	{ pos = Position(4837, 5244, 11), dir = 2 },
	{ pos = Position(4845, 5157, 11), dir = 1 },
	{ pos = Position(4845, 5160, 11), dir = 1 },
	{ pos = Position(4852, 5169, 11), dir = 1 },
	{ pos = Position(4852, 5175, 11), dir = 1 },
	{ pos = Position(4852, 5169, 11), dir = 1 },
	{ pos = Position(4852, 5185, 11), dir = 1 },
	{ pos = Position(4852, 5189, 11), dir = 1 },
	{ pos = Position(4852, 5193, 11), dir = 1 },
	{ pos = Position(4852, 5204, 11), dir = 1 },
	{ pos = Position(4852, 5208, 11), dir = 1 },
	{ pos = Position(4852, 5212, 11), dir = 1 },
	{ pos = Position(4823, 5175, 11), dir = 1 },
	{ pos = Position(4823, 5180, 11), dir = 1 },
	{ pos = Position(4837, 5202, 11), dir = 1 },
	{ pos = Position(4837, 5206, 11), dir = 1 },
	{ pos = Position(4811, 5210, 11), dir = 1 },
	{ pos = Position(4811, 5223, 11), dir = 1 },
	{ pos = Position(4811, 5226, 11), dir = 1 },
	{ pos = Position(4811, 5229, 11), dir = 1 },
	{ pos = Position(4815, 5233, 11), dir = 1 },
	{ pos = Position(4815, 5236, 11), dir = 1 },
	{ pos = Position(4815, 5239, 11), dir = 1 },
}
-- dir: NORTH = 0, EAST = 1, SOUTH = 2, WEST = 3
local cannonConfig2 = {
	{ pos = Position(5019, 5135, 14), dir = 2 }, 
	{ pos = Position(5028, 5135, 14), dir = 2 }, 
	{ pos = Position(5031, 5135, 14), dir = 2 }, 
	{ pos = Position(5013, 5142, 14), dir = 2 }, 
	{ pos = Position(5023, 5142, 14), dir = 2 }, 
	{ pos = Position(5033, 5142, 14), dir = 2 }, 
	{ pos = Position(5018, 5147, 14), dir = 2 }, 
	{ pos = Position(5028, 5147, 14), dir = 2 }, 
	{ pos = Position(5013, 5152, 14), dir = 2 }, 
	{ pos = Position(5023, 5152, 14), dir = 2 }, 
	{ pos = Position(5033, 5152, 14), dir = 2 }, 
	{ pos = Position(5018, 5157, 14), dir = 2 }, 
	{ pos = Position(5007, 5146, 14), dir = 1 }, 
	{ pos = Position(5010, 5158, 14), dir = 1 }, 
	{ pos = Position(5013, 5147, 14), dir = 1 }, 
	{ pos = Position(5018, 5142, 14), dir = 1 }, 
	{ pos = Position(5018, 5152, 14), dir = 1 }, 
	{ pos = Position(5023, 5147, 14), dir = 1 }, 
	{ pos = Position(5023, 5157, 14), dir = 1 }, 
	{ pos = Position(5028, 5142, 14), dir = 1 }, 
	{ pos = Position(5028, 5152, 14), dir = 1 }, 
	{ pos = Position(5033, 5147, 14), dir = 1 }, 
}

-- Função para reagendar o tile depois do tempo
local function reactivateTile()
	local pos = trapTiles[math.random(#trapTiles)]
	local tile = Tile(pos)
	if tile then
		local item = tile:getItemById(1211)
		if item then
			item:transform(1210)
		end
	end
end

-- Disparo do canhão
local function fireCannon(cannon, player)
	local pos = cannon.pos
	local dir = cannon.dir
	local dmgMin, dmgMax = -1500, -2000
	local effect = CONST_ME_FIREATTACK

	-- percorre tiles à frente do canhão (3 a 4 sqm)
	for i = 1, 4 do
		local firePos
		if dir == 0 then
			firePos = Position(pos.x, pos.y - i, pos.z)
		elseif dir == 1 then
			firePos = Position(pos.x + i, pos.y, pos.z)
		elseif dir == 2 then
			firePos = Position(pos.x, pos.y + i, pos.z)
		elseif dir == 3 then
			firePos = Position(pos.x - i, pos.y, pos.z)
		end

		firePos:sendMagicEffect(effect)

		local tile = Tile(firePos)
		if tile then
			local target = tile:getTopCreature()
			if target and target:isPlayer() then
				doTargetCombatHealth(0, target, COMBAT_FIREDAMAGE, dmgMin, dmgMax, CONST_ME_FIREAREA)
				target:setStorageValue(Storage.Quest.Crandoria.MasmorraDoCaos.TimerTrap, os.time() + 5)
			end
		end
	end
end

function tilesMasmorraCaos.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	-- TILE DE ARMADILHA (1210 -> 1211)
	if item.itemid == 1210 then
		item:transform(1211)

		local currentTime = Game.getStorageValue(GlobalStorage.Crandoria.MasmorraDoCaos.TilesTrap)
		if currentTime < os.time() then
			currentTime = os.time()
		end
		local newTime = currentTime + (60 * 30)
		Game.setStorageValue(GlobalStorage.Crandoria.MasmorraDoCaos.TilesTrap, newTime)

		addEvent(function()
			if os.time() >= newTime then
				reactivateTile()
			end
		end, 60 * 30 * 1000)

	-- TILE NA FRENTE DO CANHÃO (por exemplo id = 15785)
	elseif item.itemid == 15785 then
		local aid = -1
		local previoustile = Tile(fromPosition)
		if previoustile then
			local ground = previoustile:getGround()
			if ground then
				aid = ground:getActionId()
			end
		end

		if aid == 13162 then
			-- só dispara se maldição estiver ativa
			if Game.getStorageValue(GlobalStorage.Crandoria.MasmorraDoCaos.TilesTrap) < os.time() then
				for _, cannon in ipairs(cannonConfig) do
					-- checa se o jogador está em linha com o canhão
					if (cannon.dir == 0 and position.x == cannon.pos.x and position.y < cannon.pos.y) or
					(cannon.dir == 2 and position.x == cannon.pos.x and position.y > cannon.pos.y) or
					(cannon.dir == 1 and position.y == cannon.pos.y and position.x > cannon.pos.x) or
					(cannon.dir == 3 and position.y == cannon.pos.y and position.x < cannon.pos.x) then
						fireCannon(cannon, player)
					end
				end
			end
		else
			if player:getStorageValue(Storage.Quest.Crandoria.MasmorraDoCaos.TimerTrap) < os.time() then
				if Game.getStorageValue(GlobalStorage.Crandoria.MasmorraDoCaos.TilesTrap) < os.time() then
					for _, cannon in ipairs(cannonConfig) do
						-- checa se o jogador está em linha com o canhão
						if (cannon.dir == 0 and position.x == cannon.pos.x and position.y < cannon.pos.y) or
						(cannon.dir == 2 and position.x == cannon.pos.x and position.y > cannon.pos.y) or
						(cannon.dir == 1 and position.y == cannon.pos.y and position.x > cannon.pos.x) or
						(cannon.dir == 3 and position.y == cannon.pos.y and position.x < cannon.pos.x) then
							fireCannon(cannon, player)
						end
					end
				end
			end
		end
		return true
	elseif item.itemid == 410 or item.itemid == 9856 or item.itemid == 9849 or item.itemid == 9850 or item.itemid == 9851 or item.itemid == 9852 or item.itemid == 9853 or item.itemid == 9854 or item.itemid == 9855 or item.itemid == 9856 or item.itemid == 9857 then
		local aid = -1
		local previoustile = Tile(fromPosition)
		if previoustile then
			local ground = previoustile:getGround()
			if ground then
				aid = ground:getActionId()
			end
		end
		if aid == 13162 then
			for _, cannon in ipairs(cannonConfig2) do
				-- checa se o jogador está em linha com o canhão
				if (cannon.dir == 0 and position.x == cannon.pos.x and position.y < cannon.pos.y and position.y > cannon.pos.y - 5) or
				(cannon.dir == 2 and position.x == cannon.pos.x and position.y > cannon.pos.y and position.y < cannon.pos.y + 5) or
				(cannon.dir == 1 and position.y == cannon.pos.y and position.x > cannon.pos.x and position.x < cannon.pos.x + 5) or
				(cannon.dir == 3 and position.y == cannon.pos.y and position.x < cannon.pos.x and position.x > cannon.pos.x - 5) then
					fireCannon(cannon, player)
				end
			end
		else
			if player:getStorageValue(Storage.Quest.Crandoria.MasmorraDoCaos.TimerTrap) < os.time() then
				for _, cannon in ipairs(cannonConfig2) do
					-- checa se o jogador está em linha com o canhão
					if (cannon.dir == 0 and position.x == cannon.pos.x and position.y < cannon.pos.y and position.y > cannon.pos.y - 5) or
					(cannon.dir == 2 and position.x == cannon.pos.x and position.y > cannon.pos.y and position.y < cannon.pos.y + 5) or
					(cannon.dir == 1 and position.y == cannon.pos.y and position.x > cannon.pos.x and position.x < cannon.pos.x + 5) or
					(cannon.dir == 3 and position.y == cannon.pos.y and position.x < cannon.pos.x and position.x > cannon.pos.x - 5) then
						fireCannon(cannon, player)
					end
				end
			end
		end
	elseif item.itemid == 1211 then
		local chance = math.random(1, 3)
		if chance == 1 then
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:teleportTo(Position(4747, 5229, 11))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			return true
		elseif chance == 2 then
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:teleportTo(Position(4733, 5249, 11))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			return true
		elseif chance == 3 then
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:teleportTo(Position(4733, 5276, 11))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			return true
		end
	elseif item.itemid == 1949 then
		player:teleportTo(Position(4864, 5169, 11))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
end

tilesMasmorraCaos:aid(13077)
tilesMasmorraCaos:register()





-- local tilesMasmorraCaos = MoveEvent()

-- -- Lista de posições dos tiles da masmorra
-- local trapTiles = {
-- 	Position(4815, 5165, 11),
-- 	Position(4815, 5177, 11),
-- 	Position(4869, 5169, 11),
-- 	Position(4866, 5192, 11),
-- 	Position(4850, 5232, 11),
-- 	Position(4833, 5233, 11),
-- 	-- adicione todas as posições dos tiles da sua masmorra
-- }

-- -- Função para reagendar o tile depois do tempo
-- local function reactivateTile()
-- 	-- escolhe um tile aleatório da lista
-- 	local pos = trapTiles[math.random(#trapTiles)]
-- 	local tile = Tile(pos)
-- 	if tile then
-- 		local item = tile:getItemById(1211)
-- 		if item then
-- 			item:transform(1210)
-- 		end
-- 	end
-- end

-- function tilesMasmorraCaos.onStepIn(creature, item, position, fromPosition)
-- 	local player = creature:getPlayer()
-- 	if not player then
-- 		return true
-- 	end

-- 	-- Só funciona para tiles 1210
-- 	if item.itemid == 1210 then
-- 		-- transforma em 1211
-- 		item:transform(1211)

-- 		-- adiciona 20 minutos ao temporizador global
-- 		local currentTime = Game.getStorageValue(GlobalStorage.Crandoria.MasmorraDoCaos.TilesTrap)
-- 		if currentTime < os.time() then
-- 			currentTime = os.time()
-- 		end
-- 		local newTime = currentTime + (60 * 20)
-- 		Game.setStorageValue(GlobalStorage.Crandoria.MasmorraDoCaos.TilesTrap, newTime)

-- 		-- agenda a reativação do tile
-- 		addEvent(function()
-- 			if os.time() >= newTime then
-- 				reactivateTile()
-- 			end
-- 		end, 60 * 20 * 1000) -- 20 minutos em ms
-- 	elseif item.itemid == 15785 then
-- 		local px = player:getPosition().x
-- 		local py = player:getPosition().y
-- 	end

-- 	return true
-- end

-- tilesMasmorraCaos:aid(13077)
-- tilesMasmorraCaos:register()




-- local tilesMasmorraCaos = MoveEvent()

-- function tilesMasmorraCaos.onStepIn(creature, item, position, fromPosition)

-- 	local player = creature:getPlayer()

-- 	if not player then
-- 		return true
-- 	end

-- 	if player:getLevel() >= 800 then
-- 		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
-- 		player:teleportTo(Position(4802, 5183, 11))
-- 		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
-- 		return true
-- 	else
-- 		return true
-- 	end
	
-- end

-- tilesMasmorraCaos:aid(13077)
-- tilesMasmorraCaos:register()