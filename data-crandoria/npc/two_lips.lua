local internalNpcName = "Two Lips"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1762,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
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

	local storage = player:getStorageValue(Storage.Quest.Crandoria.TheRiseOfPodzilla.Progresso)

	if MsgContains(message, "invasor") or MsgContains(message, "mission") or MsgContains(message, "missao") then
		if storage < 1 then
			npcHandler:say("Vutu conatu le calun. Boem Demon Roots terc mo iatu.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 1 then
			npcHandler:say("Ah... entao Captain Seahorse trouxe voce. Me desculpe por achar que era apenas mais um invasor, sao tempos dificeis. \z
			Um terrivel ser que se denomina como Doctor Marrow invadiu nossas terras e esta fazendo experimentos com os seres daqui. \z
			Como ultimo recurso, pedi ajuda a Crandoria, mas as criaturas da ilha nao gostaram muito da ideia... Voce acha que consegue nos ajudar?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif storage == 2 then
			npcHandler:say("Por favor, mate todas as raizes malignas que crescem no entorno da flor no subsolo e depois mate (use) a flor.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 3 then
			npcHandler:say("A flor foi destruida e gerou um novo problema: Diversos mutantes raivosos de Doctor Marrow surgiram no subsolo e estao lutando contra os seres daqui. \z
			A maior parte deles foi confinada em uma sala no segundo piso do subsolo, onde haviam instalado um tipo de coracao das raizes. Preciso que va ate o local e contamine o coracao. \z
			Para isso voce devera usar um orvalho obtido de pequenos bulbos amarelos presentes no subsolo, como este ao meu lado. Basta usar os bulbos para obter o orvalho. \z
			Em seguida entre na sala e use os orvalhos no coracao. Voce pode precisar de alguns para ter sucesso, nao leve apenas um.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.TheRiseOfPodzilla.Progresso, 4)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 4 then
			npcHandler:say("Utilize o orvalho no chao da sala onde a batalha esta acontecendo para destruir o coracao gigante.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 5 then
			npcHandler:say("Eu soube de seu sucesso na missao, mas parece que isso apenas enfureceu Doctor Marrow e seus mutantes que habitam a ilha. \z
			Sabendo que ha alguem tentando derrota-lo, ele libertou um monstro terrivel chamado The Rootkraken para protege-lo. Alem disso, parece que um certo dispositivo foi ativado. \z
			Parece que o dispositivo praticamente torna esse monstro imortal, entao precisamos saber como desativa-lo. Va ate o ultimo nivel do subsolo e encontra o laboratorio. \z
			No local deve haver alguma informacao sobre o dispositivo e como desativa-lo. Tenha cuidado com os Quaras! Eles sao extremamente perigosos...", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.TheRiseOfPodzilla.Progresso, 6)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 6 then
			npcHandler:say("Encontre informacoes sobre como desativar o dispositivo de Doctor Marrow no ultimo piso do subsolo da ilha.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 7 then
			npcHandler:say("Um... gerador? Entao ele alimenta seus mutantes infinitamente com energia pura? Isso parece loucura! Como alguem pode fazer algo assim? \z
			Nao ha instrucoes sobre como desativa-lo, mas podemos tentar quebra-lo colocando gold coins entre as engrenagens. Acredito que sera nossa melhor chance. \z
			Faca isso antes mesmo de tentar derrotar essa criatura, acredito que o tal Rootkraken nao recebera dano enquanto for alimentado pelo gerador.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.TheRiseOfPodzilla.Progresso, 8)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 1 then
			player:setStorageValue(Storage.Quest.Crandoria.TheRiseOfPodzilla.Progresso, 2)
			npcHandler:say("Bom... bom... muito bom mesmo. Ouvi dizer que os guerreiros de Crandoria eram corajosos. Parece ser verdade mesmo... \z
			Mas antes de enfrenta-lo, devemos enfraquece-lo destruindo as raizes malignas que ele vem criando no centro do subsolo. Voce podera fazer isso com algumas Amber Sickles. \z
			Drope algumas unidades de Sickle das criaturas do subsolo e use-as para matar as raizes, acessiveis por uma alavanca no local. Mas atencao! \z
			As Amber Sickles duram pouco tempo e podem se partir no processo. Voce deve destruir todas as raizes da area antes que elas se regenerem, o que ocorre em poucos segundos. \z
			Quando todas as raizes estiverem mortas, mate (use) a flor no centro do local. Ah! So mais uma coisa:\z
			As raizes sao protegidas por criaturas que voce devera derrotar antes que possa atingi-las. Espero que voce tenha sucesso!", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	end
	return true
end

-- CALLBACK_GREET roda toda vez que o NPC cumprimenta um jogador (ao focar
-- nele), permitindo decidir dinamicamente qual mensagem mostrar — aqui, com
-- base na storage da quest — em vez da string fixa de setMessage(MESSAGE_GREET, ...).
local function onGreet(npc, creature)
	local player = Player(creature)
	local storage = player:getStorageValue(Storage.Quest.Crandoria.TheRiseOfPodzilla.Progresso)

	if storage < 1 then
		npcHandler:say("Taruc tuc malau ten Rootland?", npc, creature)
	else
		npcHandler:say("Mais um {invasor} em Rootland?", npc, creature)
	end
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus!")

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("bye")

npcType:register(npcConfig)



