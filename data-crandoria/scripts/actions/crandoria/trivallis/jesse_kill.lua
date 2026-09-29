local jesseKill = CreatureEvent("jesseKill")

function jesseKill.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
	if not creature or not creature:getMonster() then
		return
	end
	local damageMap = creature:getMonster():getDamageMap()

	for key, _ in pairs(damageMap) do
		local player = Player(key)
		if player then
			local storage = player:getStorageValue(Storage.Quest.Crandoria.QuestHerbert.Progresso)
			if storage == 1 then
				player:setStorageValue(Storage.Quest.Crandoria.QuestHerbert.Progresso, 2)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Jesse the Wicked.")
				return true
			end
		end
	end

	return true
end

jesseKill:register()