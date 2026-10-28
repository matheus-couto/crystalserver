<?php
/**
 *
 * Char Bazaar
 *
 */
defined('MYAAC') or die('Direct access not allowed!');
$title = 'My Auctions';

if ($logged) {
    require SYSTEM . 'pages/char_bazaar/coins_balance.php';
}

// // =====================================================
// // EXECUTA O PROCESSAMENTO SEMIAUTOMÁTICO DO BAZAAR
require SYSTEM . 'pages/char_bazaar/semifinishauction.php';
// // =====================================================

// Cancelamento da auction
//
// So o dono, so leilao aberto e so sem lances. Antes nada disso era conferido:
// cancelar um leilao ja vendido devolvia o char ao vendedor, devolvia o lance ao
// comprador e dava +50 TC, e podia ser repetido quantas vezes quisesse.
// A taxa de anuncio nao e devolvida.
if ($logged && $_SERVER['REQUEST_METHOD'] === 'POST' && ($_GET['action'] ?? null) === 'cancel') {
    $idAuctionCancel = (int)($_POST['auction_cancel_id'] ?? 0);
    $cancelError = null;

    $db->beginTransaction();
    try {
        $getAuctionCancel = $db->query("SELECT `id`, `account_old`, `player_id`, `status` FROM `myaac_charbazaar` WHERE `id` = {$idAuctionCancel} FOR UPDATE")->fetch();

        if (!charbazaarCsrfValid()) {
            $cancelError = 'Your session expired. Please try again.';
        } elseif (!$getAuctionCancel || (int)$getAuctionCancel['account_old'] !== (int)$account_logged->getId()) {
            $cancelError = 'You can only cancel your own auctions.';
        } elseif ((int)$getAuctionCancel['status'] !== CHARBAZAAR_STATUS_OPEN) {
            $cancelError = 'This auction is already finished.';
        } elseif ($db->query("SELECT 1 FROM `myaac_charbazaar_bid` WHERE `auction_id` = {$idAuctionCancel} LIMIT 1")->rowCount() > 0) {
            $cancelError = 'An auction that already has bids cannot be cancelled.';
        } else {
            $idDonoAuctionCancel = (int)$getAuctionCancel['account_old'];
            $dataCancelamento = date('Y-m-d H:i:s');

            // muda status da auction para cancelada e a encerra com a data atual
            $db->exec("UPDATE `myaac_charbazaar` SET `status` = " . CHARBAZAAR_STATUS_CLOSED . ", `date_end` = '{$dataCancelamento}', `account_new` = {$idDonoAuctionCancel} WHERE `id` = {$idAuctionCancel}");
            // devolve player para a conta original
            $db->exec("UPDATE `players` SET `account_id` = {$idDonoAuctionCancel}, `deletion` = 0, `charbazaar` = 0 WHERE `id` = " . (int)$getAuctionCancel['player_id']);
        }

        $db->commit();
    } catch (Exception $e) {
        $db->rollback();
        error_log('Erro ao cancelar auction: ' . $e->getMessage());
        $cancelError = 'Internal error. Please try again.';
    }

    if ($cancelError) {
        charbazaarMessage($cancelError);
    } else {
        charbazaarMessage('Auction cancelled. Your character has been returned to your account. The auction fee is not refunded.', true);
    }
}

    // Alerta caso esteja deslogado
    if ($logged == 0) {
        echo <<<HTML
                <div class="SmallBox">
                    <div class="MessageContainer">
                        <div class="BoxFrameHorizontal" style="background-image:url(templates/tibiacom/images/global/content/box-frame-horizontal.gif);"></div>
                        <div class="BoxFrameEdgeLeftTop" style="background-image:url(templates/tibiacom/images/global/content/box-frame-edge.gif);"></div>
                        <div class="BoxFrameEdgeRightTop" style="background-image:url(templates/tibiacom/images/global/content/box-frame-edge.gif);"></div>
                        <div class="Message">
                        <div class="BoxFrameVerticalLeft" style="background-image:url(templates/tibiacom/images/global/content/box-frame-vertical.gif);"></div>
                        <div class="BoxFrameVerticalRight" style="background-image:url(templates/tibiacom/images/global/content/box-frame-vertical.gif);"></div>
                        <table class="HintBox">
                            <tbody>
                            <tr>
                            <td>
                                <p style="color: #b32d2d; font-weight: bold; text-align: center; margin: 0;">
                                You must be logged in to view your auctions.            </p>
                            </td>
                            </tr>
                            </tbody>
                        </table>
                        </div>
                        <div class="BoxFrameHorizontal" style="background-image:url(templates/tibiacom/images/global/content/box-frame-horizontal.gif);"></div>
                        <div class="BoxFrameEdgeRightBottom" style="background-image:url(templates/tibiacom/images/global/content/box-frame-edge.gif);"></div>
                        <div class="BoxFrameEdgeLeftBottom" style="background-image:url(templates/tibiacom/images/global/content/box-frame-edge.gif);"></div>
                    </div>
                </div>
                <br>
            HTML;
    }
