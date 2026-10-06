-- Credits:
-- Sarah Wesker  OTLand
-- adaptado e otimizado para Canary por NvSo
-- Otimizado para performance por Antigravity AI

local config = {
    storage = 12442,
    pointItemId = 22723, -- Crystal Coin
    pointsPerHour = 1,
    timeSeconds = 1800, -- 30 minutos
    checkDuplicateIps = false,
    showLog = true
}

local onlinePointsEvent = GlobalEvent("GainPointPerHour")
local intervalShort = 3000
local intervalLong = 6000

function onlinePointsEvent.onThink(interval)
    local players = Game.getPlayers()
    local playerCount = #players

    if playerCount == 0 then
        onlinePointsEvent:interval(intervalLong)
        return true
    end

    local ipSet = {}
    local intervalSeconds = math.ceil(interval / 1000)

    for i, player in ipairs(players) do
        local ip = player:getIp()
        
        -- Skip se IP inválido ou duplicado
        if ip == 0 or (config.checkDuplicateIps and ipSet[ip]) then
            goto continue
        end
        
        ipSet[ip] = true
        
        -- Processar tempo online
        local seconds = math.max(0, player:getStorageValue(config.storage))
        
        if seconds >= config.timeSeconds then
            -- Resetar contador e dar recompensa
            player:setStorageValue(config.storage, 0)
            
            local item = player:addItem(config.pointItemId, config.pointsPerHour)
            if item then
                player:sendTextMessage(MESSAGE_LOOT, 
                    string.format("Você recebeu %d {%d|%s} por estar online por uma hora.", 
                        config.pointsPerHour, config.pointItemId, item:getName()))
                
                if config.showLog then
                    Spdlog.info(string.format("Player Rewarded: %s [Success]", player:getName()))
                end
                
                -- OTIMIZAÇÃO: Incrementar contador de forma eficiente
                local currentCount = Game.getStorageValue(GlobalStorage.Crandoria.TibiaCoinsColeta.ChecagemPlantas)
                Game.setStorageValue(GlobalStorage.Crandoria.TibiaCoinsColeta.ChecagemPlantas, 
                    math.max(1, currentCount + 1))
            end
        else
            -- Incrementar tempo online
            player:setStorageValue(config.storage, seconds + intervalSeconds)
        end
        
        ::continue::
    end

    onlinePointsEvent:interval(intervalShort)
    return true
end

onlinePointsEvent:interval(intervalShort)
onlinePointsEvent:register()



-- -- Credits:
-- -- Sarah Wesker  OTLand
-- -- adaptado e otimizado para Canary por NvSo

-- local config = {
--     storage = 12442, --mude o armazenamento para um tem livre
--     pointItemId = 22723, -- no momento é Crystal Coin
--     pointsPerHour = 1,
--     timeSeconds = 1800, -- 1 hour
--     checkDuplicateIps = false,
--     showLog = true -- Mostrar mensagem no console?
-- }

-- local onlinePointsEvent = GlobalEvent("GainPointPerHour")
-- local intervalShort = 30000
-- local intervalLong = 60000

-- function onlinePointsEvent.onThink(interval)
--     local players = Game.getPlayers()
--     local playerCount = #players

--     if playerCount == 0 then
--         onlinePointsEvent:interval(intervalLong)
--         return true
--     end

--     local checkIp = {}
--     local storage = config.storage
--     local pointItemId = config.pointItemId
--     local pointsPerHour = config.pointsPerHour
--     local checkDuplicateIps = config.checkDuplicateIps
--     local timeSeconds = config.timeSeconds
--     local showLog = config.showLog

--     local ipSet = {}
--     for i, player in ipairs(players) do
--         local ip = player:getIp()
--         if ip ~= 0 and (not checkDuplicateIps or not ipSet[ip]) then
--             ipSet[ip] = true
--             local seconds = math.max(0, player:getStorageValue(storage))
--             if seconds >= timeSeconds then
--                 player:setStorageValue(storage, 0)
--                 local item = player:addItem(pointItemId, pointsPerHour)
--                 if item then
--                     player:sendTextMessage(MESSAGE_LOOT, string.format("Voc\234 recebeu %d {%d|%s} por estar online por uma hora.", pointsPerHour, pointItemId, item:getName()))
--                     if showLog then
--                         local playerName = player:getName()
--                         Spdlog.info("Player Rewarded: " .. playerName .. " [Success]")
--                     end
--                     if Game.getStorageValue(GlobalStorage.Crandoria.TibiaCoinsColeta.ChecagemPlantas) < 1 then
--                         Game.setStorageValue(GlobalStorage.Crandoria.TibiaCoinsColeta.ChecagemPlantas, 1)
--                     else
--                         Game.setStorageValue(GlobalStorage.Crandoria.TibiaCoinsColeta.ChecagemPlantas, Game.getStorageValue(GlobalStorage.Crandoria.TibiaCoinsColeta.ChecagemPlantas) + 1)
--                     end
--                 end
--             else
--                 player:setStorageValue(storage, seconds + math.ceil(interval / 1000))
--             end
--         end
--     end

--     onlinePointsEvent:interval(intervalShort)
--     return true
-- end

-- onlinePointsEvent:interval(intervalShort)
-- onlinePointsEvent:register()


