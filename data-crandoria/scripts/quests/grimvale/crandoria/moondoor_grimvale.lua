local moonDoor = Action()
function moonDoor.onUse(player, item, fromPosition, target, toPosition, isHotkey)
local storage = player:getStorageValue(Storage.Grimvale.MoonDoor)
local playerPosition = player:getPosition()
        if playerPosition == Position(4806, 4333, 9) and storage > 0 then
            player:teleportTo(Position(4806, 4331, 9))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        elseif playerPosition == Position(4806, 4331, 9) and storage > 0 then
            player:teleportTo(Position(4806, 4333, 9))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        else
            player:sendTextMessage(MESSAGE_STATUS_SMALL, "Activate all mirrors in order to get access.")
            return true
    end
  end

moonDoor:aid(12257)
moonDoor:register()