local teleportArea = {
    fromPosition = Position(4543, 4596, 15), -- Posição do canto inferior esquerdo da área
    toPosition = Position(4564, 4615, 15) -- Posição do canto superior direito da área
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

local function teleportPlayers(player1, player2)
    if not player1 or not player2 then
        return
    end

    local pos1 = player1:getPosition()
    local pos2 = player2:getPosition()

    player1:teleportTo(pos2)
    player2:teleportTo(pos1)
end

local function onSpellCast(creature, variant)
    local caster = Creature(creature)
    if not caster then
        return false
    end

    local randomPlayer = getRandomPlayerInRange()
    if randomPlayer then
        teleportPlayers(caster, randomPlayer)
        caster:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        randomPlayer:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    end

    return true
end

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
    return onSpellCast(creature, variant)
end

spell:name("Crazy Hat Teleporter")
spell:words("###732")
spell:needLearn(true)
spell:cooldown("2000")
spell:isSelfTarget(true)
spell:register()
