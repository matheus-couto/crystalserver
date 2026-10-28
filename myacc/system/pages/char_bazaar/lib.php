<?php
/**
 * Char Bazaar - regras de taxa e dinheiro, num lugar so.
 *
 * Modelo de cobranca:
 *  - Vendedor paga `bazaar_create` para anunciar. Nunca e devolvida.
 *  - Comprador paga `bazaar_buyer_fee` % do lance, SO se vencer. Ao dar o lance
 *    fica reservado lance + taxa; se alguem cobrir, tudo volta. Na venda o
 *    vendedor recebe o lance inteiro e a taxa fica com o servidor.
 *  - Sem comissao sobre a venda.
 *
 * O leilao criado pelo cliente (data/modules/scripts/charbazaar/charbazaar.lua)
 * cobra a mesma taxa de anuncio: mantenha CharBazaar.Config.fee igual a
 * bazaar_create.
 *
 * Todo saldo e alterado com `coins_transferable = coins_transferable +/- x`,
 * nunca gravando um valor lido antes: o jogo e outras abas mexem na mesma
 * coluna ao mesmo tempo.
 */

defined('MYAAC') or die('Direct access not allowed!');

const CHARBAZAAR_STATUS_OPEN = 0;
const CHARBAZAAR_STATUS_SOLD = 1;
const CHARBAZAAR_STATUS_CLOSED = 2;

const CHARBAZAAR_MIN_LEVEL = 8;
const CHARBAZAAR_MAX_DAYS = 28;
const CHARBAZAAR_MAX_PRICE = 999999999;

function charbazaarListingFee(): int
{
	global $config;
	return max(0, (int)($config['bazaar_create'] ?? 0));
}

function charbazaarBuyerFeePercent(): int
{
	global $config;
	return max(0, (int)($config['bazaar_buyer_fee'] ?? 0));
}

/** Taxa do comprador para um lance, arredondada para cima. */
function charbazaarBuyerFee(int $bid): int
{
	$percent = charbazaarBuyerFeePercent();
	if ($bid <= 0 || $percent <= 0) {
		return 0;
	}

	return intdiv($bid * $percent + 99, 100);
}

/** Janela do anti-sniping, em minutos. 0 desliga. */
function charbazaarExtensionMinutes(): int
{
	global $config;
	return max(0, (int)($config['bazaar_extension_minutes'] ?? 0));
}

/**
 * Novo fim do leilao quando um lance chega faltando menos que a janela, ou null
 * se nao precisa mudar. O fim passa a ser agora + janela, entao lances seguidos
 * no fim continuam empurrando, como no leilao de verdade.
 */
function charbazaarExtendedEnd(string $dateEnd): ?string
{
	$window = charbazaarExtensionMinutes() * 60;
	if ($window <= 0 || strtotime($dateEnd) - time() >= $window) {
		return null;
	}

	return date('Y-m-d H:i:s', time() + $window);
}

/**
 * Menor preco inicial aceito. Mesma regra do minimumStartingBid() do Lua:
 * abaixo disso o vendedor perderia dinheiro, pois paga a taxa de anuncio.
 */
function charbazaarMinimumPrice(): int
{
	return charbazaarListingFee() + 1;
}

/**
 * A taxa do comprador fica guardada em cada lance, para que o reembolso devolva
 * exatamente o que foi reservado mesmo que a porcentagem mude no meio do leilao.
 * Lances antigos ficam com 0, que e o correto: no modelo antigo nada alem do
 * lance ficava reservado.
 */
