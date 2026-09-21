local npcType = Game.createNpcType("...")
local npcConfig = {}

npcConfig.description = "..."

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 1500
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

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

    if MsgContains(message, "mission") and Game.getStorageValue(GlobalStorage.FerumbrasAscendant.FerumbrasEssence) == 1 then
		if player:getStorageValue(Storage.Quest.U10_90.FerumbrasAscension.TarbazNotes) == 2 then
			npcHandler:say("I can not help you. I dont even remember my own name... Do you know what is it?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		else
			npcHandler:say("Have you read the Tarbaz Notes already? I don't think so...", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
    elseif MsgContains(message, "tevon") and npcHandler:getTopic(playerId) == 1 then
		if player:getStorageValue(Storage.Quest.U10_90.FerumbrasAscension.TarbazDoor) ~= 1 then
			npcHandler:say("Oh, yeah! Thats it! Thanks for helping me to remember. I will allow your passage to the chambers of Tarbaz for that. Thank you!", npc, creature)
			player:setStorageValue(Storage.Quest.U10_90.FerumbrasAscension.TarbazDoor, 1)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.U10_90.FerumbrasAscension.TarbazDoor) == 1 then
			npcHandler:say("Oh... Right! We had this conversation already, didnt we? Haha! Thanks again!", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	end
end


npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)

