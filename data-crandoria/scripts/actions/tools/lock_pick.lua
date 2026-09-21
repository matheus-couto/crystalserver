
local bossConfig = {
    creatureNames = {"The Primal Menace", "Goshnar's Megalomania", "Faceless Bane", "The Pale Worm", "King Zelos", "Doctor Marrow", "The Monster", "Scarlett Etzel", "Drume", "Grand Master Oberon", "Urmahlullu the Weakened", "Urmahlullu the Tamed", "Urmahlullu the Immaculate", "Wildness of Urmahlullu"}
}

local function hasCreatureInArea(fromPosition, toPosition, creatureNames)
    for x = fromPosition.x, toPosition.x do
        for y = fromPosition.y, toPosition.y do
            local pos = Position(x, y, fromPosition.z)
            local tile = Tile(pos)
            if tile then
                local creature = tile:getTopCreature()
                if creature and table.contains(creatureNames, creature:getName()) then
                    return true
                end
            end
        end
    end
    return false
end

local rewardItems = {

	{itemId = 3357, itemName = "Plate Legs"},
	{itemId = 3557, itemName = "Plate Armor"},
	{itemId = 3271, itemName = "Spike Sword"},
	{itemId = 7457, itemName = "Fur Boots"},
	-- Adicione mais itens à lista conforme necessário
}

