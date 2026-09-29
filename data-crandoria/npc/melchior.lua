local internalNpcName = "Melchior"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 130,
	lookHead = 0,
	lookBody = 25,
	lookLegs = 59,
	lookFeet = 115,
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

-- local function greetCallback(npc, creature)
-- 	local playerId = creature:getId()
-- 	npcHandler:setMessage(MESSAGE_GREET, Player(creature):getSex() == PLAYERSEX_FEMALE and 'Welcome, |PLAYERNAME|! The lovely sound of your voice shines like a beam of light through my solitary darkness!' or 'Greetings, |PLAYERNAME|. I do not see your face, but I can read a thousand things in your voice!')
-- 	return true
-- end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local storage = player:getStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.Progresso)
	local repStorage = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
	local reset = player:getStorageValue(Storage.Quest.Crandoria.Reset.Count)
	local rep = "Ilustres"
	if repStorage > 174 then
		rep = "Nobres"
	elseif repStorage > 274 then
		rep = "Virtuosos"
	elseif repStorage > 499 then
		rep = "Honrados"
	elseif repStorage > 999 then
		rep = "Lendarios"
	end

	if MsgContains(message, "missao") or MsgContains(message, "mission") or MsgContains(message, "desafio") then
		if storage < 1 then
			if reset < 1 then
				npcHandler:say("Mais um dos "..rep.." guerreiros de Crandoria?! Incrivel! Acredito que em breve esse lugar estara cheio de pessoas como voce. \z
				Assim espero... Bom, voce disse que busca por uma missao, certo? Acredito que voce nao seja forte o suficiente ainda... \z
				Retorne quando tiver ao menos 1 reset e talvez possamos conversar.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Mais um dos "..rep.." guerreiros de Crandoria?! Incrivel! Acredito que em breve esse lugar estara cheio de pessoas como voce. \z
				Assim espero... Bom, voce disse que busca por uma missao, certo? Acho que podemos nos favorecer de uma ajuda mutua. \z
				Se conseguir completar alguns desafios, talvez eu deixe que voce entre para a nossa {sociedade}.", npc, creature)
				npcHandler:setTopic(playerId, 1)
			end
		elseif storage == 1 then
			npcHandler:say("Esta pronto para iniciar? Entao vamos la! Serei simples e direto: Sua primeira missao sera derrotar tres bosses. \z
			Primeiro voce deve derrotar o boss Frozen King, depois Gaia e, por ultimo, The Flame Guardian. A ordem deve ser essa ou voce nao passara. \z
			Leve o tempo que precisar e quantas pessoas quiser com voce.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.Progresso, 2)
			npcHandler:setTopic(playerId, 0)
		elseif storage >= 2 and storage < 5 then
			npcHandler:say("Como eu disse, voce precisa derrotar na ordem: Frozen King, Gaia e, por ultimo, The Flame Guardian.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 5 then
			npcHandler:say("Muito bom! Voce demorou um pouco mais do que eu esperava, mas voce conseguiu! Comecou muito bem. Aqui, uma recompensa e, claro, mais reputacao para voce! \z
			Me avise quando estiver pronto para o proximo {desafio}.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.Progresso, 6)
			player:addExperience(repStorage * 10000, true)
			player:addItem(26186, 1)
			player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, repStorage + 5)
			player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 6 then
			npcHandler:say("Vejo que poderemos nos apoiar em voce para desafios realmente perigosos. E falando em desafios perigosos... vamos ao proximo! \z
			A economia de Astralis sempre foi muito forte e, por isso, nossa Sociedade mantem suas reservas de riquezas tanto em ouro e quanto Astralis Coins. \z
			Mostre que voce pode contribuir para a sociedade, trazendo ao menos 25 Astralis Coins para nossas reservas.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.Progresso, 7)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 7 then
			npcHandler:say("Voce trouxe as 25 Astralis Coins?", npc, creature)
			npcHandler:setTopic(playerId, 3)
		elseif storage == 8 then
			npcHandler:say("Escute, |PLAYERNAME|... Nosso servico de comercio depende exclusivamente da producao de Astralis, mas as vezes ficamos com poucos recursos. \z
			Por isso so ofertamos na loja um produto por dia e, mais do que nunca, precisamos de ajuda com nosso estoque. \z
			Por favor, traga 5 Eldritch Fragments para nos ajudar. Esse produto esta em falta ha algum tempo.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.Progresso, 9)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 9 then
			npcHandler:say("Voce trouxe os 5 Eldritch Fragments?", npc, creature)
			npcHandler:setTopic(playerId, 4)
		elseif storage == 10 then
			npcHandler:say("Para seu ultimo desafio, voce tera que se empenhar de verdade! O maior medo da Sociedade de Astralis sempre foi o fim do comercio com Crandoria. \z
			Em razao disso, costumamos enviar presentes ao King Tibianus para reforcar nossa alianca e para que novos guerreiros como voce continuem chegando. \z
			Sua proxima missao sera levar um Morgaroth's Heart para ele. Entregue dizendo ser um {presente} e ele entendera que estamos protegendo Crandoria.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.Progresso, 11)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 11 then
			npcHandler:say("Leve um Morgaroth's Heart de presente para King Tibianus em noma de toda a Sociedade. Fale para ele sobre o {presente} e ele entendera.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 12 then
			npcHandler:say("Recebemos uma carta de King Tibianus agradecendo pelo presente. Realmente incrivel. Aqui, sua recompensa pelo trabalho. \z
			E agora, como prometido, voce sera nomeado um dos membros da Sociedade de Astralis. Agora voce podera negociar com Humgolf. \z
			Voce tambem podera obter buffs mais baratos com Victor e usar nossa fonte, do lado de fora, para obter 60 minutos de stamina diariamente.", npc, creature)
			player:addExperience(repStorage * 25000, true)
			player:addItem(33307, 1)
			player:addItem(26186, 1)
			player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, repStorage + 5)
			player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
			player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.Progresso, 13)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "sociedade") or MsgContains(message, "society") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("A Sociedade de Astralis contempla os mais nobres habitantes do Novo Continente. Comerciantes, fazendeiros, pescadores e guerreiros de alto nivel. \z
			Ao fazer parte da sociedade, voce tera acesso a todas as vantagens encontradas aqui em nossa ilha, incluindo comercio de itens especiais e desafios diarios. \z
			Voce teria interesse de realizar nossos desafios para participar da sociedade?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		end
	elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 2 then
			npcHandler:say("Certo, jovem. Seu caminho nao sera longo, nao se preocupe. Precisamos apenas ter certeza de que podemos contar com voce. \z
			E claro, precisamos saber o quanto voce realmente pode contribuir para a Sociedade como um todo. Me avise quando estiver pronto para a primeira {missao}.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.Progresso, 1)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 3 then
			if player:getItemCount(22724) >= 25 then
				player:removeItem(22724, 25)
				player:addItem(33309, 1)
				player:addExperience(repStorage * 15000, true)
				player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.Progresso, 8)
				npcHandler:say("Que otimo! Voce nao vai se arrepender de contribuir para a Sociedade, acredite! Aqui, uma singela recompensa. \z
				So mais alguns passos e voce sera um membro efetivo da Sociedade de Astralis! Me avise quando quiser iniciar a proxima {missao}.", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, repStorage + 5)
				player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Desculpe, mas... onde estao as Astralis Coins?", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 4 then
			if player:getItemCount(4061) >= 5 then
				player:removeItem(4061, 5)
				player:addItem(33306, 1)
				player:addExperience(repStorage * 20000, true)
				player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.Progresso, 10)
				player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, repStorage + 5)
				player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
				npcHandler:say("...tres, quatro e... cinco! Tudo aqui. E, como sempre, mais uma recompensa para voce. \z
				Acredito que ja posso te entregar sua ultima {missao}. Me avise se estiver pronto.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Desculpe, mas... onde estao os Eldritch Fragments?", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end

	return true
end

npcHandler:setMessage(MESSAGE_FAREWELL, 'Ate a proxima!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Adeus!')
npcHandler:setMessage(MESSAGE_GREET, '|PLAYERNAME|, bem vindo! Por favor, de uma olhada na oferta do dia.')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
