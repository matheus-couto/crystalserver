local function removeTeleport(position)
	local teleportItem = Tile(position):getItemById(1949)
	if teleportItem then
		teleportItem:remove()
		position:sendMagicEffect(CONST_ME_POFF)
	end
end

-- onDeath no proprio boss, em vez de onKill no jogador: o onKill era chamado
-- em toda morte que qualquer jogador causava, so para conferir o nome e sair.
local suonDeath = CreatureEvent("SuonDeath")
function suonDeath.onDeath(creature, corpse, killer, mostDamageKiller)
	local player = getDeathCreditPlayer(mostDamageKiller)
	if not player then
		return true
	end

	-- No onKill antigo o primeiro parametro era sempre o jogador, entao este
	-- ramo sempre retornava e a limpeza da arena abaixo nunca chegou a rodar.
	-- Mantido igual para nao mudar o comportamento da quest.
	player:teleportTo(Position(4496, 5479, 6))
	player:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Progresso, 14)
	player:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Timer, os.time() + 2 * 23 * 60 * 60)
	do return true end

	--clean arena of monsters
	local spectators, spectator = Game.getSpectators(Position(4461, 5469, 14), false, false, 5, 5, 5, 5)
	for i = 1, #spectators do
		spectator = spectators[i]
		if spectator:isMonster() and spectator ~= creature then
			spectator:getPosition():sendMagicEffect(CONST_ME_POFF)
			spectator:remove()
		end
	end
	return true
end

suonDeath:register()

local startup = GlobalEvent("SuonDeathStartup")
function startup.onStartup()
	registerDeathEvent("SuonDeath", { "Tormento de Suon" })
	return true
end
startup:register()
