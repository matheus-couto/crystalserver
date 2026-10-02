local config = {
	area1 = { 
		fromPosition = Position(4306, 4396, 7), 
		toPosition = Position(4316, 4407, 7),
		centerPosition = Position(4311, 4401, 7) 
	},

	area2 = { 
		fromPosition = Position(4306, 4396, 6), 
		toPosition = Position(4316, 4406, 6),
		centerPosition = Position(4311, 4401, 6) 
	},

	area3 = { 
		fromPosition = Position(4396, 4396, 6), 
		toPosition = Position(4406, 4406, 6),
		centerPosition = Position(4401, 4401, 6) 
	},
}

local chaosTotemDeath = CreatureEvent("chaosTotemDeath")

-- Função para obter e processar os espectadores de uma área
local function checkArea(area, rangeX, rangeY)
	local spectators = Game.getSpectators(area.centerPosition, false, false, 50, 50, 8, 8)
	for _, specCreature in pairs(spectators) do
		local storagePlacar = specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.Placar)
		if specCreature:isPlayer() then
			if specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimeAnvillux) > 0 then
				specCreature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.TimeAnvillux, 0)
				specCreature:teleportTo(Position(4870, 5113, 7))
				specCreature:setFaction(FACTION_PLAYER)
				if specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerBattle) < os.time() then
					specCreature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerBattle, os.time() + 24 * 60 * 60)
					if specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.PlayerNumber) == 1 then
						if specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) >= os.time() + 15 * 60 then
							specCreature:addItem(22720, 2)
							specCreature:addItem(14112, 1)
							specCreature:addExperience(specCreature:getLevel() * 500)
						elseif specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) < os.time() + 15 * 60 and specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) > os.time() then
							specCreature:addItem(22720, 1)
							specCreature:addItem(14112, 1)
							specCreature:addExperience(specCreature:getLevel() * 250)
						end
					elseif specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.PlayerNumber) == 2 then
						if specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) >= os.time() + 17 * 60 then
							specCreature:addItem(22720, 3)
							specCreature:addItem(14112, 1)
							specCreature:addExperience(specCreature:getLevel() * 750)
						elseif specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) < os.time() + 17 * 60 and specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) >= os.time() + 10 * 60 then
							specCreature:addItem(22720, 2)
							specCreature:addItem(14112, 1)
							specCreature:addExperience(specCreature:getLevel() * 500)
						elseif specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) < os.time() + 10 * 60 and specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) > os.time() then
							specCreature:addItem(22720, 1)
							specCreature:addItem(14112, 1)
							specCreature:addExperience(specCreature:getLevel() * 250)
						end
					elseif specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.PlayerNumber) == 3 then
						if specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) >= os.time() + 18 * 60 then
							specCreature:addItem(22720, 4)
							specCreature:addItem(14112, 1)
							specCreature:addExperience(specCreature:getLevel() * 1000)
						elseif specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) < os.time() + 18 * 60 and specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) >= os.time() + 12 * 60 then
							specCreature:addItem(22720, 3)
							specCreature:addItem(14112, 1)
							specCreature:addExperience(specCreature:getLevel() * 750)
						elseif specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) < os.time() + 12 * 60 and specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) >= os.time() + 5 * 60 then
							specCreature:addItem(22720, 2)
							specCreature:addItem(14112, 1)
							specCreature:addExperience(specCreature:getLevel() * 500)
						elseif specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) < os.time() + 5 * 60 and specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) > os.time() then
							specCreature:addItem(22720, 1)
							specCreature:addItem(14112, 1)
							specCreature:addExperience(specCreature:getLevel() * 250)
						end
					elseif specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.PlayerNumber) == 4 then
						if specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) >= os.time() + 20 * 60 then
							specCreature:addItem(22720, 5)
							specCreature:addItem(14112, 1)
							specCreature:addExperience(specCreature:getLevel() * 1000)
						elseif specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) < os.time() + 20 * 60 and specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) >= os.time() + 17 * 60 then
							specCreature:addItem(22720, 4)
							specCreature:addItem(14112, 1)
							specCreature:addExperience(specCreature:getLevel() * 750)
						elseif specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) < os.time() + 17 * 60 and specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) >= os.time() + 10 * 60 then
							specCreature:addItem(22720, 3)
							specCreature:addItem(14112, 1)
							specCreature:addExperience(specCreature:getLevel() * 500)
						elseif specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) < os.time() + 10 * 60 and specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) > os.time() then
							specCreature:addItem(22720, 2)
							specCreature:addItem(14112, 1)
							specCreature:addExperience(specCreature:getLevel() * 250)
						end
					else
						specCreature:addItem(14112, 1)
						specCreature:addExperience(specCreature:getLevel() * 250)
					end
				else
					specCreature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral, 0)
					specCreature:addItem(14112, 1)
					specCreature:addExperience(specCreature:getLevel() * 250)
				end
				if storagePlacar < 1 then
					specCreature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.Placar, 1)
				else
					specCreature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.Placar, storagePlacar + 1)
				end
				local stone3 = Tile(Position(4369, 4428, 7)):getItemById(1791)
				if not stone3 then
					Game.createItem(1791, 1, Position(4369, 4428, 7))
				end
				specCreature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral, 0)
				specCreature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.PlayerNumber, 0)
				specCreature:setFaction(FACTION_PLAYER)
			elseif specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimeChaos) > 0 then
				specCreature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.TimeChaos, 0)
				specCreature:teleportTo(Position(4870, 5113, 7))
				specCreature:setFaction(FACTION_PLAYER)
				specCreature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral, 0)
				specCreature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.PlayerNumber, 0)
			end
			return true
		end	
	end
