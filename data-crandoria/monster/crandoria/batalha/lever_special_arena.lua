
			



local function setPlayersHealthInArea(fromPosition, toPosition, teamStorageValue)
    for x = fromPosition.x, toPosition.x do
        for y = fromPosition.y, toPosition.y do
            local tile = Tile(Position(x, y, fromPosition.z))
            if tile then
                for _, creature in ipairs(tile:getCreatures()) do
                    if creature:isPlayer() and creature:getStorageValue(Storage.Quest.Crandoria.Batalha.Time) == teamStorageValue then
                        local newLife = creature:getHealth() / 1.25
                        creature:setHealth(newLife) -- 🔥 Reduz a vida dos jogadores corretos
                        creature:getPosition():sendMagicEffect(CONST_ME_EXPLOSIONHIT)
                    end
                end
            end
        end
    end
end

local function getPlayerOnTile(pos)
    local tile = Tile(pos)
    if tile then
        local creature = tile:getTopCreature()
        if creature and creature:isPlayer() then
            return creature
        end
    end
    return nil
end

local leverArenaSpecial = Action()

function leverArenaSpecial.onUse(player, item, fromPosition, target, toPosition)
    if item:getPosition() == Position(4042, 4868, 7) and item.itemid == 2772 then
        local tile1 = Tile(Position(4046, 4865, 7))
        local tile2 = Tile(Position(4046, 4850, 7))
        if tile1 and tile2 then
            local itemToChange = tile1:getItemById(42349) -- Encontra o item 42349 na tile
            local itemToChange2 = tile2:getItemById(42349) -- Encontra o item 42349 na tile
            if itemToChange and itemToChange2 then
                if getPlayerOnTile(Position(4042, 4867, 7)) and getPlayerOnTile(Position(4043, 4868, 7)) and getPlayerOnTile(Position(4042, 4869, 7)) and getPlayerOnTile(Position(4041, 4868, 7)) then
                    itemToChange:transform(42348) -- Transforma 42349 em 42348
                    itemToChange2:transform(42348) -- Transforma 42349 em 42348
                    item:transform(2773)
                    Game.createMonster("Crandoria Chaos Golem", Position(4048, 4857, 7), true, true)
                    addEvent(function()
                        item:transform(2772)
                    end, 2000)
                    addEvent(function()
                        itemToChange:transform(42349)
                        itemToChange2:transform(42349)
                    end, 1000 * 60 * 5)
                else
                    player:sendTextMessage(MESSAGE_INFO_DESCR, "Sao necessarios 4 jogadores para puxar a alavanca.")
                end
            end
        end
    elseif item:getPosition() == Position(4080, 4868, 7) and item.itemid == 2772 then
        local tile3 = Tile(Position(4077, 4865, 7))
        local tile4 = Tile(Position(4077, 4850, 7))
        if tile3 and tile4 then
            local itemToChange3 = tile3:getItemById(42349) -- Encontra o item 42349 na tile
            local itemToChange4 = tile3:getItemById(42349) -- Encontra o item 42349 na tile
            if itemToChange3 and itemToChange4 then
                if getPlayerOnTile(Position(4080, 4867, 7)) and getPlayerOnTile(Position(4081, 4868, 7)) and getPlayerOnTile(Position(4080, 4869, 7)) and getPlayerOnTile(Position(4079, 4868, 7)) then
                    itemToChange3:transform(42348) -- Transforma 42349 em 42348
                    itemToChange4:transform(42348) -- Transforma 42349 em 42348
                    item:transform(2773)
                    Game.createMonster("Umbra Chaos Golem", Position(4074, 4857, 7), true, true)
                    addEvent(function()
                        item:transform(2772)
                    end, 2000)
                    addEvent(function()
                        itemToChange:transform(42349)
                        itemToChange2:transform(42349)
                    end, 1000 * 60 * 5)
                else
                    player:sendTextMessage(MESSAGE_INFO_DESCR, "Sao necessarios 4 jogadores para puxar a alavanca.")
                end
            end
        end
    elseif item:getPosition() == Position(4043, 4847, 7) and item.itemid == 2772 then -- DANO CRANDORIA > UMBRA
        local tile1 = Tile(Position(4046, 4865, 7))
        local tile2 = Tile(Position(4046, 4850, 7))
        if tile1 and tile2 then
            local itemToChange = tile1:getItemById(42349) -- Encontra o item 42349 na tile
            local itemToChange2 = tile2:getItemById(42349) -- Encontra o item 42349 na tile
            if itemToChange and itemToChange2 then
                if getPlayerOnTile(Position(4043, 4846, 7)) and getPlayerOnTile(Position(4044, 4847, 7)) and getPlayerOnTile(Position(4043, 4848, 7)) and getPlayerOnTile(Position(4042, 4847, 7)) then
                    itemToChange:transform(42348) -- Transforma 42349 em 42348
                    itemToChange2:transform(42348) -- Transforma 42349 em 42348
                    setPlayersHealthInArea(Position(4030, 4838, 7), Position(4061, 4875, 7), 2)
                    addEvent(function()
                        item:transform(2772)
                    end, 2000)
                    addEvent(function()
                        itemToChange:transform(42349)
                        itemToChange2:transform(42349)
                    end, 1000 * 60 * 5)
                else
                    player:sendTextMessage(MESSAGE_INFO_DESCR, "Sao necessarios 4 jogadores para puxar a alavanca.")
                end
            end
        end
    elseif item:getPosition() == Position(4043, 4847, 7) and item.itemid == 2772 then -- DANO UMBRA > CRANDORIA
        local tile3 = Tile(Position(4077, 4865, 7))
        local tile4 = Tile(Position(4077, 4850, 7))
        if tile3 and tile4 then
            local itemToChange3 = tile3:getItemById(42349) -- Encontra o item 42349 na tile
            local itemToChange4 = tile3:getItemById(42349) -- Encontra o item 42349 na tile
            if itemToChange3 and itemToChange4 then
                if getPlayerOnTile(Position(4079, 4846, 7)) and getPlayerOnTile(Position(4080, 4847, 7)) and getPlayerOnTile(Position(4079, 4848, 7)) and getPlayerOnTile(Position(4078, 4847, 7)) then
                    itemToChange3:transform(42348) -- Transforma 42349 em 42348
                    itemToChange4:transform(42348) -- Transforma 42349 em 42348
                    setPlayersHealthInArea(Position(4061, 4836, 7), Position(4092, 4875, 7), 1)
                    addEvent(function()
                        item:transform(2772)
                    end, 2000)
                    addEvent(function()
                        itemToChange:transform(42349)
                        itemToChange2:transform(42349)
                    end, 1000 * 60 * 5)
                else
                    player:sendTextMessage(MESSAGE_INFO_DESCR, "Sao necessarios 4 jogadores para puxar a alavanca.")
                end
            end
        end

    end
end

leverArenaSpecial:aid(13122)
leverArenaSpecial:register()
			

