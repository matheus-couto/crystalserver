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

-- Tipos de mensagem com o nome antigo. Sem o apelido a constante chega nil,
-- o servidor le 0 = MESSAGE_NONE e o jogador recebe "There was a problem
-- requesting your message". Era o que acontecia a cada kill de missao.
--
-- O mapeamento e pelo NUMERO, porque e o numero que o cliente usa para
-- decidir onde mostrar a mensagem. Os comentarios do enum atual (MessageClasses
-- em utils_definitions.hpp) batem, numero a numero, com os do antigo.
MESSAGE_STATUS_SMALL = MESSAGE_FAILURE           -- 21: branca, rodape da tela
MESSAGE_INFO_DESCR = MESSAGE_LOOK                -- 22: verde, tela e console
MESSAGE_EVENT_DEFAULT = MESSAGE_STATUS           -- 30: branca, rodape e console
MESSAGE_STATUS_WARNING = MESSAGE_ADMINISTRATOR   -- 18: vermelha, tela e console
-- O antigo 4 (azul so no console) nao existe mais; o mais proximo e o rodape.
MESSAGE_STATUS_CONSOLE_BLUE = MESSAGE_FAILURE

-- Fala laranja de criatura: ORANGE_1/ORANGE_2 viraram MONSTER_SAY/YELL (36/37).
TALKTYPE_ORANGE_1 = TALKTYPE_ORANGE_1 or TALKTYPE_MONSTER_SAY
TALKTYPE_ORANGE_2 = TALKTYPE_MONSTER_YELL

-- Se uma atualizacao futura renomear os metodos de novo, o apelido vira nil
-- sem fazer barulho e o erro so aparece quando alguem usar a pocao. Melhor
-- avisar no boot.
for _, nome in ipairs({ "getExpBoostStamina", "setExpBoostStamina", "getStoreXpBoost", "setStoreXpBoost" }) do
	if type(Player[nome]) ~= "function" then
		logger.error("[compat] Player.{} ficou sem destino; o metodo equivalente nao existe nesta versao do servidor", nome)
	end
end
for _, nome in ipairs({ "MESSAGE_STATUS_SMALL", "MESSAGE_INFO_DESCR", "MESSAGE_EVENT_DEFAULT",
	"MESSAGE_STATUS_WARNING", "MESSAGE_STATUS_CONSOLE_BLUE", "TALKTYPE_ORANGE_1", "TALKTYPE_ORANGE_2" }) do
	if rawget(_G, nome) == nil then
		logger.error("[compat] {} ficou sem destino; a constante equivalente nao existe nesta versao do servidor", nome)
	end
end
