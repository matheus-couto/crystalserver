--[[
Char Bazaar - finishes expired auctions from the game server.

The website (myacc/system/pages/char_bazaar/semifinishauction.php) does the same
when someone opens a bazaar page, which left a sold character sitting on the
vault account until somebody happened to visit the site. This runs every minute
regardless; the website's pass stays as a fallback for when the server is down.

Both can run at the same moment, so each auction is finished by ONE statement
guarded on `status` = 0: a multi-table UPDATE is atomic, and whichever side gets
the row first wins while the other one changes nothing. The website takes the row
with SELECT ... FOR UPDATE, which this statement waits on.

Money rules are the website's (char_bazaar/lib.php): the buyer's bid and buyer fee
were already taken when the bid was placed, so the seller receives the whole bid
and nothing else moves. The listing fee is never refunded.
]]

local STATUS_OPEN = 0
local STATUS_SOLD = 1
local STATUS_CLOSED = 2

local function notifyAccount(accountId, message)
	for _, player in ipairs(Game.getPlayers()) do
		if player:getAccountId() == accountId then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
		end
	end
end

local function topBid(auctionId)
	local resultId = db.storeQuery(string.format("SELECT `id`, `account_id`, `bid` FROM `myaac_charbazaar_bid` WHERE `auction_id` = %d ORDER BY `bid` DESC, `id` ASC LIMIT 1", auctionId))
	if not resultId then
		return nil
	end

	local bid = {
		id = Result.getNumber(resultId, "id"),
		accountId = Result.getNumber(resultId, "account_id"),
		amount = Result.getNumber(resultId, "bid"),
	}
	Result.free(resultId)

	return bid
end

local function auctionStatus(auctionId)
	local resultId = db.storeQuery(string.format("SELECT `status` FROM `myaac_charbazaar` WHERE `id` = %d", auctionId))
	if not resultId then
		return nil
	end

	local status = Result.getNumber(resultId, "status")
	Result.free(resultId)

	return status
end

-- `date_end` is re-checked inside the UPDATE: a bid placed in the last minutes
-- pushes it forward (anti-sniping), and that bid may land between the SELECT
-- below and this statement.
local function finishSold(auction, bid, now)
	db.query(string.format(
		"UPDATE `myaac_charbazaar` `c` "
			.. "JOIN `myaac_charbazaar_bid` `b` ON `b`.`id` = %d AND `b`.`auction_id` = `c`.`id` "
			.. "JOIN `players` `p` ON `p`.`id` = `c`.`player_id` "
			.. "JOIN `accounts` `s` ON `s`.`id` = `c`.`account_old` "
			.. "SET `c`.`status` = %d, `c`.`account_new` = `b`.`account_id`, "
			.. "`p`.`account_id` = `b`.`account_id`, `p`.`deletion` = 0, `p`.`charbazaar` = 0, "
			.. "`s`.`coins_transferable` = `s`.`coins_transferable` + `b`.`bid` "
			.. "WHERE `c`.`id` = %d AND `c`.`status` = %d AND `c`.`date_end` < '%s'",
		bid.id,
		STATUS_SOLD,
		auction.id,
		STATUS_OPEN,
		now
	))

	if auctionStatus(auction.id) == STATUS_SOLD then
		notifyAccount(auction.sellerId, string.format("[Char Bazaar] Your character %s was sold for %d Tibia Coins.", auction.name, bid.amount))
		notifyAccount(bid.accountId, string.format("[Char Bazaar] You won the auction for %s. The character is now on your account.", auction.name))
	end
end

local function finishUnsold(auction, now)
	db.query(string.format(
		"UPDATE `myaac_charbazaar` `c` "
			.. "JOIN `players` `p` ON `p`.`id` = `c`.`player_id` "
			.. "SET `c`.`status` = %d, `c`.`account_new` = `c`.`account_old`, "
			.. "`p`.`account_id` = `c`.`account_old`, `p`.`deletion` = 0, `p`.`charbazaar` = 0 "
			.. "WHERE `c`.`id` = %d AND `c`.`status` = %d AND `c`.`date_end` < '%s' "
			.. "AND NOT EXISTS (SELECT 1 FROM `myaac_charbazaar_bid` `b` WHERE `b`.`auction_id` = `c`.`id`)",
		STATUS_CLOSED,
		auction.id,
		STATUS_OPEN,
		now
	))

	if auctionStatus(auction.id) == STATUS_CLOSED then
		notifyAccount(auction.sellerId, string.format("[Char Bazaar] The auction for %s ended without bids. The character is back on your account.", auction.name))
	end
end

local charBazaarFinish = GlobalEvent("CharBazaarFinish")

function charBazaarFinish.onThink(interval)
	-- Same clock and format the website writes `date_end` with (both containers run
	-- on America/Sao_Paulo).
	local now = os.date("%Y-%m-%d %H:%M:%S")

	local auctions = {}
	local resultId = db.storeQuery(string.format("SELECT `c`.`id`, `c`.`account_old`, `p`.`name` FROM `myaac_charbazaar` `c` JOIN `players` `p` ON `p`.`id` = `c`.`player_id` " .. "WHERE `c`.`status` = %d AND `c`.`date_end` < '%s' LIMIT 50", STATUS_OPEN, now))
	if not resultId then
		return true
	end

	repeat
		auctions[#auctions + 1] = {
			id = Result.getNumber(resultId, "id"),
			sellerId = Result.getNumber(resultId, "account_old"),
			name = Result.getString(resultId, "name"),
		}
	until not Result.next(resultId)
	Result.free(resultId)

	for _, auction in ipairs(auctions) do
		local bid = topBid(auction.id)
		if bid then
			finishSold(auction, bid, now)
		else
			finishUnsold(auction, now)
		end
	end

	return true
end

charBazaarFinish:interval(60000)
charBazaarFinish:register()
