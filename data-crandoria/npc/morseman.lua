local internalNpcName = "Morseman"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 3000
npcConfig.walkRadius = 1

npcConfig.outfit = {
	lookType = 940
}

npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 60000,
	chance = 50,
	{text = 'Eu ainda pego aquela maldita ostra!'}
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

    if MsgContains(message, "vinho") or MsgContains(message, "wine") then
		if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Morseman) < 2 then
			if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) <= 9 then
				npcHandler:say("Tentador, mas eu nao aceito bebidas de pessoas que eu nao conheco...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce tem vinho ai? Por que nao disse antes, nobre viajante? Por favor, sente-se. Voce deve ser o novo visitante de quem o Gato falou... \z
				Gostaria de compartilhar um pouco de vinho com um velho marinheiro?", npc, creature)
				npcHandler:setTopic(playerId, 1)
			end
		else
			npcHandler:say("Nao se preocupe com isso, forasteiro. Ainda estou embriagado da nossa ultima garrafa! Ha ha ha! Agora so preciso da minha joia... Como anda sua {missao}?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		end
	elseif MsgContains(message, "missao") or MsgContains(message, "mission") then
		if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Morseman) < 2 then
			if npcHandler:getTopic(playerId) == 2 then
				npcHandler:say("Ha!! Como o Gato disse... voce realmente vai fazer qualquer coisa para encontrar com aquele maldito coelho! Bom, vou te contar o meu problema: Eu sempre me aventurei no mar em busca de preciosidades \z
				submersas que dessem algum sentido a minha vida. Recentemente eu encontrei uma joia muito especial enterrada proxima a costa. Eu estava encantado com o brilho daquela joia... Mas na noite em que eu trouxe a joia para casa \z
				eu fui atacado por seres das profundezas que diziam estar buscando o tesouro que pertencia a sua condessa, uma OSTRA que vive no fundo do oceano. Eles roubaram minha joia e me deixaram sem nada... Voce poderia me ajudar a recupera-la?", npc, creature)
				npcHandler:setTopic(playerId, 3)
			end
		elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Morseman) == 2 then
			npcHandler:say("Voce conseguiu recuperar a minha joia?", npc, creature)
			npcHandler:setTopic(playerId, 4)
		end
	elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
		if npcHandler:getTopic(playerId) == 1 then
			if player:removeItem(27461, 1) then
				npcHandler:say("Que maravilha! Ha muito tempo eu nao tomava um vinho tao bom! Aproveitando esse momento unico, quero saber se voce gostaria de ouvir uma proposta para uma {missao}...", npc, creature)
				player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Morseman, 1)
				npcHandler:setTopic(playerId, 2)
			else
				npcHandler:say("Onde esta o vinho? Nao tente me enganar, forasteiro!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 4 then
			if player:removeItem(39135, 1) then
				npcHandler:say("Eu... Eu nao acredito. Voce conseguiu mesmo! Simplesmente... impressionante!!! Muito obrigado por isso! Direi ao gato que voce me ajudou. E, por favor, volte quando quiser para acabar com mais dessas malditas \z
				criaturas do oceano! Ha ha ha! Obrigado!", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Morseman, 3)
				player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress, player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) + 1)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("E onde esta a joia? Nao brinque comigo, nada importa mais que essa joia para mim!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 2 then
			npcHandler:say({"Ha!! Como o Gato disse... voce realmente vai fazer qualquer coisa para encontrar com aquele maldito coelho! Bom, vou te contar o meu problema: Eu sempre me aventurei no mar em busca de preciosidades ...",
			"submersas que dessem algum sentido a minha vida. Recentemente eu encontrei uma joia muito especial enterrada proxima a costa. Eu estava encantado com o brilho daquela joia... Mas na noite em que eu trouxe a joia para casa ...",
			"eu fui atacado por seres das profundezas que diziam estar buscando o tesouro que pertencia a sua condessa, uma OSTRA que vive no fundo do oceano. Eles roubaram minha joia e me deixaram sem nada... Voce poderia me ajudar a recupera-la?"}, npc, creature)
			npcHandler:setTopic(playerId, 3)
		elseif npcHandler:getTopic(playerId) == 3 then
			npcHandler:say("Enfrentar os mares nao parece nada para voce, nao e mesmo? HA! Melhor para mim. Na prquena praia la fora coce vai encontrar um vortex de agua proximo a superficie. Esse vortex te levara ate a area submersa onde vivem as terriveis \z
			criaturas do mar. Esperto que voce tenha mais sorte do que eu ao lidar com elas... Boa sorte! Estarei esperando pela minha joia.", npc, creature)
			player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Morseman, 2)
			npcHandler:setTopic(playerId, 0)
		end
	end
end

keywordHandler:addKeyword({'coelho', 'rabbit'}, StdModule.say, {npcHandler = npcHandler, text = ''})



npcHandler:setMessage(MESSAGE_GREET, "Ola. O que faz aqui?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
