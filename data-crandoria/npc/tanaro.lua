local internalNpcName = "Tanaro"
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
	lookHead = 113,
	lookBody = 0,
	lookLegs = 97,
	lookFeet = 115,
	lookAddons = 1
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

local config = {
	sorcerer = {
		id = 1367,
		name = "Bladespark",
	},
	druid = {
		id = 1364,
		name = "Mossmasher",
	},
	paladin = {
		id = 1366,
		name = "Sandscourge",
	},
	knight = {
		id = 1365,
		name = "Snowbash",
	},
	monk = {
		id = 1819,
		name = "Moonhunter",
	},
}

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

	local vocation = config[player:getVocation():getBase():getName():lower()]

    local storage = player:getStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso)
	local outfit = player:getOutfit().lookType
	local lookHead = player:getOutfit().lookHead
	local lookBody = player:getOutfit().lookBody
	local lookLegs = player:getOutfit().lookLegs
	local lookFeet = player:getOutfit().lookFeet
	local lookAddons = 3

    if MsgContains(message, "mission") or MsgContains(message, "missao") then
		if player:getLevel() < 200 then
			npcHandler:say("Sinto muito, nobre guerreiro, mas voce nao possuir forca o suficiente para me ajudar. Volte apos o nivel 200. ", npc, creature)
            npcHandler:setTopic(playerId, 0)
		else
			if storage < 1 then
				npcHandler:say("Estou ha alguns meses vivendo nesse lugar enquanto estudo os cogumelos de Trivallis e suas propriedades em busca de efeitos especiais. \z
				Quando Donahue descobriu essa ilha eu sabia que haveria algo para pesquisar e aprimorar meus conhecimentos e, bom, aqui estou! Enfim, vamos ao que interessa... \z
				Para retirar os esporos de cogumelos e cultiva-los, talvez voce possa obter alguns deles para mim... O que acha? Pode me ajudar?", npc, creature)
                npcHandler:setTopic(playerId, 1)
			elseif storage == 1 then
				npcHandler:say("Voce trouxe os pinceis?", npc, creature)
                npcHandler:setTopic(playerId, 2)
			elseif storage == 2 then
				npcHandler:say("Estou cultivando novas especies de cogumelos e preciso de alguem para usar de cobaia. Gostaria de experimentar?", npc, creature)
                npcHandler:setTopic(playerId, 3)
			elseif storage >= 3 and storage < 6 then
				npcHandler:say("Precisamos do Elixir. Obtenha o item com Percybald, na Antiga Arena de Trivallis.", npc, creature)
                npcHandler:setTopic(playerId, 0)
			elseif storage == 6 then
				npcHandler:say("E entao, conseguiu o Elixir?", npc, creature)
                npcHandler:setTopic(playerId, 4)
			elseif storage == 7 then
				npcHandler:say("Voce por acaso tem medo de fogo? Ha ha ha ha! Existe um estabilizante de reacoes muito potente em Trivallis: A massa vulcanica (volcanic mass). \z
				O unico problema sera conseguir essa massa. Ha apenas uma pequena area com atividade vulcanica na ilha e o local esta cercado por criaturas de fogo e Nightmares. \z
				Se conseguir passar por eles e encontrar o ponto com lava, basta pegar um pouco de massa de um dos geysers desativados ao lado. Entendeu tudo? Esta pronto?", npc, creature)
                npcHandler:setTopic(playerId, 5)
			elseif storage == 8 then
				npcHandler:say("Va e colete a massa vulcanica na montanha no centro da ilha!", npc, creature)
                npcHandler:setTopic(playerId, 0)
			elseif storage == 9 then
				npcHandler:say("Espero que nao tenha passado por muito sufoco na montanha. Voce trouxe a massa vulcanica?", npc, creature)
                npcHandler:setTopic(playerId, 6)
			elseif storage == 10 then
				if player:getStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Timer) > os.time() then
					npcHandler:say("Espere, jovem. Ainda estou estudando.", npc, creature)
                	npcHandler:setTopic(playerId, 0)
				else
					if summoner then
						npcHandler:say("Certo, eu descobri! Tenho uma noticia boa e uma ruim. A noticia boa: Eu descobri o que falta para que a mistura fique perfeita! Porem... \z
						A noticia ruim: nao funcionara em voce. Alias... nao diretamente. Mas tenho quase certeza que essa mistura deixara seus summons um pouco mais fortes! \z
						Se voce quiser buscar pelo ultimo ingrediente, usarei uma amostra em voce. Voce topa?", npc, creature)
						npcHandler:setTopic(playerId, 7)		
					else
						npcHandler:say("Certo, eu descobri! Tenho uma noticia boa e uma ruim. A noticia boa: Eu descobri o que falta para que a mistura fique perfeita! Porem... \z
						A noticia ruim: nao funcionara em voce. Alias... nao diretamente. Mas tenho quase certeza que essa mistura dara ao seu familiar novos poderes permanentemente! \z
						Se voce quiser buscar pelo ultimo ingrediente, usarei uma amostra em voce. Voce topa?", npc, creature)
						npcHandler:setTopic(playerId, 7)
					end
				end
			elseif storage == 11 then
				npcHandler:say("Finalmente! Voce trouxe o ovo de inseto?", npc, creature)
                npcHandler:setTopic(playerId, 8)
			elseif storage == 12 then
				npcHandler:say("Li num de meus livros que precisamos de um tipo de artefato para canalizar os poderes das invocacoes pelo seu corpo junto a nossa mistura. Ja preparei o encantamento. \z
				Agora so precisamos do artefato. Algo me diz que os piratas a leste da ilha podem possuir o item em seus tesouros, mas voce tera que enfrenta-los para isso... voce consegue?", npc, creature)
				npcHandler:setTopic(playerId, 9)
			elseif storage == 13 or storage == 14 then
				npcHandler:say("Encontre Dorian, entre os piratas ao leste, e fale com ele sobre o {monstro} do qual eu te falei.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			elseif storage == 15 then
				npcHandler:say("Voce trouxe o artefato?", npc, creature)
				npcHandler:setTopic(playerId, 10)
			elseif storage == 16 then
				npcHandler:say("Bom, como voce conseguiu me ajudar em minha pesquisa, acho que posso confiar em voce para um novo desafio. Nao se preocupe, esse sera breve. \z
				Ouvi dizer que em alguma ilha do Novo Continente ha dragoes capazes de fornecer sangue cristalizado (Crystallized Blood). Se conseguir para mim, sera recompensado. \z
				Demore o tempo que quiser, estarei aqui esperando.", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 17)
				npcHandler:setTopic(playerId, 0)
			elseif storage == 17 then
				npcHandler:say("Voce trouxe o sangue cristalizado?", npc, creature)
				npcHandler:setTopic(playerId, 11)
			end
		end
    elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Isso! E a pesquisa continuaaaa! Ha ha ha. Digo.. obrigado por isso. Veja bem, os pinceis que voce busca podem ser obtidos logo aqui ao lado. \z
			Nas muralhas dessa parte da ilha se esconde um bando de acumuladores de riquezas. Como amantes das artes, varios deles possuem esses pinceis. Nao esta facil? \z
			So ha um problema: Os pinceis tem pouca durabilidade, entao preciso de muitos. Traga-me ao menos uns... 25 pinceis! Isso! 25 pinceis e te darei uma recompensa.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 1)
            npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 2 then
			if player:getItemCount(25689) >= 25 then
				player:removeItem(25689, 25)
				npcHandler:say("... 23... 24... 25! Muito bom! Agoa posso cultivar essa especie em diferentes substratos facilmente! Em breve vou testar quais sao suas propriedades \z
				Aqui, sua recompensa. Ei! Espere! Voce poderia ser uma de minhas cobaias! Nao... isso pode ser perigoso. Ou talvez seja um desafio para uma proxima {missao}...", npc, creature)
            	player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 2)
				player:addItem(3043, 10)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Acho que voce errou na conta...", npc, creature)
                npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 3 then
			npcHandler:say("Muito bem, aqui esta. Minha nossa! Fascinante! Voce mudou totalmente de forma, mas parece que nao dura muito tempo. Preciso testar algumas combinacoes. \z
			Ja sei! Talvez a gente consiga algo com os gladiaroes que vivem numa arena abandonada na regiao leste de Trivallis. Eles possuem um elixir que os torna mais fortes. \z
			Talvez Percybald, o 'chefe' do lugar, possa te ajudar a conseguir. Mas cuidado, os gladiadores da Arena nao sao tao amigaveis quanto ele... Va e tente conseguir o elixir.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 3)
			local condition = Condition(CONDITION_OUTFIT)
			condition:setOutfit({lookType = 677})
			condition:setTicks(5000)
			player:addCondition(condition)
			player:say('Gulp!', TALKTYPE_MONSTER_SAY)
            npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 4 then
			if player:getItemCount(21554) >= 1 then
				player:removeItem(21554, 1)
				npcHandler:say("Bom... realmente muito bom. Eu nunca consegui entender como esse elixir pode ser produzido naquelas condicoes... Enfim. Farei um teste com uma mistura. \z
				Cogumelos e elixir. Tome! Um, dois, tres e... nada? Hum... o elixir anulou o efeito do cogumelo, no lugar de potencializar. Deve estar faltando alguma coisa. Forma, forca...\z
				Ja sei!! Ha um terceiro ingrediente que pode ser a chave e acredito que nao seja um grande desafio para voce. Me diga quando estiver pronto para a proxima {missao}.", npc, creature)
            	player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 7)
				player:addExperience(1000000)
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Nao vejo elixir nenhum.", npc, creature)
                npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 5 then
			npcHandler:say("Muito bem, entao va! Tenha cuidado no caminho, ficarei aqui a sua espera.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 8)
            npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 6 then
			local vida = player:getHealth() / 2
			if player:getItemCount(9147) >= 1 then
				player:removeItem(9147, 1)
				npcHandler:say("Otimo! Misturando tudo... Ok. Agora veremos. Coma tudo! E... MINHA NOSSA!! Certo. Certo, os efeitos ainda foram rapidos. Esta tudo bem. \z
				Pelo que posso ver voce ganhou nova forma e mais forca, mas perdeu vida. Preciso ler meus livros e pensar em uma solucao. \z
				Facamos assim, retorne daqui 10 minutos e direi qual sera o proximo passo!", npc, creature)
				local condition = Condition(CONDITION_OUTFIT)
				condition:setOutfit({lookType = 676})
				condition:setTicks(5000)
				player:addCondition(condition)
				player:setHealth(vida)
				player:say('Gulp!', TALKTYPE_MONSTER_SAY)
				player:addExperience(1000000)
				player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 10)
				player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Timer, os.time() + 60 * 10)
			else
				npcHandler:say("Preciso da massa vulcanica para estabilizar a reacao do cogumelo com o elixir.", npc, creature)
                npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 7 then
			npcHandler:say("Mesmo? Digo.. que otimo! Eu sempre precisei de uma cobaia tao disposta quanto voce! He he he he... Vamos la! Sua ultima missao: Obter 1 Mutant Insect Egg. \z
			Esses ovos de insetos podem ser obtidos do monstro Spidris Elite, localizado na regiao sul de Trivallis. Eles sao raros, mas com esforco voce encontrara um.\z
			Ha apenas um problema: Ovos retirados dos isnetos tem baixa durabilidade e se desintegram em cerca de 15 minutos. Entao esse sera o tempo que voce tera para traze-lo ate mim apos obte-lo. Agora va!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 11)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 8 then
			if player:getItemCount(9156) >= 1 then
				player:removeItem(9156, 1)
				player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 12)
				npcHandler:say("Voce conseguiu!! Muito bom! Infelizmente, temos um ultimo processo para conseguir realizar o processo para transformar suas invocacoes... \z
				Li num de meus livros que precisamos de um tipo de artefato para canalizar os poderes das invocacoes pelo seu corpo junto a nossa mistura. Ja preparei o encantamento. \z
				Agora so precisamos do artefato. Algo me diz que os piratas a leste da ilha podem possuir o item em seus tesouros, mas voce tera que enfrenta-los para isso... voce consegue?", npc, creature)
				npcHandler:setTopic(playerId, 9)
			else
				npcHandler:say("Nao estou vendo nenhum ovo. Talvez ele tenha de desintegrado no caminho ate aqui.", npc, creature)
                npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 9 then
			npcHandler:say("Sua disposicao me deixa ainda mais animado! Muito bem. Mas escute... eu soube que os piratas de aliaram a um terrivel monstro do mar que agra eles controlam. \z
			Provavelmente os tesouros mais preciosos deles estao sendo guardados por esse monstro. Talvez voce tenha que derrota-lo. Procure por Dorian no local e ele pode te ajudar a encontra-lo. \z
			Talvez ele queira algo em troca... Fale com ele sobre o {monstro} e veja se ele pode ajudar. Boa sorte! Nao retorne sem o artefato.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 13)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 10 then
			if knight then
				if player:getItemCount(35589) >= 1 then
					npcHandler:say("Excelente! Voce trouxe o artefato correto! Muito bem, segure-o enquanto voce toma isso. Vou recitar o encantamento... \z
					~ Encantamento confuso ~... Pronto! Sentiu alguma coisa? Bom... de qualquer forma, voce vera os efeitos! Agora seu familiar ficara diferente!", npc, creature)
					player:addExperience(10000000, true)
					player:addFamiliar(vocation.id)
					player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 16)
					player:say('Gulp!', TALKTYPE_MONSTER_SAY)
					player:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Voce nao possui o artefato correto. Knights devem obter o artefato Snowbash Figurine. Volte quando o possuir.", npc, creature)
                	npcHandler:setTopic(playerId, 0)
				end
			elseif paladin then
				if player:getItemCount(35590) >= 1 then
					npcHandler:say("Excelente! Voce trouxe o artefato correto! Muito bem, segure-o enquanto voce toma isso. Vou recitar o encantamento... \z
					~ Encantamento confuso ~... Pronto! Sentiu alguma coisa? Bom... de qualquer forma, voce vera os efeitos! Agora seu familiar ficara diferente!", npc, creature)
					player:addExperience(10000000, true)
					player:addFamiliar(vocation.id)
					player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 16)
					player:say('Gulp!', TALKTYPE_MONSTER_SAY)
					player:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Voce nao possui o artefato correto. Paladins devem obter o artefato Sandscourge Figurine. Volte quando o possuir.", npc, creature)
                	npcHandler:setTopic(playerId, 0)
				end
			elseif sorcerer then
				if player:getItemCount(35592) >= 1 then
					npcHandler:say("Excelente! Voce trouxe o artefato correto! Muito bem, segure-o enquanto voce toma isso. Vou recitar o encantamento... \z
					~ Encantamento confuso ~... Pronto! Sentiu alguma coisa? Bom... de qualquer forma, voce vera os efeitos! Agora seu familiar ficara diferente!", npc, creature)
					player:addExperience(10000000, true)
					player:addFamiliar(vocation.id)
					player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 16)
					player:say('Gulp!', TALKTYPE_MONSTER_SAY)
					player:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Voce nao possui o artefato correto. Sorcerer devem obter o artefato Bladespark Figurine. Volte quando o possuir.", npc, creature)
                	npcHandler:setTopic(playerId, 0)
				end
			elseif druid then
				if player:getItemCount(35591) >= 1 then
					npcHandler:say("Excelente! Voce trouxe o artefato correto! Muito bem, segure-o enquanto voce toma isso. Vou recitar o encantamento... \z
					~ Encantamento confuso ~... Pronto! Sentiu alguma coisa? Bom... de qualquer forma, voce vera os efeitos! Agora seu familiar ficara diferente!", npc, creature)
					player:addExperience(10000000, true)
					player:addFamiliar(vocation.id)
					player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 16)
					player:say('Gulp!', TALKTYPE_MONSTER_SAY)
					player:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Voce nao possui o artefato correto. Druids devem obter o artefato Mossmasher Figurine. Volte quando o possuir.", npc, creature)
                	npcHandler:setTopic(playerId, 0)
				end
			elseif monk then
				if player:getItemCount(50233) >= 1 then
					npcHandler:say("Excelente! Voce trouxe o artefato correto! Muito bem, segure-o enquanto voce toma isso. Vou recitar o encantamento... \z
					~ Encantamento confuso ~... Pronto! Sentiu alguma coisa? Bom... de qualquer forma, voce vera os efeitos! Agora seu familiar ficara ainda mais forte!", npc, creature)
					player:addExperience(10000000, true)
					player:addFamiliar(vocation.id)
					player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 16)
					player:say('Gulp!', TALKTYPE_MONSTER_SAY)
					player:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Voce nao possui o artefato correto. Monks devem obter o artefato Moonhunter Figurine. Volte quando o possuir.", npc, creature)
                	npcHandler:setTopic(playerId, 0)
				end
			end
		elseif npcHandler:getTopic(playerId) == 11 then
			if player:getFreeCapacity() >= 100 and player:getFreeBackpackSlots() > 1 then
				if player:removeItem(44752, 1) then
					npcHandler:say("Ah! Sangue Cristalizado... um dos ingredientes mais poderosos de pocoes e alguns rituais. Voce deve ter se esforcado muito por ele. \z
					Aqui, como combinado, uma recompensa. Dessa vez estou te entregando algo mais concreto. Espero que ajude.", npc, creature)
					local container = player:addItem(2854, 1)
					if container then
						container:addItem(3043, 50)
						container:addItem(4061, 1)
						container:addItem(4061, 1)
						container:addItem(4061, 1)
						container:addItem(26186, 1)
						container:addItem(26186, 1)
					end
					player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 18)
					npcHandler:setTopic(playerId, 0)
				else

				end
			else
				npcHandler:say("Voce parece nao ter espaco na mochila ou cap suficiente para a recompensa. Resolva esse problema primeiro...", npc, creature)
                npcHandler:setTopic(playerId, 0)
			end
        end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola. O que faz aqui?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
npcType:register(npcConfig)









-- local function creatureSayCallback(npc, creature, type, message)
--     local player = Player(creature)
--     local playerId = player:getId()

--     if not npcHandler:checkInteraction(npc, creature) then
--         return false
--     end

-- 	local knight = player:getVocation():getBaseId() == VOCATION.BASE_ID.KNIGHT
-- 	local paladin = player:getVocation():getBaseId() == VOCATION.BASE_ID.PALADIN
-- 	local monk = player:getVocation():getBaseId() == VOCATION.BASE_ID.MONK
-- 	local druid = player:getVocation():getBaseId() == VOCATION.BASE_ID.DRUID
-- 	local sorcerer = player:getVocation():getBaseId() == VOCATION.BASE_ID.SORCERER

--     local storage = player:getStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso)
-- 	local outfit = player:getOutfit().lookType
-- 	local lookHead = player:getOutfit().lookHead
-- 	local lookBody = player:getOutfit().lookBody
-- 	local lookLegs = player:getOutfit().lookLegs
-- 	local lookFeet = player:getOutfit().lookFeet
-- 	local lookAddons = 3

--     if MsgContains(message, "mission") or MsgContains(message, "missao") then
-- 		if player:getLevel() < 200 then
-- 			npcHandler:say("Sinto muito, nobre guerreiro, mas voce nao possuir forca o suficiente para me ajudar. Volte apos o nivel 200. ", npc, creature)
--             npcHandler:setTopic(playerId, 0)
-- 		else
-- 			if storage < 1 then
-- 				npcHandler:say("Estou ha alguns meses vivendo nesse lugar enquanto estudo os cogumelos de Trivallis e suas propriedades em busca de efeitos especiais. \z
-- 				Quando Donahue descobriu essa ilha eu sabia que haveria algo para pesquisar e aprimorar meus conhecimentos e, bom, aqui estou! Enfim, vamos ao que interessa... \z
-- 				Para retirar os esporos de cogumelos e cultiva-los, talvez voce possa obter alguns deles para mim... O que acha? Pode me ajudar?", npc, creature)
--                 npcHandler:setTopic(playerId, 1)
-- 			elseif storage == 1 then
-- 				npcHandler:say("Voce trouxe os pinceis?", npc, creature)
--                 npcHandler:setTopic(playerId, 2)
-- 			elseif storage == 2 then
-- 				npcHandler:say("Estou cultivando novas especies de cogumelos e preciso de alguem para usar de cobaia. Gostaria de experimentar?", npc, creature)
--                 npcHandler:setTopic(playerId, 3)
-- 			elseif storage >= 3 and storage < 6 then
-- 				npcHandler:say("Precisamos do Elixir. Obtenha o item com Percybald, na Antiga Arena de Trivallis.", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
-- 			elseif storage == 6 then
-- 				npcHandler:say("E entao, conseguiu o Elixir?", npc, creature)
--                 npcHandler:setTopic(playerId, 4)
-- 			elseif storage == 7 then
-- 				npcHandler:say("Voce por acaso tem medo de fogo? Ha ha ha ha! Existe um estabilizante de reacoes muito potente em Trivallis: A massa vulcanica (volcanic mass). \z
-- 				O unico problema sera conseguir essa massa. Ha apenas uma pequena area com atividade vulcanica na ilha e o local esta cercado por criaturas de fogo e Nightmares. \z
-- 				Se conseguir passar por eles e encontrar o ponto com lava, basta pegar um pouco de massa de um dos geysers desativados ao lado. Entendeu tudo? Esta pronto?", npc, creature)
--                 npcHandler:setTopic(playerId, 5)
-- 			elseif storage == 8 then
-- 				npcHandler:say("Va e colete a massa vulcanica na montanha no centro da ilha!", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
-- 			elseif storage == 9 then
-- 				npcHandler:say("Espero que nao tenha passado por muito sufoco na montanha. Voce trouxe a massa vulcanica?", npc, creature)
--                 npcHandler:setTopic(playerId, 6)
-- 			elseif storage == 10 then
-- 				if player:getStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Timer) > os.time() then
-- 					npcHandler:say("Espere, jovem. Ainda estou estudando.", npc, creature)
--                 	npcHandler:setTopic(playerId, 0)
-- 				else
-- 					if summoner then
-- 						npcHandler:say("Certo, eu descobri! Tenho uma noticia boa e uma ruim. A noticia boa: Eu descobri o que falta para que a mistura fique perfeita! Porem... \z
-- 						A noticia ruim: nao funcionara em voce. Alias... nao diretamente. Mas tenho quase certeza que essa mistura deixara seus summons um pouco mais fortes! \z
-- 						Se voce quiser buscar pelo ultimo ingrediente, usarei uma amostra em voce. Voce topa?", npc, creature)
-- 						npcHandler:setTopic(playerId, 7)		
-- 					else
-- 						npcHandler:say("Certo, eu descobri! Tenho uma noticia boa e uma ruim. A noticia boa: Eu descobri o que falta para que a mistura fique perfeita! Porem... \z
-- 						A noticia ruim: nao funcionara em voce. Alias... nao diretamente. Mas tenho quase certeza que essa mistura dara ao seu familiar novos poderes permanentemente! \z
-- 						Se voce quiser buscar pelo ultimo ingrediente, usarei uma amostra em voce. Voce topa?", npc, creature)
-- 						npcHandler:setTopic(playerId, 7)
-- 					end
-- 				end
-- 			elseif storage == 11 then
-- 				npcHandler:say("Finalmente! Voce trouxe o ovo de inseto?", npc, creature)
--                 npcHandler:setTopic(playerId, 8)
-- 			elseif storage == 12 then
-- 				npcHandler:say("Li num de meus livros que precisamos de um tipo de artefato para canalizar os poderes das invocacoes pelo seu corpo junto a nossa mistura. Ja preparei o encantamento. \z
-- 				Agora so precisamos do artefato. Algo me diz que os piratas a leste da ilha podem possuir o item em seus tesouros, mas voce tera que enfrenta-los para isso... voce consegue?", npc, creature)
-- 				npcHandler:setTopic(playerId, 9)
-- 			elseif storage == 13 or storage == 14 then
-- 				npcHandler:say("Encontre Dorian, entre os piratas ao leste, e fale com ele sobre o {monstro} do qual eu te falei.", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			elseif storage == 15 then
-- 				npcHandler:say("Voce trouxe o artefato?", npc, creature)
-- 				npcHandler:setTopic(playerId, 10)
-- 			end
-- 		end
--     elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
--         if npcHandler:getTopic(playerId) == 1 then
--             npcHandler:say("Isso! E a pesquisa continuaaaa! Ha ha ha. Digo.. obrigado por isso. Veja bem, os pinceis que voce busca podem ser obtidos logo aqui ao lado. \z
-- 			Nas muralhas dessa parte da ilha se esconde um bando de acumuladores de riquezas. Como amantes das artes, varios deles possuem esses pinceis. Nao esta facil? \z
-- 			So ha um problema: Os pinceis tem pouca durabilidade, entao preciso de muitos. Traga-me ao menos uns... 25 pinceis! Isso! 25 pinceis e te darei uma recompensa.", npc, creature)
--             player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 1)
--             npcHandler:setTopic(playerId, 0)
-- 		elseif npcHandler:getTopic(playerId) == 2 then
-- 			if player:getItemCount(25689) >= 25 then
-- 				player:removeItem(25689, 25)
-- 				npcHandler:say("... 23... 24... 25! Muito bom! Agoa posso cultivar essa especie em diferentes substratos facilmente! Em breve vou testar quais sao suas propriedades \z
-- 				Aqui, sua recompensa. Ei! Espere! Voce poderia ser uma de minhas cobaias! Nao... isso pode ser perigoso. Ou talvez seja um desafio para uma proxima {missao}...", npc, creature)
--             	player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 2)
-- 				player:addItem(3043, 10)
-- 				npcHandler:setTopic(playerId, 0)
-- 			else
-- 				npcHandler:say("Acho que voce errou na conta...", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
-- 			end
-- 		elseif npcHandler:getTopic(playerId) == 3 then
-- 			npcHandler:say("Muito bem, aqui esta. Minha nossa! Fascinante! Voce mudou totalmente de forma, mas parece que nao dura muito tempo. Preciso testar algumas combinacoes. \z
-- 			Ja sei! Talvez a gente consiga algo com os gladiaroes que vivem numa arena abandonada na regiao leste de Trivallis. Eles possuem um elixir que os torna mais fortes. \z
-- 			Talvez Percybald, o 'chefe' do lugar, possa te ajudar a conseguir. Mas cuidado, os gladiadores da Arena nao sao tao amigaveis quanto ele... Va e tente conseguir o elixir.", npc, creature)
-- 			player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 3)
-- 			local condition = Condition(CONDITION_OUTFIT)
-- 			condition:setOutfit({lookType = 677})
-- 			condition:setTicks(5000)
-- 			player:addCondition(condition)
-- 			player:say('Gulp!', TALKTYPE_MONSTER_SAY)
--             npcHandler:setTopic(playerId, 0)
-- 		elseif npcHandler:getTopic(playerId) == 4 then
-- 			if player:getItemCount(21554) >= 1 then
-- 				player:removeItem(21554, 1)
-- 				npcHandler:say("Bom... realmente muito bom. Eu nunca consegui entender como esse elixir pode ser produzido naquelas condicoes... Enfim. Farei um teste com uma mistura. \z
-- 				Cogumelos e elixir. Tome! Um, dois, tres e... nada? Hum... o elixir anulou o efeito do cogumelo, no lugar de potencializar. Deve estar faltando alguma coisa. Forma, forca...\z
-- 				Ja sei!! Ha um terceiro ingrediente que pode ser a chave e acredito que nao seja um grande desafio para voce. Me diga quando estiver pronto para a proxima {missao}.", npc, creature)
--             	player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 7)
-- 				player:addExperience(1000000)
-- 				player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 				npcHandler:setTopic(playerId, 0)
-- 			else
-- 				npcHandler:say("Nao vejo elixir nenhum.", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
-- 			end
-- 		elseif npcHandler:getTopic(playerId) == 5 then
-- 			npcHandler:say("Muito bem, entao va! Tenha cuidado no caminho, ficarei aqui a sua espera.", npc, creature)
-- 			player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 8)
--             npcHandler:setTopic(playerId, 0)
-- 		elseif npcHandler:getTopic(playerId) == 6 then
-- 			local vida = player:getHealth() / 2
-- 			if player:getItemCount(9147) >= 1 then
-- 				player:removeItem(9147, 1)
-- 				npcHandler:say("Otimo! Misturando tudo... Ok. Agora veremos. Coma tudo! E... MINHA NOSSA!! Certo. Certo, os efeitos ainda foram rapidos. Esta tudo bem. \z
-- 				Pelo que posso ver voce ganhou nova forma e mais forca, mas perdeu vida. Preciso ler meus livros e pensar em uma solucao. \z
-- 				Facamos assim, retorne daqui 10 minutos e direi qual sera o proximo passo!", npc, creature)
-- 				local condition = Condition(CONDITION_OUTFIT)
-- 				condition:setOutfit({lookType = 676})
-- 				condition:setTicks(5000)
-- 				player:addCondition(condition)
-- 				player:setHealth(vida)
-- 				player:say('Gulp!', TALKTYPE_MONSTER_SAY)
-- 				player:addExperience(1000000)
-- 				player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 10)
-- 				player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Timer, os.time() + 60 * 10)
-- 			else
-- 				npcHandler:say("Preciso da massa vulcanica para estabilizar a reacao do cogumelo com o elixir.", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
-- 			end
-- 		elseif npcHandler:getTopic(playerId) == 7 then
-- 			npcHandler:say("Mesmo? Digo.. que otimo! Eu sempre precisei de uma cobaia tao disposta quanto voce! He he he he... Vamos la! Sua ultima missao: Obter 1 Mutant Insect Egg. \z
-- 			Esses ovos de insetos podem ser obtidos do monstro Spidris Elite, localizado na regiao sul de Trivallis. Eles sao raros, mas com esforco voce encontrara um.\z
-- 			Ha apenas um problema: Ovos retirados dos isnetos tem baixa durabilidade e se desintegram em cerca de 15 minutos. Entao esse sera o tempo que voce tera para traze-lo ate mim apos obte-lo. Agora va!", npc, creature)
--             player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 11)
-- 			npcHandler:setTopic(playerId, 0)
-- 		elseif npcHandler:getTopic(playerId) == 8 then
-- 			if player:getItemCount(9156) >= 1 then
-- 				player:removeItem(9156, 1)
-- 				player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 12)
-- 				npcHandler:say("Voce conseguiu!! Muito bom! Infelizmente, temos um ultimo processo para conseguir realizar o processo para fortalecer suas invocacoes... \z
-- 				Li num de meus livros que precisamos de um tipo de artefato para canalizar os poderes das invocacoes pelo seu corpo junto a nossa mistura. Ja preparei o encantamento. \z
-- 				Agora so precisamos do artefato. Algo me diz que os piratas a leste da ilha podem possuir o item em seus tesouros, mas voce tera que enfrenta-los para isso... voce consegue?", npc, creature)
-- 				npcHandler:setTopic(playerId, 9)
-- 			else
-- 				npcHandler:say("Nao estou vendo nenhum ovo. Talvez ele tenha de desintegrado no caminho ate aqui.", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
-- 			end
-- 		elseif npcHandler:getTopic(playerId) == 9 then
-- 			npcHandler:say("Sua disposicao me deixa ainda mais animado! Muito bem. Mas escute... eu soube que os piratas de aliaram a um terrivel monstro do mar que agra eles controlam. \z
-- 			Provavelmente os tesouros mais preciosos deles estao sendo guardados por esse monstro. Talvez voce tenha que derrota-lo. Procure por Dorian no local e ele pode te ajudar a encontra-lo. \z
-- 			Talvez ele queira algo em troca... Fale com ele sobre o {monstro} e veja se ele pode ajudar. Boa sorte! Nao retorne sem o artefato.", npc, creature)
--             player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 13)
-- 			npcHandler:setTopic(playerId, 0)
-- 		elseif npcHandler:getTopic(playerId) == 10 then
-- 			if knight or guardian then
-- 				if player:getItemCount(35589) >= 1 then
-- 					npcHandler:say("Excelente! Voce trouxe o artefato correto! Muito bem, segure-o enquanto voce toma isso. Vou recitar o encantamento... \z
-- 					~ Encantamento confuso ~... Pronto! Sentiu alguma coisa? Bom... de qualquer forma, voce vera os efeitos! Agora seu familiar ficara ainda mais forte!", npc, creature)
-- 					player:addExperience(10000000, true)
-- 					player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 16)
-- 					player:say('Gulp!', TALKTYPE_MONSTER_SAY)
-- 					player:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
-- 					npcHandler:setTopic(playerId, 0)
-- 				else
-- 					npcHandler:say("Voce nao possui o artefato correto. Knights e Guardians devem obter o artefato Snowbash Figurine. Volte quando o possuir.", npc, creature)
--                 	npcHandler:setTopic(playerId, 0)
-- 				end
-- 			elseif paladin then
-- 				if player:getItemCount(35590) >= 1 then
-- 					npcHandler:say("Excelente! Voce trouxe o artefato correto! Muito bem, segure-o enquanto voce toma isso. Vou recitar o encantamento... \z
-- 					~ Encantamento confuso ~... Pronto! Sentiu alguma coisa? Bom... de qualquer forma, voce vera os efeitos! Agora seu familiar ficara ainda mais forte!", npc, creature)
-- 					player:addExperience(10000000, true)
-- 					player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 16)
-- 					player:say('Gulp!', TALKTYPE_MONSTER_SAY)
-- 					player:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
-- 					npcHandler:setTopic(playerId, 0)
-- 				else
-- 					npcHandler:say("Voce nao possui o artefato correto. Paladins devem obter o artefato Sandscourge Figurine. Volte quando o possuir.", npc, creature)
--                 	npcHandler:setTopic(playerId, 0)
-- 				end
-- 			elseif sorcerer or summoner then
-- 				if player:getItemCount(35592) >= 1 then
-- 					npcHandler:say("Excelente! Voce trouxe o artefato correto! Muito bem, segure-o enquanto voce toma isso. Vou recitar o encantamento... \z
-- 					~ Encantamento confuso ~... Pronto! Sentiu alguma coisa? Bom... de qualquer forma, voce vera os efeitos! Agora seu familiar ficara ainda mais forte!", npc, creature)
-- 					player:addExperience(10000000, true)
-- 					player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 16)
-- 					player:say('Gulp!', TALKTYPE_MONSTER_SAY)
-- 					player:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
-- 					npcHandler:setTopic(playerId, 0)
-- 				else
-- 					npcHandler:say("Voce nao possui o artefato correto. Sorcerer e Summoners devem obter o artefato Bladespark Figurine. Volte quando o possuir.", npc, creature)
--                 	npcHandler:setTopic(playerId, 0)
-- 				end
-- 			else
-- 				if player:getItemCount(35591) >= 1 then
-- 					npcHandler:say("Excelente! Voce trouxe o artefato correto! Muito bem, segure-o enquanto voce toma isso. Vou recitar o encantamento... \z
-- 					~ Encantamento confuso ~... Pronto! Sentiu alguma coisa? Bom... de qualquer forma, voce vera os efeitos! Agora seu familiar ficara ainda mais forte!", npc, creature)
-- 					player:addExperience(10000000, true)
-- 					player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 16)
-- 					player:say('Gulp!', TALKTYPE_MONSTER_SAY)
-- 					player:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
-- 					npcHandler:setTopic(playerId, 0)
-- 				else
-- 					npcHandler:say("Voce nao possui o artefato correto. Druids devem obter o artefato Mossmasher Figurine. Volte quando o possuir.", npc, creature)
--                 	npcHandler:setTopic(playerId, 0)
-- 				end
-- 			end
--         end
--     end
-- end


-- npcHandler:setMessage(MESSAGE_GREET, "Ola. O que faz aqui?")
-- npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
-- npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

-- npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType:addDialogOptions("missao", "bye")
-- npcType:register(npcConfig)