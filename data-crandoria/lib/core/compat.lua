--[[
	Nomes antigos da API usados pelos scripts do Crandoria.

	Os scripts foram escritos para uma versao anterior do servidor, em que o
	boost de XP da store se chamava ExpBoostStamina (tempo) e StoreXpBoost
	(porcentagem). Aqui os mesmos dois valores se chamam XpBoostTime e
	XpBoostPercent - mesma unidade, mesmo par, so o nome mudou.

	Sem estes apelidos, toda chamada caia em "attempt to call method (a nil
	value)": pocao de XP, baus diarios, NPCs que vendem boost, a ordenha e o
	teleporte de saida dos trainers. Sao 53 chamadas em 9 arquivos, entao o
	apelido fica aqui em vez de reescrever cada uma.
]]

-- Tempo restante do boost, em segundos.
Player.getExpBoostStamina = Player.getXpBoostTime
Player.setExpBoostStamina = Player.setXpBoostTime

-- Porcentagem do boost (50 = +50% de XP).
Player.getStoreXpBoost = Player.getXpBoostPercent
Player.setStoreXpBoost = Player.setXpBoostPercent

-- Se uma atualizacao futura renomear os metodos de novo, o apelido vira nil
-- sem fazer barulho e o erro so aparece quando alguem usar a pocao. Melhor
-- avisar no boot.
for _, nome in ipairs({ "getExpBoostStamina", "setExpBoostStamina", "getStoreXpBoost", "setStoreXpBoost" }) do
	if type(Player[nome]) ~= "function" then
		logger.error("[compat] Player.{} ficou sem destino; o metodo equivalente nao existe nesta versao do servidor", nome)
	end
end
