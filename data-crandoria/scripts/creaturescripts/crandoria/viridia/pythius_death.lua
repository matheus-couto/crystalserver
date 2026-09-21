local function removeTeleport(position)
	local teleportItem = Tile(position):getItemById(1949)
	if teleportItem then
		teleportItem:remove()
		position:sendMagicEffect(CONST_ME_POFF)
	end
end

local pythius = CreatureEvent("PythiusDeath")
function pythius.onKill(creature, target)
	local targetMonster = target:getMonster()
	if not target or not targetMonster or targetMonster:getName():lower() ~= "pythius the rotten" then
		return true
	end

	local position = targetMonster:getPosition()
	position:sendMagicEffect(CONST_ME_TELEPORT)
	local item = Game.createItem(1949, 1, position)
	local teleportToPosition = Position(4557, 5537, 11)
	if item:isTeleport() then
		item:setDestination(teleportToPosition)
	end
	targetMonster:say("Você derrotou Pythius. Entre no teleport antes que ele desapareca!", TALKTYPE_MONSTER_SAY, 0, 0, position)
	--remove portal after 2 min
	addEvent(removeTeleport, 2 * 60 * 1000, position)

	--clean arena of monsters
	local spectators, spectator = Game.getSpectators(Position(4564, 5557, 11), false, false, 10, 10, 10, 10)
	for i = 1, #spectators do
		spectator = spectators[i]
		if spectator:isMonster() then
			spectator:getPosition():sendMagicEffect(CONST_ME_POFF)
			spectator:remove()
		end
	end
	return true
end

pythius:register()
