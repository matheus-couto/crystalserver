local fontesNagas = Action()

function fontesNagas.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if item.itemid == 38528 then
		if Game.getStorageValue(GlobalStorage.Crandoria.NagasQuest.Timer) < os.time() then
			item:transform(38526)
			Game.setStorageValue(GlobalStorage.Crandoria.NagasQuest.Timer, os.time() + 5 * 60)
			Game.setStorageValue(GlobalStorage.Crandoria.NagasQuest.Count, 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Fonte ativada.")
			addEvent(function()
				item:transform(38528)
			end, 30 * 60 * 1000)
		else
			local timeLeft = (Game.getStorageValue(GlobalStorage.Crandoria.NagasQuest.Timer) - os.time())
			item:transform(38526)
			addEvent(function()
				item:transform(38528)
			end, 1000 * timeLeft)
			if Game.getStorageValue(GlobalStorage.Crandoria.NagasQuest.Count) >= 1 and Game.getStorageValue(GlobalStorage.Crandoria.NagasQuest.Count) < 6 then
				Game.setStorageValue(GlobalStorage.Crandoria.NagasQuest.Count, Game.getStorageValue(GlobalStorage.Crandoria.NagasQuest.Count) + 1)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Fonte ativada.")
			else
				Game.setStorageValue(GlobalStorage.Crandoria.NagasQuest.Count, 7)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ultima fonte ativada. Voce tem " ..timeLeft.. " segundos para passar pelo portao.")
				local portao1 = Tile(Position(5897, 4326, 14)):getItemById(8569)
				local portao2 = Tile(Position(5898, 4326, 14)):getItemById(8569)
				if portao1 and portao2 then
					portao1:remove()
					portao2:remove()
					addEvent(function()
						Game.createItem(8569, Position(5897, 4326, 14))
						Game.createItem(8569, Position(5898, 4326, 14))
					end, timeLeft * 1000)
				end

			end
		end
	end
	
end

fontesNagas:aid(13144)
fontesNagas:register()



-- local fontesNagas = Action()

-- function fontesNagas.onUse(player, item, fromPosition, target, toPosition, isHotkey)

-- 	if item.itemid == 38528 then
-- 		if Game.getStorageValue(GlobalStorage.Crandoria.NagasQuest.Timer) < os.time() then
-- 			item:transform(38526)


-- 			if Game.getStorageValue(GlobalStorage.Crandoria.NagasQuest.Change) < os.time() then
-- 				addEvent(function()
-- 					item:transform(38528)
-- 				end, 25 * 60 * 1000)
-- 				Game.setStorageValue(GlobalStorage.Crandoria.NagasQuest.Timer, os.time() + 25 * 60)
-- 				Game.setStorageValue(GlobalStorage.Crandoria.NagasQuest.Change, os.time() + 25 * 60)
-- 				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Primeira fonte ativada.")
-- 			else
-- 				addEvent(function()
-- 					item:transform(38528)
-- 				end, 1000 * (Game.getStorageValue(GlobalStorage.Crandoria.NagasQuest.Change) - os.time()))
-- 				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Fonte ativada.")
-- 			end


-- 		else

-- 		end
-- 	end
	
-- end

-- fontesNagas:aid(13144)
-- fontesNagas:register()