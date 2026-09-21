local internalNpcName = "Captain Seahorse"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 129,
	lookHead = 19,
	lookBody = 113,
	lookLegs = 95,
	lookFeet = 115,
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
	local level = player:getLevel()

    if MsgContains(message, "passage") then
		if level < 300 then
			npcHandler:say("Sinto muito, mas voce nao possui forca o suficiente para aguentar a viagem. Retorne apos o nivel 300.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		else
			npcHandler:say("Meus destinos incluem {Trivallis} e {Rootland}. Para onde deseja ir?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
	elseif MsgContains(message, "triva") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Deseja retornar para Triavllis por 5.000 gold coins?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		end
	elseif MsgContains(message, "root") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Deseja ir para Rootland por 5.000 gold coins?", npc, creature)
			npcHandler:setTopic(playerId, 3)
		end
	elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 2 then
			if player:removeMoneyBank(5000) then
				player:teleportTo(Position(5763, 5619, 6))
				npcHandler:say("Vamos indo!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao tem gold o suficiente.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 3 then
			if player:removeMoneyBank(5000) then
				player:teleportTo(Position(6078, 4353, 6))
				npcHandler:say("Vamos indo!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao tem gold o suficiente.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. Posso de levar para a ilha de Rootland, lar da lenda da planta gigante Podzilla. Se quiser ir, basta pedir por uma {passagem}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais, jovem aventureiro.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus!")

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("passage", "bye")

npcType:register(npcConfig)
