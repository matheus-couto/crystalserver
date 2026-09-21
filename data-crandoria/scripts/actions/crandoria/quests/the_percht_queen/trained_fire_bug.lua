-- local fireBugQueen = Action()
-- function fireBugQueen.onUse(player, item, fromPosition, target, toPosition, isHotkey)

-- 	local chance = math.random(1, 100)
-- 	local position = target:getPosition()

-- 	if target.itemid == 30340 then
-- 		if player:getStorageValue(Storage.Quest.Crandoria.ThePerchtQueen.Timer) < os.time() then
-- 			item:remove()
-- 			position:sendMagicEffect(CONST_ME_FIREATTACK)
-- 			if chance > 1 then
-- 				Game.broadcastMessage('A Percht Queen foi descongelada e seus servos atacam novamente!', MESSAGE_EVENT_ADVANCE)
-- 				target:remove()
-- 				Game.createMonster("The Percht Queen", Position(4874, 5358, 7), true, true)
-- 				player:setStorageValue(Storage.Quest.Crandoria.ThePerchtQueen.Timer, os.time() + 2 * 60 * 60)
-- 				return true
-- 			else
-- 				player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce tenta derreter o gelo, mas o calor ainda nao foi o suficiente.")
-- 				return true
-- 			end
-- 		else
-- 			player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce so pode utilizar um fire bug a cada 2 horas.")
-- 			return true
-- 		end
-- 	end
-- end


-- fireBugQueen:id(19124)
-- fireBugQueen:register()

local fireBugQueen = Action()

function fireBugQueen.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local chance = math.random(1, 100)
	local position = target:getPosition()

	if target.itemid == 30340 then
		if player:getStorageValue(Storage.Quest.Crandoria.ThePerchtQueen.Timer) < os.time() then
			item:remove()
			position:sendMagicEffect(CONST_ME_FIREATTACK)
			if chance > 80 then
				Game.broadcastMessage('A Percht Queen foi descongelada e seus servos atacam novamente!', MESSAGE_EVENT_ADVANCE)
				target:remove()
				Game.createMonster("The Percht Queen", Position(4874, 5358, 7), true, true)

				-- Remover itens ao redor e invocar monstros
				local areaPosition = Position(position.x - 20, position.y - 20, position.z)
				local area = {
					fromPos = Position(areaPosition.x, areaPosition.y, areaPosition.z),
					toPos = Position(areaPosition.x + 40, areaPosition.y + 40, areaPosition.z)
				}
				local itemsToCheck = {7308, 7307, 7309, 7304, 7311}

				for x = area.fromPos.x, area.toPos.x do
					for y = area.fromPos.y, area.toPos.y do
						local itemPos = Position(x, y, area.fromPos.z)
						local tile = Tile(itemPos)
						if tile then
							for _, itemId in ipairs(itemsToCheck) do
								local items = tile:getItems()
								for _, item in ipairs(items) do
									if item:getId() == itemId then
										local monsterName
										if itemId == 7308 or itemId == 7307 or itemId == 7309 or itemId == 7305 then
											monsterName = "Schiach"
										elseif itemId == 7304 or itemId == 7311 or itemId == 7303 then
											monsterName = "Percht"
										end
										
										if monsterName then
											local itemPos = item:getPosition()  -- Armazena a posição antes de remover o item
											item:remove()  -- Remove o item
											Game.createMonster(monsterName, itemPos, true, true)  -- Cria o monstro na posição do item
										end
									end
								end
							end
						end
					end
				end

				player:setStorageValue(Storage.Quest.Crandoria.ThePerchtQueen.Timer, os.time() + 60 * 60)
				return true
			else
				player:setStorageValue(Storage.Quest.Crandoria.ThePerchtQueen.Timer, os.time() + 60 * 60)
				player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce tenta derreter o gelo, mas o calor ainda nao foi o suficiente.")
				return true
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce so pode utilizar um fire bug a cada 1 hora.")
			return true
		end
	end
end

fireBugQueen:id(19124)
fireBugQueen:register()
