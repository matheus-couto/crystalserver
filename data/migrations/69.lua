local function tableExists(tableName)
	local resultId = db.storeQuery(string.format("SELECT 1 FROM `information_schema`.`TABLES` WHERE `TABLE_SCHEMA` = DATABASE() AND `TABLE_NAME` = '%s' LIMIT 1;", tableName))
	if resultId then
		Result.free(resultId)
		return true
	end
	return false
end

function onUpdateDatabase()
	logger.info("Updating database to version 69 (feat: tabelas do painel de administracao)")

	if not tableExists("panel_users") then
		-- A senha nunca e guardada; o que fica e o resultado do scrypt com um
		-- sal por usuario. Quem ler esta tabela num dump nao consegue voltar
		-- para a senha.
		db.query([[
			CREATE TABLE `panel_users` (
				`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
				`username` VARCHAR(32) NOT NULL,
				`password_hash` VARCHAR(255) NOT NULL,
				`disabled` TINYINT(1) NOT NULL DEFAULT 0,
				`created_at` BIGINT NOT NULL DEFAULT 0,
				`last_login` BIGINT NOT NULL DEFAULT 0,
				`last_ip` VARCHAR(45) NOT NULL DEFAULT '',
				PRIMARY KEY (`id`),
				UNIQUE KEY `panel_users_username` (`username`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
		]])
	end

	if not tableExists("panel_sessions") then
		-- Guarda o hash do identificador, nao ele proprio: um dump vazado nao
		-- entrega sessao viva para ninguem.
		db.query([[
			CREATE TABLE `panel_sessions` (
				`id_hash` CHAR(64) NOT NULL,
				`user_id` INT UNSIGNED NOT NULL,
				`created_at` BIGINT NOT NULL,
				`expires_at` BIGINT NOT NULL,
				`ip` VARCHAR(45) NOT NULL DEFAULT '',
				`ua_hash` CHAR(64) NOT NULL DEFAULT '',
				PRIMARY KEY (`id_hash`),
				KEY `panel_sessions_expira` (`expires_at`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
		]])
	end

	if not tableExists("panel_login_attempts") then
		-- Base do bloqueio progressivo. Sem app autenticador, e o que segura
		-- tentativa de senha em massa.
		db.query([[
			CREATE TABLE `panel_login_attempts` (
				`id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
				`ip` VARCHAR(45) NOT NULL,
				`username` VARCHAR(32) NOT NULL DEFAULT '',
				`ok` TINYINT(1) NOT NULL DEFAULT 0,
				`at` BIGINT NOT NULL,
				PRIMARY KEY (`id`),
				KEY `panel_attempts_ip` (`ip`, `at`),
				KEY `panel_attempts_user` (`username`, `at`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
		]])
	end

	if not tableExists("panel_audit") then
		-- Toda acao que muda alguma coisa passa por aqui. Com duas pessoas
		-- usando o painel, e o que responde "quem trocou este script".
		db.query([[
			CREATE TABLE `panel_audit` (
				`id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
				`at` BIGINT NOT NULL,
				`username` VARCHAR(32) NOT NULL DEFAULT '',
				`ip` VARCHAR(45) NOT NULL DEFAULT '',
				`action` VARCHAR(48) NOT NULL,
				`target` VARCHAR(255) NOT NULL DEFAULT '',
				`detail` TEXT NULL,
				PRIMARY KEY (`id`),
				KEY `panel_audit_at` (`at`),
				KEY `panel_audit_acao` (`action`, `at`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
		]])
	end

	if not tableExists("panel_commands") then
		-- O painel nao fala com o servidor de jogo por nenhum protocolo: ele
		-- enfileira aqui e um globalevent em Lua consome. Mesmo desenho do
		-- sistema de doacoes, que ja funciona - e evita abrir porta de
		-- administracao no servidor.
		db.query([[
			CREATE TABLE `panel_commands` (
				`id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
				`kind` VARCHAR(24) NOT NULL,
				`payload` TEXT NOT NULL,
				`status` ENUM('PENDING','DONE','FAILED') NOT NULL DEFAULT 'PENDING',
				`result` VARCHAR(255) NOT NULL DEFAULT '',
				`created_by` VARCHAR(32) NOT NULL DEFAULT '',
				`created_at` BIGINT NOT NULL,
				`executed_at` BIGINT NOT NULL DEFAULT 0,
				PRIMARY KEY (`id`),
				KEY `panel_cmd_pendente` (`status`, `id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
		]])
	end

	return true
end
