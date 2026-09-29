local bosses = {
	["goshnar's malice"] = { storage = Storage.Quest.U12_40.SoulWar.GoshnarMaliceKilled },
	["goshnar's hatred"] = { storage = Storage.Quest.U12_40.SoulWar.GoshnarHatredKilled },
	["goshnar's spite"] = { storage = Storage.Quest.U12_40.SoulWar.GoshnarSpiteKilled },
	["goshnar's cruelty"] = { storage = Storage.Quest.U12_40.SoulWar.GoshnarCrueltyKilled },
	["goshnar's greed"] = { storage = Storage.Quest.U12_40.SoulWar.GoshnarGreedKilled },
	["goshnar's megalomania"] = { storage = Storage.Quest.U12_40.SoulWar.GoshnarMegalomaniaKilled },
}

local BAG_KILL_COUNT_STORAGE = Storage.Quest.U12_40.SoulWar.BagKillCount

-- onDeath no proprio boss, em vez de onKill no jogador: o onKill era chamado
-- em toda morte que qualquer jogador causava, so para conferir o nome e sair.
local bossesSoulWar = CreatureEvent("SoulWarKill")
function bossesSoulWar.onDeath(creature, corpse, killer, mostDamageKiller)
	if creature:getMaster() or not getDeathCreditPlayer(mostDamageKiller) then
		return true
	end
	local target = creature
	local targetMonster = creature

	local bossName = targetMonster:getName():lower()
	local bossConfig = bosses[bossName]
	if not bossConfig then
		return true
	end

	for key, _ in pairs(targetMonster:getDamageMap()) do
		local attackerPlayer = Player(key)
		if attackerPlayer then
			-- Marca o boss individual como derrotado
			if bossConfig.storage then
				attackerPlayer:setStorageValue(bossConfig.storage, 1)
			end

			-- Soma +1 na contagem geral de bosses
			local current = attackerPlayer:getStorageValue(BAG_KILL_COUNT_STORAGE)
			if current < 0 then 
				current = 0
			end -- valor padr�o

			local chanceBag = math.random(1, 1000)
			if target:getName() == "Goshnar's Megalomania" or target:getName() == "Goshnar's Megalomania 3" or target:getName() == "Goshnar's Megalomania 2" then
				if chanceBag < attackerPlayer:getStorageValue(BAG_KILL_COUNT_STORAGE) then
					attackerPlayer:addItem(34109, 1)
					attackerPlayer:setStorageValue(BAG_KILL_COUNT_STORAGE, 0)
					attackerPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu uma Bag You Desire!")
				else
					attackerPlayer:setStorageValue(BAG_KILL_COUNT_STORAGE, current + 1)
				end
			else
				attackerPlayer:setStorageValue(BAG_KILL_COUNT_STORAGE, current + 1)
				local storageRep = attackerPlayer:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
				attackerPlayer:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
				attackerPlayer:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
			end
			local storageBoss = attackerPlayer:getStorageValue(Storage.Quest.Crandoria.BossTasks.Boss)
			if (target:getName() == "Goshnar's Cruelty" and storageBoss == 14) or (target:getName() == "Goshnar's Greed" and storageBoss == 15) or (target:getName() == "Goshnar's Spite" and storageBoss == 16) or (target:getName() == "Goshnar's Malice" and storageBoss == 17) or (target:getName() == "Goshnar's Hatred" and storageBoss == 18) then
				if attackerPlayer:getStorageValue(Storage.Quest.Crandoria.BossTasks.Count) < 1 then
					attackerPlayer:setStorageValue(Storage.Quest.Crandoria.BossTasks.Count, 1)
					attackerPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou o boss para Thorwulf.")
				end
			end
		end
	end
	return true
end

bossesSoulWar:register()

local startup = GlobalEvent("SoulWarKillStartup")
function startup.onStartup()
	local nomes = {}
	for nome in pairs(bosses) do
		nomes[#nomes + 1] = nome
	end
	registerDeathEvent("SoulWarKill", nomes)
	return true
end
startup:register()


-- local bosses = {
-- 	["goshnar's malice"] = { storage = Storage.Quest.U12_40.SoulWar.GoshnarMaliceKilled },
-- 	["goshnar's hatred"] = { storage = Storage.Quest.U12_40.SoulWar.GoshnarHatredKilled },
-- 	["goshnar's spite"] = { storage = Storage.Quest.U12_40.SoulWar.GoshnarSpiteKilled },
-- 	["goshnar's cruelty"] = { storage = Storage.Quest.U12_40.SoulWar.GoshnarCrueltyKilled },
-- 	["goshnar's greed"] = { storage = Storage.Quest.U12_40.SoulWar.GoshnarGreedKilled },
-- 	["goshnar's megalomania"] = { storage = Storage.Quest.U12_40.SoulWar.GoshnarMegalomaniaKilled },
-- }

-- local bossesSoulWar = CreatureEvent("SoulWarKill")
-- function bossesSoulWar.onKill(creature, target)
-- 	local targetMonster = target:getMonster()
-- 	if not targetMonster or targetMonster:getMaster() then
-- 		return true
-- 	end
-- 	local bossConfig = bosses[targetMonster:getName():lower()]
-- 	if not bossConfig then
-- 		return true
-- 	end
-- 	for key, value in pairs(targetMonster:getDamageMap()) do
-- 		local attackerPlayer = Player(key)
-- 		if attackerPlayer then
-- 			if bossConfig.storage then
-- 				attackerPlayer:setStorageValue(bossConfig.storage, 1)
-- 			end
-- 		end
-- 	end
-- 	return true
-- end

-- bossesSoulWar:register()
