local teleportArea = {
    fromPosition = Position(4549, 5095, 14), -- Posição do canto inferior esquerdo da área
    toPosition = Position(4565, 5108, 14) -- Posição do canto superior direito da área
}

local teleportPositions = {
    Position(4552, 5098, 14),
    Position(4552, 5104, 14),
    Position(4561, 5104, 14),
    Position(4561, 5098, 14)
}

local function getRandomPlayerInRange()
    local playersInRange = {}
    for _, player in ipairs(Game.getPlayers()) do
        if player:getPosition():isInRange(teleportArea.fromPosition, teleportArea.toPosition) then
            table.insert(playersInRange, player)
        end
    end
    if #playersInRange > 0 then
        local randomIndex = math.random(1, #playersInRange)
        return playersInRange[randomIndex]
    else
        return nil
    end
end

local function teleportPlayerToRandomPosition(player)
    if not player then
        return
    end

    local randomIndex = math.random(1, #teleportPositions)
    local randomPosition = teleportPositions[randomIndex]

    player:teleportTo(randomPosition)
    player:getPosition():sendMagicEffect(CONST_ME_GHOST_SMOKE)
    player:addHealth(-2000, COMBAT_DEATHDAMAGE)
    randomPosition:sendMagicEffect(CONST_ME_TELEPORT)
end

local function transformTileAfterTeleport()
    for _, position in ipairs(teleportPositions) do
        local tile = Tile(position)
        if tile then
            local transformTile = tile:getItemById(28454)
            if transformTile then
                transformTile:transform(28455)
                addEvent(function()
                    local originalTile = tile:getItemById(28455)
                    if originalTile then
                        originalTile:transform(28454)
                    end
                end, 15 * 1000) -- Transforma de volta após 30 segundos
            end
        end
    end
end

local function onSpellCast(creature, variant)
    local caster = Creature(creature)
    if not caster then
        return false
    end

    local randomPlayer = getRandomPlayerInRange()
    if randomPlayer then
        teleportPlayerToRandomPosition(randomPlayer)
        caster:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
        transformTileAfterTeleport()
    end

    return true
end

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
    return onSpellCast(creature, variant)
end

spell:name("zarabastan teleport")
spell:words("###734")
spell:needLearn(true)
spell:cooldown("2000")
spell:isSelfTarget(true)
spell:register()