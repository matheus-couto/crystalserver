--[[
	Passe dos Novatos, etapa 20 -> 21: derrotar o Jaul.

	O Lord Vikram manda derrotar o Jaul na etapa 20 e paga a recompensa final
	na 21, mas nada gravava a 21. Quem comprava o passe na Store nunca
	fechava a ultima missao.

	Credita por dano causado, e nao por presenca na sala: e o que o proprio
	NPC avisa - "voce deve ataca-lo com todas as suas forcas e te-lo como
	alvo. Nao basta estar presente quando ele morrer."
]]
local ETAPA_PEDIDO = 20
local ETAPA_VENCIDA = 21

local jaulPasse = CreatureEvent("PasseNovatosJaulDeath")
function jaulPasse.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(_, player)
		local progresso = Storage.Quest.Crandoria.PasseNovatos.Progresso
		if player:getStorageValue(progresso) == ETAPA_PEDIDO then
			player:setStorageValue(progresso, ETAPA_VENCIDA)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Jaul. Fale com Lord Vikram para receber a recompensa final do Passe dos Novatos.")
		end
	end)
	return true
end
jaulPasse:register()

local startup = GlobalEvent("PasseNovatosJaulStartup")
function startup.onStartup()
	registerDeathEvent("PasseNovatosJaulDeath", { "Jaul" })
	return true
end
startup:register()
