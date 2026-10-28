<?php
/**
 *
 * Char Bazaar (componente de processamento semiautomático de Auction)
 * Made by: Yueclow
 */

defined('MYAAC') or die('Direct access not allowed!');

require_once SYSTEM . 'pages/char_bazaar/lib.php';

// *=================================================================*
// |PROCESSAMENTO AUTOMÁTICO DE AUCTIONS EXPIRADAS                   |
// |Limitação: Requer acesso em páginas do bazaar.                   |
// *=================================================================*
function processExpiredAuctions($db) {
    charbazaarEnsureSchema($db);

    // Verifica a data e hora atual
    $dateNow = date('Y-m-d H:i:s');
    // A selecao roda DENTRO da transacao e com FOR UPDATE. Sem isso, dois
    // acessos simultaneos a uma pagina do bazaar liam o mesmo `status` = 0 e
    // finalizavam a mesma auction duas vezes, pagando o vendedor em dobro.
    // Os lances tambem travam a linha da auction, entao nenhum lance entra
    // enquanto ela e finalizada.
    $db->beginTransaction();

    try {
        $expiredAuctions = $db->query("
        SELECT `id`, `account_old`, `player_id`
        FROM `myaac_charbazaar`
        WHERE `date_end` < '{$dateNow}'
        AND `status` = " . CHARBAZAAR_STATUS_OPEN . "
            FOR UPDATE
        ")->fetchAll();

            foreach ($expiredAuctions as $auction) {
                $auctionId = (int)$auction['id'];
                $sellerId = (int)$auction['account_old'];
                $playerId = (int)$auction['player_id'];

                $bid = $db->query("
                    SELECT `account_id`, `bid`
                    FROM `myaac_charbazaar_bid`
                    WHERE `auction_id` = {$auctionId}
                    ORDER BY `bid` DESC
                    LIMIT 1
                ")->fetch();

                // Finaliza se existir alguma bid
                if ($bid) {
                    $buyerId = (int)$bid['account_id'];

                    // O lance e a taxa do comprador ja foram debitados quando ele
                    // deu o lance. O vendedor recebe o lance inteiro (sem
                    // comissao) e a taxa do comprador fica com o servidor.
                    charbazaarCreditCoins($db, $sellerId, (int)$bid['bid']);

                    $db->exec("
                        UPDATE `players`
                        SET `account_id` = {$buyerId}, `deletion` = 0, `charbazaar` = 0
                        WHERE `id` = {$playerId}
                    ");

                    $db->exec("
                        UPDATE `myaac_charbazaar`
                        SET `status` = " . CHARBAZAAR_STATUS_SOLD . ",
                            `account_new` = {$buyerId}
                        WHERE `id` = {$auctionId}
                    ");

                } else {
                    // Expirou sem nenhuma bid: o personagem volta para o dono.
                    // A taxa de anuncio NAO e devolvida.
                    $db->exec("
                        UPDATE `myaac_charbazaar`
                        SET `status` = " . CHARBAZAAR_STATUS_CLOSED . ",
                            `account_new` = {$sellerId}
                        WHERE `id` = {$auctionId}
                    ");

                    // Devolve o player para a conta
                    $db->exec("
                        UPDATE `players`
                        SET `account_id` = {$sellerId}, `deletion` = 0, `charbazaar` = 0
                        WHERE `id` = {$playerId}
                    ");
                }
            }

            $db->commit();
            return true;

        } catch (Exception $e) {
            $db->rollback();
            error_log("Erro ao processar auctions expiradas: " . $e->getMessage());
            return false;
        }
}


// ============================================
// EXECUÇÃO DO PROCESSAMENTO SEMIAUTOMÁTICO
// ============================================
processExpiredAuctions($db);

?>