local function getRandomItemToTrade()
	-- Escolhe um item aleatório da lista de itens trocáveis
	local randomReward = math.random(1, #rewardItems)
	return rewardItems[randomReward].itemId -- Retorna o ID do item aleatório
end

local lockPick = Action()

function lockPick.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local randomItem = getRandomItemToTrade()
	local itemName = ItemType(randomItem):getName()
	local storage = player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso)
	local skillFist = player:getEffectiveSkillLevel(SKILL_FIST)
	-- local chance = math.random(1, skillFist)
	local chanceSuccess = math.random(1, skillFist)
	local chance = math.random(skillFist, 300)
	local chanceSpecial = math.random(skillFist, 1000)
	local timeLeft = math.floor((player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick) - os.time()) / 60)
	local timeLeftPrison = math.floor((player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickPrison) - os.time()) / 60)
	local timeLeftBoss = math.floor((player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss) - os.time()) / 60)


	if target.uid == 12354 then
		if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso) >= 8 then
			if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickPrison) < os.time() then
				if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick) < os.time() then
					if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss) < os.time() then
						if chanceSuccess > 80 then
							if chanceSpecial > 995 then
								player:addItem(12811, 1, true)
								player:say('CLICK!', TALKTYPE_MONSTER_SAY)
								player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 Chaotic Gamble.")
								player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
								player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
							elseif chanceSpecial <= 995 and chanceSpecial > 960 then
								if player:getPreyCards() < 10 then
									player:addPreyCards(5)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 5 Prey Cards.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
								else
									player:addItem(14112, 5, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 30 * 60)
								end
							elseif chanceSpecial > 880 and chanceSpecial <= 960 then
								player:addItem(14112, 1, true)
								player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 bar of gold.")
								player:say('CLICK!', TALKTYPE_MONSTER_SAY)
								player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
							elseif chanceSpecial > 800 and chanceSpecial <= 880 then
								player:addItem(33892, 1, true)
								player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 luminescent heart potion.")
								player:say('CLICK!', TALKTYPE_MONSTER_SAY)
								player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
							elseif chanceSpecial > 500 and chanceSpecial <= 800 then
								player:addItem(3043, 30, true)
								player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 30 Crystal Coins.")
								player:say('CLICK!', TALKTYPE_MONSTER_SAY)
								player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
							else
								player:addItem(3251, 1, true)
								player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 Blood Orb.")
								player:say('CLICK!', TALKTYPE_MONSTER_SAY)
								player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
							end
							return true
						else
							player:say('Voce falhou e quebrou sua ferramenta.', TALKTYPE_MONSTER_SAY)
							player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60)
							target:getPosition():sendMagicEffect(CONST_ME_HITAREA)
							item:remove(1)
						end
					else
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce deve aguardar por mais " ..timeLeftBoss.. " minuto(s) antes de usar a habilidade de Lockpicking novamente.")
					end
				else
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce deve aguardar por mais " ..timeLeft.. " minuto(s) antes de usar a habilidade de Lockpicking novamente.")
				end
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Por ter sido preso recentemente, coce deve aguardar por mais " ..timeLeftPrison.. " minuto(s) antes de usar a habilidade de Lockpicking novamente.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ainda nao aprendeu a habilidade de abrir fechaduras.")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		end
	elseif target.actionid == 12395 then
		if target.itemid == 9168 then
			if target:getPosition() == Position(5259, 4556, 8) then
				if player:getStorageValue(Storage.Quest.Crandoria.OldKame.Progresso) == 1 then
					player:setStorageValue(Storage.Quest.Crandoria.OldKame.Progresso, 2)
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce abriu o velho bau e obteve o segredo para abrir a porta do porao de Kame.")
					player:say('Voce abriu o velho bau e obteve o segredo para abrir a porta do porao de Kame.', TALKTYPE_MONSTER_SAY)
					player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
					item:remove(1)
				else
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja abriu este bau.")
				end
			end
			----------------------------- INTO THE SHADOWS 1 - inicio ----------------------------------------------------
		elseif target.itemid == 11540 then
			if storage == 3 then
				player:addItem(randomItem, 1)
				player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso, 4)
				player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Riddle, randomItem)
				player:say("Voce abriu a caixa e encontrou uma " ..itemName.. ".", TALKTYPE_MONSTER_SAY)
				item:remove(1)
				return true
			else
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			end
		elseif target.itemid == 5735 then
			if storage == 5 or storage == 6 then
				player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso, 7)
				player:teleportTo(Position(4652, 4702, 9))
				player:say('Voce tentou abrir a cela e foi capturado pelas amazonas.', TALKTYPE_MONSTER_SAY)
				local targetPos = Position(4654, 4702, 9)
				Tile(targetPos):getItemById(5737):transform(5735)
				addEvent(function()
					targetPos:sendMagicEffect(CONST_ME_HITAREA)
					Tile(targetPos):getItemById(5735):transform(5737)
					player:say("Voce foi solto.", TALKTYPE_MONSTER_SAY, false, nil, targetPos)
				end, 2 * 60 * 1000) 
			end
		end
		---------------------------- INTO THE SHADOWS 1 - fim -----------------------------------------------------
	elseif target.actionid == 13029 then
		if target:getPosition() == Position(5095, 4386, 10) then
			if player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 146 then
				player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 147)
				player:say('Voce encontrou 5 Gold Ingots!', TALKTYPE_MONSTER_SAY)
				player:addItem(9058, 5, true)
			else
			player:say('Voce ja pegou o conteudo deste bau.', TALKTYPE_MONSTER_SAY)
			target:getPosition():sendMagicEffect(CONST_ME_POFF)
			end
			return true
		end
		if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso) >= 8 then
			if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickPrison) < os.time() then
				if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick) < os.time() then
					if target.itemid == 28462 then
						if chanceSuccess > 20 then
							if target:getPosition() == Position(4945, 4875, 7) then
								if chance > 280 then
									player:addItem(3035, 20, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 20 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(3351, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 steel helmet.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(3030, 3, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 3 small ruby(s).")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3035, 5, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 5 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5273, 4733, 11) then
								if chance > 280 then
									player:addItem(3328, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 daramian waraxe.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 260 and chance <= 280 then
									player:addItem(3440, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 scarab shield.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 150 and chance <= 260 then
									player:addItem(3035, 35, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 35 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3042, 3, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 3 scarab coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5602, 4731, 11) then
								if chance > 280 then
									player:addItem(3073, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 wand of cosmic energy.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 230 and chance <= 280 then
									player:addItem(5878, 3, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 3 minothaur leathers.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 150 and chance <= 230 then
									player:addItem(3035, 15, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 15 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(5878, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 minotaur leather.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5605, 4910, 9) then
								if chance > 298 then
									player:addItem(14142, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 foxtail.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 280 and chance <= 298 then
									player:addItem(14247, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Ornate Crossbow.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 150 and chance <= 280 then
									player:addItem(3035, 50, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 50 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3029, 10, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 10 small sapphires.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(4994, 4445, 10) then
								if chance > 299 then
									player:addItem(12318, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Giant Shrimp.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
								elseif chance > 280 and chance <= 299 then
									player:addItem(7383, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Relic Sword.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 250 and chance <= 280 then
									player:addItem(5741, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Skull Helmet.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 150 and chance <= 250 then
									player:addItem(3043, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Crystal Coin.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3035, 35, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5345, 4598, 10) then
								if chance > 299 then
									player:addItem(12305, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Tin Key.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
								elseif chance > 280 and chance <= 299 then
									player:addItem(7422, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Jade Hammer.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 250 and chance <= 280 then
									player:addItem(7403, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Berserker.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 150 and chance <= 250 then
									player:addItem(3043, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Crystal Coin.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3030, 12, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 12 small rubies.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5614, 4504, 9) then
								if chance > 290 then
									player:addItem(31324, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 golden mask.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 280 and chance <= 290 then
									player:addItem(31323, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 sea horse figurine.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 230 and chance <= 280 then
									player:addItem(3043, 2, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 2 crystal coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 100 and chance <= 230 then
									player:addItem(8094, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Wand of Voodoo.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(31331, 2, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 2 Empty Honey Flasks.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(4953, 5018, 10) then
								if chance > 290 then
									player:addItem(3434, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Vampire Shield.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 290 then
									player:addItem(9685, 2, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 2 Vampire Teeth.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(3035, 15, true)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 15 platinum coins.")
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3035, 5, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 5 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5085, 5090, 9) then
								if chance > 280 then
									player:addItem(3035, 20, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 20 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(3557, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 plate legs.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(3033, 3, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 3 small amethysts.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3035, 5, true)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 5 platinum coins.")
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5116, 4547, 10) then
								if chance > 295 then
									player:addItem(5741, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Skull Helmet.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 230 and chance <= 295 then
									player:addItem(3043, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Crystal Coin.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 230 then
									player:addItem(6499, 5, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 5 Demonic Essences.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(9665, 3, true)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 3 wyrm scales.")
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(4786, 4795, 6) then
								if chance > 280 then
									player:addItem(3035, 20, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 20 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(3073, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 wand of cosmic energy.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(5922, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Holy Orchid.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3657, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 heaven blossom.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5127, 4851, 8) then
								if chance > 280 then
									player:addItem(3035, 25, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 25 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(5880, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 iron ore.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(3035, 15, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 15 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3032, 3, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 3 small emeralds.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5424, 5126, 7) then
								if chance > 280 then
									player:addItem(3348, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Banana Staff.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(3035, 25, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 25 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(5883, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Ape Fur.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3026, 3, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 3 White Pearls.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(4951, 4385, 6) then
								if chance > 299 then
									player:addItem(9099, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Black Candle.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance <= 299 and chance > 280 then
									player:addItem(3043, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Crystal Coin.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(3035, 25, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 25 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(5461, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Pirate Boots.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3035, 5, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 5 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5107, 4863, 8) then
								if chance > 299 then
									player:addItem(11587, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 demonic candy ball.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance <= 299 and chance > 280 then
									player:addItem(3381, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 crown armor.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(3043, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 crystal coin.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(5911, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 red piece of cloth.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3035, 25, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 25 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(4680, 5209, 3) then
								if chance > 295 then
									player:addItem(3079, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Boots of Haste.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance <= 295 and chance > 280 then
									player:addItem(3043, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Crystal Coin.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(3324, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Skull Staff.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(3035, 25, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 25 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3030, 5, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 5 small rubies.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(4708, 5120, 5) then
								if chance > 295 then
									player:addItem(3360, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Golden Armor.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance <= 295 and chance > 280 then
									player:addItem(3043, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Crystal Coin.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(3567, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Blue Robe.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(3035, 25, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 25 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3030, 15, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 15 small rubies.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5420, 5516, 6) then
								if chance > 295 then
									player:addItem(3360, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Golden Armor.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance <= 295 and chance > 280 then
									player:addItem(3043, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Crystal Coin.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(3567, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Blue Robe.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(3035, 25, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 25 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3030, 15, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 15 small rubies.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5026, 4574, 9) then
								if chance > 298 then
									player:addItem(10385, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Zaoan Helmet.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 30 * 60)
								elseif chance <= 298 and chance > 280 then
									player:addItem(10387, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Zaoan Legs.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 250 and chance <= 280 then
									player:addItem(11384, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Zaoan Armor.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 150 and chance <= 250 then
									player:addItem(3043, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Crystal Coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3035, 50, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 50 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5632, 5068, 2) then
								if chance > 298 then
									player:addItem(10385, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Zaoan Helmet.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 30 * 60)
								elseif chance <= 298 and chance > 280 then
									player:addItem(10387, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Zaoan Legs.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 250 and chance <= 280 then
									player:addItem(11384, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Zaoan Armor.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 150 and chance <= 250 then
									player:addItem(3043, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Crystal Coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3035, 50, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 50 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5431, 4730, 10) then
								if chanceSpecial > 999 then
									player:addItem(10290, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Mini Mummy.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
								elseif chanceSpecial <= 999 and chanceSpecial > 980 then
									player:addItem(3043, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Crystal Coin.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chanceSpecial > 870 and chanceSpecial <= 980 then
									player:addItem(3035, 25, true)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 25 platinum coins.")
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chanceSpecial >= 590 and chanceSpecial <= 870 then
									player:addItem(5914, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Yellow Piece of Cloth.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3028, 3, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 3 small diamonds.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(4650, 5164, 7) then
								if chance > 299 then
									player:addItem(12304, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Maxilla Maximus.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 30 * 60)
								elseif chance <= 299 and chance > 280 then
									player:addItem(3434, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Vampire Shield.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(3043, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Crystal Coin.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(3028, 10, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 10 small diamonds.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3035, 20, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 20 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5514, 4638, 11) then
								if chanceSpecial > 999 then
									player:addItem(12509, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Scorpion Sceptre.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
								elseif chanceSpecial <= 999 and chance > 880 then
									if player:getPreyCards() < 2 then
										player:addPreyCards(1)
										player:say('CLICK!', TALKTYPE_MONSTER_SAY)
										player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 Prey Card.")
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
									else
										player:addItem(3043, 1, true)
										player:say('CLICK!', TALKTYPE_MONSTER_SAY)
										player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Crystal Coin.")
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 30 * 60)
									end
								elseif chanceSpecial > 710 and chance <= 880 then
									player:addItem(3027, 10, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 10 black pearls.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chanceSpecial >= 420 and chance <= 710 then
									player:addItem(5914, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Yellow Piece of Cloth.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3035, 20, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 20 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(4564, 5190, 4) then
								if chance > 299 then
									if player:getPreyCards() < 2 then
										player:addPreyCards(1)
										player:say('CLICK!', TALKTYPE_MONSTER_SAY)
										player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 Prey Card.")
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
									else
										player:addItem(3006, 1, true)
										player:say('CLICK!', TALKTYPE_MONSTER_SAY)
										player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Ring of the Sky.")
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 30 * 60)
									end
								elseif chance <= 299 and chance > 280 then
									player:addItem(822, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Lightning Legs.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(5898, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Bonelord Eye.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(3567, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Blue Robe.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3035, 20, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 20 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(4634, 4962, 5) then
								if chance > 295 then
									if player:getPreyCards() < 2 then
										player:addPreyCards(1)
										player:say('CLICK!', TALKTYPE_MONSTER_SAY)
										player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 Prey Card.")
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
									else
										player:addItem(14088, 1, true)
										player:say('CLICK!', TALKTYPE_MONSTER_SAY)
										player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Carapace Shield.")
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 30 * 60)
									end
								elseif chance <= 295 and chance > 280 then
									player:addItem(14086, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Calopteryx Cape.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(14087, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Grasshopper Legs.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(3035, 50, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 50 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(9057, 5, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(4900, 4654, 13) then
								if chance > 295 then
									if player:getPreyCards() < 2 then
										player:addPreyCards(1)
										player:say('CLICK!', TALKTYPE_MONSTER_SAY)
										player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 Prey Card.")
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
									else
										player:addItem(10385, 1, true)
										player:say('CLICK!', TALKTYPE_MONSTER_SAY)
										player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Zaoan Helmet.")
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 30 * 60)
									end
								elseif chance <= 295 and chance > 280 then
									player:addItem(30061, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Giant Sapphire.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(10384, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Zaoan Armor.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(3035, 50, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 50 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3030, 10, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 10 small rubies.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5060, 4704, 12) then
								if chance > 295 then
									if player:getPreyCards() < 2 then
										player:addPreyCards(1)
										player:say('CLICK!', TALKTYPE_MONSTER_SAY)
										player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 Prey Card.")
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
									else
										player:addItem(20138, 1, true)
										player:say('CLICK!', TALKTYPE_MONSTER_SAY)
										player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Small Stamina Refill.")
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
									end
								elseif chance <= 295 and chance > 280 then
									player:addItem(17812, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Ratana.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(3043, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Crystal Coin.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(3039, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Red Gem.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3035, 20, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 20 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5159, 4862, 5) then
								if chance > 295 then
									player:addItem(3416, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Dragon Shield.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
								elseif chance <= 295 and chance > 280 then
									player:addItem(3322, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Dragon Hammer.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(3028, 5, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 5 Small Diamonds.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(3557, 5, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 5 Plate Legs.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3035, 5, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 5 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5950, 5079, 7) then
								if chance > 295 then
									if player:getStamina() <= 1320 then
										player:say('CLICK!', TALKTYPE_MONSTER_SAY)
										player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 hora de stamina ao abrir o bau.")
										player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
									else
										player:addItem(3043, 2, true)
										player:say('CLICK!', TALKTYPE_MONSTER_SAY)
										player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 2 Crystal Coins.")
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
									end
								elseif chance <= 295 and chance > 280 then
									player:addItem(20062, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Cluster of Solace.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(7404, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Assassin Dagger.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(3035, 25, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 25 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3026, 5, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 5 White Pearls.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5732, 5341, 8) then
								if chance > 298 then
									player:addItem(40535, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Heavy Spear.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
								elseif chance <= 298 and chance > 280 then
									player:addItem(3043, 2, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 2 Crystal Coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(3029, 20, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 20 Small Sapphires.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(3035, 25, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 25 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(40531, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 broken iks faulds.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5289, 5039, 9) then
								if chance > 295 then
									player:addItem(3392, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Royal Helmet.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 30 * 60)
								elseif chance <= 295 and chance > 280 then
									player:addItem(3079, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Boots of Haste.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 30 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(3043, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Crystal Coin.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(3029, 20, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 20 small sapphires.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3035, 15, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 15 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5384, 4868, 9) then
								if chance > 295 then
									player:addItem(3386, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Dragon Scale Mail.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 30 * 60)
								elseif chance <= 295 and chance > 280 then
									player:addItem(3392, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Royal Helmet.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 30 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(3302, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Dragon Lance.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(3035, 50, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 50 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3030, 10, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 10 small rubies.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5384, 4868, 9) then
								if chance > 295 then
									player:addItem(10387, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Zaoan Legs.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
								elseif chance <= 295 and chance > 280 then
									player:addItem(10384, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Zaoan Armor.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(3035, 50, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 50 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(10386, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Zaoan Shoes.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3030, 5, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 5 small rubies.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5816, 4603, 9) then
								if chance > 298 then
									if player:getPreyCards() < 2 then
										player:addPreyCards(1)
										player:say('CLICK!', TALKTYPE_MONSTER_SAY)
										player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 Prey Card.")
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
									else
										player:addItem(14112, 1, true)
										player:say('CLICK!', TALKTYPE_MONSTER_SAY)
										player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 bar of gold.")
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
									end
								elseif chance <= 298 and chance > 280 then
									player:addItem(30059, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Giant Ruby.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(3036, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Violet Gem.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(3035, 50, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 50 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(36972, 2, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 2 old girtablilu carapaces.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(4786, 5080, 8) then
								if chance > 298 then
									if player:getPreyCards() < 2 then
										player:addPreyCards(1)
										player:say('CLICK!', TALKTYPE_MONSTER_SAY)
										player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 Prey Card.")
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
									else
										player:addItem(3043, 3, true)
										player:say('CLICK!', TALKTYPE_MONSTER_SAY)
										player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 3 Crystal Coins.")
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
									end
								elseif chance <= 298 and chance > 280 then
									player:addItem(8074, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Spellbook of Mind Control.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(3043, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Crystal Coin.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(9663, 5, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 5 Piece of Dead Brain.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3035, 50, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 50 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(4849, 5308, 13) then
								if chance > 298 then
									if player:getStamina() <= 1320 then
										player:say('CLICK!', TALKTYPE_MONSTER_SAY)
										player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 hora de stamina ao abrir o bau.")
										player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
									else
										player:addItem(30180, 1, true)
										player:say('CLICK!', TALKTYPE_MONSTER_SAY)
										player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Hexagonal Ruby.")
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
									end
								elseif chance <= 298 and chance > 280 then
									player:addItem(3043, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Crystal Coin.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(7404, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Assassin Dagger.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(3037, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Yellow Gem.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3035, 25, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 25 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5277, 5257, 6) then
								if chance > 298 then
									player:addItem(3043, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Crystal Coin.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 30 * 60)
								elseif chance <= 298 and chance > 280 then
									player:addItem(7408, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Wyvern Fang.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 30 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(3029, 6, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 6 small sapphires.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(3035, 10, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 10 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3351, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 steel helmet.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(4993, 5534, 7) then
								if chance > 295 then
									player:addItem(3386, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Dragon Scale Mail.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 30 * 60)
								elseif chance <= 295 and chance > 280 then
									player:addItem(3392, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Royal Helmet.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 30 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(3043, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Crystal Coin.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(3428, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Tower Shield.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3029, 10, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 10 small sapphires.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(4669, 5303, 3) then
								if chance > 295 then
									player:addItem(3043, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Crystal Coin.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance <= 295 and chance > 280 then
									player:addItem(3567, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Blue Robe.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(5895, 2, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 2 Fish Fins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(3035, 50, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 50 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3418, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Bonelord Shield.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(4669, 5303, 3) then
								if chance > 295 then
									player:addItem(3043, 3, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 3 Crystal Coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance <= 295 and chance > 280 then
									player:addItem(3320, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Fire Axe.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(3043, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Crystal Coin.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(3035, 50, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 50 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3318, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Knight Axe.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5249, 4481, 7) then
								if chance > 295 then
									player:addItem(3043, 2, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 2 Crystal Coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance <= 295 and chance > 280 then
									player:addItem(3342, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou War Axe.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(3043, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Crystal Coin.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(811, 50, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Terra Mantle.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(812, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Terra Legs.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5157, 4762, 15) then
								if chance > 295 then
									player:addItem(3043, 3, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 3 Crystal Coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance <= 295 and chance > 280 then
									player:addItem(5893, 2, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 2 Perfect Behemoth Fangs.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(3043, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Crystal Coin.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(6499, 5, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 5 Demonic Essences.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3035, 50, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 50 platinum coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5461, 4326, 9) then
								if chance > 295 then
									player:addItem(7383, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Relic Sword.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance <= 295 and chance > 280 then
									player:addItem(14247, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Ornate Crossbow.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(3043, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Crystal Coin.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 120 and chance <= 210 then
									player:addItem(3370, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Knight Armor.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(6499, 3, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 3 Demonic Essences.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							elseif target:getPosition() == Position(5357, 4190, 11) then
								if chance > 298 then
									if player:getPreyCards() < 2 then
										player:addPreyCards(1)
										player:say('CLICK!', TALKTYPE_MONSTER_SAY)
										player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 Prey Card.")
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
									else
										player:addItem(3414, 1, true)
										player:say('CLICK!', TALKTYPE_MONSTER_SAY)
										player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Mastermind Shield.")
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
									end
								elseif chance <= 298 and chance > 280 then
									player:addItem(3043, 2, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 2 Crystal Coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(3043, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Crystal Coin.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 100 and chance <= 210 then
									player:addItem(3370, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Knight Armor.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3043, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Crystal Coin.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end

								if player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 143 then
									player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 144)
									player:addItem(4841, 1)
									player:say('Voce encontrou uma Memory Stone!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou uma Memory Stone!")
								end
								return true
							elseif target:getPosition() == Position(4463, 4701, 9) then
								if chance > 298 then
									if player:getPreyCards() < 2 then
										player:addPreyCards(1)
										player:say('CLICK!', TALKTYPE_MONSTER_SAY)
										player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 Prey Card.")
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
									else
										player:addItem(3414, 1, true)
										player:say('CLICK!', TALKTYPE_MONSTER_SAY)
										player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Mastermind Shield.")
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
									end
								elseif chance <= 298 and chance > 280 then
									player:addItem(3043, 2, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 2 Crystal Coins.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance > 210 and chance <= 280 then
									player:addItem(3043, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Crystal Coin.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								elseif chance >= 100 and chance <= 210 then
									player:addItem(3370, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Knight Armor.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								else
									player:addItem(3043, 1, true)
									player:say('CLICK!', TALKTYPE_MONSTER_SAY)
									player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Crystal Coin.")
									player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 10 * 60)
								end
								return true
							end
						else
							player:say('Voce falhou e quebrou sua ferramenta.', TALKTYPE_MONSTER_SAY)
							target:getPosition():sendMagicEffect(CONST_ME_HITAREA)
							item:remove(1)
						end
						------------------------- BOSS INICIO -----------------------------
					elseif target.itemid == 23741 then
						if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss) < os.time() then
							if target:getPosition() == Position(5756, 4679, 6) then -- SCARLETT
								if not hasCreatureInArea(Position(5756, 4670, 6), Position(5776, 4691, 6), bossConfig.creatureNames) then
									if chanceSuccess > 40 then
										if chance > 299 then
											player:addItem(22739, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Cobra You Desire.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
										elseif chance <= 299 and chance > 295 then
											player:addItem(14112, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Bar of Gold.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										elseif chance > 210 and chance <= 295 then
											player:addItem(3043, 5, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 5 Crystal Coins.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										elseif chance >= 120 and chance <= 210 then
											player:addItem(30060, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Giant Emerald.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										else
											player:addItem(3043, 3, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 3 Crystal Coins.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										end
									else
										player:say('Voce falhou e quebrou sua ferramenta.', TALKTYPE_MONSTER_SAY)
										target:getPosition():sendMagicEffect(CONST_ME_HITAREA)
										item:remove(1)
									end
								else
									player:say('Derrote Scarlet Etzel antes de abrir o bau.', TALKTYPE_MONSTER_SAY)
									target:getPosition():sendMagicEffect(CONST_ME_POFF)
								end
								return true
							elseif target:getPosition() == Position(5249, 4481, 7) then -- DRUME
								if not hasCreatureInArea(Position(5232, 4465, 7), Position(5274, 4505, 7), bossConfig.creatureNames) then
									if chanceSuccess > 40 then
										if chance > 299 then
											player:addItem(36827, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Lion You Desire.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
										elseif chance <= 299 and chance > 295 then
											player:addItem(14112, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Bar of Gold.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 30 * 60)
										elseif chance > 210 and chance <= 295 then
											player:addItem(3043, 5, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 5 Crystal Coins.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										elseif chance >= 120 and chance <= 210 then
											player:addItem(30061, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Giant Sapphire.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										else
											player:addItem(3043, 3, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 3 Crystal Coins.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										end
									else
										player:say('Voce falhou e quebrou sua ferramenta.', TALKTYPE_MONSTER_SAY)
										target:getPosition():sendMagicEffect(CONST_ME_HITAREA)
										item:remove(1)
									end
								else
									player:say('Derrote Drume antes de abrir o bau.', TALKTYPE_MONSTER_SAY)
									target:getPosition():sendMagicEffect(CONST_ME_POFF)
								end
								return true
							elseif target:getPosition() == Position(4823, 4481, 9) then -- OBERON
								if not hasCreatureInArea(Position(4823, 4474, 9), Position(4838, 4486, 9), bossConfig.creatureNames) then
									if chanceSuccess > 40 then
										if chance > 299 then
											player:addItem(31633, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Falcon You Desire.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
										elseif chance <= 299 and chance > 295 then
											player:addItem(14112, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Bar of Gold.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										elseif chance > 210 and chance <= 295 then
											player:addItem(3043, 5, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 5 Crystal Coins.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										elseif chance >= 120 and chance <= 210 then
											player:addItem(30059, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Giant Ruby.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										elseif chance < 120 and chance >= 5 then
											player:addItem(3043, 3, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 3 Crystal Coins.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										elseif chance < 5 then
											if player:getStorageValue(Storage.Quest.Crandoria.StarlightVial) < 1 then
												player:addItem(25976, 1, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Starlight Vial!")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
												player:setStorageValue(Storage.Quest.Crandoria.StarlightVial, 1)
											else
												player:addItem(3043, 3, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 3 Crystal Coins.")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
											end
										end
									else
										player:say('Voce falhou e quebrou sua ferramenta.', TALKTYPE_MONSTER_SAY)
										target:getPosition():sendMagicEffect(CONST_ME_HITAREA)
										item:remove(1)
									end
								else
									player:say('Derrote Grand Master Oberon antes de abrir o bau.', TALKTYPE_MONSTER_SAY)
									target:getPosition():sendMagicEffect(CONST_ME_POFF)
								end
								return true
							elseif target:getPosition() == Position(5562, 5115, 15) then -- AHAU
								if chanceSuccess > 40 then
									if chance > 297 then
										player:addItem(40535, 1, true)
										player:say('CLICK!', TALKTYPE_MONSTER_SAY)
										player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Heavy Spear.")
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
									elseif chance <= 297 and chance > 295 then
										player:addItem(14112, 1, true)
										player:say('CLICK!', TALKTYPE_MONSTER_SAY)
										player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Bar of Gold.")
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
									elseif chance > 210 and chance <= 295 then
										player:addItem(3043, 5, true)
										player:say('CLICK!', TALKTYPE_MONSTER_SAY)
										player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 5 Crystal Coins.")
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
									elseif chance >= 120 and chance <= 210 then
										player:addItem(3036, 1, true)
										player:say('CLICK!', TALKTYPE_MONSTER_SAY)
										player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Violet Gem.")
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
									else
										player:addItem(3035, 50, true)
										player:say('CLICK!', TALKTYPE_MONSTER_SAY)
										player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 50 platinum coins.")
										player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
									end
								else
									player:say('Voce falhou e quebrou sua ferramenta.', TALKTYPE_MONSTER_SAY)
									target:getPosition():sendMagicEffect(CONST_ME_HITAREA)
									item:remove(1)
								end
								return true
							elseif target:getPosition() == Position(5860, 4513, 8) then -- URMAHLULU
								if not hasCreatureInArea(Position(5856, 4500, 8), Position(5885, 4529, 8), bossConfig.creatureNames) then
									if chanceSuccess > 40 then
										if chanceSpecial > 995 then
											player:addItem(30323, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Rainbow Necklace.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
										elseif chanceSpecial <= 995 and chanceSpecial > 950 then
											player:addItem(14112, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Bar of Gold.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										elseif chanceSpecial > 900 and chanceSpecial <= 950 then
											player:addItem(31572, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Blue and Golden Cordon.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										elseif chanceSpecial >= 500 and chanceSpecial <= 900 then
											player:addItem(3043, 5, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 5 Crystal Coins.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										else
											player:addItem(3043, 3, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 3 Crystal Coins.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										end
									else
										player:say('Voce falhou e quebrou sua ferramenta.', TALKTYPE_MONSTER_SAY)
										target:getPosition():sendMagicEffect(CONST_ME_HITAREA)
										item:remove(1)
									end
								else
									player:say('Derrote Urmahlullu antes de abrir o bau.', TALKTYPE_MONSTER_SAY)
									target:getPosition():sendMagicEffect(CONST_ME_POFF)
								end
								return true
							elseif target:getPosition() == Position(5451, 4293, 12) then -- THE MONSTER
								if not hasCreatureInArea(Position(5451, 4291, 12), Position(5468, 4304, 12), bossConfig.creatureNames) then
									if chanceSuccess > 40 then
										if chanceSpecial > 997 then
											local secondChance = math.random(1, 100)
											if secondChance > 90 then
												player:addItem(40589, 1, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Stitched Mutant Hide Legs.")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
											elseif secondChance <= 90 and secondChance > 80 then
												player:addItem(40590, 1, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Mutated Skin Legs.")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
											elseif secondChance <= 80 and secondChance > 70 then
												player:addItem(40591, 1, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Mutated Skin Armor.")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
											elseif secondChance <= 70 and secondChance > 60 then
												player:addItem(40595, 1, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Mutant Bone Kilt.")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
											elseif secondChance <= 60 and secondChance > 50 then
												player:addItem(40594, 1, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Alchemist's Notepad.")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
											elseif secondChance <= 50 and secondChance > 40 then
												player:addItem(40588, 1, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Antler-horn Helmet.")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
											elseif secondChance <= 40 and secondChance > 20 then
												player:addItem(40593, 1, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Mutant Bone Boots.")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
											elseif secondChance <= 20 then
												player:addItem(40592, 1, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Alchemist's Boots.")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
											end
										elseif chanceSpecial <= 997 and chance > 980 then
											player:addItem(14112, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Bar of Gold.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 30 * 60)
										elseif chanceSpecial > 810 and chance <= 980 then
											player:addItem(30059, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Giant Ruby.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										elseif chanceSpecial >= 520 and chance <= 810 then
											player:addItem(30060, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Giant Emerald.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										else
											player:addItem(30061, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Giant Sapphire.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										end
									else
										player:say('Voce falhou e quebrou sua ferramenta.', TALKTYPE_MONSTER_SAY)
										target:getPosition():sendMagicEffect(CONST_ME_HITAREA)
										item:remove(1)
									end
								else
									player:say('Derrote o Boss antes de abrir o bau.', TALKTYPE_MONSTER_SAY)
									target:getPosition():sendMagicEffect(CONST_ME_POFF)
								end
								return true
							elseif target:getPosition() == Position(5119, 5242, 15) then -- KING ZELOS
								if not hasCreatureInArea(Position(5117, 5231, 15), Position(5142, 5253, 15), bossConfig.creatureNames) then
									if chanceSuccess > 40 then
										if chance > 299 then
											if secondChance > 75 then
												player:addItem(31581, 1, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Bow of Cataclysm.")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
											elseif secondChance <= 75 and secondChance > 50 then
												player:addItem(31583, 1, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Toga Mortis.")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
											elseif secondChance <= 50 and secondChance > 25 then
												player:addItem(31582, 1, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Galea Mortis.")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
											else
												player:addItem(31737, 1, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Shadow Cowl.")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
											end
										elseif chance <= 299 and chance > 297 then
											player:addItem(14112, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Bar of Gold.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
										elseif chance > 285 and chance <= 297 then
											player:addItem(5884, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Spirit Container.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										elseif chance >= 180 and chance <= 285 then
											player:addItem(3043, 5, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 5 Crystal Coins.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										else
											player:addItem(3043, 3, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 3 Crystal Coins.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										end
									else
										player:say('Voce falhou e quebrou sua ferramenta.', TALKTYPE_MONSTER_SAY)
										target:getPosition():sendMagicEffect(CONST_ME_HITAREA)
										item:remove(1)
									end
								else
									player:say('Derrote King Zelos antes de abrir o bau.', TALKTYPE_MONSTER_SAY)
									target:getPosition():sendMagicEffect(CONST_ME_POFF)
								end
								return true
							elseif target:getPosition() == Position(4809, 5321, 13) then -- FACELESS BANE
								if not hasCreatureInArea(Position(4808, 5314, 13), Position(4827, 5331, 13), bossConfig.creatureNames) then
									if chanceSuccess > 40 then
										if chance > 299 then
											if secondChance > 75 then
												player:addItem(29430, 1, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Ectoplasmic Shield.")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
											elseif secondChance <= 75 and secondChance > 50 then
												player:addItem(29431, 1, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou Spirit Guide.")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
											elseif secondChance <= 50 and secondChance > 25 then
												player:addItem(30344, 1, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Enchanted Pendulent.")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
											else
												player:addItem(28571, 1, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Book Backpack.")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
											end
										elseif chance <= 299 and chance > 297 then
											player:addItem(14112, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Bar of Gold.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
										elseif chance > 285 and chance <= 297 then
											player:addItem(3043, 5, true)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 5 Crystal Coins.")
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										elseif chance >= 180 and chance <= 285 then
											player:addItem(30180, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Hexagonal Ruby.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										else
											player:addItem(3043, 3, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 3 Crystal Coins.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										end
									else
										player:say('Voce falhou e quebrou sua ferramenta.', TALKTYPE_MONSTER_SAY)
										target:getPosition():sendMagicEffect(CONST_ME_HITAREA)
										item:remove(1)
									end
								else
									player:say('Derrote Faceless Bane antes de abrir o bau.', TALKTYPE_MONSTER_SAY)
									target:getPosition():sendMagicEffect(CONST_ME_POFF)
								end
								return true
							elseif target:getPosition() == Position(33795, 31504, 14) then -- PALE WORM
								if not hasCreatureInArea(Position(33792, 31494, 14), Position(33821, 31518, 14), bossConfig.creatureNames) then
									if chanceSuccess > 40 then
										if chanceSpecial > 997 then
											if secondChance > 80 then
												player:addItem(32620, 1, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Ghost Backpack.")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
											elseif secondChance <= 80 and secondChance > 60 then
												player:addItem(32617, 1, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Fabulous Legs.")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
											elseif secondChance <= 60 and secondChance > 40 then
												player:addItem(32628, 1, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Ghost Chestplate.")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
											elseif secondChance <= 40 and secondChance > 20 then
												player:addItem(32616, 1, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Phantasmal Axe.")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
											else
												player:addItem(32618, 1, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Soulful Legs.")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
											end
										elseif chanceSpecial <= 997 and chanceSpecial > 980 then
											player:addItem(14112, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Bar of Gold.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
										elseif chanceSpecial > 800 and chanceSpecial <= 980 then
											player:addItem(3043, 5, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 5 Crystal Coins.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										elseif chanceSpecial >= 500 and chanceSpecial <= 800 then
											player:addItem(32770, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Diamond.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										else
											player:addItem(3043, 3, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 3 Crystal Coins.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										end
									else
										player:say('Voce falhou e quebrou sua ferramenta.', TALKTYPE_MONSTER_SAY)
										target:getPosition():sendMagicEffect(CONST_ME_HITAREA)
										item:remove(1)
									end
								else
									player:say('Derrote The Pale Worm antes de abrir o bau.', TALKTYPE_MONSTER_SAY)
									target:getPosition():sendMagicEffect(CONST_ME_POFF)
								end
								return true
							elseif target:getPosition() == Position(33701, 31632, 14) then -- GOSHNAR'S MEGALOMANIA
								if not hasCreatureInArea(Position(5451, 4291, 12), Position(5468, 4304, 12), bossConfig.creatureNames) then
									if chanceSuccess > 40 then
										if chanceSpecial > 999 then
											player:addItem(34109, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Bag You Desire.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
										elseif chanceSpecial <= 999 and chance > 980 then
											player:addItem(14112, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Bar of Gold.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
										elseif chanceSpecial > 810 and chance <= 980 then
											player:addItem(30059, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Giant Ruby.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										elseif chanceSpecial >= 520 and chance <= 810 then
											player:addItem(30060, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Giant Emerald.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										else
											player:addItem(30061, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Giant Sapphire.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										end
									else
										player:say('Voce falhou e quebrou sua ferramenta.', TALKTYPE_MONSTER_SAY)
										target:getPosition():sendMagicEffect(CONST_ME_HITAREA)
										item:remove(1)
									end
								else
									player:say('Derrote o Boss antes de abrir o bau.', TALKTYPE_MONSTER_SAY)
									target:getPosition():sendMagicEffect(CONST_ME_POFF)
								end
								return true
							elseif target:getPosition() == Position(5675, 4706, 15) then -- PRIMAL MENACE
								if not hasCreatureInArea(Position(5673, 4696, 15), Position(5696, 4716, 15), bossConfig.creatureNames) then
									if chanceSuccess > 40 then
										if chanceSpecial > 998 then
											player:addItem(39546, 1, true)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Primal Bag.")
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
										elseif chanceSpecial <= 998 and chanceSpecial > 950 then
											player:addItem(14112, 1, true)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Bar of Gold.")
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
										elseif chanceSpecial > 650 and chanceSpecial <= 950 then
											player:addItem(30059, 1, true)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Giant Ruby.")
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										elseif chanceSpecial >= 350 and chanceSpecial <= 650 then
											player:addItem(3043, 5, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 5 Crystal Coins.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										else
											player:addItem(3043, 3, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 3 Crystal Coins.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										end
									else
										player:say('Voce falhou e quebrou sua ferramenta.', TALKTYPE_MONSTER_SAY)
										target:getPosition():sendMagicEffect(CONST_ME_HITAREA)
										item:remove(1)
									end
								else
									player:say('Derrote Urmahlullu antes de abrir o bau.', TALKTYPE_MONSTER_SAY)
									target:getPosition():sendMagicEffect(CONST_ME_POFF)
								end
								return true
								----------------------- BOSS FINAL -------------------------------
							end
						else
							player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce deve aguardar por mais " ..timeLeftBoss.. " minuto(s) antes de usar a habilidade de Lockpicking novamente.")
						end
					elseif target.itemid == 14244 then
						if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss) < os.time() then
							if target:getPosition() == Position(5813, 4796, 11) then -- JAUL
								if not hasCreatureInArea(Position(5799, 4781, 11), Position(5826, 4804, 11), bossConfig.creatureNames) then
									if chanceSuccess > 40 then
										if chance > 299 then
											if secondChance > 80 then
												player:addItem(13993, 1, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Ornate Chestplate.")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
											elseif secondChance <= 80 and secondChance > 60 then
												player:addItem(13999, 1, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Ornate Legs.")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
											elseif secondChance <= 60 and secondChance > 40 then
												player:addItem(14000, 1, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Ornate Shield.")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
											elseif secondChance <= 40 and secondChance > 20 then
												player:addItem(14001, 1, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Ornate Mace.")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
											else
												player:addItem(13994, 1, true)
												player:say('CLICK!', TALKTYPE_MONSTER_SAY)
												player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Depth Lorica.")
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
												player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
											end
										elseif chance <= 299 and chance > 297 then
											player:addItem(13991, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Deepling Axe.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickBoss, os.time() + 20 * 60 * 60)
										elseif chance > 292 and chance <= 297 then
											player:addItem(14112, 1, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 1 Bar of Gold.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 60 * 60)
										elseif chance >= 180 and chance <= 292 then
											player:addItem(3043, 5, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 5 Crystal Coins.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										else
											player:addItem(3043, 3, true)
											player:say('CLICK!', TALKTYPE_MONSTER_SAY)
											player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou 3 Crystal Coins.")
											player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick, os.time() + 20 * 60)
										end
									else
										player:say('Voce falhou e quebrou sua ferramenta.', TALKTYPE_MONSTER_SAY)
										target:getPosition():sendMagicEffect(CONST_ME_HITAREA)
										item:remove(1)
									end
								else
									player:say('Derrote Jaul antes de abrir o bau.', TALKTYPE_MONSTER_SAY)
									target:getPosition():sendMagicEffect(CONST_ME_POFF)
								end
								return true
							end
						else
							player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce deve aguardar por mais " ..timeLeftBoss.. " minuto(s) antes de usar a habilidade de Lockpicking novamente.")
						end
					end
				else
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce deve aguardar por mais " ..timeLeft.. " minuto(s) antes de usar a habilidade de Lockpicking novamente.")
				end
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Por ter sido preso recentemente, voce deve aguardar por mais " ..timeLeftPrison.. " minuto(s) antes de usar a habilidade de Lockpicking novamente.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ainda nao aprendeu a habilidade de abrir fechaduras.")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		end
	end
	return true
end

lockPick:id(7889)
lockPick:register()


local lockPickChests = Action()

function lockPickChests.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso) >= 8 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O bau parece vazio mas tem um fundo falso com uma fechadura. Talvez voca possa abri-lo com um Lock Pick...")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end

end
lockPickChests:aid(13029)
lockPickChests:register()


-- local lockPick = Action()

-- function lockPick.onUse(player, item, fromPosition, target, toPosition, isHotkey)
-- 	if target.actionid ~= 12503 then
-- 		return false
-- 	end

-- 	if math.random(100) <= 30 then
-- 		if player:getStorageValue(Storage.Quest.U8_2.TheThievesGuildQuest.Mission02) == 1 then
-- 			player:addItem(227, 1)
-- 			player:setStorageValue(Storage.Quest.U8_2.TheThievesGuildQuest.Mission02, 2)
-- 			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your lock pick open this chest!")
-- 		end
-- 	else
-- 		item:remove(1)
-- 		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your lock pick broke.")
-- 	end
-- 	return true
-- end

-- lockPick:id(7889)
-- lockPick:register()
