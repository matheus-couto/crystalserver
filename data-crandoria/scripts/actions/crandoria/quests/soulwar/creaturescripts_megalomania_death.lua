local config = {
	centerPosition = Position(33710, 31634, 14),
	rangeX = 11,
	rangeY = 11,
}

local event = CreatureEvent("megalomaniaDeath")

function event.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)

    if not creature or not creature:isMonster() then
        return true
    end

	local damageMap = creature:getMonster():getDamageMap()
	for key, _ in pairs(damageMap) do
		local player = Player(key)
		if player then
			player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
			if player:getStorageValue(Storage.Quest.Crandoria.SoulWar.Outfit) < 1 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Parabens, voce recebeu o Revenant Outfit.")
				player:addOutfit(1322, 0)
				player:addOutfit(1323, 0)
				player:setStorageValue(Storage.Quest.Crandoria.SoulWar.Outfit, 1)
			end
			if player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 157 then
				player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 158)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Goshnar's Megalomania. Reporte sua missao para o Comandante Crassus.")
			end
			if player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.Outfit) == 5 then
				if player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.KillMegalomania) < 1 then
					player:setStorageValue(Storage.Quest.Crandoria.TheRedPath.KillMegalomania, 1)
				end
			end
			local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
			player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
			player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
		end
	end



	-- local spectators = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
	-- for _, specCreature in pairs(spectators) do
	-- 	if specCreature:isPlayer() then
	-- 		if specCreature:getStorageValue(Storage.Quest.Crandoria.SoulWar.Outfit) < 1 then
	-- 			specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Parabens, voce recebeu o Revenant Outfit.")
	-- 			specCreature:addOutfit(1322, 0)
	-- 			specCreature:addOutfit(1323, 0)
	-- 			specCreature:setStorageValue(Storage.Quest.Crandoria.SoulWar.Outfit, 1)
	-- 		end
	-- 		if specCreature:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 157 then
	-- 			specCreature:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 158)
	-- 			specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Goshnar's Megalomania. Reporte sua missao para o Comandante Crassus.")
	-- 		end
	-- 		if specCreature:getStorageValue(Storage.Quest.Crandoria.TheRedPath.Outfit) == 5 then
	-- 			if specCreature:getStorageValue(Storage.Quest.Crandoria.TheRedPath.KillMegalomania) < 1 then
	-- 				specCreature:setStorageValue(Storage.Quest.Crandoria.TheRedPath.KillMegalomania, 1)
	-- 			end
	-- 		end
	-- 		local storageRep = specCreature:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
	-- 		specCreature:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
	-- 		specCreature:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
	-- 	end
	-- end

	return true
end

event:register()