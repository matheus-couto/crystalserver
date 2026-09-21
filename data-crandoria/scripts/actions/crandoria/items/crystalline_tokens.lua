local majorToken = Action()

function majorToken.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	item:remove(1)
	player:addItem(16128, 3)
	return true

end

majorToken:id(16129)
majorToken:register()


local minorToken = Action()

function minorToken.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if player:getItemCount(16128) > 2 then
		item:remove(3)
		player:addItem(16129, 1)
		return true
	else
		return true
	end

end

minorToken:id(16128)
minorToken:register()