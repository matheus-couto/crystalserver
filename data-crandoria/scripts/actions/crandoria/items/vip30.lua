local days = 30 --dias que da de vip

local vip = Action()
function vip.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if Tile(player:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) then
		player:addPremiumDays(days)
		player:onAddVip(days)
		item:remove(1) 
		player:save()
		player:remove()
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You recived 30 days of VIP time.")
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
	else
		player:sendCancelMessage("You can't use this when you're in a fight and in protection zone.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
	end
	return true
end


vip:id(14758) -- id vip scroll
vip:register()