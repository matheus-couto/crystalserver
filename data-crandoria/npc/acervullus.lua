-- local internalNpcName = "Acervullus"
-- local npcType = Game.createNpcType(internalNpcName)
-- local npcConfig = {}

-- npcConfig.name = internalNpcName
-- npcConfig.description = internalNpcName

-- npcConfig.health = 100
-- npcConfig.maxHealth = npcConfig.health
-- npcConfig.walkInterval = 0
-- npcConfig.walkRadius = 0

-- npcConfig.outfit = {
-- 	lookTypeEx = 746,
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


--     if MsgContains(message, "desafio") or MsgContains(message, "challenge") then
--         if player:getLevel() < 500 then
--             npcHandler:say("Voce precisa ter nivel 500 ou superior para este desafio.", npc, creature)
--             npcHandler:setTopic(playerId, 0)
--         else
--             npcHandler:say("Te ofereco a oportunidade de embarcar numa jornada extremamente dificil mas que pode te trazer muitas recompensas. Te levarei para a ilha de Viridia, a sudoeste de Crandoria. \z
--             Naquele local voce", npc, creature)
--             npcHandler:setTopic(playerId, 1)
--         end
--     elseif MsgContains(message, "permissao") then
--         if player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Permissao) < 1 then
--             npcHandler:say("Para que o Almirante Haldor te deixe sair de Viridia, voce precisa atingir o nivel 100 e entao requisitar a ele sua permissao. Retorne apos conseguir e te levarei para Crandoria.", npc, creature)
--             npcHandler:setTopic(playerId, 0)
--         else
--             npcHandler:say("Vejo que voce ja possui permissao para deixar Viridia. Ja registrou suas conquistas com o Almirante Haldor? Deseja ir embora para Crandoria? (apos decidir nao ha mais como retornar)", npc, creature)
--             npcHandler:setTopic(playerId, 1)
--         end
--     elseif MsgContains(message, "yes") or MsgContains(message, "sim") then

--     elseif MsgContains(message, "no") or MsgContains(message, "nao") then
--         if npcHandler:getTopic(playerId) == 1 or npcHandler:getTopic(playerId) == 2 or npcHandler:getTopic(playerId) == 3 or npcHandler:getTopic(playerId) == 4 then
--             npcHandler:say("Sem problemas, jovem mestre. Me avise se mudar de ideia.", npc, creature)
--             npcHandler:setTopic(playerId, 0)
--         end
--     end
-- end


-- npcHandler:setMessage(MESSAGE_GREET, "Mais uma alma perdida... Gostaria de iniciar um verdadeiro {desafio}?.")
-- npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
-- npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

-- npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- -- npcType registering the npcConfig table
-- npcType:register(npcConfig)
