<?php
/**
 *
 * Char Bazaar
 *
 */
defined('MYAAC') or die('Direct access not allowed!');
$title = 'Current Auctions';

if ($logged) {
    $getAccountCoins = $db->query("SELECT `id`, `premdays`, `coins`, `coins_transferable` FROM `accounts` WHERE `id` = {$account_logged->getId()}");
    $getAccountCoins = $getAccountCoins->fetch();
    } else {
        $account_logged = null;
    }

// GET PAGES
$subtopic = $_GET['subtopic'] ?? null;
$getPageDetails = $_GET['details'] ?? null;
$getPageAction = $_GET['action'] ?? null;
// GET PAGES

/* CHAR BAZAAR CONFIG */
require_once SYSTEM . 'pages/char_bazaar/lib.php';
$charbazaar_buyer_fee = charbazaarBuyerFeePercent();
$charbazaar_create = charbazaarListingFee();
/* CHAR BAZAAR CONFIG END */

/* COUNTER CONFIG */
$showCounter = true;
/* COUNTER CONFIG END */

// // =====================================================
// // EXECUTA O PROCESSAMENTO SEMIAUTOMÁTICO DO BAZAAR
require SYSTEM . 'pages/char_bazaar/semifinishauction.php';
// // =====================================================

?>

<?php 
//ACCOUNT COINS TOP BOX
if ($logged) {
    require SYSTEM . 'pages/char_bazaar/coins_balance.php';
} 
//ACCOUNT COINS TOP BOX
?>

<?php
//FIRST PAGE - SHOW AUCTIONS
if (!$getPageDetails) {
    if (!$logged) {
        ?>
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
                        <table style="width: 100%;">
                            <tbody>
                            <tr>
                                <td>
                                    <div style="float: right;">
                                        <a href="?account/manage" target="_self" rel="noreferrer">
                                            <div class="BigButton"
                                                style="background-image:url(<?= $template_path; ?>/images/global/buttons/sbutton.gif)">
                                                <div onmouseover="MouseOverBigButton(this);"
                                                    onmouseout="MouseOutBigButton(this);">
                                                    <div class="BigButtonOver"
                                                        style="background-image: url(<?= $template_path; ?>/images/global/buttons/sbutton_over.gif); visibility: hidden;"></div>
                                                    <input name="auction_confirm" class="BigButtonText" type="button"
                                                        value="Login"></div>
                                            </div>
                                        </a>
                                    </div>
                                    <p><b>Use Tibia's character auction feature to sell or purchase Tibia characters without
                                            risk!</b></p>
                                    <p><b>Log in</b> to submit a bid to <b>purchase a Tibia character</b> from another
                                        player for your Tibia account!</p>
                                    <p>To <b>sell a Tibia character</b> from your account to another player, log into the
                                        <b>Tibia Client</b> and set up an auction.</p>
                                    <p>Note that Tibia characters can only be <b>purchased with transferable Tibia
                                            Coins!</b></p>
                                </td>
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
            <?php } else {
                        ?>
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
                        <table style="width: 100%;">
                            <tbody>
                            <tr>
                                <td>
                                    <p><b>Use Tibia's character auction feature to sell or purchase Tibia characters without
                                            risk!</b></p>
                                    <p>To <b>sell a Tibia character</b> from your account to another player, log into the
                                        <b>Tibia Client</b> and set up an auction.</p>
                                    <p>Note that Tibia characters can only be <b>purchased with transferable Tibia
                                            Coins!</b></p>
                                </td>
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
            <?php
            } 
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
                        <div class="Text">Current Auctions</div>
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
                <table class="Table3" cellspacing="0" cellpadding="0">
                    <tbody>
                    <tr>
                        <td>
                            <div class="InnerTableContainer">
                                <table style="width:100%;">
                                    <tbody>
                                    <?php if ($getPageAction != 'bid') {
                                    $subtopic = 'currentcharactertrades';
                                    $dateLimit = date('Y-m-d H:i:s');
                                    $auctions = $db->query("SELECT `id`, `account_old`, `account_new`, `player_id`, `price`, `date_end`, `date_start`, `bid_account`, `bid_price`, `status` FROM `myaac_charbazaar` WHERE `date_end` >= '{$dateLimit}' ORDER BY `date_start` DESC");
                                    //Exibe alerta se não houver nenhuma auction existente no momento
                                    if ($auctions->rowCount() == 0) {
                                            echo <<<HTML
                                            <tr>
                                                <td colspan="100%" style="text-align: center; padding: 20px;">
                                                    <p style="color: #b32d2d; font-weight: bold; margin: 0;">
                                                        There are no auctions yet, but how about creating your own? 
                                                        <a href="?createcharacterauction">it's simple!</a>
                                                    </p>
                                                </td>
                                            </tr>
                                            HTML;
                                        } else {
                                            require SYSTEM . 'pages/char_bazaar/list_auctions.php';
                                        }
                                    } else {
                                    //Exibe apenas a auction com o personagem alvo da bid
                                    $subtopic = 'currentcharactertrades';
                                    $dateLimit = date('Y-m-d H:i:s');
                                    $auctions = $db->query("SELECT `id`, `account_old`, `account_new`, `player_id`, `price`, `date_end`, `date_start`, `bid_account`, `bid_price`, `status` FROM `myaac_charbazaar` WHERE `id` = " . (int) $_POST['auction_iden']);
                                    $auctions = $auctions->fetchAll(); //Garante que continuará sendo array
                                    require SYSTEM . 'pages/char_bazaar/list_auctions.php';
                                    
                                    }?>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
    <?php } 
    //FIRST PAGE - SHOW AUCTIONS END
    ?>



