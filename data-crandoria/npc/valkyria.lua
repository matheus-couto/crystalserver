local internalNpcName = "Valkyria"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 929,
	lookHead = 36,
	lookBody = 94,
	lookLegs = 48,
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

local accessedIPs = {}

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

    local playerIP = player:getIp()

    local timer = player:getStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Timer)
    local storage = player:getStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Progresso)

    if MsgContains(message, "mission") or MsgContains(message, "missao") or MsgContains(message, "tarefa") then
        if player:getLevel() < 250 then
            npcHandler:say("Voce esta muito fraco. Volte quando tiver nivel 250 ou superior para realizar as missoes.", npc, creature)
            npcHandler:setTopic(playerId, 0) 
        else
            if accessedIPs[playerIP] and accessedIPs[playerIP] ~= player:getGuid() then
                player:teleportTo(Position(4934, 4962, 6))
                npcHandler:setTopic(playerId, 0)
            else
                if timer < os.time() then
                    -- if player:getStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Progresso) < 1 then
                    local chance = math.random(1, 10)
                    if chance == 1 then
                        npcHandler:say("Estamos preparando a festa de aniversario da cidade e precisamos de alguns ingredientes. Traga-me 10 Dragonfruits para preencher nossa cesta de frutas, por favor.\z
                        Estarei esperando ansiosa pelo seu retorno! (voce tem 12 horas para entregar a missao)", npc, creature)
                        player:setStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Progresso, 1) 
                        player:setStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Timer, os.time() + 12 * 60 * 60)
                        accessedIPs[playerIP] = player:getGuid()
                        npcHandler:setTopic(playerId, 0)
                    elseif chance == 2 or chance == 3 then
                        npcHandler:say("Estamos preparando a festa de aniversario da cidade e precisamos de alguns ingredientes. Traga-me 20 Jalapeno Peppers para temperar nossas carnes, por favor.\z
                        Estarei esperando ansiosa pelo seu retorno! (voce tem 12 horas para entregar a missao)", npc, creature)
                        player:setStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Progresso, 2) 
                        player:setStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Timer, os.time() + 12 * 60 * 60)
                        accessedIPs[playerIP] = player:getGuid()
                        npcHandler:setTopic(playerId, 0)
                    elseif chance == 4 then
                        npcHandler:say("Estamos preparando a festa de aniversario da cidade e precisamos de alguns pratos especificos. Ouvi dizer que Mushroom Pies sao as favoritas do King Tibianus... \z
                        Que tal isso: Traga-me 25 Mushroom Pies e te darei um presente como recompensa. Estarei esperando! (voce tem 12 horas para entregar a missao)", npc, creature)
                        player:setStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Progresso, 3) 
                        player:setStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Timer, os.time() + 12 * 60 * 60)
                        accessedIPs[playerIP] = player:getGuid()
                        npcHandler:setTopic(playerId, 0)
                    elseif chance == 5 then
                        npcHandler:say("Estamos preparando a festa de aniversario da cidade e precisamos de alguns ingredientes, mais especificamente cogumelos para colocar em nosso molho de carnes. \z
                        Que tal isso: Traga-me 20 Wood Mushrooms e te darei um presente como recompensa. Estarei esperando ansiosa pelo seu retorno! (voce tem 12 horas para entregar a missao)", npc, creature)
                        player:setStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Progresso, 4) 
                        player:setStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Timer, os.time() + 12 * 60 * 60)
                        accessedIPs[playerIP] = player:getGuid()
                        npcHandler:setTopic(playerId, 0)
                    elseif chance == 6 then
                        npcHandler:say("Precisamos urgentemente de ovos para fazer o bolo de aniversario da cidade de Crandoria. Mas nao pode ser qualquer ovo, precisamos de ovos de tartaruga! \z
                        Traga-me 10 Tortoise Eggs e te darei um presente como recompensa. Estarei esperando! (voce tem 12 horas para entregar a missao)", npc, creature)
                        player:setStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Progresso, 5) 
                        player:setStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Timer, os.time() + 12 * 60 * 60)
                        accessedIPs[playerIP] = player:getGuid()
                        npcHandler:setTopic(playerId, 0)
                    elseif chance == 7 then
                        npcHandler:say("Os queijos dos Corym sao muito macios e suculentos. Ouvi dizer que o Comandante Crassus gosta muito desses queijos e queremos surpreende-lo no aniversario da cidade. \z
                        Traga-me 25 Soft Cheeses e te darei um presente como recompensa. Estarei esperando! (voce tem 12 horas para entregar a missao)", npc, creature)
                        player:setStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Progresso, 6) 
                        player:setStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Timer, os.time() + 12 * 60 * 60)
                        accessedIPs[playerIP] = player:getGuid()
                        npcHandler:setTopic(playerId, 0)
                    elseif chance == 8 then
                        npcHandler:say("Estamos preparando a festa de aniversario da cidade e precisamos de alguns ingredientes, mais especificamente cogumelos para colocar em nosso molho de peixes. \z
                        Que tal isso: Traga-me 25 Orange Mushrooms e te darei um presente como recompensa. Estarei esperando ansiosa pelo seu retorno! (voce tem 12 horas para entregar a missao)", npc, creature)
                        player:setStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Progresso, 7) 
                        player:setStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Timer, os.time() + 12 * 60 * 60)
                        accessedIPs[playerIP] = player:getGuid()
                        npcHandler:setTopic(playerId, 0)
                    elseif chance == 9 then
                        npcHandler:say("Estamos preparando a festa de aniversario da cidade e precisamos de alguns ingredientes, mais especificamente cogumelos para colocar em nosso molho de peixes. \z
                        Que tal isso: Traga-me 25 Fire Mushrooms e te darei um presente como recompensa. Estarei esperando ansiosa pelo seu retorno! (voce tem 12 horas para entregar a missao)", npc, creature)
                        player:setStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Progresso, 8) 
                        player:setStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Timer, os.time() + 12 * 60 * 60)
                        accessedIPs[playerIP] = player:getGuid()
                        npcHandler:setTopic(playerId, 0)
                    elseif chance == 10 then
                        npcHandler:say("Alguns dos habitantes de Crandoria amam iguarias que nao encontramos por aqui. Queremos trazer algumas dessas iguarias para compor a mesa de refeicoes no aniversario da cidade. \z
                        Que tal isso: Traga-me 20 Prickly Pears e te darei um presente como recompensa. Estarei esperando ansiosa pelo seu retorno! (voce tem 12 horas para entregar a missao)", npc, creature)
                        player:setStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Progresso, 9) 
                        player:setStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Timer, os.time() + 12 * 60 * 60)
                        accessedIPs[playerIP] = player:getGuid()
                        npcHandler:setTopic(playerId, 0)
                    end
                else
                    if storage == 1 then
                        npcHandler:say("Voce trouxe as 10 Dragonfruits que eu pedi?", npc, creature)
                        npcHandler:setTopic(playerId, 1)
                    elseif storage == 2 then
                        npcHandler:say("Voce trouxe as 20 Jalapeno Peppers que eu pedi?", npc, creature)
                        npcHandler:setTopic(playerId, 2)
                    elseif storage == 3 then
                        npcHandler:say("Voce trouxe as 25 Mushroom Pies que eu pedi?", npc, creature)
                        npcHandler:setTopic(playerId, 3)
                    elseif storage == 4 then
                        npcHandler:say("Voce trouxe os 20 Wood Mushrooms que eu pedi?", npc, creature)
                        npcHandler:setTopic(playerId, 4)
                    elseif storage == 5 then
                        npcHandler:say("Voce trouxe os 10 Tortoise Eggs que eu pedi?", npc, creature)
                        npcHandler:setTopic(playerId, 5)
                    elseif storage == 6 then
                        npcHandler:say("Voce trouxe os 25 Soft Cheeses que eu pedi?", npc, creature)
                        npcHandler:setTopic(playerId, 6)
                    elseif storage == 7 then
                        npcHandler:say("Voce trouxe os 25 Orange Mushrooms que eu pedi?", npc, creature)
                        npcHandler:setTopic(playerId, 7)
                    elseif storage == 8 then
                        npcHandler:say("Voce trouxe os 25 Fire Mushrooms que eu pedi?", npc, creature)
                        npcHandler:setTopic(playerId, 8)
                    elseif storage == 9 then
                        npcHandler:say("Voce trouxe as 20 Prickly Pears que eu pedi?", npc, creature)
                        npcHandler:setTopic(playerId, 9)
                    elseif storage == 0 then
                        npcHandler:say("Voce deve aguardar 12 horas entre cada missao recebida.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                end
            end
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            if player:getItemCount(11682) >= 10 then
                player:removeItem(11682, 10)
                player:addExperience(player:getLevel() * 10000)
                player:addItem(25302, 1)
                player:setStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Progresso, 0) 
                npcHandler:say("Muito obrigada! Aqui esta! Um presente para voce.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui os itens.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getItemCount(8016) >= 20 then
                player:removeItem(8016, 20)
                player:addExperience(player:getLevel() * 10000)
                player:addItem(25302, 1)
                player:setStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Progresso, 0) 
                npcHandler:say("Muito obrigada! Aqui esta! Um presente para voce.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui os itens.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 3 then
            if player:getItemCount(16103) >= 25 then
                player:removeItem(16103, 25)
                player:addExperience(player:getLevel() * 10000)
                player:addItem(25302, 1)
                player:setStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Progresso, 0) 
                npcHandler:say("Muito obrigada! Aqui esta! Um presente para voce.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui os itens.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 4 then
            if player:getItemCount(3727) >= 20 then
                player:removeItem(3727, 20)
                player:addExperience(player:getLevel() * 10000)
                player:addItem(25302, 1)
                player:setStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Progresso, 0) 
                npcHandler:say("Muito obrigada! Aqui esta! Um presente para voce.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui os itens.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 5 then
            if player:getItemCount(5678) >= 10 then
                player:removeItem(5678, 10)
                player:addExperience(player:getLevel() * 10000)
                player:addItem(25302, 1)
                player:setStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Progresso, 0) 
                npcHandler:say("Muito obrigada! Aqui esta! Um presente para voce.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui os itens.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 6 then
            if player:getItemCount(17820) >= 25 then
                player:removeItem(17820, 25)
                player:addExperience(player:getLevel() * 10000)
                player:addItem(25302, 1)
                player:setStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Progresso, 0) 
                npcHandler:say("Muito obrigada! Aqui esta! Um presente para voce.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui os itens.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 7 then
            if player:getItemCount(3726) >= 25 then
                player:removeItem(3726, 25)
                player:addExperience(player:getLevel() * 10000)
                player:addItem(25302, 1)
                player:setStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Progresso, 0) 
                npcHandler:say("Muito obrigada! Aqui esta! Um presente para voce.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui os itens.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 8 then
            if player:getItemCount(3731) >= 25 then
                player:removeItem(3731, 25)
                player:addExperience(player:getLevel() * 10000)
                player:addItem(25302, 1)
                player:setStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Progresso, 0) 
                npcHandler:say("Muito obrigada! Aqui esta! Um presente para voce.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui os itens.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 9 then
            if player:getItemCount(22185) >= 20 then
                player:removeItem(22185, 20)
                player:addExperience(player:getLevel() * 10000)
                player:addItem(25302, 1)
                player:setStorageValue(Storage.Quest.Crandoria.Eventos.Aniversario.Progresso, 0) 
                npcHandler:say("Muito obrigada! Aqui esta! Um presente para voce.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui os itens.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) and npcHandler:getTopic(playerId) == 1 then
        npcHandler:say("Sem problemas.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola, habitante de Crandoria. Gostaria de me ajudar com uma {tarefa}? Prometo que nao sera dificil.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus e boa sorte!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
