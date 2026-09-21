local skullPoorSouls = Action()

function skullPoorSouls.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local delay = math.random(10000, 15000)

	
	if target.itemid == 33890 then
		target:transform(33951)
		player:say("The hunger for cruelty has lessened!", TALKTYPE_ORANGE_2)
		addEvent(function()
			target:transform(33890)
		end, delay)
		item:remove(1)
	elseif target.itemid == 33951 then
		player:say("Too soon.", TALKTYPE_ORANGE_2)
	end
	return true
end

skullPoorSouls:id(33891)
skullPoorSouls:register()