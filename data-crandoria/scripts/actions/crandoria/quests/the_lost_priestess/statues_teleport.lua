local statuesConfig = {
    [1] = Position(4869, 4422, 15),
    [2] = Position(4882, 4427, 15),
    [3] = Position(4887, 4440, 15),
    [4] = Position(4882, 4453, 15),
    [5] = Position(4869, 4458, 15),
    [6] = Position(4856, 4453, 15),
    [7] = Position(4851, 4440, 15),
    [8] = Position(4856, 4427, 15)
}

local teleportPosition = Position(4869, 4440, 15)
local teleportDestination = Position(5039, 4517, 15)
local teleportId = 22761
local teleportDuration = 60 -- 1 minute in seconds

local function activateStatues()
    for _, pos in pairs(statuesConfig) do
        local tile = Tile(pos)
        if tile then
            local statue = tile:getItemById(746)
            if statue then
                statue:setActionId(12306)
            end
        end
    end
end

local function activateTeleport(player, item)
    local teleport = Game.createItem(teleportId, 1, teleportPosition)
    if teleport then
        teleport:setDestination(teleportDestination)
        addEvent(function()
            teleport:remove()
            activateStatues()
        end, teleportDuration * 1000)
    end
end

local statuesAction = Action()


function statuesAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item.actionid == 12306 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ativou a estatua.")
        player:say('CLICK', TALKTYPE_MONSTER_SAY, false, player, toPosition)
        item:setActionId(0)

        local allStatuesClicked = true
        for _, pos in pairs(statuesConfig) do
            local tile = Tile(pos)
            if tile then
                local statue = tile:getItemById(746)
                if statue and statue.actionid == 12306 then
                    allStatuesClicked = false
                    break
                end
            end
        end

        if allStatuesClicked then
            activateTeleport(player, item)
        end
    end

    return true
end

activateStatues()  -- Ativa as estátuas no início do script
statuesAction:aid(12306)
statuesAction:register()