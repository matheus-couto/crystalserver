local keyFrostDragons = Action()

function keyFrostDragons.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if target.actionid == 13105 then 
		if target.itemid == 7033 then
			target:transform(7035)
			return true
		elseif target.itemid == 7035 then
			target:transform(7033)
			return true
		elseif target.itemid == 7034 then
			target:transform(7033)
			return true
		else
			return true
		end
	end

end

keyFrostDragons:aid(13105)
keyFrostDragons:register()