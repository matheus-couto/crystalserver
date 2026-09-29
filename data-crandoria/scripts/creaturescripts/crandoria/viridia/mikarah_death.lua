-- onDeath no proprio boss, em vez de onKill no jogador: o onKill era chamado
-- em toda morte que qualquer jogador causava, so para conferir o nome e sair.
local mikarahDeath = CreatureEvent("mikarahDeath")

function mikarahDeath.onDeath(creature, corpse, killer, mostDamageKiller)
	if not getDeathCreditPlayer(mostDamageKiller) then
		return true
	end

	for pid, _ in pairs(creature:getDamageMap()) do
		local attackerPlayer = Player(pid)
		if attackerPlayer then
			if attackerPlayer:getStorageValue(Storage.Quest.Crandoria.Viridia.Conquistas.Mikarah) < 1 then
				attackerPlayer:setStorageValue(Storage.Quest.Crandoria.Viridia.Conquistas.Mikarah, 1)
			end
		end
	end
	return true
end

mikarahDeath:register()

local startup = GlobalEvent("mikarahDeathStartup")
function startup.onStartup()
	registerDeathEvent("mikarahDeath", { "Mikarah" })
	return true
end
startup:register()
