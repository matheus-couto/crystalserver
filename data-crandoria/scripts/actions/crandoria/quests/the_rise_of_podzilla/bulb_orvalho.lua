local orvalhoBulbo = Action()
function orvalhoBulbo.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not player then
        return true
    end

    local storage = player:getStorageValue(Storage.Quest.Crandoria.TheRiseOfPodzilla.Progresso)
    local pos = player:getPosition()

    if pos.z >= 8 then
        if stoarge == 4 then
            player:addItem(48422, 1)
            item:transform(12416)
            addEvent(function()
                item:transform(12418)
            end, 30000)
        end
    end
    return true
end

orvalhoBulbo:id(12418)
orvalhoBulbo:register()