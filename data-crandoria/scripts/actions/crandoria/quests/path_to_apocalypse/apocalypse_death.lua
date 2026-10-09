local config = {
	centerPosition = Position(4936, 5235, 13),
	rangeX = 14,
	rangeY = 14,
}

local event = CreatureEvent("apocalypseDeath")

function event.onPrepareDeath(creature)
	local spectators = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
	for _, specCreature in pairs(spectators) do
		if specCreature:isPlayer() then
			if specCreature:getStorageValue(Storage.Quest.Crandoria.PathToApocalypse.Mount) < 1 then
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations you received the Shadow Draptor mount.")
				specCreature:addMount(24)
				specCreature:setStorageValue(Storage.Quest.Crandoria.PathToApocalypse.Mount, 1)
			end
			local storageRep = specCreature:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
			specCreature:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
			specCreature:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
		end
	end

	return true
end

event:register()