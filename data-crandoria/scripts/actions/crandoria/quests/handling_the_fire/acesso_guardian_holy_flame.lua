local leverConfig = {
    leverId = 8911,
    leverPosition = Position(5220, 5458, 11),
    portalId = 22761,
    portalPosition = Position(5217, 5458, 11),
    destinationPosition = Position(5247, 5417, 11),
    creatureNames = {"Rage Squid", "Burning Book", "Knight of the Holy Flame"},
    leverAid = 12304,
    portalDuration = 30 -- tempo em segundos
}

local function hasCreatureInArea(fromPosition, toPosition, creatureNames)
    for x = fromPosition.x, toPosition.x do
        for y = fromPosition.y, toPosition.y do
            local pos = Position(x, y, fromPosition.z)
            local tile = Tile(pos)
            if tile then
                local creature = tile:getTopCreature()
                if creature and table.contains(creatureNames, creature:getName()) then
                    return true
                end
            end
        end
    end
    return false
end

local function removePortal()
    local portalTile = Tile(leverConfig.portalPosition)
    if portalTile and portalTile:getItemCountById(leverConfig.portalId) > 0 then
        portalTile:getItemById(leverConfig.portalId):remove()
        print("Portal removed.")
    end
end

local function createPortal()
    local portal = Game.createItem(leverConfig.portalId, 1, leverConfig.portalPosition)
    if portal then
        print("Portal created.")
        portal:setDestination(leverConfig.destinationPosition)
        addEvent(
            function()
                removePortal()
                local lever = Tile(leverConfig.leverPosition):getItemById(leverConfig.leverId + 1)
                if lever then
                    lever:transform(leverConfig.leverId)
                    print("Portal removed and lever reset.")
                end
            end,
            leverConfig.portalDuration * 1000
        )
    end
end

local leverOn = Action()

function leverOn.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    print("Lever used.")
    if not hasCreatureInArea(Position(5215, 5450, 11), Position(5234, 5464, 11), leverConfig.creatureNames) then
        print("No creatures in the area.")
        if item:getId() == leverConfig.leverId then
            createPortal()
            item:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
            item:transform(leverConfig.leverId + 1)
            print("Portal created.")
        end
    else
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "You cannot pull the lever while the creatures are present.")
    end

    return true
end

leverOn:aid(12304)
leverOn:register()
