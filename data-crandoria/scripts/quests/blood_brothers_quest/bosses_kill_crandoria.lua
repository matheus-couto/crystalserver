local vengothDeaths = CreatureEvent("vengothDeaths")

function vengothDeaths.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
	if not creature then
		return
	end

	if creature:getName():lower() ~= "Arthei" and creature:getName():lower() ~= "Boreth" or creature:getName():lower() ~= "Lersatio" or creature:getName():lower() ~= "Marziel" or creature:getName():lower() ~= "Zevelon Duskbringer" then
		return
	end

	local arthei = player:getStorageValue(Storage.Quest.U8_4.BloodBrothers.ArtheiDoor)
	local boreth = player:getStorageValue(Storage.Quest.U8_4.BloodBrothers.BorethDoor)
	local lesartio = player:getStorageValue(Storage.Quest.U8_4.BloodBrothers.LersatioDoor)
	local marziel = player:getStorageValue(Storage.Quest.U8_4.BloodBrothers.MarzielDoor)
	local zevelon = player:getStorageValue(Storage.Quest.U8_4.BloodBrothers.ZevelonKill)

	local storage = player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.Questline)

	local damageMap = creature:getMonster():getDamageMap()
	for key, value in pairs(damageMap) do
		local player = Player(key)
		if player then
			if storage == 1 then
				if creature:getName():lower() == "Arthei" then
					if arthei < 1 then
						player:setStorageValue(Storage.Quest.U8_4.BloodBrothers.ArtheiDoor, 1)
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Arthei.")
					end
				elseif reature:getName():lower() == "Boreth" then
					if boreth < 1 then
						player:setStorageValue(Storage.Quest.U8_4.BloodBrothers.BorethDoor, 1)
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Boreth.")
					end
				elseif reature:getName():lower() == "Lersatio" then
					if lesartio < 1 then
						player:setStorageValue(Storage.Quest.U8_4.BloodBrothers.LersatioDoor, 1)
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Boreth.")
					end
				elseif reature:getName():lower() == "Marziel" then
					if marziel < 1 then
						player:setStorageValue(Storage.Quest.U8_4.BloodBrothers.MarzielDoor, 1)
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Marziel.")
					end
				end
			elseif storage == 2 then
				if creature:getName():lower() == "Zevelon Duskbringer" then
					if zevelon < 1 then
						player:setStorageValue(Storage.Quest.U8_4.BloodBrothers.ZevelonKill, 1)
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Zevelon.")
					end
				end
			end
		end
	end
end

vengothDeaths:register()