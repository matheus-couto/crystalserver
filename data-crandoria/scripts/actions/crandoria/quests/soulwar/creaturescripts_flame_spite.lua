local flamesSpite = MoveEvent()

function flamesSpite.onStepIn(creature, item, position, fromPosition)

	if not creature:isPlayer() then
		return true
	end

	local player = creature
	local tile = Tile(position)
	local flame = tile and tile:getItemById(33877)

	if flame then
		print("Player stepped on flame. Storage:", player:getStorageValue(Storage.Quest.U12_40.SoulWar.FlameTimer), "Current time:", os.time())
		
		if os.time() >= player:getStorageValue(Storage.Quest.U12_40.SoulWar.FlameTimer) then
			flame:remove()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The soul fire was stomped out in time! Your soul will now have to recover before you can do this again.")
			player:setStorageValue(Storage.Quest.U12_40.SoulWar.FlameTimer, os.time() + 60)
			addEvent(function()
				if player:isPlayer() then
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your soul has recovered!")
				end
			end, 60000)
		end
	end
	return true
end

flamesSpite:aid(13146)
flamesSpite:register()