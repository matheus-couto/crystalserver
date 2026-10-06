local config = {
    monsterName = 'The Lily of Night',
    bossPosition = Position(5412, 4775, 12),
    centerPosition = Position(5412, 4779, 12),
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

local lilyofNight = GlobalEvent("lilyofNight")
function lilyofNight.onThink(interval, lastExecution)
    if checkBoss(config.centerPosition, config.rangeX, config.rangeY, config.monsterName) then
        return true
    end

    local boss = Game.createMonster(config.monsterName, config.bossPosition, true, true)
    boss:setReward(true)
    return true
end

lilyofNight:interval(1800000)
lilyofNight:register()
