local config = {
	centerPosition = Position(32208, 32046, 15),
	rangeX = 16,
	rangeY = 16,
}

local event = CreatureEvent("nightmarebeastDeath")

function event.onPrepareDeath(creature)
	local spectators = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
	for _, specCreature in pairs(spectators) do
		if specCreature:isPlayer() then
			if specCreature:getStorageValue(Storage.Quest.U12_00.DreamWarriorOutfits.Outfit) < 1 then
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations you received the Dream Warrior Outfit.")
				specCreature:addOutfit(1146, 0)
				specCreature:addOutfit(1147, 0)
				local storageRep = specCreature:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
				specCreature:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
				specCreature:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
				specCreature:setStorageValue(Storage.Quest.U12_00.DreamWarriorOutfits.Outfit, 1)
			end
		end
	end

	return true
end

event:register()