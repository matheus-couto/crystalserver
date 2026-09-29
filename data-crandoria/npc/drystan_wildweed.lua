local internalNpcName = "Drystan Wildweed"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 144,
	lookHead = 79,
	lookBody = 62,
	lookLegs = 97,
	lookFeet = 118,
	lookAddons = 3
}

npcConfig.flags = {
	floorchange = false
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
    
    local storage = player:getStorageValue(Storage.Quest.Crandoria.DrystanQuest.Progresso)
	local timer = player:getStorageValue(Storage.Quest.Crandoria.DrystanQuest.Timer)
	local count = player:getStorageValue(Storage.Quest.Crandoria.DrystanQuest.KillCount)
	local rep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)

    if MsgContains(message, "missao") or MsgContains(message, "mission") or MsgContains(message, "tarefa") then
        if storage < 1 then
			npcHandler:say("Eu nao aguento mais tantos 'Aventureiros' em Dracantus. Eles nao sabem distinguir quem sao seus inimigos e atacam qualquer um... \z
			Eu vivo aqui ha mais tempo que eles e preciso me alimentar, oras! Talvez voce possa ajudar a dar um jeito nessa situacao. Posso te dar alguma recompensa, claro. \z
			Gostaria de enfrentar alguns desses aventureiros?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif storage == 1 then
			if count < 200 then
				npcHandler:say("Como eu disse, preciso que voce derrote 200 Veteran Adventurers. Retorne quando a ilha estiver mais segura e com menos desses malditos.", npc, creature)
            	npcHandler:setTopic(playerId, 0)
			else
				local timeDone = os.time() - timer
				if timeDone < 3600 then
					player:addMoney(250000, true)
					player:addExperience(player:getLevel() * 120000)
					player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.Progresso, 2)
					player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.KillCount, 0)
					player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.Timer, 0)
					npcHandler:say("Voce foi realmente rapido! Terminou a missao em menos de 1 hora. Incrivel! Aqui esta sua recompensa. \z
					Se nao for pedir muito, voce bem que poderia completar uma segunda {tarefa} para mim...", npc, creature)
					npcHandler:setTopic(playerId, 0)
				elseif timeDone >= 3600 and timeDone < 7200 then
					player:addMoney(200000, true)
					player:addExperience(player:getLevel() * 100000)
					player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.Progresso, 2)
					player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.KillCount, 0)
					player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.Timer, 0)
					npcHandler:say("Voce nao demorou, mas ja vi pessoas sendo mais rapidas que isso. De qualquer forma voce foi muito eficiente. Aqui, sua recompensa. \z
					Se nao for pedir muito, voce bem que poderia completar uma segunda {tarefa} para mim...", npc, creature)
					npcHandler:setTopic(playerId, 0)
				elseif timeDone >= 7200 and timeDone < 14400 then
					player:addMoney(150000, true)
					player:addExperience(player:getLevel() * 80000)
					player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.Progresso, 2)
					player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.KillCount, 0)
					player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.Timer, 0)
					npcHandler:say("Voce realmente nao tem muita pressa, nao e mesmo? Mas nao tem problema, missao cumprida! Aqui, sua recompensa de acordo com o tempo gasto. \z
					Se nao for pedir muito, voce bem que poderia completar uma segunda {tarefa} para mim...", npc, creature)
					npcHandler:setTopic(playerId, 0)
				else
					player:addMoney(100000, true)
					player:addExperience(player:getLevel() * 60000)
					player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.Progresso, 2)
					player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.KillCount, 0)
					player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.Timer, 0)
					npcHandler:say("Voce esta bem? Achei que nao voltaria mais depois de tanto tempo... Mas de qualquer forma, voce completou a missao. Aqui, sua recompensa. \z
					Se nao for pedir muito, voce bem que poderia completar uma segunda {tarefa} para mim...", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			end
		elseif storage == 2 then
			npcHandler:say("Voce foi eficiente em eliminar os veteranos, porem mais e mais deles continuam chegando na ilha. Esta impossivel para obter alimento. \z
			Talvez voce pudesse me ajudar trazendo alguns frutos de Astralis ate aqui. Nao preciso de muito e te garanto uma boa recompensa. \z
			Traga-me 6 dragonfruits e 10 pineapples e te darei 15 Astralis Coins e alguma experiencia. Leve o tempo que precisar, mas nao esqueca por favor!", npc, creature)
			player:addItem(3469, 1)
			player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.Progresso, 3)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 3 then
			npcHandler:say("Voce trouxe as 6 dragonfruits e os 10 pineapples que eu pedi?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		elseif storage == 4 then
			if rep < 175 then
				npcHandler:say("Podemos fazer um acordo de tasks de tempo, porem preciso que antes voce atinja pelo menos o Titulo de Ilustre de reputacao.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				if timer < os.time() then
					npcHandler:say("Que tal uma task para derrotar alguns dragoes da ilha? O combinado sera simples: Voce deve derrotar 1000 dragoes em ate 12 horas. \z
					Se voce conseguir, te darei uma recompensa em experiencia e gold de acordo com o tempo gasto na missao. Voce aceita?", npc, creature)
					npcHandler:setTopic(playerId, 3)
				else
					npcHandler:say("Voce finalizou a ultima task ha pouco tempo. Voce so podera realizar um desafio por semana.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			end
		elseif storage == 5 then
			local timeDone = os.time() - timer
			if timeDone > 21600 then
				npcHandler:say("O tempo acabou antes que voce pudesse finalizar a missao. Nessa velocidade os dragoes tomarao toda a ilha em breve. \z
				Infelizmente nao ha recompensas para voce. Tente novamente quando estiver pronto.", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.KillCount, 0)
				player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.Timer, 0)
				player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.Progresso, 4)
				npcHandler:setTopic(playerId, 0)
			else
				if count >= 1000 then
					if timeDone < 7200 then
						npcHandler:say("Incrivel, |PLAYERNAME|! Voce finalizou em menos de duas horas. Simplesmente incrivel! Aqui, sua recompensa. \z
						Volte em uma semana se quiser repetir o desafio.", npc, creature)
						player:addMoney(1000000, true)
						player:addExperience(player:getLevel() * 200000)
					elseif timeDone >= 7200 and timeDone < 14400 then
						npcHandler:say("Muito bom, |PLAYERNAME|! Voce finalizou em menos de quatro horas. Um otimo resultado! Aqui, sua recompensa. \z
						Volte em uma semana se quiser repetir o desafio.", npc, creature)
						player:addMoney(750000, true)
						player:addExperience(player:getLevel() * 175000)
					elseif timeDone >= 14400 and timeDone < 28800 then
						npcHandler:say("Nao esta mal, |PLAYERNAME|, mas voce pode melhorar. Voce finalizou em menos de oito horas. Um resultado mediano. Aqui, sua recompensa. \z
						Volte em uma semana se quiser repetir o desafio.", npc, creature)
						player:addMoney(500000, true)
						player:addExperience(player:getLevel() * 150000)
					else
						npcHandler:say("Tome cuidado... Voce esta levando bastante tempo para finalizar a missao. Mas conseguiu a tempo! Aqui, sua recompensa \z
						Volte em uma semana se quiser repetir o desafio.", npc, creature)
						player:addMoney(300000, true)
						player:addExperience(player:getLevel() * 120000)
					end
					player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.KillCount, 0)
					player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.Timer, os.time() + 7 * 24 * 60 * 60)
					player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.Progresso, 4)
					local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                	player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 5)
                	player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Voce deve derrotar os 1000 Dragons antes de retornar. Nao importa o tipo, apenas a quantidade.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			end
		end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Excelente. Acredito que nao sera um grande desafio para voce. Mas nao quero que voce mate qualquer um que ver pela frente. \z
			Quero que derrote os 'veteranos'... Esses sim sao o grande problema. Derrote 200 deles e te darei uma boa quantidade de ouro e experiencia. \z
			E aqui vai um desafio: Quanto mais rapido voce terminar sua missao, melhor sera sua recompensa!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.Progresso, 1)
			player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.KillCount, 0)
			player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.Timer, os.time())
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 2 then
			if player:getItemCount(11682) >= 6 and player:getItemCount(11460) >= 10 then
				player:removeItem(11682, 6)
				player:removeItem(11459, 10)
				player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.Progresso, 4)
				player:addItem(22724, 15)
				if rep > 174 then
					npcHandler:say("Elas parecem otimas! Nao vejo frutos assim ha muito tempo... Aqui, como combinado, sua recompensa. \z
					Vejo que voce tem uma boa Reputacao... Talvez queira trabalhar comigo para manter a populacao de dragoes estavel na ilha. \z
					O que acha dessa {missao}?", npc, creature)
				else
					npcHandler:say("Elas parecem otimas! Nao vejo frutos assim ha muito tempo... Aqui, como combinado, sua recompensa. \z
					Sabe... se voce ficar um pouco mais forte, talvez com mais reputacao, podemos fazer um acordo para tasks repetiveis e com tempo... \z
					Retorne apos obter o titulo Ilustre ou superior e poderemos conversar melhor sobre isso.", npc, creature)
				end
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Sinto muito, mas nao vejo todos os frutos com voce. Por favor, nao brinque com quem tem fome...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 3 then
			npcHandler:say("Muito bem, que comecem os jogos! Derrote os dragoes e retorne ate mim quando terminar. Estarei esperando.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.Timer, os.time())
			player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.Progresso, 5)
			player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.KillCount, 0)
			npcHandler:setTopic(playerId, 0)
		end
	end
end


npcHandler:setMessage(MESSAGE_GREET, "Meu {pai} esta fazendo muita falta...")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
