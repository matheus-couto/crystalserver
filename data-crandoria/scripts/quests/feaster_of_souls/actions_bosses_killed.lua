local bosses = {
	["the fear feaster"] = { storage = Storage.Quest.U12_30.FeasterOfSouls.FearFeasterKilled },
	["the dread maiden"] = { storage = Storage.Quest.U12_30.FeasterOfSouls.DreadMaidenKilled },
	["the unwelcome"] = { storage = Storage.Quest.U12_30.FeasterOfSouls.UnwelcomeKilled },
	["the pale worm"] = { storage = Storage.Quest.U12_30.FeasterOfSouls.PaleWormKilled },
}

local bossesFeasterOfSouls = CreatureEvent("FeasterOfSoulsBossDeath")
function bossesFeasterOfSouls.onDeath(creature)
	local bossConfig = bosses[creature:getName():lower()]
	if not bossConfig then
		return true
	end
	onDeathForDamagingPlayers(creature, function(creature, player)
		if bossConfig.storage then
			player:setStorageValue(bossConfig.storage, 1)
			local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
			player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
			player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
		end
	end)
	return true
end

bossesFeasterOfSouls:register()
