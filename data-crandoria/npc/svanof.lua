local internalNpcName = "Svanof"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 143,
	lookHead = 32,
	lookBody = 44,
	lookLegs = 55,
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
    Sunday =  {id = 9650, name = "Polar Bear Paws", price = 150},
    Monday =  {id = 7290, name = "Shards", price = 2200},
    Tuesday = {id = 9661, name = "Frosty Hearts", price = 350},
    Wednesday = {id = 5911, name = "Red Pieces of Cloth", price = 600},
    Thursday = {id = 10321, name = "Mammoth Tusks", price = 150},
    Friday = {id = 7159, name = "Green Perches", price = 150},
    Saturday = {id = 9666, name = "Sea Serpent Scales", price = 600}
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
            "Hoje estou comprando " .. data.name .. ". Pago " .. data.price ..
            " gold coins por cada uma. Esta interessado?",
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
                "Voce nao possui " .. data.name .. " em numero suficiente. Voce tem apenas " .. playerCount .. ".", 
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
            "Muito bem. Aqui estao seus " .. total .. " gold coins. Boa sorte nas proximas aventuras!", 
            npc, creature
        )
        npcHandler:setTopic(playerId, 0)
        return true
    end

    return true
end


npcHandler:setMessage(MESSAGE_GREET, "Saudacoes! Estou buscando por {produtos de monstros} encontrados pelas Ice Lands. Se possuir algum, podemos negociar.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
