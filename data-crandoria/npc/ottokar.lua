local internalNpcName = "Ottokar"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 153,
	lookHead = 132,
	lookBody = 121,
	lookLegs = 120,
	lookFeet = 114,
	lookAddons = 3
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
	local storage = Game.getStorageValue(GlobalStorage.Crandoria.OttokarEvent.OttokarPouch)
	local storageTimer = Game.getStorageValue(GlobalStorage.Crandoria.OttokarEvent.OttokarRaid)
	local chance = math.random(1,10)
	local raid = "Feverish"

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, 'belongings of deceasead') or MsgContains(message, 'medicine') or MsgContains(message, 'remedio') or MsgContains(message, 'medicamento') then
		if storageTimer < os.time() then
			if player:getItemCount(12517) > 0 then
				if Game.getStorageValue(GlobalStorage.Crandoria.OttokarEvent.OttokarRaid) < os.time() then
					npcHandler:say('preciso de Medicine pouches. Mas cuidado! Feverish Citizens podem atacar outras regioes caso voce traga em quantidade excessiva. Voce trouxe uma medicine pouch?', npc, creature)
					npcHandler:setTopic(playerId, 1)
				else
					npcHandler:say('Ja recebi muitos Medicine Pouches por agora. Volte depois.', npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			else
				npcHandler:say('Preciso de uma medicine pouch e, dessa forma, te darei uma recompensa especial. Volte quando tiver algum.', npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		else
			npcHandler:say('Ja tenho o suficiente de medicine pouches por enquanto. Volte depois e talvez eu precise de mais.', npc, creature)
		end
	elseif (MsgContains(message, 'yes') or MsgContains(message, 'sim')) and npcHandler:getTopic(playerId) == 1 then
		if player:removeItem(12517, 1) then
			player:addItem(12413, 1, true)
			player:addAchievementProgress('Doctor! Doctor!', 100)
			if storage < 1 then
				Game.setStorageValue(GlobalStorage.Crandoria.OttokarEvent.OttokarPouch, 1)
				npcHandler:say('Aqui esta.', npc, creature)
			elseif storage >= 1 and storage < 20 then
				if chance <= 95 then
					Game.setStorageValue(GlobalStorage.Crandoria.OttokarEvent.OttokarPouch, storage + 1)
					npcHandler:say('Aqui esta.', npc, creature)
				else
					npcHandler:say('Aqui esta. Escute, um bando de Feverish Citizens esta prestes a aterrorizar a cidade de Chaos. Talvez voce deva ir ate la para proteger os habitantes.', npc, creature)
					Game.setStorageValue(GlobalStorage.Crandoria.OttokarEvent.OttokarRaid, os.time() + 6 * 60 * 60)
					Game.setStorageValue(GlobalStorage.Crandoria.OttokarEvent.OttokarPouch, 0)
				end
			elseif storage >= 20 and storage < 35 then
				if chance <= 90 then
					Game.setStorageValue(GlobalStorage.Crandoria.OttokarEvent.OttokarPouch, storage + 1)
					npcHandler:say('Aqui esta.', npc, creature)
				else
					npcHandler:say('Aqui esta. Escute, um bando de Feverish Citizens esta prestes a aterrorizar a cidade de Chaos. Talvez voce deva ir ate la para proteger os habitantes.', npc, creature)
					Game.setStorageValue(GlobalStorage.Crandoria.OttokarEvent.OttokarRaid, os.time() + 6 * 60 * 60)
					Game.setStorageValue(GlobalStorage.Crandoria.OttokarEvent.OttokarPouch, 0)
					Game.startRaid(raid)
				end
			elseif storage >= 35 then
				npcHandler:say('Aqui esta. Escute, um bando de Feverish Citizens esta prestes a aterrorizar a cidade de Chaos. Talvez voce deva ir ate la para proteger os habitantes.', npc, creature)
				Game.startRaid(raid)
				Game.setStorageValue(GlobalStorage.Crandoria.OttokarEvent.OttokarPouch, 0)
				Game.setStorageValue(GlobalStorage.Crandoria.OttokarEvent.OttokarRaid, os.time() + 6 * 60 * 60)
			end
		else
			npcHandler:say('Voce nao possui a Medicine Pouch.', npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. Escute, eu preciso de alguns {medicine} pouches para meu estoque de medicamentos. Se trouxer algum te entregarei uma recompensa. Basta me dizer.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