<?php
// AUCTION DETAILS -->
if ($getPageDetails) {
    require SYSTEM . 'pages/char_bazaar/details.php';
} 
//AUCTION DETAILS END
?>


<?php
if ($getPageAction == 'bid') {

    $Auction_iden = (int)($_POST['auction_iden'] ?? 0);
    // (int): o valor e impresso na pagina e num input hidden.
    $Auction_maxbid = (int)($_POST['maxbid'] ?? 0);
    $Auction_fee = charbazaarBuyerFee($Auction_maxbid);
    $Auction_total = $Auction_maxbid + $Auction_fee;

    /* GET INFO CHARACTER */
    $getAuction = $db->query('SELECT `id`, `account_old`, `account_new`, `player_id`, `price`, `date_end`, `date_start`, `bid_account`, `bid_price`, `status` FROM `myaac_charbazaar` WHERE `id` = ' . $Auction_iden);
    $getAuction = $getAuction->fetch();
    /* GET INFO CHARACTER END */

    if ($getAuction && ((int)$getAuction['status'] !== CHARBAZAAR_STATUS_OPEN || strtotime($getAuction['date_end']) <= time())) {
        charbazaarMessage('Este leilão já foi encerrado.');
        $getAuction = false;
    }

    if ($logged && $getAuction && $getAuction['account_old'] != $account_logged->getId()) {


        /* GET INFO CHARACTER */
        $getCharacter = $db->query('SELECT `name`, `vocation`, `level`, `sex` FROM `players` WHERE `id` = ' . $getAuction['player_id'] . '');
        $character = $getCharacter->fetch();
        /* GET INFO CHARACTER END */

        if ($logged) {
            $getAccount = $db->query("SELECT `id`, `premdays`, `coins`, `coins_transferable` FROM `accounts` WHERE `id` = {$account_logged->getId()}");
            $getAccount = $getAccount->fetch();
        }

        /* CONVERT SEX */
        $character_sex = $config['genders'][$character['sex']];
        /* CONVERT SEX END */

        /* CONVERT VOCATION */
        $character_voc = $config['vocations'][$character['vocation']];
        /* CONVERT VOCATION END */

        if ($Auction_total > $getAccount['coins_transferable']) {
            $Verif_CoinsAcc = 'false';
        } else {
            $Verif_CoinsAcc = 'true';
        }

        // Sem lances o minimo e o preco inicial; com lances, o maior lance + 1.
        $Auction_minimum = (int)$getAuction['bid_account'] > 0 ? (int)$getAuction['bid_price'] + 1 : (int)$getAuction['price'];
        if ($Auction_maxbid >= $Auction_minimum) {
            $Verif_Price = 'true';
        } else {
            $Verif_Price = 'false';
        }
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
                    <div class="Text">You account</div>
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
                                                    <td style="font-weight:normal;"><?= $getAccount['coins'] ?>
                                                        <img
                                                            src="<?= $template_path; ?>/images/account/icon-tibiacoin.png">
                                                        (<?= $getAccount['coins_transferable'] ?> <img
                                                            src="<?= $template_path; ?>/images/account/icon-tibiacointrusted.png">)
                                                    </td>
                                                    <td style="font-weight:normal;"><?= $charbazaar_buyer_fee ?>% buyer fee,
                                                        paid only by the winner.
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
        <br>
        <div class="CharacterDetailsBlock">
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
                        <div class="Text">Confirm Bid For Auction</div>
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
                <table class="Table1" cellspacing="0" cellpadding="0">
                    <tbody>
                    <tr>
                        <td>
                            <div class="InnerTableContainer">
                                <table style="width:100%;">
                                    <tbody>
                                    <tr>
                                        <td><br>Do you really want to bid the following amount for the character listed
                                            below:
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <br>
                                            <table style="width:50%;">
                                                <tbody>
                                                <?php
                                                if ($Verif_Price == 'true' and $Verif_CoinsAcc == 'true') {
                                                    ?>
                                                    <tr>
                                                        <td style="font-weight: bold;">Your Bid:</td>
                                                        <td><?= $Auction_maxbid ?> <img
                                                                src="<?= $template_path; ?>/images/account/icon-tibiacointrusted.png"
                                                                class="VSCCoinImages" title="Transferable Tibia Coins">
                                                        </td>
                                                    </tr>
                                                <?php } else { ?>
                                                    <tr>
                                                        <td style="font-weight: bold; color: red;">Your Bid:</td>
                                                        <td style="font-weight: bold; color: red;"><?= $Auction_maxbid ?>
                                                            <img
                                                                src="<?= $template_path; ?>/images/account/icon-tibiacointrusted.png"
                                                                class="VSCCoinImages" title="Transferable Tibia Coins">
                                                        </td>
                                                    </tr>
                                                <?php } ?>
                                                <tr>
                                                    <td style="font-weight: bold;">Character:</td>
                                                    <td><?= $character['name'] ?></td>
                                                </tr>
                                                <tr>
                                                    <td style="font-weight: bold;">Level:</td>
                                                    <td><?= $character['level'] ?></td>
                                                </tr>
                                                <tr>
                                                    <td style="font-weight: bold;">Profession:</td>
                                                    <td><?= $character_voc ?></td>
                                                </tr>
                                                </tbody>
                                            </table>

                                        </td>
                                    </tr>

                                    <tr>
                                        <td><br>If you confirm this bid, your bid plus a <b><?= $charbazaar_buyer_fee ?>% buyer fee</b>
                                            (<b><?= $Auction_fee ?></b> <img
                                                src="<?= $template_path; ?>/images//account/icon-tibiacointrusted.png"
                                                class="VSCCoinImages" title="Transferable Tibia Coins">), a total of <b><?= $Auction_total ?></b> <img
                                                src="<?= $template_path; ?>/images//account/icon-tibiacointrusted.png"
                                                class="VSCCoinImages" title="Transferable Tibia Coins"> transferable
                                            Tibia Coins, will be reserved from your account's balance.
                                            <br>
                                            If <b>someone places a higher bid than you</b>, the bid and the fee are <b>fully returned</b> to your account.
                                            The fee is only kept if you win the auction.
                                            <?php if (charbazaarExtensionMinutes() > 0) { ?>
                                                <br>
                                                A bid placed in the last <b><?= charbazaarExtensionMinutes() ?> minutes</b> extends the auction to <?= charbazaarExtensionMinutes() ?> minutes from that bid.
                                            <?php } ?>
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
        </div>
        <br>
        <?php
        if ($Verif_Price == 'false') {
            ?>
            <div class="TableContainer">
                <div class="CaptionContainer">
                    <div class="CaptionInnerContainer">
                        <span class="CaptionEdgeLeftTop"
                              style="background-image:url(<?= $template_path; ?>/images/content/box-frame-edge.gif);"></span>
                        <span class="CaptionEdgeRightTop"
                              style="background-image:url(<?= $template_path; ?>/images/content/box-frame-edge.gif);"></span>
                        <span class="CaptionBorderTop"
                              style="background-image:url(<?= $template_path; ?>/images/content/table-headline-border.gif);"></span>
                        <span class="CaptionVerticalLeft"
                              style="background-image:url(<?= $template_path; ?>/images/content/box-frame-vertical.gif);"></span>
                        <div class="Text">Erro</div>
                        <span class="CaptionVerticalRight"
                              style="background-image:url(<?= $template_path; ?>/images/content/box-frame-vertical.gif);"></span>
                        <span class="CaptionBorderBottom"
                              style="background-image:url(<?= $template_path; ?>/images/content/table-headline-border.gif);"></span>
                        <span class="CaptionEdgeLeftBottom"
                              style="background-image:url(<?= $template_path; ?>/images/content/box-frame-edge.gif);"></span>
                        <span class="CaptionEdgeRightBottom"
                              style="background-image:url(<?= $template_path; ?>/images/content/box-frame-edge.gif);"></span>
                    </div>
                </div>
                <table class="Table1" cellspacing="0" cellpadding="0">

                    <tbody>
                    <tr>
                        <td>
                            <div class="InnerTableContainer">
                                <table style="width:100%;">
                                    <tbody>
                                    <tr>
                                        <td>Your bid is lower than the last one.</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <br>
        <?php } ?>
        <?php
        if ($Verif_CoinsAcc == 'false') {
            ?>
            <div class="TableContainer">
                <div class="CaptionContainer">
                    <div class="CaptionInnerContainer">
                        <span class="CaptionEdgeLeftTop"
                              style="background-image:url(<?= $template_path; ?>/images/content/box-frame-edge.gif);"></span>
                        <span class="CaptionEdgeRightTop"
                              style="background-image:url(<?= $template_path; ?>/images/content/box-frame-edge.gif);"></span>
                        <span class="CaptionBorderTop"
                              style="background-image:url(<?= $template_path; ?>/images/content/table-headline-border.gif);"></span>
                        <span class="CaptionVerticalLeft"
                              style="background-image:url(<?= $template_path; ?>/images/content/box-frame-vertical.gif);"></span>
                        <div class="Text">Erro</div>
                        <span class="CaptionVerticalRight"
                              style="background-image:url(<?= $template_path; ?>/images/content/box-frame-vertical.gif);"></span>
                        <span class="CaptionBorderBottom"
                              style="background-image:url(<?= $template_path; ?>/images/content/table-headline-border.gif);"></span>
                        <span class="CaptionEdgeLeftBottom"
                              style="background-image:url(<?= $template_path; ?>/images/content/box-frame-edge.gif);"></span>
                        <span class="CaptionEdgeRightBottom"
                              style="background-image:url(<?= $template_path; ?>/images/content/box-frame-edge.gif);"></span>
                    </div>
                </div>
                <table class="Table1" cellspacing="0" cellpadding="0">

                    <tbody>
                    <tr>
                        <td>
                            <div class="InnerTableContainer">
                                <table style="width:100%;">
                                    <tbody>
                                    <tr>
                                        <td>You don't have enough coins to bid.</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <br>
        <?php } ?>


        <div style="width: 100%; text-align: center; display: flex; justify-content: center;">
            <?php
            if ($Verif_Price == 'true' && $Verif_CoinsAcc == 'true') {
                ?>
                <script>
                    var myModalFinishBid = document.getElementById('ModalOpenFinishBid')
                    var myInputFinishBid = document.getElementById('ModalInputFinishBid')
                    myModalFinishBid.addEventListener('shown.bs.modal', function () {
                        myInputFinishBid.focus()
                    })
                </script>
                <form method="post" action="?subtopic=currentcharactertrades&action=bidfinish">
                <input type="hidden" name="bid_iden" value="<?= $getAuction['id'] ?>">
                <?= charbazaarCsrfField() ?>
                <input type="hidden" name="bid_max" value="<?= $Auction_maxbid ?>">
                <div class="BigButton"
                     style="background-image:url(<?= $template_path; ?>/images/global/buttons/sbutton_green.gif)">
                    <div onmouseover="MouseOverBigButton(this);" onmouseout="MouseOutBigButton(this);">
                        <div class="BigButtonOver"
                             style="background-image: url(<?= $template_path; ?>/images/global/buttons/sbutton_green_over.gif); visibility: hidden;">
                            </div>
                        <input name="bid_confirm" class="BigButtonText" type="submit" value="Submit Bid"
                               data-bs-toggle="modal" data-bs-target="#ModalOpenFinishBid"></div>
                </div>
                </form>
                <div class="modal fade" id="ModalOpenFinishBid" data-bs-backdrop="static" data-bs-keyboard="false"
                     tabindex="-1" aria-labelledby="ModalOpenFinishBidLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
        <h5 class="modal-title" id="ModalOpenFinishBidLabel">You bid created!</h5>
		<img src="<?= $template_path; ?>/images/content/circle-symbol-minus.gif" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
      </div>
                            <div class="modal-body">
                                <div style="width: 100%; display: flex; justify-content: center; align-items: center;">
                                    <img src="<?= $template_path; ?>/images/charactertrade/confirm.gif"> <span
                                        style="font-weight: bold; font-size: 16px; padding-left: 10px; text-align: left; color: #ffffff">You submitted a bid successfully.<br><small
                                            style="font-weight: 100;">You will be redirected in a few moments.</small></span>
                                </div>
                            </div>
                            <div class="modal-footer">
                                    <div class="BigButton"
                                         style="background-image:url(<?= $template_path; ?>/images/global/buttons/sbutton_green.gif)">
                                        <div onmouseover="MouseOverBigButton(this);"
                                             onmouseout="MouseOutBigButton(this);">
                                            <div class="BigButtonOver"
                                                 style="background-image: url(<?= $template_path; ?>/images/global/buttons/sbutton_green_over.gif);visibility: hidden;"></div>
                                            <input name="bid_confirm" class="BigButtonText" type="submit" value="Exit">
                                        </div>
                                    </div>
                            </div>
                        </div>
                    </div>
                </div>
            <?php } ?>
            <a href="?subtopic=currentcharactertrades" style="margin-left: 3px">
                <div class="BigButton"
                     style="background-image:url(<?= $template_path; ?>/images/global/buttons/sbutton_red.gif)">
                    <div onmouseover="MouseOverBigButton(this);" onmouseout="MouseOutBigButton(this);">
                        <div class="BigButtonOver"
                             style="background-image: url(<?= $template_path; ?>/images/global/buttons/sbutton_red_over.gif); visibility: hidden;"></div>
                        <input class="BigButtonText" type="button" value="Cancel"></div>
                </div>
            </a>
        </div>

        <?php
    }
}
?>


