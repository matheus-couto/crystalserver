local dracantusSecret = Action()

function dracantusSecret.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player then
		return true
	end

	local pos = player:getPosition()
	local storage = player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso)


	if storage >= 11 then
		if pos.Y == 5078 then
			player:teleportTo(Position(4493, 5076, 7))
			return false
		elseif pos.Y == 5076 then
			player:teleportTo(Position(4493, 5078, 7))
			return false
		end
	end
	return true
end

dracantusSecret:id(13206)
dracantusSecret:register()