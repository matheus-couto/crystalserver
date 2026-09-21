local function removeTeleport(position)
	local teleportItem = Tile(position):getItemById(1949)
	if teleportItem then
		teleportItem:remove()
		position:sendMagicEffect(CONST_ME_POFF)
	end
end

local ahau = CreatureEvent("Ahau")
function ahau.onKill(creature, target)
	local targetMonster = target:getMonster()
	if not target or not targetMonster or targetMonster:getName():lower() ~= "ahau" then
		return true
	end

	local position = targetMonster:getPosition()
	position:sendMagicEffect(CONST_ME_TELEPORT)
	local item = Game.createItem(1949, 1, position)
	local teleportToPosition = Position(5570, 5119, 15)
	if item:isTeleport() then
		item:setDestination(teleportToPosition)
	end
	targetMonster:say("You have 2 minutes to enter the teleport and claim your reward", TALKTYPE_MONSTER_SAY, 0, 0, position)
	--remove portal after 2 min
	addEvent(removeTeleport, 2 * 60 * 1000, position)

	--clean arena of monsters
	local spectators, spectator = Game.getSpectators(Position(5492, 5150, 15), false, false, 10, 10, 10, 10)
	for i = 1, #spectators do
		spectator = spectators[i]
		if spectator:isMonster() then
			spectator:getPosition():sendMagicEffect(CONST_ME_POFF)
			spectator:remove()
		end
		if spectator:isPlayer() then
			if spectator:getStorageValue(Storage.Quest.Crandoria.BossTasks.Boss) == 5 and spectator:getStorageValue(Storage.Quest.Crandoria.BossTasks.Count) < 1 then
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

ahau:register()
