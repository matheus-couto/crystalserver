local entrance = MoveEvent()

function entrance.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if item:getActionId() == 12252 then
        -- local storage1 = player:getStorageValue(Storage.Quest.U12_40.SoulWar.GoshnarMaliceKilled)
        -- local storage2 = player:getStorageValue(Storage.Quest.U12_40.SoulWar.GoshnarHatredKilled)
        -- local storage3 = player:getStorageValue(Storage.Quest.U12_40.SoulWar.GoshnarSpiteKilled)
        -- local storage4 = player:getStorageValue(Storage.Quest.U12_40.SoulWar.GoshnarCrueltyKilled)
        -- local storage5 = player:getStorageValue(Storage.Quest.U12_40.SoulWar.GoshnarGreedKilled)
        -- local storage6 = player:getStorageValue(Storage.Quest.U12_40.SoulWar.GoshnarMegalomaniaKilled)
        local storage1 = player:getStorageValue(Storage.Quest.U7_9.ThePitsOfInferno.WeaponReward)

        if player:getStorageValue(Storage.Quest.U7_9.ThePitsOfInferno.ThroneInfernatil) >= 1 and player:getStorageValue(Storage.Quest.U7_9.ThePitsOfInferno.ThroneTafariel) >= 1 and player:getStorageValue(Storage.Quest.U7_9.ThePitsOfInferno.ThroneVerminor) >= 1 and player:getStorageValue(Storage.Quest.U7_9.ThePitsOfInferno.ThroneApocalypse) >= 1 and player:getStorageValue(Storage.Quest.U7_9.ThePitsOfInferno.ThroneBazir) >= 1 and player:getStorageValue(Storage.Quest.U7_9.ThePitsOfInferno.ThroneAshfalor) >= 1 and player:getStorageValue(Storage.Quest.U7_9.ThePitsOfInferno.ThronePumin) >= 1 then
            player:teleportTo(Position(5428, 4290, 12))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        else
            player:teleportTo(Position(5422, 4290, 12))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Apenas aqueles que ja finalizaram a quest Pits of Inferno podem acessar este local.")
            return true
        end
    end
end

entrance:type("stepin")
entrance:aid(12252)
entrance:register()
