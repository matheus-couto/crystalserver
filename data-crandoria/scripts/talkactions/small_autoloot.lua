local autoloot = {
    talkaction = "!autolootb",
    storageBase = 50000,
    freeAccountLimit = 15,
    vipAccountLimit = 30
}

local autolootCache = {}

local function getPlayerLimit(player)
    -- Ensure player is not nil before attempting to access its methods
    if player then
        if player.isVip then
            return player:isVip() and autoloot.vipAccountLimit or autoloot.freeAccountLimit
        else
            return autoloot.freeAccountLimit -- Return default limit if player is nil or not a VIP
        end
    end
end

local function getPlayerAutolootItems(player)
    local limits = getPlayerLimit(player)
    local items = {}

    if not player or not player:getGuid() then
        return items
    end

    local guid = player:getGuid()

    local itemsCache = autolootCache[guid]
    if itemsCache then
        return itemsCache
    end

    for i = 1, limits do
        local itemId = player:getStorageValue(autoloot.storageBase + i)
        if itemId and itemId > 0 then
            items[#items + 1] = itemId
        end
    end

    autolootCache[guid] = items
    autolootCache[guid .. "_set"] = nil

    return items
end

local function setPlayerAutolootItems(player, items)
    local guid = player:getGuid()
    local limit = getPlayerLimit(player)

    for i = 1, limit do
        player:setStorageValue(
            autoloot.storageBase + i,
            items[i] or -1
        )
    end

    autolootCache[guid] = nil
    autolootCache[guid .. "_set"] = nil

    return true
end

local function addPlayerAutolootItem(player, itemId)
    local items = getPlayerAutolootItems(player)
    for _, id in pairs(items) do
        if itemId == id then
            return false
        end
    end
    items[#items +1] = itemId
    return setPlayerAutolootItems(player, items)
end

local function removePlayerAutolootItem(player, itemId)
    local items = getPlayerAutolootItems(player)
    for i, id in pairs(items) do
        if itemId == id then
            table.remove(items, i)
            return setPlayerAutolootItems(player, items)
        end
    end
    return false
end

local function hasPlayerAutolootItem(player, itemId)
    if not player then
        return false
    end

    if player:getStorageValue(STORAGEVALUE_AUTO_LOOT) == 1 then
        return false
    end

    local items = getPlayerAutolootItems(player)
    if #items < 1 then
        return false
    end

    local guid = player:getGuid()
    local cacheKey = guid .. "_set"

    local itemSet = autolootCache[cacheKey]
    if not itemSet then
        itemSet = {}
        for _, id in ipairs(items) do
            itemSet[id] = true
        end
        autolootCache[cacheKey] = itemSet
    end

    return itemSet[itemId] == true
end

-- CORRIGIDO: EventCallback() sem argumento estava lançando "Invalid callback
-- name" direto no construtor. Igual aos outros construtores de evento do seu
-- servidor (CreatureEvent, GlobalEvent, etc.), esse também espera um nome.
local ec = EventCallback("autolootDropLoot")

local function doAutoloot(playerId, corpsePos)
    local player = Player(playerId)
    if not player then
        return
    end

    local tile = Tile(corpsePos)
    if not tile then
        return
    end

    local corpse
    for _, item in ipairs(tile:getItems() or {}) do
        if item:isContainer() then
            corpse = item
            break
        end
    end

    if not corpse then
        return
    end

    for _, item in ipairs(corpse:getItems()) do
        if hasPlayerAutolootItem(player, item:getId()) then
            if not item:moveTo(player) then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have no capacity.")
                return
            end
        end
    end
end

function ec.monsterOnDropLoot(monster, corpse)
    if not corpse:getType():isContainer() then
        return
    end

    local ownerId = corpse:getCorpseOwner()
    if ownerId == 0 then
        return
    end

    -- Caso padrão: owner é player
    local owner = Player(ownerId)
    if owner then
        addEvent(doAutoloot, 10, owner:getId(), corpse:getPosition())
        return
    end

    -- Caso especial: owner é summon
    local summon = Creature(ownerId)
    if not summon then
        return
    end

    local master = summon:getMaster()
    if not master or not master:isPlayer() then
        return
    end

    -- 🔒 Garantia extra: o summon realmente pertence ao player
    local summons = master:getSummons()
    for i = 1, #summons do
        if summons[i] == summon then
            addEvent(doAutoloot, 10, master:getId(), corpse:getPosition())
            return
        end
    end
end

ec:register()

local talkAction = TalkAction(autoloot.talkaction)

function talkAction.onSay(player, words, param, type)
    local split = param:splitTrimmed(",")
    local action = split[1]
    if not action then
        player:showTextDialog(27446, string.format("Exemplos de uso:\n%s add,gold coin\n%s remove,gold coin\n%s clear\n%s show\n\n~Available slots~\nfreeAccount: %d\nvipAccount: %d", words, words, words, words, autoloot.freeAccountLimit, autoloot.vipAccountLimit), false)
        return false
    end

    if action == "clear" then
        setPlayerAutolootItems(player, {})
        player:sendCancelMessage("Sua lista de loot foi completamente limpa.")
        return false
    elseif action == "show" then
        local items = getPlayerAutolootItems(player)
        local description = {string.format('~ Sua lista de Loot ~ Capacidade: %d/%d ~\n', #items, getPlayerLimit(player))}
        for i, itemId in pairs(items) do
            description[#description +1] = string.format("%d) %s", i, ItemType(itemId):getName())
        end
        player:showTextDialog(27446, table.concat(description, '\n'), false)
        return false
    end

    local function getItemType()
        local itemType = ItemType(split[2])
        if not itemType or itemType:getId() == 0 then
            itemType = ItemType(tonumber(split[2]) or 0)
            if not itemType or itemType:getId() == 0 then
                player:sendCancelMessage(string.format("O item %s nao existe.", split[2]))
                return false
            end
        end
        return itemType
    end

    if action == "add" then
        local itemType = getItemType()
        if itemType then
            local limits = getPlayerLimit(player)
            if #getPlayerAutolootItems(player) >= limits then
                player:sendCancelMessage(string.format("Seu autoloot so suporta %d itens.", limits))
                return false
            end

            if addPlayerAutolootItem(player, itemType:getId()) then
                player:sendCancelMessage(string.format("Adicionado a lista: %s.", itemType:getName()))
            else
                player:sendCancelMessage(string.format("O item %s ja esta na lista.", itemType:getName()))
            end
        end
        return false
    elseif action == "remove" then
        local itemType = getItemType()
        if itemType then
            if removePlayerAutolootItem(player, itemType:getId()) then
                player:sendCancelMessage(string.format("Voce removeu da lista: %s", itemType:getName()))
            else
                player:sendCancelMessage(string.format("O item %s nao esta na sua lista.", itemType:getName()))
            end
        end
        return false
    end

    return false
end

talkAction:groupType("normal")
talkAction:separator(" ")
talkAction:register()

local creatureEvent = CreatureEvent("autolootCleanCache")

function creatureEvent.onLogout(player)
    local guid = player:getGuid()

    autolootCache[guid] = nil
    autolootCache[guid .. "_set"] = nil

    return true
end

creatureEvent:register()


--------------------------- ULTIMO ---------------------------

-- local autoloot = {
--     talkaction = "!autolootb",
--     storageBase = 50000,
--     freeAccountLimit = 15,
--     vipAccountLimit = 30
-- }

-- local autolootCache = {}

-- -- local function getPlayerLimit(player)
-- --     return player:isVip() and autoloot.vipAccountLimit or autoloot.freeAccountLimit
-- -- end

-- local function getPlayerLimit(player)
--     -- Ensure player is not nil before attempting to access its methods
--     if player then
--         if player.isVip then
--             return player:isVip() and autoloot.vipAccountLimit or autoloot.freeAccountLimit
--         else
--             return autoloot.freeAccountLimit -- Return default limit if player is nil or not a VIP
--         end
--     end
-- end

-- local function getPlayerAutolootItems(player)
--     local limits = getPlayerLimit(player)
--     local items = {}

--     if not player or not player:getGuid() then
--         return items
--     end

--     local guid = player:getGuid()

--     local itemsCache = autolootCache[guid]
--     if itemsCache then
--         return itemsCache
--     end

--     for i = 1, limits do
--         local itemId = player:getStorageValue(autoloot.storageBase + i)
--         if itemId and itemId > 0 then
--             items[#items + 1] = itemId
--         end
--     end

--     autolootCache[guid] = items
--     autolootCache[guid .. "_set"] = nil

--     return items
-- end

-- local function setPlayerAutolootItems(player, items)
--     local guid = player:getGuid()
--     local limit = getPlayerLimit(player)

--     for i = 1, limit do
--         player:setStorageValue(
--             autoloot.storageBase + i,
--             items[i] or -1
--         )
--     end

--     autolootCache[guid] = nil
--     autolootCache[guid .. "_set"] = nil

--     return true
-- end

-- local function addPlayerAutolootItem(player, itemId)
--     local items = getPlayerAutolootItems(player)
--     for _, id in pairs(items) do
--         if itemId == id then
--             return false
--         end
--     end
--     items[#items +1] = itemId
--     return setPlayerAutolootItems(player, items)
-- end

-- local function removePlayerAutolootItem(player, itemId)
--     local items = getPlayerAutolootItems(player)
--     for i, id in pairs(items) do
--         if itemId == id then
--             table.remove(items, i)
--             return setPlayerAutolootItems(player, items)
--         end
--     end
--     return false
-- end

-- local function hasPlayerAutolootItem(player, itemId)
--     if not player then
--         return false
--     end

--     if player:getStorageValue(STORAGEVALUE_AUTO_LOOT) == 1 then
--         return false
--     end

--     local items = getPlayerAutolootItems(player)
--     if #items < 1 then
--         return false
--     end

--     local guid = player:getGuid()
--     local cacheKey = guid .. "_set"

--     local itemSet = autolootCache[cacheKey]
--     if not itemSet then
--         itemSet = {}
--         for _, id in ipairs(items) do
--             itemSet[id] = true
--         end
--         autolootCache[cacheKey] = itemSet
--     end

--     return itemSet[itemId] == true
-- end

-- local ec = EventCallback()

-- local function doAutoloot(playerId, corpsePos)
--     local player = Player(playerId)
--     if not player then
--         return
--     end

--     local tile = Tile(corpsePos)
--     if not tile then
--         return
--     end

--     local corpse
--     for _, item in ipairs(tile:getItems() or {}) do
--         if item:isContainer() then
--             corpse = item
--             break
--         end
--     end

--     if not corpse then
--         return
--     end

--     for _, item in ipairs(corpse:getItems()) do
--         if hasPlayerAutolootItem(player, item:getId()) then
--             if not item:moveTo(player) then
--                 player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have no capacity.")
--                 return
--             end
--         end
--     end
-- end

-- -- function ec.monsterOnDropLoot(monster, corpse)
-- --     if not corpse:getType():isContainer() then
-- --         return
-- --     end

-- --     local owner = Player(corpse:getCorpseOwner())
-- --     if not owner then
-- --         return
-- --     end

-- --     addEvent(doAutoloot, 1, owner:getId(), corpse:getPosition())
-- -- end

-- -- ec:register()

-- function ec.monsterOnDropLoot(monster, corpse)
--     if not corpse:getType():isContainer() then
--         return
--     end

--     local ownerId = corpse:getCorpseOwner()
--     if ownerId == 0 then
--         return
--     end

--     -- Caso padrão: owner é player
--     local owner = Player(ownerId)
--     if owner then
--         addEvent(doAutoloot, 10, owner:getId(), corpse:getPosition())
--         return
--     end

--     -- Caso especial: owner é summon
--     local summon = Creature(ownerId)
--     if not summon then
--         return
--     end

--     local master = summon:getMaster()
--     if not master or not master:isPlayer() then
--         return
--     end

--     -- 🔒 Garantia extra: o summon realmente pertence ao player
--     local summons = master:getSummons()
--     for i = 1, #summons do
--         if summons[i] == summon then
--             addEvent(doAutoloot, 10, master:getId(), corpse:getPosition())
--             return
--         end
--     end
-- end

-- ec:register()

-- local talkAction = TalkAction(autoloot.talkaction)

-- function talkAction.onSay(player, words, param, type)
--     local split = param:splitTrimmed(",")
--     local action = split[1]
--     if not action then
--         player:showTextDialog(27446, string.format("Exemplos de uso:\n%s add,gold coin\n%s remove,gold coin\n%s clear\n%s show\n\n~Available slots~\nfreeAccount: %d\nvipAccount: %d", words, words, words, words, autoloot.freeAccountLimit, autoloot.vipAccountLimit), false)
--         return false
--     end

--     if action == "clear" then
--         setPlayerAutolootItems(player, {})
--         player:sendCancelMessage("Sua lista de loot foi completamente limpa.")
--         return false
--     elseif action == "show" then
--         local items = getPlayerAutolootItems(player)
--         local description = {string.format('~ Sua lista de Loot ~ Capacidade: %d/%d ~\n', #items, getPlayerLimit(player))}
--         for i, itemId in pairs(items) do
--             description[#description +1] = string.format("%d) %s", i, ItemType(itemId):getName())
--         end
--         player:showTextDialog(27446, table.concat(description, '\n'), false)
--         return false
--     end

--     local function getItemType()
--         local itemType = ItemType(split[2])
--         if not itemType or itemType:getId() == 0 then
--             itemType = ItemType(tonumber(split[2]) or 0)
--             if not itemType or itemType:getId() == 0 then
--                 player:sendCancelMessage(string.format("O item %s nao existe.", split[2]))
--                 return false
--             end
--         end
--         return itemType
--     end

--     if action == "add" then
--         local itemType = getItemType()
--         if itemType then
--             local limits = getPlayerLimit(player)
--             if #getPlayerAutolootItems(player) >= limits then
--                 player:sendCancelMessage(string.format("Seu autoloot so suporta %d itens.", limits))
--                 return false
--             end

--             if addPlayerAutolootItem(player, itemType:getId()) then
--                 player:sendCancelMessage(string.format("Adicionado a lista: %s.", itemType:getName()))
--             else
--                 player:sendCancelMessage(string.format("O item %s ja esta na lista.", itemType:getName()))
--             end
--         end
--         return false
--     elseif action == "remove" then
--         local itemType = getItemType()
--         if itemType then
--             if removePlayerAutolootItem(player, itemType:getId()) then
--                 player:sendCancelMessage(string.format("Voce removeu da lista: %s", itemType:getName()))
--             else
--                 player:sendCancelMessage(string.format("O item %s nao esta na sua lista.", itemType:getName()))
--             end
--         end
--         return false
--     end

--     return false
-- end

-- talkAction:groupType("normal")
-- talkAction:separator(" ")
-- talkAction:register()

-- local creatureEvent = CreatureEvent("autolootCleanCache")

-- function creatureEvent.onLogout(player)
--     local guid = player:getGuid()

--     autolootCache[guid] = nil
--     autolootCache[guid .. "_set"] = nil

--     return true
-- end


------------------------------- ULTIMO -----------------------------
--------------------- PENULTIMO --------------------------

-- local autoloot = {
--     talkaction = "!autolootb",
--     storageBase = 50000,
--     freeAccountLimit = 15,
--     vipAccountLimit = 30
-- }

-- local autolootCache = {}

-- -- local function getPlayerLimit(player)
-- --     return player:isVip() and autoloot.vipAccountLimit or autoloot.freeAccountLimit
-- -- end

-- local function getPlayerLimit(player)
--     -- Ensure player is not nil before attempting to access its methods
--     if player then
--         if player.isVip then
--             return player:isVip() and autoloot.vipAccountLimit or autoloot.freeAccountLimit
--         else
--             return autoloot.freeAccountLimit -- Return default limit if player is nil or not a VIP
--         end
--     end
-- end

-- local function getPlayerAutolootItems(player)
--     local limits = getPlayerLimit(player)
--     local items = {}
    
--     if not player:getGuid() then
--         return items;
--     end

--     local guid = player:getGuid()

--     local itemsCache = autolootCache[guid]
--     if itemsCache then
--         if #itemsCache > limits then
--             local newChache = {unpack(itemsCache, 1, limits)}
--             autolootCache[guid] = newChache
--             return newChache
--         end
--         return itemsCache
--     end

    
--     for i = 1, limits do
--         local itemType = ItemType(tonumber(player:getStorageValue(autoloot.storageBase + i)) or 0)
--         if itemType and itemType:getId() ~= 0 then
--             items[#items +1] = itemType:getId()
--         end
--     end

--     autolootCache[guid] = items
--     return items
-- end

-- local function setPlayerAutolootItems(player, items)
--     for i = 1, getPlayerLimit(player) do
--         player:setStorageValue(autoloot.storageBase + i, (items[i] and items[i] or -1))
--     end
--     -- Limpar cache de hash table quando a lista é modificada
--     autolootCache[player:getGuid() .. "_set"] = nil
--     return true
-- end

-- local function addPlayerAutolootItem(player, itemId)
--     local items = getPlayerAutolootItems(player)
--     for _, id in pairs(items) do
--         if itemId == id then
--             return false
--         end
--     end
--     items[#items +1] = itemId
--     return setPlayerAutolootItems(player, items)
-- end

-- local function removePlayerAutolootItem(player, itemId)
--     local items = getPlayerAutolootItems(player)
--     for i, id in pairs(items) do
--         if itemId == id then
--             table.remove(items, i)
--             return setPlayerAutolootItems(player, items)
--         end
--     end
--     return false
-- end

-- local function hasPlayerAutolootItem(player, itemId)

--     local itemsCache = autolootCache[player:getGuid()] -- Recupera o cache para o jogador

--     if not itemsCache or #itemsCache < 1 then
--         return false
--     end

--     if player:getStorageValue(STORAGEVALUE_AUTO_LOOT) == 1 then
--         player:sendTextMessage(MESSAGE_LOOK, "O comando !autolootb nao funciona caso o !autoloot esteja habilitado!")
--         return false;
--     end

--     -- Otimização: usar hash table ao invés de loop para lookup O(1)
--     local cacheKey = player:getGuid() .. "_set"
--     local itemSet = autolootCache[cacheKey]
    
--     if not itemSet then
--         -- Criar hash table na primeira vez
--         itemSet = {}
--         for _, id in pairs(itemsCache) do
--             itemSet[id] = true
--         end
--         autolootCache[cacheKey] = itemSet
--     end
    
--     return itemSet[itemId] == true
-- end

-- local ec = EventCallback()

-- function ec.monsterOnDropLoot(monster, corpse)
--     if not corpse:getType():isContainer() then
--         return
--     end
    
--     if not Player(corpse:getCorpseOwner()) then
--         return
--     end

--     local corpseOwner = Player(corpse:getCorpseOwner())
--     local items = corpse:getItems()
--     for _, item in pairs(items) do
--         if hasPlayerAutolootItem(corpseOwner, item:getId()) then
--             if not item:moveTo(corpseOwner) then
--                 corpseOwner:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have no capacity.")
--                 break
--             end
--         end
--     end
-- end

-- ec:register()

-- local talkAction = TalkAction(autoloot.talkaction)

-- function talkAction.onSay(player, words, param, type)
--     local split = param:splitTrimmed(",")
--     local action = split[1]
--     if not action then
--         player:showTextDialog(27446, string.format("Examples of use:\n%s add,gold coin\n%s remove,gold coin\n%s clear\n%s show\n\n~Available slots~\nfreeAccount: %d\nvipAccount: %d", words, words, words, words, autoloot.freeAccountLimit, autoloot.vipAccountLimit), false)
--         return false
--     end

--     if action == "clear" then
--         setPlayerAutolootItems(player, {})
--         player:sendCancelMessage("Autoloot list cleaned.")
--         return false
--     elseif action == "show" then
--         local items = getPlayerAutolootItems(player)
--         local description = {string.format('~ Your autoloot list, capacity: %d/%d ~\n', #items, getPlayerLimit(player))}
--         for i, itemId in pairs(items) do
--             description[#description +1] = string.format("%d) %s", i, ItemType(itemId):getName())
--         end
--         player:showTextDialog(2160, table.concat(description, '\n'), false)
--         return false
--     end

--     local function getItemType()
--         local itemType = ItemType(split[2])
--         if not itemType or itemType:getId() == 0 then
--             itemType = ItemType(tonumber(split[2]) or 0)
--             if not itemType or itemType:getId() == 0 then
--                 player:sendCancelMessage(string.format("The item %s does not exists!", split[2]))
--                 return false
--             end
--         end
--         return itemType
--     end

--     if action == "add" then
--         local itemType = getItemType()
--         if itemType then
--             local limits = getPlayerLimit(player)
--             if #getPlayerAutolootItems(player) >= limits then
--                 player:sendCancelMessage(string.format("Your auto loot only allows you to add %d items.", limits))
--                 return false
--             end

--             if addPlayerAutolootItem(player, itemType:getId()) then
--                 player:sendCancelMessage(string.format("Perfect you have added to the list: %s", itemType:getName()))
--             else
--                 player:sendCancelMessage(string.format("The item %s already exists!", itemType:getName()))
--             end
--         end
--         return false
--     elseif action == "remove" then
--         local itemType = getItemType()
--         if itemType then
--             if removePlayerAutolootItem(player, itemType:getId()) then
--                 player:sendCancelMessage(string.format("Perfect you have removed to the list the article: %s", itemType:getName()))
--             else
--                 player:sendCancelMessage(string.format("The item %s does not exists in the list.", itemType:getName()))
--             end
--         end
--         return false
--     end

--     return false
-- end

-- talkAction:groupType("normal")
-- talkAction:separator(" ")
-- talkAction:register()

-- local creatureEvent = CreatureEvent("autolootCleanCache")

-- function creatureEvent.onLogout(player)
--     setPlayerAutolootItems(player, getPlayerAutolootItems(player))
--     autolootCache[player:getGuid()] = nil
--     autolootCache[player:getGuid() .. "_set"] = nil -- Limpar cache de hash table
--     return true
-- end

-- creatureEvent:register()


------------------------ ULTIMO ----------------------------

































-- -- =========================
-- -- Constants
-- -- =========================
-- local ITEM_WOOD = 5901
-- local ITEM_NAIL = 953

-- local MODAL_CATEGORY = 6000
-- local MODAL_RECIPES  = 6001
-- local MODAL_DETAILS  = 6002

-- -- =========================
-- -- Carpentry Skill Requirements
-- -- =========================
-- local carpentryRequirements = {
--     -- [itemId] = { storage = STORAGE_ID, level = requiredLevel }

--     [2472] = { -- Chest
--         storage = Storage.Quest.Ashfall.Skills.CarpentryLevel,
--         level = 2
--     }

--     -- Exemplo futuro:
--     -- [11801] = { storage = Storage.Quest.Crandoria.SkillsColeta.Carpentry, level = 3 },
-- }

-- local function getFrontFreePosition(player)
--     local position = player:getPosition()
--     position:getNextPosition(player:getDirection())

--     local tile = Tile(position)
--     if not tile then
--         return nil
--     end

--     -- Bloqueios físicos do tile (parede, água, etc)
--     if tile:hasProperty(CONST_PROP_IMMOVABLEBLOCKSOLID) then
--         return nil
--     end

--     -- Criaturas
--     if tile:getCreatureCount() > 0 then
--         return nil
--     end

--     -- Bloqueia SOMENTE se existir item MÓVEL
--     local items = tile:getItems()
--     if items then
--         for _, item in ipairs(items) do
--             if item:hasProperty(CONST_PROP_MOVEABLE) then
--                 return nil
--             end
--         end
--     end

--     return position
-- end


-- -- =========================
-- -- Craft Categories & Recipes
-- -- =========================
-- local craftCategories = {
--     [1] = {
--         name = "Containers",
--         recipes = {
--             [1] = {
--                 itemId = 2471,
--                 name = "Crate",
--                 ingredients = {
--                     { id = ITEM_WOOD, name = "Wood", count = 2 },
--                     { id = ITEM_NAIL, name = "Nail", count = 1 }
--                 }
--             },
--             [2] = {
--                 itemId = 2473,
--                 name = "Box",
--                 ingredients = {
--                     { id = ITEM_WOOD, name = "Wood", count = 2 },
--                     { id = ITEM_NAIL, name = "Nail", count = 1 }
--                 }
--             },
--             [3] = {
--                 itemId = 2472,
--                 name = "Chest",
--                 ingredients = {
--                     { id = ITEM_WOOD, name = "Wood", count = 2 },
--                     { id = ITEM_NAIL, name = "Nail", count = 1 }
--                 }
--             }
--         }
--     },

--     [2] = {
--         name = "Mobília",
--         recipes = {
--             [1] = {
--                 itemId = 11801,
--                 name = "Timber Chair",
--                 ingredients = {
--                     { id = ITEM_WOOD, name = "Wood", count = 3 },
--                     { id = ITEM_NAIL, name = "Nail", count = 2 }
--                 }
--             },
--             [2] = {
--                 itemId = 2319,
--                 name = "Small Table",
--                 ingredients = {
--                     { id = ITEM_WOOD, name = "Wood", count = 4 },
--                     { id = ITEM_NAIL, name = "Nail", count = 2 }
--                 }
--             }
--         }
--     },

--     [3] = {
--         name = "Utilitários",
--         recipes = {
--             [1] = {
--                 itemId = 27309,
--                 name = "Barricade I",
--                 ingredients = {
--                     { id = ITEM_WOOD, name = "Wood", count = 5 },
--                     { id = ITEM_NAIL, name = "Nail", count = 3 }
--                 }
--             },
--             [2] = {
--                 itemId = 27318,
--                 name = "Barricade II",
--                 ingredients = {
--                     { id = ITEM_WOOD, name = "Wood", count = 7 },
--                     { id = ITEM_NAIL, name = "Nail", count = 4 }
--                 }
--             }
--         }
--     }
-- }

-- -- =========================
-- -- Show Craft Details (Modal)
-- -- =========================
-- local function showCraftDetails(player, recipe, recipeIndex)
--     player:setStorageValue(90001, recipeIndex)

--     local text = {}
--     text[#text + 1] = string.format("%s\n", recipe.name)
--     text[#text + 1] = "Required ingredients:\n"

--     for _, ing in ipairs(recipe.ingredients) do
--         text[#text + 1] = string.format("- %dx %s", ing.count, ing.name)
--     end

--     -- =========================
--     -- Carpentry requirement (if any)
--     -- =========================
--     local req = carpentryRequirements[recipe.itemId]
--     if req then
--         text[#text + 1] = ""
--         text[#text + 1] = string.format(
--             "Carpentry: %d",
--             req.level
--         )
--     end

--     local modal = ModalWindow(
--         MODAL_DETAILS,
--         recipe.name,
--         table.concat(text, "\n")
--     )

--     modal:addButton(1, "Craft")
--     modal:addButton(2, "Back")

--     modal:setDefaultEnterButton(1)
--     modal:setDefaultEscapeButton(2)

--     modal:sendToPlayer(player)
-- end

-- -- =========================
-- -- Show Recipes by Category
-- -- =========================
-- local function showRecipesModal(player, categoryId)
--     local category = craftCategories[categoryId]
--     if not category then return end

--     player:setStorageValue(90000, categoryId)

--     local modal = ModalWindow(
--         MODAL_RECIPES,
--         category.name,
--         "Choose what you want to craft:"
--     )

--     for index, recipe in pairs(category.recipes) do
--         modal:addChoice(index, recipe.name)
--     end

--     modal:addButton(1, "Select")
--     modal:addButton(2, "Back")

--     modal:setDefaultEnterButton(1)
--     modal:setDefaultEscapeButton(2)

--     modal:sendToPlayer(player)
-- end

-- -- =========================
-- -- TalkAction !craft
-- -- =========================
-- local craftAction = TalkAction("!craft")

-- function craftAction.onSay(player)
--     local modal = ModalWindow(
--         MODAL_CATEGORY,
--         "Crafting",
--         "Choose a category:"
--     )

--     modal:addChoice(1, "Containers")
--     modal:addChoice(2, "Mobília")
--     modal:addChoice(3, "Utilitários")

--     modal:addButton(1, "Select")
--     modal:addButton(2, "Cancel")

--     modal:setDefaultEnterButton(1)
--     modal:setDefaultEscapeButton(2)

--     modal:sendToPlayer(player)
--     return false
-- end

-- craftAction:groupType("normal")
-- craftAction:register()

-- -- =========================
-- -- Modal Callback
-- -- =========================
-- local craftModal = CreatureEvent("CraftModal")

-- function craftModal.onModalWindow(player, modalId, buttonId, choiceId)

--     -- Categoria
--     if modalId == MODAL_CATEGORY then
--         if buttonId == 2 then return true end
--         showRecipesModal(player, choiceId)
--         return true
--     end

--     -- Lista de itens
--     if modalId == MODAL_RECIPES then
--         if buttonId == 2 then
--             craftAction.onSay(player)
--             return true
--         end

--         local categoryId = player:getStorageValue(90000)
--         local recipe = craftCategories[categoryId].recipes[choiceId]
--         showCraftDetails(player, recipe, choiceId)
--         return true
--     end

--     -- Detalhes + Craft
--     if modalId == MODAL_DETAILS then
--         if buttonId == 2 then
--             showRecipesModal(player, player:getStorageValue(90000))
--             return true
--         end

--         local categoryId = player:getStorageValue(90000)
--         local recipeIndex = player:getStorageValue(90001)
--         local recipe = craftCategories[categoryId].recipes[recipeIndex]

--         -- =========================
--         -- Carpentry skill check (if required)
--         -- =========================
--         local req = carpentryRequirements[recipe.itemId]
--         if req then
--             local skillLevel = player:getStorageValue(req.storage)
--             if skillLevel < req.level then
--                 player:sendCancelMessage(
--                     string.format(
--                         "You need Carpentry level %d to craft this item.",
--                         req.level
--                     )
--                 )
--                 return true
--             end
--         end

--         -- =========================
--         -- Check ingredients
--         -- =========================
--         for _, ing in ipairs(recipe.ingredients) do
--             if player:getItemCount(ing.id) < ing.count then
--                 player:sendCancelMessage("You don't have all required ingredients.")
--                 return true
--             end
--         end

--         -- =========================
--         -- Remove ingredients
--         -- =========================
--         for _, ing in ipairs(recipe.ingredients) do
--             player:removeItem(ing.id, ing.count)
--         end

--         -- =========================
--         -- Create item on player position
--         -- =========================
--         -- Game.createItem(recipe.itemId, 1, player:getPosition())
--         local createPos = getFrontFreePosition(player)
--         if not createPos then
--             player:sendCancelMessage(
--                 "You need a free and walkable tile in front of you to craft this item."
--             )
--             return true
--         end

--         Game.createItem(recipe.itemId, 1, createPos)
--         player:sendTextMessage(MESSAGE_STATUS_SMALL, "Item crafted successfully!")

--         return true
--     end

--     return false
-- end

-- craftModal:register()

-- -- =========================
-- -- Register on Login
-- -- =========================
-- local loginEvent = CreatureEvent("CraftLogin")

-- function loginEvent.onLogin(player)
--     player:registerEvent("CraftModal")
--     return true
-- end

-- loginEvent:register()


---------- TEST LOCKPICK ZOMBOID ----------------------
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

-- local LOCKPICK_ID = 7889

-- local lockpickAction = Action()

-- function lockpickAction.onUse(player, item, fromPos, target, toPos, isHotkey)

--     -- Checa se é container
--     if not target or not target:isContainer() then
--         player:sendCancelMessage("You can only lockpick containers.")
--         return true
--     end

--     local container = target -- IMPORTANTE: o container é o próprio target

--     local lootPool = {}

--     local itemCount = container:getItemHoldingCount()
--     if not itemCount or itemCount == 0 then
--         player:sendCancelMessage("The container is empty.")
--         return true
--     end

--     -- Monta pool respeitando quantidades
--     for i = 0, itemCount - 1 do
--         local lootItem = container:getItem(i)
--         if lootItem then
--             local count = lootItem:getCount() or 1
--             for c = 1, count do
--                 table.insert(lootPool, lootItem:getId())
--             end
--         end
--     end

--     if #lootPool == 0 then
--         player:sendCancelMessage("The container is empty.")
--         return true
--     end

--     -- Sorteia item
--     local stolenItemId = lootPool[math.random(#lootPool)]

--     -- Remove 1 unidade do item sorteado
--     for i = 0, itemCount - 1 do
--         local lootItem = container:getItem(i)
--         if lootItem and lootItem:getId() == stolenItemId then
--             lootItem:remove(1)
--             break
--         end
--     end

--     -- Entrega ao jogador
--     player:addItem(stolenItemId, 1)

--     player:sendTextMessage(
--         MESSAGE_STATUS_SMALL,
--         "You successfully stole an item from the container."
--     )

--     return true
-- end

-- lockpickAction:id(LOCKPICK_ID)
-- lockpickAction:register()