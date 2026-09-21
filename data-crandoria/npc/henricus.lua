local internalNpcName = "Henricus"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 132,
	lookHead = 79,
	lookBody = 0,
	lookLegs = 96,
	lookFeet = 0,
	lookAddons = 0
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

local flaskCost = 1000

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local missing, totalBlessPrice = Blessings.getInquisitionPrice(player)

	if MsgContains(message, "inquisitor") then
		npcHandler:say("As igrejas dos deuses confiaram a mim a enorme e responsavel tarefa de liderar a inquisicao. Eu deixo o trabalho de campo para os inquisidores que recruto entre pessoas adequadas que cruzam meu caminho.", npc, creature)
	elseif MsgContains(message, "join") then
		if player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline) < 1 then
			npcHandler:say("Voce quer se juntar a inquisicao?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		end
	elseif MsgContains(message, "blessing") or MsgContains(message, "bless") then
		if player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline) == 25 then --if quest is done
			npcHandler:say("Voce quer receber a bencao da inquisicao - o que significa ".. (missing == 5 and "todas as cinco disponiveis" or missing ) .." bencaos - por " .. totalBlessPrice .. " ouro?", npc, creature)
			npcHandler:setTopic(playerId, 7)
		else
			npcHandler:say("Voce nao pode obter esta bencao a menos que tenha completado a Missao da Inquisicao.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "flask") or MsgContains(message, "special flask") then
		if player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline) >= 12 then -- give player the ability to purchase the flask.
		npcHandler:say("Voce quer comprar o frasco especial de agua benta por " .. flaskCost .. " ouro?", npc, creature)
		npcHandler:setTopic(playerId, 8)
		else
			npcHandler:say("Voce nao precisa deste frasco agora.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "mission") or MsgContains(message, "missao") or MsgContains(message, "report") then
		if player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline) < 1 then
			npcHandler:say("Voce quer se juntar a inquisicao?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		elseif player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline) == 1 then
			npcHandler:say({
				"Vamos ver se voce e digno. Pegue o guia de campo de um inquisidor na caixa da sala dos fundos. ...",
				"Siga as instrucoes do guia para falar com os guardas Thaianos que protegem os muros e portoes da cidade e teste a lealdade deles. Depois me informe sobre sua {missao}."
			}, npc, creature)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline, 2)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Mission01, 1) -- The Inquisition Questlog- "Mission 1: Interrogation"
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline) == 2 then
			npcHandler:say("Sua missao atual e investigar a confiabilidade de certos guardas. Voce terminou essa missao?", npc, creature)
			npcHandler:setTopic(playerId, 3)
		elseif player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline) == 3 then
			npcHandler:say({
				"Escute, temos informacoes sobre um coven de hereges que se esconde em uma montanha chamada O Grande Antigo. As bruxas chegam a este lugar amaldiçoado em vassouras voadoras e pensam que estao seguras la. ...",
				"Eu providenciei um tapete voador que levara voce ao esconderijo delas. Viaje para as Colinas de Femor e diga ao piloto do tapete a palavra-chave 'eclipse' ...",
				"Ele levara voce ao seu destino. No local de reuniao delas, voce encontrara um caldeirao onde elas preparam uma bebida proibida ...",
				"Use este frasco de agua benta para destruir a bebida. Tambem roube o grimorio delas e traga-o para mim."
			}, npc, creature)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline, 4)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Mission02, 1) -- The Inquisition Questlog- "Mission 2: Eclipse"
			player:addItem(133, 1)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline) == 5 then
			if player:removeItem(7874, 1) then
				npcHandler:say({
					"Acho que chegou a hora de realmente testar suas habilidades. Um de nossos aliados solicitou ajuda. Acho que voce e exatamente a pessoa certa para ajuda-lo ...",
					"Storkus e um anao velho e mal-humorado que trabalha como cacador de vampiros ha muitas e muitas decadas. Ele e bastante bem-sucedido, mas ate mesmo ele tem seus limites. ...",
					"Por isso, ocasionalmente enviamos ajuda para ele. Em troca, ele treina e testa nossos recrutas. E um acordo vantajoso para ambos os lados ...",
					"Voce o encontrara em sua caverna na montanha nos arredores de Kazordoon. Ele contara a voce sobre sua proxima missao."
				}, npc, creature)
				player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline, 6)
				player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Mission02, 3) -- The Inquisition Questlog- "Mission 2: Eclipse"
				player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Mission03, 1) -- The Inquisition Questlog- "Mission 3: Vampire Hunt"
			else
				npcHandler:say("Voce precisa me trazer o grimorio das bruxas.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline) > 5 and player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline) < 11 then
			npcHandler:say("Sua missao atual e ajudar o cacador de vampiros Storkus. Voce terminou essa missao?", npc, creature)
			npcHandler:setTopic(playerId, 4)
		elseif player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline) == 11 then
			npcHandler:say({
				"Recebemos um relatorio sobre uma casa abandonada e assombrada em Liberty Bay. Quero que voce examine essa casa. Ela e a unica ruina em Liberty Bay, entao voce nao tera problemas para encontra-la. ...",
				"Existe uma criatura maligna em algum lugar. Acredito que sera mais facil encontrar o local correto durante a noite. Use este frasco de agua benta nesse local para expulsar a criatura maligna."
			}, npc, creature)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline, 12)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Mission04, 1) -- The Inquisition Questlog- "Mission 4: The Haunted Ruin"
			player:addItem(133, 1)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline) == 12 or player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline) == 13 then
			npcHandler:say("Sua missao atual e exorcizar uma criatura maligna de uma casa em Liberty Bay. Voce terminou essa missao?", npc, creature)
			npcHandler:setTopic(playerId, 5)
		elseif player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline) == 14 then
			npcHandler:say({
				"Voce enfrentou hereges, bruxas, vampiros e fantasmas. Agora esteja preparado para enfrentar as criaturas mais malignas contra as quais lutamos - demonios. Sua nova tarefa e extremamente simples, embora esteja longe de ser facil. ...",
				"Va e elimine criaturas demoniacas onde quer que as encontre. Traga-me 20 de suas essencias como prova de suas conquistas."
			}, npc, creature)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline, 15)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Mission05, 1) -- The Inquisition Questlog- "Mission 5: Essential Gathering"
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline) == 15 then
			if player:removeItem(6499, 20) then
				npcHandler:say({
					"Voce e realmente um protetor dedicado dos verdadeiros fieis. Nao pare agora. Mate o maximo dessas criaturas que conseguir. ...",
					"Eu tambem tenho uma recompensa pelos seus grandes esforcos. Fale comigo sobre sua {roupa de cacador de demonios} a qualquer momento a partir de agora. Depois disso, vamos falar sobre a proxima missao que espera por voce."
				}, npc, creature)
				player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline, 16)
				player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Mission05, 2) -- The Inquisition Questlog- "Mission 5: Essential Gathering"
			else
				npcHandler:say("Voce precisa de 20 delas.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline) == 17 then
			npcHandler:say({
				"Temos informacoes sobre algo muito perigoso acontecendo na ilha de Magincia. Os demonios estao preparando algo la ...",
				"Algo que e uma ameaca para todos nos. Nossos investigadores conseguiram obter informacoes vitais antes que alguns deles fossem mortos por um demonio chamado Ungreez. ...",
				"Sua tarefa sera se vingar e matar esse demonio. Voce o encontrara nas profundezas de Magincia. Boa sorte."
			}, npc, creature)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline, 18)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Mission06, 1) -- The Inquisition Questlog- "Mission 6: The Demon Ungreez"
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline) == 19 then
			npcHandler:say({
				"Entao a fera finalmente esta morta! Agradeca aos deuses. Pelo menos algumas coisas estao dando certo para nos ...",
				"Nossos outros agentes nao tiveram tanta sorte, porem. Mas voce sabera mais sobre isso em sua proxima {missao}."
			}, npc, creature)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline, 20)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Mission06, 3) -- The Inquisition Questlog- "Mission 6: The Demon Ungreez"
			player:addOutfitAddon(288, 1)
			player:addOutfitAddon(289, 1)
			local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
			player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
			player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline) == 20 then
			npcHandler:say("Destrua o nexus das sombras usando este frasco de agua benta e mate todos os lordes demonios.", npc, creature)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline, 21)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Mission07, 1) -- The Inquisition Questlog- "Mission 7: The Shadow Nexus"
			player:addItem(133, 1)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline) == 21 or player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline) == 22 then
			npcHandler:say("Sua missao atual e destruir o nexus das sombras na Forja dos Demonios. Voce terminou essa missao?", npc, creature)
			npcHandler:setTopic(playerId, 6)
		end
	elseif MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 2 then
			npcHandler:say("Que assim seja. Agora voce e um membro da inquisicao. Voce pode me pedir uma {missao} para aumentar minha consideracao por voce.", npc, creature)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline, 1)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 3 then
			if player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.WalterGuard) == 1 and player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.KulagGuard) == 1 and player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.GrofGuard) == 1 and player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.MilesGuard) == 1 and player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.TimGuard) == 1 then
				npcHandler:say({
					"De fato, isso e exatamente o que minhas outras fontes me disseram. Naturalmente, eu ja sabia o resultado desta investigacao antes mesmo dela acontecer. Isso foi apenas um teste. ...",
					"Bem, agora que voce provou ser util, pode me pedir outra missao. Vamos ver se voce tambem consegue lidar com algum trabalho de campo."
				}, npc, creature)
				player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline, 3)
				player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Mission01, 7) -- The Inquisition Questlog- "Mission 1: Interrogation"
			else
				npcHandler:say("Voce ainda nao concluiu sua missao.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 4 then
			if player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline) == 10 then
				npcHandler:say("Bom, voce retornou. Sua habilidade em assuntos praticos parece ser util. Se estiver pronto para uma nova missao, basta perguntar.", npc, creature)
				player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline, 11)
				player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Mission03, 6) -- The Inquisition Questlog- "Mission 3: Vampire Hunt"
			else
				npcHandler:say("Voce ainda nao concluiu sua missao com {Storkus}.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 5 then
			if player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline) == 13 then
				npcHandler:say("Bem, essa foi uma tarefa facil, mas sua proxima missao sera muito mais desafiadora.", npc, creature)
				player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline, 14)
				player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Mission04, 3) -- The Inquisition Questlog- "Mission 4: The Haunted Ruin"
			else
				npcHandler:say("Voce ainda nao concluiu sua missao com {Storkus}.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 6 then
			if player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline) == 22 then
				npcHandler:say({
					"Incrivel! Voce e um verdadeiro defensor da fe! Eu concedo a voce o titulo de Alto Inquisidor por seus nobres feitos. A partir de agora voce pode obter a bencao da inquisicao, tornando a peregrinacao das cinzas desnecessaria ...",
					"A bencao da inquisicao concedera a voce todas as bencaos disponiveis pelo preco de 110000 de ouro. Alem disso, nao se esqueca de me perguntar sobre sua {roupa} para receber o ultimo addon como cacador de demonios."
				}, npc, creature)
				player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline, 23)
				player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Mission07, 3) -- The Inquisition Questlog- "Mission 7: The Shadow Nexus"
				player:addAchievement('High Inquisitor')
			else
				npcHandler:say("Volte quando tiver destruido o nexus das sombras.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 8 then
			if player:removeMoneyBank(flaskCost) then
				npcHandler:say("Aqui esta seu novo frasco, |PLAYERNAME|.", npc, creature)
				player:addItem(133, 1)
			else
				npcHandler:say("Volte quando tiver dinheiro suficiente.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 7 then
			if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) < 1 then
				if missing == 0 then
					npcHandler:say("Voce ja recebeu a bencao!", npc, creature)
				elseif player:removeMoneyBank(totalBlessPrice) then
					npcHandler:say("Voce recebeu a bencao de todos os cinco deuses, |PLAYERNAME|.", npc, creature)
					player:addMissingBless(false)
					player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
				else
					npcHandler:say("Volte quando tiver dinheiro suficiente.", npc, creature)
				end
			else
				npcHandler:say("Jogadores do modo Hardcore nao podem obter bless por este meio.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "no") then
		if npcHandler:getTopic(playerId) > 0 then
			npcHandler:say("Entao nao.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "outfit") then
		if player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline) == 16 then
			npcHandler:say("Aqui esta sua roupa de cacador de demonios. Voce merece isso. Desbloqueie mais addons completando mais missoes.", npc, creature)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline, 17)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Mission05, 3) -- The Inquisition Questlog- "Mission 5: Essential Gathering"
			player:addOutfit(288, 0)
			player:addOutfit(289, 0)
			local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
			player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
			player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline) == 23 then
			npcHandler:say("Aqui esta o addon final da sua roupa de cacador de demonios. Parabens!", npc, creature)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline, 24)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Mission07, 4) -- The Inquisition Questlog- "Mission 7: The Shadow Nexus"
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.RewardDoor, 1)
			player:addOutfitAddon(288, 1)
			player:addOutfitAddon(289, 1)
			player:addOutfitAddon(288, 2)
			player:addOutfitAddon(289, 2)
			local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
			player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
			player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			player:addAchievement('Demonbane')
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, 'dark') then
		npcHandler:say({
			'Os poderes sombrios estao sempre presentes. Se um humano demonstrar apenas a menor fraqueza, eles tentarao corrompe-lo e atrai-lo para seus servicos. ...',
			'Devemos estar sempre atentos ao mal, que aparece de muitas formas diferentes.'
		}, npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, 'king') then
		npcHandler:say({
			'Os reis Thaianos sao coroados por um representante das igrejas. Isso significa que eles governam em nome dos deuses do bem e fazem parte do plano divino para a humanidade. ...',
			'Como lideres nominais da igreja de Banor, os reis nao sao apenas autoridades mundanas, mas tambem autoridades espirituais. ...',
			'Os reis financiam a inquisicao e as vezes fornecem recursos humanos em assuntos de extrema importancia. A inquisicao, em retorno, protege o reino contra hereges e individuos que tentam enfraquecer o dominio sagrado dos reis.'
		}, npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, 'banor') then
		npcHandler:say({
			'No passado, a ordem de Banor era a unica ordem de cavalaria existente. Com o passar do tempo, a ordem se concentrou cada vez mais em assuntos espirituais em vez de assuntos mundanos. ...',
			'Atualmente, a ordem de Banor sanciona novas ordens e oferece orientacao espiritual aos guerreiros do bem.'
		}, npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, 'fardos') then
		npcHandler:say('Os sacerdotes de Fardos sao frequentemente misticos que se afastaram dos assuntos mundanos. Outros oferecem orientacao e cura para pessoas necessitadas nos templos.', npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, 'uman') then
		npcHandler:say({
			'A igreja de Uman supervisiona a educacao das massas, assim como as atividades das guildas de feiticeiros e druidas. Ela decide quais linhas de pesquisa estao de acordo com a vontade de Uman e quais nao estao. ...',
			'Preocupada, a inquisicao observa as tentativas dessas guildas de se tornarem cada vez mais independentes e de tomarem suas proprias decisoes. ...',
			'Infelizmente, a guilda dos feiticeiros se tornou perigosamente influente e, por isso, as maos de nossos sacerdotes estao presas devido a questoes politicas ...',
			'Os druidas recentemente afirmam que estao servindo a vontade de Crunor e nao a de Uman. Tal heresia so poderia se tornar possivel com a independencia de Carlin do reino Thaiano. ...',
			'O centro espiritual dos druidas mudou-se para Carlin, onde eles possuem grande influencia e nao podem ser supervisionados pela inquisicao.'
		}, npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, 'fafnar') then
		npcHandler:say({
			'Fafnar e principalmente adorado pelos camponeses e agricultores das areas rurais. ...',
			'A inquisicao observa atentamente essas atividades. As pessoas simplesmente tendem a misturar supersticoes locais com os ensinamentos dos deuses. Isso pode novamente levar ao surgimento de subcultos hereges.'
		}, npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, 'edron') then
		npcHandler:say({
			'Edron ilustra perfeitamente por que a inquisicao e necessaria e por que precisamos de mais recursos e pessoal. ...',
			'Nossos agentes estavam a caminho para investigar certos acontecimentos la quando alguns cavaleiros sem fe fugiram para algumas ruinas profanas. ...',
			'Fomos incapazes de elimina-los e a ordem local de cavalaria ofereceu pouca ajuda. ...',
			'E quase certo que algo perigoso esta acontecendo la, entao precisamos continuar nossos esforcos.'
		}, npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, 'ankrahmun') then
		npcHandler:say({
			'Mesmo que afirmem o contrario, esta cidade esta firmemente sob o controle de Zathroth e seus lacaios malignos. Toda a sua religiao distorcida e uma zombaria dos ensinamentos dos nossos deuses ...',
			'Assim que reunirmos forca suficiente, devemos destruir esta cidade de uma vez por todas.'
		}, npc, creature)
		npcHandler:setTopic(playerId, 0)
	end
	return true
