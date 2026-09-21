local internalNpcName = "Charos"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 133,
	lookHead = 60,
	lookBody = 94,
	lookLegs = 114,
	lookFeet = 115,
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

local config = {
	towns = {
		["crandoria"] = TOWNS_LIST.CRANDORIA,
		["astralis"] = TOWNS_LIST.ASTRALIS,
		["anvillux"] = TOWNS_LIST.ANVILLUX,
		["elvenshire"] = TOWNS_LIST.ELVENSHIRE,
		["valkesh"] = TOWNS_LIST.VALKESH,
		["chaos"] = TOWNS_LIST.CHAOS,
		["hakata"] = TOWNS_LIST.HAKATA,
		["nivabi"] = TOWNS_LIST.NIVABI,
		["magincia"] = TOWNS_LIST.MAGINCIA,
	}
}

local function greetCallback(npc, creature)
	local player = Player(creature)
	local playerId = player:getId()

	if player:getStorageValue(Storage.AdventurersGuild.CharosTrav) > 6 then
		npcHandler:say("Me desculpe, mas voce ja viajou demais.", npc, creature)
		npcHandler:resetNpc(creature)
		return false
	else
		npcHandler:setMessage(MESSAGE_GREET, "Ola, jovem viajante. Eu posso te levar para a cidade de sua escolha. \z
		Se voce pisar no teletransporte voce sera teletransportado para uma cidade de sua escolha. Seria esse o seu desejo?")
	end
	return true
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if npcHandler:getTopic(playerId) == 0 then
		if MsgContains(message, "yes") or MsgContains(message, "sim") then
			if player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.House) ~= 1 and player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.Outfit) < 1 then
				npcHandler:say("Otimo, voce tem ".. -player:getStorageValue(Storage.AdventurersGuild.CharosTrav)+7 .." \z
				viagens restantes. Qual sera a cidade da sua escolha? Anvillux, Crandoria, Elvenshire, Valkesh, Chaos, \z
				Hakata, Astralis, Magincia ou Nivabi?", npc, creature)
				npcHandler:setTopic(playerId, 1)
			else
				npcHandler:say("Desculpe, mas seguidores do Caminho Vermelho nao sao bem vindos aqui.", npc, creature)
			end
		end
	elseif npcHandler:getTopic(playerId) == 1 then
		local cityTable = config.towns[message:lower()]
		if cityTable then
			player:setStorageValue(Storage.AdventurersGuild.CharosTrav,
			player:getStorageValue(Storage.AdventurersGuild.CharosTrav)+1)
			player:setStorageValue(Storage.AdventurersGuild.Stone, cityTable)
			npcHandler:say("Adeus, viajante!", npc, creature)
		else
			npcHandler:say("Desculpe, nao conheco esse lugar.", npc, creature)
		end
	else
		npcHandler:say("Desculpe, mas seguidores do Caminho Vermelho nao sao bem vindos aqui.", npc, creature)
	end
	return true
end

npcHandler:setCallback(CALLBACK_SET_INTERACTION, onAddFocus)
npcHandler:setCallback(CALLBACK_REMOVE_INTERACTION, onReleaseFocus)
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
