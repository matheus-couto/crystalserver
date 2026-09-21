local openAreinha = Action()

function openAreinha.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local chance = math.random(1, 9)
	local gold = math.random(1, 3)
	if chance == 1 or chance == 2 then
		player:addItem(3031, gold)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu " ..gold.. " gold coin(s).")
	elseif chance == 3 or chance == 4 then
		player:addItem(3035, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 platinum coin.")
	elseif chance == 5 or chance == 6 then
		player:addItem(3026, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 white pearl.")
	elseif chance == 7 or chance == 8 then
		player:addItem(3027, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 black pearl.")
	else
		player:addItem(32045, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 Tiny Bass.")
	end
	item:remove(1)
	return true
end

openAreinha:id(13992)
openAreinha:register()


local openTrutaPequena = Action()

function openTrutaPequena.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local imbuementItems = { 9641, 11703, 20199, 10196, 11447, 21200, 9635, 11452, 10309, 11464, 18994, 10298, 9691, 21202, 9654, 9657, 22189, 10405, 11484, 9647, 10420, 18993, 21975, 23508, 9686, 9640, 21194, 9661, 21801, 9650, 9636, 5920, 5954, 9644, 14079, 9665, 9639, 9638, 10304, 5877, 16131, 11658, 11466, 22007, 9660, 10295, 10307, 14012, 17823, 9694, 11702, 25694, 25702, 20205, 11444, 10311, 22728, 17458, 10302, 14081, 9685, 9633, 9663, 22053, 23507, 28567, 11492, 20200, 22730 }
	local chance = math.random(1, 2)
	local gold = math.random(50, 100)

	if chance == 1 then
		player:addItem(3031, gold)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu " ..gold.. " gold coins.")
	else
		local itemId = imbuementItems[math.random(#imbuementItems)]
		local itemName = ItemType(itemId):getName() or "item desconhecido"
		player:addItem(itemId, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 " .. itemName .. ".")
	end
	item:remove(1)

	return true
end

openTrutaPequena:id(32045)
openTrutaPequena:register()

local openTrutaMedia = Action()

function openTrutaMedia.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local imbuementItems = { 9641, 11703, 20199, 10196, 11447, 21200, 9635, 11452, 10309, 11464, 18994, 10298, 9691, 21202, 9654, 9657, 22189, 10405, 11484, 9647, 10420, 18993, 21975, 23508, 9686, 9640, 21194, 9661, 21801, 9650, 9636, 5920, 5954, 9644, 14079, 9665, 9639, 9638, 10304, 5877, 16131, 11658, 11466, 22007, 9660, 10295, 10307, 14012, 17823, 9694, 11702, 25694, 25702, 20205, 11444, 10311, 22728, 17458, 10302, 14081, 9685, 9633, 9663, 22053, 23507, 28567, 11492, 20200, 22730 }
	local chance = math.random(1, 29)
	local chance2 = math.random(1, 2)
	local gold = math.random(10, 25)

	if chance >= 1 and chance <= 14 then
		player:addItem(3035, gold)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu " ..gold.. " platinum coins.")
	elseif chance >= 15 and chance <= 28 then
		if chance2 == 1 then
			local itemId = imbuementItems[math.random(#imbuementItems)]
			local itemName = ItemType(itemId):getName() or "item desconhecido"
			player:addItem(itemId, 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 " .. itemName .. ".")
		else
			local itemId = imbuementItems[math.random(#imbuementItems)]
			local itemName = ItemType(itemId):getName() or "item desconhecido"
			player:addItem(itemId, 2)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 2 " .. itemName .. ".")
		end
	else
		player:addItem(3026, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 White Pearl.")
		-- player:addItem(25745, 1)
		-- player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 Livro Sagrado.")
	end
	item:remove(1)
	return true
end

openTrutaMedia:id(32044)
openTrutaMedia:register()


local openTrutaMedia = Action()

function openTrutaMedia.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local imbuementItems = { 9641, 11703, 20199, 10196, 11447, 21200, 9635, 11452, 10309, 11464, 18994, 10298, 9691, 21202, 9654, 9657, 22189, 10405, 11484, 9647, 10420, 18993, 21975, 23508, 9686, 9640, 21194, 9661, 21801, 9650, 9636, 5920, 5954, 9644, 14079, 9665, 9639, 9638, 10304, 5877, 16131, 11658, 11466, 22007, 9660, 10295, 10307, 14012, 17823, 9694, 11702, 25694, 25702, 20205, 11444, 10311, 22728, 17458, 10302, 14081, 9685, 9633, 9663, 22053, 23507, 28567, 11492, 20200, 22730 }
	local chance = math.random(1, 7)
	local chance2 = math.random(1, 2)
	local gold = math.random(25, 50)

	if chance >= 1 and chance < 3 then
		player:addItem(3035, gold)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu " ..gold.. " platinum coins.")
	elseif chance >= 3 and chance < 5 then
		local itemId = imbuementItems[math.random(#imbuementItems)]
		local itemName = ItemType(itemId):getName() or "item desconhecido"
		player:addItem(itemId, 2)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 2 " .. itemName .. ".")
	elseif chance == 5 then
		local itemId = imbuementItems[math.random(#imbuementItems)]
		local itemName = ItemType(itemId):getName() or "item desconhecido"
		player:addItem(itemId, 3)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 3 " .. itemName .. ".")
	elseif chance == 6 then
		local itemId = imbuementItems[math.random(#imbuementItems)]
		local itemName = ItemType(itemId):getName() or "item desconhecido"
		player:addItem(itemId, 4)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 4 " .. itemName .. ".")
	elseif chance == 7 then
		local storageTC = player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.ContagemTC)
		local limiteTC = Game.getStorageValue(GlobalStorage.Crandoria.TibiaCoinsColeta.LimiteDiario)
		if limiteTC < 0 then
			limiteTC = 0
		end
		local valorTC = 25 - limiteTC
		if valorTC >= 1 then 
			if gold < 98 then
				player:addTransferableCoins(1)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 Tibia Coin.")
				setGlobalStorage(GlobalStorage.Crandoria.TibiaCoinsColeta.CoinsTotal, getGlobalStorage(GlobalStorage.Crandoria.TibiaCoinsColeta.CoinsTotal) + 1)
			else
				player:addTransferableCoins(2)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 2 Tibia Coins.")
				setGlobalStorage(GlobalStorage.Crandoria.TibiaCoinsColeta.CoinsTotal, getGlobalStorage(GlobalStorage.Crandoria.TibiaCoinsColeta.CoinsTotal) + 2)
			end
			player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.ContagemTC,storageTC  + 1)
			Game.setStorageValue(GlobalStorage.Crandoria.TibiaCoinsColeta.LimiteDiario, limiteTC + 1)
		else
			local itemId = imbuementItems[math.random(#imbuementItems)]
			local itemName = ItemType(itemId):getName() or "item desconhecido"
			player:addItem(itemId, 4)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 4 " .. itemName .. ".")
		end
	end
	item:remove(1)
	return true
end

openTrutaMedia:id(32043)
openTrutaMedia:register()