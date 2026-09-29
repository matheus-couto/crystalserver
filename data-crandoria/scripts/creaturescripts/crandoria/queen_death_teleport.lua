local function removeTeleport(position)
	local teleportItem = Tile(position):getItemById(1949)
	if teleportItem then
		teleportItem:remove()
		position:sendMagicEffect(CONST_ME_POFF)
	end
end

-- onDeath no proprio boss, em vez de onKill no jogador: o onKill era chamado
-- em toda morte que qualquer jogador causava, so para conferir o nome e sair.
local timira = CreatureEvent("QueenofHearts")
function timira.onDeath(creature, corpse, killer, mostDamageKiller)
	if not getDeathCreditPlayer(mostDamageKiller) then
		return true
	end

	local position = creature:getPosition()
	position:sendMagicEffect(CONST_ME_TELEPORT)
	local item = Game.createItem(1949, 1, position)
	local teleportToPosition = Position(4459, 4572, 15)
	if item:isTeleport() then
		item:setDestination(teleportToPosition)
	end
	creature:say("Um portal foi aberto apos a Rainha ter sido derrotada. Rapido, entre no portal antes que ele desapareca!", TALKTYPE_MONSTER_SAY, 0, 0, position)
	--remove portal after 2 min
	addEvent(removeTeleport, 2 * 60 * 1000, position)

	--clean arena of monsters
	local spectators, spectator = Game.getSpectators(Position(4461, 4583, 15), false, false, 9, 9, 9, 9)
	for i = 1, #spectators do
		spectator = spectators[i]
		if spectator:isMonster() and spectator ~= creature then
			spectator:getPosition():sendMagicEffect(CONST_ME_POFF)
			spectator:remove()
		elseif spectator:isPlayer() then
			spectator:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress, 16)
			spectator:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Coelho, 1)
		end
	end
	return true
end

timira:register()

local startup = GlobalEvent("QueenofHeartsStartup")
function startup.onStartup()
	registerDeathEvent("QueenofHearts", { "The Abomination of Hearts" })
	return true
end
startup:register()
