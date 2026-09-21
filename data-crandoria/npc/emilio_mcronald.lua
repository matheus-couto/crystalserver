local internalNpcName = "Emilio McRonald"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 128,
	lookHead = 30,
	lookBody = 75,
	lookLegs = 22,
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
    local house = player:getHouse()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end


    if MsgContains(message, "cultivo") or MsgContains(message, "farm") or MsgContains(message, "cultivar") or MsgContains(message, "fazenda") then
        if player:getLevel() >= 500 then
            if not house then
                if player:getStorageValue(Storage.Quest.Crandoria.NovasColetas.RentFarmDaily) <= os.time() then
                    -- if player:getStorageValue(Storage.Quest.Crandoria.NovasColetas.RentFarm) >= 1 then
                    --     npcHandler:say("O que esta esperando? Seu cultivo ainda nao acabou, volte para o trabalho! Ha ha ha...", npc, creature)
                    --     npcHandler:setTopic(playerId, 0)
                    -- else
                    npcHandler:say("Eu possuo dez areas de plantio {especiais} para alugar. O valor do aluguel de cada uma e de 5 gold tokens e voce podera utilizar a terra para cultivar 150 vezes ou pelo periodo de 20 minutos. Voce gostaria de alugar uma area?", npc, creature)
                    npcHandler:setTopic(playerId, 1)
                    -- end
                else
                    if player:getStorageValue(Storage.Quest.Crandoria.NovasColetas.RentFarm) > 150 then
                        npcHandler:say("Esta querendo acabar com a fertilidade do meu solo? Ja chega de cultivo por hoje. Volte amanha e terei uma nova area disponivel para voce.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Voce nem mesmo terminou seu cultivo e ja quer alugar uma nova area? Termine seu trabalho e depois conversamos.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                end
            elseif house then
                if house:getTown():getId() == 16 or house:getTown():getId() == 1 then
                    npcHandler:say("Voce ja possui uma fazenda em Astralis, portanto nao posso alugar um pedaco de terra para voce.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                else
                    if player:getStorageValue(Storage.Quest.Crandoria.NovasColetas.RentFarmDaily) <= os.time() then
                        -- if player:getStorageValue(Storage.Quest.Crandoria.NovasColetas.RentFarm) >= 1 then
                        --     npcHandler:say("O que esta esperando? Seu cultivo ainda nao acabou, volte para o trabalho! Ha ha ha...", npc, creature)
                        --     npcHandler:setTopic(playerId, 0)
                        -- else
                        npcHandler:say("Eu possuo dez areas de plantio {especiais} para alugar. O valor do aluguel de cada uma e de 5 gold tokens e voce podera utilizar a terra para cultivar 250 vezes ou pelo periodo de 20 minutos. Voce gostaria de alugar uma area?", npc, creature)
                        npcHandler:setTopic(playerId, 1)
                        -- end
                    else
                        if player:getStorageValue(Storage.Quest.Crandoria.NovasColetas.RentFarm) > 150 then
                            npcHandler:say("Esta querendo acabar com a fertilidade do meu solo? Ja chega de cultivo por hoje. Volte amanha e terei uma nova area disponivel para voce.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        else
                            npcHandler:say("Voce nem mesmo terminou seu cultivo e ja quer alugar uma nova area? Termine seu trabalho e depois conversamos.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        end
                    end
                end
            end
        else
            npcHandler:say("Voce parece muito inexperiente para querer cultivar em um solo tao rico quanto o meu. Volte quando estiver mais experiente, talvez apos o nivel 500.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            if player:removeItem(22721, 5) then
                npcHandler:say("Excelente! Voce tera um dia inteiro para cultivar ate 200 vezes. E lembre-se: Apenas apos terminar todo o cultivo voce podera alugar uma nova area!", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.NovasColetas.RentFarmDaily, os.time() + 24 * 60 * 60)
                player:setStorageValue(Storage.Quest.Crandoria.NovasColetas.RentFarm, 1)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui a quantidade necessaria de Gold Tokens.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) and npcHandler:getTopic(playerId) == 1 then
        npcHandler:say("Sem problemas! me procure se mudar de ideia.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    elseif MsgContains(message, "especial") or MsgContains(message, "especiais") or MsgContains(message, "special") then
        npcHandler:say("Meu fertilizante especial faz com que meus campos produtivos produzam muito mais e mais rapido! Eu te garanto que voce nao vai se arrepender. Gostaria de alugar uma area?", npc, creature)
        npcHandler:setTopic(playerId, 1)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola! Precisa de um campo livre para {cultivar}? Alugue um aqui mesmo!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais! Volte quando quiser usar a forja.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
