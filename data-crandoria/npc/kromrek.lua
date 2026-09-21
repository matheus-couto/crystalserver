local internalNpcName = "Kromrek"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 131,
	lookHead = 104,
	lookBody = 104,
	lookLegs = 104,
	lookFeet = 104,
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

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

	local summoner = player:getVocation():getBaseId() == VOCATION.BASE_ID.ANCIENT_SUMMONER

    local storage = player:getStorageValue(Storage.Quest.Crandoria.QuestKromrek.Progresso)

    if MsgContains(message, "mission") or MsgContains(message, "missao") or MsgContains(message, "caminho") then
		if storage < 1 then
			npcHandler:say("Percybald e seus malditos gladiadores me colocaram nesse lugar. Eles nao entendem como as coisas funcionam no mundo de hoje... \z
			Tudo o que eu fiz foi realizar algumas {experiencias} para tornar os gladiadores ainda mais fortes. E FUNCIONOU! Mas eles nao entendem, acham que sou louco. \z
			Alguns morreram durante os testes? Sim... Mas os que sobreviveram estao vivos e fortes. Mas eles nao quiseram saber. Agora estou aqui, preso.", npc, creature)
            npcHandler:setTopic(playerId, 0)
		elseif storage == 1 then
			npcHandler:say("Esta com os ingredientes do meu banquete?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		elseif storage == 2 then
			npcHandler:say("Escute, na verdade, eu esqueci de uma coisa... Voce precisa de uma permissao assinada para acessar o local pela primeira vez. Mas calma! \z
			Eu consigo uma pra voce. So preciso que voce pegue um de meus formularios e 1 Golden Brush para que eu utilize na assinatura. Sera algo rapido! \z
			Meus formularios estao em algum lugar na minha antiga cabana. Ela fica na floresta, num ponto distante a nordeste daqui. Entre nela, procure pelo formulario e traga-o junto ao golden brush.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.QuestKromrek.Progresso, 3)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 3 then
			npcHandler:say("Voce encontrara os formularios na minha cabana, na regiao nordeste dessas montanhas. Traga-os junto a 1 golden brush.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 4 then
			npcHandler:say("Voce trouxe os formularios e o golden brush?", npc, creature)
			npcHandler:setTopic(playerId, 3)
		elseif storage == 5 then
			npcHandler:say("Ha um grande buraco na area externa proxima a Arena que foi o resultado de uma tentativa mal sucedida de extrair minerais desse lugar. \z
			Basta bater com uma picareta de cristal e levar o formulario e voce recebera permissao para acessar o esconderijo. Mas preste atencao! \z
			Os meus guerreiros sao extremamente fortes. Nao venha reclamar caso nao saia de la com as proprias pernas...", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.QuestKromrek.Progresso, 6)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "experiencia") then
		npcHandler:say("Tudo o que eu fiz foi aumentar a dose do elixir dos gladiadores com o objetivo de testar seus limites de forca. Alguns pegaram fogo instantaneamente... \z
		Mas os demais estao extremamente fortes. Nao acredita em mim? Ok! Facamos um trato: Voce me traz o que comer e eu te digo como acessar seu esconderijo na ilha. O que acha? Esta dentro?", npc, creature)
		npcHandler:setTopic(playerId, 1)
    elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Temos um acordo! Mas nao quero carne ou frutas. Quero um banquete! Ha muito tempo nao como algo decente. Vejamos... \z
			Traga 2 Dragonfruits, 10 Pineapples, 15 Fresh Fruits, 2 Small Bass e, claro, 1 Firewood para que eu possa acender um fogo aqui. \z
			Basta trazer tudo consigo e te contarei onde meus guerreiros mais fortes ficam escondidos!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.QuestKromrek.Progresso, 1)
            npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 2 then
			if player:getItemCount(11682) >= 2 and player:getItemCount(11459) >= 10 and player:getItemCount(11683) >= 15 and player:getItemCount(32044) >= 2 and player:getItemCount(32002) >= 1 then
				player:removeItem(11682, 2)
				player:removeItem(11459, 10)
				player:removeItem(25692, 15)
				player:removeItem(32044, 2)
				player:removeItem(36722, 1)
				player:addExperience(1000000, true)
				npcHandler:say("Minha nossa! Isso parece maravilhoso. Ha semanas tudo que eu como se resume a carne estragada e frutas podres. Nem acredito... \z
				Ok, voce parece ser uma boa pessoa e entenderia meu lado. Confiarei meu segredo a voce, assim podera ver com seus proprios olhos que o que fiz nao foi ruim. \z
				Me avise quando estiver pronto para saber o {caminho}.", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.QuestKromrek.Progresso, 2)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao trouxe tudo o que pedi...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 3 then
			if player:getItemCount(13429) >= 1 and player:getItemCount(25689) >= 1 then
				player:removeItem(13429, 1)
				player:removeItem(25689, 1)
				player:addItem(2864, 1)
				player:addItem(399, 1)
				npcHandler:say("Voce trouxe TODOS os meus pertences? Meu deus... Se acharem isso aqui eu estou morto. Vou esconder as coisas debaixo do meu colchao macio e... \z
				Pronto, aqui esta. Seu formulario assinado e essa bolsa vazia. Jogue isso em algum lugar, nao podem encontra-la aqui. Agora, de verdade, se quiser te contarei o {caminho}.", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.QuestKromrek.Progresso, 5)
				npcHandler:setTopic(playerId, 0)
			end
        end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "O que traz voce ao meu palacio?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais...")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus...")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
