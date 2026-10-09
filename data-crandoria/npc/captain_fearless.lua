local internalNpcName = "Captain Fearless"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

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

npcConfig.voices = {
	interval = 15000,
	chance = 50,
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
    
    local storage = player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso)
	local rep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
	local pos = player:getPosition()

    if MsgContains(message, "passage") then
		if pos.y < 5068 then
			if storage < 22 then
				npcHandler:say("Eu sinto muito, |PLAYERNAME|, mas voce precisara da autorizacao do Comandante Crassus para ir ate la. \z
				Conclua algumas de suas missoes e com certeza ele colocara seu nome na lista!", npc, creature)
				npcHandler:setTopic(playerId, 0)   
			else
				if storage == 22 then
					npcHandler:say("Ah, voce foi mandado pelo Comandante Crassus, estou certo? Muito bem, te levarei ate a ilha a pedido dele. Deseja mesmo ir?", npc, creature)
					npcHandler:setTopic(playerId, 4) 
				else
					if rep < 100 then
						npcHandler:say("Todos aqueles com reputacao Respeitavel ou superior podem ir ate a ilha de volta, mas para voce... bom, digamos que serao 3 Online Tokens. \z
						Quer mesmo ir?", npc, creature)
						npcHandler:setTopic(playerId, 1)   
					else
						npcHandler:say("Ah! Vejo que voce possui muita reputacao por aqui. Deseja ir gratuitamente ate a Arena dos Minibosses?", npc, creature)
						npcHandler:setTopic(playerId, 2) 
					end
				end
			end    
		else
			npcHandler:say("Deseja retornar para Crandoria?", npc, creature)
			npcHandler:setTopic(playerId, 3) 
		end 
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
			if player:removeItem(22723, 3) then
				player:teleportTo(Position(5235, 5128, 7))
				npcHandler:say("Ta na hora!", npc, creature)
				npcHandler:setTopic(playerId, 0)  
			else
				npcHandler:say("Confira os bolsos. Acho que voce nao esta com os Online Tokens.", npc, creature)
				npcHandler:setTopic(playerId, 0) 
			end
		elseif npcHandler:getTopic(playerId) == 2 or npcHandler:getTopic(playerId) == 4 then
			player:teleportTo(Position(5235, 5128, 7))
			npcHandler:say("Ta na hora!", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 3 then
			player:teleportTo(Position(5235, 5065, 7))
			npcHandler:say("De volta para minha terra.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
    elseif (MsgContains(message, "nao") or MsgContains(message, "no")) then
        npcHandler:say("Ok.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end

npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. Fale comigo se precisar de uma {passagem} a Arena de Minibosses ou de volta para Crandoria.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("passage", "bye")

npcType:register(npcConfig)
