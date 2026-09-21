-- The Rookie Guard Quest - Mission 03: A Rational Request

-- Mission Kills

local ratKill = CreatureEvent("VascalirRatKills")

function ratKill.onKill(player, target)
	if target:isPlayer() or target:getMaster() then
		return true
	end
	if not target:getName():lower() == "rat" then
		return true
	end
	if player:getStorageValue(Storage.Quest.U9_1.TheRookieGuard.Mission03) == 1 then
		local counter = player:getStorageValue(Storage.Quest.U9_1.TheRookieGuard.RatKills)
		if counter < 5 then
			player:setStorageValue(Storage.Quest.U9_1.TheRookieGuard.RatKills, counter + 1)
		end
	end
	return true
end

ratKill:register()
