local internalNpcName = "Salazar"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1642,
	lookHead = 25,
	lookBody = 57,
	lookLegs = 57,
	lookFeet = 94,
	lookAddons = 3
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

    if MsgContains(message, "missao") or MsgContains(message, "mission") then
        if player:getStorageValue(Storage.Quest.Crandoria.WorldTeleports.Access) > 0 then
            if player:getStorageValue(Storage.Quest.Crandoria.TeleportRune.Progresso) < 1 then
                npcHandler:say({"Entao voce esta buscando por uma missao. Entendo... Na verdade eu realmente preciso de ajuda com uma tarefa, mas nao sei se voce seria a pessoa certa para executa-la. ...",
                "Ha alguns dias eu perdi uma das minhas receitas mais importantes: A receita das Teleportation Runes. Com essas runas eu consigo marcar coordenadas do Novo Continente para que eu possa, posteriormente, retornar a elas. ...",
                "Em uma de minhas batalhas contra algumas criaturas magicas nas profundezas de Nivabi eu tive que esconde-las em um pequeno abrigo na caverna, junto a alguns outros pertences. Voce acha que consegue me ajudar a encontra-la?"}, npc, creature)
                npcHandler:setTopic(playerId, 1)
            elseif player:getStorageValue(Storage.Quest.Crandoria.TeleportRune.Progresso) == 1 then
                if player:getItemCount(36586) >= 1 then
                    npcHandler:say("Voce encontrou a receita das Teleportation Runes?.", npc, creature)
                    npcHandler:setTopic(playerId, 2)
                else
                    npcHandler:say("Por favor, encontre a receita e traga-a ate mim e te darei uma otima recompensa! Voce podera encontra-la em uma das cavernas do arquipelago de Nivabi.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                end
            end
        else
            npcHandler:say("Sinto muito, mas eu so exponho meus interesses aos parceiros da Sociedade dos Magos. Se ainda nao faz parte da Sociedade, converse com meu irmao Baltazar. Ele fica no deserto de Valkesh e pode te ajudar a entrar para a Sociedade.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "teleportation rune") then
        if player:getStorageValue(Storage.Quest.Crandoria.TeleportRune.Progresso) < 2 then
            npcHandler:say("As teleportation runes podem ser utilizadas para te levar a um local onde voce ja esteve e que voce tenha marcado com uma magia especial. Posso te ensinar um pouco mais apos voce completar uma {missao} para mim.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.TeleportRune.Progresso) == 2 then
            npcHandler:say("Para utilizar as teleportation runes voce precisa antes aprender a Spell chamada {mark position}. Essa magia pode ser usada para marcar sua posicao atual, mas nao funciona em qualquer lugar. Se quiser posso te ensinar essa magia por apenas 1.000.000 de moedas de ouro (1kk). Voce gostaria de aprender essa nova magia?", npc, creature)
            npcHandler:setTopic(playerId, 3)
        end
    elseif MsgContains(message, "mark position") then
        if player:getStorageValue(Storage.Quest.Crandoria.TeleportRune.Progresso) == 2 then
            npcHandler:say("Deseja aprender a magia 'Mark Position' por 1.000.000 de moedas de ouro?", npc, creature)
            npcHandler:setTopic(playerId, 4)
        elseif player:getStorageValue(Storage.Quest.Crandoria.TeleportRune.Progresso) < 2 then
            npcHandler:say("Termine a {missao} e depois conversaremos sobre a magia nova.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Muito bom... Vejo que esta confiante. Mas escute bem: As criaturas que voce vai encontrar naquele lugar sao muito poderosas e podem acabar te dando muito trabalho. Se nao tiver certeza da sua capacidade, leve um time com voce! Aqui esta a chave da porta. Estarei esperando pelo seu retorno.", npc, creature)
            player:sendTextMessage(MESSAGE_HOTKEY_PRESSED, "Salazar te entregou uma chave. Agora voce podera abrir a porta do local.")
            player:setStorageValue(Storage.Quest.Crandoria.TeleportRune.Progresso, 1)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getItemCount(36586) >= 1 then
                player:removeItem(36586, 1)
                player:addExperience(1000000)
                npcHandler:say("Muito bom!! Voce foi mais rapido do que eu esperava, devo confessar. Como recompensa, basta me dizer e eu te ensinarei como utilizar suas proprias {teleportation runes}. Alem disso, a partir de agora venderei Runas para voce sempre que quiser. Basta solicitar por uma {troca}.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.TeleportRune.Progresso, 2)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("E onde esta a receita? Esta tentando me enganar? Nao volte aqui sem ela em maos!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 3 or npcHandler:getTopic(playerId) == 4 then
            if player:getLevel() >= 300 then
                if player:removeMoneyBank(1000000) then
                    -- player:learnSpell("Mark Position")
                    npcHandler:say("Muito bem. Voce aprendeu a magia Mark Position (utevo tempo grav). Agora podera marcar quase qualquer local da superficie estando com uma Teleportation Rune na backpack e, quando quiser retornar, basta utilizar a Runa para que ela seja consumida e voce seja teletransportado, mas cuidado! Isso consumira 100 dos seus Soul Points. Quano quiser comprar runas basta vir ate mim e oferecer uma {troca}.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.TeleportRune.Progresso, 3)
                    npcHandler:setTopic(playerId, 0)
                else
                    npcHandler:say("Voce nao possui dinheiro suficiente.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                end
            else
                npcHandler:say("Infelizmente voce ainda parece fraco para dominar esse nivel de poder magico. Volte apos o nivel 300.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) and npcHandler:getTopic(playerId) == 1 then
        npcHandler:say("Ah. Tudo bem, nao tem problema.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end

npcConfig.shop = {
	{ itemName = "teleportation rune", clientId = 3235, buy = 150000 },
}

local function onTradeRequest(npc, creature)
	if Player(creature):getStorageValue(Storage.Quest.Crandoria.TeleportRune.Progresso) < 3 then
		npcHandler:say('Para que voce quer negociar teleportation runes se nem mesmo conhece as palavras magicas? Volte apos finalizar a {missao} que eu te dei e aprender a spell {mark position}.', npc, creature)
		return false
	end

	return true
end

npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end

-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType)
end



npcHandler:setCallback(CALLBACK_ON_TRADE_REQUEST, onTradeRequest)

npcHandler:setMessage(MESSAGE_GREET, "Ola, jovem viajante. O que faz por aqui?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
