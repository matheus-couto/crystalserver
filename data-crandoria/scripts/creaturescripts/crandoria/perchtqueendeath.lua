local perchtQueenDeath = CreatureEvent("perchtQueenDeath")

function perchtQueenDeath.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
	if not creature or not creature:getMonster() then
		return
	end
	local damageMap = creature:getMonster():getDamageMap()


	for key, _ in pairs(damageMap) do
		local player = Player(key)
		if player then
			if player:getStorageValue(Storage.Quest.Crandoria.ThePerchtQueen.Outfit) < 1 then
				player:setStorageValue(Storage.Quest.Crandoria.ThePerchtQueen.Outfit, 1) 
				player:addOutfit(1162, 0)
				player:addOutfit(1161, 0)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu o Percht Raider Outfits.")
			elseif player:getStorageValue(Storage.Quest.Crandoria.ThePerchtQueen.Outfit) == 4 then	
				player:setStorageValue(Storage.Quest.Crandoria.ThePerchtQueen.Outfit, 5)
				player:addOutfit(1162, 0)
				player:addOutfit(1161, 0)
				player:addOutfitAddon(1162, 1)
				player:addOutfitAddon(1161, 1)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu o primeiro Addon do Percht Raider Outfits.")
			elseif player:getStorageValue(Storage.Quest.Crandoria.ThePerchtQueen.Outfit) == 9 then
				player:setStorageValue(Storage.Quest.Crandoria.ThePerchtQueen.Outfit, 10) 
				player:addOutfit(1162, 0)
				player:addOutfit(1161, 0)
				player:addOutfitAddon(1162, 1)
				player:addOutfitAddon(1161, 1)
				player:addOutfitAddon(1162, 2)
				player:addOutfitAddon(1161, 2)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu o segundo Addon do Percht Raider Outfits.")
			else
				player:setStorageValue(Storage.Quest.Crandoria.ThePerchtQueen.Outfit, player:getStorageValue(Storage.Quest.Crandoria.ThePerchtQueen.Outfit) + 1) 
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou a Percht Queen novamente.")
			end
		end
	end

	return true
end

perchtQueenDeath:register()

-- local config = {
-- 	centerPosition = Position(4874, 5358, 7),
-- 	rangeX = 14,
-- 	rangeY = 20,
-- }

-- local perchtQueenDeath = CreatureEvent("perchtQueenDeath")


-- function perchtQueenDeath.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
-- 	local spectators = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)

-- 	if creature:getName() ~= "The Percht Queen" then
-- 		return false
-- 	end
-- 	local storage = specCreature:getStorageValue(Storage.Quest.Crandoria.ThePerchtQueen.Outfit)

-- 	for _, specCreature in pairs(spectators) do
-- 		if specCreature:isPlayer() then
-- 			if storage < 1 then
-- 				specCreature:setStorageValue(Storage.Quest.Crandoria.ThePerchtQueen.Outfit, 1) 
-- 				specCreature:addOutfit(1162, 0)
-- 				specCreature:addOutfit(1161, 0)
-- 			elseif storage >= 1 and storage < 4 then
-- 				specCreature:setStorageValue(Storage.Quest.Crandoria.ThePerchtQueen.Outfit, storage + 1) 
-- 				specCreature:addOutfit(1162, 0)
-- 				specCreature:addOutfit(1161, 0)
-- 			elseif storage == 4 then
-- 				specCreature:setStorageValue(Storage.Quest.Crandoria.ThePerchtQueen.Outfit, 5) 
-- 				specCreature:addOutfit(1162, 0)
-- 				specCreature:addOutfit(1161, 0)
-- 				specCreature:addOutfitAddon(1162, 1)
-- 				specCreature:addOutfitAddon(1161, 1)
-- 			elseif storage >= 4 and storage < 9 then
-- 				specCreature:setStorageValue(Storage.Quest.Crandoria.ThePerchtQueen.Outfit, storage + 1) 
-- 				specCreature:addOutfit(1162, 0)
-- 				specCreature:addOutfit(1161, 0)
-- 				specCreature:addOutfitAddon(1162, 1)
-- 				specCreature:addOutfitAddon(1161, 1)
-- 			elseif storage == 9 then
-- 				specCreature:setStorageValue(Storage.Quest.Crandoria.ThePerchtQueen.Outfit, 10) 
-- 				-- specCreature:addOutfit(1162, 0)
-- 				-- specCreature:addOutfit(1161, 0)
-- 				specCreature:addOutfitAddon(1162, 2)
-- 				specCreature:addOutfitAddon(1161, 2)
-- 			end
-- 		end
-- 		return true
-- 	end


-- end

-- perchtQueenDeath:register()
