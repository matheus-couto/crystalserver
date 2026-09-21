local internalNpcName = "Tom Imbuer"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 1

npcConfig.outfit = {
	lookType = 131,
	lookHead = 0,
	lookBody = 114,
	lookLegs = 84,
	lookFeet = 114,
    	lookAddons = 3,
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

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()
    local money = player:getMoney() + player:getBankBalance()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

    if MsgContains(message, "vampirism") and npcHandler:getTopic(playerId) == 0 then
        npcHandler:say("Eu vendo os itens para os imbuements de vampirism {basic}, {intricate} e {powerful}. Qual deles voce deseja adquirir?", npc, creature)
        npcHandler:setTopic(playerId, 1)
    elseif MsgContains(message, "void") and npcHandler:getTopic(playerId) == 0 then
        npcHandler:say("Eu vendo os itens para os imbuements de void {basic}, {intricate} e {powerful}. Qual deles voce deseja adquirir?", npc, creature)
        npcHandler:setTopic(playerId, 2)
    elseif MsgContains(message, "strike") and npcHandler:getTopic(playerId) == 0 then
        npcHandler:say("Eu vendo os itens para os imbuements de strike {basic}, {intricate} e {powerful}. Qual deles voce deseja adquirir?", npc, creature)
        npcHandler:setTopic(playerId, 3)
    elseif MsgContains(message, "basic") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Gostaria de comprar os itens necessarios para o imbuement nivel basico de vampirism por 300.000 gold coins?", npc, creature)
            npcHandler:setTopic(playerId, 4)
        elseif npcHandler:getTopic(playerId) == 2 then
            npcHandler:say("Gostaria de comprar os itens necessarios para o imbuement nivel basico de void por 300.000 gold coins?", npc, creature)
            npcHandler:setTopic(playerId, 5)
        elseif npcHandler:getTopic(playerId) == 3 then
            npcHandler:say("Gostaria de comprar os itens necessarios para o imbuement nivel basico de strike por 300.000 gold coins?", npc, creature)
            npcHandler:setTopic(playerId, 6)
        end
    elseif MsgContains(message, "intricate") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Gostaria de comprar os itens necessarios para o imbuement nivel intricate de vampirism por 600.000 gold coins?", npc, creature)
            npcHandler:setTopic(playerId, 7)
        elseif npcHandler:getTopic(playerId) == 2 then
            npcHandler:say("Gostaria de comprar os itens necessarios para o imbuement nivel intricate de void por 600.000 gold coins?", npc, creature)
            npcHandler:setTopic(playerId, 8)
        elseif npcHandler:getTopic(playerId) == 3 then
            npcHandler:say("Gostaria de comprar os itens necessarios para o imbuement nivel intricate de strike por 600.000 gold coins?", npc, creature)
            npcHandler:setTopic(playerId, 9)
        end
    elseif MsgContains(message, "powerful") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Gostaria de comprar os itens necessarios para o imbuement nivel powerful de vampirism por 900.000 gold coins?", npc, creature)
            npcHandler:setTopic(playerId, 10)
        elseif npcHandler:getTopic(playerId) == 2 then
            npcHandler:say("Gostaria de comprar os itens necessarios para o imbuement nivel powerful de void por 900.000 gold coins?", npc, creature)
            npcHandler:setTopic(playerId, 11)
        elseif npcHandler:getTopic(playerId) == 3 then
            npcHandler:say("Gostaria de comprar os itens necessarios para o imbuement nivel powerful de strike por 900.000 gold coins?", npc, creature)
            npcHandler:setTopic(playerId, 12)
        end
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
        if npcHandler:getTopic(playerId) == 4 then
            if money >= 300000 then
                player:removeMoneyBank(300000)
                player:addItem(9685, 25)
                npcHandler:say("Aqui estao os itens. Me avise se precisar de algo mais.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui dinheiro suficiente.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 5 then
            if money >= 300000 then
                player:removeMoneyBank(300000)
                player:addItem(11492, 25)
                npcHandler:say("Aqui estao os itens. Me avise se precisar de algo mais.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui dinheiro suficiente.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 6 then
            if money >= 300000 then
                player:removeMoneyBank(300000)
                player:addItem(11444, 20)
                npcHandler:say("Aqui estao os itens. Me avise se precisar de algo mais.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui dinheiro suficiente.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 7 then
            if money >= 600000 then
                player:removeMoneyBank(600000)
                player:addItem(9685, 25)
                player:addItem(9633, 15)
                npcHandler:say("Aqui estao os itens. Me avise se precisar de algo mais.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui dinheiro suficiente.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 8 then
            if money >= 600000 then
                player:removeMoneyBank(600000)
                player:addItem(11492, 25)
                player:addItem(20200, 25)
                npcHandler:say("Aqui estao os itens. Me avise se precisar de algo mais.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui dinheiro suficiente.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 9 then
            if money >= 600000 then
                player:removeMoneyBank(600000)
                player:addItem(11444, 20)
                player:addItem(10311, 25)
                npcHandler:say("Aqui estao os itens. Me avise se precisar de algo mais.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui dinheiro suficiente.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 10 then
            if money >= 900000 then
                player:removeMoneyBank(900000)
                player:addItem(9685, 25)
                player:addItem(9633, 15)
                player:addItem(9663, 5)
                npcHandler:say("Aqui estao os itens. Me avise se precisar de algo mais.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui dinheiro suficiente.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 11 then
            if money >= 900000 then
                player:removeMoneyBank(900000)
                player:addItem(11492, 25)
                player:addItem(20200, 25)
                player:addItem(22730, 5)
                npcHandler:say("Aqui estao os itens. Me avise se precisar de algo mais.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui dinheiro suficiente.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 12 then
            if money >= 900000 then
                player:removeMoneyBank(900000)
                player:addItem(11444, 20)
                player:addItem(10311, 25)
                player:addItem(22728, 5)
                npcHandler:say("Aqui estao os itens. Me avise se precisar de algo mais.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui dinheiro suficiente.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    end
end



npcHandler:setMessage(MESSAGE_GREET, "Ola, nobre viajante. Eu vendo itens de imbuements para {vampirism}, {void} e {strike}. Basta me dizer caso se interesse por algum.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais e boa sorte!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
