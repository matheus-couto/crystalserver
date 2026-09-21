local internalNpcName = "Bugozd"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 160,
	lookHead = 112,
	lookBody = 52,
	lookLegs = 45,
	lookFeet = 116
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
    
    local dailyTrades = {
        -- day = { item1Id, count1, item2Id, count2 }
        [1] = {5879, 10, 26186, 1},
        [2] = {20062, 10, 26186, 1},
        [3] = {11682, 5, 26186, 1},
        [4] = {4061, 1, 26186, 1},
        [5] = {5892, 3, 26186, 1},
        [6] = {20063, 1, 26186, 1},
        [7] = {22720, 10, 26186, 1},
        [8] = {43850, 10, 26186, 1},
        [9] = {36820, 10, 26186, 1},
        [10] = {12252, 10, 26186, 1},
        [11] = {36807, 10, 26186, 1},
        [12] = {9656, 20, 26186, 1},
        [13] = {2958, 1, 26186, 1},
        [14] = {27461, 3, 26186, 1},
        [15] = {36971, 10, 26186, 1},
        [16] = {40587, 10, 26186, 1},
        [17] = {32002, 3, 26186, 1},
        [18] = {34139, 10, 26186, 1},
        [19] = {6558, 15, 26186, 1},
        [20] = {43859, 10, 26186, 1},
        [21] = {29346, 25, 26186, 1},
        [22] = {34141, 10, 26186, 1},
        [23] = {36780, 20, 26186, 1},
        [24] = {5922, 25, 26186, 1},
        [25] = {36806, 10, 26186, 1},
        [26] = {43849, 10, 26186, 1},
        [27] = {32198, 5, 26186, 1},
        [28] = {9088, 2, 26186, 1},
        [29] = {22723, 50, 26186, 1},
        [30] = {3387, 1, 26186, 1},
        [31] = {5919, 1, 26186, 1},
        [32] = {5014, 2, 26186, 1},
        [33] = {30168, 1, 26186, 1},
        [34] = {39544, 1, 26186, 1},
        
        -- ...
        -- Preencha até 31 se quiser, ou repita ciclos
    }

    local function getTradeOfTheDay()
        local d = tonumber(os.date("%d"))      -- dia do mês (1–31)
        local trade = dailyTrades[d]
        if not trade then
            -- fallback caso você não tenha definido esse dia
            return 2148, 100, 7618, 1
        end
        return trade[1], trade[2], trade[3], trade[4]
    end

    local item1, count1, item2, count2 = getTradeOfTheDay()

    local storage = player:getStorageValue(Storage.Quest.Crandoria.BugozdQuest.Progresso)
    local storageTimer = player:getStorageValue(Storage.Quest.Crandoria.BugozdQuest.Timer)
    local timeLeft = math.floor((player:getStorageValue(Storage.Quest.Crandoria.BugozdQuest.Timer) - os.time()) / 60)

    local now = os.date("*t")
	local day = now.day

    local storageTrocaGlobal = Game.getStorageValue(GlobalStorage.Crandoria.BugozdTroca.Troca)
    local storageDia = Game.getStorageValue(GlobalStorage.Crandoria.BugozdTroca.Dia)

    local level = player:getLevel()

    if MsgContains(message, "escambo") then
        if storage < 1 then
            if player:getLevel() >= 400 then
                npcHandler:say("Ei! Ei! Fale baixo, jovem. Quem falou com voce sobre isso? ... Sim, eu realizo algumas trocas de itens aqui e ali, mas ninguem pode saber! \z
                Algumas pessoas dizem que minhas trocas podem desestabilizar a economia de Anvillux. Que piada! E olhe aqui, jovem. Eu nao troco com qualquer um! \z
                Mas talvez voce consiga me comprar... O que voce tem para me oferecer?", npc, creature)
                npcHandler:setTopic(playerId, 1)
            else
                npcHandler:say("Saia ja daqui! Ta pensando que eu falo sobre isso com qualquer um? Alcance o nivel 400 e talvez eu te de ouvidos.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 1 then
            npcHandler:say("Voce trouxe a Dwarven Armor?", npc, creature)
            npcHandler:setTopic(playerId, 4)
        elseif storage == 2 then
            if day ~= storageDia then
                if storageTimer < os.time() then
                    npcHandler:say("Hoje estou buscando por "..count1.." "..getItemName(item1).." e ofereco em troca 5 Tibia Coins. Voce aceita a troca?", npc, creature)
                    npcHandler:setTopic(playerId, 5)
                else
                    npcHandler:say("Ja fiz uma troca justa com voce nas ultimas 24 horas. Retorne em "..timeLeft.." minutos e poderemos trocar novamente.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                end
            else
                npcHandler:say("Odeio dizer, mas ja realizei uma troca com outro jogador hoje. Para nao levantar suspeitas, terei que esperar ate amanha para a proxima troca. (Apos Server Save)", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "gold") or MsgContains(message, "dinheiro") or MsgContains(message, "money") or MsgContains(message, "ouro") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("He he he he... Voces acham que todo anao passa os dias pensando em dinheiro? Por que acha que faco trocas em vez de vender meus itens? \z
            Nao quero dinheiro. Tente novamente.", npc, creature)
            npcHandler:setTopic(playerId, 1)
        end
    elseif MsgContains(message, "love") or MsgContains(message, "amor") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Voce... do que voce esta falando? Quer se casar comigo por acaso? Nao, obrigado! Ha ha ha ha! Tente mais uma vez.", npc, creature)
            npcHandler:setTopic(playerId, 1)
        end
    elseif MsgContains(message, "protecao") or MsgContains(message, "protection") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("E do que voce me protegeria? Voce ja viu onde estamos? Nao ha perigo algum nesse lugar. Apos o que aconteceu com Khazordoon nos aprendemos.\z
            Agora ficamos bem isolados e protegidos contra esses monstros malditos. Mas continue tentando, talvez voce ofereca outra coisa que possa me convencer.", npc, creature)
            npcHandler:setTopic(playerId, 1)
        end
    elseif MsgContains(message, "amizade") or MsgContains(message, "friendship") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Ami... HA! Amizade? Voce esta falando serio? Nao me leve a mal, mas eu nao estou procurando por novos amigos, apenas parceiros de negocios. \z
            Tente mais uma vez. O que mais voce teria a oferecer?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        end
    elseif MsgContains(message, "parceria") or MsgContains(message, "partner") or MsgContains(message, "companheiro") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Eu ja entendi que voce quer ser meu parceiro e negociar alguns itens, mas ainda nao me disse o que pode me oferecer para me convencer a fazer negocios com voce. \z
            O que voce oferece?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        end
    elseif MsgContains(message, "itens") or MsgContains(message, "item") or MsgContains(message, "artefato") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Gosto de todos os tipos de itens. Artefatos, equipamentos, armas... Nao costumo negociar esse tipo de item. Sou mais do tipo colecionador... \z
            E eu poderia obter uma armadura para minha colecao. Talvez uma armadura rara... uma que me lembre meu povo e minhas origens. Conhece alguma assim? Me diga.", npc, creature)
            npcHandler:setTopic(playerId, 2)
        end
    elseif MsgContains(message, "dwarven armor") then
        if storage < 1 then
            if npcHandler:getTopic(playerId) == 2 then
                npcHandler:say("Ha! Entao voce sabe sobre a existencia da Dwarven Armor... Sim, uma Dwarven Armor em perfeito estado seria uma otima aquisicao... Bom. Faremos um acordo: \z
                Traga-me uma Dwarven Armor e eu darei uma olhada nela. Se ela estiver em perfeito estado, ficarei com ela. Se ela nao estiver tao perfeita, deixo que fique com ela.\z
                Independente de quem ficara com ela, negociarei com voce apos ve-la com meus proprios olhos. Voce aceita?", npc, creature)
                npcHandler:setTopic(playerId, 3)
            end
        elseif storage == 1 then
            npcHandler:say("Voce trouxe a Dwarven Armor?", npc, creature)
            npcHandler:setTopic(playerId, 4)
        end
    elseif MsgContains(message, "ginger") or MsgContains(message, "floyd") or MsgContains(message, "drulok") then
        if player:getStorageValue(Storage.Quest.Crandoria.NilluxQuest.Progresso) < 5 then
            npcHandler:say("Sinto muito, nao sei sobre o que voce esta falando.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.NilluxQuest.Progresso) == 5 then
            npcHandler:say("Maldito Drulok... Esse desgracado continua abusando da minha boa vontade, so porque contei um dos meus segredos a ele. \z
            Escute, eu ajudei o alquimista fornecendo um esconderijo para que ele pudesse descansar por uns meses. Ele esta em uma sala improvisada a leste do depot. \z
            Voce podera encontra-lo a qualquer momento no local, aquele doido nao sai de la desde que chegou. Boa sorte...", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.NilluxQuest.Progresso, 6)
            npcHandler:setTopic(playerId, 0)
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 3 then
            npcHandler:say("Muito bem! Boa sorte com sua busca! Ha ha ha...", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.BugozdQuest.Progresso, 1)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 4 then
            local chance = math.random(1, 10)
            if player:getItemCount(3397) >= 1 then
                -- if chance > 7 then
                    player:removeItem(3397, 1)
                    npcHandler:say("Eu nao acredito! Cada detalhe, cada um dos adornos, cada dobradica... Esta tudo em perfeito estado, como se tivesse sido forjada hoje mesmo! \z
                    Onde voce conseguiu isso? Bom, como combinado, ficarei com ela e agora poderemos realizar um bom {escambo}. E nao se preocupe, nao te deixarei na mao. \z
                    Aqui, nossa primeira troca, para compensar pela Dwarven Armor.", npc, creature)
                    player:addItem(39145, 1)
                    player:addExperience(1000000)
                    player:setStorageValue(Storage.Quest.Crandoria.BugozdQuest.Progresso, 2)
                    npcHandler:setTopic(playerId, 0)
                -- else
                --     npcHandler:say("Nossa! De longe ja consigo ver as marcas e imperfeicoes dessa armadura. Claro, parece legitima, nao vou negar que vale muito. \z
                --     Mas sou um colecionador, preciso do melhor! De qualquer forma vou cumprir a minha parte do combinado, a partir de agora podemos fazer alguns {escambos}.", npc, creature)
                --     player:addExperience(1000000)
                --     player:setStorageValue(Storage.Quest.Crandoria.BugozdQuest.Progresso, 2)
                --     npcHandler:setTopic(playerId, 0)
                -- end
            else
                npcHandler:say("Certo, e onde ela esta?..", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 5 then
            if player:getItemCount(item1) >= count1 then
                player:removeItem(item1, count1)
                player:addTransferableCoins(5)
                setGlobalStorage(GlobalStorage.Crandoria.TibiaCoinsColeta.CoinsTotal, getGlobalStorage(GlobalStorage.Crandoria.TibiaCoinsColeta.CoinsTotal) + 5)
                npcHandler:say("Negocio fechado! Hoje voce trocou "..count1.."x "..ItemType(item1):getName().." por 5 Tibia Coins. Retorne amanha se quiser fazer uma nova troca.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.BugozdQuest.Timer, os.time() + 23 * 60 * 60)
                Game.setStorageValue(GlobalStorage.Crandoria.BugozdTroca.Troca, 1)
                Game.setStorageValue(GlobalStorage.Crandoria.BugozdTroca.Dia, day)
            else
                npcHandler:say("Voce nao tem os itens necessarios!", npc, creature)
            end
            npcHandler:setTopic(playerId, 0)
        end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Saudacoes, jovem. Como posso ajudar?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "bread", clientId = 3600, buy = 4 },
	{ itemName = "brown mushroom", clientId = 3725, buy = 10 },
	{ itemName = "cheese", clientId = 3607, buy = 6 },
	{ itemName = "ham", clientId = 3582, buy = 8 },
	{ itemName = "meat", clientId = 3577, buy = 5 },
	{ itemName = "mug of beer", clientId = 2880, buy = 2, count = 3 },
	{ itemName = "mug of lemonade", clientId = 2880, buy = 2, count = 12 },
	{ itemName = "mug of water", clientId = 2880, buy = 1, count = 1 },
	{ itemName = "mug of wine", clientId = 2880, buy = 3, count = 2 }

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

npcType:addDialogOptions("bye")

-- npcType registering the npcConfig table
npcType:register(npcConfig)
