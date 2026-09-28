local function tableExists(tableName)
	local resultId = db.storeQuery(string.format("SELECT 1 FROM `information_schema`.`TABLES` WHERE `TABLE_SCHEMA` = DATABASE() AND `TABLE_NAME` = '%s' LIMIT 1;", tableName))
	if resultId then
		Result.free(resultId)
		return true
	end
	return false
end

function onUpdateDatabase()
	logger.info("Updating database to version 68 (feat: add donate_transactions table)")

	if tableExists("donate_transactions") then
		return true
	end

	-- O valor fica em centavos, como inteiro. Guardar dinheiro em float leva a
	-- centavos perdidos no arredondamento, e o Asaas trabalha com 2 casas.
	--
	-- Ciclo do `status`:
	--   PENDING          !donate gravou a intencao; o worker Node ainda nao viu
	--   AWAITING_PAYMENT o worker criou o link no Asaas e gravou `invoice_url`
	--   PAID             o webhook do Asaas confirmou o pagamento
	--   CREDITED         o jogo creditou as coins (estado final de sucesso)
	--   EXPIRED          a intencao passou do prazo sem ser paga
	--   FAILED           o worker nao conseguiu criar a cobranca
	--   REFUNDED         estorno recebido pelo webhook apos o credito
	db.query([[
		CREATE TABLE IF NOT EXISTS `donate_transactions` (
			`id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
			`account_id` INT(11) NOT NULL,
			`player_id` INT(11) NOT NULL,
			`player_name` VARCHAR(255) NOT NULL,
			`amount_cents` INT(11) UNSIGNED NOT NULL,
			`coins` INT(11) UNSIGNED NOT NULL,
			`status` ENUM('PENDING','AWAITING_PAYMENT','PAID','CREDITED','EXPIRED','FAILED','REFUNDED') NOT NULL DEFAULT 'PENDING',
			`asaas_payment_link_id` VARCHAR(64) NOT NULL DEFAULT '',
			`asaas_payment_id` VARCHAR(64) NOT NULL DEFAULT '',
			`invoice_url` VARCHAR(512) NOT NULL DEFAULT '',
			`delivered` TINYINT(1) NOT NULL DEFAULT 0,
			`fail_reason` VARCHAR(255) NOT NULL DEFAULT '',
			`world_id` INT(11) NOT NULL DEFAULT 1,
			`created_at` BIGINT(20) NOT NULL,
			`updated_at` BIGINT(20) NOT NULL,
			`paid_at` BIGINT(20) NOT NULL DEFAULT 0,
			`credited_at` BIGINT(20) NOT NULL DEFAULT 0,
			CONSTRAINT `donate_transactions_pk` PRIMARY KEY (`id`),
			KEY `donate_status` (`status`),
			KEY `donate_account` (`account_id`),
			KEY `donate_player` (`player_id`),
			KEY `donate_delivery` (`status`, `delivered`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	]])

	-- Indice unico apenas sobre pagamentos ja identificados. O default vazio se
	-- repete em toda linha PENDING, entao a coluna nao pode ser UNIQUE direto;
	-- a unicidade e garantida no worker, que so grava o id uma vez.
	db.query("ALTER TABLE `donate_transactions` ADD INDEX `donate_asaas_payment` (`asaas_payment_id`);")
	db.query("ALTER TABLE `donate_transactions` ADD INDEX `donate_asaas_link` (`asaas_payment_link_id`);")

	return true
end
