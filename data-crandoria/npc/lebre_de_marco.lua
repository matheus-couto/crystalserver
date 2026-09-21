local internalNpcName = "Lebre de Marco"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 3000
npcConfig.walkRadius = 1

npcConfig.outfit = {
	lookType = 977
}

npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 60000,
	chance = 50,
	{text = 'Ei! Voce viu o Chapeleiro por ai?'}
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
		if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) <= 9 then
			npcHandler:say("Espera um pouco... voce nao falou com o Gato, falou? Saia daqui! Nao posso confiar em ninguem que nao tenha sido aprovado pelo Gato! \z
			Voce acha que sou bobo? Louco? MALUCO? Anda, anda! E nao me venha com essa historia de desaniversario! Apenas os mais confiaveis podem me ajudar a recuperar meu... digo, me ajudar na missao! Adeus!", npc, creature)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) >= 10 then
			if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Lebre) < 1 then
				npcHandler:say("Voce vai mesmo me ajudar? Que incrivel! E por coincidencia hoje estou comemorando o meu desaniversario. Ha ha ha ha! Mas, bom... acontece que meu melhor amigo, \z
				Crazy Hat, desapareceu ha alguns dias. Algumas pessoas dizem que sua alma foi tomada por forcas do mal. Outros dizem que ele foi amaldicoado pela {rainha}... digo... por alguem... \z
				Ele enlouqueceu e criou um portal para um mundo de trevas e caos. Voce poderia ir ate la e procurar por ele e derrota-lo para restaurar a paz por aqui?", npc, creature)
				npcHandler:setTopic(playerId, 1)
			elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Lebre) == 1 then
				npcHandler:say("Voce conseguiu derrotar Crazy Hat e seus demonios?", npc, creature)
				npcHandler:setTopic(playerId, 2)
			elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Lebre) >= 2 then
				npcHandler:say("Voce ja fez mais que o suficiente por mim. Mas voce pode acessar a terra do Crazy Hat para derrotar mais criaturas quando quiser, sera de grande ajuda!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	elseif MsgContains(message, "rainha") or MsgContains(message, "queen") then
		npcHandler:setTopic(playerId, 0)
		player:say('Nao conheco nenhuma Rainha, desculpe!', TALKTYPE_MONSTER_SAY, false, player, npc:getPosition())
		npc:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
		npc:remove()
	elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Sensacional! Tome cuidado, as criaturas desse lugar podem te deixar meio BIRUTA! HA HA HA HA. Eu sou prova disso. Se encontrar meu amigo, por favor \z
			Traga-o de volta para mim ou pelo menos me traga algo que me mostre que voce conseguiu derrota-lo!", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Lebre, 1)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 2 then
			if player:removeItem(396, 1) then
				npcHandler:say("Aaaaah! Que páéíú seria essa? Voce trouxe a BARBA dele? Nao poderia ter pegado, sei la, o chapeu? Meu deus... Depois dizem que EU sou louco! Entao ele foi derrotado, pelo menos por enquanto, certo? \z
				Entao tudo bem, pelo menos voce conseguiu completar a missao. Direi ao Gato que voce foi de grande ajuda. Muito obrigado!", npc, creature)
				npcHandler:setTopic(playerId, 0)
				player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Lebre, 2)
				player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress, player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) + 1)
			else
				npcHandler:say("Voce conseguiu derrotar Crazy Hat e seus demonios?", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end
end



npcHandler:setMessage(MESSAGE_GREET, "Um visitante? Otimo! Por favor, me ajude em uma {missao} importante!!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate depois!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
