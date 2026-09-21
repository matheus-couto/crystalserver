-- local prisonTeleport = {
--     enter = Position(4934, 4967, 6),  -- Entrada da prisão
--     exit = Position(4932, 4963, 7),   -- Saída da prisão
-- }


-- local prisonTimers = {

--     enterCooldown = 0,  -- Cooldown para entrar na prisão (em segundos)
--     prisonDuration = 1 * 60 -- Duração da prisão em segundos (meia hora)
-- }

-- local leverPositions = {
--     Position(4933, 4961, 6),
--     Position(4933, 4962, 6),
--     Position(4935, 4961, 6),
--     Position(4935, 4962, 6)
-- }

-- local teleportEnter = MoveEvent()

-- function areAllLeversActivated()
--     for _, position in pairs(leverPositions) do
--         local leverItem = Tile(position):getItemById(2773)
--         if not leverItem then
--             return false
--         end
--     end
--     return true
-- end

-- function teleportEnter.onStepIn(creature, item, position, fromPosition)
--     local player = creature:getPlayer()
--     if not player then
--         return true
--     end

--     local addTimeValue = player:getStorageValue(Storage.Quest.Crandoria.Prison.AddTime)
--     local maxAddTimeValue = 21600
--     local calculatedAddTime = addTimeValue * 15 * 60
--     local enterCooldown = os.time() - player:getStorageValue(Storage.Quest.Crandoria.Prison.EnterCooldown)
--     local prisonTimer = player:getStorageValue(Storage.Quest.Crandoria.Prison.Timer)
--     local adjustedAddTime = math.min(calculatedAddTime, maxAddTimeValue)

--     if not areAllLeversActivated() then
--         player:teleportTo(fromPosition)
--         player:getPosition():sendMagicEffect(CONST_ME_POFF)
--         player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Coloque as alavancas todas para a direita para acessar o teleport.")
--         return true
--     end

--     -- Aleatoriamente transforma os itens nas posições das alavancas entre os IDs 8912 e 8911
--     for _, position in pairs(leverPositions) do
--         local leverItem = Tile(position):getItemById(2773)
--         if leverItem then
--             leverItem:transform(math.random() > 0.5 and 2772 or 2773)
--         end
--     end

--     player:teleportTo(prisonTeleport.exit)
--     player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
--     player:setStorageValue(Storage.Quest.Crandoria.Prison.AddTime, addTimeValue + 1)
--     player:setStorageValue(Storage.Quest.Crandoria.Prison.Timer, os.time() + prisonTimers.prisonDuration + adjustedAddTime)
--     player:setStorageValue(Storage.Quest.Crandoria.Prison.EnterCooldown, os.time() + prisonTimers.enterCooldown)
--     return true
-- end

-- teleportEnter:type("stepin")
-- teleportEnter:aid(12339)
-- teleportEnter:register()


-- local forgivenessReal = Action()

-- local forgivenessDuration = 15 * 60 -- 15 minutos em segundos

-- local forgivenessItemId = 39136

-- function forgivenessReal.onUse(player, item, fromPosition, target, toPosition, isHotkey)
--     local addTimeValue = player:getStorageValue(Storage.Quest.Crandoria.Prison.AddTime)
--     local maxAddTimeValue = 21600
--     local calculatedAddTime = addTimeValue * 15 * 60
--     local enterCooldown = os.time() - player:getStorageValue(Storage.Quest.Crandoria.Prison.EnterCooldown)
--     local prisonTimer = player:getStorageValue(Storage.Quest.Crandoria.Prison.Timer)
--     local adjustedAddTime = math.min(calculatedAddTime, maxAddTimeValue)

--     -- if isInArea(player, area1) or isInArea(player, area2) or isInArea(player, area3) then
--     --     player:sendCancelMessage("Voce nao pode usar um perdao real enquanto esta na prisao.")
--     --     player:getPosition():sendMagicEffect(CONST_ME_POFF)
--     --     return true
--     -- end

--     if adjustedAddTime >= 15 * 60 then
--         -- player:setStorageValue(Storage.Quest.Crandoria.Prison.AddTime, addTimeValue - 1)
--         player:setStorageValue(Storage.Quest.Crandoria.Prison.Timer, (os.time() + prisonTimers.prisonDuration + adjustedAddTime) - forgivenessDuration)
--         item:remove(1)
--         player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce usou o item de perdao real e reduziu sua sentenca de prisao em 15 minutos.")
--     else
--         player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce ja reduziu sua pena ao maximo.")
--         return true
--     end
-- end

-- forgivenessReal:id(39136)
-- forgivenessReal:register()



local prisonTeleport = {
    enter = Position(4934, 4967, 6),  -- Entrada da prisão
    exit = Position(4932, 4963, 7),   -- Saída da prisão
}


local prisonTimers = {

    enterCooldown = 0,  -- Cooldown para entrar na prisão (em segundos)
    prisonDuration = 30 * 60 -- Duração da prisão em segundos (meia hora)
}

local leverPositions = {
    Position(4933, 4961, 6),
    Position(4933, 4962, 6),
    Position(4935, 4961, 6),
    Position(4935, 4962, 6)
}

local leverPositionsViridia = {
    Position(4563, 5405, 7),
    Position(4563, 5406, 7),
    Position(4565, 5405, 7),
    Position(4565, 5406, 7)
}

