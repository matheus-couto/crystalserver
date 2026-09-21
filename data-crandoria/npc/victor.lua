local internalNpcName = "Victor"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 134,
	lookHead = 21,
	lookBody = 78,
	lookLegs = 38,
	lookFeet = 95,
	lookAddons = 3
}

npcConfig.flags = {
	floorchange = false
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

local baseCost = {
    xp = math.random(90, 120),
    loot = math.random(90, 120),
    skills = math.random(90, 120),
    coleta = math.random(70, 100),
    afk = math.random(50, 80)
}

local function getPlayerPrices(player)

    -- Copia valores base (imutáveis)
    local costXp = baseCost.xp
    local costLoot = baseCost.loot
    local costSkills = baseCost.skills
    local costColeta = baseCost.coleta
    local costAfk = baseCost.afk

    -- Storages globais
    local storageXp = math.max(0, Game.getStorageValue(GlobalStorage.Crandoria.BuffsVictor.Xp))
    local storageLoot = math.max(0, Game.getStorageValue(GlobalStorage.Crandoria.BuffsVictor.Loot))
    local storageSkills = math.max(0, Game.getStorageValue(GlobalStorage.Crandoria.BuffsVictor.Skills))
    local storageColeta = math.max(0, Game.getStorageValue(GlobalStorage.Crandoria.BuffsVictor.Coleta))
    local storageAfk = math.max(0, Game.getStorageValue(GlobalStorage.Crandoria.BuffsVictor.Afk))

    -- Cálculo individual (SEM alterar base)
    costXp = (costXp + (storageXp * 5))
    costLoot = (costLoot + (storageLoot * 5))
    costSkills = (costSkills + (storageSkills * 5))
    costColeta = (costColeta + (storageColeta * 5))
    costAfk = (costAfk + (storageAfk * 5))

    -- Evita valores negativos ou zero
    costXp = math.max(1, costXp)
    costLoot = math.max(1, costLoot)
    costSkills = math.max(1, costSkills)
    costColeta = math.max(1, costColeta)
    costAfk = math.max(1, costAfk)

    -- Desconto da sociedade
    local storage = player:getStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.Progresso)

    if storage >= 13 then
        costXp = math.floor(costXp / 2)
        costLoot = math.floor(costLoot / 2)
        costSkills = math.floor(costSkills / 2)
        costColeta = math.floor(costColeta / 2)
        costAfk = math.floor(costAfk / 2)
    end

    return {
        xp = costXp,
        loot = costLoot,
        skills = costSkills,
        coleta = costColeta,
        afk = costAfk
    }
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	local prices = getPlayerPrices(player)

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local storage = player:getStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.Progresso)
	local repStorage = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
	local reset = player:getStorageValue(Storage.Quest.Crandoria.DracantusQuest.KillCount)
	local rep = "Ilustres"

	if repStorage > 174 then
		rep = "Nobres"
	elseif repStorage > 274 then
		rep = "Virtuosos"
	elseif repStorage > 499 then
		rep = "Honrados"
	elseif repStorage > 999 then
		rep = "Lendarios"
	end

	local storage1 = Game.getStorageValue(GlobalStorage.Crandoria.BuffsVictor.Xp)
    local storage2 = Game.getStorageValue(GlobalStorage.Crandoria.BuffsVictor.Loot)
    local storage3 = Game.getStorageValue(GlobalStorage.Crandoria.BuffsVictor.Skills)
    local storage4 = Game.getStorageValue(GlobalStorage.Crandoria.BuffsVictor.Coleta)
    local storage5 = Game.getStorageValue(GlobalStorage.Crandoria.BuffsVictor.Afk)

	local currentExpBoostTime = player:getExpBoostStamina()
	local timeLeft = math.floor((player:getStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffCooldown) - os.time()) / 60)

	if MsgContains(message, "buff") then
		if player:getStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffCooldown) < os.time() then
			npcHandler:say("Posso te fornecer buff de {experiencia}, de {loot} e de {skills} em troca de Tibia Coins. \z
			Membros da {sociedade} pagam a metade do preco em qualquer buff. De qual desses voce gostaria de se beneficiar hoje?", npc, creature)
			if storage1 < 0 and storage2 < 0 and storage3 < 0 and storage4 < 0 and storage5 < 0 then
				Game.setStorageValue(GlobalStorage.Crandoria.BuffsVictor.Xp, 0)
				Game.setStorageValue(GlobalStorage.Crandoria.BuffsVictor.Loot, 0)
				Game.setStorageValue(GlobalStorage.Crandoria.BuffsVictor.Skills, 0)
				Game.setStorageValue(GlobalStorage.Crandoria.BuffsVictor.Coleta, 0)
				Game.setStorageValue(GlobalStorage.Crandoria.BuffsVictor.Afk, 0)
			end
			npcHandler:setTopic(playerId, 1)
		else
			npcHandler:say("Voce ja utilizou um buff nas ultimas 24 horas. Retorne em "..timeLeft.." minutos se quiser obter outro buff.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "exp") or MsgContains(message, "xp") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Posso te fornecer 2 horas de +50% Xp por " ..prices.xp.. " Tibia Coins. O tempo deste buff se somara a qualquer outro buff de potion e Store que voce tiver. Voce aceita?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		end
	elseif MsgContains(message, "loot") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Posso te fornecer 2 horas com +25% na taxa de Loot por " ..prices.loot.. " Tibia Coins. O tempo sera contado continuamente independente de voce estar ativo ou nao. O buff se aplica a bosses e criaturas. Voce aceita?", npc, creature)
			npcHandler:setTopic(playerId, 3)
		end
	elseif MsgContains(message, "skill") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Posso te fornecer 4 horas de Double Skills por " ..prices.skills.. " Tibia Coins. O tempo sera contado continuamente independente de voce estar ativo ou nao. Voce aceita?", npc, creature)
			npcHandler:setTopic(playerId, 4)
		end
	-- elseif MsgContains(message, "coleta") then
	-- 	if npcHandler:getTopic(playerId) == 1 then
	-- 		npcHandler:say("Posso te fornecer retorno em dobro de itens nos sistemas de Farming, Lumberjack, Mining e Fishing por 4 horas pelo valor de " ..prices.coleta.. " Tibia Coins. O tempo sera contado continuamente independente de voce estar ativo ou nao. Voce aceita?", npc, creature)
	-- 		npcHandler:setTopic(playerId, 5)
	-- 	end
	-- elseif MsgContains(message, "afk") then
	-- 	if npcHandler:getTopic(playerId) == 1 then
	-- 		npcHandler:say("Posso te dobrar seu bonus de Xp por checagem respondida corretamente pelo periodo de 4 horas por " ..prices.afk.. " Tibia Coins. O tempo sera contado continuamente independente de voce estar ativo ou nao. Voce aceita?", npc, creature)
	-- 		npcHandler:setTopic(playerId, 6)
	-- 	end
	elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 2 then
			if player:getExpBoostStamina() < 1 * 60 * 60 then
				if player:removeTransferableCoins(prices.xp) then
					player:setStoreXpBoost(50)
					player:setExpBoostStamina(currentExpBoostTime + 60 * 60)
					player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffCooldown, os.time() + 24 * 60 * 60)
					Game.setStorageValue(GlobalStorage.Crandoria.BuffsVictor.Xp, storage1 + 5)
					player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
					npcHandler:say("Buff aplicado! Boa hunt!", npc, creature)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Voce nao possui o valor necessario.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			else
				npcHandler:say("Voce nao pode acumular mais de 3 horas de Xp Boost.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 3 then
			if player:removeTransferableCoins(prices.loot) then
				player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffLoot, os.time() + 2 * 60 * 60)
				player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffCooldown, os.time() + 24 * 60 * 60)
				Game.setStorageValue(GlobalStorage.Crandoria.BuffsVictor.Loot, storage2 + 1)
				player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
				npcHandler:say("Buff aplicado! Boa hunt!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao possui o valor necessario.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 4 then
			if player:removeTransferableCoins(prices.skills) then
				player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffSkills, os.time() + 4 * 60 * 60)
				player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffCooldown, os.time() + 24 * 60 * 60)
				Game.setStorageValue(GlobalStorage.Crandoria.BuffsVictor.Skills, storage3 + 1)
				player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
				npcHandler:say("Buff aplicado! Boa hunt!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao possui o valor necessario.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 5 then
			if player:removeTransferableCoins(prices.coleta) then
				player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffColeta, os.time() + 4 * 60 * 60)
				player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffCooldown, os.time() + 24 * 60 * 60)
				Game.setStorageValue(GlobalStorage.Crandoria.BuffsVictor.Coleta, storage4 + 1)
				player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
				npcHandler:say("Buff aplicado! Boa coleta!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao possui o valor necessario.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 6 then
			if player:removeTransferableCoins(prices.afk) then
				player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffAfk, os.time() + 4 * 60 * 60)
				player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffCooldown, os.time() + 24 * 60 * 60)
				Game.setStorageValue(GlobalStorage.Crandoria.BuffsVictor.Afk, storage5 + 1)
				player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
				npcHandler:say("Buff aplicado! Boa coleta!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao possui o valor necessario.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end

	return true
end

npcHandler:setMessage(MESSAGE_FAREWELL, 'Ate mais!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Adeus!')
npcHandler:setMessage(MESSAGE_GREET, 'Ola, |PLAYERNAME|. Posso te fornecer um {buff} por dia em troca de Tibia Coins.')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)


