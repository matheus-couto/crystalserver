local teleportClash = Action()

function teleportClash.onUse(creature, item, fromPosition, target, toPosition)

	if creature:isMonster() then
		if creature:getOutfit().lookLegs == 0 then
			creature:teleportTo(Position(3956, 4762, 7))
		elseif creature:getOutfit().lookLegs == 114 then
			creature:teleportTo(Position(4005, 4762, 7))
		end
	elseif creature:isPlayer() then
		creature:teleportTo(Position(3980, 4778, 7))
		creature:setFaction(FACTION_PLAYER)
		creature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.TimeChaos, 0)
		creature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.TimeAnvillux, 0)
	end
	return true
	
end

teleportClash:aid(13117)
teleportClash:register()