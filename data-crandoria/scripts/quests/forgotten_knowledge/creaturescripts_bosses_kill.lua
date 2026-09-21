local bosses = {
	-- bosses
	["lady tenebris"] = { storage = Storage.Quest.U11_02.ForgottenKnowledge.LadyTenebrisKilled },
	["the enraged thorn knight"] = { storage = Storage.Quest.U11_02.ForgottenKnowledge.ThornKnightKilled },
	["lloyd"] = { storage = Storage.Quest.U11_02.ForgottenKnowledge.LloydKilled },
	["soul of dragonking zyrtarch"] = { storage = Storage.Quest.U11_02.ForgottenKnowledge.DragonkingKilled },
	["melting frozen horror"] = { storage = Storage.Quest.U11_02.ForgottenKnowledge.HorrorKilled },
	["the time guardian"] = { storage = Storage.Quest.U11_02.ForgottenKnowledge.TimeGuardianKilled },
	["the blazing time guardian"] = { storage = Storage.Quest.U11_02.ForgottenKnowledge.TimeGuardianKilled },
	["the freezing time guardian"] = { storage = Storage.Quest.U11_02.ForgottenKnowledge.TimeGuardianKilled },
	["the last lore keeper"] = { storage = Storage.Quest.U11_02.ForgottenKnowledge.LastLoreKilled },
	-- IA interactions
	["an astral glyph"] = {},
}

local bossesForgottenKill = CreatureEvent("BossesForgottenKill")
function bossesForgottenKill.onKill(creature, target)
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
				attackerPlayer:setStorageValue(bossConfig.storage, os.time() + 20 * 3600)
			elseif targetMonster:getName():lower() == "the enraged thorn knight" then
				attackerPlayer:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.PlantCounter, 0)
				attackerPlayer:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.BirdCounter, 0)
			elseif targetMonster:getName():lower() == "melting frozen horror" then
				local egg = Tile(Position(4967, 4766, 15)):getTopCreature()
				if egg then
					local pos = egg:getPosition()
					egg:remove()
					Game.createMonster("baby dragon", pos, true, true)
				end
				local horror = Tile(Position(4965, 4753, 15)):getTopCreature()
				if horror then
					horror:remove()
				end
			end
		end
	end
	return true
end

bossesForgottenKill:register()
