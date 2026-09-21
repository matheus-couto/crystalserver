local internalNpcName = "Hermeto Pascoal"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 153,
	lookHead = 0,
	lookBody = 112,
	lookLegs = 84,
	lookFeet = 26,
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

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

    if MsgContains(message, "montaria") or MsgContains(message, "mount") then
        if player:hasMount(138) then
            npcHandler:say("Voce ja possui essa montaria. Nao fique por ai se exibindo!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        else
            npcHandler:say("Eu posso te ajudar com isso, claro. Mas em troca vou precisar de algumas {cenouras especiais} para alimentar os coelhos da minha fazenda. Digamos... 250 cenouras. Voce possui essa quantidade com voce?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        end
    elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
        if npcHandler:getTopic(playerId) == 0 then
            npcHandler:say("Eu posso te ajudar com isso, claro. Mas em troca vou precisar de algumas {cenouras especiais} para alimentar os coelhos da minha fazenda. Digamos... 250 cenouras. Voce possui essa quantidade com voce?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        elseif npcHandler:getTopic(playerId) == 1 then
            if player:getItemCount(3250) >= 250 then
                player:removeItem(3250, 250)
                player:addMount(138)
                player:setStorageValue(Storage.Quest.Crandoria.Mounts.RabbitRickshaw, 1)
                player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
                npcHandler:say("Excelente, jovem! Aqui esta sua nova montaria! Por favor, tome conta dos coelhos. E cuidado!! Eles sao muito rapidos.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Ei, ei, ei! Nao tente enganar as pessoas, jovem gafanhoto... Volte quando tiver as cenouras especiais em quantidade suficiente.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "no") or MsgContains(message, "nao") then
        if npcHandler:getTopic(playerId) < 1 then
            npcHandler:say("Ah... Tudo bem. Volte se mudar de ideia.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Sem problemas! Volte quando estiver com todas as cenouras especiais e eu te entregarei sua montaria.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    end
end


keywordHandler:addKeyword({'cenouras especiais'}, StdModule.say, {npcHandler = npcHandler, text = 'As cenouras especiais podem ser obtidas de qualquer monstro enquanto eu e minha esposa, Gertrudes, estivermos em Crandoria.'})

npcHandler:setMessage(MESSAGE_GREET, "Ola. Ja pensou em utilizar coelhos puxando um carrinho no lugar de sua {montaria}?.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