?>




<!-- Início do html -->
<div class="SmallBox">
    <div class="MessageContainer">
        <div class="BoxFrameHorizontal"
             style="background-image:url(<?= $template_path; ?>/images/global/content/box-frame-horizontal.gif);"></div>
        <div class="BoxFrameEdgeLeftTop"
             style="background-image:url(<?= $template_path; ?>/images/global/content/box-frame-edge.gif);"></div>
        <div class="BoxFrameEdgeRightTop"
             style="background-image:url(<?= $template_path; ?>/images/global/content/box-frame-edge.gif);"></div>
        <div class="Message">
            <div class="BoxFrameVerticalLeft"
                 style="background-image:url(<?= $template_path; ?>/images/global/content/box-frame-vertical.gif);"></div>
            <div class="BoxFrameVerticalRight"
                 style="background-image:url(<?= $template_path; ?>/images/global/content/box-frame-vertical.gif);"></div>
            <table class="HintBox">
                <tbody>
                <tr>
                    <td>
                        <div style="float: right;"></div>
                        <p>Here you find <b>your character auctions</b> that:</p>
                        <ul>
                            <li>are about to start</li>
                            <li>are currently running</li>
                            <li>were recently successfully completed</li>
                            <li>were recently cancelled</li>
                        </ul>
                        <p>Check out your Tibia Coins History to see <b>all characters you have sold</b> successfully.
                        </p></td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="BoxFrameHorizontal"
             style="background-image:url(<?= $template_path; ?>/images/global/content/box-frame-horizontal.gif);"></div>
        <div class="BoxFrameEdgeRightBottom"
             style="background-image:url(<?= $template_path; ?>/images/global/content/box-frame-edge.gif);"></div>
        <div class="BoxFrameEdgeLeftBottom"
             style="background-image:url(<?= $template_path; ?>/images/global/content/box-frame-edge.gif);"></div>
    </div>
