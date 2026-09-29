local function removeTeleport(position)
	local teleportItem = Tile(position):getItemById(1949)
	if teleportItem then
		teleportItem:remove()
		position:sendMagicEffect(CONST_ME_POFF)
	end
end

-- onDeath no proprio boss, em vez de onKill no jogador: o onKill era chamado
-- em toda morte que qualquer jogador causava, so para conferir o nome e sair.
local timira = CreatureEvent("Timira")
function timira.onDeath(creature, corpse, killer, mostDamageKiller)
	if not getDeathCreditPlayer(mostDamageKiller) then
		return true
	end

	local position = creature:getPosition()
	position:sendMagicEffect(CONST_ME_TELEPORT)
	local item = Game.createItem(1949, 1, position)
	local teleportToPosition = Position(5640, 4260, 9)
	if item:isTeleport() then
		item:setDestination(teleportToPosition)
	end
	creature:say("Timira died and left a teleport in her place! It will disappear in 2 minutes. Enter it!", TALKTYPE_MONSTER_SAY, 0, 0, position)
	--remove portal after 2 min
	addEvent(removeTeleport, 2 * 60 * 1000, position)

	--clean arena of monsters
	local spectators, spectator = Game.getSpectators(Position(5652, 4259, 9), false, false, 9, 9, 9, 9)
	for i = 1, #spectators do
		spectator = spectators[i]
		if spectator:isMonster() and spectator ~= creature then
			spectator:getPosition():sendMagicEffect(CONST_ME_POFF)
			spectator:remove()
		end
		if spectator:isPlayer() then
			if spectator:getStorageValue(Storage.Quest.Crandoria.BossTasks.Boss) == 6 and spectator:getStorageValue(Storage.Quest.Crandoria.BossTasks.Count) < 1 then
				spectator:setStorageValue(Storage.Quest.Crandoria.BossTasks.Count, 1)
				spectator:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou o boss para Thorwulf.")
			end
			local storageRep = spectator:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
			spectator:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
			spectator:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
		end
	end
	return true
end

timira:register()

local startup = GlobalEvent("TimiraStartup")
function startup.onStartup()
	registerDeathEvent("Timira", { "Timira the Many-Headed" })
	return true
end
startup:register()
