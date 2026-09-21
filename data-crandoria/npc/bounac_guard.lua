local internalNpcName = "Bounac Guard"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = "Boris the Guard"
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1071,
	lookHead = 38,
	lookBody = 114,
	lookLegs = 132,
	lookFeet = 98,
	lookAddons = 3,
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

    local storage = player:getStorageValue(Storage.AccessBoss.OberonAccess)

    if MsgContains(message, "enfrentar") or MsgContains(message, "mission") or MsgContains(message, "missao") then
		if storage < 1 then
			npcHandler:say("Escute, jovem... Eu aconselho a nao entregar sua vida assim, mas defendo sua liberdade de tentar. \z
			Se quer mesmo passar por esse desafio, traga-me antes 10 Falcon Crests e permitirei que passe pelo teleport.", npc, creature)
			player:setStorageValue(Storage.AccessBoss.OberonAccess, 1)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 1 then
			npcHandler:say("Voce esta com os 10 Falcon Crests?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif storage == 2 then
			npcHandler:say("Bom... eu ja dei meu conselho, agora voce deve decidir. Se quiser enfrentar Oberon, fique a vontade.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 1 then
			if player:getItemCount(31678) >= 10 then
				player:removeItem(31678, 10)
				player:setStorageValue(Storage.AccessBoss.OberonAccess, 2)
				local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
				player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
				player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
				npcHandler:say("Excelente! Talvez nao sera assim tao facil que Oberon te mate. Espero que voce se divirta antes de morrer. HAHA! Boa sorte.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce ainda nao tem os 10 Falcon Crests. Sinto muito.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcHandler:setMessage(MESSAGE_GREET, "Nao me diga que acha que pode {enfrentar} o Grand Master Oberon.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais. Ha ha ha!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Espero nao te ver mais por aqui.")

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
