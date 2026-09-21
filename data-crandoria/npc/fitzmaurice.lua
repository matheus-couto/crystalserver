local internalNpcName = "Fitzmaurice"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 1071,
	lookHead = 57,
	lookBody = 57,
	lookLegs = 57,
	lookFeet = 57,
	lookAddons = 3,
}

npcConfig.respawnType = {
	period = RESPAWNPERIOD_NIGHT,
	underground = false,
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

    local storage = player:getStorageValue(Storage.AccessBoss.DrumeAccess)

    if MsgContains(message, "enfrentar") or MsgContains(message, "mission") or MsgContains(message, "missao") then
		if storage < 1 then
			npcHandler:say("Eu soube mesmo que alguns guerreiros valentes de Crandoria estavam planejando desafiar o grande Drume. \z
			Nao se preocupe, nao proibirei sua passagem, mas antes voce tera que me entregar 10 Lion Cloak Patches. Se voce acha que pode vencer o Drume, isso nao sera um problema.", npc, creature)
			player:setStorageValue(Storage.AccessBoss.DrumeAccess, 1)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 1 then
			npcHandler:say("Voce trouxe os 10 Lion Cloak Patches?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif storage == 2 then
			npcHandler:say("Chegou a hora da sua morte. Boa sorte contra o Drume.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 1 then
			if player:getItemCount(34162) >= 10 then
				player:removeItem(34162, 10)
				player:setStorageValue(Storage.AccessBoss.DrumeAccess, 2)
				local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
				player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
				player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
				npcHandler:say("Tudo aqui. Muito bem, voce pode passar. Aconselho que leve um time com voce, ou nao dara nem tempo para que voce se arrependa...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao tem todos os itens.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcHandler:setMessage(MESSAGE_GREET, "Posso te dar a chance de {enfrentar} o grande Drume.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Espero nao te ver mais por aqui.")

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
