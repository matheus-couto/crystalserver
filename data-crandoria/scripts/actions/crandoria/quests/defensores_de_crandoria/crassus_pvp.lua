--[[
	Defensores de Crandoria, etapas 164-167: o teste PvP do Comandante Crassus.

	164  Paz na Guerra          derrotar 1 jogador com skull            -> 165
	165  (Crassus paga e passa a segunda missao)                        -> 166
	166  Justica em Crandoria   derrotar 3 jogadores diferentes c/ skull -> 167
	167  Maos Limpas            24h sem morte injustificada e sem skull;
	                            conferido pelo Crassus na conversa       -> 168

	Vale a morte para quem deu o ultimo golpe e para quem causou mais dano
	(ou o dono da invocacao). A vitima precisa ter no maximo 100 niveis a
	menos que o jogador, a morte nao pode ser injustificada e as duas contas
	nao podem estar no mesmo IP - senao bastava pular de skull com um char
	proprio para fechar a missao.

	Registrado no jogador (login_events.lua): o onDeath roda quando o
	jogador que o tem morre, que e exatamente a vitima aqui.
]]
local DIFERENCA_NIVEL = 100
local ALVOS_JUSTICA = 3

local ETAPA_PAZ = 164
local ETAPA_JUSTICA = 166
local ETAPA_MAOS_LIMPAS = 167

local function temSkull(player)
	local skull = player:getSkull()
	return skull == SKULL_WHITE or skull == SKULL_RED or skull == SKULL_BLACK
end

local function jogadorDe(creature)
	if not creature then
		return nil
	end
	local player = creature:getPlayer()
	if player then
		return player
	end
	local master = creature:getMaster()
	return master and master:getPlayer() or nil
end

local function vitimaValida(player, vitima)
	if vitima:getLevel() < player:getLevel() - DIFERENCA_NIVEL then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Comandante Crassus: esse jogador tem mais de 100 niveis a menos que voce. Nao conta para o teste.")
		return false
	end
	local ip = player:getIp()
	if ip ~= 0 and ip == vitima:getIp() then
		return false
	end
	return true
end

local function creditar(player, vitima, injustificada)
	local progresso = Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso
	local etapa = player:getStorageValue(progresso)

	if etapa == ETAPA_MAOS_LIMPAS then
		if injustificada then
			player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.PvpMaosLimpas, os.time())
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Comandante Crassus: uma morte injustificada! O prazo de 24 horas da missao Maos Limpas recomecou.")
		end
		return
	end

	if injustificada or not temSkull(vitima) then
		return
	end

	if etapa == ETAPA_PAZ then
		if vitimaValida(player, vitima) then
			player:setStorageValue(progresso, ETAPA_PAZ + 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Paz na Guerra: voce derrotou " .. vitima:getName() .. ". Volte ao Comandante Crassus.")
		end
	elseif etapa == ETAPA_JUSTICA then
		if not vitimaValida(player, vitima) then
			return
		end
		local guid = vitima:getGuid()
		local alvo1 = Storage.Quest.Crandoria.DefensoresDeCrandoria.PvpAlvo1
		local alvo2 = Storage.Quest.Crandoria.DefensoresDeCrandoria.PvpAlvo2
		if player:getStorageValue(alvo1) == guid or player:getStorageValue(alvo2) == guid then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Justica em Crandoria: voce ja derrotou " .. vitima:getName() .. ". Precisa ser outro jogador.")
			return
		end
		local contagem = Storage.Quest.Crandoria.DefensoresDeCrandoria.PvpAlvos
		local feitos = math.max(0, player:getStorageValue(contagem)) + 1
		if feitos >= ALVOS_JUSTICA then
			player:setStorageValue(progresso, ETAPA_JUSTICA + 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Justica em Crandoria: voce derrotou 3 malfeitores. Volte ao Comandante Crassus.")
			return
		end
		player:setStorageValue(contagem, feitos)
		player:setStorageValue(feitos == 1 and alvo1 or alvo2, guid)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Justica em Crandoria: %s derrotado. Progresso: %d/%d.", vitima:getName(), feitos, ALVOS_JUSTICA))
	end
end

local crassusPvp = CreatureEvent("CrassusPvpDeath")
function crassusPvp.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	local vitima = creature:getPlayer()
	if not vitima then
		return true
	end

	local ultimo = jogadorDe(killer)
	local maisDano = jogadorDe(mostDamageKiller)
	if ultimo and ultimo:getId() ~= vitima:getId() then
		creditar(ultimo, vitima, lastHitUnjustified)
	end
	if maisDano and maisDano:getId() ~= vitima:getId() and not (ultimo and maisDano:getId() == ultimo:getId()) then
		creditar(maisDano, vitima, mostDamageUnjustified)
	end
	return true
end
crassusPvp:register()
