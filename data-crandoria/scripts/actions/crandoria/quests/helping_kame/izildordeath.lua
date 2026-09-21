local izildorDeath = CreatureEvent("izildordeath")
function izildorDeath.onKill(creature, target)

local config = {
	centerPosition = Position(5337, 4554, 9),
	rangeX = 8,
	rangeY = 8,
}

	local spectators = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)

	if not target or not targetMonster or targetMonster:getName():lower() ~= "izildor" then
		return true
	end

	for _, specCreature in pairs(spectators) do
		if specCreature:isPlayer() then
			if player:getStorageValue(Storage.Quest.Crandoria.OldKame.Progresso) == 6 then
				player:setStorageValue(Storage.Quest.Crandoria.OldKame.Progresso, 7)
			end
		end
	end
	return true
end

izildorDeath:register()