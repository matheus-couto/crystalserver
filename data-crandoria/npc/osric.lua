-- local internalNpcName = "Osric"
-- local npcType = Game.createNpcType(internalNpcName)
-- local npcConfig = {}

-- npcConfig.name = internalNpcName
-- npcConfig.description = internalNpcName

-- npcConfig.health = 100
-- npcConfig.maxHealth = npcConfig.health
-- npcConfig.walkInterval = 0
-- npcConfig.walkRadius = 0

-- npcConfig.outfit = {
-- 	lookType = 1415,
-- 	lookHead = 115,
-- 	lookBody = 0,
-- 	lookLegs = 44,
-- 	lookFeet = 118,
-- 	lookAddons = 1
-- }

-- npcConfig.flags = {
-- 	floorchange = false
-- }

-- local keywordHandler = KeywordHandler:new()
-- local npcHandler = NpcHandler:new(keywordHandler)

-- npcConfig.voices = {
-- 	interval = 30000,
-- 	chance = 50,
-- 	{text = 'Quer aprender a coletar Plantas Selvagens? Posso te ajudar!'},
-- 	{text = 'Fale comigo se quiser aprender a colher frutos de Plantas Selvagens'},
--     {text = 'Posso te ensinar um pouco mais sobre Plantas Selvagens'}
-- }

-- npcType.onThink = function(npc, interval)
-- 	npcHandler:onThink(npc, interval)
-- end

-- npcType.onAppear = function(npc, creature)
-- 	npcHandler:onAppear(npc, creature)
-- end

-- npcType.onDisappear = function(npc, creature)
-- 	npcHandler:onDisappear(npc, creature)
-- end

-- npcType.onMove = function(npc, creature, fromPosition, toPosition)
-- 	npcHandler:onMove(npc, creature, fromPosition, toPosition)
-- end

-- npcType.onSay = function(npc, creature, type, message)
-- 	npcHandler:onSay(npc, creature, type, message)
-- end

-- npcType.onCloseChannel = function(npc, creature)
-- 	npcHandler:onCloseChannel(npc, creature)
-- end

-- local function creatureSayCallback(npc, creature, type, message)
--     local player = Player(creature)
--     local playerId = player:getId()

--     if not npcHandler:checkInteraction(npc, creature) then
--         return false
--     end

-- 	local storage = player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.PlantasSelvagens)

