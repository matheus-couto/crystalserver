local internalNpcName = "Kalvin"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 132,
	lookHead = 115,
	lookBody = 117,
	lookLegs = 120,
	lookFeet = 126,
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

local items1 = {
	{ name = "Fresh Fruits", id = 25692, count = 25 },
	{ name = "Pineapples", id = 11459, count = 10 },
	{ name = "Dragonfruits", id = 11682, count = 3 },
}

local items2 = {
	{ name = "Blue Glass Plates", id = 29345, count = 5 },
	{ name = "Green Glass Plates", id = 29346, count = 5 },
	{ name = "Violet Glass Plates", id = 29347, count = 5 },
}

local items3 = {
	{ name = "Giant Leaf", id = 11550, count = 1 },
	{ name = "Exquisite Wood", id = 11547, count = 1 },
	{ name = "Mystic Root", id = 11551, count = 1 },
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()
	local progresso = player:getStorageValue(Storage.Quest.Crandoria.QuestKalvin.Progresso)
	local cooldown  = player:getStorageValue(Storage.Quest.Crandoria.QuestKalvin.Timer)
	local index1 = player:getStorageValue(Storage.Quest.Crandoria.QuestKalvin.Item1)
	local index2 = player:getStorageValue(Storage.Quest.Crandoria.QuestKalvin.Item2)
	local index3 = player:getStorageValue(Storage.Quest.Crandoria.QuestKalvin.Item3)
	local timeLeft = math.floor((player:getStorageValue(Storage.Quest.Crandoria.BugozdQuest.Timer) - os.time()) / 60)

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "missao") or MsgContains(message, "mission") or MsgContains(message, "elixir") then
		if player:getLevel() < 400 then
			npcHandler:say("Acha mesmo que vou confiar minhas tarefas importantissimas nessa fortaleza a alguem tao fraco? Retorne apos o nivel 400 e talvez possamos conversar.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		else
			if progresso < 1 then
				if cooldown < os.time() then
					npcHandler:say("Sou um dos responsaveis pela manutencao dos recursos da nossa fortaleza. Como voce viu, nem todos aqui sao amigaveis... \z
					Atualmente estou em busca de alguns recursos e talvez voce possa me ajudar, mas aviso desde ja que voce tera que trazer tudo aqui. \z
					E eu nao te protegerei caso alguem da fortaleza queira te atacar no caminho... Voce se interessa pela tarefa?", npc, creature)
					npcHandler:setTopic(playerId, 1)
				else
					npcHandler:say("Voce ja me ajudou recentemente. So preciso de suprimentos uma vez por semana. Retorne em "..timeLeft.." minutos e terei uma nova tarefa para voce.", npc, creature)
				end
			elseif progresso == 1 then
				local item1 = items1[index1]
				local item2 = items2[index2]
				local item3 = items3[index3]
				npcHandler:say("Como eu disse, preciso de " ..item1.count .. " " .. item1.name .. ", " ..item2.count .. " " .. item2.name .. " e " ..item3.count .. " " .. item3.name .. ". Voce tem tudo com voce?", npc, creature)
				npcHandler:setTopic(playerId, 2)
			end
		end
	elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 1 then
			local i1 = math.random(#items1)
			local i2 = math.random(#items2)
			local i3 = math.random(#items3)

			player:setStorageValue(Storage.Quest.Crandoria.QuestKalvin.Item1, i1)
			player:setStorageValue(Storage.Quest.Crandoria.QuestKalvin.Item2, i2)
			player:setStorageValue(Storage.Quest.Crandoria.QuestKalvin.Item3, i3)
			player:setStorageValue(Storage.Quest.Crandoria.QuestKalvin.Progresso, 1)

			local item1 = items1[i1]
			local item2 = items2[i2]
			local item3 = items3[i3]

			npcHandler:say(
				"Que otimo! Preciso de " ..
				item1.count .. " " .. item1.name .. ", " ..
				item2.count .. " " .. item2.name .. " e " ..
				item3.count .. " " .. item3.name ..
				". Traga tudo para mim e te darei sua recompensa.",
			npc, creature)

			npcHandler:setTopic(playerId, 0)

		elseif npcHandler:getTopic(playerId) == 2 then
			local item1 = items1[index1]
			local item2 = items2[index2]
			local item3 = items3[index3]

			if player:getItemCount(item1.id) >= item1.count
			and player:getItemCount(item2.id) >= item2.count
			and player:getItemCount(item3.id) >= item3.count then

				player:removeItem(item1.id, item1.count)
				player:removeItem(item2.id, item2.count)
				player:removeItem(item3.id, item3.count)

				player:addItem(3043, 10)
				player:addItem(26186, 1)

				player:setStorageValue(Storage.Quest.Crandoria.QuestKalvin.Progresso, 0)
				player:setStorageValue(Storage.Quest.Crandoria.QuestKalvin.Item1, 0)
				player:setStorageValue(Storage.Quest.Crandoria.QuestKalvin.Item2, 0)
				player:setStorageValue(Storage.Quest.Crandoria.QuestKalvin.Item3, 0)
				player:setStorageValue(Storage.Quest.Crandoria.QuestKalvin.Timer, os.time() + 7 * 24 * 60 * 60)

				npcHandler:say("Muito bem. Me deixe conferir se esta tudo aqui mesmo... Certo! Como combinado, aqui esta seu Exercise Stash e seu ouro. \z
				Retorne em uma semana e terei uma nova tarefa para voce.", npc, creature)

				npcHandler:setTopic(playerId, 0)
			end
		end
	end

	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Ah! Um visitante!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
