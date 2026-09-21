local internalNpcName = "Mlepnus"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 130,
	lookHead = 36,
	lookBody = 110,
	lookLegs = 114,
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

    local knight = player:getVocation():getBaseId() == VOCATION.BASE_ID.KNIGHT
    local paladin = player:getVocation():getBaseId() == VOCATION.BASE_ID.PALADIN
    local monk = player:getVocation():getBaseId() == VOCATION.BASE_ID.MONK
    local druid = player:getVocation():getBaseId() == VOCATION.BASE_ID.DRUID
    local sorcerer = player:getVocation():getBaseId() == VOCATION.BASE_ID.SORCERER


    if MsgContains(message, "crandoria") or MsgContains(message, "Crandoria") then
        if player:getLevel() < 100 then
            npcHandler:say("Para sair de Viridia voce precisa obter a {permissao} do Almirante Haldor.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        else
            npcHandler:say("Tem certeza de que deseja sair de Viridia para viver em Crandoria? Apos deixar este local voce nunca mais podera retornar!", npc, creature)
            npcHandler:setTopic(playerId, 1)
        end
    elseif MsgContains(message, "permissao") then
        if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Permissao) < 1 then
            npcHandler:say("Para que o Almirante Haldor te deixe sair de Viridia, voce precisa atingir o nivel 100 e entao requisitar a ele sua permissao. Retorne apos conseguir e te levarei para Crandoria.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        else
            npcHandler:say("Vejo que voce ja possui permissao para deixar Viridia. Ja registrou suas conquistas com o Almirante Haldor? Deseja ir embora para Crandoria? (apos decidir nao ha mais como retornar)", npc, creature)
            npcHandler:setTopic(playerId, 1)
        end
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Muito bem. A partir do momento em que voce sair, recebera recompensas de acordo com suas conquistas alcancadas neste local e registradas com o Almirante Haldor. Pergunto novamente: Tem certeza de que ja deseja ir embora?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getLevel() < 100 then
                npcHandler:say("Voce nao pode deixar este lugar com nivel inferior a 100.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                if player:getFreeBackpackSlots() < 6 or player:getFreeCapacity() < 500 then
                    npcHandler:say("Voce precisa ter ao menos 6 espacos vazios na backpack e 500 oz de cap livre para viajar.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                else
------------------------------------- EXP --------------------------------------
                    if player:getHouse() then
                        npcHandler:say("Voce nao pode deixar Viridia enquanto possui uma casa na ilha.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    else
                        local rep = math.max(0, player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points))
                        local storages = {
                            {storage = Storage.Quest.Crandoria.Viridia.Conquistas.Level, value = 1, rate = 1},
                            {storage = Storage.Quest.Crandoria.Viridia.Conquistas.Level, value = 2, rate = 2},
                            {storage = Storage.Quest.Crandoria.Viridia.Haldor.Progresso, value = 35, rate = 1},
                            -- {storage = Storage.Quest.Crandoria.Viridia.Conquistas.Jaul, value = 2, rate = 1}, -- removido para skills
                            {storage = Storage.Quest.Crandoria.Viridia.Conquistas.Mikarah, value = 2, rate = 1},
                            {storage = Storage.Quest.Crandoria.Viridia.Conquistas.Outfit, value = 1, rate = 1},
                        }
                    
                        local bonusExp = math.max(0, player:getStorageValue(Storage.Quest.Crandoria.Viridia.Bonus.Exp))
                    
                        for _, storageData in ipairs(storages) do
                            local currentValue = player:getStorageValue(storageData.storage) or 0
                            if currentValue == storageData.value then
                                bonusExp = 0 + storageData.rate
                            end
                        end
                        player:setStorageValue(Storage.Quest.Crandoria.Viridia.Bonus.Exp, bonusExp)
                        if bonusExp >= 5 then
                            rep = rep + 5
                        end
    ------------------------------------- LOOT --------------------------------------
                        if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Conquistas.Montaria) > 1 then
                            player:setStorageValue(Storage.Quest.Crandoria.Viridia.Conquistas.Montaria, 3)
                            rep = rep + 5
                        end
    ------------------------------------- PACOTE --------------------------------------
                        if player:getLevel() >= 300 then
                            player:addItem(37461, 1)
                            rep = rep + 5
                        end
    ------------------------------------- SKILLS --------------------------------------          

                        if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Conquistas.Jaul) == 2 then
                            player:setStorageValue(Storage.Quest.Crandoria.Viridia.Bonus.Skills, 1)
                            rep = rep + 5
                        end

    ---------------------------- REPUTATION ---------------------------------
                        player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, rep)
                        
    ---------------------------------------- CITIZEN, ITENS E TELEPORT ----------------------------------------
                        player:setStorageValue(Storage.Quest.Crandoria.Viridia.Citizen, 2)
                        player:teleportTo(Position(5003, 5003, 6))
                        if knight or guardian then
                            player:addItem(3366, 1)
                            player:addItem(3420, 1)
                            player:addItem(3364, 1)
                            player:addItem(3554, 1)
                            player:addItem(3392, 1)
                        elseif paladin then
                            player:addItem(8063, 1)
                            player:addItem(3420, 1)
                            player:addItem(3364, 1)
                            player:addItem(3079, 1)
                            player:addItem(3392, 1)
                        else
                            player:addItem(14086, 1)
                            player:addItem(14087, 1)
                            player:addItem(8074, 1)
                            player:addItem(3079, 1)
                            player:addItem(10451, 1)
                        end
                        npcHandler:say("Boa sorte em sua nova jornada!", npc, creature)
    ------------------------- OUTROS --------------------------------------
                        player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraItem, 0)
                        player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraHunt, 0)
                        player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraRaceId, 0)
                        player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraCount, 0)


                        npcHandler:setTopic(playerId, 0)
                    end
                end
            end
        end
    elseif MsgContains(message, "no") or MsgContains(message, "nao") then
        if npcHandler:getTopic(playerId) == 1 or npcHandler:getTopic(playerId) == 2 or npcHandler:getTopic(playerId) == 3 or npcHandler:getTopic(playerId) == 4 then
            npcHandler:say("Sem problemas, jovem mestre. Me avise se mudar de ideia.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Saudacoes! Se ja tiver a devida {permissao} posso te guiar ate a cidade de {Crandoria}, a capital do Novo Continente.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