-- local internalNpcName = "Victor"
-- local npcType = Game.createNpcType(internalNpcName)
-- local npcConfig = {}

-- npcConfig.name = internalNpcName
-- npcConfig.description = internalNpcName

-- npcConfig.health = 100
-- npcConfig.maxHealth = npcConfig.health
-- npcConfig.walkInterval = 2000
-- npcConfig.walkRadius = 2

-- npcConfig.outfit = {
-- 	lookType = 134,
-- 	lookHead = 21,
-- 	lookBody = 78,
-- 	lookLegs = 38,
-- 	lookFeet = 95,
-- 	lookAddons = 3
-- }

-- npcConfig.flags = {
-- 	floorchange = false
-- }

--  local keywordHandler = KeywordHandler:new()
-- local npcHandler = NpcHandler:new(keywordHandler)

-- npcType.onAppear = function(npc, creature)
-- 	npcHandler:onAppear(npc, creature)
-- end

-- npcType.onDisappear = function(npc, creature)
-- 	npcHandler:onDisappear(npc, creature)
-- end

-- npcType.onSay = function(npc, creature, type, message)
-- 	npcHandler:onSay(npc, creature, type, message)
-- end

-- npcType.onCloseChannel = function(npc, creature)
-- 	npcHandler:onCloseChannel(npc, creature)
-- end

