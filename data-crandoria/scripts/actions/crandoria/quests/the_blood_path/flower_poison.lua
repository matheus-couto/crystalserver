local flowerPoison = Action()

function flowerPoison.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if target:getId() == 27465 then 
        if target:getUniqueId() == 12319 then
            if player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.SecondTask) == 1 then
                player:setStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.SecondTask, 2)
                item:remove()
                target:transform(3698)
                
                -- Agendando a mudança de volta para o estado original após 5 minutos
                addEvent(function()
                    local originalPlant = Tile(target:getPosition()):getItemById(3698)
                    if originalPlant then
                        originalPlant:transform(27465)
                    end
                end, 2 * 60 * 1000) -- 5 minutos em milissegundos
            else
                player:sendCancelMessage("Voce nao esta nessa estapa da missao.")
            end
        else
            player:sendCancelMessage("Este item nao pode ser usado aqui.")
        end
    end
end

flowerPoison:id(11364)
flowerPoison:register()

local rewardItems = {

    {itemId = 23682, itemName = "VIP Coins", count = 1},
    {itemId = 26186, itemName = "Exercise Stash", count = 1},
    {itemId = 9099, itemName = "Black Candle", count = 1},
    {itemId = 22721, itemName = "Gold Token", count = 3},
    {itemId = 22721, itemName = "Gold Token", count = 2},
    {itemId = 22516, itemName = "Silver Token", count = 3},
    {itemId = 22516, itemName = "Silver Token", count = 2},
    {itemId = 14112, itemName = "Bar of Gold", count = 1},
    {itemId = 3043, itemName = "Crystal Coin", count = 50},
    {itemId = 25745, itemName = "Livro Sagrado", count = 1},
    {itemId = 3235, itemName = "Teleportation Rune", count = 1},
    {itemId = 637, itemName = "Casino Ticket", count = 1},

    -- Adicione mais itens à lista conforme necessário
}

local function getRandomItemToTrade()
    -- Escolhe um item aleatório da lista de itens trocáveis
    local randomReward = math.random(1, #rewardItems)
    return rewardItems[randomReward].itemId, rewardItems[randomReward].count -- Retorna o ID do item aleatório
end

local rewardFlower = Action()

function rewardFlower.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.SecondTask) >= 3 then
        local randomItem, itemCount = getRandomItemToTrade()

        player:addItem(randomItem, itemCount) -- Remove o item misterioso do jogador

        player:setStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.SecondTask, 0)
        local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
        player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
        player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
    else
        player:sendCancelMessage("Voce nao pode abrir o bau de Frigard sem sua permissao.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
    end
    return true
end

rewardFlower:uid(12320)
rewardFlower:register()


    -- {itemId = 26186, itemName = "Exercise Stash"},
    -- {itemId = 26186, itemName = "Exercise Stash"},
    -- {itemId = 26186, itemName = "Exercise Stash"},
    -- {itemId = 26186, itemName = "Exercise Stash"},
    -- {itemId = 26186, itemName = "Exercise Stash"},
    -- {itemId = 26186, itemName = "Exercise Stash"},
    -- {itemId = 26186, itemName = "Exercise Stash"},
    -- {itemId = 26186, itemName = "Exercise Stash"},
    -- {itemId = 20138, itemName = "Small Stamina Refill"},
    -- {itemId = 9099, itemName = "Black Candle"},
    -- {itemId = 26186, itemName = "Exercise Stash"},
    -- {itemId = 20138, itemName = "Small Stamina Refill"},
    -- {itemId = 9099, itemName = "Black Candle"},
    -- {itemId = 26186, itemName = "Exercise Stash"},
    -- {itemId = 20138, itemName = "Small Stamina Refill"},
    -- {itemId = 9099, itemName = "Black Candle"},
    -- {itemId = 26186, itemName = "Exercise Stash"},
    -- {itemId = 20139, itemName = "Full Stamina Refill"},
    -- {itemId = 26186, itemName = "Exercise Stash"},
    -- {itemId = 26186, itemName = "Exercise Stash"},
    -- {itemId = 26186, itemName = "Exercise Stash"},
    -- {itemId = 26186, itemName = "Exercise Stash"},
    -- {itemId = 20138, itemName = "Small Stamina Refill"},
    -- {itemId = 9099, itemName = "Black Candle"},
    -- {itemId = 26186, itemName = "Exercise Stash"},
    -- {itemId = 20138, itemName = "Small Stamina Refill"},
    -- {itemId = 9099, itemName = "Black Candle"},
    -- {itemId = 16244, itemName = "Music Box"},
    -- {itemId = 26186, itemName = "Exercise Stash"},
    -- {itemId = 20138, itemName = "Small Stamina Refill"},
    -- {itemId = 9099, itemName = "Black Candle"},
    -- {itemId = 16244, itemName = "Music Box"},
    -- {itemId = 26186, itemName = "Exercise Stash"},
    -- {itemId = 20139, itemName = "Full Stamina Refill"},
    -- {itemId = 22739, itemName = "Cobra You Desire"},
    -- {itemId = 36827, itemName = "Lion You Desire"},
    -- {itemId = 31633, itemName = "Falcon You Desire"},
    -- {itemId = 22739, itemName = "Cobra You Desire"},
    -- {itemId = 36827, itemName = "Lion You Desire"},
    -- {itemId = 31633, itemName = "Falcon You Desire"},
    -- {itemId = 23682, itemName = "VIP Coins"},
    -- {itemId = 34109, itemName = "Bag You Desire"},