function charbazaarEnsureSchema($db): void
{
	static $done = false;
	if ($done) {
		return;
	}

	// SHOW COLUMNS direto, e nao $db->hasColumn(): aquele guarda a resposta em
	// cache e continuaria dizendo "nao existe" depois do ALTER.
	if ($db->query("SHOW COLUMNS FROM `myaac_charbazaar_bid` LIKE 'fee'")->rowCount() === 0) {
		$db->exec('ALTER TABLE `myaac_charbazaar_bid` ADD COLUMN IF NOT EXISTS `fee` INT NOT NULL DEFAULT 0');
	}

	// O que o vendedor escolhe no cliente: ate 4 itens de vitrine (ids separados
	// por virgula) e os argumentos de venda ([{"icon":N,"text":"..."}]). O Lua
	// so grava se as colunas existirem.
	if ($db->query("SHOW COLUMNS FROM `myaac_charbazaar` LIKE 'sales_arguments'")->rowCount() === 0) {
		$db->exec('ALTER TABLE `myaac_charbazaar` ADD COLUMN IF NOT EXISTS `showcase` VARCHAR(255) NULL DEFAULT NULL, ADD COLUMN IF NOT EXISTS `sales_arguments` TEXT NULL DEFAULT NULL');
	}
	$done = true;
}

function charbazaarCreditCoins($db, int $accountId, int $amount): void
{
	if ($accountId <= 0 || $amount <= 0) {
		return;
	}

	$db->exec("UPDATE `accounts` SET `coins_transferable` = `coins_transferable` + {$amount} WHERE `id` = {$accountId}");
}

/** Debita so se houver saldo; diz se debitou. */
function charbazaarDebitCoins($db, int $accountId, int $amount): bool
{
	if ($amount <= 0) {
		return true;
	}

	return $db->exec("UPDATE `accounts` SET `coins_transferable` = `coins_transferable` - {$amount} WHERE `id` = {$accountId} AND `coins_transferable` >= {$amount}") > 0;
}

/**
 * Tudo o que impede o personagem de ir a leilao. Mesmas regras do passo 2 da
 * criacao, rodadas de novo na confirmacao porque o POST final pode chegar sem
 * passar por ele.
 */
function charbazaarSellProblems($db, int $playerId, int $accountId): array
{
	global $config;

	$problems = [];

	$player = $db->query("SELECT `id`, `account_id`, `level`, `deletion`, `charbazaar` FROM `players` WHERE `id` = {$playerId}")->fetch();
	if (!$player || (int)$player['account_id'] !== $accountId) {
		return ['You can only create auctions for your characters.'];
	}

	if ((int)$player['deletion'] !== 0 || (int)$player['charbazaar'] !== 0) {
		$problems[] = 'The character is already up for auction or scheduled for deletion.';
	}

	if ((int)$player['level'] < CHARBAZAAR_MIN_LEVEL) {
		$problems[] = 'The character needs to be at least level ' . CHARBAZAAR_MIN_LEVEL . '.';
	}

	$account = $db->query("SELECT `coins_transferable`, `key` FROM `accounts` WHERE `id` = {$accountId}")->fetch();
	if (!$account || (int)$account['coins_transferable'] < charbazaarListingFee()) {
		$problems[] = 'You need ' . charbazaarListingFee() . ' transferable Tibia Coins to create this auction.';
	}

	if (!$account || empty($account['key'])) {
		$problems[] = 'Your account must be registered.';
	}

	$checks = [
		"SELECT 1 FROM `players_online` WHERE `player_id` = {$playerId}" => 'The character must be offline.',
		"SELECT 1 FROM `houses` WHERE `owner` = {$playerId} OR `bidder` = {$playerId}" => 'The character may not own or bid for a house.',
		"SELECT 1 FROM `guilds` WHERE `ownerid` = {$playerId}" => 'The character may not be a member of a guild.',
		"SELECT 1 FROM `guild_membership` WHERE `player_id` = {$playerId}" => 'The character may not be a member of a guild.',
		"SELECT 1 FROM `guild_invites` WHERE `player_id` = {$playerId}" => 'The character may not have applied to a guild.',
		"SELECT 1 FROM `market_offers` WHERE `player_id` = {$playerId}" => 'The character may not have any running offers in the Market.',
	];

	if ($db->hasTable('player_killers') && ($config['characters']['frags'] ?? false)) {
		$checks["SELECT 1 FROM `player_killers` WHERE `player_id` = {$playerId}"] = 'The character may not have any frags.';
	}

	foreach ($checks as $query => $problem) {
		if ($db->query($query . ' LIMIT 1')->rowCount() > 0 && !in_array($problem, $problems, true)) {
			$problems[] = $problem;
		}
	}

	return $problems;
}

