local internalNpcName = "An Apparition"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 568
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

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()

	local storage = player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.Outfit)

	local storageMegalomania = player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.KillMegalomania)
	local storagePrimal = player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.KillPrimalMenace)

    if MsgContains(message, "missao") or MsgContains(message, "mission") then
        if storage < 3 then
			npcHandler:say("Sua alma nao parece forte o suficiente nem mesmo para realizar meu teste de poder. Voce com certeza nao esta pronto para se encontrar com Apocalypse.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 3 then
			npcHandler:say("Para acessar as masmorras de Apocalypse voce deve passar por um simples teste, comprovando assim sua forca. O teste se consiste em duas etapas. \z
			Primeiro, voce deve trazer 3 Bloody Tears para mim. Que tal? Sei que voce nao tera dificuldades para consegui-las. Va! Estou aguardando.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.TheRedPath.Outfit, 4)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 4 then
			npcHandler:say("Voce trouxe as 3 Bloody Tears?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif storage == 5 then
			if storageMegalomania < 1 and storagePrimal < 1 then
				npcHandler:say("Voce ainda nao entendeu? A primeira parte do seu teste sera derrotar Goshnar's Megalomania e The Primal Menace. Va logo!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				if storageMegalomania < 1 then
					npcHandler:say("Voce ainda nao derrotou Goshnar's Megalomania.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				elseif storagePrimal < 1 then
					npcHandler:say("Voce ainda nao derrotou The Primal Menace.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				elseif storageMegalomania >= 1 and storagePrimal >= 1 then
					npcHandler:say("Hmm.. Voce conseguiu mesmo. Muitos, como eu, morrem ao tentar completar esse teste. Muito bem, eu cumprirei com minha palavra. \z
					A partir de agora voce podera acessar os dominios de Apocalypse quando quiser. Ah! E boa sorte... Ha ha ha ha ha!", npc, creature)
					player:setStorageValue(Storage.Quest.Crandoria.TheRedPath.Outfit, 6)
					npcHandler:setTopic(playerId, 0)
				end
			end
		end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
			if player:getItemCount(32594) >= 3 then
				player:removeItem(32594, 3)
				player:addExperience(5000000)
				player:setStorageValue(Storage.Quest.Crandoria.TheRedPath.Outfit, 5)
				player:setStorageValue(Storage.Quest.Crandoria.TheRedPath.KillPrimalMenace, 0)
				player:setStorageValue(Storage.Quest.Crandoria.TheRedPath.KillMegalomania, 0)
				npcHandler:say("Que bela oportun... digo... muito bem, voce passou da primeira etapa. Agora, vejamos se da conta da segunda parte do seu teste: \z
				Derrote Goshnar's Megalomaina e The Primal Menace ao menos uma vez cada um.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Nao, voce nao as possui... Se continuar tentando me enganar farei com que voce nunca consiga entrar nos dominiod de Apocalypse!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Hmm.. um ser ainda vivo... Nao ficara vivo por muito tempo!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")

-- npcType registering the npcConfig table
npcType:register(npcConfig)