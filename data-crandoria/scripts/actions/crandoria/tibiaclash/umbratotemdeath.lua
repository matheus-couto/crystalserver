local config = {
	area1 = { 
		fromPosition = Position(3952, 4760, 7), 
		toPosition = Position(4009, 4768, 7),
		centerPosition = Position(3980, 4762, 7),
	},
}

local umbraTotemDeath = CreatureEvent("umbraTotemDeath")

-- Função para obter e processar os espectadores de uma área
local function checkArea(area, rangeX, rangeY)
	local spectators = Game.getSpectators(area.centerPosition, false, false, 35, 35, 8, 8)
	for _, specCreature in pairs(spectators) do
		if specCreature:isPlayer() then
			specCreature:teleportTo(Position(4870, 5113, 7))
			if specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaClash.Time) == 1 then
				specCreature:addItem(22720, 1)
				specCreature:addExperience(specCreature:getLevel() * 5000)
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce venceu a partida e recebeu 1 Arena Token e um pouco de experiencia.")
			elseif specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaClash.Time) == 2 then
				specCreature:addExperience(specCreature:getLevel() * 1000)
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce foi derrotado e recebeu apenas um pouco de experiencia.")
			end
		elseif specCreature:isMonster() then
			specCreature:remove()
		end	
	end
end

function umbraTotemDeath.onDeath(creature)
	if creature:getOutfit().lookTypeEx == 16572 then
		-- Verifica os espectadores em cada uma das três áreas
		checkArea(config.area1, 35, 8)
		Game.setStorageValue(GlobalStorage.Crandoria.TibiaClashGlobal.Partida, 0)
	end

	return true
end

umbraTotemDeath:register()







