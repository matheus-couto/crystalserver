local boss = {
	["apocalypse"] = { storage = Storage.Quest.Crandoria.TradeSpecialNPC.ApocalypseKilled },
}

-- onDeath no proprio boss, em vez de onKill no jogador: o onKill era chamado
-- em toda morte que qualquer jogador causava, so para conferir o nome e sair.
local bossApocalypse = CreatureEvent("CrandoriaApocalypseKill")
function bossApocalypse.onDeath(creature, corpse, killer, mostDamageKiller)
	if creature:getMaster() or not getDeathCreditPlayer(mostDamageKiller) then
		return true
	end
	local bossConfig = boss[creature:getName():lower()]
	if not bossConfig then
		return true
	end
	for key, value in pairs(creature:getDamageMap()) do
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

local startup = GlobalEvent("CrandoriaApocalypseKillStartup")
function startup.onStartup()
	registerDeathEvent("CrandoriaApocalypseKill", { "Apocalypse" })
	return true
end
startup:register()
