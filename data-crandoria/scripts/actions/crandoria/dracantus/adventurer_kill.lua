local adventurerKill = CreatureEvent("adventurerKill")

function adventurerKill.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
	if not creature or not creature:getMonster() then
		return
	end
	local damageMap = creature:getMonster():getDamageMap()

	local pos = corpse:getPosition()
	Game.createMonster("Dragonling", pos)

	local storage = player:getStorageValue(Storage.Quest.Crandoria.DrystanQuest.Progresso)

	if storage == 1 then
		if count < 199 then
			local current = storage + 1
			player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.KillCount, current)
			player:sendTextMessage(
			MESSAGE_STATUS_SMALL,
			string.format("[Veteran Adventurer] %d/200", current)
			)
			return true
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[Veteran Adventurer] Finalizada")
			player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.KillCount, 200)
			return true
		end
	end



	return true
end

adventurerKill:register()