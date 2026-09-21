local internalNpcName = "Gnomadness"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 493,
	lookHead = 110,
	lookBody = 65,
	lookLegs = 110,
	lookFeet = 110,
	lookAddons = 0
}

npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = " I'll have to write that idea down."},
	{ text = "So many ideas, so little time" },
	{ text = "Muhahaha!" },
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

local function creatureSayCallback(npc, creature, type, message, hazard)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local hazard = Hazard.getByName("hazard.gnomprona-gardens")
	local current = hazard:getPlayerCurrentLevel(player)
	local maximum = hazard:getPlayerMaxLevel(player)

	if MsgContains(message, "hazard") then
		npcHandler:say("Posso alterar seu nivel de Hazard e tornar as coisas mais interessantes. Seu nivel atual esta em " .. current .. ". O nivel maximo para voce e {" .. maximum .. "}. Em qual nivel voce gostaria de permanecer?", npc, creature)
		npcHandler:setTopic(playerId, 1)
	else
		if npcHandler:getTopic(playerId) == 1 then
			-- local desiredLevel = getMoneyCount(message)
			local desiredLevel = tonumber(message)
			if desiredLevel == -1 then
				npcHandler:say("Me desculpe, nao entendi...?", npc, creature)
				npcHandler:setTopic(playerId, 0)
				return true
			end
			if desiredLevel > maximum then
				npcHandler:say("Voce nao pode aumentar tanto seu nivel de Hazard.", npc, creature)
			end

			if hazard:setPlayerCurrentLevel(player, desiredLevel) then
				npcHandler:say("Seu nivel foi setado em " .. desiredLevel .. ". Boa sorte!", npc, creature)
			else
				npcHandler:say("Voce nao pode alterar seu nivel de Hazard para um nivel maior que seu nivel maximo permitido.", npc, creature)
			end
		end
	end
	return true
end

keywordHandler:addGreetKeyword({'hi'}, {npcHandler = npcHandler, text = "Bem vindo a Gnomprona Gardens. Se quiser alterar seu nivel de {hazard}, eu sou a pessoa que voce procura."})
keywordHandler:addAliasKeyword({'hello'})

npcHandler:setMessage(MESSAGE_GREET, 'Ola e bem vindo a Gnomprona Gardens')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
