local torchesViridia = Action()

function torchesViridia.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if item.itemid == 25661 then
		if item:getPosition() == Position(4702, 5349, 7) then
			if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.TimerQuest) > os.time() then 
				if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) == 1 then
					item:transform(25660)
					player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce acendeu o primeiro farol.")
					player:say("Voce acendeu o primeiro farol.", TALKTYPE_MONSTER_SAY)
					addEvent(function()
						item:transform(25661)
					end, 60 * 1000)
					player:setStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao, 2)
					return true
				elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) > 1 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) < 10 then
					player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce ja acendeu este farol.")
					return true
				else
					player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce nao esta nessa missao.")
					return true
				end
			else
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			end
		elseif item:getPosition() == Position(4615, 5300, 7) then
			if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.TimerQuest) > os.time() then
				if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) == 2 then
					item:transform(25660)
					player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce acendeu o segundo farol.")
					player:say("Voce acendeu o segundo farol.", TALKTYPE_MONSTER_SAY)
					addEvent(function()
						item:transform(25661)
					end, 60 * 1000)
					player:setStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao, 3)
				elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) == 1 then
					player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce deve acender os farois na ordem correta.")
					return true
				elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) > 2 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) < 10 then
					player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce ja acendeu este farol.")
					return true
				else
					player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce nao esta nessa missao.")
					return true
				end
			else
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			end
		elseif item:getPosition() == Position(4490, 5226, 7) then
			if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.TimerQuest) > os.time() then
				if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) == 3 then
					item:transform(25660)
					player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce acendeu o terceiro farol.")
					player:say("Voce acendeu o terceiro farol.", TALKTYPE_MONSTER_SAY)
					addEvent(function()
						item:transform(25661)
					end, 60 * 1000)
					player:setStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao, 4)
				elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) >= 1 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) <= 2 then
					player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce deve acender os farois na ordem correta.")
					return true
				elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) > 3 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) < 10 then
					player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce ja acendeu este farol.")
					return true
				else
					player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce nao esta nessa missao.")
					return true
				end
			else
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			end
		elseif item:getPosition() == Position(4373, 5407, 7) then
			if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.TimerQuest) > os.time() then
				if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) == 4 then
					item:transform(25660)
					player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce acendeu o quarto farol.")
					player:say("Voce acendeu o quarto farol.", TALKTYPE_MONSTER_SAY)
					addEvent(function()
						item:transform(25661)
					end, 60 * 1000)
					player:setStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao, 5)
				elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) >= 1 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) <= 3 then
					player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce deve acender os farois na ordem correta.")
					return true
				elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) > 4 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) < 10 then
					player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce ja acendeu este farol.")
					return true
				else
					player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce nao esta nessa missao.")
					return true
				end
			else
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			end
		elseif item:getPosition() == Position(4415, 5532, 7) then
			if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.TimerQuest) > os.time() then
				if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) == 5 then
					item:transform(25660)
					player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce acendeu o quinto farol.")
					player:say("Voce acendeu o quinto farol.", TALKTYPE_MONSTER_SAY)
					addEvent(function()
						item:transform(25661)
					end, 60 * 1000)
					player:setStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao, 6)
				elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) >= 1 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) <= 4 then
					player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce deve acender os farois na ordem correta.")
					return true
				elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) > 5 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) < 10 then
					player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce ja acendeu este farol.")
					return true
				else
					player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce nao esta nessa missao.")
					return true
				end
			else
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			end
		elseif item:getPosition() == Position(4560, 5562, 7) then
			if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.TimerQuest) > os.time() then
				if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) == 6 then
					item:transform(25660)
					player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce acendeu o ultimo farol.")
					player:say("Voce acendeu o ultimo farol.", TALKTYPE_MONSTER_SAY)
					addEvent(function()
						item:transform(25661)
					end, 60 * 1000)
					player:setStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao, 7)
				elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) >= 1 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) <= 5 then
					player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce deve acender os farois na ordem correta.")
					return true
				elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) > 6 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) < 10 then
					player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce ja acendeu este farol.")
					return true
				else
					player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce nao esta nessa missao.")
					return true
				end
			else
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			end
		end
	else
		if item:getPosition() == Position(4520, 5404, 12) then
			if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.TimerQuest) > os.time() then
				if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) == 10 then
					if item.itemid == 13335 then
						item:transform(13168)
						player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce fechou a ostra.")
						player:say("Voce fechou a ostra.", TALKTYPE_MONSTER_SAY)
						addEvent(function()
							item:transform(13335)
						end, 60 * 1000)
						player:setStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao, 11)
					end
				elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) >= 11 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) < 20 then
					player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce ja fechou a ostra.")
					return true
				elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) < 10 or player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) >= 20 then
					player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce nao esta nessa missao.")
					return true
				end
			else
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			end
		elseif item:getPosition() == Position(4472, 5212, 15) or item:getPosition() == Position(4498, 5212, 15) then
			if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.TimerQuest) > os.time() then
				if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) == 30 then
					local lantern1 = Tile(Position(4472, 5212, 15)):getItemById(11048)
					local lantern2 = Tile(Position(4498, 5212, 15)):getItemById(11048)
					if item:getPosition() == Position(4472, 5212, 15) then
						item:transform(11048)
						if lantern2 then
							player:say("Voce ligou os dois receptores de magia.", TALKTYPE_MONSTER_SAY)
							player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce ligou os dois receptores de magia.")
							addEvent(function()
								item:transform(11050)
							end, 30 * 1000)
							player:setStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao, 31)
							return true
						end
						addEvent(function()
							item:transform(11050)
						end, 15 * 1000)
					elseif item:getPosition() == Position(4498, 5212, 15) then
						item:transform(11048)
						if lantern1 then
							player:say("Voce ligou os dois receptores de magia.", TALKTYPE_MONSTER_SAY)
							player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce ligou os dois receptores de magia.")
							addEvent(function()
								item:transform(11050)
							end, 30 * 1000)
							player:setStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao, 31)
							return true
						end
						addEvent(function()
							item:transform(11050)
						end, 10 * 1000)
					end
				elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) == 31 then
					player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce ja ligou os receptores.")
					return true
				else
					player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce nao esta nessa missao.")
					return true
				end
			else
				return false
			end

		end
	end
end

torchesViridia:aid(13111)
torchesViridia:register()
