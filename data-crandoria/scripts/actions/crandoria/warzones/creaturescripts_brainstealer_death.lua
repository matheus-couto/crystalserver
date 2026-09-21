local config = {
	centerPosition = Position(5215, 5429, 11),
	rangeX = 11,
	rangeY = 11,
}

local theBrainstealerDeath = CreatureEvent("theBrainstealerDeath")

function theBrainstealerDeath.onPrepareDeath(creature)
	local spectators = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
	for _, specCreature in pairs(spectators) do
		if specCreature:isPlayer() then
			if specCreature:getStorageValue(Storage.Quest.Crandoria.BossTasks.Boss) == 25 and specCreature:getStorageValue(Storage.Quest.Crandoria.BossTasks.Count) < 1 then
				specCreature:setStorageValue(Storage.Quest.Crandoria.BossTasks.Count, 1)
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou o boss para Thorwulf.")
			end
			local storageRep = specCreature:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
			specCreature:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
			specCreature:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
		end
	end

	return true
end

theBrainstealerDeath:register()