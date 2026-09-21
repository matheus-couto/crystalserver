local prisonTeleport = {
    enter = Position(4934, 4969, 6),  -- Entrada da prisão
    exit = Position(4934, 4971, 7),   -- Saída da prisão
}

local prisonTimers = {
    enterCooldown = 0,  -- Cooldown para entrar na prisão (em segundos)
    prisonDuration = 60 * 30 -- Duração da prisão em segundos (meia hora)
}

local leverPositions = {
    Position(4933, 4973, 6),
    Position(4933, 4974, 6),
    Position(4935, 4973, 6),
    Position(4935, 4974, 6)
}

local leverPositionsViridia = {
    Position(4563, 5417, 7),
    Position(4563, 5418, 7),
    Position(4565, 5417, 7),
    Position(4565, 5418, 7)
}

local teleportEnterPK = MoveEvent()

function areAllBLeversActivated()
    for _, position in pairs(leverPositions) do
        local leverItem = Tile(position):getItemById(2773)
        if not leverItem then
            return false
        end
    end
    return true
end

function areAllBLeversActivatedViridia()
    for _, position in pairs(leverPositionsViridia) do
        local leverItem = Tile(position):getItemById(2773)
        if not leverItem then
            return false
        end
    end
    return true
end

function teleportEnterPK.onStepIn(creature, item, position, fromPosition)
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

        if not areAllBLeversActivated() then
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
        
        -- player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 30 * 60)
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
        return true
    else

        local addTimeValue = player:getStorageValue(Storage.Quest.Crandoria.Prison.AddTime)
        local maxAddTimeValue = 21600
        local calculatedAddTime = addTimeValue * 30 * 60
        local enterCooldown = os.time() - player:getStorageValue(Storage.Quest.Crandoria.Prison.EnterCooldown)
        local prisonTimer = player:getStorageValue(Storage.Quest.Crandoria.Prison.Timer)
        local adjustedAddTime = math.min(calculatedAddTime, maxAddTimeValue)

        if not areAllBLeversActivatedViridia() then
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
        player:teleportTo(Position(4553, 5410, 7))


    end
end

teleportEnterPK:type("stepin")
teleportEnterPK:aid(12336)
teleportEnterPK:register()