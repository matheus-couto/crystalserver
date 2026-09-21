local cleansedSanity = Action()

function cleansedSanity.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if target.itemid == 33890 then
		target:transform(33951)
		addEvent(function()
			target:transform(33890)
		end, 20000)
		player:say("Megalomania levels has decreased!", TALKTYPE_MONSTER_SAY)
		item:remove(1)
	elseif target.itemid == 33951 then
		player:say("Too soon.", TALKTYPE_ORANGE_2)
	end
	return true
end

cleansedSanity:id(33950)
cleansedSanity:register()