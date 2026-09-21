local internalNpcName = "Mirana"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 139,
	lookHead = 36,
	lookBody = 94,
	lookLegs = 114,
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

    if MsgContains(message, "mission") or MsgContains(message, "missao") then
        npcHandler:say("Eu nao tenho missoes para voce, mas posso te dar {permissao} para acessar as masmorras pela porta ao lado.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    elseif MsgContains(message, "permissao") or MsgContains(message, "permission") then
        local chance = math.random(1, 10)
        if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Mirana.TimerDoor) > os.time() then
            npcHandler:say("Sua ultima permissao ainda esta valendo!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        else
            if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Mirana.TimerQuest) < os.time() then
                if chance < 5 then
                    npcHandler:say("Traga-me 5 Red Pieces of Cloth e te darei permissoa para passar pela porta pelas proximas 24 horas.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.Viridia.Mirana.TimerQuest, os.time() + 24 * 60 * 60)
                    player:setStorageValue(Storage.Quest.Crandoria.Viridia.Mirana.TimerItem, 1)
                elseif chance >= 5 and chance < 8 then
                    npcHandler:say("Se me trouxer um bonelord shield te darei acesso as masmorras por 24 horas.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.Viridia.Mirana.TimerQuest, os.time() + 24 * 60 * 60)
                    player:setStorageValue(Storage.Quest.Crandoria.Viridia.Mirana.TimerItem, 2)
                elseif chance == 8 or chance == 9 then
                    npcHandler:say("Preciso fazer um amuleto da sorte. Traga-me 1 Bear Paw e te darei acesso as masmorras por 24 horas.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.Viridia.Mirana.TimerQuest, os.time() + 24 * 60 * 60)
                    player:setStorageValue(Storage.Quest.Crandoria.Viridia.Mirana.TimerItem, 3)
                elseif chance == 10 then
                    npcHandler:say("Minha Dragon Scale Mail se partiu enquanto eu lutava contra um Hero. Traga-me uma nova e te darei acesso as masmorras por 24 horas.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.Viridia.Mirana.TimerQuest, os.time() + 24 * 60 * 60)
                    player:setStorageValue(Storage.Quest.Crandoria.Viridia.Mirana.TimerItem, 4)
                end
            else
                if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Mirana.TimerItem) == 1 then
                    npcHandler:say("Voce trouxe os 5 Red Pieces of Cloth que eu havia pedido?", npc, creature)
                    npcHandler:setTopic(playerId, 1)
                elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Mirana.TimerItem) == 2 then
                    npcHandler:say("Voce trouxe o Bonelord Shield que eu havia pedido?", npc, creature)
                    npcHandler:setTopic(playerId, 2)
                elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Mirana.TimerItem) == 3 then
                    npcHandler:say("Voce trouxe 1 Bear Paw como eu havia pedido?", npc, creature)
                    npcHandler:setTopic(playerId, 3)
                elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Mirana.TimerItem) == 4 then
                    npcHandler:say("Voce tem a Dragon Scale Mail com voce?", npc, creature)
                    npcHandler:setTopic(playerId, 4)
                end
            end
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            if player:getItemCount(5911) >= 5 then
                npcHandler:say("Muito bem! Excelente. Farei uma nova capa com esse tecido. Va! Voce tem minha permissao para passar pela porta pelas proximas 24 horas.", npc, creature)
                player:removeItem(5911, 5)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Mirana.TimerDoor, os.time() + 24 * 60 * 60)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Mirana.TimerQuest, os.time() + 24 * 60 * 60)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Mirana.TimerItem, 0)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("E onde estao os itens?", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getItemCount(3418) >= 1 then
                npcHandler:say("Que otimo! Estou procurando um desses ha dias para a minha colecao! Certo, voce pode passar pela porta pelas proximas 24 horas.", npc, creature)
                player:removeItem(3418, 1)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Mirana.TimerDoor, os.time() + 24 * 60 * 60)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Mirana.TimerQuest, os.time() + 24 * 60 * 60)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Mirana.TimerItem, 0)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("E onde esta o Bonelord Shield?", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 3 then
            if player:getItemCount(5896) >= 1 then
                npcHandler:say("Este item dara um otimo amuleto! Obrigada. Voce tem minha permissao para passar pela porta pelas proximas 24 horas.", npc, creature)
                player:removeItem(5896, 1)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Mirana.TimerDoor, os.time() + 24 * 60 * 60)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Mirana.TimerQuest, os.time() + 24 * 60 * 60)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Mirana.TimerItem, 0)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("E onde esta o item?", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 3 then
            if player:getItemCount(3386) >= 1 then
                npcHandler:say("Maravilha! Ela esta em otimo estado. Obrigada. Te garanto acesso as masmorras pelas proximas 24 horas.", npc, creature)
                player:removeItem(3386, 1)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Mirana.TimerDoor, os.time() + 24 * 60 * 60)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Mirana.TimerQuest, os.time() + 24 * 60 * 60)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Mirana.TimerItem, 0)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("E onde esta a armadura?", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) and npcHandler:getTopic(playerId) == 1 then
        npcHandler:say("Entao nao perca nosso tempo!", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "O que faz aqui?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus e boa sorte!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("missao", "bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