-- npcType.onThink = function(npc, interval)
-- 	npcHandler:onThink(npc, interval)
-- end

-- local costXp = math.random(90, 120)
-- local costLoot = math.random(90, 120)
-- local costSkills = math.random(90, 120)
-- local costColeta = math.random(70, 100)
-- local costAfk = math.random(50, 80)

-- local function creatureSayCallback(npc, creature, type, message)
-- 	local player = Player(creature)
-- 	local playerId = player:getId()

-- 	if not npcHandler:checkInteraction(npc, creature) then
-- 		return false
-- 	end

-- 	local storage = player:getStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.Progresso)
-- 	local repStorage = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
-- 	local reset = player:getStorageValue(Storage.Quest.Crandoria.DracantusQuest.KillCount)
-- 	local rep = "Ilustres"

-- 	if repStorage > 174 then
-- 		rep = "Nobres"
-- 	elseif repStorage > 274 then
-- 		rep = "Virtuosos"
-- 	elseif repStorage > 499 then
-- 		rep = "Honrados"
-- 	elseif repStorage > 999 then
-- 		rep = "Lendarios"
-- 	end

-- 	local storageXp = Game.getStorageValue(GlobalStorage.Crandoria.BuffsVictor.Xp)
-- 	local storageLoot = Game.getStorageValue(GlobalStorage.Crandoria.BuffsVictor.Loot)
-- 	local storageSkills = Game.getStorageValue(GlobalStorage.Crandoria.BuffsVictor.Skills)
-- 	local storageColeta = Game.getStorageValue(GlobalStorage.Crandoria.BuffsVictor.Coleta)
-- 	local storageAfk = Game.getStorageValue(GlobalStorage.Crandoria.BuffsVictor.Afk)

