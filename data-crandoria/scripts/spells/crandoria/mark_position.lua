-- local area1 = {
--     fromPosition = {x = 4930, y = 4961, z = 6},
--     toPosition = {x = 4939, y = 4978, z = 6}
-- }

-- local area2 = {
--     fromPosition = {x = 4926, y = 4961, z = 7},
--     toPosition = {x = 4939, y = 4977, z = 7}
-- }

-- local area3 = {
--     fromPosition = {x = 4927, y = 4964, z = 8},
--     toPosition = {x = 4946, y = 4974, z = 8}
-- }

-- local area4 = {
--     fromPosition = {x = 4942, y = 4966, z = 9},
--     toPosition = {x = 4959, y = 4976, z = 9}
-- }

-- local function isInArea(player, area)
--     local playerPos = player:getPosition()
--     return playerPos.x >= area.fromPosition.x and playerPos.x <= area.toPosition.x
--         and playerPos.y >= area.fromPosition.y and playerPos.y <= area.toPosition.y
--         and playerPos.z == area.fromPosition.z
-- end


-- local spell = Spell("instant")

-- function spell.onCastSpell(creature, variant)

-- 	local player = creature:getPlayer()

-- 	local playerPosition = player:getPosition()
-- 	local posX = playerPosition.x
-- 	local posY = playerPosition.y
-- 	local posZ = playerPosition.z

-- 	if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
-- 		player:sendTextMessage(MESSAGE_LOOK, "Voce nao pode marcar posicoes em Viridia.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end

-- 	if isInArea(player, area1) or isInArea(player, area2) or isInArea(player, area3) or isInArea(player, area4) then
-- 		player:sendTextMessage(MESSAGE_LOOK, "Voce nao pode usar essa magia aqui.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end

-- 	if player:getStorageValue(Storage.Quest.Crandoria.TeleportRune.Progresso) < 3 then
-- 		player:sendTextMessage(MESSAGE_LOOK, "Voce ainda nao aprendeu como utilizar este encantamento.")
-- 		playerPosition:sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end

-- 	if posZ ~= 7 then		
-- 		player:sendTextMessage(MESSAGE_LOOK, "Voce so pode marcar pontos que estiverem no nível do mar.")
-- 		playerPosition:sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end

-- 	if player:getTile():getHouse() then
-- 		player:sendTextMessage(MESSAGE_LOOK, "Voce nao pode marcar uma posição em uma casa.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end

-- 	if Tile(player:getPosition()):hasFlag(TILESTATE_NOLOGOUT) then
-- 		player:sendTextMessage(MESSAGE_LOOK, "Voce nao pode usar essa magia aqui.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end

-- 	if Tile(player:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) then
-- 		player:sendTextMessage(MESSAGE_LOOK, "Voce nao pode marcar uma area pz (Protection Zone).")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end

-- 	if player:getStorageValue(Storage.Quest.Crandoria.PvpStatus.Status) == 2 then
-- 		player:sendTextMessage(MESSAGE_LOOK, "Voce nao pode marcar pontos em hunts de Gold Token.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end

-- 	if player:getSkull() == WHITE_SKULL or player:getSkull() == RED_SKULL or player:getSkull() == BLACK_SKULL then
-- 		player:sendTextMessage(MESSAGE_LOOK, "Voce nao pode usar essa magia com uma Skull ativada.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end

-- 	if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
-- 		player:sendTextMessage(MESSAGE_LOOK, "Voce nao pode marcar posicoes em Viridia.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return false
-- 	end

-- 	player:setStorageValue(Storage.Quest.Crandoria.TeleportRune.PosX, posX)
-- 	player:setStorageValue(Storage.Quest.Crandoria.TeleportRune.PosY, posY)
-- 	player:setStorageValue(Storage.Quest.Crandoria.TeleportRune.PosZ, posZ)
-- 	player:sendTextMessage(MESSAGE_LOOK, "Voce marcou sua localizacao.")
-- 	playerPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
-- 	return true
-- end

-- spell:name("Mark Position")
-- spell:words("utevo tempo grav")
-- spell:group("support")
-- spell:vocation("druid;true", "elder druid;true", "knight;true", "elite knight;true", "paladin;true", "royal paladin;true", "sorcerer;true", "master sorcerer;true", "guardian;true", "celestial guardian;true", "summoner;true", "ancient summoner;true")
-- spell:castSound(SOUND_EFFECT_TYPE_SPELL_FIND_PERSON)
-- spell:id(345)
-- spell:cooldown(15 * 60 * 1000)
-- spell:groupCooldown(2 * 1000)
-- spell:level(300)
-- spell:mana(400)
-- spell:isAggressive(false)
-- spell:needLearn(false)
-- spell:register()
