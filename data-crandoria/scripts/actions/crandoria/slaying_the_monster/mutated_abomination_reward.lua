local mutatedAbomination = Action()
function mutatedAbomination.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.SlayingTheMonster.TheMonsterKilled) == 1 then
		player:addMount(206)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been rewarded with the Mutated Abomination Mount!")
		player:setStorageValue(Storage.Quest.Crandoria.SlayingTheMonster.TheMonsterKilled, 2)
		return true
	elseif
		player:getStorageValue(Storage.Quest.Crandoria.SlayingTheMonster.TheMonsterKilled) == 2 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already taken the mount.")
	return true

	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have to slay The Monster to be rewarded with this mount.")
	end
end

mutatedAbomination:position({x = 5404, y = 4290, z = 12})
mutatedAbomination:uid(12258)
mutatedAbomination:register()