-- 	if storageXp < 1 then
-- 		storageXp = 0
-- 	end
-- 	if storageLoot < 1 then
-- 		storageLoot = 0
-- 	end
-- 	if storageSkills < 1 then
-- 		storageSkills = 0
-- 	end
-- 	if storageColeta < 1 then
-- 		storageColeta = 0
-- 	end
-- 	if storageAfk < 1 then
-- 		storageAfk = 0
-- 	end

-- 	local baseXp = costXp
-- 	local baseLoot = costLoot
-- 	local baseSkills = costSkills
-- 	local baseColeta = costColeta
-- 	local baseAfk = costAfk

-- 	local soma = storageXp + storageLoot + storageSkills + storageColeta + storageAfk
-- 	costXp = (baseXp + (storageXp * 5)) - (storageLoot + storageSkills + storageColeta + storageAfk)
-- 	costLoot = (baseLoot + (storageLoot * 5)) - (storageXp + storageSkills + storageColeta + storageAfk)
-- 	costSkills = (baseSkills + (storageSkills * 5)) - (storageXp + storageLoot + storageColeta + storageAfk)
-- 	costColeta = (baseColeta + (storageColeta * 5)) - (storageXp + storageLoot + storageSkills + storageAfk)
-- 	costAfk = (baseAfk + (storageAfk * 5)) - (storageXp + storageLoot + storageSkills + storageColeta)

-- 	local newCostXp = costXp
-- 	local newCostLoot = costLoot
-- 	local newCostSkills = costSkills
-- 	local newCostColeta = costColeta
-- 	local newCostAfk = costAfk

-- 	if storage >= 13 then
-- 		newCostXp = math.floor(costXp / 2)
-- 		newCostLoot = math.floor(costLoot / 2)
-- 		newCostSkills = math.floor(costSkills / 2)
-- 		newCostColeta = math.floor(costColeta / 2)
-- 		newCostAfk = math.floor(costAfk / 2)
-- 	end

-- 	local currentExpBoostTime = player:getExpBoostStamina()
-- 	local timeLeft = math.floor((player:getStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffCooldown) - os.time()) / 60)

