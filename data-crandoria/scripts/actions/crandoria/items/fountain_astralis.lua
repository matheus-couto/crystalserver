local fountainAstralis = Action()

function fountainAstralis.onUse(player, item, fromPosition, target, toPosition, monster, isHotkey)

	if not player then
        return true
    end

	if player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points) >= 175 then
		if player:getStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.Fountain) < os.time() then
			local stamina = player:getStamina()
			if stamina >= 2520 then
				player:sendCancelMessage("Sua stamina ja esta completa.")
				return true
			else
				player:setStamina(math.min(2520, stamina + 60))
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce regenerou parte da sua stamina.")
				if player:getStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.Progresso) >= 13 then
					player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.Fountain, os.time() + 24 * 60 * 60)
				else
					player:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.Fountain, os.time() + 72 * 60 * 60)
				end
				return true
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce utilizou a fonte ha pouco tempo.")
			return true
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Obtenha reputacao Nobre ou superior para utilizar a Fonte.")
		return true
	end
	return true
end
			

fountainAstralis:aid(13196)
fountainAstralis:register()