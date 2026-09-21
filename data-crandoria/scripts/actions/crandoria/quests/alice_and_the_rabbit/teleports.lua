local teleportsAlice = MoveEvent()

function teleportsAlice.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if item:getId() == 25717 then
        if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Lagarta) >= 1 then
            player:teleportTo(Position(4529, 4692, 15))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        else
            player:teleportTo(fromPosition)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ainda nao tem assuntos a tratar nesse lugar.")
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        end
    elseif item:getId() == 27589 then
        if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Lebre) >= 1 then
            player:teleportTo(Position(4697, 4525, 15))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        else
            player:teleportTo(fromPosition)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ainda nao tem assuntos a tratar nesse lugar.")
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        end
    elseif item:getId() == 21739 then
        if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Morseman) >= 1 then
            player:teleportTo(Position(4772, 4665, 15))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        else
            player:teleportTo(fromPosition)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ainda nao tem assuntos a tratar nesse lugar.")
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        end
    elseif item:getId() == 1066 then
        if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor) >= 1 then
            player:teleportTo(Position(4592, 4709, 15))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        else
            player:teleportTo(fromPosition)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ainda nao tem assuntos a tratar nesse lugar.")
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        end
    elseif item:getId() == 5768 then
        if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Coelho) >= 1 then
            return true
        else
            player:teleportTo(fromPosition)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ainda nao tem assuntos a tratar nesse lugar.")
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        end
        return true
    elseif item:getId() == 43691 then
        if item:getPosition() == Position(4604, 4682, 14) then
            if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) > 14 then
                player:getPosition():sendMagicEffect(CONST_ME_GREYTELEPORT)
                player:teleportTo(Position(4429, 4650, 15))
                player:getPosition():sendMagicEffect(CONST_ME_GREYTELEPORT)
                return true
            else
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ainda nao tem assuntos a tratar nesse lugar.")
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
                return true
            end
        elseif item:getPosition() == Position(4429, 4651, 15) then
            player:getPosition():sendMagicEffect(CONST_ME_GREYTELEPORT)
            player:teleportTo(Position(4604, 4683, 14))
            player:getPosition():sendMagicEffect(CONST_ME_GREYTELEPORT)
            return true
        end
    end

    local area = {
        fromPosition = {x = 4460, y = 4808, z = 15},
        toPosition = {x = 4475, y = 4821, z = 15}
    }

    local function isInArea(player, area)
        local playerPos = player:getPosition()
        return playerPos.x >= area.fromPosition.x and playerPos.x <= area.toPosition.x
            and playerPos.y >= area.fromPosition.y and playerPos.y <= area.toPosition.y
            and playerPos.z == area.fromPosition.z
    end

    local monsters = {'Noxious Intruder', 'Pestilent Slitherer'}

    function createRandomMonster(position)
        local randomIndex = math.random(1, #monsters)
        local monsterName = monsters[randomIndex]
        Game.createMonster(monsterName, position, false, true)
    end
    
    function createMudCrawlerIfNotExists(position)
        local mudCrawler = Tile(position):getTopCreature()
        if not mudCrawler or mudCrawler:getName() ~= 'Mud Crawler' then
            Game.createMonster('Mud Crawler', position, false, true)
        end
    end
    
    if isInArea(player, area) then
        if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.VerminQueen) < 1 then
            player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.VerminQueen, 1)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce esta pisando no sensivel chao que abriga os filhos da Vermin Queen...")
            return true
        elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.VerminQueen) >= 1 and player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.VerminQueen) < 4 then
            player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.VerminQueen, player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.VerminQueen) + 1)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce foi notado pelas criaturas que estao abaixo dos seus pes.")
            return true
        elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.VerminQueen) >= 4 then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce pisou no lugar errado e alguns vermes subiram das profundezas!")
            createMudCrawlerIfNotExists(Position(4467, 4815, 15))
            createRandomMonster(Position(4467, 4813, 15))
            createRandomMonster(Position(4467, 4817, 15))
            player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.VerminQueen, 0)
            return true
        end
    end
    return true
end

teleportsAlice:type("stepin")
teleportsAlice:aid(12375)
teleportsAlice:register()

-- local teleportsAliceUse = Action()

-- function teleportsAliceUse.onUse(creature, item, position, fromPosition)
--     local player = creature:getPlayer()
--     if not player then
--         return true
--     end

--     if item:getId() == 17318 then
--         if item:getPosition() == Position(4604, 4682, 14) then
--             if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) > 14 then
--                 player:getPosition():sendMagicEffect(CONST_ME_GREYTELEPORT)
--                 player:teleportTo(Position(4429, 4650, 15))
--                 player:getPosition():sendMagicEffect(CONST_ME_GREYTELEPORT)
--                 return true
--             else
--                 player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ainda nao tem assuntos a tratar nesse lugar.")
--                 player:getPosition():sendMagicEffect(CONST_ME_POFF)
--                 return true
--             end
--         elseif item:getPosition() == Position(4429, 4651, 15) then
--             player:getPosition():sendMagicEffect(CONST_ME_GREYTELEPORT)
--             player:teleportTo(Position(4604, 4683, 14))
--             player:getPosition():sendMagicEffect(CONST_ME_GREYTELEPORT)
--             return true
--         end
--     end
-- end

-- teleportsAliceUse:aid(12375)
-- teleportsAliceUse:register()