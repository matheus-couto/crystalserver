local teleport = MoveEvent()

-- Tabela para armazenar IPs de jogadores que acessaram o teleporte
local accessedIPs = {}

function teleport.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if player:getLevel() < 250 then
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "Voce precisa possuir nivel 250 ou superior para acessar esse local.")
        player:teleportTo(Position(4877, 5345, 10))
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        return true
    else

        local playerIP = player:getIp()
    
        if accessedIPs[playerIP] and accessedIPs[playerIP] ~= player:getGuid() then
            player:sendTextMessage(MESSAGE_STATUS_SMALL, "Voce so pode enfrentar a Percht Queen com um personagem por dia.")
            player:teleportTo(Position(4877, 5345, 10))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        else
            player:teleportTo(Position(4881, 5374, 7))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            -- if player:getStorageValue(Storage.Quest.Crandoria.ThePerchtQueen.Outfit) > 0 and player:getStorageValue(Storage.Quest.Crandoria.ThePerchtQueen.Outfit) <= 2 then
            --     player:addOutfit(1161, 0)
            --     player:addOutfit(1162, 0)
            -- elseif player:getStorageValue(Storage.Quest.Crandoria.ThePerchtQueen.Outfit) > 4 and player:getStorageValue(Storage.Quest.Crandoria.ThePerchtQueen.Outfit) <= 9 then
            --     player:addOutfit(1161, 0)
            --     player:addOutfit(1162, 0)
            --     player:addOutfitAddon(1161, 1)
            --     player:addOutfitAddon(1162, 1)
            -- elseif player:getStorageValue(Storage.Quest.Crandoria.ThePerchtQueen.Outfit) > 9 then
            --     player:addOutfit(1161, 0)
            --     player:addOutfit(1162, 0)
            --     player:addOutfitAddon(1161, 1)
            --     player:addOutfitAddon(1162, 1)
            --     player:addOutfitAddon(1161, 2)
            --     player:addOutfitAddon(1162, 2)
            -- end
            accessedIPs[playerIP] = player:getGuid()
        end
    end
end

teleport:aid(13047)
teleport:register()


------------------------- MULTI IPS: -----------------

-- local teleport = MoveEvent()

-- -- Tabela para armazenar IPs de jogadores que acessaram o teleporte
-- local accessedIPs = {}

-- -- Tabela para agrupar os IPs específicos
-- local groupedIPs = {
--     [2984019035] = true,
--     [764178760] = true,
--     [286485578] = true
-- }

-- local function isGroupedIP(ip)
--     return groupedIPs[ip] ~= nil
-- end

-- local function hasGroupAccessed(playerIP)
--     for ip, _ in pairs(groupedIPs) do
--         if accessedIPs[ip] then
--             return true
--         end
--     end
--     return false
-- end

-- function teleport.onStepIn(creature, item, position, fromPosition)
--     local player = creature:getPlayer()
--     if not player then
--         return true
--     end

--     if player:getLevel() < 250 then
--         player:sendTextMessage(MESSAGE_STATUS_SMALL, "Você precisa possuir nível 250 ou superior para acessar esse local.")
--         player:teleportTo(Position(4877, 5345, 10))
--         player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--         return true
--     else
--         local playerIP = player:getIp()

--         -- Verifica se o IP do jogador está no grupo específico
--         if isGroupedIP(playerIP) then
--             -- Verifica se algum IP do grupo já foi usado
--             if hasGroupAccessed(playerIP) then
--                 player:sendTextMessage(MESSAGE_STATUS_SMALL, "Você só pode enfrentar a Percht Queen com um personagem por dia.")
--                 player:teleportTo(Position(4877, 5345, 10))
--                 player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--                 return true
--             else
--                 -- Permite o teleporte e registra todos os IPs do grupo
--                 for ip, _ in pairs(groupedIPs) do
--                     accessedIPs[ip] = player:getGuid()
--                 end
--                 player:teleportTo(Position(4881, 5374, 7))
--                 player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--                 return true
--             end
--         else
--             -- Verifica a lógica para outros IPs
--             if accessedIPs[playerIP] and accessedIPs[playerIP] ~= player:getGuid() then
--                 player:sendTextMessage(MESSAGE_STATUS_SMALL, "Você só pode enfrentar a Percht Queen com um personagem por dia.")
--                 player:teleportTo(Position(4877, 5345, 10))
--                 player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--                 return true
--             else
--                 player:teleportTo(Position(4881, 5374, 7))
--                 player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--                 accessedIPs[playerIP] = player:getGuid()
--             end
--         end
--     end
-- end

-- teleport:aid(13047)
-- teleport:register()