<?php
//REGISTRO NA DB
//
// Tudo dentro de uma transacao que trava a linha da auction (FOR UPDATE): dois
// lances ao mesmo tempo nao leem o mesmo "maior lance" e o lance anterior nao e
// devolvido duas vezes. O mesmo lock e usado pela finalizacao, entao nenhum lance
// entra numa auction que esta sendo encerrada.
//
// Fica reservado lance + taxa do comprador. Quem for coberto recebe os dois de
// volta; o vencedor paga a taxa e o lance vai inteiro para o vendedor.
if ($getPageAction == 'bidfinish') {

    if (isset($_POST['bid_confirm']) && !empty($_POST['bid_max']) && $logged) {
        $idLogged = (int)$account_logged->getId();
        $bid_iden = (int)($_POST['bid_iden'] ?? 0);
        $bid_max = (int)$_POST['bid_max'];
        $bidError = null;

        if (!charbazaarCsrfValid()) {
            $bidError = 'Sessão expirada. Abra o leilão e dê o lance novamente.';
        } elseif ($bid_iden <= 0 || $bid_max <= 0 || $bid_max > CHARBAZAAR_MAX_PRICE) {
            $bidError = 'Dados inválidos fornecidos.';
        }

        if (!$bidError) {
            $db->beginTransaction();
            try {
                $getAuction = $db->query("SELECT `id`, `account_old`, `price`, `date_end`, `status` FROM `myaac_charbazaar` WHERE `id` = {$bid_iden} FOR UPDATE")->fetch();
                $topBid = $getAuction ? $db->query("SELECT `account_id`, `bid`, `fee` FROM `myaac_charbazaar_bid` WHERE `auction_id` = {$bid_iden} ORDER BY `bid` DESC LIMIT 1")->fetch() : false;
                $minimumBid = $topBid ? (int)$topBid['bid'] + 1 : ($getAuction ? (int)$getAuction['price'] : 0);
                $bidFee = charbazaarBuyerFee($bid_max);
                $totalCost = $bid_max + $bidFee;

                if (!$getAuction) {
                    $bidError = 'Leilão não encontrado.';
                } elseif ((int)$getAuction['status'] !== CHARBAZAAR_STATUS_OPEN || strtotime($getAuction['date_end']) <= time()) {
                    $bidError = 'Este leilão já foi encerrado.';
                } elseif ($idLogged === (int)$getAuction['account_old']) {
                    $bidError = 'Você não pode dar bid no seu próprio leilão.';
                } elseif ($bid_max < $minimumBid) {
                    $bidError = "Seu bid deve ser no mínimo {$minimumBid} coins.";
                } else {
                    // Devolve primeiro o lance anterior (lance + taxa reservada). Se
                    // o anterior for do proprio usuario, isso ja conta no saldo dele.
                    if ($topBid) {
                        charbazaarCreditCoins($db, (int)$topBid['account_id'], (int)$topBid['bid'] + (int)$topBid['fee']);
                    }

                    if (!charbazaarDebitCoins($db, $idLogged, $totalCost)) {
                        $bidError = "Saldo insuficiente. Necessário: {$totalCost} coins ({$bid_max} + {$bidFee} de taxa).";
                    } else {
                        // Anti-sniping: um lance nos ultimos minutos empurra o fim
                        // para dar tempo de quem foi coberto responder.
                        $newDateEnd = charbazaarExtendedEnd($getAuction['date_end']);
                        $dateEndSql = $newDateEnd ? ", `date_end` = '{$newDateEnd}'" : '';

                        $db->exec("UPDATE `myaac_charbazaar` SET `price` = {$bid_max}, `bid_account` = {$idLogged}, `bid_price` = {$bid_max}{$dateEndSql} WHERE `id` = {$bid_iden}");
                        $db->exec("INSERT INTO `myaac_charbazaar_bid` (`account_id`, `auction_id`, `bid`, `fee`) VALUES ({$idLogged}, {$bid_iden}, {$bid_max}, {$bidFee})");
                    }
                }

                if ($bidError) {
                    // Desfaz a devolucao do lance anterior, se houve.
                    $db->rollback();
                } else {
                    $db->commit();
                }
            } catch (Exception $e) {
                $db->rollback();
                error_log('Erro ao registrar bid: ' . $e->getMessage());
                $bidError = 'Erro interno. Tente novamente.';
            }
        }

        if ($bidError) {
            charbazaarMessage($bidError);
            return;
        }

        header('Location: ' . BASE_URL . '?subtopic=currentcharactertrades');
    }
}
?>

