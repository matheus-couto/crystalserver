local internalNpcName = "Eldoran the Ambitious"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = "Eldoran o Ambicioso"
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 1900, 
	lookHead = 95, 
	lookBody = 116, 
	lookLegs = 116, 
	lookFeet = 116, 
	lookAddons = 3, 
}

npcConfig.flags = {
	floorchange = false,
}

-- TODO: Confirmar se tem voices e quais são os textos
npcConfig.voices = {
	interval = 15000,
	chance = 50,
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

    local storage = player:getStorageValue(Storage.Quest.Crandoria.StagBastion.TeleportCourtWarlock)

    if MsgContains(message, "enfrentar") or MsgContains(message, "mission") or MsgContains(message, "missao") then
        if storage < 1 then
			npcHandler:say("Escute, jovem. Voce nao foi o primeiro a ter essa ideia de derrotar o Court Warlock e com certeza nao sera o ultimo, mas ha um obstaculo: Eu! \z
			Perdemos muitas vidas tentando derrota-lo e por isso minha funcao sera avaliar se voce tem o necessario para tal tarefa. Te darei uma simples missao antes. \z
			E entao, esta pronto para sua provacao?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif storage == 1 then
			npcHandler:say("Voce trouxe os 10 bicos de harpia?", npc, creature)
            npcHandler:setTopic(playerId, 2)
		elseif storage == 2 then
			npcHandler:say("Agora nao ha razao para ter medo... Siga seu caminho.", npc, creature)
            npcHandler:setTopic(playerId, 0)
		end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Muito bem... Entao preste atencao: Ocasionalmente somos atacados na ilha por Night Harpies. Essas criaturas sao agressivas e podem te destruir rapidamente. \z
			Precisamos de ajuda para elimina-las. Nao posso vigiar seu progresso, preciso ficar no meu posto, mas para provar que voce conseguiu derrota-las, traga-me 10 de seus bicos (night harpy beak). \z
			Use uma obsidian knife para remover o bico apos derrota-las. Traga 5 deles para mim e permitirei sua passagem.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.StagBastion.TeleportCourtWarlock, 1)
            npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 2 then
			if player:getItemCount(52632) >= 5 then
				player:removeItem(52632, 5)
				player:setStorageValue(Storage.Quest.Crandoria.StagBastion.TeleportCourtWarlock, 2)
				local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
				player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
				player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
				npcHandler:say("...quatro, CINCO! Otimo! Talvez voce nao seja um completo inutil afinal. Como combinado, voce pode passar e enfrentar o Court Warlock. \z
				Boa sorte!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao tem bicos o suficiente.", npc, creature)
            	npcHandler:setTopic(playerId, 0)
			end
        end
    end
end

npcHandler:setMessage(MESSAGE_GREET, "Um intruso na ilha de Stag Bastion? Veio {enfrentar} o Court Warlock, eu presumo...")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "...")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
