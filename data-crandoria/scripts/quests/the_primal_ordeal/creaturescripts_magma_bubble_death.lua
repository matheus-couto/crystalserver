local magmaBubbleDeath = CreatureEvent("MagmaBubbleDeath")

local function hasOutfit(player)
	return player:hasOutfit(1569) or player:hasOutfit(1568)
end

function magmaBubbleDeath.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
	if not creature then
		return
	end

	local damageMap = creature:getMonster():getDamageMap()
	for key, value in pairs(damageMap) do
		local player = Player(key)
		if player then
			local storageCrassus = player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso)
			if not hasOutfit(player) then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations you received the Fire-Fighter Outfit.")
				player:addOutfit(1569, 0)
				player:addOutfit(1568, 0)
			end
			if player:getStorageValue(Storage.Quest.U12_90.PrimalOrdeal.Bosses.MagmaBubbleKilled) < 1 then
				player:setStorageValue(Storage.Quest.U12_90.PrimalOrdeal.Bosses.MagmaBubbleKilled, 1) -- Access to The primal menace boss fight
			end
			if storageCrassus >= 203 and storageCrassus < 207 then
				local factor = 207 - storageCrassus
				player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, storageCrassus + 1)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ainda precisa derrotar Magma Bubble " ..factor .." vezes para Kalahar.")
			elseif storageCrassus == 207 then
				player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 208)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Magma Bubble 5 vezes e finalizou a missao de Kalahar.")
			end
		end
	end
end

magmaBubbleDeath:register()
