<style>
    form {
        display: block;
        margin-top: 0;
        margin-block-end: 0;
    }

    .CVIcon.CVIconObject img {
        width: 32px;
        height: 32px;
    }

    .CharacterDetailsBlock .ShowMoreOrLess a {
        cursor: pointer;
    }

    .CollapsedBlock .TableContent tr:last-child {
        display: table-row;
        text-align: center;
    }
</style>

<?php
/**
 *
 * Char Bazaar
 *
 */

defined('MYAAC') or die('Direct access not allowed!');
$title = 'Create Auction';

// // =====================================================
// // EXECUTA O PROCESSAMENTO SEMIAUTOMÁTICO DO BAZAAR
require SYSTEM . 'pages/char_bazaar/semifinishauction.php';
// // =====================================================

if ($logged) {
    require SYSTEM . 'pages/char_bazaar/coins_balance.php';
} else {
    if (!empty($errors))
        $twig->display('error_box.html.twig', array('errors' => $errors));

    $twig->display('account.login.html.twig', array(
        'redirect' => isset($_REQUEST['redirect']) ? $_REQUEST['redirect'] : null,
        'account' => USE_ACCOUNT_NAME ? 'Name' : 'Number',
        'account_login_by' => getAccountLoginByLabel(),
        'error' => isset($errors[0]) ? $errors[0] : null
    ));
    return;
}

/* CHAR BAZAAR CONFIG ~ USING IN STEPS, DO NOT REMOVE! */
$charbazaar_create = charbazaarListingFee();
$charbazaar_buyer_fee = charbazaarBuyerFeePercent();
$charbazaar_newacc = (int)$config['bazaar_accountid'];
/* CHAR BAZAAR CONFIG END */

$getAuctionStep = $_GET['step'] ?? null;

/* REDIRECT TO STEP 1 */
if (empty($getAuctionStep) || $getAuctionStep < 1 || $getAuctionStep > 5) {
    header('Location: ' . BASE_URL . '?subtopic=createcharacterauction&step=1');
}
/* REDIRECT TO STEP 1 END */

/* STEP 01 START */
if ($getAuctionStep == 1) {
    require SYSTEM . 'pages/char_bazaar/create_step1.php';
}
/* STEP 01 END */

/* STEP 02 START */
if ($getAuctionStep == 2) {
    require SYSTEM . 'pages/char_bazaar/create_step2.php';
}
/* STEP 02 END */

/* STEP 03 START */
if ($getAuctionStep == 3) {
    require SYSTEM . 'pages/char_bazaar/create_step3.php';
}
/* STEP 03 END */

/* STEP 03 START */
if ($getAuctionStep == 4) {
    require SYSTEM . 'pages/char_bazaar/create_step4.php';
}
/* STEP 04 END */

