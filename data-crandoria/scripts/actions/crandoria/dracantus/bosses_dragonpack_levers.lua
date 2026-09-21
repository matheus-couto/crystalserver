-- local leverMaliz = Action()

-- function leverMaliz.onUse(player, item, fromPosition, target, toPosition, isHotkey)

-- 	local storage = Game.getStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Maliz)

-- 	if storage < 1 then
-- 		Game.createMonster("Maliz", Position(4471, 4886, 12))
-- 		Game.setStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Maliz, 1)
-- 		return true
-- 	else
-- 		player:sendMagicEffect(CONST_ME_POFF)
-- 		return true
-- 	end
-- end

-- leverMaliz:aid(48000)
-- leverMaliz:register()


 
-- Nomes de todos os bosses do Dragon Pack, pra checar se algum já está vivo na sala
local dragonPackBossNames = { "Maliz", "Vengar", "Bruton", "Greedok", "Vilear", "Crultor", "Despor" }
 
-- Ajuste pros limites reais da sala do Dragon Pack
local specPos = {
	from = Position(4454, 4858, 12),
	to = Position(4487, 4898, 12)
}
 
local function isAnyDragonPackBossAlive(fromPosition, toPosition)
	local centerX = 4471
	local centerY = 4886
	local rangeX = 10
	local rangeY = 10
	local center = Position(centerX, centerY, 12)
 
	local spectators = Game.getSpectators(center, false, false, rangeX, rangeX, rangeY, rangeY)
	for _, creature in ipairs(spectators) do
		if creature:isMonster() then
			for _, name in ipairs(dragonPackBossNames) do
				if creature:getName() == name then
					return true, name
				end
			end
		end
	end
 
	return false
end

-------------------------------- MALIZ -----------------------------------------------------------------------
local leverMaliz = Action()
 
function leverMaliz.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local storage = Game.getStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Maliz)
 
	if storage >= 1 then
		player:sendMagicEffect(CONST_ME_POFF)
		return true
	end
 
	local alive, bossName = isAnyDragonPackBossAlive(specPos.from, specPos.to)
	if alive then
		player:sendCancelMessage(string.format("%s ainda esta vivo na sala. Derrote-o antes de invocar outro boss.", bossName))
		player:sendMagicEffect(CONST_ME_POFF)
		return true
	end
 
	Game.createMonster("Maliz", Position(4471, 4886, 12))
	Game.setStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Maliz, 1)
	return true
end
 
leverMaliz:aid(48000)
leverMaliz:register()

-------------------------------- VENGAR -----------------------------------------------------------------------
local leverVengar = Action()
 
function leverVengar.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local storage = Game.getStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Vengar)
 
	if storage >= 1 then
		player:sendMagicEffect(CONST_ME_POFF)
		return true
	end
 
	local alive, bossName = isAnyDragonPackBossAlive(specPos.from, specPos.to)
	if alive then
		player:sendCancelMessage(string.format("%s ainda esta vivo na sala. Derrote-o antes de invocar outro boss.", bossName))
		player:sendMagicEffect(CONST_ME_POFF)
		return true
	end
 
	Game.createMonster("Vengar", Position(4471, 4886, 12))
	Game.setStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Vengar, 1)
	return true
end

leverVengar:aid(48001)
leverVengar:register()


-------------------------------- BRUTON -----------------------------------------------------------------------
local leverBruton = Action()
 
function leverBruton.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local storage = Game.getStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Bruton)
 
	if storage >= 1 then
		player:sendMagicEffect(CONST_ME_POFF)
		return true
	end
 
	local alive, bossName = isAnyDragonPackBossAlive(specPos.from, specPos.to)
	if alive then
		player:sendCancelMessage(string.format("%s ainda esta vivo na sala. Derrote-o antes de invocar outro boss.", bossName))
		player:sendMagicEffect(CONST_ME_POFF)
		return true
	end
 
	Game.createMonster("Bruton", Position(4471, 4886, 12))
	Game.setStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Bruton, 1)
	return true
end

leverBruton:aid(48002)
leverBruton:register()


-------------------------------- GREEDOK -----------------------------------------------------------------------
local leverGreedok = Action()
 
function leverGreedok.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local storage = Game.getStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Greedok)
 
	if storage >= 1 then
		player:sendMagicEffect(CONST_ME_POFF)
		return true
	end
 
	local alive, bossName = isAnyDragonPackBossAlive(specPos.from, specPos.to)
	if alive then
		player:sendCancelMessage(string.format("%s ainda esta vivo na sala. Derrote-o antes de invocar outro boss.", bossName))
		player:sendMagicEffect(CONST_ME_POFF)
		return true
	end
 
	Game.createMonster("Greedok", Position(4471, 4886, 12))
	Game.setStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Greedok, 1)
	return true
end

leverGreedok:aid(48003)
leverGreedok:register()


-------------------------------- VILEAR -----------------------------------------------------------------------
local leverVilear = Action()
 
function leverVilear.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local storage = Game.getStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Vilear)
 
	if storage >= 1 then
		player:sendMagicEffect(CONST_ME_POFF)
		return true
	end
 
	local alive, bossName = isAnyDragonPackBossAlive(specPos.from, specPos.to)
	if alive then
		player:sendCancelMessage(string.format("%s ainda esta vivo na sala. Derrote-o antes de invocar outro boss.", bossName))
		player:sendMagicEffect(CONST_ME_POFF)
		return true
	end
 
	Game.createMonster("Vilear", Position(4471, 4886, 12))
	Game.setStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Vilear, 1)
	return true
end

leverVilear:aid(48004)
leverVilear:register()


-------------------------------- CRULTOR -----------------------------------------------------------------------
local leverCrultor = Action()
 
function leverCrultor.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local storage = Game.getStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Crultor)
 
	if storage >= 1 then
		player:sendMagicEffect(CONST_ME_POFF)
		return true
	end
 
	local alive, bossName = isAnyDragonPackBossAlive(specPos.from, specPos.to)
	if alive then
		player:sendCancelMessage(string.format("%s ainda esta vivo na sala. Derrote-o antes de invocar outro boss.", bossName))
		player:sendMagicEffect(CONST_ME_POFF)
		return true
	end
 
	Game.createMonster("Crultor", Position(4471, 4886, 12))
	Game.setStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Crultor, 1)
	return true
end

leverCrultor:aid(48005)
leverCrultor:register()


-------------------------------- DESPOR -----------------------------------------------------------------------
local leverDespor = Action()
 
function leverDespor.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local storage = Game.getStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Despor)
 
	if storage >= 1 then
		player:sendMagicEffect(CONST_ME_POFF)
		return true
	end
 
	local alive, bossName = isAnyDragonPackBossAlive(specPos.from, specPos.to)
	if alive then
		player:sendCancelMessage(string.format("%s ainda esta vivo na sala. Derrote-o antes de invocar outro boss.", bossName))
		player:sendMagicEffect(CONST_ME_POFF)
		return true
	end
 
	Game.createMonster("Despor", Position(4471, 4886, 12))
	Game.setStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Despor, 1)
	return true
end

leverDespor:aid(48006)
leverDespor:register()