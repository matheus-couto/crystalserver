local function createWooden(position, removeId, createId, actionId)
	local woodPosition = Position(position)
	local woodenPlanks = Tile(woodPosition):getItemById(removeId)
	if woodenPlanks then
		woodenPlanks:remove()
		local woods = Game.createItem(createId, 1, position)
		if woods then
			woods:setActionId(actionId)
		end
	end
	return true
end

local settingTable = {
	[42501] = {
		position = Position(32647, 32216, 7),
		removeItem = 12183,
		createItem = 6474,
	},
	[42502] = {
		position = Position(32660, 32213, 7),
		removeItem = 12183,
		createItem = 6474,
	},
	[42503] = {
		position = Position(32644, 32183, 6),
		removeItem = 12185,
		createItem = 6473,
	},
	[42504] = {
		position = Position(32660, 32201, 7),
		removeItem = 12184,
		createItem = 6473,
	},
	[42505] = {
		position = Position(32652, 32200, 5),
		removeItem = 12185,
		createItem = 6473,
	},
}

local hammer = Action()

function hammer.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not target or type(target) ~= "userdata" or not target:isItem() then
		return false
	end
	-- Lay down the wood
	local targetActionId = target:getActionId()
	local position = Position(32571, 31508, 9)
	local tile = Tile(position)
	if targetActionId == 40021 and tile:getItemById(4597) then
		if player:getItemCount(5901) >= 3 and player:getItemCount(953) >= 3 then
			player:removeItem(5901, 3)
			player:removeItem(953, 3)
			player:say("KLING KLONG!", TALKTYPE_MONSTER_SAY)
			tile:getItemById(295):remove()
			tile:getItemById(291):remove()
			Game.createItem(5770, 1, position):setActionId(40021)
		end
		return true
		-- Lay down the rails
	elseif targetActionId == 40021 and tile:getItemById(5770) then
		if player:getItemCount(9114) >= 1 and player:getItemCount(9115) >= 2 and player:getItemCount(953) >= 3 then
			player:removeItem(9114, 1)
			player:removeItem(9115, 2)
			player:removeItem(953, 3)
			player:say("KLING KLONG!", TALKTYPE_MONSTER_SAY)
			Game.createItem(7122, 1, position)
		end
		return true
	end

	-- Rottin wood and maried quest
	if player:getStorageValue(Storage.Quest.U8_7.RottinWoodAndTheMarriedMen.RottinStart) < 6 then
		local setting = settingTable[target:getActionId()]
		if setting then
			local woodenPosition = Position(setting.position)
			local woodenItem = Tile(woodenPosition):getItemById(settingTable.removeItem)
			if woodenItem then
				woodenItem:remove()
				Game.createItem(setting.createItem, 1, setting.position)
				addEvent(createWooden, 2 * 60 * 1000, setting.position, setting.removeItem, setting.createItem, setting)
			end

			player:setStorageValue(Storage.Quest.U8_7.RottinWoodAndTheMarriedMen.RottinStart, player:getStorageValue(Storage.Quest.U8_7.RottinWoodAndTheMarriedMen.RottinStart) + 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You fixed this broken wall.")
			return true
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already fixed many broken walls today.")
		return true
	end

	if target:getId() == 2032 then
		if target:getActionId() == 13111 then
			if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) == 20 then
				if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.TimerQuest) > os.time() then
					target:transform(11994)
					target:getPosition():sendMagicEffect(CONST_ME_HITAREA)
					player:setStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao, 21)
					addEvent(function()
						target:transform(2032)
					end, 60 * 1000) -- 1 minuto em milissegundos
				else
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao chegou a tempo.")
					return true
				end
			elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) == 21 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja quebrou a estatua.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			else
				return false
			end
		end
	end

	-- KAME
	if target:getId() == 2995 then 
		if target:getUniqueId() == 12333 then
			if player:getStorageValue(Storage.Quest.Crandoria.OldKame.Reward) < 1 then
				if player:getStorageValue(Storage.Quest.Crandoria.OldKame.Pig) < 1 then
					player:setStorageValue(Storage.Quest.Crandoria.OldKame.Pig, 1)
					player:say("Voce quebrou o cofre e encontrou a chave da dispensa de Kame.", TALKTYPE_MONSTER_SAY)
					target:transform(7180)
					
					-- Agendar a transforma��o de volta ap�s 1 minuto
					addEvent(function()
						local originalPlant = Tile(target:getPosition()):getItemById(7180)
						if originalPlant then
							originalPlant:transform(2995)
						end
					end, 60 * 1000) -- 5 minutos em milissegundos
				else
					player:say("Voce ja encontrou a chave da dispensa que estava no cofre.", TALKTYPE_MONSTER_SAY)
				end
			else
				player:say("Kame nao precisa mais de ajuda com isso.", TALKTYPE_MONSTER_SAY)
			end
		end 
	end

	if target:getId() == 1295 and target:getPosition() == Position(4557, 5402, 7) then
		local position = target:getPosition()
		addEvent(function()
			local stoneWall = Game.createItem(1295, 1, position)
			if stoneWall then
				player:say("A parede foi reconstruida!", TALKTYPE_MONSTER_SAY)
			end
		end, 5 * 1000) 
		target:remove()
	end

	if target:getId() == 2108 and target:getPosition() == Position(5076, 4457, 7) then
		if player:getStorageValue(Storage.Quest.Crandoria.GloothAddon.Progresso) == 10 then
			player:sendTextMessage(MESSAGE_FAILURE, "Voce consertou o poste de luz.")
			player:setStorageValue(Storage.Quest.Crandoria.GloothAddon.Progresso, 11)
			target:transform(2109)
			addEvent(function()
				target:transform(2108)
			end, 60000)
		end
	end

	if target:getId() == 6292 and player:getStorageValue(Storage.Quest.Crandoria.GloothAddon.Progresso) == 11 then
		if player:getItemCount(32002) < 2 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao possui Firewood o suficiente.")
			return false
		else
			player:removeItem(36722, 1)
			player:removeItem(36722, 1)
			target:transform(5771)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce reparou o pier.")
			player:setStorageValue(Storage.Quest.Crandoria.GloothAddon.Progresso, 12)
			addEvent(function()
				target:transform(6292)
			end, 60000)
		end
	end

	return false
end

hammer:id(3460)
hammer:register()
