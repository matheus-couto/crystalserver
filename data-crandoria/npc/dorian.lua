local internalNpcName = "Dorian"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 151,
	lookHead = 22,
	lookBody = 58,
	lookLegs = 77,
	lookFeet = 21,
	lookAddons = 2
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

	local storage = player:getStorageValue(Storage.Quest.Crandoria.PiratesQuest.Progresso)

	if MsgContains(message, "missao") or MsgContains(message, "mission") then
		if storage < 1 then
			npcHandler:say("Me chamo Dorian. Ja fiz parte de um dos piores bandos de piratas que o Novo Continente ja viu: o Bando do Dirtbeard. \z
			Mas isso ja faz tempo. Hoje sou o que chamariam de 'contrabandista', mas eu prefiro o termo 'mercador de risco'... he he he. \z
			No momento preciso recuperar um tesouro que ficou perdido em um pequeno barco. Talvez voce queira me ajudar em troca de uma singela {recompensa}...", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 1 then
			npcHandler:say("Va logo e busque o tesouro perdido! O que voce esta esperando?", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 2 then
			npcHandler:say("Voce trouxe meu tesouro?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		elseif storage == 5 then
			npcHandler:say("Eu soube que alguem derrotou aquele monstro terrivel. Entao foi voce? Ha ha ha! Eu sabia que voce conseguiria! \z
			Espero que ele nao se recupere tao cedo do seu ataque. Aqui, uma singela recompensa pela sua ajuda. Nao posso oferecer muito, mas espero que ajude.", npc, creature)
			
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "recompensa") then
		if storage < 1 then
			npcHandler:say("Sobre a recompensa? Bom... facamos o seguinte. Se voce conseguir recuperar o tesouro, te darei 5 Crystal Coins. Nao ser adificil. \z
			Voce pode usar o bote no fundo do navio abandonado no cais para chegar ate o barco onde o tesouro esta localizado. Mas derrotar os piratas no caminho sera com voce... Aceita o desafio?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
	elseif MsgContains(message, "monstro") then
		if player:getLevel() < 250 then
			npcHandler:say("Pensando bem, acho que voce nao esta assim tao forte. Retorne apos o nivel 250.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		else
			if player:getStorageValue(Storage.Quest.Crandoria.PiratesQuest.Progresso) < 3 then
				npcHandler:say("Nao sei se voce consegue derrotar o monstro que esta causando tanto problema por aqui. Talvez voce possa executar uma {missao} para mim antes... \z
				Voce sabe... para provar o seu valor.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			elseif player:getStorageValue(Storage.Quest.Crandoria.PiratesQuest.Progresso) == 3 then
				npcHandler:say("Entao voce quer saber sobre o monstro... Ele se chama Tentugly's Head. De acordo com os piratas ele ja causou medo nas antigas terras Tibianas. \z
				Agora os piratas se uniram so monstro e eles o usam para proteger seus tesouros preciosos e um certo artefato. Eu nao gosto da ideia de colaborar com monstros, nunca se sabe... \z
				Voce tera que nadar um pouco pela area de naufragio se quiser chegar ate ele. Use meu bote para chegar proximo da area. Boa sorte!", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.PiratesQuest.Progresso, 4)
				npcHandler:setTopic(playerId, 0)
			end
		end
	elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Muito bem. Va em frente! Sei que sera algo simples para voce.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.PiratesQuest.Progresso, 1)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 2 then
			if player:getItemCount(3032) >= 5 and player:getItemCount(3030) >= 5 and player:getItemCount(3029) >= 5 and player:getItemCount(3033) >= 5 and player:getItemCount(6099) >= 1 then
				player:removeItem(3032, 5)
				player:removeItem(3029, 5)
				player:removeItem(3030, 5)
				player:removeItem(3033, 5)
				player:removeItem(6099, 1)
				player:addItem(3043, 5)
				player:setStorageValue(Storage.Quest.Crandoria.PiratesQuest.Progresso, 3)
				npcHandler:say("Esmeralds... Rubis... Safiras... Ametistas e... O CHAPEU! Tudo aqui. Voce realmente parece forte, pensei por um momento que voce nao conseguiria. \z
				Aqui esta, como combinado. Sabe... Voce parece realmente forte. Talvez ate possa derrotar um certo {monstro}...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao esta com meu tesouro. Nao conseguira enganar um pirata, amigo...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_WALKAWAY, 'Ate mais, |PLAYERNAME|')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Ate mais, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_GREET, 'Anh? Ah! Ola...')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
npcType:register(npcConfig)
