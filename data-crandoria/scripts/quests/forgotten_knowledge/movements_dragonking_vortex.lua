local function functionBack()
	local soul, diference, health = false, 0, 0
	local spectators, spectator = Game.getSpectators(Position(5030, 4730, 15), false, false, 14, 14, 14, 14)
	for v = 1, #spectators do
		spectator = spectators[v]
		if spectator:getName():lower() == "soul of dragonking zyrtarch" then
			soul = true
		end
	end

	local dragonking = Tile(Position(4974, 4732, 14)):getTopCreature()
	if not soul then
		dragonking:remove()
		return true
	end

	local specs, spec = Game.getSpectators(Position(5030, 4730, 15), false, false, 14, 14, 14, 14)
	for i = 1, #specs do
		spec = specs[i]
		if spec:isPlayer() then
			spec:teleportTo(Position(4974, 4732, 15))
		elseif spec:isMonster() and spec:getName():lower() == "soul of dragonking zyrtarch" then
			spec:teleportTo(Position(4974, 4732, 14))
			health = spec:getHealth()
			diference = dragonking:getHealth() - health
		end
	end
	dragonking:addHealth(-diference)
	dragonking:teleportTo(Position(4974, 4732, 15))
end

local function removeVortex(position)
	local vortex = Tile(position):getItemById(23728)
	if vortex then
		vortex:remove()
	end
end

local dragonkingVortex = MoveEvent()

function dragonkingVortex.onStepIn(creature, item, position, fromPosition)
	if creature:isMonster() and creature:getName():lower() ~= "dragonking zyrtarch" then
		return true
	end
	if creature:isPlayer() then
		creature:teleportTo(Position(5029, 4730, 15))
	end
	if creature:getName():lower() == "dragonking zyrtarch" then
		local soul = Tile(Position(4974, 4732, 14)):getTopCreature()
		creature:teleportTo(Position(4974, 4732, 14))
		soul:teleportTo(Position(5031, 4730, 15))
		addEvent(functionBack, 30 * 1000)
		addEvent(removeVortex, 15 * 1000, position)
	end
	return true
end

dragonkingVortex:type("stepin")
dragonkingVortex:id(23728)
dragonkingVortex:register()
