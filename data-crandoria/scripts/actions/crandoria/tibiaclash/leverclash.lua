local leverClash = Action()

local team1Positions = {
    Position(3978, 4781, 7),
    Position(3979, 4781, 7)
}

local team2Positions = {
    Position(3981, 4781, 7),
    Position(3982, 4781, 7)
}

local restrictedItems = {3031, 3035, 3043, 14112}
local goldTokenId = 22721
local requiredTokens = 2
local storageTimerNovoJogo = Storage.Quest.Crandoria.TibiaClash.TimerNovoJogo
local storageTimerSummon = Storage.Quest.Crandoria.TibiaClash.TimerSummon
local storageTimerGeral = Storage.Quest.Crandoria.TibiaClash.TimerGeral
local storageTeam = Storage.Quest.Crandoria.TibiaClash.Time
local teleportPositions = {
    [1] = Position(3954, 4766, 7),
    [2] = Position(4007, 4766, 7)
}

local restrictedArea = {
    fromPosition = Position(3953, 4765, 7),
    toPosition = Position(4009, 4770, 7)
}

local function removeMonstersInArea(fromPos, toPos)
    for x = fromPos.x, toPos.x do
        for y = fromPos.y, toPos.y do
            for z = fromPos.z, fromPos.z do
                local tile = Tile(Position(x, y, z))
                if tile then
                    local creature = tile:getTopCreature()
                    if creature and creature:isMonster() then
                        creature:remove() -- Remove o monstro da área
                    end
                end
            end
        end
    end
end

local function isPlayerInRestrictedArea()
    for x = restrictedArea.fromPosition.x, restrictedArea.toPosition.x do
        for y = restrictedArea.fromPosition.y, restrictedArea.toPosition.y do
            local tile = Tile(Position(x, y, restrictedArea.fromPosition.z))
            if tile then
                local creature = tile:getTopCreature()
                if creature and creature:isPlayer() then
                    return true
                end
            end
        end
    end
    return false
end

function leverClash.onUse(player, item, fromPosition, target, toPosition)
    if isPlayerInRestrictedArea() then
        player:sendCancelMessage("Ha jogadores na arena. Aguarde para iniciar o proximo jogo.")
        return true
    end

    if Game.getStorageValue(GlobalStorage.Crandoria.TibiaClashGlobal.Partida) > os.time() then
        player:sendCancelMessage("Aguarde, ha uma partida em andamento.")
        return true
    end
    
    local team1, team2 = {}, {}
    
    for _, pos in ipairs(team1Positions) do
        local creature = Tile(pos):getTopCreature()
        if creature and creature:isPlayer() then
            table.insert(team1, creature)
        end
    end
    
    for _, pos in ipairs(team2Positions) do
        local creature = Tile(pos):getTopCreature()
        if creature and creature:isPlayer() then
            table.insert(team2, creature)
        end
    end
    
    if #team1 ~= #team2 or #team1 == 0 then
        player:sendCancelMessage("Ambos os times devem possuir o mesmo numero de jogadores.")
        return true
    end
    
    for _, team in ipairs({team1, team2}) do
        for _, player in ipairs(team) do
            if player:getItemCount(goldTokenId) < requiredTokens then
                player:sendCancelMessage("Todos os jogadores devem ter pelo menos " .. requiredTokens .. " Gold Tokens.")
                return true
            end
            
            for _, itemId in ipairs(restrictedItems) do
                if player:getItemCount(itemId) > 0 then
                    player:sendCancelMessage("Nenhum jogador pode acessar a Arena com dinheiro na backpack.")
                    return true
                end
            end
            
            if player:getStorageValue(storageTimerNovoJogo) > os.time() then
                player:sendCancelMessage("Algum dos jogadores ainda nao esperou o periodo de 4 horas para jogar novamente.")
                return true
            end

            if player:getLevel() < 500 then
                player:sendCancelMessage("Todos os jogadores devem ter nivel 500 ou superior para participar.")
                return true
            end
        end
    end
    
    for _, team in ipairs({team1, team2}) do
        for _, player in ipairs(team) do
            player:setStorageValue(storageTimerNovoJogo, os.time() + 8 * 60 * 60)
            player:removeItem(22721, 2)
            player:addItem(3031, 50)
            player:setStorageValue(Storage.Quest.Crandoria.TibiaClash.Gold, 50)
            player:setStorageValue(storageTimerSummon, os.time() + 10)
            player:setStorageValue(storageTimerGeral, os.time() + 60 * 10)
            player:setStorageValue(Storage.Quest.Crandoria.TibiaClash.Summon1, 0)
            player:setStorageValue(Storage.Quest.Crandoria.TibiaClash.Summon2, 0)
            player:setStorageValue(Storage.Quest.Crandoria.TibiaClash.Summon3, 0)
        end
    end
    
    for _, player in ipairs(team1) do
        player:teleportTo(teleportPositions[1])
        player:setStorageValue(storageTeam, 1)
        player:setStorageValue(Storage.Quest.Crandoria.TibiaClash.Special, 1)
    end
    
    for _, player in ipairs(team2) do
        player:teleportTo(teleportPositions[2])
        player:setStorageValue(storageTeam, 2)
        player:setStorageValue(Storage.Quest.Crandoria.TibiaClash.Special, 1)
    end

    removeMonstersInArea(Position(3952, 4760, 7), Position(4009, 4770, 7))

    addEvent(function()
        Game.createMonster("Crandoria Totem", Position(3954, 4762, 7), true, true)
        Game.createMonster("Umbra Totem", Position(4007, 4762, 7), true, true)
        Game.setStorageValue(GlobalStorage.Crandoria.TibiaClashGlobal.Partida, os.time() + 60 * 10)
    end, 10000)

    addEvent(function()
        if isPlayerInRestrictedArea() then
            player:sendCancelMessage("O tempo acabou.")
            removeMonstersInArea(Position(3952, 4760, 7), Position(4009, 4770, 7))
        end
    end, 10 * 60 * 1000)
    
    return true
end

leverClash:aid(13116)
leverClash:register()