</div>
<br>
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
            <div class="Text">My Auctions</div>
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
    <table class="Table3" cellpadding="0" cellspacing="0">
        <tbody>
        <tr>
            <td>
                <div class="InnerTableContainer">
                    <table style="width:100%;">
                        <tbody>
                        <tr>
                            <td>
                                <div class="TableContentContainer">
                                    <table class="TableContent" width="100%" style="border:1px solid #faf0d7;">
                                        <tbody>
                                        <tr class="Odd">
                                            <td class="LabelV">Name</td>
                                            <td class="LabelV">Start</td>
                                            <td class="LabelV">End</td>
                                            <td class="LabelV">Current Bid</td>
                                            <td class="LabelV">Options</td>
                                            <td class="LabelV">Status</td>
                                        </tr>
                                        <?php
                                        $getAuctionsbyAccount = [];
                                        if ($logged) {
                                            $getAuctionsbyAccount = $db->query(
                                                "SELECT `id`, `account_old`, `account_new`, `player_id`, `price`, `date_end`, `date_start`, `bid_account`, `bid_price`, `status` 
                                                FROM `myaac_charbazaar` 
                                                WHERE `account_old` = {$account_logged->getId()}
                                                ORDER BY `date_start` DESC");
                                            $i_bg = 0;
                                            foreach ($getAuctionsbyAccount as $Auction) {
                                                $i_bg = $i_bg + 1;

                                                $getCharacterbyAccount = $db->query("SELECT `id`, `name`, `level` FROM `players` WHERE `id` = {$Auction['player_id']}");
                                                $getCharacterbyAccount = $getCharacterbyAccount->fetch();

                                                $Hoje = date('Y-m-d H:i:s');
                                                $End = date('Y-m-d H:i:s', strtotime($Auction['date_end']));
                                                if ($Auction['status'] == 1) {
                                                    $bg_DateEnd = (strtotime($End) > strtotime($Hoje)) ? '' : 'green';
                                                } elseif ($Auction['status'] == 2) {
                                                    $bg_DateEnd = (strtotime($End) > strtotime($Hoje)) ? '' : 'red';
                                                }
                                                ?>
                                                <tr bgcolor="<?= getStyle($i_bg); ?>">
                                                    <td style="color: <?= $bg_DateEnd ?>;"><?= $getCharacterbyAccount['name'] ?></td>
                                                    <td style="color: <?= $bg_DateEnd ?>;"><?= date('d M Y', strtotime($Auction['date_start'])); ?></td>
                                                    <td style="color: <?= $bg_DateEnd ?>;"><?= date('d M Y', strtotime($Auction['date_end'])); ?></td>
                                                    <td style="color: <?= $bg_DateEnd ?>;"><?= number_format($Auction['bid_price'], 0, ',', ','); ?>
                                                        <img
                                                            src="<?= $template_path; ?>/images//account/icon-tibiacointrusted.png"
                                                            class="VSCCoinImages" title="Transferable Tibia Coins"></td>
                                                    <?php if (strtotime($End) > strtotime($Hoje) && $Auction['status'] == 0) { ?>
                                                        <?php $canCancel = (int)$Auction['bid_account'] === 0; ?>
                                                        <td>
                                                            <a href="?subtopic=currentcharactertrades&details=<?= $Auction['id'] ?>">
                                                                <div class="BigButton"
                                                                     style="background-image:url(<?= $template_path; ?>/images/global/buttons/sbutton_green.gif); display: inline-block; margin-right:4px;">
                                                                    <div onmouseover="MouseOverBigButton(this);"
                                                                         onmouseout="MouseOutBigButton(this);">
                                                                        <div class="BigButtonOver"
                                                                             style="background-image: url(<?= $template_path; ?>/images/global/buttons/sbutton_green_over.gif); visibility: hidden;"></div>
                                                                        <input name="auction_confirm"
                                                                               class="BigButtonText"
                                                                               type="button" value="Access">
                                                                    </div>
                                                                </div>
                                                            </a>
                                                            <?php if ($canCancel) { ?>
                                                            <form method="post" action="?subtopic=owncharactertrades&action=cancel"
                                                            style="display:inline-block; margin: 0;">    
                                                                <div class="BigButton"
                                                                        style="background-image:url(<?= $template_path; ?>/images/global/buttons/sbutton_red.gif); margin: 0px;display: inline-block;">
                                                                        <div onmouseover="MouseOverBigButton(this);"
                                                                            onmouseout="MouseOutBigButton(this);">
                                                                            <div class="BigButtonOver"
                                                                                style="background-image: url(<?= $template_path; ?>/images/global/buttons/sbutton_red_over.gif); visibility: hidden;"></div>
                                                                            <input type="hidden" name="auction_cancel_id" value="<?= $Auction['id'] ?>">
                                                                            <?= charbazaarCsrfField() ?>
                                                                            <input
                                                                                class="BigButtonText"
                                                                                type="submit"
                                                                                value="Cancel"
                                                                                onclick="return confirm('Are you sure you want to cancel this auction?');">
                                                                        </div>
                                                                </div>
                                                            </form>
                                                            <?php } ?>
                                                        </td>
                                                            

                                                    <?php } else { 
                                                        ?>
                                                        <td>
                                                            <a href="?subtopic=pastcharactertrades&details=<?= $Auction['id'] ?>">
                                                                <div class="BigButton"
                                                                     style="background-image:url(<?= $template_path; ?>/images/global/buttons/sbutton_red.gif)">
                                                                    <div onmouseover="MouseOverBigButton(this);"
                                                                         onmouseout="MouseOutBigButton(this);">
                                                                        <div class="BigButtonOver"
                                                                             style="background-image: url(<?= $template_path; ?>/images/global/buttons/sbutton_red_over.gif); visibility: hidden;"></div>
                                                                        <input name="auction_confirm"
                                                                               class="BigButtonText"
                                                                               type="button" value="Finished">
                                                                    </div>
                                                                </div>
                                                            </a></td>
                                                    <?php 
                                                } ?>
                                                <?php if ($Auction['status']== 1) { 
                                                    echo <<<HTML
                                                        <td>Finished</td>
                                                        HTML;
                                                    } elseif ($Auction['status'] == 2) {
                                                    echo <<<HTML
                                                    <td>Cancelled</td>
                                                    HTML;
                                                    } else{
                                                        echo <<<HTML
                                                        <td>Open</td>
                                                        HTML;
                                                    }
                                                    ?>
                                                </tr>
                                                <?php
                                            }
                                        }
                                        ?>
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