/** Ids dos itens de vitrine de uma auction, sem repetidos. */
function charbazaarShowcaseIds(?string $showcase): array
{
	$ids = array_filter(array_map('intval', explode(',', (string)$showcase)), function ($id) {
		return $id > 0;
	});

	return array_slice(array_values(array_unique($ids)), 0, 4);
}

/** Argumentos de venda de uma auction, como [['icon' => N, 'text' => '...']]. */
function charbazaarSalesArguments(?string $json): array
{
	$entries = json_decode((string)$json, true);
	if (!is_array($entries)) {
		return [];
	}

	$result = [];
	foreach ($entries as $entry) {
		if (is_array($entry) && isset($entry['text'])) {
			$result[] = ['icon' => max(0, min(14, (int)($entry['icon'] ?? 0))), 'text' => (string)$entry['text']];
		}
	}

	return $result;
}

/**
 * Token contra CSRF dos formularios que mexem em dinheiro (lance, cancelar,
 * criar). Sem ele, qualquer site podia fazer o navegador de quem esta logado
 * mandar um lance ou cancelar um anuncio. Um token por sessao.
 */
function charbazaarCsrfToken(): string
{
	$token = getSession('charbazaar_csrf');
	if (!$token) {
		$token = bin2hex(random_bytes(16));
		setSession('charbazaar_csrf', $token);
	}

	return $token;
}

function charbazaarCsrfField(): string
{
	return '<input type="hidden" name="charbazaar_token" value="' . charbazaarCsrfToken() . '">';
}

function charbazaarCsrfValid(): bool
{
	$token = getSession('charbazaar_csrf');
	return $token && hash_equals($token, (string)($_POST['charbazaar_token'] ?? ''));
}

/** A caixa de aviso que as paginas do bazaar usam, vermelha ou verde. */
function charbazaarMessage(string $text, bool $ok = false): void
{
	$color = $ok ? '#2f7a2f' : '#b32d2d';
	$text = htmlspecialchars($text);
	$img = 'templates/tibiacom/images/global/content';

	echo <<<HTML
	<div class="SmallBox">
		<div class="MessageContainer">
			<div class="BoxFrameHorizontal" style="background-image:url({$img}/box-frame-horizontal.gif);"></div>
			<div class="BoxFrameEdgeLeftTop" style="background-image:url({$img}/box-frame-edge.gif);"></div>
			<div class="BoxFrameEdgeRightTop" style="background-image:url({$img}/box-frame-edge.gif);"></div>
			<div class="Message">
				<div class="BoxFrameVerticalLeft" style="background-image:url({$img}/box-frame-vertical.gif);"></div>
				<div class="BoxFrameVerticalRight" style="background-image:url({$img}/box-frame-vertical.gif);"></div>
				<table class="HintBox">
					<tbody>
					<tr>
						<td>
							<p style="color: {$color}; font-weight: bold; text-align: center; margin: 0;">{$text}</p>
						</td>
					</tr>
					</tbody>
				</table>
			</div>
			<div class="BoxFrameHorizontal" style="background-image:url({$img}/box-frame-horizontal.gif);"></div>
			<div class="BoxFrameEdgeRightBottom" style="background-image:url({$img}/box-frame-edge.gif);"></div>
			<div class="BoxFrameEdgeLeftBottom" style="background-image:url({$img}/box-frame-edge.gif);"></div>
		</div>
	</div>
	<br>
	HTML;
}
