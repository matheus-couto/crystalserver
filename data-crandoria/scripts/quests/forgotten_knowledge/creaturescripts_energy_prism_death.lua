local energyPrismDeath = CreatureEvent("EnergyPrismDeath")

function energyPrismDeath.onKill(creature, target)
	stopEvent(Storage.Quest.U11_02.ForgottenKnowledge.LloydEvent)
	local tile = Tile(Position(4933, 4734, 15))
	if not tile then
		return false
	end
	local lloyd = tile:getTopCreature()
	if lloyd then
		lloyd:teleportTo(Position(4933, 4737, 15))
		lloyd:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
end

energyPrismDeath:register()
