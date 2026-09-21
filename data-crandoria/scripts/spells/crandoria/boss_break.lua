local function anomalyBreak(pos)
	local upConer = { x = pos.x - 1, y = pos.y - 1, z = pos.z } -- upLeftCorner
	local downConer = { x = pos.x + 1, y = pos.y + 1, z = pos.z } -- downRightCorner

	for i = upConer.x, downConer.x do
		for j = upConer.y, downConer.y do
			for k = upConer.z, downConer.z do
				local room = { x = i, y = j, z = k }
				local tile = Tile(room)
				if tile then
					local itemIds = {2118, 2119, 2120, 105, 2122, 2135, 2134}
					for _, itemId in ipairs(itemIds) do
						if tile:getItemById(itemId) then
							tile:getItemById(itemId):remove()
							Position(room):sendMagicEffect(3)
						end
					end
				end
			end
		end
	end
end

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local pos = creature:getPosition()
	anomalyBreak(pos)
end

spell:name("boss break")
spell:words("###585")
spell:blockWalls(true)
spell:needLearn(true)
spell:register()
