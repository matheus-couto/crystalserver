local function removeTeleport(position)
	local teleportItem = Tile(position):getItemById(1949)
	if teleportItem then
		teleportItem:remove()
		position:sendMagicEffect(CONST_ME_POFF)
	end
end

local suonDeath = CreatureEvent("SuonDeath")
function suonDeath.onKill(creature, target)
	local targetMonster = target:getMonster()
	if not target or not targetMonster or targetMonster:getName():lower() ~= "tormento de suon" then
		return true
	end

	if creature:isPlayer() then
		creature:teleportTo(Position(4496, 5479, 6))
		creature:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Progresso, 14)
		creature:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Timer, os.time() + 2 * 23 * 60 * 60)
		return true
	end


	--clean arena of monsters
	local spectators, spectator = Game.getSpectators(Position(4461, 5469, 14), false, false, 5, 5, 5, 5)
	for i = 1, #spectators do
		spectator = spectators[i]
		if spectator:isMonster() then
			spectator:getPosition():sendMagicEffect(CONST_ME_POFF)
			spectator:remove()
		end
	end
	return true
end

suonDeath:register()
