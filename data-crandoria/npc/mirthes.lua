local internalNpcName = "Mirthes"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 157,
	lookHead = 0,
	lookBody = 39,
	lookLegs = 63,
	lookFeet = 57,
	lookAddons = 1,
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
    npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
    npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
    npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
    npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
    npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
    npcHandler:onCloseChannel(npc, creature)
end


local BUY_LIST = {
    Sunday =  {id = 5879, name = "Spider Silks", price = 2500},
    Monday =  {id = 10282, name = "Hydra Heads", price = 750},
    Tuesday = {id = 10305, name = "Lumps of Earth", price = 150},
    Wednesday = {id = 5881, name = "Lizard Scale", price = 180},
    Thursday = {id = 3044, name = "Tusks", price = 150},
    Friday = {id = 18995, name = "Venisons", price = 75},
    Saturday = {id = 10313, name = "Winged Tails", price = 1200}
}

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

    local weekday = os.date("%A")
    local data = BUY_LIST[weekday]

    -- Jogador perguntou
    if MsgContains(message, "produto") then
        npcHandler:say(
            "Hoje estou buscando por " .. data.name .. ". Pago " .. data.price ..
            " gold coins por unidade. Tem interesse?",
            npc, creature
        )
        npcHandler:setTopic(playerId, 1)
        return true
    end

    -- Jogador aceitou
    if (MsgContains(message, "yes") or MsgContains(message, "sim")) 
    and npcHandler:getTopic(playerId) == 1 then
        npcHandler:say("Quantas unidades de " .. data.name .. " voce deseja vender?", npc, creature)
        npcHandler:setTopic(playerId, 2)
        return true
    end

    -- Jogador informou número
    if npcHandler:getTopic(playerId) == 2 then
        local amount = tonumber(message)

        if not amount or amount < 1 then
            npcHandler:say("Preciso que diga um numero valido.", npc, creature)
            return true
        end

        local itemId = data.id
        local price = data.price
        local playerCount = player:getItemCount(itemId)

        if playerCount < amount then
            npcHandler:say(
                "Voce nao possui " .. data.name .. " o suficiente. Voce tem apenas " .. playerCount .. ".", 
                npc, creature
            )
            npcHandler:setTopic(playerId, 0)
            return true
        end

        -- Transação
        player:removeItem(itemId, amount)
        local total = amount * price
        player:addMoney(total)

        npcHandler:say(
            "Perfeito! Aqui estao seus " .. total .. " gold coins. Obrigado!", 
            npc, creature
        )
        npcHandler:setTopic(playerId, 0)
        return true
    end

    return true
end


npcHandler:setMessage(MESSAGE_GREET, "Oi, caro viajante. Estou buscando por {produtos de monstros} do deserto. Que tal uma ajuda?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
