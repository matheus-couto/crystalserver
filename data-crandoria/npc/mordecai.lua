local internalNpcName = "Mordecai"
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
	lookHead = 38,
	lookBody = 132,
	lookLegs = 117,
	lookFeet = 3,
	lookAddons = 3,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
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

local ITEM_ID = 31967
local ACTION_ID = 100
local TARGET_COUNT = 100

local function shuffle(list)
	for i = #list, 2, -1 do
		local j = math.random(i)
		list[i], list[j] = list[j], list[i]
	end
	return list
end

-- area = { from = Position, to = Position }
-- Devolve: quantos itens foram criados, total de itens na area depois da criacao
function fillAreaWithItems(area)
	local from, to = area.from, area.to
	local existing = 0
	local candidates = {}

	-- Uma unica passada: conta os itens que ja existem e separa os tiles disponiveis
	for x = from.x, to.x do
		for y = from.y, to.y do
			local tile = Tile(Position(x, y, from.z))
			if tile then
				local count = tile:getItemCountById(ITEM_ID)
				if count > 0 then
					existing = existing + count
				elseif tile:getGround()
					and not tile:hasFlag(TILESTATE_BLOCKSOLID)
					and not tile:hasFlag(TILESTATE_BLOCKPATH)
					and not tile:hasFlag(TILESTATE_FLOORCHANGE) then
					candidates[#candidates + 1] = tile:getPosition()
				end
			end
		end
	end

	local needed = TARGET_COUNT - existing
	if needed <= 0 then
		return 0, existing
	end

	shuffle(candidates)

	local created = 0
	for i = 1, math.min(needed, #candidates) do
		local item = Game.createItem(ITEM_ID, 1, candidates[i])
		if item then
			item:setActionId(ACTION_ID)
			created = created + 1
		end
	end

	if created < needed then
		print(string.format("[fillAreaWithItems] criados %d de %d necessarios (faltaram tiles disponiveis)", created, needed))
	end

	return created, existing + created
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local storageCrassus = player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso)
	local storage = player:getStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso)
	local storageReward = player:getStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Reward)
	local storageVirtudeCount = player:getStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Count)

	if storageReward < 1 then
		storageReward = 0
	end

	if MsgContains(message, "missao") or MsgContains(message, "mission") then
		if storageCrassus < 138 then
			npcHandler:say("Olhe, nao leve a mal, mas eu nao tenho assuntos a tratar com aqueles que ainda nao foram aprovados pelo Comandante Crassus. Realize mais algumas missoes e prove seu valor e suas virtudes.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		else
			if storage < 1 then
				npcHandler:say("Ah, |PLAYERNAME|... o Comandante Crassus me falou sobre voce. Parece que seus feitos tem te concedido certa reputacao, estou certo? Isso pode ser muito bom, realmente. \z
				Mas a reputacao as vezes sobe a cabeca, faz com que passemos a nos dar mais valor do que realmente deveriamos. Por isso meu trabalho sempre foi importante para Crandoria. \z
				Minha missao com voce sera te guiar num caminho de virtudes, para que encontre um equilibrio entre as principais virtudes necessarias para um Defensor de Crandoria. Esta pronto para essa jornada?", npc, creature)
				npcHandler:setTopic(playerId, 1)
			elseif storage == 1 then
				npcHandler:say("Voce conseguiu o Writhing Heart?", npc, creature)
				npcHandler:setTopic(playerId, 2)
			elseif storage == 2 then
				npcHandler:say("Bom, vamos comecar com algo que voce merece faz tempo... Fale com Tezila, em Anvillux, para obter uma bonificacao pelos servicos prestados ate agora. \z
				Ela fica na relojoaria do local. Apos obter sua recompensa, retorne a mim.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			elseif storage == 3 then
				npcHandler:say("Vejo que voce foi honesto e nao mentiu sobre sua vocacao com o objetivo de obter uma recompensa melhor. Fico feliz em saber disso. \z
				Voce passou no teste da Honestidade. Gosto de testar essa virtude primeiro para ver o quao honestos sao os novos guerreiros de Crandoria. \z
				Sua conquista esta registrada e sua recompensa final melhorada. Me avise quando estiver pronto para a proxima {missao}.", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Reward, storageReward + 2)
				player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 6)
				npcHandler:setTopic(playerId, 0)
			elseif storage == 4 then
				npcHandler:say("Sabe, |PLAYERNAME|, eu nao entendi muito bem voce... Voce mentiu sobre sua vocacao, mesmo nao obtendo nenhuma vantagem sobre isso. \z
				Voce nao sera punido por isso, mas saiba que por ter mentido voce nao passou no teste da Honestidade, a primeira das virtudes. Isso ficara registrado.", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Reward, storageReward + 1)
				player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 6)
				npcHandler:setTopic(playerId, 0)
			elseif storage == 5 then
				npcHandler:say("Triste... pelo que me foi passado voce mentiu sobre sua vocacao para obter uma recompensa melhor de Anvillux. Estou desapontado. \z
				Voce falhou na primeira missao relacionada a virtude da Humildade. Isso ficara registrado e sua recompensa final sera reduzida em razao disso.", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 6)
				npcHandler:setTopic(playerId, 0)
			elseif storage == 6 then
				npcHandler:say("Para sua proxima missao voce devera fazer um juramento magico e entao passar por uma simples tarefa. O juramento sera um acordo de paz durante sua missao, ou seja, voce nao podera atacar nenhum monstro no caminho. \z
				Seu objetivo aqui sera passar por uma fazenda de slimes de um morador de Astralis. No fundo da fazenda ha um Slime corrompido que deve ser eliminado. Mas apenas ele podera sofrer dano! \z
				Quando estiver preparado, fale {juramento} e te enviarei ao local da sua missao. Seu objetivo sera chegar ao final do caminho e voce so tera uma chance.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			elseif storage == 7 then
				npcHandler:say("Voce atacou um Friendly Slime e nem mesmo foi capaz de derrotar o Corrupted Slime... Estou bem desapontado com voce. Estou registrando tudo... \z
				Infelizmente seu juramento foi quebrado e voce nao passou no teste da Honra. Uma virtude importante... Me avise quando quiser passar para o proximo desafio.", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 10)
				npcHandler:setTopic(playerId, 0)
			elseif storage == 8 then
				npcHandler:say("Muito bem! Voce derrotou o Corrupted Slime sem ferir nenhum Friendly Slime. Voce manteve seu juramento ate o fim e provou sua Honra. \z
				Essa virtude esta entre as mais dificeis de ser provada ao longo da vida de um guerreiro. Parabens! Estou registrando sua conquista. Me avise quando estiver pronto para a proxima {missao}.", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 10)
				player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Reward, storageReward + 2)
				npcHandler:setTopic(playerId, 0)
			elseif storage == 9 then
				npcHandler:say("Soube que voce chegou a ferir Friendly Slimes... mas pelo menos derrotou o Corrupted Slime, cumprindo parte do seu juramento e demonstrando ainda ter um pouco de Honra. \z
				Mas perdera pontos por ter sido descuidado, fique ciente. Me avise quando estiver pronto para o proximo desafio.", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Reward, storageReward + 1)
				player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 10)
				npcHandler:setTopic(playerId, 0)
			elseif storage == 10 then
				npcHandler:say("Agora sua missao sera simples mas um pouco perigosa: Voce deve enfrentar Goriath, em Krotkah. Nao me importa se voce perder, mas deve ao menos tentar derrota-lo. \z
				Prove que voce nao se assusta com desafios perigosos. Leve o time que quiser para te ajudar na missao.", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 11)
				npcHandler:setTopic(playerId, 0)
			elseif storage == 11 then
				if player:getStorageValue(Storage.Quest.Crandoria.TheCanyonChallenge.GoriathTimer) < os.time() then
					npcHandler:say("Enfrente Goriath, em Krotkah, e retorne a mim.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Excelente! Voce conseguiu enfrentar um desafio extremamente perigoso, demonstrando ter Coragem, uma virtude imprescindivel para um Defensor de Crandoria! \z
					Sua conquista foi registrada e agora podemos passar para a proxima {missao}.", npc, creature)
					player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Reward, storageReward + 2)
					player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 12)
					npcHandler:setTopic(playerId, 0)
				end
			elseif storage == 12 then
				npcHandler:say("Preciso analisar um material raro para incluir algumas anotacoes no livro que estou escrevendo. Quero que busque esse material para mim. \z
				Ele ficara com voce, nao se preocupe. O item em questao se chama Mini Mummy, conhecido por ser obtido de mumias no deserto, mas pode haver outros meios... \z
				Preciso que traga uma unidade para que eu possa analisar. Leve quanto tempo precisar.", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 13)
				npcHandler:setTopic(playerId, 0)
			elseif storage == 13 then
				npcHandler:say("Voce conseguiu encontrar a Mini Mummy?", npc, creature)
				npcHandler:setTopic(playerId, 4)
			elseif storage == 14 then
				npcHandler:say("Estou precisando de ajuda para limpar os corredores da antiga fazenda de Slimes, que fica proxima a que voce visitou duas missoes atras. \z
				O local esta cheio de sujeira. Quero que limpe parte dessa sujeira, o quanto voce quiser. Quando achar que limpou o suficiente, retorne pelo teleport. Esta pronto?", npc, creature)
				npcHandler:setTopic(playerId, 6)
			elseif storage == 15 then
				if storageVirtudeCount < 10 then
					npcHandler:say("Hum... voce limpou realmente muito pouco. Parece que voce acredita que esta muito acima de missoes tao simples, estou certo? \z
					Saiba que a Humildade, estando entre as seis virtudes principais, nao deve ser ignorada em sua jornada. Voce falhou nesse teste, mas ainda nao acabou. \z
					Estou registrando seu progresso. Sua proxima {missao} ja esta preparada.", npc, creature)
					player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 16)
					npcHandler:setTopic(playerId, 0)
				elseif storageVirtudeCount >= 10 and storageVirtudeCount < 20 then
					npcHandler:say("Bom, voce limpou uma quantidade razoavel de sujeira, mas desistiu rapidamente. Aceitar trabalhos pequenos as vezes pode ser chato, mas demonstra Humildade. \z
					Nem sempre quem precisar de sua ajuda te pedira para derrotar o monstro mais forte que voce ja viu... De qualquer forma sua ajuda foi adequada e sera registrada. \z
					Voce nao falhou no teste, mas poderia ter ido melhor. Sua proxima {missao} ja esta preparada.", npc, creature)
					player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 16)
					player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Reward, storageReward + 1)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Voce demonstrou sua Humildade ao se dedicar tanto a uma tarefa tao tediosa e claramente abaixo dos seus niveis de habilidade. \z
					Parabens! Voce passou no teste dessa virtude. Seu progresso foi registrado e sua proxima {missao} ja esta preparada.", npc, creature)
					player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 16)
					player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Reward, storageReward + 2)
					npcHandler:setTopic(playerId, 0)
				end
			elseif storage == 16 then
				npcHandler:say("Esta sera sua ultima missao, entao preste muita atencao: Lembra-se do coracao que voce me entregou na primeira missao? Pois bem... Nao te pedi ele atoa. \z
				Ha tres pessoas em Valkesh em busca de um desses e voce devera decidir quem deve ficar com o coracao. As tres pessoas sao: Ishina, Miraia e Kaleb. \z
				Escute os motivos de cada um e me traga uma resposta.", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 17)
				npcHandler:setTopic(playerId, 0)
			elseif storage == 17 then
				npcHandler:say("E entao, |PLAYERNAME|. Fez seu julgamento? Quem voce acha que merece ficar com o Writhing Heart? {Kaleb}, {Miraia} ou {Ishina}?", npc, creature)
				npcHandler:setTopic(playerId, 7)
			elseif storage == 18 then
				npcHandler:say("Voce finalizou seu Teste de Virtude. Me diga se quiser conferir o {resultado}.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			elseif storage == 19 then
				npcHandler:say("Voce finalizou seu Teste de Virtude e foi bem sucedido. Podera usar as Estatuas da Virtude.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	elseif MsgContains(message, "resultado") then
		if storage == 18 then
			if storageReward >= 6 then
				npcHandler:say("Parabens! Voce obteve "..storageReward.." pontos no seu desafio e foi aceito pela Sociedade dos Magos para usar as Estatuas da Virtude! \z
				Voce precisava de pelo menos 6 pontos para passar, dos quais de 0 a 2 poderiam ser obtidos em cada missao, de acordo com seus resultados. Voce recebeu experiencia e gold de acordo com seu resultado em pontos. \z
				Voce podera usar as estatuas para obter bonus ou recursos. Leia as informacoes no nosso livro para entender melhor sobre as regras e o funcionamento. Boa sorte!", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 19)
				local xp = storageReward * 10000000
				local gold = storageReward * 500000
				player:addExperience(xp, true)
				player:addMoney(gold, true)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce obteve "..storageReward.." pontos no seu desafio e nao passou no Teste da Virtude. Eu sinto muito. Voce deve trabalhar melhor suas virtudes. \z
				Mas nao se preocupe! Voce pode reiniciar o teste quando quiser, basta me dizer e retornamos a primeira {missao}.", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 0)
				player:addExperience(50000, true)
				npcHandler:setTopic(playerId, 0)
			end
		end
	elseif MsgContains(message, "juramento") then
		if storage == 6 then
			npcHandler:say("Lembre-se: voce deve chegar ao final do caminho sem atacar nenhuma criatura. Esta pronto para iniciar?", npc, creature)
			npcHandler:setTopic(playerId, 3)
		end
	elseif MsgContains(message, "aleb") then
		if npcHandler:getTopic(playerId) == 7 then
			npcHandler:say("A Justica nunca foi uma ciencia exata e dependera sempre do contexto social no qual voce vive. O que parece certo aqui, pode ser errado em outro lugar ou em outra epoca. \z
			Sua decisao foi sabia e se alinha com a opiniao da Sociedade dos Magos. Por isso voce passou no teste da Justica, recebendo pontos por dominar essa Virtude. \z
			Mas lembre-se, mais uma vez: O que parece justo para voce ou para mim pode nao ser justo para outros. Agora que concluiu os desafios, pode checar seu {resultado}.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Reward, storageReward + 2)
			player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 18)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "iraia") then
		if npcHandler:getTopic(playerId) == 7 then
			npcHandler:say("A Justica nunca foi uma ciencia exata e dependera sempre do contexto social no qual voce vive. O que parece certo aqui, pode ser errado em outro lugar ou em outra epoca. \z
			Sua decisao nao se alinha com a opiniao da Sociedade dos Magos. Pense comigo: quem garante a palavra de Miraia sobre as suas intencoes? E por que ajudar alguem que esta pensando em beneficio proprio quando se pode ajudar diretamente quem mais precisa? \z
			Mas nao ha problemas, sua decisao ainda poderia beneficiar duas pessoas e, como eu disse, a justica nunca foi uma ciencia exata. Agora que concluiu os desafios, pode checar seu {resultado}.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Reward, storageReward + 1)
			player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 18)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "shina") then
		if npcHandler:getTopic(playerId) == 7 then
			npcHandler:say("A Justica nunca foi uma ciencia exata e dependera sempre do contexto social no qual voce vive. O que parece certo aqui, pode ser errado em outro lugar ou em outra epoca. \z
			Sua decisao nao se alinha com a opiniao da Sociedade dos Magos. Entre as tres opcoes, a sua escolha seria a que menos ajudaria diretamente alguem que realmente precisaria do item. Seria justo? \z
			Mas nao se preocupe, voce nao passou no teste mas saiba que a Justica se faz de diversas formas. Agora que concluiu os desafios, pode checar seu {resultado}.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 18)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Muito bem, entao preste atencao: Ha seis virtudes igualmente importantes que voce precisa dominar no seu caminho, independente de sua vocacao. \z
			Sao elas: Honra, Coragem, Sacrificio, Honestidade, Humildade e Justica. Quando conseguir dominar as seis virtudes, sera superior a grande maioria dos guerreiros dessas terras. \z
			E para iniciar sua jornada, pedirei por algo simples que sera extremamente necessario em sua jornada: traga para mim um Writhing Heart, obtido do boss The Unwelcome. Simples, certo? Ficarei esperando.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 1)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 2 then
			if player:getItemCount(32599) >= 1 then
				player:removeItem(32599, 1)
				player:addExperience(2500000, true)
				player:addMoney(185000, true)
				npcHandler:say("Ah! Excelente! Nao se preocupe, te pagarei seu valor exato, aqui. Este coracao sera necessario para uma de suas proximas missoes, que sera tambem o inicio do seu caminho pelas Virtudes. \z
				Me avise quando estiver pronto para essa {missao}.", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 2)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao esta com o coracao? Parece que se confundiu...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 3 then
			npcHandler:say("Entao boa sorte!", npc, creature)
			player:teleportTo(Position(5024, 4846, 15))
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 4 then
			if player:getItemCount(10290) >= 1 then
				npcHandler:say("Oh, que incrivel! Esta Mini Mummy esta em perfeito estado! Como isso pode ser possivel? Eu nao consigo acreditar... \z
				Olhe, voce pode negar se quiser, mas a contribuicao desse artefato para a colecao de Magincia seria muito importante para todo o Reino. \z
				Voce gostaria de oferecer este item para a colecao de artefatos dos magos de Magincia? ({sim} ou {nao})", npc, creature)
				npcHandler:setTopic(playerId, 5)
			else
				npcHandler:say("E onde esta? Nao estou vendo o artefato com voce...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 5 then
			player:removeItem(10290, 1)
			npcHandler:say("Muito bem, |PLAYERNAME|. Com isso voce passou no teste do Sacrificio. As vezes, pelo bem do reino, precisamos sacrificar algo valioso. \z
			Em alguns momentos sera algo material, mas podera chegar um dia em que devera sacrificar a propria vida para proteger aqueles que voce ama. \z
			Muito bem, me avise quando estiver pronto para a proxima missao.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Reward, storageReward + 1)
			player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 14)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 6 then
			npcHandler:say("Certo. Segure esse balde, com ele voce podera coletar as sujeiras.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 15)
			player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Count, 0)
			player:addItem(2873, 1)
			addEvent(function()
				if player then
					player:teleportTo(Position(5035, 4935, 15))
				end
			end, 3000)
			fillAreaWithItems({
				from = Position(5025, 4893, 15),
				to = Position(5071, 4941, 15),
			})
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "no") or MsgContains(message, "nao") then
		if npcHandler:getTopic(playerId) == 5 then
			npcHandler:say("Sem problemas, sei que este pode ser um artefato dificil de conseguir. Fique com ele, nem todos os guerreiros estao prontos para a virtude do Sacrificio. \z
			Em razao disso, voce nao passou nesse teste. Seu progresso foi registrado. Espero que esteja pronto para a proxima {missao}.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 14)
			npcHandler:setTopic(playerId, 0)
		end
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Bem vindo ao Templo das Estatuas da Virtude.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Cuide-se!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")

npcType:register(npcConfig)


-- local internalNpcName = "Mordecai"
-- local npcType = Game.createNpcType(internalNpcName)
-- local npcConfig = {}

-- npcConfig.name = internalNpcName
-- npcConfig.description = internalNpcName

-- npcConfig.health = 100
-- npcConfig.maxHealth = npcConfig.health
-- npcConfig.walkInterval = 2000
-- npcConfig.walkRadius = 2

-- npcConfig.outfit = {
-- 	lookType = 130,
-- 	lookHead = 38,
-- 	lookBody = 132,
-- 	lookLegs = 117,
-- 	lookFeet = 3,
-- 	lookAddons = 1,
-- }

-- npcConfig.flags = {
-- 	floorchange = false,
-- }

-- npcConfig.voices = {
-- 	interval = 15000,
-- 	chance = 50,
-- 	{ text = "Come in, young mages! Purchase the latest in runes and wands!" },
-- 	{ text = "Perhaps I need to bake them hotter? Or was it longer?" },
-- 	{ text = "Offering all sorts of magic equipment!" },
-- 	{ text = "Now where did Alaistar put the wood for the new wands?" },
-- 	{ text = "Hmmm.. Maybe those crushed gems caused the strange side effect?" },
-- 	{ text = "Wands and rods, the true magician's weapons of choice!" },
-- }

-- local itemsTable = {
-- 	["runes"] = {
-- 		{ itemName = "animate dead rune", clientId = 3203, buy = 375 },
-- 		{ itemName = "avalanche rune", clientId = 3161, buy = 64 },
-- 		{ itemName = "blank rune", clientId = 3147, buy = 10 },
-- 		{ itemName = "chameleon rune", clientId = 3178, buy = 210 },
-- 		{ itemName = "convince creature rune", clientId = 3177, buy = 80 },
-- 		{ itemName = "cure poison rune", clientId = 3153, buy = 65 },
-- 		{ itemName = "destroy field rune", clientId = 3148, buy = 15 },
-- 		{ itemName = "desintegrate rune", clientId = 3197, buy = 26 },
-- 		{ itemName = "energy field rune", clientId = 3164, buy = 38 },
-- 		{ itemName = "energy wall rune", clientId = 3166, buy = 85 },
-- 		{ itemName = "energy bomb rune", clientId = 3149, buy = 203 },
-- 		{ itemName = "explosion rune", clientId = 3200, buy = 31 },
-- 		{ itemName = "fire bomb rune", clientId = 3192, buy = 147 },
-- 		{ itemName = "fire field rune", clientId = 3188, buy = 28 },
-- 		{ itemName = "fire wall rune", clientId = 3190, buy = 61 },
-- 		{ itemName = "fireball rune", clientId = 3189, buy = 30 },
-- 		{ itemName = "great fireball rune", clientId = 3191, buy = 64 },
-- 		{ itemName = "heavy magic missile rune", clientId = 3198, buy = 12 },
-- 		{ itemName = "holy missile rune", clientId = 3182, buy = 16 },
-- 		{ itemName = "icicle rune", clientId = 3158, buy = 30 },
-- 		{ itemName = "intense healing rune", clientId = 3152, buy = 95 },
-- 		{ itemName = "light magic missile rune", clientId = 3174, buy = 4 },
-- 		{ itemName = "magic wall rune", clientId = 3180, buy = 116 },
-- 		{ itemName = "paralyze rune", clientId = 3165, buy = 700 },
-- 		{ itemName = "poison bomb rune", clientId = 3173, buy = 85 },
-- 		{ itemName = "poison field rune", clientId = 3172, buy = 21 },
-- 		{ itemName = "poison wall rune", clientId = 3176, buy = 52 },
-- 		{ itemName = "stalagmite rune", clientId = 3179, buy = 12 },
-- 		{ itemName = "stone shower rune", clientId = 3175, buy = 41 },
-- 		{ itemName = "sudden death rune", clientId = 3155, buy = 162 },
-- 		{ itemName = "thunderstorm rune", clientId = 3202, buy = 52 },
-- 		{ itemName = "ultimate healing rune", clientId = 3160, buy = 175 },
-- 		{ itemName = "wild growth rune", clientId = 3156, buy = 160 },
-- 	},
-- 	["wands"] = {
-- 		{ itemName = "hailstorm rod", clientId = 3067, buy = 15000 },
-- 		{ itemName = "moonlight rod", clientId = 3070, buy = 1000 },
-- 		{ itemName = "necrotic rod", clientId = 3069, buy = 5000 },
-- 		{ itemName = "northwind rod", clientId = 8083, buy = 7500 },
-- 		{ itemName = "snakebite rod", clientId = 3066, buy = 500 },
-- 		{ itemName = "springsprout rod", clientId = 8084, buy = 18000 },
-- 		{ itemName = "terra rod", clientId = 3065, buy = 10000 },
-- 		{ itemName = "underworld rod", clientId = 8082, buy = 22000 },
-- 		{ itemName = "wand of cosmic energy", clientId = 3073, buy = 10000 },
-- 		{ itemName = "wand of decay", clientId = 3072, buy = 5000 },
-- 		{ itemName = "wand of draconia", clientId = 8093, buy = 7500 },
-- 		{ itemName = "wand of dragonbreath", clientId = 3075, buy = 1000 },
-- 		{ itemName = "wand of inferno", clientId = 3071, buy = 15000 },
-- 		{ itemName = "wand of starstorm", clientId = 8092, buy = 18000 },
-- 		{ itemName = "wand of voodoo", clientId = 8094, buy = 22000 },
-- 		{ itemName = "wand of vortex", clientId = 3074, buy = 500 },
-- 	},
-- 	["exercise weapons"] = {
-- 		{ itemName = "durable exercise rod", clientId = 35283, buy = 1250000, count = 1800 },
-- 		{ itemName = "durable exercise wand", clientId = 35284, buy = 1250000, count = 1800 },
-- 		{ itemName = "exercise rod", clientId = 28556, buy = 347222, count = 500 },
-- 		{ itemName = "exercise wand", clientId = 28557, buy = 347222, count = 500 },
-- 		{ itemName = "lasting exercise rod", clientId = 35289, buy = 10000000, count = 14400 },
-- 		{ itemName = "lasting exercise wand", clientId = 35290, buy = 10000000, count = 14400 },
-- 	},
-- 	["others"] = {
-- 		{ itemName = "spellwand", clientId = 651, sell = 299 },
-- 	},
-- }

-- npcConfig.shop = {}
-- for _, categoryTable in pairs(itemsTable) do
-- 	for _, itemTable in ipairs(categoryTable) do
-- 		table.insert(npcConfig.shop, itemTable)
-- 	end
-- end

-- local keywordHandler = KeywordHandler:new()
-- local npcHandler = NpcHandler:new(keywordHandler)

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
-- 	local player = Player(creature)
-- 	local playerId = player:getId()

-- 	if not npcHandler:checkInteraction(npc, creature) then
-- 		return false
-- 	end

-- 	local categoryTable = itemsTable[message:lower()]

-- 	if categoryTable then
-- 		local remainingCategories = npc:getRemainingShopCategories(message:lower(), itemsTable)
-- 		npcHandler:say("Of course, just browse through my wares. You can also look at " .. remainingCategories .. ".", npc, player)
-- 		npc:openShopWindowTable(player, categoryTable)
-- 	end
-- 	return true
-- end

-- npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
-- npcHandler:setMessage(MESSAGE_GREET, "Welcome to the magic emporium, child. Ask me for a trade if you need {runes}, {wands}, or spellbooks.")
-- npcHandler:setMessage(MESSAGE_FAREWELL, "Take care, child.")
-- npcHandler:setMessage(MESSAGE_WALKAWAY, "Ah, the impetuosity of youth.")
-- npcHandler:setMessage(MESSAGE_SENDTRADE, "Choose wisely! Or maybe you want to look only at " .. GetFormattedShopCategoryNames(itemsTable) .. ".")
-- npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- -- On buy npc shop message
-- npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
-- 	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
-- end
-- -- On sell npc shop message
-- npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
-- 	player:sendTextMessage(MESSAGE_TRADE, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
-- end
-- -- On check npc shop message (look item)
-- npcType.onCheckItem = function(npc, player, clientId, subType) end

-- -- Dialog options (interactive icons in the NPC conversation window)
-- npcType:addDialogOptions("trade", "bye")

-- npcType:register(npcConfig)
