	local setting = {
	centerRoom = {x = 4830, y = 4479, z = 9},
	storage = Storage.Quest.U11_80.TheSecretLibrary.FalconBastion.OberonCrandoriaTimer,
	Pillar1pos = {x = 4827, y = 4477, z = 9},
	bossPosition = {x = 4830, y = 4478, z = 9},
	kickPosition = {x = 4766, y = 4450, z = 9},
	playerTeleport = {x = 4830, y = 4483, z = 9}
}

local oberonLever = Action()

-- Start Script 
function oberonLever.onUse(creature, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 2772 and item.actionid == 57605 then
		if creature:getStorageValue(Storage.Quest.U11_80.TheSecretLibrary.FalconBastion.OberonCrandoriaTimer) > os.time() then
			creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Grand Master Oberon so pode ser enfrentado a cada 20 horas.")
			creature:getPosition():sendMagicEffect(CONST_ME_POFF)
			return false
		end

		local clearOberonRoom = Game.getSpectators(Position(setting.centerRoom), false, false, 10, 10, 10, 10)
		for index, spectatorcheckface in ipairs(clearOberonRoom) do
			if spectatorcheckface:isPlayer() then
				creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Someone is fighting against the boss! You need wait awhile.")
				return false
			end
		end
		for index, removeOberon in ipairs(clearOberonRoom) do
			if (removeOberon:isMonster()) then
				removeOberon:remove()
			end
		end
		Game.createMonster("Grand Master Oberon", setting.bossPosition, false, true)
		Game.createMonster("Oberon's Bile", Position({x = setting.Pillar1pos.x, y = setting.Pillar1pos.y, z = setting.Pillar1pos.z}), false, true)
		Game.createMonster("Oberon's Hate", Position({x = setting.Pillar1pos.x + 6, y = setting.Pillar1pos.y, z = setting.Pillar1pos.z}), false, true)
		Game.createMonster("Oberon's Spite", Position({x = setting.Pillar1pos.x, y = setting.Pillar1pos.y + 4, z = setting.Pillar1pos.z}), false, true)
		Game.createMonster("Oberon's Ire", Position({x = setting.Pillar1pos.x + 6, y = setting.Pillar1pos.y + 4, z = setting.Pillar1pos.z}), false, true)
		local players = {}
		for i = 0, 4 do
			local player1 = Tile({x = (Position(item:getPosition()).x - 2) + i, y = Position(item:getPosition()).y + 1, z = Position(item:getPosition()).z}):getTopCreature()
			players[#players+1] = player1
		end
		local ipCount = {}
		for _, p in ipairs(players) do
			if p and p:isPlayer() then
				local ip = Game.convertIpToString(p:getIp())
				ipCount[ip] = (ipCount[ip] or 0) + 1
				if ipCount[ip] > 2 then
					p:sendTextMessage(MESSAGE_EVENT_ADVANCE, "No maximo 2 personagens do mesmo jogador sao permitidos.")
					for _, affected in ipairs(players) do
						if affected and affected:isPlayer() then
							affected:getPosition():sendMagicEffect(CONST_ME_POFF)
						end
					end
					return true
				end
			end
		end




		for i, player in ipairs(players) do
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			player:teleportTo(Position(setting.playerTeleport), false)
			doSendMagicEffect(player:getPosition(), CONST_ME_TELEPORT)
			player:setStorageValue(Storage.Quest.U11_80.TheSecretLibrary.FalconBastion.OberonTimer, os.time() + 20 * 60)
			player:setStorageValue(Storage.Quest.U11_80.TheSecretLibrary.FalconBastion.OberonCrandoriaTimer, os.time() + 20 * 60 * 60)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have 20 minute(s) to defeat the boss.')
			addEvent(function(cid)
				local playerToRemove = Player(cid)
				if playerToRemove then
					local playerToRemovePosition = playerToRemove:getPosition()
					local leftTopCorner = Position(setting.centerRoom.x - 10, setting.centerRoom.y - 10, setting.centerRoom.z)
					local rightBottomCorner = Position(setting.centerRoom.x + 10, setting.centerRoom.y + 10, setting.centerRoom.z)
					if playerToRemovePosition:isInRange(leftTopCorner, rightBottomCorner) then
						playerToRemove:teleportTo(Position(setting.kickPosition))
						playerToRemove:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
						playerToRemove:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Time is over.')
					end
				end
			end, 20 * 60 * 1000, player:getId())
		end
	end
	return true
end

oberonLever:aid(57605)
oberonLever:register()
