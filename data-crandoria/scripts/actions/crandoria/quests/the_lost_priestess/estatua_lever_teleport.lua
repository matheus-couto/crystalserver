local config = {
	{
		fromPosition = Position(4869, 4509, 15),
		toPosition = Position(4869, 4494, 15),
		sacrificePosition = Position(4867, 4509, 15),
		sacrificeId = 3319,
		vocationIds = { VOCATION.BASE_ID.KNIGHT, VOCATION.BASE_ID.CELESTIAL_GUARDIAN }
	},
	{
		fromPosition = Position(4869, 4510, 15),
		toPosition = Position(4869, 4494, 15),
		sacrificePosition = Position(4867, 4510, 15),
		sacrificeId = 14769,
		vocationIds = { VOCATION.BASE_ID.DRUID, VOCATION.BASE_ID.ANCIENT_SUMMONER }
	},
	{
		fromPosition = Position(4869, 4511, 15),
		toPosition = Position(4869, 4494, 15),
		sacrificePosition = Position(4867, 4511, 15),
		sacrificeId = 8062,
		vocationIds = { VOCATION.BASE_ID.SORCERER, VOCATION.BASE_ID.ANCIENT_SUMMONER }
	},
	{
		fromPosition = Position(4869, 4512, 15),
		toPosition = Position(4869, 4494, 15),
		sacrificePosition = Position(4867, 4512, 15),
		sacrificeId = 8060,
		vocationIds = { VOCATION.BASE_ID.PALADIN, VOCATION.BASE_ID.CELESTIAL_GUARDIAN }
	},
	{
		fromPosition = Position(4869, 4513, 15),
		toPosition = Position(4869, 4494, 15),
		sacrificePosition = Position(4867, 4513, 15),
		sacrificeId = 50275,
		vocationIds = { VOCATION.BASE_ID.PALADIN, VOCATION.BASE_ID.CELESTIAL_GUARDIAN }
	},
}

local othersDesert = Action()
function othersDesert.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	item:transform(item.itemid == 8911 and 8912 or 8911)

	if item.itemid ~= 8911 then
		return true
	end

	local position = player:getPosition()

	local players = {}
	for i = 1, #config do
		local creature = Tile(config[i].fromPosition):getTopCreature()
		if not creature or not creature:isPlayer() then
			player:sendCancelMessage("Um personagem de cada vocacao sera necessario.")
			position:sendMagicEffect(CONST_ME_POFF)
			return true
		end

		local vocationId = creature:getVocation():getBaseId()
		if not table.contains(config[i].vocationIds, vocationId) then
			player:sendCancelMessage("Um personagem de cada vocacao sera necessario.")
			position:sendMagicEffect(CONST_ME_POFF)
			return true
		end

		local sacrificeItem = Tile(config[i].sacrificePosition):getItemById(config[i].sacrificeId)
		if not sacrificeItem then
			player:sendCancelMessage(creature:getName() .. " nao possui 1 " .. creature:getPossessivePronoun() .. " para ser sacrificado no altar.")
			position:sendMagicEffect(CONST_ME_POFF)
			return true
		end

		players[#players + 1] = creature
	end

	for i = 1, #players do
		local sacrificeItem = Tile(config[i].sacrificePosition):getItemById(config[i].sacrificeId)
		if sacrificeItem then
			sacrificeItem:remove()
		end

		players[i]:getPosition():sendMagicEffect(CONST_ME_POFF)
		players[i]:teleportTo(config[i].toPosition)
        players[i]:setStorageValue(Storage.Quest.Crandoria.TheLostPriestess.Shortcut, 1)
		config[i].toPosition:sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
end

othersDesert:aid(12315)
othersDesert:register()


-- BACKUP CRANDORIA

-- local config = {
-- 	{
-- 		fromPosition = Position(4869, 4509, 15),
-- 		toPosition = Position(4869, 4494, 15),
-- 		sacrificePosition = Position(4867, 4509, 15),
-- 		sacrificeId = 3319,
-- 		vocationId = VOCATION.BASE_ID.KNIGHT,
-- 	},
-- 	{
-- 		fromPosition = Position(4869, 4510, 15),
-- 		toPosition = Position(4869, 4494, 15),
-- 		sacrificePosition = Position(4867, 4510, 15),
-- 		sacrificeId = 14769,
-- 		vocationId = VOCATION.BASE_ID.DRUID,
-- 	},
-- 	{
-- 		fromPosition = Position(4869, 4511, 15),
-- 		toPosition = Position(4869, 4494, 15),
-- 		sacrificePosition = Position(4867, 4511, 15),
-- 		sacrificeId = 8062,
-- 		vocationId = VOCATION.BASE_ID.SORCERER,
-- 	},
-- 	{
-- 		fromPosition = Position(4869, 4512, 15),
-- 		toPosition = Position(4869, 4494, 15),
-- 		sacrificePosition = Position(4867, 4512, 15),
-- 		sacrificeId = 8060,
-- 		vocationId = VOCATION.BASE_ID.PALADIN,
-- 	},
-- }

-- local othersDesert = Action()
-- function othersDesert.onUse(player, item, fromPosition, target, toPosition, isHotkey)
-- 	item:transform(item.itemid == 8911 and 8912 or 8911)

-- 	if item.itemid ~= 8911 then
-- 		return true
-- 	end

-- 	local position = player:getPosition()

-- 	local players = {}
-- 	for i = 1, #config do
-- 		local creature = Tile(config[i].fromPosition):getTopCreature()
-- 		if not creature or not creature:isPlayer() then
-- 			player:sendCancelMessage("You need one player of each vocation for this quest.")
-- 			position:sendMagicEffect(CONST_ME_POFF)
-- 			return true
-- 		end

-- 		local vocationId = creature:getVocation():getBaseId()
-- 		if vocationId ~= config[i].vocationId then
-- 			player:sendCancelMessage("You need one player of each vocation for this quest.")
-- 			position:sendMagicEffect(CONST_ME_POFF)
-- 			return true
-- 		end

-- 		local sacrificeItem = Tile(config[i].sacrificePosition):getItemById(config[i].sacrificeId)
-- 		if not sacrificeItem then
-- 			player:sendCancelMessage(creature:getName() .. " is missing " .. creature:getPossessivePronoun() .. " sacrifice on the altar.")
-- 			position:sendMagicEffect(CONST_ME_POFF)
-- 			return true
-- 		end

-- 		players[#players + 1] = creature
-- 	end

-- 	for i = 1, #players do
-- 		local sacrificeItem = Tile(config[i].sacrificePosition):getItemById(config[i].sacrificeId)
-- 		if sacrificeItem then
-- 			sacrificeItem:remove()
-- 		end

-- 		players[i]:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		players[i]:teleportTo(config[i].toPosition)
--         players[i]:setStorageValue(Storage.Quest.Crandoria.TheLostPriestess.Shortcut, 1)
-- 		config[i].toPosition:sendMagicEffect(CONST_ME_TELEPORT)
-- 	end
-- 	return true
-- end

-- othersDesert:aid(12315)
-- othersDesert:register()