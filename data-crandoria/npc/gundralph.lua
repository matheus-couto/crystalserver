local internalNpcName = "Gundralph"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 9,
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
    
    local storageReward = Storage.Quest.Crandoria.EventoProgramado.RewardArtefato
	local storageGlobal = Game.getStorageValue(GlobalStorage.Crandoria.Eventos.EventoProgramado)
	local name = player:getName()

    if MsgContains(message, "artefato perdido") or MsgContains(message, "missao") or MsgContains(message, "mission") then
		npcHandler:say("Voce tem um artefato perdido com voce?", npc, creature)
		npcHandler:setTopic(playerId, 1)
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
			if player:removeItem(19149, 1) then
				npcHandler:say("Voce conseguiu! Parabens. Voce foi o vencedor do evento Artefato Perdido desta semana. Obtenha sua recompensa no bau de recompensas abaixo do Templo de Crandoria.", npc, creature)
				Game.broadcastMessage("O jogador "..name.." entregou o Artefato Perdido e foi o vencedor do evento da semana.", MESSAGE_EVENT_ADVANCE)
				Game.setStorageValue(GlobalStorage.Crandoria.Eventos.EventoProgramado, 0)
				player:setStorageValue(storageReward, 2)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao possui o Artefato. Talvez ele tenha se dissolvido na sua mochila...", npc, creature)
        		npcHandler:setTopic(playerId, 0)
			end
		end
    elseif (MsgContains(message, "nao") or MsgContains(message, "no")) then
        npcHandler:say("Tudo bem.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Preciso de um {artefato aerdido} para entregar ao museu.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
