local internalNpcName = "Percybald"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 131,
	lookHead = 0,
	lookBody = 94,
	lookLegs = 21,
	lookFeet = 38,
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

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()
	local storage = player:getStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso)

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "missao") or MsgContains(message, "mission") or MsgContains(message, "elixir") then
		if storage == 3 then
			npcHandler:say("Entao voce quer um frasco do nosso elixir? Bom, eu talvez tenha um sobrando, mas como voce sabe tudo tem um preco... Talvez voce esteja disposto a pagar. \z
			Na verdade nao sera um preco em dinheiro, mas em batalha. Nas profundezas da Arena reside um maldito monstro chamado de Chizzoron the Distorter. Maldito lagarto! \z
			Ele esta cercado por alguns repteis malditos e vez ou outra decide nos perturbar na superficie. Se voce conseguir derrota-lo numa batalha, te darei seu elixir. O que acha? Aceita o desafio?", npc, creature)
            npcHandler:setTopic(playerId, 1)
		elseif storage == 4 then
			npcHandler:say("Voce deve derrotar Chizzoron com as proprias maos. Nao retorne sem derrota-lo.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 5 then
			npcHandler:say("Incrivel! Voce conseguiu mesmo. Mas um de meus gladiadores me disse que ele ainda retornara... Bom, pelo menos agora sabera o que o espera do lado de fora. \z
			Aqui, como prometido, um frasco do nosso elixir. Boa sorte em sua jornada!", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 6)
			player:addItem(21554, 1)
			player:addExperience(1000000, true)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Bom, veremos se voce tera a forca que meus gladiadores nao tiveram para alcanca-lo. Va! Estarei aqui esperando por seu retorno ou da sua alma. Ha ha!", npc, creature)
			npcHandler:setTopic(playerId, 0)
			player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 4)
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Ola, meu jovem. Bem vindo a Antiga Arena de Trivallis.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
