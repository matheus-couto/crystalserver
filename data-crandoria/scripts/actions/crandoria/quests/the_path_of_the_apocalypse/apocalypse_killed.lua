local boss = {
	["apocalypse"] = {storage = Storage.Quest.Crandoria.TradeSpecialNPC.ApocalypseKilled},

}

local bossApocalypse = CreatureEvent("CrandoriaApocalypseKill")
function bossApocalypse.onKill(creature, target)
	local targetMonster = target:getMonster()
	if not targetMonster or targetMonster:getMaster() then
		return true
	end
	local bossConfig = boss[targetMonster:getName():lower()]
	if not bossConfig then
		return true
	end
	for key, value in pairs(targetMonster:getDamageMap()) do
		local attackerPlayer = Player(key)
		if attackerPlayer then
			if bossConfig.storage then
				attackerPlayer:setStorageValue(Storage.Quest.Crandoria.TradeSpecialNPC.ApocalypseKilled, 1)
			end
		end
	end
	return true
end
bossApocalypse:register()
