local internalNpcName = "Dragon Ancestor Spirit"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
-- npcConfig.walkInterval = 2000 -- TODO
-- npcConfig.walkRadius = 2 -- TODO

npcConfig.outfit = {
	lookType = 1883,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.speechBubble = 1

npcConfig.light = {
	level = 0,
	color = 0,
}

-- TODO: Confirmar se tem voices e quais são os textos
npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Zzzzz." }, -- TODO: Confirmar texto (placeholder)
	{ text = "Farewell, friend." }, -- TODO: Confirmar texto
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

local weapons = {
	{ id = 52336, name = "crypt bile" },
	{ id = 52334, name = "crypt breaker" },
	{ id = 52337, name = "crypt jaw" },
	{ id = 52338, name = "crypt slicer" },
	{ id = 52332, name = "crypt spine" },
	{ id = 52333, name = "crypt splitter" },
	{ id = 52335, name = "crypt strike" },
}

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()

	local storage = player:getStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Progresso)
	local level = player:getLevel()

    if MsgContains(message, "missao") or MsgContains(message, "mission") then
		if storage == 1 then
			npcHandler:say("Hmmm... seria voce o enviado de S'Zallar? Nao parece assim tao forte... espero que possamos confiar mesmo em voce. \z
			Como S'Zallar ja havia te informado, o terrivel Bone Overlord esta ameacando todas as regioes do Novo Continente e precisamos para-lo o quanto antes. \z
			Para conseguir derrota-lo devemos enfraquecer seu espirito derrotando os lideres de seus subordinados. Voce tem certeza que deseja se arriscar nessa missao?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif storage == 2 then
			npcHandler:say("O que esta esperando? Derrote o Grupo de Aventureiros que se esconde na passagem secreta pela cabana dos aventureiros. \z
			Drako sabera como acessar o local, basta ajuda-lo em uma missao.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 3 then
			npcHandler:say("Voce derrotou o Grupo de Aventureiros com seu Fatal Bug. Isso ja enfraquecera um pouco o Bone Overlord, mas nao sera o suficiente. \z
			Seu proximo desafio sera derrotar um dragao poderoso que se esconde nas profundezas da Pits of Inferno. Este dragao ficou conhecido como o Eldritch Dragon Lord. \z
			Ele comanda os dragoes a mando do Bone Overlord e precisa ser derrotado. Encontre o portal que leva ao seu dominio e acabe com ele. \z
			Apos derrota-lo, como no boss anterior, entre no teleport verde de seus aposentos e use a Jade Dragon Head no totem do boss.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Progresso, 4)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 4 then
			npcHandler:say("Derrote o Eldritch Dragon Lord. Seus dominios estao escondidos em algum lugar da Pits of Inferno.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 5 then
			npcHandler:say("Parece que voce realmente pode ser a pessoa que nos salvara do terrivel Bone Overlord. Mas voce esta apenas na metade do caminho para enfrenta-lo...\z
			Agora preciso que voce derrote o lider das tropas das geleiras, o terrivel Ice Horror. Ele se esconde em algum lugar das geleiras proximas a Icehold. \z
			Encontre-o, derrote-o e use a Jade Dragon Head em seu totem, passando pelo teleport verde da sala. Aguardarei pelo seu retorno, mortal.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Progresso, 6)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 6 then
			npcHandler:say("Derrote o Ice Horror. Ele esta escondido em algum lugar das geleiras proximas a Icehold.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 7 then
			npcHandler:say("Por um momento eu pensei que voce pudesse ter virado uma estatua de gelo nas maos do Ice Horror, mas vejo que saiu vitorioso afinal. \z
			Agora voce tera seu ultimo desafio antes de enfrentar o Bone Overlord. Voce deve buscar pelo boss The Gravedigger no deserto de Valkesh. Ele sera o ultimo elo de poder. \z
			Encontre seu esconderijo, derrote-o e acesse o teleport verde em seus aposentos. Use a Jade Dragon Head no totem e retorne ate mim.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Progresso, 8)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 8 then
			npcHandler:say("Derrote The Gravedigger. Ele esta escondido em algum lugar no deserto de Valkesh.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 9 then
			npcHandler:say("Muito bem, humano. Voce conseguiu derrotar os quatro guardioes do grande Bone Overlord. Agora podera acessar seus dominios e enfrenta-lo! \z
			Entre no teleport da Forgotten Crypt e de o seu melhor. Espero que retorne com boas noticias sobre sua missao.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Progresso, 10)
			player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Unhallowed, 0)
			player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Forsaken, 0)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 10 then
			npcHandler:say("Acesse a Forgotten Crypt e derrota o Bone Overlord!", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 11 then
			npcHandler:say("Voce foi muito util para manter o equilibrio neste continente, mas seu trabalho nao acabou. Colete Fetid Hearts e Cryptic Fossils e use cada um para obter um acesso as criptas. \z
			Alem disso, se quiser posso aprimorar sua {jade dragon head} em um artefato que, ao ser usado, te garantira uma carga para entrar em cada uma das criptas a cada 14 dias. Basta me dizer. \z
			Aqui, uma singela recompensa. Se conseguir 5 runas diferentes traga ate mim e ofereca uma {troca} e te darei uma arma especial.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Progresso, 12)
			local chance = math.random(1, 5)
			if chance == 1 then
				player:addItem(52657, 1)
			elseif chance == 2 then
				player:addItem(52658, 1)
			elseif chance == 3 then
				player:addItem(52659, 1)
			elseif chance == 4 then
				player:addItem(52660, 1)
			elseif chance == 5 then
				player:addItem(52661, 1)
			end
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "jade") or MsgContains(message, "dragon") or MsgContains(message, "head") then
		if storage == 12 then
			if player:getItemCount(51976) >= 1 then
				player:removeItem(51976, 1)
				player:addItem(52874, 1)
				npcHandler:say("Aqui esta. Use esse item a cada 14 dias para receber uma permissao para acessar cada uma das criptas. Ele nao mudara seu aspecto, mas te avisara quanto tempo falta.", npc, creature)
				npcHandler:setTopic(playerId, 0)
				player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Progresso, 13)
			elseif storage == 13 then
				npcHandler:say("Eu ja aprimorei sua Jade Dragon Head.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	elseif MsgContains(message, "trade") or MsgContains(message, "troca") then
		if storage >= 12 then
			if player:getItemCount(52657) >= 1 and player:getItemCount(52658) >= 1 and player:getItemCount(52659) >= 1 and player:getItemCount(52660) >= 1 and player:getItemCount(52661) >= 1 then
				local randId = math.random(1, #weapons)
				local rewardItem = weapons[randId]
				player:removeItem(52657, 1)
				player:removeItem(52658, 1)
				player:removeItem(52659, 1)
				player:removeItem(52660, 1)
				player:removeItem(52661, 1)
				player:addItem(rewardItem.id, 1)
				npcHandler:say("Muito bem, aqui esta sua arma especial. Faca bom proveito!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce precisa de pelo menos uma unidade de cada uma das runas da cripta para trocar por uma nova arma.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
		if npcHandler:getTopic(playerId) == 1 then
			player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Progresso, 2)
			npcHandler:say("Espero que seja realmente forte e nao apenas um tolo confiante, mortal. Bom, para derrotar os subordinados do Bone Overlord iremos por partes. \z
			Comecando por um Grupo de Aventureiros que se esconde aqui mesmo, em Dracantus. O acesso a eles esta guardado pelos Adventurers, mas ha um humano chamado Drako que sabe como entrar. \z
			O tal Drako pode ser encontrado na superficie da ilha. Apos ajuda-lo com uma missao ele te dira como acessar a passagem que leva ate o local. \z
			Ao derrotar o grupo, entre no teleport verde da sala e use a caveira de jade dada a voce por S'Zallar no totem do boss, no chao da sala seguinte. Assim saberei que ele foi derrotado.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	end
end

npcHandler:setMessage(MESSAGE_GREET, "Mortal... voce esta a frente do Espirito Anciao. Fale!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Os ventos do tempo te levam embora, por enquanto...") 
npcHandler:setMessage(MESSAGE_WALKAWAY, "Corra, mortal! Talvez voce ainda nao esteja pronto.") 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
