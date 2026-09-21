-- local internalNpcName = "Oraculo de Viridia"
-- local npcType = Game.createNpcType(internalNpcName)
-- local npcConfig = {}

-- npcConfig.name = internalNpcName
-- npcConfig.description = internalNpcName

-- npcConfig.health = 100
-- npcConfig.maxHealth = npcConfig.health
-- npcConfig.walkInterval = 0
-- npcConfig.walkRadius = 2

-- npcConfig.outfit = {
-- 	lookTypeEx = 2031
-- }

-- npcConfig.flags = {
-- 	floorchange = false
-- }

-- local keywordHandler = KeywordHandler:new()
-- local npcHandler = NpcHandler:new(keywordHandler)

-- npcType.onThink = function(npc, interval)
-- 	npcHandler:onThink(npc, interval)
-- end

-- npcType.onAppear = function(npc, creature)
-- 	npcHandler:onAppear(npc, creature)
-- end

-- npcType.onDisappear = function(npc, creature)
-- 	npcHandler:onDisappear(npc, creature)
-- end

-- npcType.onMove = function(npc, creature, fromPosition, toPosition)
-- 	npcHandler:onMove(npc, creature, fromPosition, toPosition)
-- end

-- npcType.onSay = function(npc, creature, type, message)
-- 	npcHandler:onSay(npc, creature, type, message)
-- end

-- npcType.onCloseChannel = function(npc, creature)
-- 	npcHandler:onCloseChannel(npc, creature)
-- end


