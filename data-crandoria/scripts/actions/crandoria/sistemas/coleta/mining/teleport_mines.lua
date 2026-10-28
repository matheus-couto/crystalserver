local teleportMines = MoveEvent()

local accessedIPs = {}

function teleportMines.onStepIn(player, item, position, fromPosition)

	local playerIP = player:getIp()

	if accessedIPs[playerIP] and accessedIPs[playerIP] ~= player:getGuid() then
		player:sendTextMessage(MESSAGE_STATUS_SMALL, "Voce so pode acessar as minas com um personagem diariamente.")
		player:teleportTo(Position(4729, 4572, 7))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end

	if player:getLevel() < 200 then
		player:sendTextMessage(MESSAGE_STATUS_SMALL, "Voce precisa ter nivel 200 ou superior para acessar as minas.")
		player:teleportTo(Position(4729, 4572, 7))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end

	if player:getStorageValue(Storage.Quest.Crandoria.ForgeSystem.AutoMining) > os.time() or player:getVipDays() > 0 or player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.MiningLevel) >= 50 then
		player:teleportTo(Position(4335, 4480, 10))
		accessedIPs[playerIP] = player:getGuid()
		return true
	else
		player:teleportTo(Position(4729, 4572, 7))
		player:say("Converse com Taburok para obter acesso as minas.", TALKTYPE_MONSTER_SAY)
		return true
	end
end

teleportMines:aid(13071)
teleportMines:register()