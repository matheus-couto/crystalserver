-- Morte de Veteran Adventurer (registrado em monster.events do veteran_adventurer):
-- cria um Dragonling no lugar e conta para a primeira missao do Drystan Wildweed.
--
-- A versao anterior usava `player` e `count` sem nunca defini-los: dava erro em
-- toda morte (adventurer_kill.lua:12) e nenhum kill era contado.
local KILLS = 200
local DRYSTAN = Storage.Quest.Crandoria.DrystanQuest

local adventurerKill = CreatureEvent("adventurerKill")

function adventurerKill.onDeath(creature, corpse, killer, mostDamageKiller)
	local monster = creature and creature:getMonster()
	if not monster or monster:getMaster() then
		return true
	end

	Game.createMonster("Dragonling", creature:getPosition())

	-- Conta para todos que causaram dano, como o contador das tasks.
	for playerId in pairs(monster:getDamageMap()) do
		local player = Player(playerId)
		if player and player:getStorageValue(DRYSTAN.Progresso) == 1 then
			local count = math.max(0, player:getStorageValue(DRYSTAN.KillCount))
			if count < KILLS then
				count = count + 1
				player:setStorageValue(DRYSTAN.KillCount, count)
				if count >= KILLS then
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[Veteran Adventurer] %d/%d - volte a Drystan Wildweed.", count, KILLS))
				else
					player:sendTextMessage(MESSAGE_STATUS_SMALL, string.format("[Veteran Adventurer] %d/%d", count, KILLS))
				end
			end
		end
	end
	return true
end

adventurerKill:register()
