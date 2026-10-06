-- Morte de dragao da ilha (Crimson, Verdant, Blizzard, Haunted e o Dragon, que tem
-- este evento em monster.events). Conta para duas missoes, de forma independente:
--   Drako (The First Dragon, etapa 1): 200 dragoes
--   Drystan Wildweed (task de dragoes, etapa 5): 1000 dragoes dentro do prazo
--
-- Antes: contava ate 499 com "/500" enquanto o NPC e o quest log pediam 200, e
-- em 499 parava sem avisar; quem nao estava na missao recebia "Finalizada" a
-- cada dragao; e a parte do Drystan nunca rodava (a funcao retornava antes).
local DRAKO_KILLS = 200
local DRYSTAN_KILLS = 1000
local DRYSTAN_PRAZO = 6 * 60 * 60 -- o mesmo limite que o Drystan confere (21600 s)

local FIRST_DRAGON = Storage.Quest.U11_02.TheFirstDragon
local DRYSTAN = Storage.Quest.Crandoria.DrystanQuest

local function contar(player, chave, total, rotulo, fim)
	local count = math.max(0, player:getStorageValue(chave))
	if count >= total then
		return
	end
	count = count + 1
	player:setStorageValue(chave, count)
	if count >= total then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[%s] %d/%d - %s", rotulo, count, total, fim))
	else
		player:sendTextMessage(MESSAGE_STATUS_SMALL, string.format("[%s] %d/%d", rotulo, count, total))
	end
end

local killDragon = CreatureEvent("TheFirstDragonDragonTaskDeath")

function killDragon.onDeath(creature, _corpse, _lastHitKiller, mostDamageKiller)
	-- Dano maior de uma invocacao conta para o dono.
	if mostDamageKiller and mostDamageKiller:isMonster() and mostDamageKiller:getMaster() then
		mostDamageKiller = mostDamageKiller:getMaster()
	end

	onDeathForParty(creature, mostDamageKiller, function(_, player)
		if player:getStorageValue(FIRST_DRAGON.Progresso) == 1 then
			contar(player, FIRST_DRAGON.DragonCounter, DRAKO_KILLS, "Dragons de Dracantus", "volte ao Drako.")
		end

		if player:getStorageValue(DRYSTAN.Progresso) == 5
			and os.time() - player:getStorageValue(DRYSTAN.Timer) <= DRYSTAN_PRAZO then
			contar(player, DRYSTAN.KillCount, DRYSTAN_KILLS, "Dragons para Drystan", "volte a Drystan Wildweed.")
		end
	end)
	return true
end

killDragon:register()
