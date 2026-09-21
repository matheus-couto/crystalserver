local internalNpcName = "Heavenly Messenger"
local npcType = Game.createNpcType("Heavenly Messenger")
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 294,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
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

--
-- CHATGPT, INSERIR FUNÇÕES DE DIÁLOGO AQUI:

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end
	local addonProgress = player:getStorageValue(Storage.Quest.Crandoria.FerumbrasAscension.Outfit)
	if MsgContains(message, 'outfit') and addonProgress < 1 then
		npcHandler:say('It seems that in fighting so close to the rift to beyond, you acquired a new outfit! What a strange occurrence indeed.', npc, creature)
		player:addOutfit(845, 0)
		player:addOutfit(846, 0)
		local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
		player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
		player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
		player:setStorageValue(Storage.Quest.Crandoria.FerumbrasAscension.Outfit, 1)

	elseif MsgContains(message, 'outfit') and addonProgress == 1 then
		npcHandler:say('You already have the outfits.', npc, creature)
	end
end
--
npcHandler:setMessage(MESSAGE_GREET, 'Greetings, warrior of the rift! I am a messenger of the heavenly forces.')
	npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|.')
	npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
