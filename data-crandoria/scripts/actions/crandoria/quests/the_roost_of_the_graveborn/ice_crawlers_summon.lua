local iceHorrorHealth = CreatureEvent("iceHorrorHealth")

local hasSummoned = false

local function isValidSpawnPosition(position)
    local tile = Tile(position)

    if not tile then
        return false
    end

    if tile:hasFlag(TILESTATE_BLOCKSOLID) then
        return false
    end

    if tile:getTopCreature() then
        return false
    end

    return true
end

local function summonIceCrawlers(creature)
	local center = creature:getPosition()
	local positions = {}

	-- Procura posições em uma área de 7 SQMs para cada lado
	for x = -7, 7 do
		for y = -7, 7 do
			if x ~= 0 or y ~= 0 then
				local position = Position(
					center.x + x,
					center.y + y,
					center.z
				)

				if isValidSpawnPosition(position) then
					table.insert(positions, position)
				end
			end
		end
	end
    -- Embaralha as posições
    for i = #positions, 2, -1 do
        local j = math.random(i)
        positions[i], positions[j] = positions[j], positions[i]
    end

    -- Cria até 20 Ice Crawlers
    local amount = math.min(20, #positions)

    for i = 1, amount do
        local monster = Game.createMonster("Ice Crawler", positions[i])

        if monster then
            positions[i]:sendMagicEffect(CONST_ME_TELEPORT)
        end
    end
end


function iceHorrorHealth.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature or not creature:getMonster() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    local currentHealth = creature:getHealth()

    if not hasSummoned and currentHealth <= 300000 and currentHealth > 250000 then
        summonIceCrawlers(creature)
		hasSummoned = true
    end

	if currentHealth <= 5000 then
		hasSummoned = false
	end

    return primaryDamage, primaryType, secondaryDamage, secondaryType
end

iceHorrorHealth:register()