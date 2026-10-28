local config = {
	creatureNames = { "Zharvorin's Soulcage", "Scarith's Soulcage", "Elyrax's Soulcage", "Myzareth's Soulcage" },
	arenaFrom = Position(4555, 5004, 9),
	arenaTo = Position(4567, 5016, 9),
}

local function countCreaturesInArea(fromPosition, toPosition, creatureNames, excludeCreature)
	local count = 0
	for x = fromPosition.x, toPosition.x do
		for y = fromPosition.y, toPosition.y do
			local pos = Position(x, y, fromPosition.z)
			local tile = Tile(pos)
			if tile then
				local creature = tile:getTopCreature()
				if creature and creature ~= excludeCreature and table.contains(creatureNames, creature:getName()) then
					count = count + 1
				end
			end
		end
	end
	return count
end

local soulcageDeath = CreatureEvent("soulcageDeath")

local SOULCAGES = {
    ["Zharvorin's Soulcage"] = true,
    ["Scarith's Soulcage"] = true,
    ["Elyrax's Soulcage"] = true,
    ["Myzareth's Soulcage"] = true,
    ["Bonelord's Phylactery"] = true
}

	-- local storageForsaken = player:getStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Forsaken)
	-- local storageUnhallowed = player:getStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Unhallowed)

function soulcageDeath.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
    if not creature:isMonster() or not SOULCAGES[creature:getName()] then
        return true
    end

    if creature:getName() == "Bonelord's Phylactery" then
        for key, value in pairs(damageMap) do
            local player = Player(key)
		    if player then
                local storageForsaken = player:getStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Forsaken)
	            local storageUnhallowed = player:getStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Unhallowed)
                local storage = player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Progresso)
                if storage == 10 then
                    player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Progresso, 11)
                    player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Forsaken, storageForsaken + 10)
                    player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Unhallowed, storageUnhallowed + 10)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou o Bone Overlord pela primeira vez e recebeu 10 entradas na Forsaken Crypt e na Unhallowed Crypt. Fale com o NPC para receber a recompensa pela quest.")
                end
                if player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 221 then
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 222)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Missao do Kalahar completa.")
                end
                local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 5)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
            end
        end
        local head1 = Tile(Position(4561, 5010, 9)):getItemById(52650)
        local head2 = Tile(Position(4563, 5010, 9)):getItemById(52651)
        local head3 = Tile(Position(4561, 5012, 9)):getItemById(52652)
        local head4 = Tile(Position(4563, 5012, 9)):getItemById(52653)
        if head1 and head2 and head3 and head4 then
            head1:transform(52639)
            head2:transform(52640)
            head3:transform(52641)
            head4:transform(52642)
            addEvent(function()
                head1:transform(52650)
                head2:transform(52651)
                head3:transform(52652)
                head4:transform(52653)
            end, 30000)
        end
    else
        local remaining = countCreaturesInArea(config.arenaFrom, config.arenaTo, config.creatureNames, creature)
        if remaining > 0 then
            return true
        else
            Game.createMonster("Bonelord's Phylactery", Position(4561, 5014, 9))
            Game.createMonster("Enthralled Dragon", Position(4557, 5017, 9))
            Game.createMonster("Enthralled Dragon", Position(4559, 5017, 9))
            Game.createMonster("Enthralled Dragon", Position(4563, 5017, 9))
            Game.createMonster("Enthralled Dragon", Position(4566, 5017, 9))
        end
    end

    return true
end

soulcageDeath:register()
