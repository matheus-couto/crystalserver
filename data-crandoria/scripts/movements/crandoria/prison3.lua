

local prisonTeleport = {
    release = Position(5000, 5000, 7), -- Local de liberação após meia hora
    releasepk = Position(5000, 4955, 7), -- Local de liberação pk após meia hora
}

-- local teleportRelease = MoveEvent()

-- function teleportRelease.onStepIn(creature, item, position, fromPosition)
--     local player = creature:getPlayer()
--     if not player then
--         return true
--     end

--     local prisonTimer = player:getStorageValue(Storage.Quest.Crandoria.Prison.Timer)

--     if os.time() < prisonTimer then
--         player:teleportTo(fromPosition)
--         player:getPosition():sendMagicEffect(CONST_ME_POFF)
--         player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce deve aguardar por trinta minutos a uma hora antes de sair da prisao!")
--         return true
--     elseif os.time() >= prisonTimer then
--         if player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.House) ~= 1 then
--             player:teleportTo(prisonTeleport.release)
--             player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--             return true
--         else
--             player:teleportTo(Position(6073, 5314, 4))
--             player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--             return true
--         end
--     end
-- end

-- teleportRelease:type("stepin")
-- teleportRelease:aid(12337)
-- teleportRelease:register()

local teleportRelease = MoveEvent()

function teleportRelease.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local prisonTimer = player:getStorageValue(Storage.Quest.Crandoria.Prison.Timer)

    if os.time() < prisonTimer then
        local timeLeft = math.ceil((prisonTimer - os.time()) / 60) -- Converte o tempo restante para minutos e arredonda para cima

        player:teleportTo(fromPosition)
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce deve aguardar " .. timeLeft .. " minutos antes de sair da prisao!")
        return true
    elseif os.time() >= prisonTimer then
        if player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.House) ~= 1 then
            if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
                player:teleportTo(Position(4541, 5432, 4))
            else
                player:teleportTo(prisonTeleport.release)
            end
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        else
            player:teleportTo(Position(6073, 5314, 4))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        end
    end
end

teleportRelease:type("stepin")
teleportRelease:aid(12337)
teleportRelease:register()

local teleportReleasePK = MoveEvent()

function teleportReleasePK.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local prisonTimer = player:getStorageValue(Storage.Quest.Crandoria.Prison.Timer)

    if os.time() < prisonTimer then
        local timeLeft = math.ceil((prisonTimer - os.time()) / 60) -- Converte o tempo restante para minutos e arredonda para cima

        player:teleportTo(fromPosition)
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce deve aguardar " .. timeLeft .. " minutos antes de sair da prisao!")
        return true
    elseif os.time() >= prisonTimer then
        if player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.House) ~= 1 then
            if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
                player:teleportTo(Position(4541, 5432, 4))
            else
                player:teleportTo(prisonTeleport.release)
            end
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        else
            player:teleportTo(Position(6049, 5314, 5))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        end
    end
end

teleportReleasePK:type("stepin")
teleportReleasePK:aid(12338)
teleportReleasePK:register()