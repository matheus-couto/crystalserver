<?php
/**
 *
 * Char Bazaar (componente de processamento semiautomático de Auction)
 * Made by: Yueclow
 */

defined('MYAAC') or die('Direct access not allowed!');

$charbazaar_tax = $config['bazaar_tax'];
$charbazaar_create = $config['bazaar_create'];

// *=================================================================*
// |PROCESSAMENTO AUTOMÁTICO DE AUCTIONS EXPIRADAS                   |
// |Limitação: Requer acesso em páginas do bazaar.                   |
// *=================================================================*
function processExpiredAuctions($db, $charbazaar_tax, $charbazaar_create) {
    // Verifica a data e hora atual
    $dateNow = date('Y-m-d H:i:s');
    // A selecao roda DENTRO da transacao e com FOR UPDATE. Sem isso, dois
    // acessos simultaneos a uma pagina do bazaar liam o mesmo `status` = 0 e
    // finalizavam a mesma auction duas vezes, pagando o vendedor em dobro.
    $db->beginTransaction();

    try {
        $expiredAuctions = $db->query("
        SELECT `id`, `account_old`, `player_id`, `bid_account`, `bid_price`, `status` 
        FROM `myaac_charbazaar` 
        WHERE `date_end` < '{$dateNow}' 
        AND `status` = 0
            FOR UPDATE
        ");

            while ($auction = $expiredAuctions->fetch()) {
                $getBid = $db->query("
                    SELECT `account_id`, `bid` 
                    FROM `myaac_charbazaar_bid` 
                    WHERE `auction_id` = {$auction['id']} 
                    ORDER BY `bid` DESC 
                    LIMIT 1
                ");
                // Finaliza se existir alguma bid
                if ($getBid->rowCount() > 0) {
                    $bid = $getBid->fetch();
                    
                    $taxAmount = ($bid['bid'] / 100) * $charbazaar_tax;
                    $sellerProfit = $bid['bid'] - $taxAmount;
                    
                    $getSellerCoins = $db->query("
                        SELECT `coins_transferable` 
                        FROM `accounts` 
                        WHERE `id` = {$auction['account_old']}
                    ");
                    $sellerData = $getSellerCoins->fetch();
                    $newSellerBalance = $sellerData['coins_transferable'] + $sellerProfit;
                    
                    $db->exec("
                        UPDATE `accounts` 
                        SET `coins_transferable` = {$newSellerBalance} 
                        WHERE `id` = {$auction['account_old']}
                    ");
                    
                    $db->exec("
                        UPDATE `players` 
                        SET `account_id` = {$bid['account_id']}, `deletion` = 0, `charbazaar` = 0 
                        WHERE `id` = {$auction['player_id']}
                    ");
                    
                    $db->exec("
                        UPDATE `myaac_charbazaar` 
                        SET `status` = 1, 
                            `account_new` = {$bid['account_id']} 
                        WHERE `id` = {$auction['id']}
                    ");
                    
                } else {
                    // Executado se a Auction expirar sem nenhuma bid
                    
                    // Define como cancelada (expirada)
                    $db->exec("
                        UPDATE `myaac_charbazaar` 
                        SET `status` = 2,
                            `account_new` = {$auction['account_old']}
                        WHERE `id` = {$auction['id']}
                    ");

                    // Devolve o player para a conta 
                    $db->exec("
                        UPDATE `players` 
                        SET `account_id` = {$auction['account_old']}, `deletion` = 0, `charbazaar` = 0 
                        WHERE `id` = {$auction['player_id']}
                    ");

                    // Reembolsa vendedor
                    $db->exec("
                        UPDATE `accounts` 
                        SET `coins_transferable` = `coins_transferable` + $charbazaar_create
                        WHERE `id` = {$auction['account_old']}
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
processExpiredAuctions($db, $charbazaar_tax, $charbazaar_create);

?>

