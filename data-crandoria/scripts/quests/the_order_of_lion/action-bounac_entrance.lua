
local bounacEntrance = Action()
function bounacEntrance.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item:getActionId() == 59602 then
		if player:getLevel() < 250 then
			player:sendCancelMessage("You need at least level 250.")
			toPosition:sendMagicEffect(CONST_ME_POFF)
		else
			player:teleportTo({x = 5241, y = 4411, z = 7})
			toPosition:sendMagicEffect(CONST_ME_WATERSPLASH)
			Position({x = 5241, y = 4411, z = 7}):sendMagicEffect(CONST_ME_WATERSPLASH)
		end
	elseif item:getActionId() == 59603 then		
		player:teleportTo({x = 5262, y = 4821, z = 7})
		Position({x = 5262, y = 4821, z = 7}):sendMagicEffect(CONST_ME_WATERSPLASH)
		toPosition:sendMagicEffect(CONST_ME_WATERSPLASH)
	end	
	return true
end
bounacEntrance:aid(59602)
bounacEntrance:aid(59603)
bounacEntrance:register()
