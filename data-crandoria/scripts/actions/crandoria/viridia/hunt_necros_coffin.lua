local necrosHunt = Action()

function necrosHunt.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local tile = Tile(Position(4501, 5482, 9))

	local itemOnTile = tile:getItemById(164)
	if itemOnTile then
		itemOnTile:transform(166)
		addEvent(function()
			itemOnTile:transform(164)
		end, 60 * 1000)
	end
	player:say('CLICK!', TALKTYPE_MONSTER_SAY)
	return true
end


necrosHunt:aid(13091)
necrosHunt:register()