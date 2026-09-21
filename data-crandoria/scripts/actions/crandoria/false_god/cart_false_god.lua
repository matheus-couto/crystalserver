local cartFalseGod = Action()
function cartFalseGod.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local storage =

	if item:getPosition() == Position() then
		if storage >= 8 then
			player:teleportTo(Position(5184, 4481, 14))
			return true
		else
			player:fromPosition():sendMagicEffect(CONST_ME_POFF)
			return true
		end
	elseif item:getPosition() == Position(5184, 4480, 14) then
		player:teleportTo(Position(5184, 4481, 14))
		return true
	end
	return true
end

cartFalseGod:aid(13221)
cartFalseGod:register()