-- local function greetCallback(npc, creature)
-- 	local playerId = creature:getId()
-- 	local player = Player(creature)
-- 	local level = player:getLevel()
-- 	-- if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Egresso) == 1 then
-- 	-- 	npcHandler:say("VOCE JA TEVE SUA CHANCE EM CRANDORIA!", npc, creature)
-- 	-- 	npcHandler:resetNpc(creature)
-- 	-- 	return false
-- 	-- else
-- 		if level < 8 then
-- 			npcHandler:say("VOCE PRECISA TER NIVEL ENTRE 8 E 50 PARA ESSE TESTE.", npc, creature)
-- 			npcHandler:resetNpc(creature)
-- 			return false
-- 		elseif level > 50 then
-- 			npcHandler:say(player:getName() ..", VOCE NAO PODE SEGUIR ESTE CAMINHO - JA ESTA FORTE DEMAIS! \z
-- 			VOCE SO PODERA ASCENDER SE TIVER NIVEL ENTRE 8 E 50.", npc, creature)
-- 			npcHandler:resetNpc(creature)
-- 			return false
-- 		else
-- 			npcHandler:setMessage(MESSAGE_GREET, player:getName() ..", ESTA PREPARADO PARA UM NOVO CAMINHO?")
-- 		end
-- 	-- end
-- 	return true
-- end

-- local function creatureSayCallback(npc, creature, type, message)
-- 	local player = Player(creature)
-- 	local playerId = player:getId()
-- 	local vocation = player:getVocation():getBaseId()
-- 	local baseVocation = Vocation(VOCATION.ID.NONE)

-- 	if not npcHandler:checkInteraction(npc, creature) then
-- 		return false
-- 	end

-- 	if npcHandler:getTopic(playerId) == 0 then
-- 		if (MsgContains(message, "yes") or MsgContains(message, "sim")) and (vocation == VOCATION.BASE_ID.DRUID or vocation == VOCATION.BASE_ID.SORCERER) then
-- 			npcHandler:say("QUE ESCOLHA CORAJOSA \z
-- 			VOCE DESEJA MUDAR SEU CAMINHO E SE TORNAR UM SUMMONER?", npc, creature)
-- 			npcHandler:setTopic(playerId, 2)
-- 		elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) and (vocation == VOCATION.BASE_ID.KNIGHT or vocation == VOCATION.BASE_ID.PALADIN) then
-- 			npcHandler:say("QUE ESCOLHA CORAJOSA \z
-- 			VOCE DESEJA MUDAR SEU CAMINHO E SE TORNAR UM GUARDIAN?", npc, creature)
-- 			npcHandler:setTopic(playerId, 3)
-- 		end
-- 	elseif npcHandler:getTopic(playerId) == 2 then
-- 		if (MsgContains(message, "yes") or MsgContains(message, "sim")) then
-- 			npcHandler:say("VOCE TEM CERTEZA? ESSA DECISAO SERA DEFINITIVA! \z
-- 			RETIRE TODOS OS SEUS EQUIPAMENTOS E DIGA {SIM} PARA CONTNUAR.", npc, creature)
-- 			npcHandler:setTopic(playerId, 4)
-- 		end
-- 	elseif npcHandler:getTopic(playerId) == 3 then
-- 		if (MsgContains(message, "yes") or MsgContains(message, "sim")) then
-- 			npcHandler:say("VOCE TEM CERTEZA? ESSA DECISAO SERA DEFINITIVA! \z
-- 			RETIRE TODOS OS SEUS EQUIPAMENTOS E DIGA {SIM} PARA CONTNUAR.", npc, creature)
-- 			npcHandler:setTopic(playerId, 5)
-- 		end
-- 	elseif npcHandler:getTopic(playerId) == 4 then
-- 		if (MsgContains(message, "yes") or MsgContains(message, "sim")) and player:getSlotItem(CONST_SLOT_LEFT) == nil and player:getSlotItem(CONST_SLOT_RIGHT) == niL and player:getSlotItem(CONST_SLOT_HEAD) == niL and player:getSlotItem(CONST_SLOT_ARMOR) == niL and player:getSlotItem(CONST_SLOT_FEET) == niL and player:getSlotItem(CONST_SLOT_LEGS) == niL and player:getSlotItem(CONST_SLOT_NECKLACE) == niL and player:getSlotItem(CONST_SLOT_RING) == niL and player:getSlotItem(CONST_SLOT_AMMO) == niL and #player:getSummons() < 1 then
-- 			npcHandler:say("ESTA FEITO!", npc, creature)
-- 			player:setVocation(VOCATION.ID.ANCIENT_SUMMONER)
-- 			player:setLevel(8)
-- 			player:setMaxMana(90)
-- 			player:setMaxHealth(185)
-- 			player:setCapacity((7 * baseVocation:getCapacityGain()) + (level * player:getVocation():getCapacityGain()) + 40000)
-- 			player:kv():get("promoted")
-- 			player:remove() -- CRANDORIAEDIT
-- 		else
-- 			npcHandler:say("VOCE NAO PODE TER NENHUM ITEM EQUIPADO NEM TER SUMMONS INVOCADOS PARA ESSE TESTE, JOVEM. ESTA TUDO PRONTO?", npc, creature)
-- 			npcHandler:setTopic(playerId, 4)
-- 		end
-- 	elseif npcHandler:getTopic(playerId) == 5 then
-- 		if (MsgContains(message, "yes") or MsgContains(message, "sim")) and player:getSlotItem(CONST_SLOT_LEFT) == nil and player:getSlotItem(CONST_SLOT_RIGHT) == niL and player:getSlotItem(CONST_SLOT_HEAD) == niL and player:getSlotItem(CONST_SLOT_ARMOR) == niL and player:getSlotItem(CONST_SLOT_FEET) == niL and player:getSlotItem(CONST_SLOT_LEGS) == niL and player:getSlotItem(CONST_SLOT_NECKLACE) == niL and player:getSlotItem(CONST_SLOT_RING) == niL and player:getSlotItem(CONST_SLOT_AMMO) == niL and #player:getSummons() < 1 then
-- 			npcHandler:say("ESTA FEITO!", npc, creature)
-- 			player:setVocation(VOCATION.ID.CELESTIAL_GUARDIAN)
-- 			player:setLevel(8)
-- 			player:setMaxMana(90)
-- 			player:setMaxHealth(185)
-- 			player:setCapacity((7 * baseVocation:getCapacityGain()) + (level * player:getVocation():getCapacityGain()) + 40000)
-- 			player:kv():get("promoted")
-- 			player:remove() -- CRANDORIAEDIT
-- 		else
-- 			npcHandler:say("VOCE NAO PODE TER NENHUM ITEM EQUIPADO NEM TER SUMMONS INVOCADOS PARA ESSE TESTE, JOVEM. ESTA TUDO PRONTO?", npc, creature)
-- 			npcHandler:setTopic(playerId, 5)
-- 		end
-- 	end
-- 	return true
-- end

-- npcHandler:setCallback(CALLBACK_SET_INTERACTION, onAddFocus)
-- npcHandler:setCallback(CALLBACK_REMOVE_INTERACTION, onReleaseFocus)
-- npcHandler:setCallback(CALLBACK_GREET, greetCallback)
-- npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- npcHandler:setMessage(MESSAGE_FAREWELL, "RETORNE QUANDO ESTIVER PRONTO PARA ENFRENTAR SEU DESTINO!")
-- npcHandler:setMessage(MESSAGE_WALKAWAY, "RETORNE QUANDO ESTIVER PRONTO PARA ENFRENTAR SEU DESTINO!")

-- npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- -- npcType registering the npcConfig table
-- npcType:register(npcConfig)