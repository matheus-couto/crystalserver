local internalNpcName = "Victoria"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 1461,
	lookHead = 0,
	lookBody = 114,
	lookLegs = 74,
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

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

    if MsgContains(message, "aprimoramento") or MsgContains(message, "improvement") then
        npcHandler:say("Voce pode continuar usando essas roupas sujas com cheiro de aventura por ai, mas um nobre guerreiro tambem pode se vestir bem, sabe? ... \z
        Eu posso te oferecer um formal dress {outfit}, assim como seus {addons}, para que voce fique mais apresentavel. Mas ja vou logoa visando que nao sera barato...", npc, creature)
        npcHandler:setTopic(playerId, 0)
    elseif MsgContains(message, "outfit") then
        if player:hasOutfit(1460, 0) or player:hasOutfit(1461, 0) then
            npcHandler:say("Voce ja possui esse outfit.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        else
            npcHandler:say("O Formal Dress Outfit vai te custar miseros 5.000.000 gold coins. Voce possui esse valor consigo?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        end
    elseif MsgContains(message, "addon") then
        npcHandler:say("Qual addon voce deseja obter: o {primeiro} ou o {segundo}?", npc, creature)
        npcHandler:setTopic(playerId, 2)
    elseif MsgContains(message, "primeiro") then
        if npcHandler:getTopic(playerId) == 2 then
            if player:hasOutfit(1460, 1) or player:hasOutfit(1461, 1) then
                npcHandler:say("Voce ja possui o primeiro addon.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("O primeiro addon sera entregue em troca de 1 Gearwheel Chain. Voce possui o item com voce?", npc, creature)
                npcHandler:setTopic(playerId, 3)
            end
        end
    elseif MsgContains(message, "segundo") then
        if npcHandler:getTopic(playerId) == 2 then
            if player:hasOutfit(1460, 2) or player:hasOutfit(1461, 2) then
                npcHandler:say("Voce ja possui o segundo addon.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Para o segundo addon voce precisara possuir ao menos 25.000.000 gold coins e os seguintes itens: 1 Castle Shield, 1 Rift Bow e 1 Snake God's Wristguard. Esta com tudo ai?", npc, creature)
                npcHandler:setTopic(playerId, 4)
            end
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        local money = player:getBankBalance() + player:getMoney()
        if npcHandler:getTopic(playerId) == 1 then
            if money >= 5000000 then
                player:removeMoneyBank(5000000)
                player:addOutfit(1460, 0)
                player:addOutfit(1461, 0)
                local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                npcHandler:say("Muito bem! Vejo que conseguir essa quantia nao foi problema para voce. Aqui esta! Me avise se quiser os {addons}", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui dinheiro suficiente. Parece que a jornada nao esta rendendo tanto assim...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 3 then
            if player:getItemCount(21170) >= 1 then
                player:removeItem(21170, 1)
                player:addOutfitAddon(1460, 1)
                player:addOutfitAddon(1460, 1)
                local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                npcHandler:say("Perfeito! Estes amuletos sao raros por aqui, voce sabia? Muito obrigada! Aqui esta seu primeiro addon.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Nao tente me enganar, jovem... Isso nao tem classe nenhuma.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 4 then
            if money >= 25000000 and player:getItemCount(22866) >= 1 and player:getItemCount(11691) >= 1 and player:getItemCount(3435) >= 1 then
                player:removeItem(22866, 1)
                player:removeItem(11691, 1)
                player:removeItem(3435, 1)
                player:removeMoneyBank(25000000)
                player:addOutfitAddon(1460, 2)
                player:addOutfitAddon(1460, 2)
                local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                npcHandler:say("Voce conseguiu mesmo todos os itens?! Que incrivel! Minha colecao de itens raros esta ainda mais valiosa agora! Aqui, como combinado, seu novo addon.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) and npcHandler:getTopic(playerId) == 1 then
        npcHandler:say("Entao nao perca nosso tempo!", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Um dos guerreiros de confianca de Haldor... Muito interessante. Talvez seja a hora de um {aprimoramento}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus e boa sorte!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
