function clearDevourer()
	local upConer = { x = 5503, y = 4761, z = 15 } -- upLeftCorner
	local downConer = { x = 5526, y = 4786, z = 15 } -- downRightCorner
	for i = upConer.x, downConer.x do
		for j = upConer.y, downConer.y do
			for k = upConer.z, downConer.z do
				local tile = Tile(i, j, k)
				if tile then
					local creatures = tile:getCreatures()
					if creatures and #creatures > 0 then
						for _, creature in pairs(creatures) do
							if creature:isMonster() then -- éMonstro
								creature:remove()
							end
						end
					end
				end
			end
		end
	end
	stopEvent(areaDevourer4)
	stopEvent(areaDevourer5)
	stopEvent(areaDevourer6)
end

local function setStorageDevourer()
	local upConer = { x = 5503, y = 4761, z = 15 } -- upLeftCorner
	local downConer = { x = 5526, y = 4786, z = 15 } -- downRightCorner

	for i = upConer.x, downConer.x do
		for j = upConer.y, downConer.y do
			for k = upConer.z, downConer.z do
				local tile = Tile(i, j, k)
				if tile then
					local creatures = tile:getCreatures()
					if creatures and #creatures > 0 then
						for _, creature in pairs(creatures) do
							if creature:isPlayer() then -- éPlayer
								creature:setStorageValue(60835, 1)
								creature:setStorageValue(60814, 1)
								creature:setStorageValue(60828, 1)
							end
						end
					end
				end
			end
		end
	end
end

local function setStorage(fromPos, toPos, storage)
	local upConer = fromPos -- upLeftCorner
	local downConer = toPos -- downRightCorner

	for i = upConer.x, downConer.x do
		for j = upConer.y, downConer.y do
			for k = upConer.z, downConer.z do
				local room = { x = i, y = j, z = k }
				local tile = Tile(room)
				if tile then
					local creatures = tile:getCreatures()
					if creatures and #creatures > 0 then
						for _, creature in pairs(creatures) do
							if creature:isPlayer() and creature:getStorageValue(storage) < 1 then
								creature:setStorageValue(storage, 1) -- Access to boss Anomaly
							end
						end
					end
				end
			end
		end
	end
end

local bosses = {
	["anomaly"] = {
		tile = { x = 5454, y = 4820, z = 15 },
		actionId = 14325,
		fromPos = { x = 5452, y = 4808, z = 15 },
		toPos = { x = 5476, y = 4831, z = 15 },
		storage = 14326,
	},
	["rupture"] = {
		tile = { x = 5507, y = 4825, z = 15 },
		actionId = 14325,
		fromPos = { x = 5506, y = 4815, z = 15 },
		toPos = { x = 5527, y = 4836, z = 15 },
		storage = 14327,
	},
	["realityquake"] = {
		tile = { x = 5483, y = 4880, z = 15 },
		actionId = 14325,
		fromPos = { x = 5481, y = 4869, z = 15 },
		toPos = { x = 5504, y = 4891, z = 15 },
		storage = 14328,
	},
	["eradicator"] = {
		tile = { x = 5459, y = 4847, z = 15 },
		actionId = 14325,
		fromPos = { x = 5440, y = 4836, z = 15 },
		toPos = { x = 5461, y = 4857, z = 15 },
		storage = 14330,
	},
	["outburst"] = {
		tile = { x = 5423, y = 4762, z = 15 },
		actionId = 14325,
		fromPos = { x = 5421, y = 4751, z = 15 },
		toPos = { x = 5443, y = 4773, z = 15 },
		storage = 14332,
	},
}

local heartBossDeath = CreatureEvent("HeartBossDeath")

function heartBossDeath.onDeath(creature)
	if not creature or not creature:getMonster() then
		return true
	end

	local monsterName = creature:getName():lower()
	local bossName = bosses[monsterName]
	if bossName then
		local vortex = Tile(bossName.tile):getItemById(23483)
		if vortex then
			vortex:transform(23482)
			vortex:setActionId(bossName.actionId)
		end
		setStorage(bossName.fromPos, bossName.toPos, bossName.storage)
	elseif monsterName == "world devourer" then
		local vortex = Tile({ x = 5585, y = 4827, z = 15 }):getItemById(23483)
		if vortex then
			vortex:transform(23482)
			vortex:setActionId(14354)
		end
		setStorageDevourer()
		clearDevourer()
	end
	return true
end

heartBossDeath:register()
