local internalNpcName = "Baltazar"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1642,
	lookHead = 25,
	lookBody = 57,
	lookLegs = 57,
	lookFeet = 86,
	lookAddons = 3
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
---------------------------------

    if MsgContains(message, "teleport") or MsgContains(message, "teleports") then
        if player:getStorageValue(Storage.Quest.Crandoria.WorldTeleports.Access) == 1 then
            npcHandler:say("Muito obrigado pela sua nobre contribuicao, jovem viajante!", npc, creature)
            return true
        else
            npcHandler:say("Um Demon Helmet, uma Mini Mummy e 150 Silver Tokens sao os itens necessarios para se tornar um parceiro da Sociedade dos Magos. Voce possui esses itens e deseja doa-los? ({liberar} este acesso por 5000 Tibia Coins?)", npc, creature)
            npcHandler:setTopic(playerId, 1)
        end
    elseif MsgContains(message, "liberar") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("A Sociedade dos Magos tambem precisa de dinheiro, sabia? Se quiser pode contribuir com Tibia Coins para a causa. � o que quer? (Deseja liberar este acesso por 5000 Tibia Coins?)", npc, creature)
            npcHandler:setTopic(playerId, 4)
        end
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
        if npcHandler:getTopic(playerId) == 1 then
            if player:getItemCount(3387) == 0
            or player:getItemCount(10290) == 0
            or player: getItemCount(22516) < 150 then
                npcHandler:say("Voce acha que sou tolo?", npc, creature)
                npcHandler:setTopic(playerId, 0)
                return true
            end

            npcHandler:say("Muito bom. Realmente, muito bom... Se voce me der todos os itens, te deixarei utilizar os nossos teleports quando quiser. \z
                    Gostaria de contribuir com os itens para a Sociedade?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif npcHandler:getTopic(playerId) == 2 then
            if not player:removeItem(3387, 1) then
                npcHandler:say("Esta faltando um Demon Helmet.", npc, creature)
                return true
            end
        
            if not player:removeItem(10290, 1) then
                npcHandler:say("Esta faltando uma Mini Mummy.", npc, creature)
                return true
            end
        
        
            if not player:removeItem(22516, 150) then
                npcHandler:say("Estao faltando alguns Silver Tokens...", npc, creature)
                return true
            end
        
            npcHandler:say("Obrigado! A Sociedade dos Magos se lembrara desse gesto. \z
                Aproveite nosso sistema de teleports a vontade a partir de agora!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.WorldTeleports.Access, 1)
            local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
            player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 5)
            player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 3 then
            if player:getItemCount(11552) >= 1 then
                if player:getStorageValue(torage.Quest.Crandoria.AsurasSecret.Reward) < 3 then
                    player:removeItem(11552, 1)
                    npcHandler:say("Excelente! Nao vai se arrepender, nosso sistema vai te ajudar a chegar mais longe, pode ter certeza disso!", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.WorldTeleports.Access, 1)
                    player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress, 12)
                    player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.Reward, 3)
                    local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                    player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 7)
                    player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                    npcHandler:setTopic(playerId, 0)
                else
					npcHandler:say('Voce pensa que sou idiota? Eu sei que voce esta tentando me passar um cristal falso. Voce ja conseguiu o que queria trocando o cristal verdadeiro.', npc, creature)
					npcHandler:setTopic(playerId, 0)
                end
            else
                npcHandler:say("Ei, esta tentando me enganar? Onde esta o cristal? Sem o cristal magico, nada feito!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 4 then
            npcHandler:say("Voce tem certeza? ({sim}/{nao})", npc, creature)
            npcHandler:setTopic(playerId, 5)
        elseif npcHandler:getTopic(playerId) == 5 then
            if player:getTransferableCoins() >= 5000 then
                player:removeTransferableCoins(5000)
                npcHandler:say("Muto bem! Agradecemos pela sua contribuicao, jovem viajante. Agora voce podera utilizar nosso sistema de teletransporte a vontade.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.WorldTeleports.Access, 1)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("E onde estao as Tibia Coins, jovem? (voce nao possui as Tibia Coins necessarias)", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end

    elseif MsgContains(message, "no") or MsgContains(message, "nao") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Tudo bem, entao.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 2 then
            npcHandler:say("Sem problemas. Volte quando mudar de ideia.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        else
            npcHandler:say("Sem problemas. Volte se mudar de ideia.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif  MsgContains(message, "magic crystal") or MsgContains(message, "cristal magico")  then
        if player:getStorageValue(Storage.Quest.Crandoria.WorldTeleports.Access) > 0 then
            npcHandler:say("Esse cristal... Eu conheco esse cristal... Escuta aqui, eu te ofereceria meus servicos em troca desse cristal, mas como voce ja se tornou adepto da Sociedade dos Magos, nao ha nada mais que eu possa oferecer por ele. \z
            Tenha cuidado! Esse cristal pode ser muito valioso nas maos da pessoa certa. Ou, pior ainda, nas maos da pessoa errada...", npc, creature)
            npcHandler:setTopic(playerId, 0)
        else
            npcHandler:say("Esse cristal... Eu conheco esse cristal... Se voce quiser eu posso te oferecer os meus servicos com os teleports por toda a sua vida em troca desse cristal. Parece uma boa proposta nao e mesmo? E ai, Voce aceita?", npc, creature)
            npcHandler:setTopic(playerId, 3)
        end
    end
    return true

end

npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. Gostaria de usar nossos {teleports}?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye. You are welcome.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")

-- npcType registering the npcConfig table
npcType:register(npcConfig)









-- local internalNpcName = "Baltazar"
-- local npcType = Game.createNpcType(internalNpcName)
-- local npcConfig = {}

-- npcConfig.name = internalNpcName
-- npcConfig.description = internalNpcName

-- npcConfig.health = 100
-- npcConfig.maxHealth = npcConfig.health
-- npcConfig.walkInterval = 2000
-- npcConfig.walkRadius = 2

-- npcConfig.outfit = {
-- 	lookType = 1642,
-- 	lookHead = 25,
-- 	lookBody = 57,
-- 	lookLegs = 57,
-- 	lookFeet = 86,
-- 	lookAddons = 3
-- }

-- local keywordHandler = KeywordHandler:new()
-- local npcHandler = NpcHandler:new(keywordHandler)

-- npcType.onThink = function(npc, interval)
--     npcHandler:onThink(npc, interval)
-- end

-- npcType.onAppear = function(npc, creature)
--     npcHandler:onAppear(npc, creature)
-- end

-- npcType.onDisappear = function(npc, creature)
--     npcHandler:onDisappear(npc, creature)
-- end

-- npcType.onMove = function(npc, creature, fromPosition, toPosition)
--     npcHandler:onMove(npc, creature, fromPosition, toPosition)
-- end

-- npcType.onSay = function(npc, creature, type, message)
--     npcHandler:onSay(npc, creature, type, message)
-- end

-- npcType.onCloseChannel = function(npc, creature)
--     npcHandler:onCloseChannel(npc, creature)
-- end

-- local function creatureSayCallback(npc, creature, type, message)
--     local player = Player(creature)
--     local playerId = player:getId()

--     if not npcHandler:checkInteraction(npc, creature) then
--         return false
--     end
-- ---------------------------------

--     if MsgContains(message, "teleport") or MsgContains(message, "teleports") then
--         if player:getStorageValue(Storage.Quest.Crandoria.WorldTeleports.Access) == 1 then
--             npcHandler:say("Muito obrigado pela sua nobre contribuicao, jovem viajante!", npc, creature)
--             return true
--         else
--             npcHandler:say("Um Demon Helmet, uma Mini Mummy e 150 Silver Tokens sao os itens necessarios para se tornar um parceiro da Sociedade dos Magos. Voce possui esses itens e deseja doa-los?", npc, creature)
--             npcHandler:setTopic(playerId, 1)
--         end
--     elseif MsgContains(message, "yes") or MsgContains(message, "sim")then
--         if npcHandler:getTopic(playerId) == 1 then
--             if player:getItemCount(3387) == 0
--             or player:getItemCount(10290) == 0
--             or player: getItemCount(22516) < 150 then
--                 npcHandler:say("Voce acha que sou tolo?", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--                 return true
--             end

--             npcHandler:say("Muito bom. Realmente, muito bom... Se voce me der todos os itens, te deixarei utilizar os nossos teleports quando quiser. \z
--                     Gostaria de contribuir com os itens para a Sociedade?", npc, creature)
--             npcHandler:setTopic(playerId, 2)
--         elseif npcHandler:getTopic(playerId) == 2 then
--             if not player:removeItem(3387, 1) then
--                 npcHandler:say("Esta faltando um Demon Helmet.", npc, creature)
--                 return true
--             end
        
--             if not player:removeItem(10290, 1) then
--                 npcHandler:say("Esta faltando uma Mini Mummy.", npc, creature)
--                 return true
--             end
        
        
--             if not player:removeItem(22516, 150) then
--                 npcHandler:say("Estao faltando alguns Silver Tokens...", npc, creature)
--                 return true
--             end
        
--             npcHandler:say("Obrigado! A Sociedade dos Magos se lembrara desse gesto. \z
--                 Aproveite nosso sistema de teleports a vontade a partir de agora!", npc, creature)
--             player:setStorageValue(Storage.Quest.Crandoria.WorldTeleports.Access, 1)
--         elseif npcHandler:getTopic(playerId) == 3 then
--             if player:getItemCount(11552) >= 1 then
--                 if player:getStorageValue(torage.Quest.Crandoria.AsurasSecret.Reward) < 3 then
--                     player:removeItem(11552, 1)
--                     npcHandler:say("Excelente! Nao vai se arrepender, nosso sistema vai te ajudar a chegar mais longe, pode ter certeza disso!", npc, creature)
--                     player:setStorageValue(Storage.Quest.Crandoria.WorldTeleports.Access, 1)
--                     player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress, 12)
--                     player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.Reward, 3)
--                     npcHandler:setTopic(playerId, 0)
--                 else
-- 					npcHandler:say('Voce pensa que sou idiota? Eu sei que voce esta tentando me passar um cristal falso. Voce ja conseguiu o que queria trocando o cristal verdadeiro.', npc, creature)
-- 					npcHandler:setTopic(playerId, 0)
--                 end
--             else
--                 npcHandler:say("Ei, esta tentando me enganar? Onde esta o cristal? Sem o cristal magico, nada feito!", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             end
--         end

--     elseif MsgContains(message, "no") or MsgContains(message, "nao") then
--         if npcHandler:getTopic(playerId) == 1 then
--             npcHandler:say("Tudo bem, entao.", npc, creature)
--             npcHandler:setTopic(playerId, 0)
--         elseif npcHandler:getTopic(playerId) == 2 then
--             npcHandler:say("Sem problemas. Volte quando mudar de ideia.", npc, creature)
--             npcHandler:setTopic(playerId, 0)
--         end
--     elseif  MsgContains(message, "magic crystal") or MsgContains(message, "cristal magico")  then
--         if player:getStorageValue(Storage.Quest.Crandoria.WorldTeleports.Access) > 0 then
--             npcHandler:say("Esse cristal... Eu conheco esse cristal... Escuta aqui, eu te ofereceria meus servicos em troca desse cristal, mas como voce ja se tornou adepto da Sociedade dos Magos, nao ha nada mais que eu possa oferecer por ele. \z
--             Tenha cuidado! Esse cristal pode ser muito valioso nas maos da pessoa certa. Ou, pior ainda, nas maos da pessoa errada...", npc, creature)
--             npcHandler:setTopic(playerId, 0)
--         else
--             npcHandler:say("Esse cristal... Eu conheco esse cristal... Se voce quiser eu posso te oferecer os meus servicos com os teleports por toda a sua vida em troca desse cristal. Parece uma boa proposta nao e mesmo? E ai, Voce aceita?", npc, creature)
--             npcHandler:setTopic(playerId, 3)
--         end
--     end
--     return true

-- end

-- npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. Gostaria de usar nossos {teleports}?")
-- npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye. You are welcome.")
-- npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye.")

-- npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- -- npcType registering the npcConfig table
-- npcType:register(npcConfig)
