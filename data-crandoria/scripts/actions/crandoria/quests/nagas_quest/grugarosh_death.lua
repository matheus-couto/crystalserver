local grugaroshDeath = CreatureEvent("grugaroshdeath")
function grugaroshDeath.onKill(creature, target)

local config = {
	centerPosition = Position(5893, 4423, 9),
	rangeX = 9,
	rangeY = 9,
}

	local spectators = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)

	if not target or not targetMonster or targetMonster:getName():lower() ~= "grugarosh" then
		return true
	end

	for _, specCreature in pairs(spectators) do
		if specCreature:isPlayer() then
			if specCreature:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 11 then
				specCreature:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 12)
			end
		end
	end
	return true
end

grugaroshDeath:register()