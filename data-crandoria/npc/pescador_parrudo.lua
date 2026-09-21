local internalNpcName = "Dave Johnes"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 463,
	lookHead = 0,
	lookBody = 114,
	lookLegs = 33,
	lookFeet = 26,
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

    local possibleItems1 = {
        {name = "opal", id = 22194 },
        {name = "cobalt ridge", id = 39037 },
        {name = "gold ingot", id = 9058 },
        {name = "giant shimmering pearl", id = 281 },
        {name = "ancient coin", id = 24390 },
        {name = "silver token", id = 22516 },
        {name = "emerald bangle", id = 3010 },
        {name = "gemmed figurine", id = 24382 },
        {name = "rainbow quartz", id = 25737 },
    }
    
    local selectedItem1 = possibleItems1[math.random(1, #possibleItems1)]

    -- local imbuements = {
    --     ["blackade"] = {
    --         basic     = { {id = 9641, count = 20} },  -- Piece of Scarab Shell
    --         intricate = { {id = 11703, count = 25} },  -- Brimstone Shell
    --         powerful  = { {id = 20199, count = 25} }   -- Frazzle Skin
    --     },
    --     ["chop"] = {
    --         basic     = { {id = 10196, count = 20} }, 
    --         intricate = { {id = 11447, count = 25} }, 
    --         powerful  = { {id = 21200, count = 20} } 
    --     },
    --     ["epiphany"] = {
    --         basic     = { {id = 9635, count = 25} }, 
    --         intricate = { {id = 11452, count = 15} }, 
    --         powerful  = { {id = 10309, count = 15} } 
    --     },
    --     ["precision"] = {
    --         basic     = { {id = 11464, count = 25} }, 
    --         intricate = { {id = 18994, count = 20} }, 
    --         powerful  = { {id = 10298, count = 10} } 
    --     },
    --     ["slash"] = {
    --         basic     = { {id = 9691, count = 25} }, 
    --         intricate = { {id = 21202, count = 25} }, 
    --         powerful  = { {id = 9654, count = 5} } 
    --     },
    --     ["bash"] = {
    --         basic     = { {id = 9657, count = 20} }, 
    --         intricate = { {id = 22189, count = 15} }, 
    --         powerful  = { {id = 10405, count = 10} } 
    --     },
    --     ["reap"] = {
    --         basic     = { {id = 11484, count = 25} }, 
    --         intricate = { {id = 9647, count = 20} }, 
    --         powerful  = { {id = 10420, count = 5} } 
    --     },
    --     ["electrify"] = {
    --         basic     = { {id = , count = } }, 
    --         intricate = { {id = , count = } }, 
    --         powerful  = { {id = , count = } } 
    --     },
    --     [""] = {
    --         basic     = { {id = , count = } }, 
    --         intricate = { {id = , count = } }, 
    --         powerful  = { {id = , count = } } 
    --     },
    --     [""] = {
    --         basic     = { {id = , count = } }, 
    --         intricate = { {id = , count = } }, 
    --         powerful  = { {id = , count = } } 
    --     },
    -- }


    if MsgContains(message, "ticket") then
        if player:getStorageValue(Storage.Quest.Crandoria.PescaCustom.Access) > os.time() then
            npcHandler:say("Seu ticket ainda esta valendo. Voce pode acessar o lago por mais algum tempo.", npc, creature)
        else
            if player:getEffectiveSkillLevel(SKILL_FISHING) < 80 then
                npcHandler:say("Voce precisa possuir 80 de Fishing para comprar um Ticket e acessar o Lago.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("O ticket te da acesso ao lago por um total de um dia inteiro e custa 1 gold token. Voce gostaria de comprar um ticket?", npc, creature)
                npcHandler:setTopic(playerId, 1)
            end
        end
    elseif MsgContains(message, "missao") or MsgContains(message, "mission") then
        if player:getLevel() >= 250 and player:getSkillLevel(SKILL_FISHING) >= 80 then
            if player:getStorageValue(Storage.Quest.Crandoria.MissaoPesca.Item) < 1 then
                if player:getStorageValue(Storage.Quest.Crandoria.MissaoPesca.Timer) < os.time() then
                    local chance = math.random(1, 100)
                    if chance <= 98 then
                        npcHandler:say("Esta buscando por algumas minhocas especiais? Posso te oferecer algumas delas agora mesmo, basta me ajudar com uma simples tarefa... Escute bem: \z
                        Minha vida sempre foi no mar e sinto saudades dos tesouros que encontravamos aqui e ali. Como agora nao navego mais, estou buscando por alguns desses tesouros para me satisfazer. \z
                        Para me ajudar, traga-me 1 " ..selectedItem1.name.. " e como agradecimento te darei 200 das minhas minhocas especiais. Com elas voce obtera os melhores itens no lago. Estarei esperando!", npc, creature)
                        player:setStorageValue(Storage.Quest.Crandoria.MissaoPesca.Item, selectedItem1.id)
                        player:setStorageValue(Storage.Quest.Crandoria.MissaoPesca.Timer, os.time() + 23 * 60 * 60)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Nos meus tempos em alto mar, em meio a tempestades e muito caos, so havia uma coisa que me deixava tranquilo: O bom e velho rum! Mesmo que o mastro se partisse ao meio, se eu tivesse uma garrafa de rum... \z
                        Tudo ficava bem! Agora ja nao preciso me preocupar com o mar, mas ainda tenho sede de um bom e doce rum, sabe? Dizem que em Astralis sao produzidas as melhores garrafas de rum do Novo Continente. \z
                        Traga-me uma garrafa do rum produzido nas destilarias de Astralis e eu te darei... digamos... 300 minhocas especiais. Estarei esperando, por favor nao demore.", npc, creature) 
                        player:setStorageValue(Storage.Quest.Crandoria.MissaoPesca.Item, 36601)
                        player:setStorageValue(Storage.Quest.Crandoria.MissaoPesca.Timer, os.time() + 23 * 60 * 60)
                    end
                else
                    if player:getStorageValue(Storage.Quest.Crandoria.MissaoPesca.TimerGeral) > os.time() then
                        npcHandler:say("Voce ja entregou sua missao de hoje.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    else
                        if player:getStorageValue(Storage.Quest.Crandoria.MissaoPesca.Item) == 36601 then
                            npcHandler:say("Voce trouxe a minha Garrafa de Rum?", npc, creature)
                            npcHandler:setTopic(playerId, 2)
                        else
                            npcHandler:say("Como eu te disse, quero 1 " ..getItemName(player:getStorageValue(Storage.Quest.Crandoria.MissaoPesca.Item))..". Voce possui o item com voce?", npc, creature)
                            npcHandler:setTopic(playerId, 3)
                        end
                    end
                end
            else
                if player:getStorageValue(Storage.Quest.Crandoria.MissaoPesca.Item) == 36601 then
                    npcHandler:say("Voce trouxe a minha Garrafa de Rum?", npc, creature)
                    npcHandler:setTopic(playerId, 2)
                else
                    npcHandler:say("Como eu te disse, quero 1 " ..getItemName(player:getStorageValue(Storage.Quest.Crandoria.MissaoPesca.Item))..". Voce possui o item com voce?", npc, creature)
                    npcHandler:setTopic(playerId, 3)
                end
            end
        else
            npcHandler:say("Sinto muito, mas pela sua experiencia voce nao deve ter encontrado muitos tesouros por ai... Volte apos atingir o nivel 250 e obter ao menos 80 de Fishing e te darei sua missao.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
	elseif MsgContains(message, "primeiro dragao") then
		if player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso) == 3 then
			npcHandler:say("O Primeiro Dragao? Apesar de adorar uma boa lenda, conheco melhor lendas do oceano. \z
            Receio que eu nunca tenha ouvido falar sobre um dragao imortal. Espero que seja mentira! Ha ha ha ha!", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            if player:getItemCount(22721) >= 1 then
                player:removeItem(22721, 1)
                player:setStorageValue(Storage.Quest.Crandoria.PescaCustom.Access, os.time() + 60 * 60 * 24)
                npcHandler:say("Aqui esta seu ticket! Agora voce podera pescar por 24 horas no Lago de Crandoria.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Sem gold token, nada feito!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getItemCount(36601) >= 1 then
                player:removeItem(36601, 1)
                player:addItem(8177, 300)
                player:setStorageValue(Storage.Quest.Crandoria.MissaoPesca.TimerGeral, player:getStorageValue(Storage.Quest.Crandoria.MissaoPesca.Timer))
                player:setStorageValue(Storage.Quest.Crandoria.MissaoPesca.Item, 0)
                npcHandler:say("Muito bem. Aqui estao suas minhocas especiais.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Onde esta meu rum produzido em Astralis?", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 3 then
            if player:getItemCount(player:getStorageValue(Storage.Quest.Crandoria.MissaoPesca.Item)) >= 1 then
                player:removeItem(player:getStorageValue(Storage.Quest.Crandoria.MissaoPesca.Item), 1)
                player:addItem(8177, 200)
                player:setStorageValue(Storage.Quest.Crandoria.MissaoPesca.Item, 0)
                player:setStorageValue(Storage.Quest.Crandoria.MissaoPesca.TimerGeral, player:getStorageValue(Storage.Quest.Crandoria.MissaoPesca.Timer))
                npcHandler:say("Muito bem. Aqui estao suas minhocas especiais.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Como eu disse, traga-me 1 " ..getItemName(player:getStorageValue(Storage.Quest.Crandoria.MissaoPesca.Item)).."?", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) and npcHandler:getTopic(playerId) == 1 then
        npcHandler:say("Sem problemas! Me avise quando quiser pescar alguns itens valiosos.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola, amante da pesca. Se quiser pescar itens valiosos no lago de Crandoria, posso te vender um {ticket}. Mas talvez voce esteja interessado em me ajudar em uma {missao}...")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais! Volte quando quiser pescar alguns itens valiosos.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "worm", clientId = 3492, buy = 3 },
    { itemName = "fish", clientId = 3578, sell = 4 },
    { itemName = "sandfish", clientId = 13992, sell = 50 },
    { itemName = "tiny bass", clientId = 32045, sell = 75 },
    { itemName = "small bass", clientId = 32044, sell = 1000 },
    { itemName = "bass", clientId = 32043, sell = 15000 },
    
}
-- On buy npc shop message
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

npcType:addDialogOptions("trade", "bye")

-- npcType registering the npcConfig table
npcType:register(npcConfig)
