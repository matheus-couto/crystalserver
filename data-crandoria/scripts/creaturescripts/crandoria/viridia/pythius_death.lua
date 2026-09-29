local function removeTeleport(position)
	local teleportItem = Tile(position):getItemById(1949)
	if teleportItem then
		teleportItem:remove()
		position:sendMagicEffect(CONST_ME_POFF)
	end
end

-- onDeath no proprio boss, em vez de onKill no jogador: o onKill era chamado
-- em toda morte que qualquer jogador causava, so para conferir o nome e sair.
local pythius = CreatureEvent("PythiusDeath")
function pythius.onDeath(creature, corpse, killer, mostDamageKiller)
	if not getDeathCreditPlayer(mostDamageKiller) then
		return true
	end

	local position = creature:getPosition()
	position:sendMagicEffect(CONST_ME_TELEPORT)
	local item = Game.createItem(1949, 1, position)
	local teleportToPosition = Position(4557, 5537, 11)
	if item:isTeleport() then
		item:setDestination(teleportToPosition)
	end
	creature:say("Você derrotou Pythius. Entre no teleport antes que ele desapareca!", TALKTYPE_MONSTER_SAY, 0, 0, position)
	--remove portal after 2 min
	addEvent(removeTeleport, 2 * 60 * 1000, position)

	--clean arena of monsters
	local spectators, spectator = Game.getSpectators(Position(4564, 5557, 11), false, false, 10, 10, 10, 10)
	for i = 1, #spectators do
		spectator = spectators[i]
		if spectator:isMonster() and spectator ~= creature then
			spectator:getPosition():sendMagicEffect(CONST_ME_POFF)
			spectator:remove()
		end
	end
	return true
end

pythius:register()

local startup = GlobalEvent("PythiusDeathStartup")
function startup.onStartup()
	registerDeathEvent("PythiusDeath", { "Pythius the Rotten" })
	return true
end
startup:register()
