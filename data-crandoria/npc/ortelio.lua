local internalNpcName = "Ortelio"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 133,
	lookHead = 0,
	lookBody = 9,
	lookLegs = 0,
	lookFeet = 114,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Help!" },
	{ text = "I'm trapped! Help me!" },
	{ text = "Please, somebody help!" },
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

	local storage = player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Questlog)

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "sair") then
		if player:getPosition().x < 5161 or player:getPosition().y > 4305 then
			if storage >= 5 then
				npcHandler:say("Sou muito grato pela sua ajuda.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Me ajude, por favor! O guarda deve voltar a qualquer momento. Use um dedo de um dos demonios desse lugar para tentar abrir a cela.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		else
			if storage >= 5 then
				npcHandler:say("Sou muito grato pela sua ajuda.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Vamos logo, nao perca nem um segundo! Vamos embora!", npc, creature)
				player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Questlog, 5)
				npcHandler:setTopic(playerId, 0)
			end
		end
		return true
	end

	return true
end
npcHandler:setMessage(MESSAGE_GREET, "Nao perca tempo. Me ajude a {sair} daqui.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Espere! Ajude!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ei, me ajude!")

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