local teleportEnter = MoveEvent()

function areAllLeversActivated()
    for _, position in pairs(leverPositions) do
        local leverItem = Tile(position):getItemById(2773)
        if not leverItem then
            return false
        end
    end
    return true
end

function areAllLeversActivatedViridia()
    for _, position in pairs(leverPositionsViridia) do
        local leverItem = Tile(position):getItemById(2773)
        if not leverItem then
            return false
        end
    end
    return true
end

function teleportEnter.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) ~= 1 then

        local addTimeValue = player:getStorageValue(Storage.Quest.Crandoria.Prison.AddTime)
        local maxAddTimeValue = 21600
        local calculatedAddTime = addTimeValue * 15 * 60
        local enterCooldown = os.time() - player:getStorageValue(Storage.Quest.Crandoria.Prison.EnterCooldown)
        local prisonTimer = player:getStorageValue(Storage.Quest.Crandoria.Prison.Timer)
        local adjustedAddTime = math.min(calculatedAddTime, maxAddTimeValue) 

        if not areAllLeversActivated() then
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Coloque as alavancas todas para a direita para acessar o teleport.")
            return true
        end

        -- Aleatoriamente transforma os itens nas posições das alavancas entre os IDs 8912 e 8911
        for _, position in pairs(leverPositions) do
            local leverItem = Tile(position):getItemById(2773)
            if leverItem then
                leverItem:transform(math.random() > 0.5 and 2772 or 2773)
            end
        end

        if player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 169 then
            player:teleportTo(prisonTeleport.exit)
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            player:setStorageValue(Storage.Quest.Crandoria.Prison.QuestionIndex, 0)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 170)
            return true
        end


        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        player:setStorageValue(Storage.Quest.Crandoria.Prison.QuestionIndex, 0)
        player:setStorageValue(Storage.Quest.Crandoria.Prison.AddTime, addTimeValue + 1)
        player:setStorageValue(Storage.Quest.Crandoria.Prison.Timer, os.time() + prisonTimers.prisonDuration + adjustedAddTime)
        player:setStorageValue(Storage.Quest.Crandoria.Prison.EnterCooldown, os.time() + prisonTimers.enterCooldown)
        if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) >= 1 then
            player:teleportTo(Position(4553, 5405, 7))
        else
            player:teleportTo(prisonTeleport.exit)
        end
        -- player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 30 * 60)
        return true
    else
        local addTimeValue = player:getStorageValue(Storage.Quest.Crandoria.Prison.AddTime)
        local maxAddTimeValue = 21600
        local calculatedAddTime = addTimeValue * 30 * 60
        local enterCooldown = os.time() - player:getStorageValue(Storage.Quest.Crandoria.Prison.EnterCooldown)
        local prisonTimer = player:getStorageValue(Storage.Quest.Crandoria.Prison.Timer)
        local adjustedAddTime = math.min(calculatedAddTime, maxAddTimeValue) 

        if not areAllLeversActivatedViridia() then
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Coloque as alavancas todas para a direita para acessar o teleport.")
            return true
        end

        for _, position in pairs(leverPositionsViridia) do
            local leverItem = Tile(position):getItemById(2773)
            if leverItem then
                leverItem:transform(math.random() > 0.5 and 2772 or 2773)
            end
        end
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        player:setStorageValue(Storage.Quest.Crandoria.Prison.QuestionIndex, 0)
        player:setStorageValue(Storage.Quest.Crandoria.Prison.AddTime, addTimeValue + 1)
        player:setStorageValue(Storage.Quest.Crandoria.Prison.Timer, os.time() + prisonTimers.prisonDuration + adjustedAddTime)
        player:setStorageValue(Storage.Quest.Crandoria.Prison.EnterCooldown, os.time() + prisonTimers.enterCooldown)
        player:teleportTo(Position(4553, 5405, 7))
        return true

    end
end

teleportEnter:type("stepin")
teleportEnter:aid(12339)
teleportEnter:register()


local forgivenessReal = Action()

function forgivenessReal.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    
    local forgivenessDuration = 15 * 60 -- 15 minutos em segundos
    local addTimeValue = player:getStorageValue(Storage.Quest.Crandoria.Prison.AddTime)
    local maxAddTimeValue = 21600
    local calculatedAddTime = addTimeValue * 15 * 60
    local enterCooldown = os.time() - player:getStorageValue(Storage.Quest.Crandoria.Prison.EnterCooldown)
    local prisonTimer = player:getStorageValue(Storage.Quest.Crandoria.Prison.Timer)
    local adjustedAddTime = math.min(calculatedAddTime, maxAddTimeValue)

    if prisonTimer == -1 or os.time() > prisonTimer then
        player:sendCancelMessage("Voce nao pode usar o item a menos que tenha pena a cumprir.")
        return true
    end

    if os.time() < prisonTimer - 1800 and addTimeValue > 0 then 
        player:setStorageValue(Storage.Quest.Crandoria.Prison.AddTime, addTimeValue - 1)
        player:setStorageValue(Storage.Quest.Crandoria.Prison.Timer, prisonTimer - forgivenessDuration)
        item:remove(1)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce usou o item de perdao real e reduziu sua sentenca de prisao em 15 minutos.")
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce ja reduziu sua pena ao maximo.")
        return true
    end
end

forgivenessReal:id(39136)
forgivenessReal:register()