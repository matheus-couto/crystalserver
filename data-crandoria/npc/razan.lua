local internalNpcName = "Razan"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 146,
	lookHead = 19,
	lookBody = 19,
	lookLegs = 9,
	lookFeet = 58,
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

local topic = {}

local config = {
	['ape fur'] = {
		itemId = 5883,
		count = 100,
		storageValue = 1,
		text = {
			'Voce realmente conseguiu cumprir a tarefa e trouxe-me 100 pecas de Ape Fur?',
			'Apenas as pecas de Ape Fur sao boas o suficiente para tocar os pes do nosso Caliph.',
			'Ahhh, essa suavidade! Estou impressionado, |PLAYERNAME|. Voce esta no melhor caminho para ganhar esse turbante. Agora, por favor, traga 100 {fish fins}.'
		}
	},
	['fish fins'] = {
		itemId = 5895,
		count = 100,
		storageValue = 2,
		text = {
			'Voce conseguiu descobrir a raca subaquatica e trazer 100 Fish Fins?',
			'Realmente me pergunto o que a sociedade dos exploradores esta planejando. Na verdade, nao tenho ideia de como conseguiram mergulhar.',
			'Nunca pensei que voce conseguiria, |PLAYERNAME|. Agora so precisamos de duas {enchanted chicken wings} para iniciar nosso teste de caminhar sobre a agua!'
		}
	},
	['enchanted chicken wings'] = {
		itemId = 5891,
		count = 2,
		storageValue = 3,
		text = {
			'Voce conseguiu obter duas Enchanted Chicken Wings?',
			'As Enchanted Chicken Wings sao na verdade usadas para fazer botas de pressa, entao elas poderiam ser extraidas magicamente novamente. Dizem que os Djinns sao bons nisso.',
			'Otimo, muito obrigado. Apenas traga-me 100 {blue piece of cloth} agora e ficarei feliz em mostrar como fazer um turbante.'
		}
	},
	['blue piece of cloth'] = {
		itemId = 5912,
		count = 100,
		storageValue = 4,
		text = {
			'Ah! Voce ja trouxe os 100 Blue Pieces of Cloth?',
			'Realmente um otimo material para turbantes.',
			'Oh! Parabens!! - Mesmo que voce nao seja um mestre das armas, voce com certeza merece esse turbante. Aqui, deixe-me ajustar para voce.'
		}
	}
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end


	if MsgContains(message, 'outfit') then
		if player:getStorageValue(Storage.Quest.U7_8.OutfitQuest.SecondOrientalAddon) < 1 then
			npcHandler:say(player:getSex() == PLAYERSEX_FEMALE and 'Meu turbante? Eu sei de uma coisa ainda melhor para uma garota como voce. Por que voce nao fala com Miraia?' or 'Meu turbante? Eh.. Nao. Voce nao pode possuir um assim. Apenas mestres orientais podem utiliza-lo apos cumprir uma dificil {tarefa}.', npc, creature)
		elseif player:getStorageValue(Storage.Quest.U7_8.OutfitQuest.SecondOrientalAddon) == 1 then
			npcHandler:say('Primeiramente, raga-me os 100 {ape fur}, por favor.', npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.U7_8.OutfitQuest.SecondOrientalAddon) == 2 then
			npcHandler:say('Agora preciso de 100 {fish fins}.', npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.U7_8.OutfitQuest.SecondOrientalAddon) == 3 then
			npcHandler:say('Traga-me 2 {enchanted chicken wings} por favor.', npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.U7_8.OutfitQuest.SecondOrientalAddon) == 4 then
			npcHandler:say('Por ultimo, traga-me 100 {blue piece of cloth} e farei um turbante para voce.', npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, 'task') or MsgContains(message, 'tarefa') then
		if player:getSex() == PLAYERSEX_FEMALE then
			npcHandler:say('Eu nao quero fazer uma garota ter que trabalhar pra mim. Se quer mesmo pum trabalho, procure por Miraia.', npc, creature)
			return true
		else
			if player:getStorageValue(Storage.Quest.U7_8.OutfitQuest.SecondOrientalAddon) < 1 then
				npcHandler:say('Quer dizer que voce quer provar que merece usar um turbante como este?', npc, creature)
				npcHandler:setTopic(playerId, 1)
			end
		end
	elseif config[message] and npcHandler:getTopic(playerId) == 0 then
		if player:getStorageValue(Storage.Quest.U7_8.OutfitQuest.SecondOrientalAddon) == config[message].storageValue then
			npcHandler:say(config[message].text[1], npc, creature)
			npcHandler:setTopic(playerId, 3)
			topic[playerId] = message
		else
			npcHandler:say(config[message].text[2], npc, creature)
		end
	elseif MsgContains(message, 'yes') or MsgContains(message, 'sim') then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say({
				'Tudo bem, entao ouca os seguintes requisitos. Estamos atualmente em grande necessidade de Ape Fur, pois o Califa pediu um novo tapete para o banheiro. ...',
				'Portanto, por favor, traga-me 100 pecas de {ape fur}. Em segundo lugar, chegou aos nossos ouvidos que a sociedade dos exploradores descobriu uma nova raca subaquatica de homens-peixe. ...',
				'Dizem que suas nadadeiras permitem que os humanos caminhem sobre a agua! Por favor, traga-nos 100 dessas nadadeiras de peixe (fish fins). ...',
				'Em terceiro lugar, se o plano de caminhar sobre a agua falhar, precisamos de enchanted chicken wings para evitar que os testadores se afoguem. Por favor, traga-me duas. ...',
				'Por ultimo, mas nao menos importante, passe aqui com 100 Blue Pieces of Cloth e eu ficarei feliz em mostrar como fazer um turbante. ...',
				'Voce entendeu tudo o que eu lhe disse e esta disposto a lidar com essa tarefa?'
			}, npc, creature)
			npcHandler:setTopic(playerId, 2)
		elseif npcHandler:getTopic(playerId) == 2 then
			if player:getStorageValue(Storage.Quest.U7_8.OutfitQuest.DefaultStart) ~= 1 then
				player:setStorageValue(Storage.Quest.U7_8.OutfitQuest.DefaultStart, 1)
			end
			player:setStorageValue(Storage.Quest.U7_8.OutfitQuest.SecondOrientalAddon, 1)
			npcHandler:say('Excelente! Retorne quando tiver coletado os 100 {ape fur}.', npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 3 then
			local targetMessage = config[topic[playerId]]
			if not player:removeItem(targetMessage.itemId, targetMessage.count) then
				npcHandler:say('Essa foi uma mentira sem vergonha...', npc, creature)
				npcHandler:setTopic(playerId, 0)
				return true
			end

			player:setStorageValue(Storage.Quest.U7_8.OutfitQuest.SecondOrientalAddon, player:getStorageValue(Storage.Quest.U7_8.OutfitQuest.SecondOrientalAddon) + 1)
			if player:getStorageValue(Storage.Quest.U7_8.OutfitQuest.SecondOrientalAddon) == 5 then
				player:addOutfitAddon(146, 2)
				player:addOutfitAddon(150, 2)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			end
			npcHandler:say(targetMessage.text[3], npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, 'no') or MsgContains(message, 'nao') and npcHandler:getTopic(playerId) ~= 0 then
		npcHandler:say('Ah.. Que pena.', npc, creature)
		npcHandler:setTopic(playerId, 0)
	end

	return true
end

local function onReleaseFocus(npc, creature)
	local playerId = creature:getId()
	topic[playerId] = nil
end

npcHandler:setMessage(MESSAGE_GREET, 'Saudacoes |PLAYERNAME|. O que te traz aqui?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Adeus.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_REMOVE_INTERACTION, onReleaseFocus)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
