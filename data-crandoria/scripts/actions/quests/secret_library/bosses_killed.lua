local bosses = {
	["ghulosh"] = { storage = Storage.Quest.U11_80.TheSecretLibrary.GhuloshKilled },
	["gorzindel"] = { storage = Storage.Quest.U11_80.TheSecretLibrary.GorzindelKilled },
	["lokathmor"] = { storage = Storage.Quest.U11_80.TheSecretLibrary.LokathmorKilled },
	["mazzinor"] = { storage = Storage.Quest.U11_80.TheSecretLibrary.MazzinorKilled },
	["scourge of oblivion"] = { storage = Storage.Quest.U11_80.TheSecretLibrary.ScourgeOfOblivionKilled },
}

local bossesSecretLibrary = CreatureEvent("SecretLibraryKill")
function bossesSecretLibrary.onKill(player, target)
	local targetMonster = target:getMonster()
	if not targetMonster or targetMonster:getMaster() then
		return true
	end
	local bossConfig = bosses[targetMonster:getName():lower()]
	if not bossConfig then
		return true
	end
	for key, value in pairs(targetMonster:getDamageMap()) do
		local attackerPlayer = Player(key)
		if attackerPlayer then
			if bossConfig.storage then
				attackerPlayer:setStorageValue(bossConfig.storage, 1)
			end
		end
	end
	local bossesKilled = 0
	for value in pairs(bosses) do
		if player:getStorageValue(bosses[value].storage) > 0 then
			bossesKilled = bossesKilled + 1
		end
	end
	if bossesKilled >= 4 then -- number of mini bosses
		player:setStorageValue(Storage.Quest.U11_80.TheSecretLibrary.ScourgeOfOblivionDoor, 1)
	end
	if target:getName() == "Scourge of Oblivion" then
		if player:getStorageValue(Storage.Quest.Crandoria.BossTasks.Boss) == 24 and player:getStorageValue(Storage.Quest.Crandoria.BossTasks.Count) < 1 then
			player:setStorageValue(Storage.Quest.Crandoria.BossTasks.Count, 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou o boss para Thorwulf.")
		end
		local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
        player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 8)
        player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
	end
	return true
end

bossesSecretLibrary:register()