end

keywordHandler:addKeyword({'paladin'}, StdModule.say, {npcHandler = npcHandler, text = 'It\'s a shame that only a few paladins still use their abilities to further the cause of the gods of good. Too many paladins have become selfish and greedy.'})
keywordHandler:addKeyword({'knight'}, StdModule.say, {npcHandler = npcHandler, text = 'Nowadays, most knights seem to have forgotten the noble cause to which all knights were bound in the past. Only a few have remained pious, serve the gods and follow their teachings.'})
keywordHandler:addKeyword({'sorcerer'}, StdModule.say, {npcHandler = npcHandler, text = 'Those who wield great power have to resist great temptations. We have the burden to eliminate all those who give in to the temptations.'})
keywordHandler:addKeyword({'druid'}, StdModule.say, {npcHandler = npcHandler, text = 'The druids here still follow the old rules. Sadly, the druids of Carlin have left the right path in the last years.'})
keywordHandler:addKeyword({'dwarf'}, StdModule.say, {npcHandler = npcHandler, text = 'The dwarfs are allied with Thais but follow their own obscure religion. Although dwarfs keep mostly to themselves, we have to observe this alliance closely.'})
keywordHandler:addKeyword({'kazordoon'}, StdModule.say, {npcHandler = npcHandler, text = 'The dwarfs are allied with Thais but follow their own obscure religion. Although dwarfs keep mostly to themselves, we have to observe this alliance closely.'})
keywordHandler:addKeyword({'elves'}, StdModule.say, {npcHandler = npcHandler, text = 'Those elves are hardly any more civilised than orcs. They can become a threat to mankind at any time.'})
keywordHandler:addKeyword({'ab\'dendriel'}, StdModule.say, {npcHandler = npcHandler, text = 'Those elves are hardly any more civilised than orcs. They can become a threat to mankind at any time.'})
keywordHandler:addKeyword({'venore'}, StdModule.say, {npcHandler = npcHandler, text = 'Venore is somewhat difficult to handle. The merchants have a close eye on our activities in their city and our authority is limited there. However, we will use all of our influence to prevent a second Carlin.'})
keywordHandler:addKeyword({'drefia'}, StdModule.say, {npcHandler = npcHandler, text = 'Drefia used to be a city of sin and heresy, just like Carlin nowadays. One day, the gods decided to destroy this town and to erase all evil there.'})
keywordHandler:addKeyword({'darashia'}, StdModule.say, {npcHandler = npcHandler, text = 'Darashia is a godless town full of mislead fools. One day, it will surely share the fate of its sister town Drefia.'})
keywordHandler:addKeyword({'demon'}, StdModule.say, {npcHandler = npcHandler, text = 'Demons exist in many different shapes and levels of power. In general, they are servants of the dark gods and command great powers of destruction.'})
keywordHandler:addKeyword({'carlin'}, StdModule.say, {npcHandler = npcHandler, text = 'Carlin is a city of sin and heresy. After the reunion of Carlin with the kingdom, the inquisition will have much work to purify the city and its inhabitants.'})
keywordHandler:addKeyword({'zathroth'}, StdModule.say, {npcHandler = npcHandler, text = 'We can see his evil influence almost everywhere. Keep your eyes open or the dark one will lead you on the wrong way and destroy you.'})
keywordHandler:addKeyword({'crunor'}, StdModule.say, {npcHandler = npcHandler, text = 'The church of Crunor works closely together with the druid guild. This makes a cooperation sometimes difficult.'})
keywordHandler:addKeyword({'gods'}, StdModule.say, {npcHandler = npcHandler, text = 'We owe to the gods of good our creation and continuing existence. If it weren\'t for them, we would surely fall prey to the minions of the vile and dark gods.'})
keywordHandler:addKeyword({'church'}, StdModule.say, {npcHandler = npcHandler, text = 'The churches of the gods united to fight heresy and dark magic. They are the shield of the true believers, while the inquisition is the sword that fights all enemies of virtuousness.'})
keywordHandler:addKeyword({'inquisitor'}, StdModule.say, {npcHandler = npcHandler, text = 'The churches of the gods entrusted me with the enormous and responsible task to lead the inquisition. I leave the field work to inquisitors who I recruit from fitting people that cross my way.'})
keywordHandler:addKeyword({'believer'}, StdModule.say, {npcHandler = npcHandler, text = 'Belive on the gods and they will show you the path.'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'By edict of the churches I\'m the Lord Inquisitor.'})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m Henricus, the Lord Inquisitor.'})

npcHandler:setMessage(MESSAGE_GREET, "Saudacoes, |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Esteja sempre atento, |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Voce parece apressado demais...")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "holy water", clientId = 133, buy = 1000 }
}
-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType)
end

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
