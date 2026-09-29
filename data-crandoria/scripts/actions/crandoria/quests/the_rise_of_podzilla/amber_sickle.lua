local amberSickle = Action()
function amberSickle.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    if not player then
        return true
    end
    local chance = math.random(1, 8)

    local creaturePos1 = Position(toPosition.x, toPosition.y + 1, toPosition.z)
    local creaturePos2 = Position(toPosition.x + 1, toPosition.y, toPosition.z)
    local tile1 = Tile(creaturePos1)
    local tile2 = Tile(creaturePos3)
    local creature1 = tile1:getTopCreature()
    local creature2 = tile2:getTopCreature()

    if target.itemid == 45602 then
        if creature1 then
            if creature1:isMonster() and creature1:getName() == "Rootthing Buckler" then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "As raizes estao sendo protegidas pelo Rootthing Buckler.")
                return false
            end
        end
        toPosition:sendMagicEffect(CONST_ME_SLASH)
        target:transform(45603)
        addEvent(function()
            target:transform(45602)
        end, 45000)
        if chance == 1 then
            item:remove(1)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O item se partiu ao ser usado.")
        end
        return true
    elseif target.itemid == 45604 then
        if creature2 then
            if creature2:isMonster() and creature2:getName() == "Rootthing Buckler" then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "As raizes estao sendo protegidas pelo Rootthing Buckler.")
                return false
            end
        end
        toPosition:sendMagicEffect(CONST_ME_SLASH)
        target:transform(45605)
        addEvent(function()
            target:transform(45604)
        end, 45000)
        if chance == 1 then
            item:remove(1)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O item se partiu ao ser usado.")
        end
        return true
    end
    return true
end

amberSickle:id(48413)
amberSickle:register()