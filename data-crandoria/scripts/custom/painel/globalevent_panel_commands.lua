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

--- Inteiro positivo de um campo, dentro de [1, maximo]; nil se nao for.
local function inteiro(payload, chave, maximo)
	local n = tonumber(campo(payload, chave))
	if not n or n ~= math.floor(n) or n < 1 or n > maximo then
		return nil
	end
	return n
end

--- Um personagem online da conta, se houver.
--- Coins e dias VIP sao da conta, nao do personagem: basta qualquer um dela
--- estar online para a conta estar carregada na memoria do servidor.
local function onlineDaConta(accountId)
	for _, p in ipairs(Game.getPlayers()) do
		if p:getAccountId() == accountId then
			return p
		end
	end
	return nil
end

local function contaExiste(accountId)
	local resultId = db.storeQuery(string.format("SELECT `id` FROM `accounts` WHERE `id` = %d;", accountId))
	if not resultId then
		return false
	end
	Result.free(resultId)
	return true
end

local MAX_COINS = 1000000
local MAX_DIAS_VIP = 365

local HANDLERS = {
	-- Tibia Coins. "transferivel" e o mesmo tipo que a doacao entrega.
	coins = function(payload)
		local accountId = inteiro(payload, "conta", 2 ^ 31)
		local qtd = inteiro(payload, "quantidade", MAX_COINS)
		local tipo = campo(payload, "tipo")
		if not accountId then
			return false, "conta invalida"
		end
		if not qtd then
			return false, "quantidade invalida"
		end
		if tipo ~= "transferivel" and tipo ~= "normal" then
			return false, "tipo de coin invalido"
		end

		local player = onlineDaConta(accountId)
		if player then
			local ok
			if tipo == "transferivel" then
				ok = player:addTransferableCoins(qtd)
			else
				ok = player:addTibiaCoins(qtd)
			end
			if not ok then
				return false, "o jogo recusou o credito"
			end
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Voce recebeu %d Tibia Coins.", qtd))
			player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
			return true, string.format("%d coins (%s) na conta %d, online com %s", qtd, tipo, accountId, player:getName())
		end

		-- Offline: o saldo de coins mora no banco (o proprio jogo le e grava
		-- direto la), entao somar na linha e o mesmo que a API faria. A
		-- transacao entra no historico como as do jogo.
		if not contaExiste(accountId) then
			return false, "conta nao existe"
		end
		local coluna = tipo == "transferivel" and "coins_transferable" or "coins"
		db.query(string.format("UPDATE `accounts` SET `%s` = `%s` + %d WHERE `id` = %d;", coluna, coluna, qtd, accountId))
		db.query(string.format(
			"INSERT INTO `coins_transactions` (`account_id`, `type`, `coin_type`, `amount`, `description`) VALUES (%d, 1, %d, %d, %s);",
			accountId, tipo == "transferivel" and 3 or 1, qtd, escapar("Painel")))
		return true, string.format("%d coins (%s) na conta %d, offline", qtd, tipo, accountId)
	end,

	-- Dias VIP = dias de premium da conta: e o que getVipDays() le e o que os
	-- itens vip1/vip7/vip30 dao.
	vip = function(payload)
		local accountId = inteiro(payload, "conta", 2 ^ 31)
		local dias = inteiro(payload, "dias", MAX_DIAS_VIP)
		if not accountId then
			return false, "conta invalida"
		end
		if not dias then
			return false, "quantidade de dias invalida"
		end

		local player = onlineDaConta(accountId)
		if player then
			-- Online e obrigatorio passar pela API: a conta na memoria e salva
			-- por cima do banco no proximo save e apagaria um UPDATE feito aqui.
			if not player:addPremiumDays(dias) then
				return false, "o jogo recusou os dias (conta com VIP infinito?)"
			end
			player:onAddVip(dias, true)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Voce recebeu %d dia(s) de VIP. Agora tem %d.", dias, player:getVipDays()))
			player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
			return true, string.format("+%d dias na conta %d, online com %s (agora %d)", dias, accountId, player:getName(), player:getVipDays())
		end

		-- Offline: a mesma conta do Account::addPremiumDays. O que vale e o
		-- `lastday` (fim do VIP); `premdays` e recalculado dele no login.
		local resultId = db.storeQuery(string.format("SELECT `lastday` FROM `accounts` WHERE `id` = %d;", accountId))
		if not resultId then
			return false, "conta nao existe"
		end
		local agora = os.time()
		local fim = math.max(Result.getNumber(resultId, "lastday"), agora) + dias * 86400
		Result.free(resultId)
		local total = math.floor((fim - agora) / 86400)
		db.query(string.format(
			"UPDATE `accounts` SET `lastday` = %d, `premdays` = %d, `premdays_purchased` = `premdays_purchased` + %d WHERE `id` = %d;",
			fim, total, dias, accountId))
		return true, string.format("+%d dias na conta %d, offline (agora %d)", dias, accountId, total)
	end,

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
		-- MESSAGE_GAME_HIGHLIGHT, e nao a constante de broadcast que existe em
		-- outros servidores: aqui ela nao e exportada para o Lua, entao chegava
		-- como nil, o C++ lia 0 = MESSAGE_NONE e respondia ao jogador com
		-- "There was a problem requesting your message".
		local n = #Game.getPlayers()
		Game.broadcastMessage(texto, MESSAGE_GAME_HIGHLIGHT)
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
