local internalNpcName = "Lagarta Azul"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookTypeEx = 25444
}

npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 60000,
	chance = 50,
	{text = 'Quem esta ai? Nao consigo ver com toda essa fumaca! Ola??'}
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

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId() 

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

    if MsgContains(message, player:getName():lower()) or MsgContains(message, player:getName()) then
		if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) <= 9 then
			player:getPosition():sendMagicEffect(CONST_ME_REDSMOKE)
			player:say('Eu nunca vi ou ouvi sobre voce na vida. E voce parece grande demais para alguém confiavel! Sinto muito e adeus!', TALKTYPE_MONSTER_SAY, false, player, Position(4498, 4689, 14))
			npc:getPosition():sendMagicEffect(CONST_ME_PURPLESMOKE)
			npc:remove()
			local bluebutterfly = Game.createMonster("Borboleta Azul", Position(4498, 4689, 14))
			if bluebutterfly then
				addEvent(function()
					bluebutterfly:getPosition():sendMagicEffect(CONST_ME_EARLY_THUNDER)
					addEvent(function()
						bluebutterfly:remove()
					end, 1000)
				end, 1500)
			npcHandler:setTopic(playerId, 0)
			end
		elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) >= 10 then
			if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Lagarta) < 1 then
				npcHandler:say("Ah, claro... Poff.. Poff.. O Gato me falou de voce... Esta aqui para completar sua {missao}, nao e mesmo? Poff... Poff...", npc, creature)
				player:getPosition():sendMagicEffect(CONST_ME_GREENSMOKE)
				addEvent(function()
					npc:getPosition():sendMagicEffect(CONST_ME_REDSMOKE)
				end, 500)
				npcHandler:setTopic(playerId, 1)
			elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Lagarta) == 1 then
				npcHandler:say("Ah! Claro.. Poff.. Poff.. Nao consegui ver em meio a fumaca. Entao voce retornou! Conseguiu derrotar o monstro?", npc, creature)
				npc:getPosition():sendMagicEffect(CONST_ME_GREENSMOKE)
				addEvent(function()
					player:getPosition():sendMagicEffect(CONST_ME_REDSMOKE)
				end, 500)
				npcHandler:setTopic(playerId, 3)
			end
		end
	elseif MsgContains(message, "missao") or MsgContains(message, "mission") then
		if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Lagarta) < 1 then
			npcHandler:say("Bom, como pode ver sou uma lagarta vivendo em uma concha de caracol. Poff... Poff... Vivo assim porque o local onde eu vivia foi tomado por monstros enormes! Fomos expulsos de lá. \z
			Alem disso, ha um monstro terrivel que domina todos os demais. Poff... Poff... Ele pode ser implacavel, nao sei se voce sobrevivera... Mas voce parece grande o suficiente para desafia-los. Poff... Poff... \z
			Para provar que voce derrotou mesmo o monstro, precisara trazer algo que comprove sua morte. Poff... Voce aceita essa tarefa?", npc, creature)
			npc:getPosition():sendMagicEffect(CONST_ME_YELLOWSMOKE)
			addEvent(function()
			player:getPosition():sendMagicEffect(CONST_ME_PURPLESMOKE)
			end, 1000)
			npcHandler:setTopic(playerId, 2)
		end
	elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 2 then
			player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Lagarta, 1)
			npcHandler:say("Tudo bem. Apesar de nao confiar em pessoas tao grandes, te darei entao um voto de confianca. Poff.. Poff.. Entre no vortex de areia que esta logo atras dessas arvores para chegar ao local. \z
			Estarei esperando pela prova de que a terrivel criatura foi morta! Poff.. Poff..", npc, creature)
			npc:getPosition():sendMagicEffect(CONST_ME_REDSMOKE)
			addEvent(function()
				player:getPosition():sendMagicEffect(CONST_ME_GREENSMOKE)
			end, 1000)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 3 then
			npcHandler:say("Mesmo? Sabe que eu nao confio em seres gigantes... Poff.. Poff.. Voce trouxe alguma prova da sua vitoria?", npc, creature)
			player:getPosition():sendMagicEffect(CONST_ME_PURPLESMOKE)
			addEvent(function()
				npc:getPosition():sendMagicEffect(CONST_ME_REDSMOKE)
			end, 500)
			npcHandler:setTopic(playerId, 4)
		elseif npcHandler:getTopic(playerId) == 4 then
			if player:removeItem(8827, 1) then
				player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Lagarta, 2)
				player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress, player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress + 1))
				player:addExperience(10000000)
				player:addOutfitAddon(575, 1)
				player:addOutfitAddon(574, 1)
				local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
				player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
				player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
				npcHandler:say("Isso seria... o... OLHO? Ha ha! Poff.. Poff.. Voce realmene conseguiu. Nao duvidarei mais de voce. Direi ao Gato que voce me ajudou. Pode ir!", npc, creature)
				player:getPosition():sendMagicEffect(CONST_ME_PURPLESMOKE)
				addEvent(function()
					npc:getPosition():sendMagicEffect(CONST_ME_REDSMOKE)
				end, 500)
			else
				player:getPosition():sendMagicEffect(CONST_ME_REDSMOKE)
				player:say('Nao estou vendo prova alguma... Poff.. Poff.. Voce esta tentando me enganar?? Volte quando tiver uma prova de que voce realmente derrotoua quele monstro terrivel!', TALKTYPE_MONSTER_SAY, false, player, Position(4498, 4689, 14))
				npc:getPosition():sendMagicEffect(CONST_ME_PURPLESMOKE)
				npc:remove()
				local bluebutterfly = Game.createMonster("Borboleta Azul", Position(4498, 4689, 14))
				if bluebutterfly then
					addEvent(function()
						bluebutterfly:getPosition():sendMagicEffect(CONST_ME_EARLY_THUNDER)
						addEvent(function()
							bluebutterfly:remove()
						end, 1000)
					end, 1500)
				npcHandler:setTopic(playerId, 0)
				end
			end
		end
	end
end

keywordHandler:addKeyword({'coelho', 'rabbit'}, StdModule.say, {npcHandler = npcHandler, text = ''})



npcHandler:setMessage(MESSAGE_GREET, "Quem... es... tu...?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "E cuidado com onde pisa!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
