local internalNpcName = "Varo"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 151,
	lookHead = 0,
	lookBody = 68,
	lookLegs = 44,
	lookFeet = 59,
	lookAddons = 1,
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
    
    local storage = player:getStorageValue(Storage.Quest.Crandoria.VaroQuest.Progresso)

    if MsgContains(message, "mission") or MsgContains(message, "missao") or MsgContains(message, "missoes") then
        if storage < 1 then
            npcHandler:say("Se quiser negociar comigo precisa antes mostrar seu valor. Meu trabalho pode ser muito arriscado, sabe? \z
            Os objetos e recursos que eu adquiro podem ser levados para qualquer lugar. Para pessoas boas ou ruins, nao cabe a mim julgar.\z
            Se quiser negociar comigo, tera que provar ser alguem de extrema confianca... O que acha? Esta pronto para se provar?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        elseif storage == 1 then
            npcHandler:say("Traga o carregamento de Umbra para mim. Nao demore!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 2 then
            npcHandler:say("E entao? Encontrou o carregamento? Trouxe tudo com voce?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif storage == 3 then
            npcHandler:say("Veremos se posso confiar um carregamento ainda mais valioso a voce. Ja viajou a Nagaeth? Se nao, prepare-se. \z
            O proximo carregamento foi deixado em uma pequena praia em Nagaeth. Voce pode precisar de alguma permissao para alcancar o local... \z
            So posso dizer que o carregamento estara na regiao norte da ilha. Pegue os itens da caixa e traga-os para mim.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.VaroQuest.Progresso, 4)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 4 then
            npcHandler:say("Traga o carregamento de Nagaeth para mim. Estou esperando...", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 5 then
            npcHandler:say("E entao? Encontrou o carregamento? Trouxe os itens com voce?", npc, creature)
            npcHandler:setTopic(playerId, 3)
        elseif storage == 6 then
            npcHandler:say("O proximo carregamento esta num local de dificil dificil acesso e um tanto quanto perigoso. Mas sei que voce conseguira! \z
            Na ilha de Krotkah, dentro do quenion passando por algumas Black Hydras, voce encontrada o carregamento. Itens valiosos estao dentro da caixa. \z
            Talvez a tentacao seja grande para ficar com eles para si. Mas pense bem sobre essa decisao... Estarei esperando pelo seu retorno.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.VaroQuest.Progresso, 7)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 7 then
            npcHandler:say("Traga o carregamento de Krotkah para mim. Estou esperando...", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 8 then
            npcHandler:say("Voce retornou mesmo? Ha! Parece que alguem realmente quer fazer negocios. Esta com todos os itens?", npc, creature)
            npcHandler:setTopic(playerId, 4)
        elseif storage == 9 then
            npcHandler:say("Escute... Voce ja deve ter percebido que o que faco por aqui nao pode ser chamado de 'legal', certo? Mas eu chamaria de um trabalho necessario. \z
            Algumas pessoas foram expulsas das cidades do Novo Continente em razao de crimes cometidos no passado. Mas essas pessoas tambem precisam de equipamentos para sobreviver. \z
            Precisam de roupas, de comida... Enfim. Preciso que entenda isso antes da sua proxima missao. Voce tera que viajar para longe daqui. Esta preparado?", npc, creature)
            npcHandler:setTopic(playerId, 5)
        elseif storage == 10 then
            npcHandler:say("Traga o carregamento das Ice Lands para mim. Ele esta perdido em alguma das pequenas ilhas. Encontre-o!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 11 then
            npcHandler:say("E entao.. Encontrou o carregamento perdido? Trouxe todos os itens para mim?", npc, creature)
            npcHandler:setTopic(playerId, 6)
        elseif storage == 12 then
            npcHandler:say("Nao tenho mais missoes para voce. Me diga caso queira negociar.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Tudo bem. Sempre podemos dar uma chance, mas nao desperdice a oportunidade! Preste bem atencao: \z
            Ha um carregamento chegando em Umbra agora mesmo. Nao sei onde ele aparecera, mas sera em algum lugar da costa. Procure por uma caixa. \z
            Pegue o conteudo, deixe a caixa para tras e traga o que tiver dentro para mim. Estarei esperando.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.VaroQuest.Progresso, 1)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getItemCount(3375) >= 1 and player:getItemCount(3357) >= 1 and player:getItemCount(3556) >= 1 then
                player:removeItem(3375, 1)
                player:removeItem(3357, 1)
                player:removeItem(3556, 1)
                player:addExperience(1000000)
                npcHandler:say("Bom, voce trouxe tudo. Isso parece bom, mas ainda nao sera o suficiente... me avise quando estiver pronto para a proxima {missao}.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.VaroQuest.Progresso, 3)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao tem todo o carregamento. Parece que nao posso confiar em voce afinal...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 3 then
            if player:getItemCount(3360) >= 1 and player:getItemCount(3382) >= 1 then
                player:removeItem(3360, 1)
                player:removeItem(3382, 1)
                player:addExperience(2000000)
                npcHandler:say("Certo, certo... Muito bem, voce esta realmente mostrando seu valor. Que tal uma ultima {missao}? Se terminar a proxima, poderei negociar alguns itens com voce...", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.VaroQuest.Progresso, 6)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao tem todo o carregamento. Parece que nao posso confiar em voce afinal...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 4 then
            if player:getItemCount(3366) >= 1 and player:getItemCount(3364) >= 1 and player:getItemCount(4061) >= 1 then
                player:removeItem(3366, 1)
                player:removeItem(3364, 1)
                player:removeItem(4061, 1)
                player:addExperience(3000000)
                npcHandler:say("Armadura... Golden legs... Eldritch Fragment... Certo! Esta tudo aqui. Muito bem, voce realmente demonstrou ser de confianca.\z
                A partir de hoje comprarei os seguintes itens de voce: Frutos colhidos e bebidas de Astralis, Livros Sagrados e Silver e Gold Tokens. \z
                Caso queira negociar outros itens, tera que me ajudar em mais {missoes}.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.VaroQuest.Progresso, 9)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao tem todo o carregamento. Nao diga que quer ficar com algo para si...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 5 then
            npcHandler:say("Preste muita atencao. Um dos nossos carregamentos se perdeu nas ilhas geladas proximas a Icehold. Nao sabemos onde ele esta. \z
            Talvez alguem carregou a caixa para um local seguro ate que encontrem uma forma de abri-la. Nao sei... Para isso preciso da sua ajuda. \z
            Encontre a caixa e traga o carregamento ate mim. Estou te confiando uma missao muito dificil, mas tambem muito importante. Espero que consiga!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.VaroQuest.Progresso, 10)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 6 then
            if player:getItemCount(8053) >= 1 and player:getItemCount(7417) >= 1 and player:getItemCount(3342) >= 1 then
                player:removeItem(8053, 1)
                player:removeItem(7417, 1)
                player:removeItem(3342, 1)
                player:addExperience(5000000)
                npcHandler:say("Incrivel! Voce conseguiu mesmo. Este carregamento estava perdido ha dias! Bom, como combinado, voce agora podera negociar mais itens. \z
                Porem nao fara isso comigo, e sim com meu imediato logo abaixo de nos. Desca pelo acesso ao lado e ira encontra-lo. Te desejo sorte.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.VaroQuest.Progresso, 12)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao tem todo o carregamento.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    end
end

local function onTradeRequest(npc, creature)
    local player = creature:getPlayer()
	if player:getStorageValue(Storage.Quest.Crandoria.VaroQuest.Progresso) < 9 then
		npcHandler:say('Sinto muito, viajante, mas so negocio com pessoas de confianca.', npc, creature)
		return false
	end

    if (os.date("%A") ~= "Wednesday") and (os.date("%A") ~= "Sunday") then
		npcHandler:say('Por motivos de seguranca, so negocio nas quartas e aos domingos. Retorne depois.', npc, creature)
		return false
	end

	return true
end

npcConfig.shop = {
    -- { name = "aubergine", clientId = 11460, sell = 1200 },
    { name = "bunch of winterberries", clientId = 12252, sell = 6000 },
    { name = "dragonfruit", clientId = 11682, sell = 6000 },
    { name = "silver token", clientId = 22516, sell = 10000 },
    { name = "gold token", clientId = 22721, sell = 15000 },
    { name = "livro sagrado", clientId = 25745, sell = 6000 },
}

npcHandler:setCallback(CALLBACK_ON_TRADE_REQUEST, onTradeRequest)

npcHandler:setMessage(MESSAGE_GREET, "Compro artigos de luxo de pessoas confiaveis. O que tem para oferecer?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("trade", "bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
