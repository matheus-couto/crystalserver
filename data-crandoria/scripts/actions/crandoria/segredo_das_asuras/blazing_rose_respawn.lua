local config = {
    monsterName = 'The Blazing Rose',
    bossPosition = Position(5432, 4784, 12),
    centerPosition = Position(5432, 4788, 12),
    rangeX = 10,
    rangeY = 10
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

local blazingRose = GlobalEvent("blazingRose")
function blazingRose.onThink(interval, lastExecution)
    if checkBoss(config.centerPosition, config.rangeX, config.rangeY, config.monsterName) then
        return true
    end

    local boss = Game.createMonster(config.monsterName, config.bossPosition, true, true)
    boss:setReward(true)
    return true
end

blazingRose:interval(1800000)
blazingRose:register()
