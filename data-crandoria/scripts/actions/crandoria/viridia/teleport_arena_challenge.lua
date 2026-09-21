local chainsArena = Action()

function chainsArena.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local teleportPos = Position(4645, 5295, 12)
	local isteleport = Tile(teleportPos):getItemById(1949)

	if isteleport then
		return true
	else
		local teleport = Game.createItem(1949, 1, teleportPos)
		player:say('CLICK!', TALKTYPE_MONSTER_SAY)
		if teleport:isTeleport() then
			teleport:setDestination(Position(4657, 5254, 12))
			addEvent(function()
				local isteleport = Tile(teleportPos):getItemById(1949)
				if isteleport then
					isteleport:remove()
				end
			end, 60 * 1000)
		end
			
	end
	return true

end


chainsArena:aid(13098)
chainsArena:register()