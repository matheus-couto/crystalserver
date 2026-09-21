local internalNpcName = "Vanys"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1137,
	lookHead = 0,
	lookBody = 38,
	lookLegs = 34,
	lookFeet = 73,
	lookAddons = 0,
	lookMount = 0
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

    if MsgContains(message, "addon") then 
		if player:hasOutfit(1146) or player:hasOutfit(1147) then
			npcHandler:say("Qual addon do Dream Warrior Outfit voce gostaria de completar? O {primeiro} ou o {segundo}?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		else
			npcHandler:say("Voce ainda nao possui o Dream Warrior Outfit para completar o addon.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
    elseif MsgContains(message, "primeiro") or MsgContains(message, "first") then
		npcHandler:say("Para o primeiro addon voce devera entregar 5 Pomegranades. Voce possui todos os itens com voce?", npc, creature)
		npcHandler:setTopic(playerId, 2)
    elseif MsgContains(message, "segundo") or MsgContains(message, "second") then
		npcHandler:say("Para o segundo addon voce devera entregar 1 Ice Shield. Voce possui o iten com voce?", npc, creature)
		npcHandler:setTopic(playerId, 3)
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
		if npcHandler:getTopic(playerId) == 2 then
			if player:getItemCount(30169) >= 5 then
				player:removeItem(30169, 5)
				player:addOutfitAddon(1146, 1)
				player:addOutfitAddon(1147, 1)
				local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
				player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
				player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
				npcHandler:say("Muito bem! Aqui esta seu primeiro addon.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Parece que voce nao possui todos os itens...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 3 then
			if player:getItemCount(30168) >= 1 then
				player:removeItem(30168, 1)
				player:addOutfitAddon(1146, 2)
				player:addOutfitAddon(1147, 2)
				local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
				player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
				player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
				npcHandler:say("Muito bem! Aqui esta seu segundo addon.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Parece que voce nao possui o Ice Shield...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end
end


npcHandler:setMessage(MESSAGE_GREET, "Saudacoes. Em troca de alguns itens posso te entregar os {addon}s do Dream Warrior Outfit.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
