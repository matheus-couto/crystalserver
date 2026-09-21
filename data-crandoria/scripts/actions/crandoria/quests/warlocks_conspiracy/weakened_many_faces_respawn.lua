
local config = {
    monsterName = 'Weakened Many Faces',
    bossPosition = Position(4687, 5047, 12),
    centerPosition = Position(4686, 5048, 12),
    rangeX = 15,
    rangeY = 15
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

local weakenedManyFaces = GlobalEvent("weakenedManyFaces")
function weakenedManyFaces.onThink(interval, lastExecution)
    if checkBoss(config.centerPosition, config.rangeX, config.rangeY, config.monsterName) then
        return true
    end

    local boss = Game.createMonster(config.monsterName, config.bossPosition, true, true)
    return true
end

weakenedManyFaces:interval(900000)
weakenedManyFaces:register()
