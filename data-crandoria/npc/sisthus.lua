-- local internalNpcName = "Sisthus"
-- local npcType = Game.createNpcType(internalNpcName)
-- local npcConfig = {}

-- npcConfig.name = internalNpcName
-- npcConfig.description = internalNpcName

-- npcConfig.health = 100
-- npcConfig.maxHealth = npcConfig.health
-- npcConfig.walkInterval = 2000
-- npcConfig.walkRadius = 0

-- npcConfig.outfit = {
-- 	lookType = 1642,
-- 	lookHead = 0,
-- 	lookBody = 0,
-- 	lookLegs = 114,
-- 	lookFeet = 84,
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

--     if MsgContains(message, "teleport") or MsgContains(message, "teleports") or MsgContains(message, "mission") or MsgContains(message, "missao") or MsgContains(message, "missoes") then
--         if player:getStorageValue(Storage.Quest.Crandoria.TeleportRoom.Progresso) < 1 then
--             npcHandler:say("Todos possuem permissao para utilizar os teleports da primeira sala, mas precisarao passar realizar {missoes} para acessar as salas seguintes.", npc, creature)
--             player:setStorageValue(Storage.Quest.Crandoria.TeleportRoom.Progresso, 1)
--             npcHandler:setTopic(playerId, 0)
--         elseif player:getStorageValue(Storage.Quest.Crandoria.TeleportRoom.Progresso) == 1 then
--             if player:getLevel() >= 30 then
--                 npcHandler:say("Para acessar a segunda parte dos teleports voce precisara trazer uma quantidade de ouro e alguns itens para mim. Estes itens sao obtidos das proprias criaturas presentes nos teleports que voce deseja acessar. \z
--                 Busque por essas criaturas pelo mapa e traga para mim os seguintes itens: 5 Vampire Teeth, 3 Red Piece of Cloth, 2 Boggy Dreads, 3 Wyrm Scales, 3 Lizard Leathers, 2 Shards e 3 Red Dragon Leathers. \z
--                 Traga todos os itens alem de 25.000 gold coins e permitirei seu acesso a segunda sala.", npc, creature)
--                 player:setStorageValue(Storage.Quest.Crandoria.TeleportRoom.Progresso, 2)
--                 npcHandler:setTopic(playerId, 0)
--             else
--                 npcHandler:say("Voce precisa possuir nivel 30 ou superior para acessar a proxima sala de Teleports.", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             end
--         elseif player:getStorageValue(Storage.Quest.Crandoria.TeleportRoom.Progresso) == 2 then
--             npcHandler:say("Como eu te disse, preciso de 5 Vampire Teeth, 3 Red Piece of Cloth, 2 Boggy Dreads, 3 Wyrm Scales, 3 Lizard Leathers, 2 Shards e 3 Red Dragon Leathers para garantir seu acesso. Esta com todos os itens?", npc, creature)
--             npcHandler:setTopic(playerId, 1)
--         elseif player:getStorageValue(Storage.Quest.Crandoria.TeleportRoom.Progresso) == 3 then
--             if player:getLevel() >= 150 then
--                 npcHandler:say("Quer acessar a proxima sala de Teleports? Muito bem! Mas prepare-se, sua missao agora sera um pouco mais dificil! Voce tera que me trazer uma quantidade maior de ouro, alguns itens de criatura e tambem um item especial. \z
--                 Traga-me 200.000 moedas de ouro, 1 Demonic Candy Ball, 2 Clusters of Solace, 3 Onyx Chips, 3 Bashmu Fangs, 3 Werecrocodile Tongues, 3 Empty Honey Glasses e 3 Strands of Medusa Hair. Por favor, nao demore.", npc, creature)
--                 player:setStorageValue(Storage.Quest.Crandoria.TeleportRoom.Progresso, 4)
--                 npcHandler:setTopic(playerId, 0)
--             else
--                 npcHandler:say("Voce precisa possuir nivel 150 ou superior para acessar a proxima sala de Teleports.", npc, creature)
--                 npcHandler:setTopic(playerId, 0)   
--             end
--         elseif player:getStorageValue(Storage.Quest.Crandoria.TeleportRoom.Progresso) == 4 then
--             npcHandler:say("Como combinamos, preciso de 200.000 gold, 1 Demonic Candy Ball, 2 Clusters of Solace, 3 Onyx Chips, 3 Bashmu Fangs, 3 Werecrocodile Tongues, 3 Empty Honey Glasses e 3 Strands of Medusa Hair. Voce trouxe tudo?", npc, creature)
--             npcHandler:setTopic(playerId, 2)
--         elseif player:getStorageValue(Storage.Quest.Crandoria.TeleportRoom.Progresso) == 5 then
--             if player:getLevel() >= 250 then
--                 npcHandler:say("Para acessar a proxima area, voce tera que me trazer 1.000.000 gold coins, 1 Holy Scarab, 500 Demonic Essences e 50 Mystical Hourglasses. Leve o tempo que precisar.", npc, creature)
--                 player:setStorageValue(Storage.Quest.Crandoria.TeleportRoom.Progresso, 6)
--                 npcHandler:setTopic(playerId, 0)
--             else
--                 npcHandler:say("Voce precisa possuir nivel 250 ou superior para acessar a proxima sala de Teleports.", npc, creature)
--                 npcHandler:setTopic(playerId, 0)   
--             end
--         elseif player:getStorageValue(Storage.Quest.Crandoria.TeleportRoom.Progresso) == 6 then
--             npcHandler:say("A proxima area pode ser acessada em troca de 1.000.000 gold coins, 1 Holy Scarab, 500 Demonic Essences e 50 Mystical Hourglasses. Voce trouxe o ouro e os itens?", npc, creature)
--             npcHandler:setTopic(playerId, 3)   
--         elseif player:getStorageValue(Storage.Quest.Crandoria.TeleportRoom.Progresso) == 7 then
--             if player:getLevel() >= 500 then
--                 npcHandler:say("Ah... a sala dos Bosses. A ultima parte dos Teleports. Voce podera acessar a area em troca 15.000.000 gold coins ou um unico item: um Morgaroth's Heart! Qual voce escolhe? O {ouro} ou o {heart}?", npc, creature)
--                 npcHandler:setTopic(playerId, 4)
--             else
--                 npcHandler:say("Voce precisa possuir nivel 500 ou superior para acessar a proxima sala de Teleports.", npc, creature)
--                 npcHandler:setTopic(playerId, 0)   
--             end
--         elseif player:getStorageValue(Storage.Quest.Crandoria.TeleportRoom.Progresso) == 8 then
--             npcHandler:say("Voce ja possui acesso a todos os teleports. Mas tenho uma nova proposta: O Reino de Crandoria precisa de contribuicoes para contrinuar funcionando adequadamente. \z
--             Pelo valor de 2.000 Tibia Coins voce pode ter acesso a todos os Teleports de Hunts sem nenhum custo de itens adicionais. Voce gostaria de contribuir para o reino?", npc, creature)
--             npcHandler:setTopic(playerId, 7)   
--         end
--     elseif MsgContains(message, "ouro") or MsgContains(message, "gold") then
--         if npcHandler:getTopic(playerId) == 4 then
--             npcHandler:say("Deseja pagar 15.000.000 gold coins para ter acesso aos portais dos bosses?", npc, creature)
--             npcHandler:setTopic(playerId, 5) 
--         end
--     elseif MsgContains(message, "heart") then
--         if npcHandler:getTopic(playerId) == 4 then
--             npcHandler:say("E voce trouxe o Morgaroth's Heart com voce?", npc, creature)
--             npcHandler:setTopic(playerId, 6) 
--         end
--     elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
--         local money = player:getBankBalance() + player:getMoney()
--         if npcHandler:getTopic(playerId) == 1 then
--             if money >= 25000 and player:getItemCount(9685) >= 5 and player:getItemCount(5911) >= 3 and player:getItemCount(9667) >= 2 and player:getItemCount(9665) >= 3 and player:getItemCount(5876) >= 3 and player:getItemCount(7290) >= 2 and player:getItemCount(5948) >= 3 then
--                 player:removeItem(9685, 5)
--                 player:removeItem(5911, 3)
--                 player:removeItem(9667, 2)
--                 player:removeItem(9665, 3)
--                 player:removeItem(5876, 3)
--                 player:removeItem(7290, 2)
--                 player:removeItem(5948, 3)
--                 player:removeMoneyBank(25000)
--                 player:setStorageValue(Storage.Quest.Crandoria.TeleportRoom.Progresso, 3)
--                 local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
--                 player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
--                 player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
--                 npcHandler:say("Excelente! Seu acesso a segunda sala de Teleports esta permitido. Boa sorte!", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             else
--                 npcHandler:say("Voce nao possui todos os itens necessarios.", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             end
--         elseif npcHandler:getTopic(playerId) == 2 then
--             if money >= 200000 and player:getItemCount(11587) >= 1 and player:getItemCount(20062) >= 2 and player:getItemCount(22193) >= 3 and player:getItemCount(36820) >= 3 and player:getItemCount(43729) >= 3 and player:getItemCount(31331) >= 3 and player:getItemCount(10309) >= 3 then
--                 player:removeMoneyBank(200000)
--                 player:removeItem(11587, 1)
--                 player:removeItem(20062, 2)
--                 player:removeItem(22193, 3)
--                 player:removeItem(36820, 3)
--                 player:removeItem(43729, 3)
--                 player:removeItem(31331, 3)
--                 player:removeItem(10309, 3)
--                 player:setStorageValue(Storage.Quest.Crandoria.TeleportRoom.Progresso, 5)
--                 local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
--                 player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
--                 player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
--                 npcHandler:say("Muito bem. Voce realmente mostrou seu valor! Podera acessar a proxima area a partir de agora.", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             else
--                 npcHandler:say("Voce nao possui tudo...", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             end
--         elseif npcHandler:getTopic(playerId) == 3 then
--             if money >= 1000000 and player:getItemCount(3023) >= 1 and player:getItemCount(6499) >= 500 and player:getItemCount(9660) >= 50 then
--                 player:removeMoneyBank(1000000)
--                 player:removeItem(3023, 1)
--                 player:removeItem(6499, 500)
--                 player:removeItem(9660, 50)
--                 player:setStorageValue(Storage.Quest.Crandoria.TeleportRoom.Progresso, 7)
--                 local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
--                 player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
--                 player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
--                 npcHandler:say("Perfeito! Esta tudo aqui. Aproveite a proxima sala de teleports.", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             else
--                 npcHandler:say("Voce nao possui tudo...", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             end
--         elseif npcHandler:getTopic(playerId) == 5 then
--             if money >= 15000000 then
--                 player:removeMoneyBank(15000000)
--                 player:setStorageValue(Storage.Quest.Crandoria.TeleportRoom.Progresso, 8)
--                 npcHandler:say("Muito bem. Seu acesso a area dos bosses esta concedido. Boa sorte em suas batalhas vindouras!", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             else
--                 npcHandler:say("Voce nao possui ouro o suficiente.", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             end
--         elseif npcHandler:getTopic(playerId) == 6 then
--             if player:getItemCount(5943) >= 1 then
--                 player:removeItem(5943, 1)
--                 player:setStorageValue(Storage.Quest.Crandoria.TeleportRoom.Progresso, 8)
--                 npcHandler:say("Muito bem. Seu acesso a area dos bosses esta concedido. Boa sorte em suas batalhas vindouras!", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             else
--                 npcHandler:say("Voce nao possui o item com voce.", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             end
--         elseif npcHandler:getTopic(playerId) == 7 then
--             npcHandler:say("Confirmando: Gostaria de doar 2.000 Tibia Coins para acessar todos os Teleports de Hunt quando quiser e gratuitamente?", npc, creature)
--             npcHandler:setTopic(playerId, 8)
--         elseif npcHandler:getTopic(playerId) == 8 then
--             if player:getTransferableCoins() >= 2000 then
--                 player:removeTransferableCoins(2000)
--                 player:setStorageValue(Storage.Quest.Crandoria.TeleportRoom.Progresso, 9)
--                 local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
--                 player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 6)
--                 player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
--                 npcHandler:say("Muito obrigado pela sua contribuicao! Use os Teleports de Hunts o quanto quiser!", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             else
--                 npcHandler:say("Voce nao possui as Tibia Coins necessarias.", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             end
--         end
--     end
--     return true
-- end

-- npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. Sou Sisthus, o responsavel pelos {teleports} de Crandoria.")
-- npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye. You are welcome.")
-- npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye.")

-- npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- -- npcType registering the npcConfig table
-- npcType:register(npcConfig)









