local mallet = Action()

function mallet.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    if not player then
        return true
    end

    if player:getItemCount(27524) >= 1 and player:getItemCount(27525) >= 1 and player:getItemCount(27526) >= 1 then
        player:removeItem(27524, 1)
        player:removeItem(27525, 1)
        player:removeItem(27526, 1)
        player:addItem(27523, 1)
        fromPosition:sendMagicEffect(CONST_ME_HITAREA)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce montou uma marreta estranha...")
        return true
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao possui todas as pecas.")
        return true
    end

end

mallet:id(27524, 27525, 27526)


local storageSpawn = Game.getStorageValue("SpawnMorgathla")

local malletGong = Action()

function malletGong.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    local pos = Position(33693, 32385, 15)
    local tile = Tile()

    if target.itemid == 25768 and target:getPosition() == Position(33692, 32385, 15) then
        if getMonstersInArea(Position(33703, 32365, 15), Position(33740, 32383, 15), "Ancient Spawn of Morgathla", false) and storageSpawn < 1 then
            Game.setStoraveValue("SpawnMorgathla", 1)
            local stone = tile:getItemById(10580)
            if stone then
                stone:remove()
                local teleport = Game.createItem(1949, 1, pos)
                if teleport then
                    teleport:setDestination(Position(33710, 32375, 15))
                    addEvent(function()
                        teleport:remove()
                        Game.createItem(10580, 1, pos)
                    end, 120000)
                end
            end
        end
    end

end

malletGong:id(27526)