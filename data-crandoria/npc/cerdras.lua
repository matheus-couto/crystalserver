local internalNpcName = "Cerdras"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 144,
	lookHead = 20,
	lookBody = 96,
	lookLegs = 41,
	lookFeet = 22,
	lookAddons = 2
}

npcConfig.flags = {
	floorchange = false
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

local config = {
    creatureNames = {"Spidris Elite"}
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

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	local storage = player:getStorageValue(Storage.Quest.Crandoria.CerdrasQuest.Progresso)
	local cooldown = player:getStorageValue(Storage.Quest.Crandoria.CerdrasQuest.Timer)

	local knight = player:getVocation():getBaseId() == VOCATION.BASE_ID.KNIGHT
	local paladin = player:getVocation():getBaseId() == VOCATION.BASE_ID.PALADIN
	local druid = player:getVocation():getBaseId() == VOCATION.BASE_ID.DRUID
	local sorcerer = player:getVocation():getBaseId() == VOCATION.BASE_ID.SORCERER
	local monk = player:getVocation():getBaseId() == VOCATION.BASE_ID.MONK

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "mission") or MsgContains(message, "missao") or MsgContains(message, "peixes") then
		if hasCreatureInArea(Position(5646, 5573, 2), Position(5656, 5582, 2), config.creatureNames) then
			npcHandler:say("Alguns monstros conseguiram acessar meu 'telhado'. Derrote-os e poderemos conversar com mais calma.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		else
			if player:getLevel() < 500 then
				npcHandler:say("Acredito que voce nao sera forte o suficiente para cumprir o que eu preciso. Retorne apos o nivel 500.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				if storage < 1 then
					if cooldown < os.time() then
						local chance = math.random(1, 5)
						if chance == 1 then
							npcHandler:say("Eu estou ja muitos dias sem comer uma proteina que nao seja carne ou ovos de insetos gigantes. Sinto falta dos peixes que eu pescada em Crandoria. \z
							Nao tenho muito a oferecer, mas sempre consigo um carregamento com Donahue vindo de Astralis. Algumas vezes tambem consigo Tibia Coins. Enfim... \z
							Traga-me dessa vez 3 Small Bass e te darei 1 Eldritch Fragment e um pouco de experiencia como recompensa. Esses peixes só podem ser pescados no Lago da Avareza, em Crandoria.", npc, creature)
							player:setStorageValue(Storage.Quest.Crandoria.CerdrasQuest.Progresso, 1)
							npcHandler:setTopic(playerId, 0)
						elseif chance == 2 then
							npcHandler:say("Eu estou ja muitos dias sem comer uma proteina que nao seja carne ou ovos de insetos gigantes. Sinto falta dos peixes que eu pescada em Crandoria. \z
							Nao tenho muito a oferecer, mas sempre consigo um carregamento com Donahue vindo de Astralis. Algumas vezes tambem consigo Tibia Coins. Enfim... \z
							Traga-me dessa vez 15 Sandfish e te darei 3 Dragonfruits e um pouco de experiencia como recompensa. Esses peixes só podem ser pescados no Lago da Avareza, em Crandoria. Boa sorte!", npc, creature)
							player:setStorageValue(Storage.Quest.Crandoria.CerdrasQuest.Progresso, 2)
							npcHandler:setTopic(playerId, 0)
						elseif chance == 3 then
							npcHandler:say("Eu estou ja muitos dias sem comer uma proteina que nao seja carne ou ovos de insetos gigantes. Sinto falta dos peixes que eu pescada em Crandoria. \z
							Nao tenho muito a oferecer, mas sempre consigo um carregamento com Donahue vindo de Astralis. Algumas vezes tambem consigo Tibia Coins. Enfim... \z
							Traga-me dessa vez 1 Bass e te darei 10 Astralis Coins e um pouco de experiencia como recompensa. Esses peixes só podem ser pescados no Lago da Avareza, em Crandoria. Boa sorte!", npc, creature)
							player:setStorageValue(Storage.Quest.Crandoria.CerdrasQuest.Progresso, 3)
							npcHandler:setTopic(playerId, 0)
						elseif chance == 4 then
							if paladin then
								npcHandler:say("Eu estou ja muitos dias sem comer uma proteina que nao seja carne ou ovos de insetos gigantes. Sinto falta dos peixes que eu pescada em Crandoria. \z
								Nao tenho muito a oferecer, mas sempre consigo um carregamento com Donahue vindo de Astralis. Algumas vezes tambem consigo Tibia Coins. Enfim... \z
								Traga-me dessa vez 10 Tiny Bass e te darei 1 Giant Leaf e um pouco de experiencia como recompensa. Esses peixes só podem ser pescados no Lago da Avareza, em Crandoria. Boa sorte!", npc, creature)
								player:setStorageValue(Storage.Quest.Crandoria.CerdrasQuest.Progresso, 4)
								npcHandler:setTopic(playerId, 0)
							elseif knight or monk then
								npcHandler:say("Eu estou ja muitos dias sem comer uma proteina que nao seja carne ou ovos de insetos gigantes. Sinto falta dos peixes que eu pescada em Crandoria. \z
								Nao tenho muito a oferecer, mas sempre consigo um carregamento com Donahue vindo de Astralis. Algumas vezes tambem consigo Tibia Coins. Enfim... \z
								Traga-me dessa vez 10 Tiny Bass e te darei 1 Exquisite Wood e um pouco de experiencia como recompensa. Esses peixes só podem ser pescados no Lago da Avareza, em Crandoria. Boa sorte!", npc, creature)
								player:setStorageValue(Storage.Quest.Crandoria.CerdrasQuest.Progresso, 4)
								npcHandler:setTopic(playerId, 0)
							else
								npcHandler:say("Eu estou ja muitos dias sem comer uma proteina que nao seja carne ou ovos de insetos gigantes. Sinto falta dos peixes que eu pescada em Crandoria. \z
								Nao tenho muito a oferecer, mas sempre consigo um carregamento com Donahue vindo de Astralis. Algumas vezes tambem consigo Tibia Coins. Enfim... \z
								Traga-me dessa vez 10 Tiny Bass e te darei 1 Mystic Root e um pouco de experiencia como recompensa. Esses peixes só podem ser pescados no Lago da Avareza, em Crandoria. Boa sorte!", npc, creature)
								player:setStorageValue(Storage.Quest.Crandoria.CerdrasQuest.Progresso, 4)
								npcHandler:setTopic(playerId, 0)
							end
						elseif chance == 5 then
							npcHandler:say("Pra ser sincero estou com um dinheiro sobrando e dessa vez nao quero um peixe, mas um prato com peixes! \z
							Nao tenho muito a oferecer, mas sempre consigo um carregamento com Donahue vindo de Astralis. Algumas vezes tambem consigo Tibia Coins. Enfim... \z
							Traga-me dessa vez 1 Svargrond Salmon Filet e te darei 10 Tibia Coins e um pouco de experiencia como recompensa. Esses peixes só podem ser pescados no Lago da Avareza, em Crandoria. Boa sorte!", npc, creature)
							player:setStorageValue(Storage.Quest.Crandoria.CerdrasQuest.Progresso, 5)
							npcHandler:setTopic(playerId, 0)
						end
					else
						npcHandler:say("Faz pouco tempo que voce me ajudou. Retorne em "..timeLeft.." minutos e te darei uma nova missao.", npc, creature)
						npcHandler:setTopic(playerId, 0)
					end
				elseif storage == 1 then
					npcHandler:say("Voce trouxe os 3 Small Basses?", npc, creature)
					npcHandler:setTopic(playerId, 1)
				elseif storage == 2 then
					npcHandler:say("Voce trouxe os 20 Sandfish?", npc, creature)
					npcHandler:setTopic(playerId, 2)
				elseif storage == 3 then
					npcHandler:say("Voce trouxe o Bass?", npc, creature)
					npcHandler:setTopic(playerId, 3)
				elseif storage == 4 then
					npcHandler:say("Voce trouxe os 10 Tiny Bass?", npc, creature)
					npcHandler:setTopic(playerId, 4)
				elseif storage == 5 then
					npcHandler:say("Voce trouxe o Svargrond Salmon Filet?", npc, creature)
					npcHandler:setTopic(playerId, 5)
				end
			end
		end
	elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
		if npcHandler:getTopic(playerId) == 1 then
			if player:getItemCount(32044) >= 3 then
				player:removeItem(32044, 3)
				player:addItem(4061, 1)
				npcHandler:say("Uh! Parecem frescos! Aqui esta sua recompensa. Volte em 3 dias e talvez eu queira outros peixes.", npc, creature)
				player:addExperience(1000000, true)
				player:setStorageValue(Storage.Quest.Crandoria.CerdrasQuest.Progresso, 0)
				player:setStorageValue(Storage.Quest.Crandoria.CerdrasQuest.Timer, os.time() + 3 * 24 * 60 * 60)
				local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Acho que voce se confundiu...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 2 then
			if player:getItemCount(13992) >= 15 then
				player:removeItem(13992, 15)
				player:addItem(11682, 3)
				npcHandler:say("Uh! Parecem frescos! Aqui esta sua recompensa. Volte em 3 dias e talvez eu queira outros peixes.", npc, creature)
				player:addExperience(1000000, true)
				player:setStorageValue(Storage.Quest.Crandoria.CerdrasQuest.Progresso, 0)
				player:setStorageValue(Storage.Quest.Crandoria.CerdrasQuest.Timer, os.time() + 3 * 24 * 60 * 60)
				local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Acho que voce se confundiu...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 3 then
			if player:getItemCount(32043) >= 1 then
				player:removeItem(32043, 1)
				player:addItem(22724, 10)
				npcHandler:say("Uh! Parece fresco! Aqui esta sua recompensa. Volte em 3 dias e talvez eu queira outros peixes.", npc, creature)
				player:addExperience(1000000, true)
				player:setStorageValue(Storage.Quest.Crandoria.CerdrasQuest.Progresso, 0)
				player:setStorageValue(Storage.Quest.Crandoria.CerdrasQuest.Timer, os.time() + 3 * 24 * 60 * 60)
				local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Acho que voce se confundiu...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 4 then
			if player:getItemCount(32045) >= 10 then
				player:removeItem(32045, 10)
				if paladin then
					player:addItem(11550, 1)
				elseif knight or monk then
					player:addItem(11547, 1)
				else
					player:addItem(11551, 1)
				end
				npcHandler:say("Uh! Parece fresco! Aqui esta sua recompensa. Volte em 3 dias e talvez eu queira outros peixes.", npc, creature)
				player:addExperience(1000000, true)
				player:setStorageValue(Storage.Quest.Crandoria.CerdrasQuest.Progresso, 0)
				player:setStorageValue(Storage.Quest.Crandoria.CerdrasQuest.Timer, os.time() + 3 * 24 * 60 * 60)
				local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Acho que voce se confundiu...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 5 then
			if player:getItemCount(29413) >= 1 then
				player:removeItem(29413, 1)
				npcHandler:say("Ahh! O cheiro desse prato deve ser a melhor coisa que ja senti no Novo Continente. Muito obrigado! Aqui esta sua recompensa. \z
				Volte em tres dias e talvez eu queira algo mais.", npc, creature)
				player:addExperience(1000000, true)
				player:addTransferableCoins(10)
				player:setStorageValue(Storage.Quest.Crandoria.CerdrasQuest.Progresso, 0)
				player:setStorageValue(Storage.Quest.Crandoria.CerdrasQuest.Timer, os.time() + 3 * 24 * 60 * 60)
				local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Acho que voce se confundiu...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Bem vindo ao meu esconderijo. Busco por alguns {peixes} em troca de produtos trazidos de Astralis.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais.")
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