<?php
//DESATIVADO - Atualmente está sem uso devido ao bazaar semiauto
//Remova os comentários abaixo e desative a mecânica para reestabelecer o uso.
// if ($getPageAction == 'finish') {
//     $auction_iden = $_POST['auction_iden'];

//     /* GET INFO AUCTION */
//     $getAuction = $db->query("SELECT `id`, `account_old`, `account_new`, `player_id`, `price`, `date_end`, `date_start`, `bid_account`, `status` FROM `myaac_charbazaar` WHERE `id` = {$db->quote($auction_iden)}");
//     $getAuction = $getAuction->fetch();
//     /* GET INFO AUCTION END */

//     /* GET INFO BID */
//     $getBid = $db->query("SELECT `id`, `account_id`, `auction_id`, `bid`, `date` FROM `myaac_charbazaar_bid` WHERE `auction_id` = {$getAuction['id']}");
//     $getBid = $getBid->fetch();
//     /* GET INFO BID END */

//     /* GET COINS VENDEDOR */
//     $getCoinsVendedor = $db->query("SELECT `id`, `premdays`, `coins`, `coins_transferable` FROM `accounts` WHERE `id` = {$getAuction['account_old']}");
//     $getCoinsVendedor = $getCoinsVendedor->fetch();
    /* GET COINS VENDEDOR END */

//    $auction_taxacoins = $getBid['bid'] / 100;
//    $auction_taxacoins = $auction_taxacoins * $config['bazaar_tax'];
//    $auction_finalcoins = $getBid['bid'] - $auction_taxacoins;
    // $sellerCoins = $getCoinsVendedor['coins_transferable'] + ($getBid['bid'] - (($getBid['bid'] / 100) * $charbazaar_tax));
    // $db->exec("UPDATE `accounts` SET `coins_transferable` = {$sellerCoins} WHERE `id` = {$getAuction['account_old']}"); // adiciona os coins ao vendedor

    // $account_new = $getBid['account_id'];

    // $db->exec("UPDATE `players` SET `account_id` = {$account_new} WHERE `id` = {$getAuction['player_id']}"); // muda o player de conta
    // $db->exec("UPDATE `myaac_charbazaar` SET `status` = 1, `account_new` = {$account_new} WHERE `id` = {$getAuction['id']}"); // muda status da auction

    // header('Location: ' . BASE_URL . '?account/manage');
// }
// ?>
