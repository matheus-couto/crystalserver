local config = {
	area1 = { 
		fromPosition = Position(4030, 4837, 7), 
		toPosition = Position(4093, 4876, 7),
		centerPosition = Position(4061, 4856, 7),
	},
}

local crandoriaTowerDeath = CreatureEvent("crandoriaTowerDeath")

-- Função para obter e processar os espectadores de uma área
local function checkArea(area, rangeX, rangeY)
	local spectators = Game.getSpectators(area.centerPosition, false, false, 35, 35, 20, 20)
	for _, specCreature in pairs(spectators) do
		if specCreature:isPlayer() then
			specCreature:teleportTo(Position(4870, 5113, 7))
			if specCreature:getStorageValue(Storage.Quest.Crandoria.Batalha.Time) == 2 then
				if specCreature:getStorageValue(Storage.Quest.Crandoria.Batalha.TimerPartida) > os.time() + 25 * 60 then
					specCreature:addItem(22720, 10)
					specCreature:addExperience(specCreature:getLevel() * 20000)
					specCreature:addItem(26186, 3)
				elseif specCreature:getStorageValue(Storage.Quest.Crandoria.Batalha.TimerPartida) > os.time() + 20 * 60 then
					specCreature:addItem(22720, 9)
					specCreature:addExperience(specCreature:getLevel() * 19000)
					specCreature:addItem(26186, 2)
				elseif specCreature:getStorageValue(Storage.Quest.Crandoria.Batalha.TimerPartida) > os.time() + 15 * 60 then
					specCreature:addItem(22720, 8)
					specCreature:addExperience(specCreature:getLevel() * 18000)
					specCreature:addItem(26186, 1)
				elseif specCreature:getStorageValue(Storage.Quest.Crandoria.Batalha.TimerPartida) > os.time() + 10 * 60 then
					specCreature:addItem(22720, 7)
					specCreature:addExperience(specCreature:getLevel() * 17000)
					specCreature:addItem(26186, 1)
				elseif specCreature:getStorageValue(Storage.Quest.Crandoria.Batalha.TimerPartida) > os.time() + 5 * 60 then
					specCreature:addItem(22720, 6)
					specCreature:addExperience(specCreature:getLevel() * 16000)
				elseif specCreature:getStorageValue(Storage.Quest.Crandoria.Batalha.TimerPartida) >= os.time() then
					specCreature:addItem(22720, 5)
					specCreature:addExperience(specCreature:getLevel() * 15000)
				else
					specCreature:addExperience(specCreature:getLevel() * 5000)
					specCreature:addItem(22720, 1)
				end
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Seu time venceu a partida e recebeu Arena Tokens e uma grande quantia de experiencia.")
			elseif specCreature:getStorageValue(Storage.Quest.Crandoria.Batalha.Time) == 1 then
				specCreature:addExperience(specCreature:getLevel() * 5000)
				specCreature:addItem(22720, 1)
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce foi derrotado e recebeu 1 Arena Token e um pouco de experiencia pela participacao.")
			end
			Game.setStorageValue(GlobalStorage.Crandoria.BatalhaCampal.Partida, 0)
		elseif specCreature:isMonster() then
			specCreature:remove()
		end	
	end
end

function crandoriaTowerDeath.onDeath(creature)
	if creature:getOutfit().lookTypeEx == 2105 then
		checkArea(config.area1, 35, 20)
		Game.setStorageValue(GlobalStorage.Crandoria.BatalhaCampal.Partida, 0)
	end

	return true
end

crandoriaTowerDeath:register()