/* STEP CONFIRM START */
if ($getAuctionStep == '5') {
    /* CADASTRAR AUCTION */
    //
    // Tudo e conferido de novo aqui, dentro de uma transacao: o POST deste passo
    // pode chegar sem passar pelo passo 2 (char online, em guild, com casa...).
    // Antes so a posse do char e o saldo eram conferidos.
    if (isset($_POST['auction_confirm']) && isset($_POST['auction_price']) && isset($_POST['auction_days']) && isset($_POST['auction_character'])) {
        $idLogged = (int)$account_logged->getId();
        $auction_price = (int)$_POST['auction_price'];
        $auction_days = (int)$_POST['auction_days'];
        $player_id = (int)$_POST['auction_character'];
        $auctionId = 0;
        $createProblems = [];

        if (!charbazaarCsrfValid()) {
            $createProblems[] = 'Your session expired. Please start the auction again.';
        }

        if ($auction_price < charbazaarMinimumPrice() || $auction_price > CHARBAZAAR_MAX_PRICE) {
            $createProblems[] = 'The starting price must be between ' . charbazaarMinimumPrice() . ' and ' . CHARBAZAAR_MAX_PRICE . ' Tibia Coins.';
        }

        if ($auction_days < 1 || $auction_days > CHARBAZAAR_MAX_DAYS) {
            $createProblems[] = 'The auction must end between 1 and ' . CHARBAZAAR_MAX_DAYS . ' days from now.';
        }

        if (!$createProblems) {
            $db->beginTransaction();
            try {
                $createProblems = charbazaarSellProblems($db, $player_id, $idLogged);

                if (!$createProblems) {
                    // Reivindica o personagem com a MESMA guarda que o servidor usa em
                    // data/modules/scripts/charbazaar/charbazaar.lua: o AND `charbazaar` = 0
                    // impede que o jogo e o site abram dois leiloes para o mesmo char.
                    // `deletion` = 1 tira o personagem da lista e bloqueia o login.
                    $claimed = $db->exec("UPDATE `players` SET `deletion` = 1, `charbazaar` = 1 WHERE `id` = {$player_id} AND `account_id` = {$idLogged} AND `charbazaar` = 0") > 0;

                    if (!$claimed) {
                        $createProblems[] = 'This character could not be put up for auction.';
                    } elseif (!charbazaarDebitCoins($db, $idLogged, $charbazaar_create)) {
                        $createProblems[] = "You need {$charbazaar_create} transferable Tibia Coins to create this auction.";
                    } else {
                        $date_start = date('YmdHis');
                        $date_end = date('YmdHis', strtotime('+' . $auction_days . ' days'));

                        $db->exec("INSERT INTO `myaac_charbazaar` (`account_old`, `account_new`, `player_id`, `price`, `date_end`, `date_start`, `bid_account`, `bid_price`, `status`) VALUES ({$idLogged}, {$charbazaar_newacc}, {$player_id}, {$auction_price}, '{$date_end}', '{$date_start}', 0, 0, " . CHARBAZAAR_STATUS_OPEN . ")");
                        $auctionId = (int)$db->lastInsertId();

                        $db->exec("UPDATE `players` SET `account_id` = {$charbazaar_newacc} WHERE `id` = {$player_id}");
                    }
                }

                if ($createProblems) {
                    $db->rollback();
                } else {
                    $db->commit();
                }
            } catch (Exception $e) {
                $db->rollback();
                error_log('Erro ao criar auction: ' . $e->getMessage());
                $createProblems = ['Internal error. Please try again.'];
            }
        }

        if (!$createProblems) {
            ?>
        <div class="TableContainer">
            <div class="CaptionContainer">
                <div class="CaptionInnerContainer">
                    <span class="CaptionEdgeLeftTop"
                          style="background-image:url(<?= $template_path; ?>/images/global/content/box-frame-edge.gif);"></span>
                    <span class="CaptionEdgeRightTop"
                          style="background-image:url(<?= $template_path; ?>/images/global/content/box-frame-edge.gif);"></span>
                    <span class="CaptionBorderTop"
                          style="background-image:url(<?= $template_path; ?>/images/global/content/table-headline-border.gif);"></span>
                    <span class="CaptionVerticalLeft"
                          style="background-image:url(<?= $template_path; ?>/images/global/content/box-frame-vertical.gif);"></span>
                    <div class="Text">Auction created</div>
                    <span class="CaptionVerticalRight"
                          style="background-image:url(<?= $template_path; ?>/images/global/content/box-frame-vertical.gif);"></span>
                    <span class="CaptionBorderBottom"
                          style="background-image:url(<?= $template_path; ?>/images/global/content/table-headline-border.gif);"></span>
                    <span class="CaptionEdgeLeftBottom"
                          style="background-image:url(<?= $template_path; ?>/images/global/content/box-frame-edge.gif);"></span>
                    <span class="CaptionEdgeRightBottom"
                          style="background-image:url(<?= $template_path; ?>/images/global/content/box-frame-edge.gif);"></span>
                </div>
            </div>
            <table class="Table5" cellspacing="0" cellpadding="0">
                <tbody>
                <tr>
                    <td>
                        <div class="InnerTableContainer">
                            <table style="width:100%;">
                                <tbody>
                                <tr>
                                    <td>
                                        <div class="TableContentContainer">
                                            <table class="TableContent" style="border:1px solid #faf0d7;" width="100%">
                                                <tbody>
                                                <tr>
                                                    <td style="font-weight:normal;"><img
                                                            src="<?= $template_path; ?>/images/charactertrade/confirm.gif">
                                                    </td>
                                                    <td style="font-weight:bold; font-size: 24px;">Auction created</td>
                                                    <td>
                                                        <a href="?subtopic=currentcharactertrades&details=<?= $auctionId ?>">
                                                            <div class="BigButton"
                                                                 style="background-image:url(<?= $template_path; ?>/images/global/buttons/sbutton_green.gif)">
                                                                <div onmouseover="MouseOverBigButton(this);"
                                                                     onmouseout="MouseOutBigButton(this);">
                                                                    <div class="BigButtonOver"
                                                                         style="background-image: url(<?= $template_path; ?>/images/global/buttons/sbutton_green_over.gif); visibility: hidden;"></div>
                                                                    <input name="auction_confirm" class="BigButtonText"
                                                                           type="button" value="View auction"></div>
                                                            </div>
                                                        </a>
                                                    </td>
                                                </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <?php
        }

        // Página de aviso de erro na criação do bazar
        else {
            foreach ($createProblems as $problem) {
                charbazaarMessage($problem);
            }
        ?>
        <a href="?subtopic=createcharacterauction&step=1">
            <div class="BigButton"
                style="background-image:url(<?= $template_path; ?>/images/global/buttons/sbutton.gif)">
                <div onmouseover="MouseOverBigButton(this);" onmouseout="MouseOutBigButton(this);">
                    <div class="BigButtonOver"
                        style="background-image: url(<?= $template_path; ?>/images/global/buttons/sbutton_over.gif); visibility: hidden;"></div>
                    <input class="BigButtonText" type="button" value="Back">
                </div>
            </div>
        </a>
        <?php
        }
    }
    /* CADASTRAR AUCTION END */
}
/* STEP CONFIRM END */
?>