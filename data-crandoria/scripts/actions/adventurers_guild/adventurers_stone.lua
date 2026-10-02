local setting = {
	{fromPos = Position(4996, 4991, 6), toPos = Position(5005, 5004, 6), townId = TOWNS_LIST.CRANDORIA},
	{fromPos = Position(4670, 4773, 8), toPos = Position(4690, 4788, 8), townId = TOWNS_LIST.ELVENSHIRE},
	{fromPos = Position(5558, 5106, 7), toPos = Position(5569, 5118, 7), townId = TOWNS_LIST.HAKATA},
	{fromPos = Position(5372, 4672, 7), toPos = Position(5390, 4680, 7), townId = TOWNS_LIST.VALKESH},
	{fromPos = Position(5080, 4464, 5), toPos = Position(5091, 4473, 5), townId = TOWNS_LIST.CHAOS},
	{fromPos = Position(4726, 5224, 4), toPos = Position(4738, 5230, 4), townId = TOWNS_LIST.MAGINCIA},
	{fromPos = Position(5031, 5399, 5), toPos = Position(5040, 5402, 5), townId = TOWNS_LIST.ICEHOLD},
	{fromPos = Position(5842, 5031, 6), toPos = Position(5846, 5035, 6), townId = TOWNS_LIST.ROSHAMUUL},
	{fromPos = Position(5730, 4514, 7), toPos = Position(5737, 4520, 7), townId = TOWNS_LIST.NIVABI}
}

local adventurersStone = Action()

function adventurersStone.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Jogadores de Viridia nao podem ir para a Adventurers Island.')
		return true
	end

	local playerPos, isInTemple, temple, townId = player:getPosition(), false
	for i = 1, #setting do
		temple = setting[i]
		if playerPos:isInRange(temple.fromPos, temple.toPos) then
			if Tile(playerPos):hasFlag(TILESTATE_PROTECTIONZONE) then
				isInTemple, townId = true, temple.townId
				break
			end
		end
	end

	if not isInTemple then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Try to move more to the center of a temple to use the spiritual energy for a teleport.')
		return true
	end

	player:setStorageValue(Storage.Quest.U9_80.AdventurersGuild.Stone, townId)
	playerPos:sendMagicEffect(CONST_ME_TELEPORT)

	local destination = Position(5040, 5129, 7)
		player:teleportTo(destination)
		destination:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

adventurersStone:id(16277)
adventurersStone:register()
