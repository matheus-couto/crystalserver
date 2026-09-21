local internalNpcName = "Gato de Thaumasia"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookTypeEx = 21947
}

npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 60000,
	chance = 50,
	{text = 'Parece que voce se perdeu. Isso nao soa maravilhoso? Hahaha...'}
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

    if MsgContains(message, "missao") or MsgContains(message, "mission") then
		if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) <= 8 then
			npcHandler:say("Sim, eu sei que voce esta em uma missao. Aposto que veio parar aqui buscando por Jack, o {coelho}! Estou certo?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) == 9 then
			npcHandler:say("Sua missao agora sera chegar ate o castelo. Talvez o coelho que voce busca esteja la. Mas so mostrarei o caminho se voce aceitar ajudar todos os seres em apuros de Thaumasia. Voce aceita essa missao?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) >= 10 and player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) < 14 then
			npcHandler:setTopic(playerId, 0)
			player:say('Voce ainda nao ajudou todos os seres de Thaumatia ainda. Como espera que eu te ajude? Nao confunda bife a milanesa com bife ali na mesa. Va e continue sua missao!', TALKTYPE_MONSTER_SAY, false, player, Position(4509, 4707, 14))
			npc:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
			npc:remove()
		elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) == 14 then
			npcHandler:say("Eu bateria palmas, mas como voce deve saber, nenhum dos problemas foi totalmente resolvido. Voce tera que voltar outras vezes para continuar as batalhas... Apesar disso, te ensinarei como chegar ate o castelo: \z
			Seguindo a estrada a leste da ilha, voce vai encontrar um portal magico. Esse portal te levara diretamente ao castelo. Mas, para isso, antes precisarei te conceder minha permissao real. Aqui está! Agora va e continue sua missao. Talvez voce encontre o Coelho que tanto procura... \z ", npc, creature)
			player:say('ZUHMMM', TALKTYPE_MONSTER_SAY, false, player, player:getPosition())
			player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
			player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress, 15)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) > 14 then
			npcHandler:say("Voce podera ajudar os habitantes de Thaumasia com seus desafios diariamente. Basta acessar cada um dos locais especiais e enfrentar os terriveis monstros que dominam essas areas.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "castelo") or MsgContains(message, "castle") then
		if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) <= 8 then
			player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress, 9)
			npcHandler:say("Ha apenas um caminho que leva ao unico castelo de Thaumasia, mas apenas eu e Jack, o Coelho, sabemos passar por ele. Se quiser, posso te mostrar como passar, mas antes sua missao sera ajudar cada um dos habitantes daqui... Acha que voce consegue passar por esse desafio?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) == 9 then
			npcHandler:say("Eu te disse... Se quiser que eu te mostre o caminho, tera que ajudar todos daqui. Temos um trato?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) == 10 then
			npcHandler:setTopic(playerId, 0)
			player:say('Voce ainda nao ajudou todos os seres de Thaumatia ainda. Como espera que eu te ajude? Nao confunda bife a milanesa com bife ali na mesa. Va e continue sua missao!', TALKTYPE_MONSTER_SAY, false, player, Position(4509, 4707, 14))
			npc:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
			npc:remove()
		end
	elseif MsgContains(message, "rainha") or MsgContains(message, "queen") then
		npcHandler:setTopic(playerId, 0)
		player:say('Rainha? Que rainha? HA HA HA', TALKTYPE_MONSTER_SAY, false, player, Position(4509, 4707, 14))
		npc:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
		npc:remove()
	elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Jack, o coelho branco de {Thaumasia}. Sempre com pressa e sempre atrasado. Yang e yang... Algumas vezes aquilo que nos mostra o caminho nem sempre se torna parte do objetivo no final. Tenha cuidado...", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 2 then
			npcHandler:say("A protecao das pequenas criaturas, a busca por uma joia rara, o equilibrio das criaturas da natureza e a luta pela alma de um amigo sao os desafios que voce tera que enfrentar! Espero que sobreviva a tudo isso. Thaumasia conta com voce!", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress, 10)
			npcHandler:setTopic(playerId, 0)
		end
	end
end

keywordHandler:addKeyword({'coelho'}, StdModule.say, {npcHandler = npcHandler, text = 'Jack, o coelho branco de {Thaumasia}. Sempre com pressa e sempre atrasado. Yang e yang... Algumas vezes aquilo que nos mostra o caminho nem sempre se torna parte do objetivo no final. Tenha cuidado...'})
keywordHandler:addKeyword({'rabbit'}, StdModule.say, {npcHandler = npcHandler, text = 'Jack, o coelho branco de {Thaumasia}. Sempre com pressa e sempre atrasado. Yang e yang... Algumas vezes aquilo que nos mostra o caminho nem sempre se torna parte do objetivo no final. Tenha cuidado...'})
keywordHandler:addKeyword({'thaumasia'}, StdModule.say, {npcHandler = npcHandler, text = 'Thaumasia, terra dos insanos. Para os viajantes pacificos, um lugar calmo e tranquilo, para os exploradores, um lugar cheio de perigos. {Lagartas} falantes, {lebres} desorientadas e colecionadores de {ostras} sao alguns dos meios para se chegar aos maiores desafios que a terra de Thaumasia oferece.'})
keywordHandler:addKeyword({'lagarta'}, StdModule.say, {npcHandler = npcHandler, text = 'Insetos podem ser mais perigosos do que eles parecem. Aquele que nao tem forca de verdade nao pode viver tranquilo pois sabe que a qualquer momento pode ser esmagado. A evolucao pode ser a unica resposta nesse tipo de situacao. Ja ofereceu {ajuda} a uma lagarta a buscar sua evolucao? Isso pode fazer a diferenca na sua busca pelo {coelho}...'})
keywordHandler:addKeyword({'lagartas'}, StdModule.say, {npcHandler = npcHandler, text = 'Insetos podem ser mais perigosos do que eles parecem. Aquele que nao tem forca de verdade nao pode viver tranquilo pois sabe que a qualquer momento pode ser esmagado. A evolucao pode ser a unica resposta nesse tipo de situacao. Ja ofereceu {ajuda} a uma lagarta a buscar sua evolucao? Isso pode fazer a diferenca na sua busca pelo {coelho}...'})
keywordHandler:addKeyword({'ajuda'}, StdModule.say, {npcHandler = npcHandler, text = 'Ajudar aqueles que estao perdidos pode te levar a encontrar o seu proprio {caminho}...'})
keywordHandler:addKeyword({'ajudar'}, StdModule.say, {npcHandler = npcHandler, text = 'Ajudar aqueles que estao perdidos pode te levar a encontrar o seu proprio {caminho}...'})
keywordHandler:addKeyword({'lebre'}, StdModule.say, {npcHandler = npcHandler, text = 'O desespero e a falta de foco podem acabar com a mente e destuir o corpo. Perdido em pensamentos intrusivos, uma lebre passa por um dos momentos mais dificeis da sua vida quando lhe falta aquilo que mais importa a ele: um amigo. Ajudar a Lebre sera uma {missao importante} que voce precisara enfrentar para conseguir chegar ate Jack, o Coelho.'})
keywordHandler:addKeyword({'lebres'}, StdModule.say, {npcHandler = npcHandler, text = 'O desespero e a falta de foco podem acabar com a mente e destuir o corpo. Perdido em pensamentos intrusivos, uma lebre passa por um dos momentos mais dificeis da sua vida quando lhe falta aquilo que mais importa a ele: um amigo. Ajudar a Lebre sera uma {missao importante} que voce precisara enfrentar para conseguir chegar ate Jack, o Coelho.'})
keywordHandler:addKeyword({'ostra'}, StdModule.say, {npcHandler = npcHandler, text = 'Algumas pessoas podem acabar ficando loucas correndo atras de seus objetivos. Algumas pessoas buscam por ostras e caranguejos ate se perderem em alto mar, outras bsucam por coelhos brancos ate se perderem com lancas em suas costas...'})
keywordHandler:addKeyword({'ostras'}, StdModule.say, {npcHandler = npcHandler, text = 'Algumas pessoas podem acabar ficando loucas correndo atras de seus objetivos. Algumas pessoas buscam por ostras e caranguejos ate se perderem em alto mar, outras bsucam por coelhos brancos ate se perderem com lancas em suas costas...'})
keywordHandler:addKeyword({'missao importante'}, StdModule.say, {npcHandler = npcHandler, text = 'As vezes acreditamos que nossa missao pode ser uma coisa simples, como achar um coelho. Mas a missao mais importante na maioria das vezes esta um pouco mais a frente, em um jardim real, ou mesmo num {castelo} de uma perversa {rainha}...'})



npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. O que voce esta buscando? Qual a sua {missao} no momento?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais, |PLAYERNAME|. E tenha cuidado...")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Nao ande com os pes no chao!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
