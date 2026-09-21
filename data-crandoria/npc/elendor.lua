local internalNpcName = "Elendor"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 159,
	lookHead = 78,
	lookBody = 92,
	lookLegs = 0,
	lookFeet = 76
}

npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
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

    local accessedIPs = {}

    local playerIP = player:getIp()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

    if MsgContains(message, "mission") or MsgContains(message, "missao") or MsgContains(message, "sun fruit") then
        if player:getStorageValue(Storage.Quest.Crandoria.AstralisTales.Progresso) == 2 then
            npcHandler:say("Enviado por Howard? Mesmo? Muito bem... Se Howard acha que voce da conta dessa missao, confiarei nos seus poderes... Preciso de alguem que consiga derrotar a Abominacao da Ilha e, dessa forma, reduzir seus poderes. \z
            Mas para que eu te envie para o local da alavanca, voce precisara trazer para mim uma {sun fruit}. As Sun Fruits podem ser obtidas como loot dos monstros da ilha, mas tenha cuidado! Como voce viu, eles podem, ser bem fortes.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.AstralisTales.Progresso, 3)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.AstralisTales.Progresso) == 3 then
            npcHandler:say("Em troca de uma Sun Fruit posso te levar ate a alavanca pelo tapete. Voce possui uma sun fruit com voce?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        end
    elseif MsgContains(message, "carregamento") then
        if player:getStorageValue(Storage.Quest.Crandoria.VaroQuest.Progresso) == 15 then
            if player:getItemCount(5884) >= 1 then
                player:removeItem(5884, 1)
                player:setStorageValue(Storage.Quest.Crandoria.VaroQuest.Progresso, 16)
                npcHandler:say("O carregamento demorou mais que o esperado para ser entregue, mas eu agradeco. Aqui, fique com essa singela recompensa pelo trabalho. \z", npc, creature)
                player:addItem(3043, 10)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Estou esperando por um carregamento com um item especial. Espero que nao demore a chegar...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            if accessedIPs[playerIP] and accessedIPs[playerIP] ~= player:getGuid() then
                npcHandler:say("Voce ja acessou este local com um personagem hoje.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                if player:getItemCount(29995) >= 1 then
                    player:removeItem(29995, 1)
                    npcHandler:say("Excelente. Aqui esta sua passagem e boa sorte!", npc, creature)
                    player:teleportTo(Position(4745, 4479, 4))
                    accessedIPs[playerIP] = player:getGuid()
                    npcHandler:setTopic(playerId, 0)
                else
                    npcHandler:say("Voce nao possui a sun fruit...", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                end
            end
        end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) then
        npcHandler:say("Ok. Sem problemas!", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. O que faz por aqui?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Boa sorte!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)

