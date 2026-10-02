local internalNpcName = "Captain Donahue"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 472,
	lookHead = 0,
	lookBody = 114,
	lookLegs = 20,
	lookFeet = 39,
	lookAddons = 0
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

    local storage = player:getStorageValue(Storage.Quest.Crandoria.CaptainDonahue.Treasure)
    local rep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)

    if MsgContains(message, "treasure") or MsgContains(message, "tesouro") or MsgContains(message, "passage") or MsgContains(message, "sail") or MsgContains(message, "viagem") then
        -- if storage < 1 then
        --     npcHandler:say("Ofereco meus servicos de viagem a qualquer um que puder me ajudar a recuperar um tesouro perdido. \z
        --     Ele se consiste em 1 Holy Falcon, 1 Holy Scarab e 50 Gold Tokens. Voce tem esses itens com voce?", npc, creature)
        --     npcHandler:setTopic(playerId, 1)
        -- else
            npcHandler:say("Posso te levar para {Crandoria}, {Trivallis}, {Dracantus}, {Ravencrest}, {Gnomprona}, {Tartarus} ou {Krotkah}. Basta escolher o destino.", npc, creature)
            npcHandler:setTopic(playerId, 2)
        -- end
    elseif MsgContains(message, "crandoria") then
        if npcHandler:getTopic(playerId) == 2 or storage > 0 then
            npcHandler:say("Serao 1000 Gold Coins para viajar ate Crandoria. Esta pronto para a viagem? (gratuito para Reconhecidos)", npc, creature)
            npcHandler:setTopic(playerId, 3)
        end
    elseif MsgContains(message, "ravencrest") then
        if npcHandler:getTopic(playerId) == 2 or storage > 0 then
            npcHandler:say("Serao 10000 Gold Coins para viajar ate Ravencrest. Esta pronto para a viagem? (gratuito para Reconhecidos)", npc, creature)
            npcHandler:setTopic(playerId, 4)
        end
    elseif MsgContains(message, "gnomprona") then
        if npcHandler:getTopic(playerId) == 2 or storage > 0 then
            npcHandler:say("Serao 10000 Gold Coins para viajar ate Gnomprona. Esta pronto para a viagem? (gratuito para Reconhecidos)", npc, creature)
            npcHandler:setTopic(playerId, 5)
        end
    elseif MsgContains(message, "tartarus") then
        if npcHandler:getTopic(playerId) == 2 or storage > 0 then
            npcHandler:say("Serao 20000 Gold Coins para viajar ate Tartarus. Esta pronto para a viagem? (gratuito para Reconhecidos)", npc, creature)
            npcHandler:setTopic(playerId, 6)
        end
    elseif MsgContains(message, "krotkah") then
        if npcHandler:getTopic(playerId) == 2 or storage > 0 then
            npcHandler:say("Serao 10000 Gold Coins para viajar ate Krotkah. Esta pronto para a viagem? (gratuito para Reconhecidos)", npc, creature)
            npcHandler:setTopic(playerId, 7)
        end
    elseif MsgContains(message, "dracantus") then
        if npcHandler:getTopic(playerId) == 2 or storage > 0 then
            npcHandler:say("Serao 10000 Gold Coins para viajar ate Krotkah. Esta pronto para a viagem? (gratuito para Reconhecidos)", npc, creature)
            npcHandler:setTopic(playerId, 8)
        end
    elseif MsgContains(message, "trivallis") then
        if npcHandler:getTopic(playerId) == 2 or storage > 0 then
            npcHandler:say("Serao 10000 Gold Coins para viajar ate Krotkah. Esta pronto para a viagem? (gratuito para Reconhecidos)", npc, creature)
            npcHandler:setTopic(playerId, 7)
        end
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
        if npcHandler:getTopic(playerId) == 1 then
            if player:getItemCount(3024) == 0
            or player:getItemCount(3023) == 0
            or player: getItemCount(22721) < 50 then
                npcHandler:say("Voce acha que sou idiota? Preciso de 1 Holy Falcon, 1 Holy Scarab e 50 Gold Tokens.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                player:removeItem(3024, 1)
                player:removeItem(3023, 1)
                player:removeItem(22721, 50)
                player:setStorageValue(Storage.Quest.Crandoria.CaptainDonahue.Treasure, 1)
                npcHandler:say("Voce conseguiu mesmo? Incrivel! Agora sim, considere-se parte da minha tripulacao! Ha ha ha ha. Fale comigo quando quiser fazer uma {viagem}.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 3 then
            local cost = rep >= 10 and 0 or 1000
            if player:removeMoneyBank(cost) then
                npcHandler:say("Espero que tenha uma boa viagem.", npc, creature)
                player:teleportTo(Position(5041, 5066, 6))
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Sinto muito, mas voce nao tem dinheiro o suficiente.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 4 then
            local cost = rep >= 10 and 0 or 10000
            if player:removeMoneyBank(cost) then
                npcHandler:say("Espero que tenha uma boa viagem.", npc, creature)
                player:teleportTo(Position(5566, 4877, 6))
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Sinto muito, mas voce nao tem dinheiro o suficiente.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 5 then
            local cost = rep >= 10 and 0 or 10000
            if player:removeMoneyBank(cost) then
                npcHandler:say("Espero que tenha uma boa viagem.", npc, creature)
                player:teleportTo(Position(5650, 4804, 13))
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Sinto muito, mas voce nao tem dinheiro o suficiente.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 6 then
            local cost = rep >= 10 and 0 or 20000
            if player:removeMoneyBank(cost) then
                npcHandler:say("Espero que tenha uma boa viagem.", npc, creature)
                player:teleportTo(Position(5626, 4666, 6))
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Sinto muito, mas voce nao tem dinheiro o suficiente.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 7 then
            local cost = rep >= 10 and 0 or 10000
            if player:removeMoneyBank(cost) then
                npcHandler:say("Espero que tenha uma boa viagem.", npc, creature)
                player:teleportTo(Position(5916, 4728, 6))
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Sinto muito, mas voce nao tem dinheiro o suficiente.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 8 then
            local cost = rep >= 10 and 0 or 10000
            if player:removeMoneyBank(cost) then
                npcHandler:say("Espero que tenha uma boa viagem.", npc, creature)
                player:teleportTo(Position(4489, 5104, 6))
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Sinto muito, mas voce nao tem dinheiro o suficiente.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 9 then
            local cost = rep >= 10 and 0 or 10000
            if player:removeMoneyBank(cost) then
                npcHandler:say("Espero que tenha uma boa viagem.", npc, creature)
                player:teleportTo(Position(5694, 5482, 6))
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Sinto muito, mas voce nao tem dinheiro o suficiente.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola, jovem |PLAYERNAME|. Precisa de uma {passagem}?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye. You are welcome.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("passage", "bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)










-- local internalNpcName = "Captain Donahue"
-- local npcType = Game.createNpcType(internalNpcName)
-- local npcConfig = {}

-- npcConfig.name = internalNpcName
-- npcConfig.description = internalNpcName

-- npcConfig.health = 100
-- npcConfig.maxHealth = npcConfig.health
-- npcConfig.walkInterval = 2000
-- npcConfig.walkRadius = 2

-- npcConfig.outfit = {
-- 	lookType = 472,
-- 	lookHead = 0,
-- 	lookBody = 114,
-- 	lookLegs = 20,
-- 	lookFeet = 39,
-- 	lookAddons = 0
-- }

-- local keywordHandler = KeywordHandler:new()
-- local npcHandler = NpcHandler:new(keywordHandler)

-- npcType.onThink = function(npc, interval)
--     npcHandler:onThink(npc, interval)
-- end

-- npcType.onAppear = function(npc, creature)
--     npcHandler:onAppear(npc, creature)
-- end

-- npcType.onDisappear = function(npc, creature)
--     npcHandler:onDisappear(npc, creature)
-- end

-- npcType.onMove = function(npc, creature, fromPosition, toPosition)
--     npcHandler:onMove(npc, creature, fromPosition, toPosition)
-- end

-- npcType.onSay = function(npc, creature, type, message)
--     npcHandler:onSay(npc, creature, type, message)
-- end

-- npcType.onCloseChannel = function(npc, creature)
--     npcHandler:onCloseChannel(npc, creature)
-- end

-- local function creatureSayCallback(npc, creature, type, message)
--     local player = Player(creature)
--     local playerId = player:getId()

--     if not npcHandler:checkInteraction(npc, creature) then
--         return false
--     end

--     if MsgContains(message, "treasure") or MsgContains(message, "tesouro") then
--         if player:getStorageValue(Storage.Quest.Crandoria.CaptainDonahue.Treasure) == 1 then
--             npcHandler:say("Obrigado por recuperar meu tesouro!", npc, creature)
--             return true
--         else
--             npcHandler:say("Um {Holy Falcon}, um {Holy Scarab} e 200 {Gold Tokens} sao a principal parte do meu tesouro. Voce tem esses itens com voce?", npc, creature)
--             npcHandler:setTopic(playerId, 1)
--         end
--     elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
--         if npcHandler:getTopic(playerId) == 1 then
--             if player:getItemCount(3024) == 0
--             or player:getItemCount(3023) == 0
--             or player: getItemCount(22721) < 200 then
--                 npcHandler:say("Voce acha que sou idiota?", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--                 return true
--             end

--             npcHandler:say("Nao acredito! Voce realmente recuperou os itens! \z
--                     Se voce me der estes itens eu posso te ajudar com meus servidos. Esta interessado?", npc, creature)
--             npcHandler:setTopic(playerId, 2)
--         elseif npcHandler:getTopic(playerId) == 2 then
--             if player:getItemCount(3024) >= 1 and player:getItemCount(3023) >= 1 and player:getItemCount(22721) >= 200 then
--                 -- if not player:removeItem(3024, 1) then
--                 --     npcHandler:say("Voce nao tem o Holy Falcon.", npc, creature)
--                 --     return true
--                 -- end
            
--                 -- if not player:removeItem(3023, 1) then
--                 --     npcHandler:say("Voce nao tem o Holy Scarab.", npc, creature)
--                 --     return true
--                 -- end
            
            
--                 -- if not player:removeItem(22721, 200) then
--                 --     npcHandler:say("Voce nao possui todos os Gold Tokens.", npc, creature)
--                 --     return true
--                 -- end
--                 player:removeItem(3024, 1)
--                 player:removeItem(3023, 1)
--                 player:removeItem(22721, 200)
            
--                 npcHandler:say("Obrigado! Eu te considero um companheiro de viagem de agora em diante! \z
--                     Me avise se precisar de uma {passagem}!", npc, creature)
--                 player:setStorageValue(Storage.Quest.Crandoria.CaptainDonahue.Treasure, 1)
--             end
--         end

--     elseif MsgContains(message, "no") or MsgContains(message, "nao") then
--         if npcHandler:getTopic(playerId) == 1 then
--             npcHandler:say("Voce deve pensar que sou idiota.", npc, creature)
--         elseif npcHandler:getTopic(playerId) == 2 then
--             npcHandler:say("Sem problemas. Guarde seus tesouros com voce e eu guardo meus segredos comigo!", npc, creature)
--         end
--         npcHandler:setTopic(playerId, 0)
--     end
--     return true
-- end

-- keywordHandler:addKeyword({"passage"}, StdModule.say,
--     {
--         npcHandler = npcHandler,
--         text = "Esta querendo uma aventura? \z
--                 Se voce ja recuperou meu {tesouro} perdido, posso te levar para {Crandoria}, {Squispot}, {Gnomprona}, {Tartarus} ou {Krotkah}. Basta escolher o destino."
--     },
--     function(player)
--         return player:getStorageValue(Storage.Quest.Crandoria.CaptainDonahue.Treasure) ~= 1
--     end
-- )

-- keywordHandler:addKeyword({"passagem"}, StdModule.say,
--     {
--         npcHandler = npcHandler,
--         text = "Esta querendo uma aventura? \z
--         Se voce ja recuperou meu {tesouro} perdido, posso te levar para {Crandoria}, {Squispot}, {Gnomprona}, {Tartarus} ou {Krotkah}. Basta escolher o destino."
--     },
--     function(player)
--         return player:getStorageValue(Storage.Quest.Crandoria.CaptainDonahue.Treasure) ~= 1
--     end
-- )

-- keywordHandler:addKeyword({"ravencrest"}, StdModule.say,
--     {
--         npcHandler = npcHandler,
--         text = "Ravencrest, uma ilha perigosa e sombria... \z
--                 Posso te levar ate la depois que voce recuperar meu {tesouro} perdido. As principais partes do meu tesouro eram o {holy falcon}, o {holy scarab} e 200 gold {tokens}. Se voce tiver meu {tesouro}, basta dizer e podemos partir quando quiser."
--     },
--     function(player)
--         return player:getStorageValue(Storage.Quest.Crandoria.CaptainDonahue.Treasure) ~= 1
--     end
-- )

-- keywordHandler:addKeyword({"gnomprona"}, StdModule.say,
--     {
--         npcHandler = npcHandler,
--         text = "Gnomprona, uma ilha abaixo da terra... \z
--                 Posso te levar ate la depois que voce recuperar meu {tesouro} perdido. As principais partes do meu tesouro eram o {holy falcon}, o {holy scarab} e 200 gold {tokens}. Se voce tiver meu {tesouro}, basta dizer e podemos partir quando quiser."
--     },
--     function(player)
--         return player:getStorageValue(Storage.Quest.Crandoria.CaptainDonahue.Treasure) ~= 1
--     end
-- )

-- keywordHandler:addKeyword({"tartarus"}, StdModule.say,
--     {
--         npcHandler = npcHandler,
--         text = "Tartarus, a pequena ilha formada apos as erosoes do deserto de Valkesh... \z
--                 Posso te levar ate la depois que voce recuperar meu {tesouro} perdido. As principais partes do meu tesouro eram o {holy falcon}, o {holy scarab} e 200 gold {tokens}. Se voce tiver meu {tesouro}, basta dizer e podemos partir quando quiser."
--     },
--     function(player)
--         return player:getStorageValue(Storage.Quest.Crandoria.CaptainDonahue.Treasure) ~= 1
--     end
-- )

-- keywordHandler:addKeyword({"krotkah"}, StdModule.say,
--     {
--         npcHandler = npcHandler,
--         text = "Eu fui ate Krotkah poucas vezes. \z
--                 Posso te levar ate la, mas apenas depois que voce conseguir meu {tesouro} perdido. Meu tesouro era composto por um {holy falcon}, um {holy scarab} e 200 gold {tokens}. Se voce tiver meu {tesouro}, basta dizer e podemos partir quando quiser."
--     },
--     function(player)
--         return player:getStorageValue(Storage.Quest.Crandoria.CaptainDonahue.Treasure) ~= 1
--     end
-- )
-- local travelNode = keywordHandler:addKeyword({"krotkah"}, StdModule.say,
--     {
--         npcHandler = npcHandler,
--         text = "Voce deseja viajar para Krotkah por 50.000 moedas de ouro?"
--     }
-- )
-- travelNode:addChildKeyword({"yes"}, StdModule.travel,
--     {
--         npcHandler = npcHandler,
--         premium = false,
--         text = "Tenha uma boa viagem!",
--         cost = 50000,
--         destination = Position(5916, 4728, 6)
--     }
-- )
-- travelNode:addChildKeyword({"no"}, StdModule.say,
--     {
--         npcHandler = npcHandler, reset = true,
--         text = "Ok. Estarei aqui se mudar de ideia."
--     }
-- )

-- local travelNode = keywordHandler:addKeyword({"gnomprona"}, StdModule.say,
--     {
--         npcHandler = npcHandler,
--         text = "Voce deseja viajar para gnomprona por 25.000 moedas de ouro?"
--     }
-- )
-- travelNode:addChildKeyword({"yes"}, StdModule.travel,
--     {
--         npcHandler = npcHandler,
--         premium = false,
--         text = "Tenha uma boa viagem!",
--         cost = 25000,
--         destination = Position(5650, 4804, 13)
--     }
-- )

-- local travelNode = keywordHandler:addKeyword({"tartarus"}, StdModule.say,
--     {
--         npcHandler = npcHandler,
--         text = "Voce deseja viajar para tartarus por 40.000 moedas de ouro?"
--     }
-- )
-- travelNode:addChildKeyword({"yes"}, StdModule.travel,
--     {
--         npcHandler = npcHandler,
--         premium = false,
--         text = "Boa sorte para todos nos!",
--         cost = 40000,
--         destination = Position(5622, 4666, 6)
--     }
-- )

-- travelNode:addChildKeyword({"no"}, StdModule.say,
--     {
--         npcHandler = npcHandler, reset = true,
--         text = "Ok. Estarei aqui se mudar de ideia."
--     }
-- )

-- local travelSquidspot = keywordHandler:addKeyword({"ravencrest"}, StdModule.say,
--     {
--         npcHandler = npcHandler,
--         text = "Voce quer ir para Ravencrest pot 10.000 moedas de ouro?"
--     }
-- )
-- travelSquidspot:addChildKeyword({"yes"}, StdModule.travel,
--     {
--         npcHandler = npcHandler,
--         premium = false,
--         text = "Tenha uma boa viagem!",
--         cost = 10000,
--         destination = Position(5567, 4877, 6)
--     }
-- )
-- travelSquidspot:addChildKeyword({"no"}, StdModule.say,
--     {
--         npcHandler = npcHandler, reset = true,
--         text = "Ok. Estarei aqui se mudar de ideia."
--     }
-- )
-- local travelCrandoria = keywordHandler:addKeyword({"crandoria"}, StdModule.say,
--     {
--         npcHandler = npcHandler,
--         text = "Quer viajar para Crandoria por 1.000 moedas de ouro?"
--     }
-- )
-- travelCrandoria:addChildKeyword({"yes"}, StdModule.travel,
--     {
--         npcHandler = npcHandler,
--         premium = false,
--         text = "Tenha uma boa viagem!",
--         cost = 1000,
--         destination = Position(5041, 5066, 6)
--     }
-- )
-- travelCrandoria:addChildKeyword({"no"}, StdModule.say,
--     {
--         npcHandler = npcHandler, reset = true,
--         text = "Ok. Estarei aqui se mudar de ideia."
--     }
-- )
-- keywordHandler:addKeyword({"name"}, StdModule.say,
--     {
--         npcHandler = npcHandler,
--         text = "My name is Captain Donahue, a once proud pirate captain."
--     }
-- )
-- keywordHandler:addKeyword({"boat"}, StdModule.say,
--     {
--         npcHandler = npcHandler,
--         text = "I use this boat to take some selected people to dangerous places across the sea. What about you? Wuld you like a {passage}?"
--     }
-- )
-- keywordHandler:addKeyword({"passage"}, StdModule.say,
--     {
--         npcHandler = npcHandler,
--         text = "Se voce ja tiver me dado meu {tesouro}, posso te levar para {Crandoria}, {Ravencrest}, {Tartarus}, {Gnomprona} ou {Krotkah}. Just chose your destination."
--     }
-- )
-- keywordHandler:addKeyword({"holy falcon"}, StdModule.say,
--     {
--         npcHandler = npcHandler,
--         text = "O Holy Falcon e muito valioso. Acredito que voce possa obte-lo buscando com alguma mumia antiga de algum farao pelos desertos do Novo Continente. \z
--                 Se conseguir, por favor traga-o para mim junto ao resto dos itens. <sigh>"
--     }
-- )
-- keywordHandler:addKeyword({"holy scarab"}, StdModule.say,
--     {
--         npcHandler = npcHandler,
--         text = "O Holy Scarab sempre foi um tesouro da areia. Tao valioso e dificil de encontrar... Talvez voce devesse buscar por ele em meio a alguma tumbas..."
--     }
-- )
-- keywordHandler:addKeyword({"tokens"}, StdModule.say,
--     {
--         npcHandler = npcHandler,
--         text = "Golden Tokens sao os meus favoritos! \z
--                 Eles podem ser obtidos derrotando diversos bosses diferentes. <sigh>"
--     }
-- )

-- keywordHandler:addKeyword({"kame"}, StdModule.say,
--     {
--         npcHandler = npcHandler,
--         text = "A casa do Kame fica em uma pequena ilha. Mas eu nao levo ninguem ate la. Apenas tartarugas marinhas podem te levar ate la, jovem..."
--     }
-- )

-- npcHandler:setMessage(MESSAGE_GREET, "Be greeted, traveler |PLAYERNAME|. Welcome to my {boat}.")
-- npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye. You are welcome.")
-- npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye.")

-- npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- -- npcType registering the npcConfig table
-- npcType:register(npcConfig)
