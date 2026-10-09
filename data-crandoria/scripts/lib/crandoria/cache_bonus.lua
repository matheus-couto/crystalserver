CollectionBonus = CollectionBonus or {}
CollectionBonus.cache = CollectionBonus.cache or {}

local PER_ITEM = 0.1       -- % por addon completo e por montaria
local MAX_PER_SOURCE = 5   -- teto de cada fonte, em %
local EMPTY = { exp = 0, loot = 0, skills = 0, outfits = 0, mounts = 0 }

function CollectionBonus.calculate(outfitCount, mountCount)
	local outfitBonus = math.min(outfitCount * PER_ITEM, MAX_PER_SOURCE)
	local mountBonus = math.min(mountCount * PER_ITEM, MAX_PER_SOURCE)
	local total = outfitBonus + mountBonus

	-- exp, loot e skills usam a mesma regra
	return {
		exp = total,
		loot = total,
		skills = total,
		outfits = outfitBonus,
		mounts = mountBonus,
	}
end

function CollectionBonus.set(player, outfitCount, mountCount)
	local bonus = CollectionBonus.calculate(outfitCount, mountCount)
	CollectionBonus.cache[player:getGuid()] = bonus
	return bonus
end

function CollectionBonus.get(player)
	return CollectionBonus.cache[player:getGuid()] or EMPTY
end

function CollectionBonus.load(player)
	local outfits = math.max(player:getStorageValue(Storage.Quest.Crandoria.AddonsBonus.BonusExp), 0)
	local mounts = math.max(player:getStorageValue(Storage.Quest.Crandoria.MountBonus.BonusExp), 0)
	return CollectionBonus.set(player, outfits, mounts)
end