-- 	if MsgContains(message, "buff") then
-- 		if player:getStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffCooldown) < os.time() then
-- 			npcHandler:say("Posso te fornecer buff de {experiencia}, de {loot}, de {skills}, de {coleta} e buff {afk} em troca de Tibia Coins. \z
-- 			Membros da {sociedade} pagam a metade do preco em qualquer buff. De qual desses voce gostaria de se beneficiar hoje?", npc, creature)
-- 			npcHandler:setTopic(playerId, 1)
-- 		else
-- 			npcHandler:say("Voce ja utilizou um buff nas ultimas 24 horas. Retorne em "..timeLeft.." minutos se quiser obter outro buff.", npc, creature)
-- 			npcHandler:setTopic(playerId, 0)
-- 		end
-- 	elseif MsgContains(message, "exp") or MsgContains(message, "xp") then
-- 		npcHandler:say("Posso te fornecer 2 horas de +50% Xp por " ..costXp.. " Tibia Coins. O tempo deste buff se somara a qualquer outro buff de potion e Store que voce tiver. Voce aceita?", npc, creature)
-- 		npcHandler:setTopic(playerId, 2)
-- 	elseif MsgContains(message, "loot") then
-- 		npcHandler:say("Posso te fornecer 2 horas com +25% na taxa de Loot por " ..costLoot.. " Tibia Coins. O tempo sera contado continuamente independente de voce estar ativo ou nao. O buff se aplica a bosses e criaturas. Voce aceita?", npc, creature)
-- 		npcHandler:setTopic(playerId, 3)
-- 	elseif MsgContains(message, "skill") then
-- 		npcHandler:say("Posso te fornecer 4 horas de Double Skills por " ..costSkills.. " Tibia Coins. O tempo sera contado continuamente independente de voce estar ativo ou nao. Voce aceita?", npc, creature)
-- 		npcHandler:setTopic(playerId, 4)
-- 	elseif MsgContains(message, "coleta") then
-- 		npcHandler:say("Posso te fornecer retorno em dobro de itens nos sistemas de Farming, Lumberjack, Mining e Fishing por 4 horas pelo valor de " ..costColeta.. " Tibia Coins. O tempo sera contado continuamente independente de voce estar ativo ou nao. Voce aceita?", npc, creature)
-- 		npcHandler:setTopic(playerId, 5)
-- 	elseif MsgContains(message, "afk") then
-- 		npcHandler:say("Posso te deixar por 4 horas sem receber checagens do AntiAfk " ..costAfk.. " Tibia Coins. O tempo sera contado continuamente independente de voce estar ativo ou nao. Voce aceita?", npc, creature)
-- 		npcHandler:setTopic(playerId, 6)
-- 	elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
-- 		if npcHandler:getTopic(playerId) == 2 then
-- 			if player:getExpBoostStamina() < 1 * 60 * 60 then
-- 				if player:removeTransferableCoins(costXp) then
-- 					player:setStoreXpBoost(50)
-- 					player:setExpBoostStamina(currentExpBoostTime + 60 * 60)
-- 					player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffCooldown, os.time() + 24 * 60 * 60)
-- 					npcHandler:say("Buff aplicado! Boa hunt!", npc, creature)
-- 					npcHandler:setTopic(playerId, 0)
-- 				else
-- 					npcHandler:say("Voce nao possui o valor necessario.", npc, creature)
-- 					npcHandler:setTopic(playerId, 0)
-- 				end
-- 			else
-- 				npcHandler:say("Voce nao pode acumular mais de 3 horas de Xp Boost.", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			end
-- 		elseif npcHandler:getTopic(playerId) == 3 then
-- 			if player:removeTransferableCoins(costLoot) then
-- 				player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffLoot, os.time() + 2 * 60 * 60)
-- 				player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffCooldown, os.time() + 24 * 60 * 60)
-- 				npcHandler:say("Buff aplicado! Boa hunt!", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			else
-- 				npcHandler:say("Voce nao possui o valor necessario.", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			end
-- 		elseif npcHandler:getTopic(playerId) == 4 then
-- 			if player:removeTransferableCoins(costSkills) then
-- 				player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffSkills, os.time() + 4 * 60 * 60)
-- 				player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffCooldown, os.time() + 24 * 60 * 60)
-- 				npcHandler:say("Buff aplicado! Boa hunt!", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			else
-- 				npcHandler:say("Voce nao possui o valor necessario.", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			end
-- 		elseif npcHandler:getTopic(playerId) == 5 then
-- 			if player:removeTransferableCoins(costColeta) then
-- 				player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffColeta, os.time() + 4 * 60 * 60)
-- 				player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffCooldown, os.time() + 24 * 60 * 60)
-- 				npcHandler:say("Buff aplicado! Boa coleta!", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			else
-- 				npcHandler:say("Voce nao possui o valor necessario.", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			end
-- 		elseif npcHandler:getTopic(playerId) == 5 then
-- 			if player:removeTransferableCoins(costColeta) then
-- 				player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffAfk, os.time() + 4 * 60 * 60)
-- 				player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffCooldown, os.time() + 24 * 60 * 60)
-- 				npcHandler:say("Buff aplicado! Boa coleta!", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			else
-- 				npcHandler:say("Voce nao possui o valor necessario.", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			end
-- 		end
-- 	end

-- 	return true
-- end

-- npcHandler:setMessage(MESSAGE_FAREWELL, 'Ate mais!')
-- npcHandler:setMessage(MESSAGE_WALKAWAY, 'Adeus!')
-- npcHandler:setMessage(MESSAGE_GREET, 'Ola, |PLAYERNAME|. Posso te fornecer um {buff} por dia em troca de Tibia Coins.')
-- npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
-- npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- -- npcType registering the npcConfig table
-- npcType:register(npcConfig)
