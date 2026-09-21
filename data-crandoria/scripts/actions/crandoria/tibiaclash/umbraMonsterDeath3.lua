local config = {
	area1 = { 
		fromPosition = Position(3952, 4760, 7), 
		toPosition = Position(4009, 4768, 7),
		centerPosition = Position(3980, 4763, 7),
	},
}

local umbraMonsterDeath3 = CreatureEvent("umbraMonsterDeath3")

-- Função para obter e processar os espectadores de uma área
local function checkArea(area, rangeX, rangeY)
	local spectators = Game.getSpectators(area.centerPosition, false, false, 35, 35, 8, 8)
	for _, specCreature in pairs(spectators) do
		if specCreature:isPlayer() then
			if specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaClash.Time) == 1 then
				if #spectators > 2 then
					specCreature:addItem(3031, 30)
				else
					specCreature:addItem(3031, 20)
				end
			end
		end	
	end
end

function umbraMonsterDeath3.onDeath(creature)
	if creature:getOutfit().lookLegs == 114 then
		-- Verifica os espectadores em cada uma das três áreas
		checkArea(config.area1, 35, 8)
	end

	return true
end

umbraMonsterDeath3:register()







