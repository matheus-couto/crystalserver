local setting = {
    -- At what level can do the quest?
    requiredLevel = 100,
    -- Can it be done daily? true = yes, false = no
    daily = true,
    -- Do not change from here down
    centerDemonRoomPosition = {x = 5292, y = 5034, z = 8},
    demonsPositions = {
        {x = 5290, y = 5032, z = 8},
        {x = 5292, y = 5032, z = 8},
        {x = 5294, y = 5034, z = 8},
        {x = 5295, y = 5034, z = 8},
        {x = 5291, y = 5036, z = 8},
        {x = 5293, y = 5036, z = 8}
    },
    playersPositions = {
        {fromPos = {x = 5296, y = 5046, z = 8}, toPos = {x = 5293, y = 5034, z = 8}},
        {fromPos = {x = 5295, y = 5046, z = 8}, toPos = {x = 5292, y = 5034, z = 8}},
        {fromPos = {x = 5294, y = 5046, z = 8}, toPos = {x = 5291, y = 5034, z = 8}},
        {fromPos = {x = 5293, y = 5046, z = 8}, toPos = {x = 5290, y = 5034, z = 8}},
    }
}

local lever = Action()

function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item.itemid == 2772 then
        local playersReady = false
        for i = 1, #setting.playersPositions do
            local creature = Tile(setting.playersPositions[i].fromPos):getTopCreature()
            if creature and creature:isPlayer() then
                if creature:getLevel() < setting.requiredLevel then
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "All the players need to be level ".. setting.requiredLevel .." or higher.")
                    return true
                end
                playersReady = true
            end
        end

        if not playersReady then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "At least one player needs to be prepared to face the Annihilator.")
            return true
        end

        -- Checks if there are still players inside the room, if so, return true
        if Position.hasPlayer(setting.centerDemonRoomPosition, 4, 4) then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "A team is already inside the quest room.")
            return true
        end

        -- Create monsters
        for i = 1, #setting.demonsPositions do
            Game.createMonster("Angry Demon", setting.demonsPositions[i])
        end

        -- Get players from the tiles "playersPositions" and teleport to the demons room if all of the above requirements are met
        for i = 1, #setting.playersPositions do
            local creature = Tile(setting.playersPositions[i].fromPos):getTopCreature()
            if creature and creature:isPlayer() then
                creature:teleportTo(setting.playersPositions[i].toPos)
                creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            end
        end
        item:transform(2773)
    elseif item.itemid == 2773 then
        -- If it has "daily = true" then it will execute this function
        if setting.daily then
            player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
        end
        -- Not be able to push the lever back if someone is still inside the monsters room
        if Position.hasPlayer(setting.centerDemonRoomPosition, 4, 4) then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "A team is already inside the quest room.")
            return true
        end
        -- Removes all monsters so that the next team can enter
        if Position.removeMonster(setting.centerDemonRoomPosition, 4, 4) then
            return true
        end
        item:transform(2772)
    end
    return true
end

lever:uid(30025)
lever:register()