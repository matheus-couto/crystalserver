--[[
	Executa os comandos que o painel enfileira.

	O painel nao fala com o servidor por protocolo nenhum - nao ha porta de
	administracao aberta, e nem precisa. Ele grava uma linha em
	`panel_commands` e este evento consome, do mesmo jeito que o sistema de
	doacoes ja faz. Se o painel cair, o jogo nem percebe.

	Tipos aceitos estao em HANDLERS; qualquer outro e recusado sem executar
	nada, porque o que chega do banco e entrada externa.
]]

local INTERVALO_MS = 5000
local POR_CICLO = 20  -- teto por rodada, para uma fila grande nao travar o tick

local function escapar(texto)
	return db.escapeString(tostring(texto or ""))
end

local function concluir(id, status, resultado)
	db.query(string.format(
		"UPDATE `panel_commands` SET `status` = %s, `result` = %s, `executed_at` = %d WHERE `id` = %d;",
		escapar(status), escapar(string.sub(tostring(resultado or ""), 1, 250)),
		os.time() * 1000, id))
end

--- Le um campo de um JSON simples, sem depender de parser.
--- O painel e quem monta esse payload, e sempre com chaves de texto curtas.
local function campo(payload, chave)
	return string.match(payload or "", '"' .. chave .. '"%s*:%s*"(.-)"')
end

local HANDLERS = {
	kick = function(payload)
		local nome = campo(payload, "player")
		if not nome or nome == "" then
			return false, "sem nome de personagem"
		end
		local player = Player(nome)
		if not player then
			return false, "nao esta online"
		end
		player:save()
		player:remove()
		return true, "desconectado"
	end,

	save = function(payload)
		local nome = campo(payload, "player")
		if not nome or nome == "" then
			return false, "sem nome de personagem"
		end
		local player = Player(nome)
		if not player then
			return false, "nao esta online"
		end
		player:save()
		return true, "salvo"
	end,

	broadcast = function(payload)
		local texto = campo(payload, "texto")
		if not texto or texto == "" then
			return false, "mensagem vazia"
		end
		local n = 0
		for _, player in ipairs(Game.getPlayers()) do
			player:sendTextMessage(MESSAGE_GAMEMASTER_BROADCAST, texto)
			n = n + 1
		end
		return true, string.format("enviado para %d jogador(es)", n)
	end,
}

local painelCommands = GlobalEvent("PainelCommands")

function painelCommands.onThink(interval)
	local resultId = db.storeQuery(string.format(
		"SELECT `id`, `kind`, `payload` FROM `panel_commands` WHERE `status` = 'PENDING' ORDER BY `id` ASC LIMIT %d;",
		POR_CICLO))
	if not resultId then
		return true
	end

	-- Junta tudo antes de executar: o handler do kick remove jogador, e mexer
	-- no mundo com um result set aberto pede problema.
	local pendentes = {}
	repeat
		pendentes[#pendentes + 1] = {
			id = Result.getNumber(resultId, "id"),
			kind = Result.getString(resultId, "kind"),
			payload = Result.getString(resultId, "payload"),
		}
	until not Result.next(resultId)
	Result.free(resultId)

	for _, cmd in ipairs(pendentes) do
		local handler = HANDLERS[cmd.kind]
		if not handler then
			concluir(cmd.id, "FAILED", "tipo desconhecido: " .. tostring(cmd.kind))
		else
			local ok, resultado, detalhe = pcall(handler, cmd.payload)
			if not ok then
				-- pcall pegou um erro: registra e segue, em vez de deixar o
				-- globalevent morrer e a fila parar de vez.
				concluir(cmd.id, "FAILED", "erro no script: " .. tostring(resultado))
				logger.warn("[Painel] comando {} falhou: {}", cmd.id, resultado)
			elseif resultado then
				concluir(cmd.id, "DONE", detalhe)
			else
				concluir(cmd.id, "FAILED", detalhe)
			end
		end
	end

	return true
end

painelCommands:interval(INTERVALO_MS)
painelCommands:register()
