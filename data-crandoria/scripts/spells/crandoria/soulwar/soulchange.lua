local EXPLOSION_MIN = 2500
local EXPLOSION_MAX = 5000

local function explode(creature)
	local center = creature:getPosition()
	local area = AREA_CIRCLE2X2

	-- localiza o centro da matriz (o valor 3)
	local centerRow, centerCol
	for y, row in ipairs(area) do
		for x, value in ipairs(row) do
			if value == 3 then
				centerRow, centerCol = y, x
			end
		end
	end

	for y, row in ipairs(area) do
		for x, value in ipairs(row) do
			if value ~= 0 then
				local pos = Position(center.x + (x - centerCol), center.y + (y - centerRow), center.z)
				pos:sendMagicEffect(CONST_ME_FIREAREA)

				local tile = Tile(pos)
				if tile then
					for _, target in ipairs(tile:getCreatures() or {}) do
						if target:isPlayer() then
							doTargetCombatHealth(creature, target, COMBAT_FIREDAMAGE, -EXPLOSION_MIN, -EXPLOSION_MAX, CONST_ME_NONE)
						end
					end
				end
			end
		end
	end
end

local spell = Spell("instant")
function spell.onCastSpell(creature, var)
	local position = creature:getPosition()

	if creature:getName() == "Weak Soul" then
		creature:remove()
		Game.createMonster("Strong Soul", position)
	elseif creature:getName() == "Strong Soul" then
		creature:remove()
		Game.createMonster("Powerful Soul", position)
	elseif creature:getName() == "Powerful Soul" then
		explode(creature)
		creature:remove()
	elseif creature:getName() == "Lesser Splinter of Madness" then
		creature:remove()
		Game.createMonster("Greater Splinter of Madness", position)
	elseif creature:getName() == "Greater Splinter of Madness" then
		creature:remove()
		Game.createMonster("Mighty Splinter of Madness", position)
	end

	return true
end


spell:name("soulchange")
spell:words("###741")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()
