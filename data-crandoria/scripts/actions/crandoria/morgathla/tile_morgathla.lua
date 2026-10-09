local tileMorgathla = MoveEvent()

function tileMorgathla.onStepIn(creature, item, position, fromPosition)

    if not creature:isMonster() or creature:getName() ~= "Ancient Spawn of Morgathla" then
        return true
    end

    local storage = creature:getStorageValue(Storage.Quest.Crandoria.Morgathla.Health)
    if storage == 1 then
        creature:setStorageValue(Storage.Quest.Crandoria.Morgathla.Health, 0)
        item:transform(19387)
        addEvent(function()
            item:transform(19243)
        end, 20000)
    end
end

tileMorgathla:aid(13226)
tileMorgathla:register()