local bossDisputaKill = CreatureEvent("bossDisputaKill")

function bossDisputaKill.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
	if not creature or not creature:getMonster() or creature:getName() ~= "Crystalog" or creature:getName() ~= "Shockanog" or creature:getName() ~= "Flamanzog" or creature:getName() ~= "Multog" then
		return
	end

	local pos = creature:getPosition()
	local storageBossGlobal = player:getStorageValue(Storage.Quest.Crandoria.EventoProgramado.BossGlobal)

	local damageMap = creature:getMonster():getDamageMap()

	pos:sendMagicEffect(CONST_ME_FIREWORK_YELLOW)

	for key, _ in pairs(damageMap) do
		local player = Player(key)
		if player then
			local storageReward = player:getStorageValue(Storage.Crandoria.EventoProgramago.RewardDisputa)
			if storageBossGlobal >= 1 then
				player:getStorageValue(Storage.Crandoria.EventoProgramago.RewardDisputa, 2)
				player:setStorageValue(Storage.Quest.Crandoria.DonateRewards.PalacioAccesso, os.time() + 7 * 24 * 60 * 60)
				player:sendTextMessage("Parabens! Seu time venceu o torneio. Resgate suas recompensas no Bau de Eventos no Templo de Crandoria.")
			else
				player:sendTextMessage("Seu time ficou em segundo lugar no torneio desta semana. Resgate suas recompensas de participacao no Bau de Eventos.")
			end
		end
	end

	if storageBossGlobal >= 1 then
		addEvent(function()
			player:getStorageValue(Storage.Quest.Crandoria.EventoProgramado.BossGlobal, 0)
			if pos.x < 4329 and pos.x > 4305 then
				Game.broadcastMessage("O boss foi derrotado e o time Vermelho venceu a Disputa do Poder! Evento encerrado.", MESSAGE_EVENT_ADVANCE)
			elseif pos.x > 4329 and pos.x < 4352 then
				Game.broadcastMessage("O boss foi derrotado e o time Azul venceu a Disputa do Poder! Evento encerrado.", MESSAGE_EVENT_ADVANCE)
			end
		end, 250)
	end


	return true
end

bossDisputaKill:register()