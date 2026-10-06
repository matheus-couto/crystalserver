local config = {
    monsterName = 'The Diamond Blossom',
    bossPosition = Position(5432, 4767, 12),
    centerPosition = Position(5432, 4771, 12),
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

local diamondBlossom = GlobalEvent("diamondBlossom")
function diamondBlossom.onThink(interval, lastExecution)
    if checkBoss(config.centerPosition, config.rangeX, config.rangeY, config.monsterName) then
        return true
    end

    local boss = Game.createMonster(config.monsterName, config.bossPosition, true, true)
    boss:setReward(true)
    return true
end

diamondBlossom:interval(1800000)
diamondBlossom:register()