end

function chaosTotemDeath.onDeath(creature)
	if creature:getOutfit().lookTypeEx == 17520 then
		-- Verifica os espectadores em cada uma das três áreas
		checkArea(config.area1, 50, 8)
		checkArea(config.area2, 8, 8)
		checkArea(config.area3, 8, 8)
		Game.setStorageValue(GlobalStorage.Crandoria.Aram.Partida, 0)
	end

	return true
end

chaosTotemDeath:register()






-- local config = {
-- 	area1 = { 
-- 		fromPosition = Position(4306, 4396, 7), 
-- 		toPosition = Position(4316, 4407, 7),
-- 		centerPosition = Position(4311, 4401, 7) 
-- 	},

-- 	area2 = { 
-- 		fromPosition = Position(4306, 4396, 6), 
-- 		toPosition = Position(4316, 4406, 6),
-- 		centerPosition = Position(4311, 4401, 6) 
-- 	},

-- 	area3 = { 
-- 		fromPosition = Position(4396, 4396, 6), 
-- 		toPosition = Position(4406, 4406, 6),
-- 		centerPosition = Position(4401, 4401, 6) 
-- 	},
-- }

-- local chaosTotemDeath = CreatureEvent("chaosTotemDeath")

-- -- Função para obter e processar os espectadores de uma área
-- local function checkArea(area, rangeX, rangeY)
-- 	local spectators = Game.getSpectators(area.centerPosition, false, false, 50, 50, 8, 8)
-- 	for _, specCreature in pairs(spectators) do
-- 		if specCreature:isPlayer() then
-- 			if specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimeChaos) > 0 then
-- 				specCreature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.TimeChaos, 0)
-- 				specCreature:teleportTo(Position(4870, 5113, 7))
-- 				specCreature:setFaction(FACTION_PLAYER)
-- 			elseif specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimeAnvillux) > 0 then
-- 				specCreature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.TimeAnvillux, 0)
-- 				specCreature:teleportTo(Position(4870, 5113, 7))
-- 				specCreature:setFaction(FACTION_PLAYER)
-- 				if specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerBattle) < os.time() then
-- 					specCreature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerBattle, os.time() + 24 * 60 * 60)
-- 					if specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) > os.time() + 20 * 60 then
-- 						specCreature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral, 0)
-- 						specCreature:addItem(22720, 5)
-- 						specCreature:addItem(14112, 1)
-- 						specCreature:addExperience(specCreature:getLevel() * 3000)
-- 					elseif specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) > os.time() + 15 * 60 then
-- 						specCreature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral, 0)
-- 						specCreature:addItem(22720, 4)
-- 						specCreature:addItem(14112, 1)
-- 						specCreature:addExperience(specCreature:getLevel() * 2000)
-- 					elseif specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) > os.time() + 10 * 60 then
-- 						specCreature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral, 0)
-- 						specCreature:addItem(22720, 3)
-- 						specCreature:addItem(14112, 1)
-- 						specCreature:addExperience(specCreature:getLevel() * 1500)
-- 					elseif specCreature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) > os.time() + 5 * 60 then
-- 						specCreature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral, 0)
-- 						specCreature:addItem(22720, 2)
-- 						specCreature:addItem(14112, 1)
-- 						specCreature:addExperience(specCreature:getLevel() * 1000)
-- 					else
-- 						specCreature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral, 0)
-- 						specCreature:addItem(22720, 1)
-- 						specCreature:addItem(14112, 1)
-- 						specCreature:addExperience(specCreature:getLevel() * 500)
-- 					end
-- 				else
-- 					specCreature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral, 0)
-- 					specCreature:addItem(14112, 1)
-- 					specCreature:addExperience(specCreature:getLevel() * 500)
-- 				end
-- 				local stone3 = Tile(Position(4369, 4428, 7)):getItemById(1791)
-- 				if not stone3 then
-- 					Game.createItem(1791, 1, Position(4369, 4428, 7))
-- 				end
-- 			end
-- 		end	
-- 	end
-- end

-- function chaosTotemDeath.onDeath(creature)
-- 	if creature:getOutfit().lookTypeEx == 17520 then
-- 		-- Verifica os espectadores em cada uma das três áreas
-- 		checkArea(config.area1, 50, 8)
-- 		checkArea(config.area2, 8, 8)
-- 		checkArea(config.area3, 8, 8)
-- 		Game.setStorageValue(GlobalStorage.Crandoria.Aram.Partida, 0)
-- 	end

-- 	return true
-- end

-- chaosTotemDeath:register()


