local tileViridia = Action()

function tileViridia.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if not player then
		return true
	end

	if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) ~= 1 then
		player:setStorageValue(Storage.Quest.Crandoria.Viridia.Citizen, 1)
		return true
	end

    return true
end

tileViridia:aid(13175)
tileViridia:register()