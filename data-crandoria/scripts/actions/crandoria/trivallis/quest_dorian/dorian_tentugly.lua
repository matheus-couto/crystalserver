--[[
	Quest do Dorian (PiratesQuest), etapa 4 -> 5: derrotar o Tentugly's Head.

	O Dorian manda derrotar o monstro na etapa 4 e comemora na 5, mas a morte
	do Tentugly's Head so gravava a quest do upstream (A Pirate's Tail,
	TentuglyKilled). A do Dorian ficava parada na 4 para sempre.

	Evento separado, e nao uma linha a mais no script do upstream, para que
	uma atualizacao de la nao leve esta correcao junto.
]]
local ETAPA_PEDIDO = 4
local ETAPA_VENCIDA = 5

local dorianTentugly = CreatureEvent("DorianTentuglyDeath")
function dorianTentugly.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(_, player)
		local progresso = Storage.Quest.Crandoria.PiratesQuest.Progresso
		if player:getStorageValue(progresso) == ETAPA_PEDIDO then
			player:setStorageValue(progresso, ETAPA_VENCIDA)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Tentugly's Head. Conte a Dorian.")
		end
	end)
	return true
end
dorianTentugly:register()

local startup = GlobalEvent("DorianTentuglyStartup")
function startup.onStartup()
	registerDeathEvent("DorianTentuglyDeath", { "Tentugly's Head" })
	return true
end
startup:register()
