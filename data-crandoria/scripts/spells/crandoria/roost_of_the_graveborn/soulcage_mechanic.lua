

----------------------------------------------------

local function getFreePositionsAround(center, radius)
	local free = {}
	for dx = -radius, radius do
		for dy = -radius, radius do
			if dx ~= 0 or dy ~= 0 then
				local pos = Position(center.x + dx, center.y + dy, center.z)
				local tile = Tile(pos)
				if tile
					and tile:getCreatureCount() == 0
					and not tile:hasFlag(TILESTATE_BLOCKSOLID)
					and not tile:hasFlag(TILESTATE_FLOORCHANGE)
					and not tile:hasFlag(TILESTATE_PROTECTIONZONE) then
					free[#free + 1] = pos
				end
			end
		end
	end
	return free
end

local center = Position(4562, 5010, 9)

-----------------------------------------

local DRAIN_TICKS = 5
local DRAIN_INTERVAL = 2000 -- ms entre cada tick

-- Guarda ids, nao objetos: durante os 10 segundos o alvo pode deslogar ou ser removido
local function drainTick(casterId, targetId, drain, remaining)
	local caster = Creature(casterId)
	local target = Creature(targetId)
	if not caster or not target then
		return
	end

	doTargetCombatHealth(0, caster, COMBAT_MANADRAIN, -drain, -drain, CONST_ME_DRAWBLOOD)

	if remaining > 1 then
		addEvent(drainTick, DRAIN_INTERVAL, casterId, targetId, drain, remaining - 1)
	end
end

-------------------------------------

local EXPLOSION_TICKS = 4
local EXPLOSION_INTERVAL = 4000 -- ms
local EXPLOSION_MIN = 800
local EXPLOSION_MAX = 1500

-- Converte a matriz AREA_CIRCLE2X2 em deslocamentos a partir do centro (valor 3)
local explosionOffsets = {}
do
	local centerRow, centerCol
	for y, row in ipairs(AREA_CIRCLE2X2) do
		for x, value in ipairs(row) do
			if value == 3 then
				centerRow, centerCol = y, x
			end
		end
	end
	for y, row in ipairs(AREA_CIRCLE2X2) do
		for x, value in ipairs(row) do
			if value ~= 0 then
				explosionOffsets[#explosionOffsets + 1] = { dx = x - centerCol, dy = y - centerRow }
			end
		end
	end
end

-- Guarda ids, nao objetos: durante os 16 segundos o alvo pode deslogar ou morrer
local function explosionTick(casterId, targetId, remaining)
	local target = Creature(targetId)
	if not target or target:getHealth() <= 0 then
		return
	end

	local caster = Creature(casterId)
	local center = target:getPosition() -- a explosao acompanha o alvo

	for _, offset in ipairs(explosionOffsets) do
		local pos = Position(center.x + offset.dx, center.y + offset.dy, center.z)
		pos:sendMagicEffect(CONST_ME_FIREAREA)

		local tile = Tile(pos)
		if tile then
			for _, victim in ipairs(tile:getCreatures() or {}) do
				if victim:isPlayer() then
					doTargetCombatHealth(caster or 0, victim, COMBAT_PHYSICALDAMAGE, -EXPLOSION_MIN, -EXPLOSION_MAX, CONST_ME_NONE)
				end
			end
		end
	end

	if remaining > 1 then
		addEvent(explosionTick, EXPLOSION_INTERVAL, casterId, targetId, remaining - 1)
	end
end

-----------------------------------------------

local area = {
	{fromPosition = Position(4550, 5001, 9), toPosition = Position(4571, 5021, 9)}
}

local function getPlayersInArea(area)
    local players = {}
    for x = area.fromPosition.x, area.toPosition.x do
        for y = area.fromPosition.y, area.toPosition.y do
            local pos = Position(x, y, area.fromPosition.z)
            local tile = Tile(pos)
            if tile then
                local creature = tile:getTopCreature()
                if creature and creature:isPlayer() then
                    table.insert(players, creature)
                end
            end
        end
    end
    return players
end

local condition1 = Condition(CONDITION_ROOTED)
condition1:setParameter(CONDITION_PARAM_TICKS, 3000)

local condition2 = Condition(CONDITION_PARALYZE)
condition2:setParameter(CONDITION_PARAM_TICKS, 5000)

local condition3 = Condition(CONDITION_FEARED)
condition3:setParameter(CONDITION_PARAM_TICKS, 3000)

local condition4 = Condition(CONDITION_DRUNK)
condition4:setParameter(CONDITION_PARAM_TICKS, 10000)

local function applyCondition1()
	local playersInArea = getPlayersInArea(area)
	for _, player in ipairs(playersInArea) do
		player:addCondition(condition1)
	end 
end

local function applyCondition2()
	local playersInArea = getPlayersInArea(area)
	for _, player in ipairs(playersInArea) do
		player:addCondition(condition2)
	end 
end

local function applyCondition3()
	local playersInArea = getPlayersInArea(area)
	for _, player in ipairs(playersInArea) do
		player:addCondition(condition3)
	end 
end

local function applyCondition4()
	local playersInArea = getPlayersInArea(area)
	for _, player in ipairs(playersInArea) do
		player:addCondition(condition4)
	end 
end

------------------------------------------------

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local hp = creature:getHealth()
	local pos = creature:getPosition()
	local chance = math.random(1, 8)
	local target = creature:getTarget()
	local timeNow = os.time()

	if chance == 1 then
		if Game.getStorageValue("soulcageFlame") > timeNow then
			return true
		else
			local free = getFreePositionsAround(center, 8)
			if #free > 0 then
				local randomFreePos = free[math.random(#free)]
				Game.createItem(52441, 1, randomFreePos)
				Game.setStorageValue("soulcageFlame", timeNow + 15)
			end
		end
	elseif chance == 2 then
		if Game.getStorageValue("soulcageEye") > timeNow then
			return true
		else
			local free = getFreePositionsAround(center, 8)
			if #free > 0 then
				local randomFreePos = free[math.random(#free)]
				Game.createMonster("An Eye", randomFreePos)
				Game.setStorageValue("soulcageEye", timeNow + 15)
			end
		end
	elseif chance == 3 then
		if Game.getStorageValue("soulcageTeleport") > timeNow then
			return true
		else
			if target then
				target:teleportTo(Position(4549, 5035, 9))
				Game.setStorageValue("soulcageTeleport", timeNow + 10)
			end
		end
	elseif chance == 4 then
		if Game.getStorageValue("soulcageMana") > timeNow then
			return true
		else
			if target then
				local drain = math.floor(target:getMaxMana() / 20)
				addEvent(drainTick, DRAIN_INTERVAL, creature:getId(), target:getId(), drain, DRAIN_TICKS)
				Game.setStorageValue("soulcageMana", timeNow + 10)
			end
		end
	elseif chance == 5 then
		if Game.getStorageValue("soulcageExplosion") > timeNow then
			return true
		else
			if target then
				addEvent(explosionTick, EXPLOSION_INTERVAL, creature:getId(), target:getId(), EXPLOSION_TICKS)
				Game.setStorageValue("soulcageExplosion", timeNow + 20)
			end
		end
	elseif chance > 5 then
		if creature:getName() == "Zharvorin's Soulcage" then
			applyCondition1()
		elseif creature:getName() == "Elyrax's Soulcage" then
			applyCondition2()
		elseif creature:getName() == "Myzareth's Soulcage" then
			applyCondition3()
		elseif creature:getName() == "Scarith's Soulcage" then
			applyCondition4()
		end
	end

	return true
end

spell:name("soulcage mechanic") 
spell:words("###851") 
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()