--     if MsgContains(message, "plant") or MsgContains(message, "missao") or MsgContains(message, "mission") or MsgContains(message, "tarefa") then
-- 		if storage < 1 then
-- 			npcHandler:say("Possuir uma ferramenta nao basta para colher plantas selvagens, mas posso te ajudar com isso. Claro, nao sera de graca... \z
-- 			Mas apos algumas tarefas simples eu te ensinarei tudo que eu sei. O que acha? Esta preparado?", npc, creature)
-- 			npcHandler:setTopic(playerId, 1)
-- 		elseif storage == 1 then
-- 			npcHandler:say("Voce trouxe os 3 Crude Chunks of Crude Iron que eu pedi?", npc, creature)
-- 			npcHandler:setTopic(playerId, 2)
-- 		elseif storage == 2 then
-- 			npcHandler:say("Leve os 3 Crude Chunks of Crude Iron para Kradok e solicite por minhas {ferramentas}.", npc, creature)
-- 			npcHandler:setTopic(playerId, 0)
-- 		elseif storage == 3 then
-- 			npcHandler:say("Ah... Entao Kradok te contou sobre a divida... Hehe. Me desculpe por isso. Nao queria te envolver no problema, mas preciso mesmo das ferramentas. \z
-- 			Por favor, me perdoe. Espero que ele nao tenha pedido nada demais...", npc, creature)
-- 			npcHandler:setTopic(playerId, 0)
-- 		elseif storage == 4 then
-- 			if player:getItemCount(3457) >= 1 and player:getItemCount(3453) >= 1 and player:getItemCount(3456) >= 1 then
-- 				player:removeItem(3453, 1)
-- 				player:removeItem(3456, 1)
-- 				player:removeItem(3457, 1)
-- 				npcHandler:say("Incrivel! Voce conseguiu as ferramentas. Ok, agora te passarei uma tarefa um pouco dificil, mas sera essencial! \z
-- 				Voce deve encontrar um arbusto de Winterberry. Esses arbustos nascem por todos os cantos do Novo Continente, dos desertos as areas geladas. \z
-- 				Ao encontrar o arbusto, utilize uma Scythe e tente remover uma Winterberry do arbusto. No inicio voce pode errar, mas nao se preocupe. Quando conseguir, retorne ate mim.", npc, creature)
-- 				player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.PlantasSelvagens, 5)
-- 				npcHandler:setTopic(playerId, 0)
-- 			else
-- 				npcHandler:say("Nem todas as ferramentas estao aqui... Preciso de uma pa, uma picareta e uma foice.", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			end
-- 		elseif storage == 5 then
-- 			npcHandler:say("Colha uma Winterberry de um arbusto que nasce aleatoriamente pelo Novo Continente. Quando conseguir, retorne ate mim.", npc, creature)
-- 			npcHandler:setTopic(playerId, 0)
-- 		elseif storage == 6 then
-- 			npcHandler:say("Voce conseguiu colher a Winterberry? Muito bem! Espero que nao tenha sido tao dificil. Mas aqui esta a boa noticia: SEU TREINAMENTO ESTA COMPLETO! Pode ficar com o fruto colhido. \z
-- 			Nao existem segredos, se voce consegue colher Winterberries, voce ja esta pronto. Mas lembre-se: Suas skills de Fist e Cultivo te ajudarão a obter melhores retornos. \z
-- 			Nunca esqueca de treinar! Aqui, uma recompensa pela ajuda que voce me deu antes. Muito obrigado e boa sorte!", npc, creature)
-- 			player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.PlantasSelvagens, 7)
-- 			player:addItem(11682, 1)
-- 			player:addItem(11460, 3)
-- 			player:addItem(11683, 5)
-- 			npcHandler:setTopic(playerId, 0)
-- 		elseif storage == 7 then
-- 			if npcHandler:getTopic(playerId) == 3 then
-- 				npcHandler:say("Entao voce tem interesse em me ajudar? Otimo! Preste atencao: Eu devo 20 Astralis coins para o Sir Bowser em razao de uma... negociacao er.. que fizemos ha algum tempo. \z
-- 				Coisa sigilosa, sabe como sao as coisas ne? Hehehe... Enfim, ele nao pode saber que estou pedindo sua ajuda. Mas nao tem segredo, traga-me as 20 Astralis Coins e eu te darei o Watering Can.", npc, creature)
-- 				player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.PlantasSelvagens, 8)
-- 				npcHandler:setTopic(playerId, 0)
-- 			else
-- 				npcHandler:say("Sabe... Voce pode cuidar da sua propria fazenda aqui em Astralis. Basta comprar uma das fazendas com espaco para plantio. Para que as plantas crescam voce deve rega-las duas vezes ao dia. \z
-- 				Para isso voce vai precisar de um regador, ou um Watering Can. Eu posso te oferecer um se voce me ajudar em uma pequena {tarefa}...", npc, creature)
-- 				npcHandler:setTopic(playerId, 3)
-- 			end
-- 		elseif storage == 8 then
-- 			npcHandler:say("Entao... sobre o que conversamos... voce trouxe as 20 Astralis Coins?", npc, creature)
-- 			npcHandler:setTopic(playerId, 4)
-- 		elseif storage == 9 then
-- 			npcHandler:say("Ah... Voce conversou com Bowser?... Olha, nao me entenda mal. Eu tenho os meus motivos. De qualquer forma, o combinado ainda esta de pe. E entao? \z
-- 			Voce quer trocar ou nao as 20 Astralis Coins pelo seu regador?", npc, creature)
-- 			npcHandler:setTopic(playerId, 5)
-- 		elseif storage == 10 then
-- 			npcHandler:say("Nao tenho mais tarefas por enquanto.", npc, creature)
-- 			npcHandler:setTopic(playerId, 0)
-- 		end
-- 	elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
-- 		if npcHandler:getTopic(playerId) == 1 then
-- 			if player:getLevel() >= 200 or player:getEffectiveSkillLevel(SKILL_FIST) >= 80 then
-- 				player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.PlantasSelvagens, 1)
-- 				npcHandler:say("Excelente! Nao se preocupe, nao tirarei muito do seu tempo. Primeiramente, preciso de ferramentas novas. Traga-me 3 Huge Chunks of Crude Iron. \z
-- 				Esse material sera o suficiente para renovar meu acervo.", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			else
-- 				npcHandler:say("Sinto muito, mas voce parece um pouco inexperiente para coletar plantas selvagens. Volte quanto possuir ao menos nivel 200 e 80 de Fist Fighting", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			end
-- 		elseif npcHandler:getTopic(playerId) == 2 then
-- 			if player:getItemCount(5892) >= 3 then
-- 				npcHandler:say("Muito bem! Mas veja... eu nao sou um ferreiro, apenas uma agricultor e explorador. Entao preciso que leve o material para o ferreiro de Astralis, Kradok. \z
-- 				Ele esta sempre ocupado, mas basta falar {ferramentas} que ele sabera que preciso de um favor. Estarei esperando.", npc, creature)
-- 				player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.PlantasSelvagens, 2)
-- 				npcHandler:setTopic(playerId, 0)
-- 			else
-- 				npcHandler:say("Voce nao possui todos os itens...", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			end
-- 		elseif npcHandler:getTopic(playerId) == 4 then
-- 			if player:getItemCount(22724) >= 20 then
-- 				player:removeItem(22724, 20)
-- 				npcHandler:say("Maravilha! Agora poderei comprar... Digo... Pagar a minha divida! Aqui, como combinado, seu regador!", npc, creature)
-- 				player:addItem(650, 1)
-- 				player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.PlantasSelvagens, 10)
-- 				npcHandler:setTopic(playerId, 0)
-- 			else
-- 				npcHandler:say("Parece que voce ainda nao tem o suficiente...", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			end
-- 		elseif npcHandler:getTopic(playerId) == 5 then
-- 			if player:getItemCount(22724) >= 20 then
-- 				player:removeItem(22724, 20)
-- 				npcHandler:say("Otimo! Aqui, como combinado, seu regador!", npc, creature)
-- 				player:addItem(650, 1)
-- 				player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.PlantasSelvagens, 10)
-- 				npcHandler:setTopic(playerId, 0)
-- 			else
-- 				npcHandler:say("Parece que voce ainda nao tem o suficiente...", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			end
-- 		end
-- 	end
-- end


-- npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. Gostaria de aprender como colher {plantas} selvagens?")
-- npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
-- npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

-- npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
-- npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)


-- npcType:register(npcConfig)
