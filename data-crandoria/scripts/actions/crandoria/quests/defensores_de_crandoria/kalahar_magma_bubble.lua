--[[
	Defensores de Crandoria, etapa 182 -> 183 (missao do Kalahar).

	O Kalahar pede para derrotar a Magma Bubble (etapa 182) e, na 183,
	comemora a vitoria. Mas nada gravava a 183: o jogador matava o boss,
	voltava e o Kalahar repetia o pedido para sempre. Faz para a Magma
	Bubble o mesmo que scourge_oblivion_death.lua faz para o Scourge of
	Oblivion na etapa 178 -> 179.

	Credita quem causou dano, pelo mesmo helper que o proprio upstream usa
	para os bosses da Primal Ordeal.
]]
local ETAPA_PEDIDO = 182
local ETAPA_VENCIDA = 183

local kalaharMagmaBubble = CreatureEvent("KalaharMagmaBubbleDeath")
function kalaharMagmaBubble.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(_, player)
		local progresso = Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso
		if player:getStorageValue(progresso) == ETAPA_PEDIDO then
			player:setStorageValue(progresso, ETAPA_VENCIDA)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou a Magma Bubble para Kalahar. Retorne a Kalahar e reporte sua missao.")
		end
	end)
	return true
end
kalaharMagmaBubble:register()

local startup = GlobalEvent("KalaharMagmaBubbleStartup")
function startup.onStartup()
	registerDeathEvent("KalaharMagmaBubbleDeath", { "Magma Bubble" })
	return true
end
startup:register()
