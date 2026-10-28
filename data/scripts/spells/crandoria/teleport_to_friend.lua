-- local spell = Spell("instant")

-- -- Descobre o jogador mencionado. Aceita variant por id (numero) ou por nome (texto),
-- -- porque isso varia entre forks.
-- local function getTargetPlayer(variant)
-- 	local id = variant:getNumber()
-- 	if id and id > 0 then
-- 		local byId = Player(id)
-- 		if byId then
-- 			return byId
-- 		end
-- 	end

-- 	local name = variant:getString()
-- 	if name and name ~= "" then
-- 		return Player(name)
-- 	end

-- 	return nil
-- end

-- local function isOnNoLogoutTile(player)
-- 	local tile = Tile(player:getPosition())
-- 	return tile ~= nil and tile:hasFlag(TILESTATE_NOLOGOUT)
-- end

-- -- Sorteia um tile livre ao redor (x +/- 1, y +/- 1) do centro
-- local function getFreeTileAround(center)
-- 	local free = {}
-- 	for dx = -1, 1 do
-- 		for dy = -1, 1 do
-- 			if dx ~= 0 or dy ~= 0 then
-- 				local pos = Position(center.x + dx, center.y + dy, center.z)
-- 				local tile = Tile(pos)
-- 				if tile
-- 					and tile:getCreatureCount() == 0
-- 					and not tile:hasFlag(TILESTATE_BLOCKSOLID)
-- 					and not tile:hasFlag(TILESTATE_FLOORCHANGE)
-- 					and not tile:hasFlag(TILESTATE_NOLOGOUT) then
-- 					free[#free + 1] = pos
-- 				end
-- 			end
-- 		end
-- 	end

-- 	if #free == 0 then
-- 		return nil
-- 	end
-- 	return free[math.random(#free)]
-- end

-- function spell.onCastSpell(creature, variant)
-- 	local player = creature:getPlayer()
-- 	if not player then
-- 		return false
-- 	end

-- 	local storage = player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso)
-- 	if storage < 229 then
-- 		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao sabe como usar essa spell.")
-- 		return false
-- 	end

-- 	local party = player:getParty()
-- 	if not party then
-- 		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce so pode usar essa Spell com um membro da sua Party.")
-- 		return false
-- 	end

-- 	local target = getTargetPlayer(variant)
-- 	if not target or target:getId() == player:getId() then
-- 		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Informe o nome de um membro da sua Party.")
-- 		return false
-- 	end

-- 	-- Mesma party: compara pelo lider, que e unico por party
-- 	local targetParty = target:getParty()
-- 	if not targetParty or targetParty:getLeader():getId() ~= party:getLeader():getId() then
-- 		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce so pode usar essa Spell com um membro da sua Party.")
-- 		return false
-- 	end

-- 	if not Tile(player:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) and (player:isPzLocked() or player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)) then
--         player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao pode usar essa Spell em batalha.")
--         player:getPosition():sendMagicEffect(CONST_ME_POFF)
--         return true
--     end

-- 	if not Tile(target:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) and (target:isPzLocked() or target:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)) then
--         player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao pode usar essa Spell se seu alvo esta em batalha.")
--         player:getPosition():sendMagicEffect(CONST_ME_POFF)
--         return true
--     end

-- 	if isOnNoLogoutTile(player) or isOnNoLogoutTile(target) then
-- 		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ou " .. target:getName() .. " esta em um local onde essa Spell nao pode ser usada.")
-- 		return false
-- 	end

-- 	local destination = getFreeTileAround(target:getPosition())
-- 	if not destination then
-- 		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nao ha espaco livre ao lado de " .. target:getName() .. ".")
-- 		return false
-- 	end

-- 	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
-- 	player:teleportTo(destination)
-- 	destination:sendMagicEffect(CONST_ME_TELEPORT)
-- 	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce se teleportou para perto de " .. target:getName() .. ".")
-- 	return true
-- end

-- spell:name("Teleport to Friend")
-- spell:words("exeta sio")
-- spell:group("healing")
-- spell:vocation("druid;true", "elder druid;true")
-- spell:castSound(SOUND_EFFECT_TYPE_SPELL_HEAL_FRIEND)
-- spell:id(503)
-- spell:cooldown(1800 * 1000)
-- spell:groupCooldown(1000)
-- spell:level(500)
-- spell:mana(1000)
-- spell:needTarget(false)
-- spell:hasParams(true)
-- spell:hasPlayerNameParam(true)
-- spell:allowOnSelf(false)
-- spell:isAggressive(false)
-- spell:isPremium(true)
-- spell:register()
