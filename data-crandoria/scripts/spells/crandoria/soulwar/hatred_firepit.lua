local spell = Spell("instant")

-- IDs em ordem de evolução
local itemSequence = {
    [34009] = 34010,
    [34010] = 34011,
    [34011] = 34012,
    [34012] = 34013
}

-- Posição do item a ser verificado e evoluído
local checkPos = Position(33743, 31599, 14)

function spell.onCastSpell(creature, variant)
    local tile = Tile(checkPos)
    if not tile then
        return false
    end

    for fromId, toId in pairs(itemSequence) do
        local item = tile:getItemById(fromId)
        if item then
            item:transform(toId)
            checkPos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
            return true
        end
    end

    return false
end

spell:name("hatred firepit")
spell:words("###751")
spell:isAggressive(false)
spell:needLearn(true)
spell:blockWalls(true)
spell:register()