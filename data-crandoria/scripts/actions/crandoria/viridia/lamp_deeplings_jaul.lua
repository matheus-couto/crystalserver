local lampDeeplings = Action()

function lampDeeplings.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if player:getLevel() >= 200 then
		player:say('GLUP!', TALKTYPE_MONSTER_SAY)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:teleportTo(Position(4518, 5406, 12))
		player:say('glub glub', TALKTYPE_MONSTER_SAY)
		return true
	else
		return true
	end

end


lampDeeplings:aid(13090)
lampDeeplings:register()