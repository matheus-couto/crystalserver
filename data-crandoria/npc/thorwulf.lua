local internalNpcName = "Thorwulf"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 143,
	lookHead = 3,
	lookBody = 58,
	lookLegs = 97,
	lookFeet = 116,
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

	BossTasks = {
		[1] = {name = "Scarlett Etzel", minLevel = 250},
		[2] = {name = "King Zelos", minLevel = 250},
		[3] = {name = "Grand Master Oberon", minLevel = 250},
		[4] = {name = "Faceless Bane", minLevel = 250},
		[5] = {name = "Ahau", minLevel = 250},
		[6] = {name = "Timira the Many-Headed", minLevel = 250},
		[7] = {name = "Bakragore", minLevel = 800},
		[8] = {name = "Chagorz", minLevel = 800},
		[9] = {name = "Drume", minLevel = 250},
		[10] = {name = "The False God", minLevel = 250},
		[11] = {name = "The First Dragon", minLevel = 500},
		[12] = {name = "Frozen King", minLevel = 500},
		[13] = {name = "Gaia", minLevel = 500},
		[14] = {name = "Goshnar's Cruelty", minLevel = 600},
		[15] = {name = "Goshnar's Greed", minLevel = 600},
		[16] = {name = "Goshnar's Spite", minLevel = 600},
		[17] = {name = "Goshnar's Malice", minLevel = 600},
		[18] = {name = "Goshnar's Hatred", minLevel = 600},
		[19] = {name = "Ichgahal", minLevel = 800},
		[20] = {name = "Magma Bubble", minLevel = 250},
		[21] = {name = "The Primal Menace", minLevel = 250},
		[22] = {name = "Pale Worm", minLevel = 250},
		[23] = {name = "Murcion", minLevel = 800},
		[24] = {name = "Scourge of Oblivion", minLevel = 250},
		[25] = {name = "The Brainstealer", minLevel = 250},
		[26] = {name = "The Flame Guardian", minLevel = 600},
		[27] = {name = "Vemiath", minLevel = 600},
		[28] = {name = "Zarabastan", minLevel = 250},
		[29] = {name = "The Monster", minLevel = 250},
	}

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end
	
	local function getRandomBoss(player)
		local level = player:getLevel()
		local availableBosses = {}

		for id, data in pairs(BossTasks) do
			if level >= data.minLevel then
				table.insert(availableBosses, {id = id, name = data.name})
			end
		end

		if #availableBosses == 0 then
			return nil, nil
		end

		local chosen = availableBosses[math.random(#availableBosses)]
		return chosen.id, chosen.name
	end

	local reset = player:getStorageValue(Storage.Quest.Crandoria.Reset.Count)
    local boss = player:getStorageValue(Storage.Quest.Crandoria.BossTasks.Boss)
	local count = player:getStorageValue(Storage.Quest.Crandoria.BossTasks.Count)
	local timer = player:getStorageValue(Storage.Quest.Crandoria.BossTasks.Timer)
	local cooldown = player:getStorageValue(Storage.Quest.Crandoria.BossTasks.Cooldown)

	local factor = reset * 1.1
	local level = player:getLevel()

	local exp = 50000 * level * factor

    if MsgContains(message, "mission") or MsgContains(message, "missao") or MsgContains(message, "task") then
		if reset < 1 or level < 250 then
			npcHandler:say("Eu sinto muito, mas minhas missoes sao apenas para aqueles que possuem ao menos 1 Reset e nivel 250 ou superior.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		else
			if cooldown < os.time() then
				if timer > os.time() then
					if count < 1 then
						npcHandler:say("Voce ainda nao completou sua tarefa...", npc, creature)
						npcHandler:setTopic(playerId, 0)
					else
						npcHandler:say("Muito bom. Um boss a menos para nos preocupar em Crandoria! Aqui esta sua recompensa em experiencia. Retorne em 20 horas e te darei uma nova missao.", npc, creature)
						player:addExperience(exp)
						player:setStorageValue(Storage.Quest.Crandoria.BossTasks.Count, 0)
						player:setStorageValue(Storage.Quest.Crandoria.BossTasks.Boss, 0)
						player:setStorageValue(Storage.Quest.Crandoria.BossTasks.Timer, 0)
						player:setStorageValue(Storage.Quest.Crandoria.BossTasks.Cooldown, os.time() + 20 * 60 * 60)
						npcHandler:setTopic(playerId, 0)
					end
				else
					if timer < 1 then
						local bossNumber, bossName = getRandomBoss(player)
						npcHandler:say("Vim para Crandoria com um unico objetivo: eliminar Bosses! O boss que voce deve matar sera: "..bossName..". Derrote-o em ate 2 horas. \z
						Se conseguir te recompensarei com uma boa quantidade de experiencia e um bonus de experiencia se voce tiver mais resets! Estou esperando.", npc, creature)
						player:setStorageValue(Storage.Quest.Crandoria.BossTasks.Count, 0)
						player:setStorageValue(Storage.Quest.Crandoria.BossTasks.Boss, bossNumber)
						player:setStorageValue(Storage.Quest.Crandoria.BossTasks.Timer, os.time() + 2 * 60 * 60)
						npcHandler:setTopic(playerId, 0)
					else
						npcHandler:say("Voce nao finalizou a missao a tempo e perdeu a recompensa. Fale comigo se quiser uma nova {missao}.", npc, creature)
						player:setStorageValue(Storage.Quest.Crandoria.BossTasks.Timer, 0)
						npcHandler:setTopic(playerId, 0)
					end
				end
			else
				npcHandler:say("Voce finalizou uma missao a menos de 20 horas. Aguarde para obter uma nova.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ah! Ola, jovem. Que tal ganhar muita experiencia derrotando seu proximo boss?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
