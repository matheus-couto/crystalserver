local sorrowFlames = Action()

function sorrowFlames.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if target.itemid == 34013 then
		target:transform(34012)
		item:remove(1)
	elseif target.itemid == 34012 then
		target:transform(34011)
		item:remove(1)
	elseif target.itemid == 34011 then
		target:transform(34010)
		item:remove(1)
	elseif target.itemid == 34010 then
		target:transform(34009)
		item:remove(1)
	end
end


sorrowFlames:id(33793)
sorrowFlames:register()