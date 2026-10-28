local adventurerGroupDeath = CreatureEvent("adventurerGroupDeath")

local teleportConfig = {
		creatureNames = { "Fatal Bug", "Fiona Firstdream", "Grendel Greenlunch", "Nigel Neverguess", "Percy Peacetinker", "Yorik Youngbook"}
	}

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

function adventurerGroupDeath.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	local player = mostDamageKiller or killer
	if not player or not player:isPlayer() then
		return true
	end

	if hasCreatureInArea(Position(4448, 4952, 9), Position(4465, 4967, 9), teleportConfig.creatureNames) then
		return true
	else
		addEvent(function()
			Game.createMonster("Fatal Bug", Position(4456, 4959, 9))
		end, 250)
		return true
	end

	return true
end

adventurerGroupDeath:register()