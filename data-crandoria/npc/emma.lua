local internalNpcName = "Emma"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 139,
	lookHead = 77,
	lookBody = 116,
	lookLegs = 120,
	lookFeet = 115,
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

    local storage = player:getStorageValue(Storage.AccessBoss.ScarlettAccess)

    if MsgContains(message, "enfrentar") or MsgContains(message, "mission") or MsgContains(message, "missao") then
		if storage < 1 then
			npcHandler:say("HA HA HA HA! Voce sera um otimo aperitivo para ela. Mas nao pense que seu acesso sera gratuito... \z
			Se quiser acesso ilimitado aos aposentos de Scarlett Etzel tera que me trazer 10 Cobra Crests, obtidos das criaturas da ilha.", npc, creature)
			player:setStorageValue(Storage.AccessBoss.ScarlettAccess, 1)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 1 then
			npcHandler:say("Voce esta com os 10 Cobra Crests?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif storage == 2 then
			npcHandler:say("O que esta esperando? Va logo morrer nas maos da Scarlett Etzel!", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 1 then
			if player:getItemCount(31678) >= 10 then
				player:removeItem(31678, 10)
				player:setStorageValue(Storage.AccessBoss.ScarlettAccess, 2)
				local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
				player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
				player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
				npcHandler:say("Voce conseguiu? Hum... bom, isso nao significa nada! Ainda aposto que acabara morrendo la dentro. Boa sorte, seu acesso esta liberado.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao tem os 10 Cobra Crests. Esta tentando me passar para tras? Saia daqui!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcHandler:setMessage(MESSAGE_GREET, "Ja sei, ja sei... acha que tem chances de {enfrentar} Scarlett Etzel e sair com vida.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Espero nao te ver mais por aqui.")

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
