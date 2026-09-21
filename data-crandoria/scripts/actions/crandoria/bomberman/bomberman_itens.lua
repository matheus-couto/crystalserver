local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 5000)
condition:setFormula(-0.4, 0, -0.4, 0)

local itemBomberman = MoveEvent()

function itemBomberman.onStepIn(player, item, position, fromPosition)

	local storageLife = player:getStorageValue(Storage.Quest.Crandoria.Bomberman.Life)
	local storagePower = player:getStorageValue(Storage.Quest.Crandoria.Bomberman.Power)
	local storageBomb = player:getStorageValue(Storage.Quest.Crandoria.Bomberman.MoreBomb)

	if item.itemid == 10450 and item.actionid == 100 then
		local newLife = storageLife + 1
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "HP: " ..newLife.. "!! ")
		player:setStorageValue(Storage.Quest.Crandoria.Bomberman.Life, storageLife + 1)
		player:getPosition():sendMagicEffect(CONST_ME_HEARTS)
		item:remove()
	elseif item.itemid == 946 and item.actionid == 100 then
		if storagePower < 5 then
			local power = storagePower + 1
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Poder: " ..power.. "!! ")
			player:setStorageValue(Storage.Quest.Crandoria.Bomberman.Power, storagePower + 1)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
			item:remove()
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Poder: " ..storagePower.. "!! ")
			item:remove()
		end
	elseif item.itemid == 35336 and item.actionid == 100 then
		if storageBomb < 5 then
			local bombs = storageBomb + 1
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Bombas: " ..bombs.. "!! ")
			player:setStorageValue(Storage.Quest.Crandoria.Bomberman.MoreBomb, storageBomb + 1)
			player:getPosition():sendMagicEffect(CONST_ME_BLACK_BLOOD)
			item:remove(1)
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Bombas: " ..storageBomb.. "!! ")
			item:remove(1)
		end
	elseif item.itemid == 12259 and item.actionid == 100 then
		player:addCondition(condition)
		item:remove()
		player:getPosition():sendMagicEffect(CONST_ME_REDSMOKE)
		addEvent(function()
			if player:isPlayer() then
				player:getPosition():sendMagicEffect(CONST_ME_REDSMOKE)
			end
		end, 1000)
		addEvent(function()
			if player:isPlayer() then
				player:getPosition():sendMagicEffect(CONST_ME_REDSMOKE)
			end
		end, 2000)
		addEvent(function()
			if player:isPlayer() then
				player:getPosition():sendMagicEffect(CONST_ME_REDSMOKE)
			end
		end, 3000)
		addEvent(function()
			if player:isPlayer() then
				player:getPosition():sendMagicEffect(CONST_ME_REDSMOKE)
			end
		end, 4000)
	end
end

itemBomberman:id(10450, 946, 35336, 12259)
itemBomberman:register()
