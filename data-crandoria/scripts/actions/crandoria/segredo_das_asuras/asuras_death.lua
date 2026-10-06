local config = {
	centerPosition1 = Position(5432, 4771, 12),
	centerPosition2 = Position(5432, 4788, 12),
	centerPosition3 = Position(5412, 4779, 12),
	rangeX = 8,
	rangeY = 8,
}

local asuraFrostDeath = CreatureEvent("asuraFrostDeath")

function asuraFrostDeath.onDeath(creature)
	local spectators = Game.getSpectators(config.centerPosition1, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
	for _, specCreature in pairs(spectators) do
		if specCreature:isPlayer() then
			if specCreature:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret) == 3 then
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou a primeira das irmas asuras.")
				specCreature:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret, 6)
			elseif specCreature:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret) == 7 then
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou a segunda das irmas asuras.")
				specCreature:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret, 4)
			end
		end
	end

	return true
end

asuraFrostDeath:register()

local asuraFireDeath = CreatureEvent("asuraFireDeath")

function asuraFireDeath.onDeath(creature)
	local spectators = Game.getSpectators(config.centerPosition2, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
	for _, specCreature in pairs(spectators) do
		if specCreature:isPlayer() then
			if specCreature:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret) == 3 then
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou a primeira das irmas asuras.")
				specCreature:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret, 7)
			elseif specCreature:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret) == 6 then
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou a segunda das irmas asuras. Va ate Iaashna para obter uma recompensa.")
				specCreature:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret, 4)
			end
		end
	end

	return true
end

asuraFireDeath:register()

local asuraMidnightDeath = CreatureEvent("asuraMidnightDeath")

function asuraMidnightDeath.onDeath(creature)
	local spectators = Game.getSpectators(config.centerPosition3, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
	for _, specCreature in pairs(spectators) do
		if specCreature:isPlayer() then
			if specCreature:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret) == 9 then
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou a ultima das irmas asuras. Va ate Iaashna para obter sua recompensa.")
				specCreature:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret, 10)
			end
		end
	end

	return true
end

asuraMidnightDeath:register()
