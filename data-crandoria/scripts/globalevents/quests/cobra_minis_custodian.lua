local config = {
	monsterName = "Custodian",
	bossPosition = Position(5746, 4856, 8),
	centerPosition = Position(5746, 4856, 8),
	rangeX = 10,
	rangeY = 10,
}

local function checkBoss(centerPosition, rangeX, rangeY, bossName)
	local spectators, spec = Game.getSpectators(centerPosition, false, false, rangeX, rangeX, rangeY, rangeY)
	for i = 1, #spectators do
		spec = spectators[i]
		if spec:isMonster() then
			if spec:getName() == bossName then
				return true
			end
		end
	end
	return false
end

local miniBoss = GlobalEvent("custodian")
function miniBoss.onThink(interval, lastExecution)
	if checkBoss(config.centerPosition, config.rangeX, config.rangeY, config.monsterName) then
		return true
	end

	local boss = Game.createMonster(config.monsterName, config.bossPosition, true, true)
	boss:setReward(true)
	return true
end

miniBoss:interval(120 * 60 * 1000)
miniBoss:register()
