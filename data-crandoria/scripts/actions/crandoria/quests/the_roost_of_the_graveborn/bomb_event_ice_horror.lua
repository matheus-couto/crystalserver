local config = {
    fromPos = Position(4544, 4873, 9),
    toPos = Position(4567, 4919, 9),

    targetItemId = 51884,
    explosionItemId = 51883,

    targetDelay = 2000, -- 2 segundos até a explosão
    interval = 5000, -- ativa a cada 5 segundos

    explosionDamage = 650,
    explosionEffect = CONST_ME_FIREAREA,
}

local explosionArea = createCombatArea(AREA_CIRCLE2X2)


local function isInsideArea(pos)
    return pos.z == config.fromPos.z
        and pos.x >= config.fromPos.x
        and pos.x <= config.toPos.x
        and pos.y >= config.fromPos.y
        and pos.y <= config.toPos.y
end


local function getRandomTargetPosition(player)
    local playerPos = player:getPosition()
    local positions = {}

    for dx = -1, 1 do
        for dy = -1, 1 do
            if not (dx == 0 and dy == 0) then
                local pos = Position(
                    playerPos.x + dx,
                    playerPos.y + dy,
                    playerPos.z
                )

                if isInsideArea(pos) then
                    local tile = Tile(pos)

                    if tile
                        and not tile:hasFlag(TILESTATE_BLOCKSOLID)
                        and not tile:getTopCreature()
                    then
                        table.insert(positions, pos)
                    end
                end
            end
        end
    end

    if #positions == 0 then
        return nil
    end

    return positions[math.random(#positions)]
end


local function explodeTarget(position)
    local tile = Tile(position)

    if tile then
        local targetItem = tile:getItemById(config.targetItemId)

        if targetItem then
            targetItem:remove()
        end
    end

    -- Explosão visual + dano
    doAreaCombatHealth(
        0,
        COMBAT_AGONYDAMAGE,
        position,
        explosionArea,
        -config.explosionDamage,
        -config.explosionDamage,
        config.explosionEffect
    )

    -- Cria o item deixado pela explosão
    local hole = Game.createItem(config.explosionItemId, 1, position)
    if hole then
        addEvent(function()
            hole:remove()
        end, 8000)
    end
end


local function activateTarget()
    local players = {}

    for _, player in ipairs(Game.getPlayers()) do
        local pos = player:getPosition()

        if isInsideArea(pos) then
            table.insert(players, player)
        end
    end

    if #players == 0 then
        return
    end

    -- Escolhe um jogador aleatoriamente
    local player = players[math.random(#players)]

    local targetPosition = getRandomTargetPosition(player)

    if not targetPosition then
        return
    end

    -- Cria o alvo
    Game.createItem(config.targetItemId, 1, targetPosition)

    -- Explode após 2 segundos
    addEvent(function()
        explodeTarget(targetPosition)
    end, config.targetDelay)
end


local globalEvent = GlobalEvent("IceHorrorTargets")

function globalEvent.onThink(interval)
    activateTarget()
    return true
end

globalEvent:interval(config.interval)
globalEvent:register()