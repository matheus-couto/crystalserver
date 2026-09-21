local internalNpcName = "The Draccoon"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 1703,
	lookAddons = 3,
}

npcConfig.flags = {
	floorchange = false,
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

    local storage = player:getStorageValue(Storage.Quest.Crandoria.TheFalseGod.Progresso)

    if MsgContains(message, "teleport") or MsgContains(message, "tp") then
		if storage == 8 then
			npcHandler:say("Eu nao como nada alem de carne crua ha muito tempo. Talvez voce possa me ajudar com isso e, em troca, deixo que voce passe. \z
			Traga para mim 10 Dragonfruits e um delicioso prato, digamos... um Roasted Dragon Wings. Voce tem esses itens com voce?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
	elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
		if npcHandler:getTopic(playerId) == 1 then
			if player:getItemCount(11682) >= 10 and player:getItemCount(9081) >= 1 then
				player:removeItem(11682, 10) and player:removeItem(9081, 1)
				npcHandler:say("<nhac!> Aaaah! Isso que eu chamo de comida de verdade! Maravilhoso. Tudo bem como combinado, voce pode passar pelo teleport. Boa sorte com os Bulltaurs.", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.TheFalseGod.Progresso, 9)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcHandler:setMessage(MESSAGE_GREET, "O que faz aqui? Bao permito que qualquer um passe pelo {teleport}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
