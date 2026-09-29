local internalNpcName = "Comandante Crassus"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 4000
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 289,
	lookHead = 0,
	lookBody = 74,
	lookLegs = 59,
	lookFeet = 59,
    lookAddons = 1,
}

npcConfig.voices = {
	interval = 30000,
	chance = 50,
	{text = 'Se aliste para missoes comigo e ajude a cidade de Crandoria!'},
	{text = 'Crandoria oferece missoes em troca de recompensas valiosas!'},
    {text = 'Nao sabe o que fazer? Aliste-se em uma missao e ajude o povo de Crandoria!'}
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

    local dear
    if player:getSex() == PLAYERSEX_MALE then
        dear = "Lord"
    else
        dear = "Lady"
    end

    local rewardSurpriseItems = {

        {itemId = 22739, itemName = "Cobra You Desire"},
        {itemId = 36827, itemName = "Lion You Desire"},
        {itemId = 31633, itemName = "Falcon You Desire"},
    
    }
    local function getRandomItemToTrade()
        -- Escolhe um item aleatório da lista de itens trocáveis
        local randomReward = math.random(1, #rewardSurpriseItems)
        return rewardSurpriseItems[randomReward].itemId -- Retorna o ID do item aleatório
    end
    local randomSurpriseItem = getRandomItemToTrade()

    local timeLeft = math.floor((player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Timer) - os.time()) / 60)
    local timeLeftItems = math.floor((player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItemsTimer) - os.time()) / 60)
    local storage = player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso)
    local itemsTimer = player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItemsTimer)
    local storageItems = player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade)
    local knight = player:getVocation():getBaseId() == VOCATION.BASE_ID.KNIGHT
    local paladin = player:getVocation():getBaseId() == VOCATION.BASE_ID.PALADIN
    local monk = player:getVocation():getBaseId() == VOCATION.BASE_ID.MONK
    local druid = player:getVocation():getBaseId() == VOCATION.BASE_ID.DRUID
    local sorcerer = player:getVocation():getBaseId() == VOCATION.BASE_ID.SORCERER

    local itemsLeft = 4 - player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade)


    local randomChance = math.random(1, 10)


    if MsgContains(message, "missao") or MsgContains(message, "mission") or MsgContains(message, "quest") or MsgContains(message, "task") then


        if player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Timer) <= os.time() then
            if itemsTimer <= os.time() then
                if storage < 1 then
                    if player:getLevel() >= 8 then
                        npcHandler:say("Entao voce esta interessado em ajudar a cidade de Crandoria com alguns desafios? Ha! Excelente! Tentarei pegar leve com voce, |PLAYERNAME|. Por que nao comecamos com algo facil? Um dos nossos recrutas perdeu uma katana nos bueiros e parece que ela foi pega por uma das rotworms que vive no local. \z
                        Acesse os bueiros e derrote algumas rotworms ate encontrar a katana. Ao encontra-la traga-a para mim e te recompensarei com um pouco de ouro e experiencia. Voce aceita a missao?", npc, creature)
                        npcHandler:setTopic(playerId, 1)
                    else
                        npcHandler:say("Sinto muito, mas apenas jogadores de nivel 8 ou superior podem ajudar Crandoria com suas missoes.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 1 then
                    if player:removeItem(3300, 1) then
                        npcHandler:say("Voce encontrou a katana! Excelente. Foi mais rapido que eu esperava. Aqui esta sua recompensa! 5.000 moedas de ouro e alguma experiencia.", npc, creature)
                        player:addMoney(5000, true)
                        player:addExperience(15000, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 2)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Por favor, recupere a katana perdida entre as rotworms e traga-a para mim!", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 2 then
                    if player:getLevel() >= 12 then
                        npcHandler:say("Entao as Rotworms nao foram um desafio tao grande quando eu imaginava que seriam. Bom, a proxima missao sera um pouco mais desafiadora: Voce devera ir ate a montanha onde vivem as Amazonas, no sentido noroeste da saida de Crandoria. \z
                        Nas profundezas do local ha seis baus com itens especiais. Voce devera abrir UM DELES e depois retornar e reportar para mim sua missao. Esses itens foram tomados de nossos guerreiros pelas Amazonas ao longo das batalhas. Voce aceita a missao?", npc, creature)      
                        npcHandler:setTopic(playerId, 2)
                    else
                        npcHandler:say("Sinto muito, mas apenas jogadores de nivel 12 ou superior podem se alistar para a proxima missao.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 3 then
                    if player:getStorageValue(Storage.Quest.Crandoria.FirstWeapon.FirstWeaponReward) > 0 then
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 4)
                        player:addItem(3057, 1, true)
                        player:addMoney(20000, true)
                        player:addExperience(100000, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        npcHandler:say("Muito bem. Voce passou bravamente pelo desafio das amazonas. Aqui estao suas recompensas. Volte quando quiser receber um novo desafio!", npc, creature)
                    else
                        npcHandler:say("O campo das amazonas fica no sentido noroeste, pela saida norte de Crandoria. Va ate la e consiga um dos itens especiais em um dos baus no fundo da caverna, depois volte ate mim e te darei sua recompensa.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 4 then
                    if player:getLevel() >= 16 then
                        -- npcHandler:say("Como as amazonas nao foram um grande desafio para voce, vou te mandar em uma missao um pouco mais perigosa. Acima das amazonas vive uma comunidade de Cyclops. Essas criaturas estao se multiplicando muito rapido e precisamos de alguem \z
                        -- para derrotar alguns deles e manter sua populacao sob controle. Mate alguns deles para mim e como prova do seu trabalho bem feito, me traga 5 cyclops toes. Ao trazer os itens te darei uma boa recompensa! Aceita o desafio?", npc, creature)
                        -- npcHandler:setTopic(playerId, 3)
                        npcHandler:say("Como as amazonas nao foram um grande desafio para voce, vou te mandar em uma missao um pouco mais perigosa. Proximo a ciadade de Elvenshire ha um povoado de elfos rebeldes e preciso da sua ajuda para conte-los. \z
                        Como prova de que voce derrotou elfos o suficiente, traga-me 3 Heaven Blossoms. Aceita o desafio?", npc, creature)
                        npcHandler:setTopic(playerId, 3)
                    else
                        npcHandler:say("Sinto muito, mas apenas jogadores de nivel 16 ou superior podem se alistar para a proxima missao.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 5 then
                    if player:removeItem(5921, 3) then
                        if knight or paladin or monk then
                            player:addExperience(250000, true)
                            player:addMoney(30000, true)
                            player:addItem(3432, 1, true)
                            player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        elseif sorcerer or druid then
                            player:addExperience(250000, true)
                            player:addMoney(30000, true)
                            player:addItem(8072, 1, true)
                            player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        end
                        npcHandler:say("Essas flores nao estao tao bonitas quanto eu me lembrava... Mas tudo bem, sua missao esta completa! Aqui estao suas recompensas. Me avise quando quiser um novo desafio.", npc, creature)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 6)
                        local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                        player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
                        player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Preciso de pelo menos 5 Cyclops Toes para ter certeza que o suficiente deles foi derrotado. Por favor, traga-os ate mim!", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 6 then
                    if player:getLevel() >= 30 then
                        npcHandler:say("Voce realmente tem me surpreendido. Tem muito mais poder do que eu imaginava! Bom, seu novo desafio sera realmente mais... desafiador! Ha ha ha... Eu preciso de 3 green dragon leathers e 3 green dragon scales. \z
                        Voce podera obter esses itens de dragoes. Eles estao espalhados por toda parte. Se quiser uma dica, saia pelo portao norte e va para a direcao nordeste e encontara uma montanha cheia deles! Voce aceita a missao?", npc, creature)
                        npcHandler:setTopic(playerId, 4)
                    else
                        npcHandler:say("Sinto muito, mas apenas jogadores de nivel 30 ou superior podem se alistar para a proxima missao.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 7 then
                    if knight then
                        if player:getItemCount(5877) >= 3 and player:getItemCount(5920) >= 3 then
                            npcHandler:say("Impressinante! Estao em otimo estado. Muito obrigado pelas iguarias, jovem. Te recompensarei com experiencia, ouro e uma nova arma. Voce gostaria de um {machado}, uma {clava} ou uma {espada}?.", npc, creature)
                            npcHandler:setTopic(playerId, 5)
                        else
                            npcHandler:say("Por favor, me traga os 3 green dragon leathers e as 3 green dragon scales. Estarei aguardando pelo seu retorno.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        end
                    elseif paladin then
                        if player:getItemCount(5877) >= 3 and player:getItemCount(5920) >= 3 then
                            if player:removeItem(5877, 3) and player:removeItem(5920, 3) then
                                npcHandler:say("Impressinante! Estao em otimo estado. Muito obrigado pelas iguarias, jovem. Te recompensarei com experiencia, ouro e uma nova arma. Espero que goste!", npc, creature)
                                player:addItem(8021, 1, true)
                                player:addExperience(1000000, true)
                                player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                                player:addMoney(40000, true)
                                npcHandler:setTopic(playerId, 5)
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 8)
                            else
                                npcHandler:say("Por favor, me traga os 3 green dragon leathers e as 3 green dragon scales. Estarei aguardando pelo seu retorno.", npc, creature)
                                npcHandler:setTopic(playerId, 0)
                            end
                        else
                            npcHandler:say("Por favor, me traga os 3 green dragon leathers e as 3 green dragon scales. Estarei aguardando pelo seu retorno.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        end
                    elseif druid then
                        if player:getItemCount(5877) >= 3 and player:getItemCount(5920) >= 3 then
                            if player:removeItem(5877, 3) and player:removeItem(5920, 3) then
                                npcHandler:say("Impressinante! Estao em otimo estado. Muito obrigado pelas iguarias, jovem. Te recompensarei com experiencia, ouro e uma nova arma. Espero que goste!", npc, creature)
                                player:addItem(8084, 1, true)
                                player:addExperience(1000000, true)
                                player:addMoney(40000, true)
                                player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 8)
                            else
                                npcHandler:say("Por favor, me traga os 3 green dragon leathers e as 3 green dragon scales. Estarei aguardando pelo seu retorno.", npc, creature)
                                npcHandler:setTopic(playerId, 0)
                            end
                        else
                            npcHandler:say("Por favor, me traga os 3 green dragon leathers e as 3 green dragon scales. Estarei aguardando pelo seu retorno.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        end
                    elseif sorcerer then
                        if player:getItemCount(5877) >= 3 and player:getItemCount(5920) >= 3 then
                            if player:removeItem(5877, 3) and player:removeItem(5920, 3) then
                                npcHandler:say("Impressinante! Estao em otimo estado. Muito obrigado pelas iguarias, jovem. Te recompensarei com experiencia, ouro e uma nova arma. Espero que goste!", npc, creature)
                                player:addItem(8092, 1, true)
                                player:addExperience(1000000, true)
                                player:addMoney(40000, true)
                                player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 8)
                            else
                                npcHandler:say("Por favor, me traga os 3 green dragon leathers e as 3 green dragon scales. Estarei aguardando pelo seu retorno.", npc, creature)
                                npcHandler:setTopic(playerId, 0)
                            end
                        else
                            npcHandler:say("Por favor, me traga os 3 green dragon leathers e as 3 green dragon scales. Estarei aguardando pelo seu retorno.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        end
                    elseif monk then
                        if player:getItemCount(5877) >= 3 and player:getItemCount(5920) >= 3 then
                            if player:removeItem(5877, 3) and player:removeItem(5920, 3) then
                                npcHandler:say("Impressinante! Estao em otimo estado. Muito obrigado pelas iguarias, jovem. Te recompensarei com experiencia, ouro e uma nova arma. Espero que goste!", npc, creature)
                                player:addItem(50182, 1, true)
                                player:addExperience(1000000, true)
                                player:addMoney(40000, true)
                                player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 8)
                            else
                                npcHandler:say("Por favor, me traga os 3 green dragon leathers e as 3 green dragon scales. Estarei aguardando pelo seu retorno.", npc, creature)
                                npcHandler:setTopic(playerId, 0)
                            end
                        else
                            npcHandler:say("Por favor, me traga os 3 green dragon leathers e as 3 green dragon scales. Estarei aguardando pelo seu retorno.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        end
                    end
                elseif storage == 8 then
                    if player:getLevel() >= 50 then
                        -- npcHandler:say("Voce esta progredindo rapidamente. Isso me parece um sinal de que voce precisa de uma missao mais seria e perigosa. Abaixo do templo de Crandoria ha uma alavanca que te levara a Miniboss Room. \z 
                        -- Enfrente um dos bosses e retorne ate mim, mesmo que nao saia vitorioso, e eu te recompensarei pela sua coragem. O que acha? Aceita essa missao?", npc, creature)
                        -- npcHandler:setTopic(playerId, 6)
                        npcHandler:say("Voce esta progredindo rapidamente. Isso me parece um sinal de que voce precisa de uma missao mais desafiadora e perigosa... Entao vamos la! \z
                        Na montanha ao norte de Hakata ha diversas cavernas de Hydras. Em uma delas ha uma flor gigante que solta um cheiro extremamente agradavel. A unica da especie... \z
                        Va ate ela e colete uma amostra de seu extrato. Mas atencao! Voce deve retornar em no maximo 10 minutos apos coletar, ou o cheiro se perdera! Estarei esperando.", npc, creature)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 9)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Sinto muito, mas apenas jogadores de nivel 50 ou superior podem se alistar para a proxima missao.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 9 then
                    if player:getStorageValue(Storage.Quest.Crandoria.BossRoom.MiniBossRoomTimer) > os.time() then
                        npcHandler:say("Voce conseguiu! Aqui, deixe-me coletar uma amostra do aroma da flor. Isso com certeza sera uma boa descoberta para Filandrel, em Astralis. Aqui, uma singela recompensa.", npc, creature)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 10)
                        player:addMoney(50000, true)
                        player:addExperience(1500000, true)
                        player:addItem(22721, 1, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:addAchievement("Escudeiro de Crandoria")
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Onde esta o extrato? Voce chegou a encontrar a flor? Nao sinto cheiro nenhum... Encontre a flor especial entre as Hydras ao norte de Hakata e traga seu extrato para mim. ", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 10 then
                    if player:getLevel() >= 60 then
                        npcHandler:say("Acredito que voce ja tenha forca suficiente para enfrentar Heroes e Necromancers, estou certo? Pois bem! Preciso que me traga uma Crown Legs dos heroes e um Skull Staff dos necromances. Me entregue ambos os itens juntos. \z
                        Esses equipamentos ajudarao um novo recruta que temos em Crandoria e, obviamente, te recompensarei por eles. Voce esta disposto a embarcar nessa missao?", npc, creature)
                        npcHandler:setTopic(playerId, 7)
                    else
                        npcHandler:say("Sinto muito, mas apenas jogadores de nivel 60 ou superior podem se alistar para a proxima missao.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 11 then
                    if player:getItemCount(3382) >= 1 and player:getItemCount(3324) >= 1 then
                        if player:removeItem(3382, 1) and player:removeItem(3324, 1) then
                            npcHandler:say("Por que demorou tanto? As coisas estao ficando dificeis, nao e mesmo? Ha ha ha. Bom, o importante sempre sera os guerreiros retornarem saos e salvos. Como combinao, aqui esta sua recompensa, descubra um bom uso para isso. Retorne quand quiser um novo desafio.", npc, creature)
                            player:addMoney(65000, true)
                            player:addItem(7889, 3, true)
                            player:addExperience(2500000, true)
                            player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 12)
                            local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                            player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
                            player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                            npcHandler:setTopic(playerId, 0)
                        else
                            npcHandler:say("Por favor, traga uma Crown Armor e um Skull Staff para mim.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        end
                    else
                        npcHandler:say("Por favor, traga uma Crown Armor e um Skull Staff para mim.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 12 then
                    if player:getLevel() >= 75 then
                        npcHandler:say("Voce realmente esta indo muito bem, jovem... Que tal um desafio que te levara um pouco mais longe agora? Por favor, cace algumas criaturas das regioes frias e obtenha delas 5 Shards. Traga os shards para mim e te recompensarei por eles. Voce aceita o desafio?", npc, creature)
                        npcHandler:setTopic(playerId, 8)
                    else
                        npcHandler:say("Sinto muito, mas apenas jogadores de nivel 75 ou superior podem se alistar para a proxima missao.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 13 then
                    if player:removeItem(7290, 5) then
                        if knight or paladin or monk then
                            npcHandler:say("Voce foi mais rapido do que eu esperava para essa missao. Bom trabalho! Aqui esta sua recompensa.", npc, creature)
                            player:addMoney(90000, true)
                            player:addItem(3386, 1, true)
                            player:addExperience(2500000, true)
                            player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        elseif sorcerer or druid then
                            npcHandler:say("Voce foi mais rapido do que eu esperava para essa missao. Bom trabalho! Aqui esta sua recompensa.", npc, creature)
                            player:addMoney(90000, true)
                            player:addItem(8043, 1, true)
                            player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                            player:addExperience(2500000, true)
                        end
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 14)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Por favor, traga 5 shards para mim o quanto antes. Voce pode encontra-los derrotando frost dragons, frost giants, crystal spider e algumas outras criaturas.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 14 then
                    if player:getLevel() >= 100 then
                        npcHandler:say("Um dos nossos cavaleiros perdeu seu escudo. Precisamos repor este escudo ao nosso arsenal. Por favor, saia e busque um Tower Shield e traga ate mim e eu te recompensarei. Voce aceita a missao?", npc, creature)
                        npcHandler:setTopic(playerId, 9)
                    else
                        npcHandler:say("Apenas jogadores de nivel 100 ou superior podem se alistar para a proxima missao.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 15 then
                    if player:removeItem(3428, 1) then
                        npcHandler:say("Este escudo esta em otimo estado! Muito obrigado. Aqui esta sua recompensa.", npc, creature)
                        player:addMoney(100000, true)
                        player:addExperience(3000000, true)
                        player:addPreyCards(2, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        npcHandler:setTopic(playerId, 0)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 16)
                    else
                        npcHandler:say("Nao volte sem um Tower Shield. Agora va, depressa!", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 16 then
                    if player:getLevel() >= 100 then
                        npcHandler:say("Preste atencao, a sua proxima missao sera a mais dificil ate agora... Voce tera que passar por uma prova de fogo e morte, em meio a demonios poderosos. Essa sera a Annihilator Quest! O local fica para o sudeste, descendo as escadas das ruinas abandonadas. \z
                        Apos descer, voce tera encontrar seu proprio caminho ate o local da alavanca. Leve um time de mais tres pessoas com voce. Ao puxarem a alavanca terao que enfrentar alguns demonios para passar ate a sala de recompensas. Apos conseguir derrotar os demonios e pegar sua recompensa, retorne ate mim.", npc, creature)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 17)
                    else
                        npcHandler:say("Apenas jogadores de nivel 100 ou superior podem se alistar para a proxima missao.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 17 then
                    if player:getStorageValue(Storage.Quest.U7_24.TheAnnihilator.Reward) >= 1 then
                        npcHandler:say("Incrivel! Voce realmente tem provado seu valor para todos em Crandoria. Aqui esta sua recompensa pela missao.", npc, creature)
                        player:addExperience(3500000, true)
                        player:addMoney(120000, true)
                        player:addItem(637, 3)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 18)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Termine a Annihilator Quest e retorne ate mim para receber a recompensa.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 18 then
                    npcHandler:say("Bom, acho que agora voce finalmente esta subindo para um novo patamar... Quero te oferecer um desafio quase sufocante! Viaje ate Nautis utilizando o Tapete Magico de Uzon e entre no mundo submerso dos Deeplings. \z
                    Precisamos de algumas Deepling Claw para fazer alguns trofeus para nossos campeonatos de luta. Traga-me 10 Deepling Claws e sua missao estara cumprida!", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 19)
                elseif storage == 19 then
                    if player:removeItem(14044, 10) then
                        player:addExperience(4000000, true)
                        player:addMoney(130000, true)
                        player:addItem(7889, 5, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 20)
                        local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                        player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
                        player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Traga-me 10 Deepling Claws dos Deelpings de Nautis e sua missao estara terminada.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 20 then
                    if player:getLevel() >= 120 then
                        npcHandler:say("Voce ja ouviu falar nos Behemoths? Criaturas horrendas! Sao gigantes poderosos e crueis que te esmagariam numa so das maos se voce... quero dizer.. err.. eu aposto que voce derrotaria facilmente alguns deles! \z
                        E sua proxima missao dependera disso. Preciso que voce cace alguns Behemoths e me traga 2 Perfect Behemoth Fangs. Negocio fechado?", npc, creature)
                        npcHandler:setTopic(playerId, 10)
                    else
                        npcHandler:say("Apenas jogadores de nivel 120 ou superior podem se alistar para a proxima missao.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 21 then
                    if player:removeItem(5893, 2) then
                        npcHandler:say("Voce conseguiu mesmo? HA! Eu nunca duvidei de voce, |PLAYERNAME|. Aqui, pegue sua recompensa.", npc, creature)
                        player:addExperience(4500000, true)
                        player:addMoney(140000, true)
                        player:addPreyCards(2, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 22)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Derrote alguns behemoths e me traga 2 perfect behemoth fangs. Entao te darei sua recompensa.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 22 then
                    npcHandler:say("Teremos uma cerimonia para celebrar a volta de um dos nossos guerreiros e precisamos de um Medusa Shield e um Royal Helmet para ornamentar o local. Por favor, obtenha um de cada desses itens para mim. Nao se preocupe se voce acabar morrendo no caminho... HA HA HA!", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 23)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 23 then
                    if player:getItemCount(3436) >= 1 and player:getItemCount(3392) >= 1 then
                        if player:removeItem(3436, 1) and player:removeItem(3392, 1) then
                            npcHandler:say("Muito bem. Aposto que nao foi nada dificil! Aqui esta sua recompensa, como combinado. 1 dia de Vip e algum ouro para que possa aproveitar melhor o inicio de sua jornada.", npc, creature)
                            player:addExperience(5000000, true)
                            player:addMoney(150000, true)
                            player:addPremiumDays(1)
                            player:onAddVip(1)
                            player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
                            player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 24)
                            npcHandler:setTopic(playerId, 0)
                        else
                            npcHandler:say("Obtenha 1 Medusa Shield e 1 Royal Helmet para mim, por favor.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        end
                    else
                        npcHandler:say("Obtenha 1 Medusa Shield e 1 Royal Helmet para mim, por favor.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 24 then
                    if player:getLevel() >= 130 then
                        npcHandler:say("Que tal enfrentar algumas criaturas demoniacas? Estamos precisando de algumas Demonic Essences e seria otimo se voce pudesse nos ajudar com isso. Traga-me 20 Demonic Essences e te darei uma boa recompensa. Trato feito?", npc, creature)
                        npcHandler:setTopic(playerId, 11)
                    else
                        npcHandler:say("Apenas jogadores de nivel 130 ou superior podem se alistar para a proxima missao.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 25 then
                    if player:removeItem(6499, 20) then
                        npcHandler:say("Demonios sao o mesmo que nada para voce? Ha ha ha! Muito bom, jovem |PLAYERNAME|. Aqui, pegue sua recompensa.", npc, creature)
                        player:addExperience(5000000, true)
                        player:addMoney(160000, true)
                        player:addItem(637, 3, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 26)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Traga as 20 Demonic Essences para completar sua missao.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 26 then
                    npcHandler:say("Acho que nao preciso de mais provas que voce pode enfrentar alguns desses malditos demonios. Entao agora seu desafio sera passar de vez por cima deles! Va ate as ruinas ao sudeste de Crandoria e encontre um local onde voce podera pegar um Demon Helmet. \z
                    Apos finalizar a quest e obter seu helmet, volte ate mim. Estarei te esperando.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 27)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 27 then
                    if player:getStorageValue(Storage.Quest.U6_4.DemonHelmet.Rewards.DemonHelmet) > 0 then
                        npcHandler:say("Incrivel! Voce conseguiu completar a Demon Helmet Quest! Aqui esta sua recompensa pelos esforcos empregados nessa jornada.", npc, creature)
                        player:addExperience(5000000, true)
                        player:addMoney(160000, true)
                        player:addPremiumDays(1)
                        player:onAddVip(1)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:addAchievement("Poder Comprovado")
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 28)
                        local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                        player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
                        player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Termine a Demon Helmet Quest e retorne ate mim para receber sua recompensa.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 28 then
                    if player:getLevel() >= 150 then
                        npcHandler:say("Agora voce ja possui nivel suficiente para enfrentar alguns bosses e obter bons espolios. Um dos espolios de bosses que voce podera sempre obter sao as chamadas Silver Tokens. Com elas sera possivel comprar alguns itens e terminar algumas quests por aqui. \z
                        Que tal voce me trazer 5 dessas Silver Tokens? Aceita a missao?.", npc, creature)
                        npcHandler:setTopic(playerId, 12)
                    else
                        npcHandler:say("Apenas jogadores de nivel 150 ou superior podem se alistar para a proxima missao.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 29 then
                    if player:removeItem(22516, 5) then
                        npcHandler:say("Trouxe todas as 5? Maravilha! Aqui esta sua recompensa.", npc, creature)
                        player:addExperience(7500000, true)
                        player:addMoney(175000, true)
                        player:addItem(637, 3, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 30)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Consiga 5 Silver Tokens com alguns bosses e traga-os para mim.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 30 then
                    npcHandler:say("Que tal passar por um desafio um pouco mais complicado dessa vez? Voce agora devera passar pela missao denominada como Wrath of Emperor. Para isso, voce devera ir ate Chaos, nas profundezas de onde vivem os lagartos. \z
                    No local ha um dragao milenar que te pedira ajuda para derrotar um Deus maligno. Siga suas instrucoes, derrote o tal deus e retorne vitorioso e eu te darei uma boa recompensa. Esta preparado?", npc, creature)
                    npcHandler:setTopic(playerId, 13)
                elseif storage == 31 then
                    if player:getStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Questline) >= 33 then
                        if knight or paladin or monk then
                            npcHandler:say("Entao voce conheceu Awarness of the Emperor? Um ser realmente desprezivel, nao e mesmo? Mas voce coseguiu ajuda-lo apesar de tudo e, como combinado, aqui esta sua recompensa.", npc, creature)
                            player:addExperience(7500000, true)
                            player:addMoney(175000, true)
                            player:addItem(10385, 1, true)
                            player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 32)
                            npcHandler:setTopic(playerId, 0)
                        elseif sorcerer or druid then
                            npcHandler:say("Entao voce conheceu Awarness of the Emperor? Um ser realmente desprezivel, nao e mesmo? Mas voce coseguiu ajuda-lo apesar de tudo e, como combinado, aqui esta sua recompensa.", npc, creature)
                            player:addExperience(7500000, true)
                            player:addMoney(175000, true)
                            player:addItem(10451, 1, true)
                            player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 32)
                            local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                            player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
                            player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                            npcHandler:setTopic(playerId, 0)
                        end
                    else
                        npcHandler:say("Complete a missao Wrath of Emperor, em Chaos, e retorne ate mim para obter sua recompensa.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 32 then
                    if player:getLevel() >= 175 then
                        npcHandler:say("Escute, |PLAYERNAME|, voce parece alguem que lidaria bem com um desafio mais... selvagem! Que tal enfrentar alguns crocodilos? Estamos precisando de algumas linguas de crocodilo para um banquete. \z
                        Va ate Oskayaat e derrote alguns Werecrocodiles e traga 10 Werecrocodile Tongues para mim. Estarei te esperando com sua recompensa.", npc, creature)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 33)
                    else
                        npcHandler:say("Apenas jogadores de nivel 175 ou superior podem se alistar para a proxima missao.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 33 then
                    if player:removeItem(43729, 10) then
                        npcHandler:say("Wow! Talvez eu devesse ter pedido apenas 5. Me esqueci de como essas criaturas sao enormes. Aqui esta sua recompensa pelo servico.", npc, creature)
                        player:addExperience(8000000, true)
                        player:addMoney(180000, true)
                        player:addPreyCards(3, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 34)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Traga as 10 Werecrocodile Tongues para mim o quanto antes.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 34 then
                    if player:getLevel() >= 200 then
                        npcHandler:say("Otimo, voce explorou Oskayaat e ja esta um pouco familiarizado com a ilha. Agora preciso que voce faca uma jornada ainda mais adentro do local... \z
                        No fundo das masmorras de Oskayaat ha 5 espelhos da lua conectados que, se pressionados na ordem correta, liberam a passagem por uma porta mágica. Essa porta leva ate \z
                        a sala dos bosses Tamru e Ayana. Sua missao sera encontrar os espelhos, pressiona-los na ordem correta e conseguir acesso a sala das alavancas. Ao conseguir fazer isso, retorne ate mim. \z
                        Voce aceita a missao?", npc, creature)
                        npcHandler:setTopic(playerId, 14)
                    else
                        npcHandler:say("Apenas jogadores de nivel 200 ou superior podem se alistar para a proxima missao.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 35 then
                    if player:getStorageValue(Storage.Grimvale.MoonDoor) >= 2 then
                        npcHandler:say("Muito bom! Agora que voce tem acesso ao local, podera enfrentar Tamru e Ayana todos os dias puxando a alavanca. Tome, aqui esta sua recompensa por ter chegado tao longe.", npc, creature)
                        player:addExperience(9500000, true)
                        player:addMoney(190000, true)
                        player:addItem(11587, 2, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 36)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Va nas profundezas de Oskayaat e descubra a ordem correta para pressionar os 5 espelhos da lua e conseguir acesso a porta magica das alavancas. Retorne ate mim quando conseguir!", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 36 then
                    if player:getLevel() >= 220 then
                        npcHandler:say("Sua proxima missao sera dificil, nao vou negar... Te aconselho buscar um bom time para te ajudar. Voce tera que enfrentar e derrotar Azerus, um dos mais temiveis seres da ilha de Crandoria. \z
                        Seu covil esta localizado no extremo norte da ilha. Apos derrotar Azerus voce devera entrar no portal no qual ele se transformara e caminhar ate a ponta do abismo, para ter certeza de que ele nao esta mais la. Voce entendeu?", npc, creature)
                        npcHandler:setTopic(playerId, 15)
                    else
                        npcHandler:say("Apenas jogadores de nivel 220 ou superior podem se alistar para a proxima missao.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 37 then
                    if player:getStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission10) >= 3 then
                        npcHandler:say("Muito bom! Voce realmente derrotou o terrivel Azerus! Aqui esta sua recopensa por esse grande feito!", npc, creature)
                        player:addExperience(10000000, true)
                        player:addMoney(200000, true)
                        player:addItem(9099, 1, true)
                        player:addItem(11587, 1, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 38)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Va! Derrote Azerus e depois retorne para pegar sua recompensa.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 38 then
                    if player:getLevel() >= 230 then
                        npcHandler:say("Ha um homem chamado Lord Thompson que vive numa ilha habitada por insetos, ao sul de Elvenshire. Ele precisa de ajuda, parece que ele tem problemas com alguns insetos gigantes. Ajude-o em sua primeira missao e retorne ate mim e eu te recompensarei. \z
                        Essa nao sera uma missao muito facil, entao tenha cuidado. Voce aceita o desafio?", npc, creature)
                    npcHandler:setTopic(playerId, 24)
                    else
                        npcHandler:say("Apenas jogadores de nivel 230 ou superior podem se alistar para a proxima missao.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 39 then
                    if player:getStorageValue(Storage.Quest.Crandoria.InsectoidOutfit.Outfit) >= 1 then
                        npcHandler:say("Como foi lidar com aqueles insetos? Aposto que foi divertido... HA HA HA! Bom, tenho certeza de que Lord Thompson ficou satisfeito. Aqui esta sua recompensa pela missao.", npc, creature)
                        player:addExperience(10000000, true)
                        player:addMoney(200000, true)
                        player:addItem(22721, 2, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 40)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Va ate Lord Thompson e ajude-o com sua missao contra os insetos.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 40 then
                    npcHandler:say("Voce provavelmente nao tem idade para se lembrar disso, mas a Magic Plate Armor ja foi uma das armaduras mais belas e desejadas de todo o antigo continente Tibiano... muitos mataram por uma dessas ha um tempo atras. \z
                    Hoje, esquecidas, se tornaram reliquias para aqueles que ainda enxergam valor em sua historia. E eu sou um deles! HA HA HA! Coff.. coff.. Bom.. Por isso, sua proxima missao sera me trazer uma Magic Plate Armor! Estarei aguardando ansiosamente!", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 41)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 41 then
                    if player:removeItem(3366, 1) then
                        npcHandler:say("Que espetaculo! Essa deve ser a armadura mais esplendida de todas! HA! Nao acredito que poderei andar por ai com minha propria... Digo... Bom, muito obrigado. Como prometido, aqui esta sua recompensa.", npc, creature)
                        player:addExperience(10000000, true)
                        player:addMoney(200000, true)
                        player:addPreyCards(5, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 42)
                        local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                        player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
                        player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Retorne ate mim com uma Magic Plate Armor e te darei uma boa recompensa!.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 42 then
                    if player:getLevel() >= 250 then
                        npcHandler:say("Chegou a hora de voce provar seu valor na luta contra os demonios. Numa pequena ilha ao norte de Magincia esta localizado Demon Oak. Converse com Oldrak sobre ele e derrote-o. Apos derrota-lo, retorne e te darei uma recompensa. Voce aceita a missao?", npc, creature)
                        npcHandler:setTopic(playerId, 16)
                    else
                        npcHandler:say("Apenas jogadores de nivel 250 ou superior podem se alistar para a proxima missao.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 43 then
                    if player:getStorageValue(Storage.Quest.U8_2.TheDemonOak.Done) >= 3 then
                        player:addExperience(11500000, true)
                        player:addMoney(200000, true)
                        player:addItem(12311, 1, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 44)
                        npcHandler:say("Muito impressionante! Voce realmente tem se mostrado um dos mais fortes guerreiros de Crandoria. Aqui esta mais uma de suas recompensas.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Derrote Demon Oak e pegue a recompensa em um dos baus escondidos proximo a ele. Depois disso retorne e recebera sua recompensa.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 44 then
                    npcHandler:say("Que tal uma missao de coleta para relaxar um pouco? Precisamos de mais tecido para nossas bandeiras. Por favor, traga 10 Red Pieces of Cloth, 10 Yellow Pieces of Cloth, 10 White Pieces of Cloth, 10 Green Pieces of Cloth, 10 Brown Pieces of Cloth e 10 Blue Pieces of Cloth. \z
                    Te darei uma boa recompensa por eles. Voce aceita a missao?", npc, creature)
                    npcHandler:setTopic(playerId, 17)
                elseif storage == 45 then
                    if player:getItemCount(5909) >= 10 and player:getItemCount(5910) >= 10 and player:getItemCount(5911) >= 10 and player:getItemCount(5912) >= 10 and player:getItemCount(5913) >= 10 and player:getItemCount(5914) >= 10 then
                        if player:removeItem(5909, 10) and player:removeItem(5910, 10) and player:removeItem(5911, 10) and player:removeItem(5912, 10) and player:removeItem(5913, 10) and player:removeItem(5914, 10) then
                            npcHandler:say("Impressionante! Olha quantas cores. Exatamente do que estavamos precisando! Aqui esta sua recompensa pelos tecidos.", npc, creature)
                            player:addExperience(12000000, true)
                            player:addMoney(200000, true)
                            player:addOutfit(1095, 0)
                            player:addOutfit(1094, 0)
                            local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                            player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
                            player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                            player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu o Discoverer Outfit.")
                            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 46)
                            npcHandler:setTopic(playerId, 0)
                        else
                            npcHandler:say("Lembre-se: preciso de 10 tecidos de cada cor: Marrom, Branco, Azul, Vermelho, Amarelo e Verde. Traga-os para mim.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        end
                    else
                        npcHandler:say("Lembre-se: preciso de 10 tecidos de cada cor: Marrom, Branco, Azul, Vermelho, Amarelo e Verde. Traga-os para mim.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 46 then
                    npcHandler:say("Cace alguns Gazer Spectres e traga para mim 3 Hexagonal Rubys. Voce pode encontra-los em algumas cavernas com acesso por Magincia, pelo deserto de Valkesh ou pela Selva de Jagunda. Voce aceita a missao?", npc, creature)
                    npcHandler:setTopic(playerId, 18)
                elseif storage == 47 then
                    if player:removeItem(30180, 3) then
                        npcHandler:say("Magnifico! Olhe como elas brilham... sensacional! Ah! Quase me esqueci, aqui esta sua recompensa.", npc, creature)
                        player:addExperience(12000000, true)
                        player:addMoney(200000, true)
                        player:addItem(25698, 1, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 48)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Traga as 3 Hexagonal Rubys para mim. Voce vai encontra-las com os Gazer Spectre.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 48 then
                    npcHandler:say("Dessa vez te pedirei um item que nem mesmo eu sei onde conseguir... Eu preciso de uma Mysterious Voodoo Skull. Voce acha que consegue executar essa tarefa?", npc, creature)
                    npcHandler:setTopic(playerId, 19)
                elseif storage == 49 then
                    if player:removeItem(5668, 1) then
                        npcHandler:say("Voce descobriu mesmo onde encontra-la? Eu nao posso acreditar! Ate agora eu achava que era uma lenda, uma historia para criancas, uma... Digo... Mas claro que voce conseguiu encontrar! HA HA HA! \z
                        Eu nunca duvidei de voce, nem por um segundo! Aqui esta sua recompensa! HA HA HA... Lenda? Quem falou em lenda? Coff.. Coff....", npc, creature)
                        player:addExperience(15000000, true)
                        player:addMoney(200000, true)
                        player:addPreyCards(5, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 50)
                        local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                        player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
                        player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Nao conseguiu achar a Mysterious Voodoo Skull? Continue procurando, sei que voce vai conseguir!", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 50 then
                    npcHandler:say("Chega de brincadeiras de criancas! Escute aqui, os lords da Grave Danger Quest estao todos no Novo Continente. Eu preciso que voce derrote cada um deles, pelo menos UMA VEZ! Voce entende e aceita sua missao?", npc, creature)
                    npcHandler:setTopic(playerId, 20)
                elseif storage == 51 then
                    if player:getStorageValue(Storage.Quest.U12_20.GraveDanger.Bosses.BaelocNictrosKilled) >= 1 and player:getStorageValue(Storage.Quest.U12_20.GraveDanger.Bosses.CountVlarkorthKilled) >= 1 and player:getStorageValue(Storage.Quest.U12_20.GraveDanger.Bosses.DukeKruleKilled) >= 1 and player:getStorageValue(Storage.Quest.U12_20.GraveDanger.Bosses.EarlOsamKilled) >= 1 and player:getStorageValue(Storage.Quest.U12_20.GraveDanger.Bosses.LordAzaramKilled) >= 1 and player:getStorageValue(Storage.Quest.U12_20.GraveDanger.Bosses.KingZelosKilled) >= 1 then
                        npcHandler:say("Incrivel! Voce derrotou todos os chefes da Grave Danger! Muito bom, aqui esta sua recompensa pelos esforcos.", npc, creature)
                        player:addExperience(15000000, true)
                        player:addMoney(215000, true)
                        player:addItem(22721, 5, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 52)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Derrote os chefes da Grave Danger. Lembre-se: Voce precisa derrotar pelo menos uma vez Duke Krule, Sir Baeloc, Count Vlarkorth, Earl Osam, Lord Azaram e King Zelos. King Zelos com certeza sera o mais dificil, tome cuidado!", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 52 then
                    if player:getLevel() >= 270 then
                        npcHandler:say("Alguns habitantes de Crandoria precisam de sapatos novos. Dizem que os Oriental Shoes das asuras sao extremamente confortaveis. Traga 3 dos Oriental Shoes para mim e eu te recompensarei. Estarei esperando.", npc, creature)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 53)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Apenas jogadores de nivel 270 ou superior podem se alistar para a proxima missao.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 53 then
                    if player:removeItem(21981, 3) then
                        npcHandler:say("Deixe-me avaliar esses sapatos... Humm... aham.... Otimo! Estao em perfeito estado. Aqui esta sua recompensa e muito obrigado, |PLAYERNAME|.", npc, creature)
                        player:addExperience(16500000, true)
                        player:addMoney(215000, true)
                        player:addItem(39136, 2, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 54)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Por favor, traga os 3 Oriental Shoes para mim.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 54 then
                    if player:getLevel() >= 300 then
                        npcHandler:say("Eis a sua provacao, |PLAYERNAME|... A partir daqui voce estara em um novo nivel e suas missoes comecarao a exigir um pouco mais de voce. Alem disso, voce podera pegar apenas uma missao por dia a partir de agora. \z 
                        Prepare-se! Para sua proxima missao, voce devera falar com Henricus. Ele fica na torre sudoeste de Crandoria. Complete sua missao, a Inquisition Quest. Apos finalizar a quest retorne ate mim e nos conversaremos. Voce entendeu?", npc, creature)
                        npcHandler:setTopic(playerId, 21)
                    else
                        npcHandler:say("Apenas jogadores de nivel 300 ou superior podem se alistar para a proxima missao.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 55 then
                    if player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Reward) >= 1 then
                        npcHandler:say("Muito bem, nobre |PLAYERNAME|. Agora nao te tratarei mais como uma crianca, voce realmente se mostrou digno do meu respeito! Aqui, uma recompensa pela sua bravura.", npc, creature)
                        player:addExperience(17500000, true)
                        player:addMoney(225000, true)
                        player:addItem(9099, 1, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 56)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Timer, os.time() + 2 * 60 * 60)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Retorne apos finalizar a Inquisition Quest.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 56 then
                    npcHandler:say("Ola, " .. dear .. " |PLAYERNAME|. Ha uma missao disponivel para voce hoje: Coletar 10 Empty Honey Glasses. Voce aceita a missao?", npc, creature)
                    npcHandler:setTopic(playerId, 22)
                elseif storage == 57 then
                    if player:removeItem(31331, 10) then
                        npcHandler:say("Bom te ver novamente, " .. dear .. " |PLAYERNAME|. Os itens estao corretos, aqui esta sua recompensa.", npc, creature)
                        player:addExperience(17500000, true)
                        player:addMoney(225000, true)
                        player:addItem(11587, 2, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 58)
                        local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                        player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
                        player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Por favor, nos traga os 10 Empty Honey Glasses.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 58 then
                    npcHandler:say("" .. dear .. " |PLAYERNAME|. Ha uma missao disponivel para voce hoje: Coletar 05 Manticore Ears e 05 Sphinx Tiaras. Voce aceita a missao?", npc, creature)
                    npcHandler:setTopic(playerId, 23)
                elseif storage == 59 then
                    if player:removeItem(31440, 5) and player:removeItem(31438, 5) then
                        npcHandler:say("Teve um bom retorno, " .. dear .. " |PLAYERNAME|? Sobre sua missao: Os itens estao corretos, aqui esta sua recompensa.", npc, creature)
                        player:addExperience(20000000, true)
                        player:addMoney(230000, true)
                        player:addItem(22721, 5, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 60)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Timer, os.time() + 2 * 60 * 60)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Retorne com 5 sphinx tiaras e 5 manticore ears e tera sua recompensa, " .. dear .. " |PLAYERNAME|.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 60 then
                    npcHandler:say("" .. dear .. " |PLAYERNAME|, que bom que voce esta aqui. Precisamos de alguem com ampla experiencia para realizar uma missao perigosa: uma incursao a Pits of Inferno! \z
                    Reuna um time e complete essa missao tao perigosa. Ela se inicia em Serpentis, arquipelago de Chaos, numa pequena ilha a oeste. Pegue o tapete de Uzon e va para la agora mesmo! Retorne quando terminar a missao e chegar ao fundo da Pits of Inferno, obtendo seus espolios.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 61)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Timer, os.time() + 1 * 60 * 60)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 61 then
                    if player:getStorageValue(Storage.Quest.U7_9.ThePitsOfInferno.ThroneInfernatil) >= 1 and player:getStorageValue(Storage.Quest.U7_9.ThePitsOfInferno.ThroneTafariel) >= 1 and player:getStorageValue(Storage.Quest.U7_9.ThePitsOfInferno.ThroneVerminor) >= 1 and player:getStorageValue(Storage.Quest.U7_9.ThePitsOfInferno.ThroneApocalypse) >= 1 and player:getStorageValue(Storage.Quest.U7_9.ThePitsOfInferno.ThroneBazir) >= 1 and player:getStorageValue(Storage.Quest.U7_9.ThePitsOfInferno.ThroneAshfalor) >= 1 and player:getStorageValue(Storage.Quest.U7_9.ThePitsOfInferno.ThronePumin) >= 1 then
                        npcHandler:say("Voce conseguiu, " .. dear .. " |PLAYERNAME|. Passou por todos os tronos e chegou ao fim da Pits of Inferno! Aqui estao suas recompensas.", npc, creature)
                        player:addExperience(20000000, true)
                        player:addMoney(245000, true)
                        player:addItem(637, 3, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:addAchievement("Caminho de Ferro")
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 62)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("" .. dear .. " |PLAYERNAME|, por favor va ate as profundezas da Pits of Inferno e finalize a quest, passando por todos os tronos e obtendo os espolios. Depois disso, retorne ate mim.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 62 then
                    if player:getLevel() >= 350 then
                        npcHandler:say("Sabe, " .. dear .. " |PLAYERNAME|, nem toda missao tem como objetivo apenas batalhas, sangue e morte... Algumas vezes nossos objetivos sao apenas os de ajudar uma pessoa ou um grupo de pessoas. Suas proximas missoes te mostrarao melhor o que eu quero dizer. \z
                        Pegando o barco do Captain Whitepatch voce podera chegar a Astralis. Astralis sempre foi uma cidade pacifica que gira em torno da producao de recursos como alimentos e minerios para todo o Novo Continente. Alem disso, a idade sempre foi amiga de Crandoria. \z
                        Por isso quero que voce va ate la e converse com os habitantes e ajude-os com o que precisarem. Eu soube que Gondariel precisava de ajuda com algumas colheitas. Comece por ele. Retorne quando acabar suas missoes por la!", npc, creature)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 63)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Apenas jogadores de nivel 350 ou superior podem se alistar para a proxima missao.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage >= 63 and storage < 77 then
                    npcHandler:say("Ajude os habitantes de Astralis e depois retorne ate mim e reporte suas missoes!", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 77 then
                    npcHandler:say("Os habitantes de Astralis ja estao contando historias sobre os feitos de " .. dear .. " |PLAYERNAME|, sabia? Voce com certeza sera lembrado, assim como todos aqueles que ajudam os que precisam em tempos dificeis. Aqui, uma recompensa pelo seu tempo dedicado a ajudar Astralis. \z
                    Troque essas dragonfruits com Gondariel, em Astralis, ou utilize-as para produzir pocoes ou bebidas nas destilarias. Tenho certeza que conseguira um bom lucro com elas.", npc, creature)
                    player:addExperience(20000000, true)
                    player:addMoney(250000, true)
                    player:addItem(11682, 25, true)
                    player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 78)
                    player:addAchievement("Amigo de Astralis")
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Timer, os.time() + 1 * 60 * 60)
                    local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                    player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 5)
                    player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 78 then
                    npcHandler:say("A proxima cidade que precisara da sua ajuda sera Hakata. Va ate la e procure por Hugo, ele divide uma loja de itens magicos com Xodet em frente ao Templo da cidade. Ele precisa de ajuda e te dira melhor o que fazer.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 79)
                    npcHandler:setTopic(playerId, 0)
                elseif storage > 78 and storage < 82 then
                    npcHandler:say("Va ate Hakata e ajude Hugo com seu problema.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 82 then
                    npcHandler:say("Ouvi falar que voce derrotou o terrivel Faceless Bane! Mas isso ja nao me impressiona, visto o quanto voce tem ficado forte. Aqui esta sua recompensa pela missao, " .. dear .." |PLAYERNAME|.", npc, creature)
                    player:addExperience(20000000, true)
                    player:addMoney(250000, true)
                    player:addItem(9099, 1, true)
                    player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 83)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Timer, os.time() + 1 * 60 * 60)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 83 then
                    npcHandler:say("Escute, " .. dear .. " |PLAYERNAME|... Sua proxima missao sera na cidade de Valkesh. Va ate la e procure por Ahmet. Ele precisa da nossa ajuda.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 84)
                    npcHandler:setTopic(playerId, 0)
                elseif storage > 83 and storage < 86 then
                    npcHandler:say("Va ate Valkesh e ajude Ahmet e seu povo.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 86 then
                    npcHandler:say("Um Holy Scarab, " .. dear .. " |PLAYERNAME|... Nem eu imaginei que voce teria uma missao dessas. Aqui esta sua recompensa. Me avise quando estiver pronto para a proxima missao!", npc, creature)
                    player:addExperience(20000000, true)
                    player:addMoney(255000, true)
                    player:addItem(22721, 5, true)
                    player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 87)
                    local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                    player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 5)
                    player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Timer, os.time() + 1 * 60 * 60)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 87 then
                    npcHandler:say("Agora sua missao sera em Icehold. Procure por Dankwart, o vendedor de alimentos da Taverna da cidade. Ele precisa de sua ajuda com uma missao.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 88)
                    npcHandler:setTopic(playerId, 0)
                elseif storage > 87 and storage < 90 then
                    npcHandler:say("Ajude Dankwart, em Icehold, com sua missao. Retorne aqui apos finalizar a tarefa.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 90 then
                    npcHandler:say("Sinceramente, " .. dear .. " |PLAYERNAME|, nos dois sabemos que essa foi uma missao muito facil para voce. Nada mais que um descanso! Ha Ha Ha! Aqui esta sua recompensa. Me avise quando estiver pronto para uma missao de verdade!", npc, creature)
                    player:addExperience(20000000, true)
                    player:addMoney(255000, true)
                    player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                    player:addPreyCards(3, true)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 91)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Timer, os.time() + 1 * 60 * 60)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 91 then
                    npcHandler:say("Agora voce vai viajar para Chaos e procurar por Romella. Ela comercializa armas na pequena cidade. Romella em noticias alarmantes sobre alguns dos mais crueis inimigos de Crandoria e pediu para que fossemos ate la falar com ela sobre isso com urgencia. Va ate Chaos e descubra o que esta acontecendo.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 92)
                    npcHandler:setTopic(playerId, 0)
                elseif storage > 91 and storage < 97 then
                    npcHandler:say("" .. dear .. " |PLAYERNAME|, seu objetivo agora sera ajudar Romella, em Chaos. Complete suas missoes e retorne ate aqui para sua recompensa.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 97 then
                    npcHandler:say("Ja recebi as boas noticias vindas de Chaos, " .. dear .. " |PLAYERNAME|. Muito obrigado pela ajuda. ", npc, creature)
                    player:addExperience(20000000, true)
                    player:addMoney(275000, true)
                    player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                    player:addItem(randomSurpriseItem, 1, true)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 98)
                    local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                    player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 5)
                    player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Timer, os.time() + 1 * 60 * 60)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 98 then
                    npcHandler:say("" .. dear .. " |PLAYERNAME|, nossos proximos esforcos serao direcionados para os habitantes da nossa cidade vizinha, Elvenshire. Fale com Shiriel, o comerciante de pocoes da cidade e ele te dira melhor do que precisa.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 99)
                    npcHandler:setTopic(playerId, 0)
                elseif storage > 98 and storage < 101 then
                    npcHandler:say("Voce precisa ajudar Shiriel com sua missao, em Elvenshire. Volte quando tiver terminado.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 101 then
                    npcHandler:say("" .. dear .. " |PLAYERNAME|, voce realmente esta colecionando vitorias. Estou muito orgulhoso da sua jornada ate aqui. Sua recompensa esta aqui mesmo. Me diga quando quiser uma nova missao.", npc, creature)
                    player:addExperience(20000000, true)
                    player:addMoney(275000, true)
                    player:addItem(36726, 1, true)
                    player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 102)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Timer, os.time() + 1 * 60 * 60)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 102 then
                    npcHandler:say("Proxima parada: Magincia! Sandra, vendedora de pocoes da cidade, pediu ajuda com um assunto urgente. Ela nao disse na carta o que era o problema, mas quando li que era urgente pensei logo em " .. dear .. " |PLAYERNAME|!", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 103)
                    npcHandler:setTopic(playerId, 0)
                elseif storage > 102 and storage < 105 then
                    npcHandler:say("Ajude Sandra, em Magincia, com sua missao e so depois retorne para reportar os resultados.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 105 then
                    npcHandler:say("Sensacional, " .. dear .. " |PLAYERNAME|! Voce tem se tornado uma pessoa de muita honra por todo o Novo Continente. Aqui, tome sua recompensa.", npc, creature)
                    player:addExperience(20000000, true)
                    player:addMoney(275000, true)
                    player:addItem(39136, 2, true)
                    player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 106)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Timer, os.time() + 1 * 60 * 60)
                    local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                    player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 5)
                    player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 106 then
                    npcHandler:say("Tenho certeza que ja ouviu falar de Anvillux, a cidade dos Anoes. Bom, esse sera seu itinerario para a proxima missao! Procure por Drulok, na taverna da cidade. Ele nos enviou uma carta recentemente e disse precisar de alguem com experiencia. Va ate la e veja o que houve.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 107)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 109 then
                    npcHandler:say("Drulok pode estar quase sempre bebado, mas acredite, ele sempre foi um grande guerreiro. Obrigado por ajuda-lo, " .. dear .. " |PLAYERNAME|. Aqui esta sua recompensa.", npc, creature)
                    player:addExperience(20000000, true)
                    player:addMoney(275000, true)
                    player:addItem(26186, 1, true)
                    player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 110)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 110 then
                    npcHandler:say("Resta apenas uma cidade para voce visitar, " .. dear .. " |PLAYERNAME|: Nivabi, a cidade do recomeco. Mugruu, um ogro pacifico que vive na cidade, precisa da sua ajuda. Veja o que ele quer e ajude-o como puder, por favor.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 111)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 113 then
                    npcHandler:say("Devo dizer, " .. dear .." |PLAYERNAME|, que voce realmente poderia se tornar diplomata de Crandoria! Seus esforcos culminaram na satisfacao de residentes de todo o Novo Continente! Aqui esta sua recompensa por essa e as outras missoes ate aqui.", npc, creature)
                    player:addExperience(20000000, true)
                    player:addMoney(275000, true)
                    player:addItem(12811, 1, true)
                    player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                    player:addAchievement("Diplomata")
                    player:addOutfitAddon(1095, 1)
                    player:addOutfitAddon(1094, 1)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu addon 1 do Discoverer Outfits.")
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 114)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, 0)
                    local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                    player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 5)
                    player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 114 then
                    npcHandler:say("Ah... " .. dear .. " |PLAYERNAME|, ao chegar em certo nivel nao basta apenas derrotar criaturas aqui e ali... Precisamos saber como derrotar os monstros e manter seus recursos intocados e com alta qualidade, afinal de contas sao nossos espolios! Nossa fonte de renda. \z
                    Entao agora te darei algumas missoes para obter alguns itens de criaturas derrotadas, mas todos os itens entregues deverao ter altissima qualidade! Eu irei conferir UM a UM. Para comecar, me traga 5 Sphinx Feathers. Esta pronto para esse desafio?", npc, creature)
                    npcHandler:setTopic(playerId, 25)
                elseif storage == 115 then
                    if randomChance > 2 then
                        if player:removeItem(31437, 1) then
                            if storageItems < 3 then
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, storageItems + 1)
                                npcHandler:say("Incrivel! Esse item tem altissima qualidade. Ok, traga-me mais " ..itemsLeft.. " itens iguais a este.", npc, creature)
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItemsTimer, os.time() + 15 * 60)
                                npcHandler:setTopic(playerId, 0)
                            elseif storageItems == 3 then
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, storageItems + 1)
                                npcHandler:say("Incrivel! Esse item tem altissima qualidade. Ok, traga-me mais " ..itemsLeft.. " item igual a este.", npc, creature)
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItemsTimer, os.time() + 15 * 60)
                                npcHandler:setTopic(playerId, 0)
                            elseif storageItems >= 4 then
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, 0)
                                npcHandler:say("Muito bom! Voce entregou todos os 5 itens de altissima qualidade. Me avise quando estiver pronto para a proxima coleta!", npc, creature)
                                player:addExperience(25000000, true)
                                player:addMoney(275000, true)
                                player:addPremiumDays(2, true)
                                player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 116)
                                npcHandler:setTopic(playerId, 0)
                                player:save()
                                player:remove()
                            end
                        else
                            npcHandler:say("Traga-me todas as 5 Sphinx Feathers com alta qualidade.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        end
                    else
                        if player:removeItem(31437, 1) then
                            npcHandler:say("Sinto muito, mas esse item nao tem boa qualidade.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        else
                            npcHandler:say("Traga-me todas as 5 Sphinx Feathers com alta qualidade.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        end
                    end
                elseif storage == 116 then
                    npcHandler:say("Sua proxima missao sera coletar 5 Liodile Fangs. Essas raras criaturas sao encontradas na ilha de Squidspot. Captain Donahue pode te levar ate la. Traga-me os itens de alta qualidade!", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 117)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 117 then
                    if randomChance > 2 then
                        if player:removeItem(40583, 1) then
                            if storageItems < 3 then
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, storageItems + 1)
                                npcHandler:say("Incrivel! Esse item tem altissima qualidade. Ok, traga-me mais " ..itemsLeft.. " itens iguais a este.", npc, creature)
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItemsTimer, os.time() + 15 * 60)
                                npcHandler:setTopic(playerId, 0)
                            elseif storageItems == 3 then
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, storageItems + 1)
                                npcHandler:say("Incrivel! Esse item tem altissima qualidade. Ok, traga-me mais " ..itemsLeft.. " item igual a este.", npc, creature)
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItemsTimer, os.time() + 15 * 60)
                                npcHandler:setTopic(playerId, 0)
                            elseif storageItems >= 4 then
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, 0)
                                npcHandler:say("Muito bom! Voce entregou todos os 5 itens de altissima qualidade. Me avise quando estiver pronto para a proxima coleta!", npc, creature)
                                player:addExperience(25000000, true)
                                player:addMoney(275000, true)
                                player:addItem(20138, 1, true)
                                player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 118)
                                npcHandler:setTopic(playerId, 0)
                            end
                        else
                            npcHandler:say("Traga-me todas as 5 Liodile Fangs com alta qualidade.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        end
                    else
                        if player:removeItem(40583, 1) then
                            npcHandler:say("Sinto muito, mas esse item nao tem boa qualidade.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        else
                            npcHandler:say("Traga-me todas as 5 Liodile Fangs com alta qualidade.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        end
                    end
                elseif storage == 118 then
                    npcHandler:say("Muito bem, agora seu desafio sera um pouco mais dificil, " ..dear.. " |PLAYERNAME|... Agora minha demanda sera 5 Sea Horse Figurines. Voce encontrara esse item em Nivabi, com os guerreiros do Sol. Traga apenas os de melhor qualidade para mim.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 119)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 119 then
                    if randomChance > 3 then
                        if player:removeItem(31323, 1) then
                            if storageItems < 3 then
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, storageItems + 1)
                                npcHandler:say("Incrivel! Esse item tem altissima qualidade. Ok, traga-me mais " ..itemsLeft.. " itens iguais a este.", npc, creature)
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItemsTimer, os.time() + 15 * 60)
                                npcHandler:setTopic(playerId, 0)
                            elseif storageItems == 3 then
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, storageItems + 1)
                                npcHandler:say("Incrivel! Esse item tem altissima qualidade. Ok, traga-me mais " ..itemsLeft.. " item igual a este.", npc, creature)
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItemsTimer, os.time() + 15 * 60)
                                npcHandler:setTopic(playerId, 0)
                            elseif storageItems >= 4 then
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, 0)
                                npcHandler:say("Muito bom! Voce entregou todos os 5 itens de altissima qualidade. Me avise quando estiver pronto para a proxima coleta!", npc, creature)
                                player:addExperience(25000000, true)
                                player:addMoney(300000, true)
                                player:addItem(26186, 1, true)
                                player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 120)
                                npcHandler:setTopic(playerId, 0)
                            end
                        else
                            npcHandler:say("Traga-me todas as 5 Sea Horse Figurines com alta qualidade.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        end
                    else
                        if player:removeItem(31323, 1) then
                            npcHandler:say("Sinto muito, mas esse item nao tem boa qualidade.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        else
                            npcHandler:say("Traga-me todas as 5 Sea Horse Figurines com alta qualidade.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        end
                    end 
                elseif storage == 120 then
                    npcHandler:say("" ..dear.. " |PLAYERNAME|, agora voce ira rumo as Warzones! Traga-me 5 Tremendous Tyrant Shells dos Tremendous Tyrants e lembre-se: Todos deevm ser da melhor qualidade.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 121)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 121 then
                    if randomChance > 3 then
                        if player:removeItem(36784, 1) then
                            if storageItems < 3 then
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, storageItems + 1)
                                npcHandler:say("Incrivel! Esse item tem altissima qualidade. Ok, traga-me mais " ..itemsLeft.. " itens iguais a este.", npc, creature)
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItemsTimer, os.time() + 15 * 60)
                                npcHandler:setTopic(playerId, 0)
                            elseif storageItems == 3 then
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, storageItems + 1)
                                npcHandler:say("Incrivel! Esse item tem altissima qualidade. Ok, traga-me mais " ..itemsLeft.. " item igual a este.", npc, creature)
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItemsTimer, os.time() + 15 * 60)
                                npcHandler:setTopic(playerId, 0)
                            elseif storageItems >= 4 then
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, 0)
                                npcHandler:say("Muito bom! Voce entregou todos os 5 itens de altissima qualidade. Me avise quando estiver pronto para a proxima coleta!", npc, creature)
                                player:addExperience(25000000, true)
                                player:addMoney(300000, true)
                                player:addItem(22739, 1, true)
                                player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 122)
                                npcHandler:setTopic(playerId, 0)
                            end
                        else
                            npcHandler:say("Traga-me todas as 5 Tremendous Tyrant Shells com alta qualidade.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        end
                    else
                        if player:removeItem(36784, 1) then
                            npcHandler:say("Sinto muito, mas esse item nao tem boa qualidade.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        else
                            npcHandler:say("Traga-me todas as 5 Tremendous Tyrant Shells com alta qualidade.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        end
                    end 
                elseif storage == 122 then
                    npcHandler:say("" ..dear.. " |PLAYERNAME|, voce ja matou algum Hellflayer? HA HA HA! O que estou dizendo? Claro que ja! Ok, traga-me 5 Pairs of Hellflayer Horns da melhor qualidade para mim.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 123)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 123 then
                    if randomChance > 4 then
                        if player:removeItem(22729, 1) then
                            if storageItems < 3 then
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, storageItems + 1)
                                npcHandler:say("Incrivel! Esse item tem altissima qualidade. Ok, traga-me mais " ..itemsLeft.. " itens iguais a este.", npc, creature)
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItemsTimer, os.time() + 15 * 60)
                                npcHandler:setTopic(playerId, 0)
                            elseif storageItems == 3 then
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, storageItems + 1)
                                npcHandler:say("Incrivel! Esse item tem altissima qualidade. Ok, traga-me mais " ..itemsLeft.. " item igual a este.", npc, creature)
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItemsTimer, os.time() + 15 * 60)
                                npcHandler:setTopic(playerId, 0)
                            elseif storageItems >= 4 then
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, 0)
                                npcHandler:say("Muito bom! Voce entregou todos os 5 itens de altissima qualidade. Me avise quando estiver pronto para a proxima coleta!", npc, creature)
                                player:addExperience(25000000, true)
                                player:addMoney(300000, true)
                                player:addItem(36827, 1, true)
                                player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 124)
                                npcHandler:setTopic(playerId, 0)
                            end
                        else
                            npcHandler:say("Traga-me todas as 5 Pairs of Hellflayer Horns com alta qualidade.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        end
                    else
                        if player:removeItem(22729, 1) then
                            npcHandler:say("Sinto muito, mas esse item nao tem boa qualidade.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        else
                            npcHandler:say("Traga-me todas as 5 Pairs of Hellflayer Horns com alta qualidade.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        end
                    end
                elseif storage == 124 then
                    npcHandler:say("Muito bem, " ..dear.. " |PLAYERNAME|. Voce esta a caminho de se tornar um mestre na coleta de recursos! Agora eu quero que voce me traga 5 Headpecker Beaks. Voce vai encontrar esses monstros em Gnomprona.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 125)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 125 then
                    if randomChance > 4 then
                        if player:removeItem(39387, 1) then
                            if storageItems < 3 then
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, storageItems + 1)
                                npcHandler:say("Excelente! Esse item tem altissima qualidade. Ok, traga-me mais " ..itemsLeft.. " itens iguais a este.", npc, creature)
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItemsTimer, os.time() + 15 * 60)
                                npcHandler:setTopic(playerId, 0)
                            elseif storageItems == 3 then
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, storageItems + 1)
                                npcHandler:say("Ecelente! Esse item tem otima qualidade. Ok, traga-me mais " ..itemsLeft.. " item igual a este.", npc, creature)
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItemsTimer, os.time() + 15 * 60)
                                npcHandler:setTopic(playerId, 0)
                            elseif storageItems >= 4 then
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, 0)
                                npcHandler:say("Muito bom! Voce entregou todos os 5 itens de altissima qualidade. Me avise quando estiver pronto para a proxima coleta!", npc, creature)
                                player:addExperience(25000000, true)
                                player:addMoney(300000, true)
                                player:addItem(31633, 1, true)
                                player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 126)
                                npcHandler:setTopic(playerId, 0)
                            end
                        else
                            npcHandler:say("Traga-me todas as 5 Headpecker Beaks com alta qualidade.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        end
                    else
                        if player:removeItem(39387, 1) then
                            npcHandler:say("Sinto muito, mas esse item nao tem boa qualidade.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        else
                            npcHandler:say("Traga-me todas as 5 Headpecker Beaks com alta qualidade.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        end
                    end
                elseif storage == 126 then
                    npcHandler:say("Estamos quase fechando nossa colecao, " ..dear.. " |PLAYERNAME|. Agora precisamos de um item que voce so vai conseguir com as criaturas mais inteligentes. \z
                    Preciso de 5 Silken Bookmarks! Traga-os para mim, mas lembre-se: Apenas os de melhor qualidade serao aceitos!", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 127)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 127 then
                    if randomChance > 5 then
                        if player:removeItem(28566, 1) then
                            if storageItems < 3 then
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, storageItems + 1)
                                npcHandler:say("Excelente! Esse item tem altissima qualidade. Ok, traga-me mais " ..itemsLeft.. " itens iguais a este.", npc, creature)
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItemsTimer, os.time() + 15 * 60)
                                npcHandler:setTopic(playerId, 0)
                            elseif storageItems == 3 then
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, storageItems + 1)
                                npcHandler:say("Ecelente! Esse item tem otima qualidade. Ok, traga-me mais " ..itemsLeft.. " item igual a este.", npc, creature)
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItemsTimer, os.time() + 15 * 60)
                                npcHandler:setTopic(playerId, 0)
                            elseif storageItems >= 4 then
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, 0)
                                npcHandler:say("Muito bom! Voce entregou todos os 5 itens de altissima qualidade. Me avise quando estiver pronto para a proxima coleta!", npc, creature)
                                player:addExperience(25000000, true)
                                player:addMoney(300000, true)
                                player:addItem(20273, 1, true)
                                player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 128)
                                npcHandler:setTopic(playerId, 0)
                            end
                        else
                            npcHandler:say("Traga-me todas as 5 Silken Bookmarks com alta qualidade.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        end
                    else
                        if player:removeItem(28566, 1) then
                            npcHandler:say("Sinto muito, mas esse item nao tem boa qualidade.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        else
                            npcHandler:say("Traga-me todas as 5 Silken Bookmarks com alta qualidade.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        end
                    end
                elseif storage == 128 then
                    npcHandler:say("Essa sera sua ultima missao de coleta de itens de alta qualidade, " ..dear.. " |PLAYERNAME|. Pelo menos por enquanto... 'HA HA HA!' Bom... Esta preparado? \z
                    Para essa missao, preciso que me traga 5 Infernal Hearts! Voce pode obte-los derrotando Infernal Phantoms. Estarei esperando pelos Infernal Hearts de maxima qualidade!", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 129)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 129 then
                    if randomChance > 6 then
                        if player:removeItem(34139, 1) then
                            if storageItems < 3 then
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, storageItems + 1)
                                npcHandler:say("Excelente! Esse Infernal Heart tem uma otima qualidade. Ok, traga-me mais " ..itemsLeft.. " itens iguais a este.", npc, creature)
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItemsTimer, os.time() + 15 * 60)
                                npcHandler:setTopic(playerId, 0)
                            elseif storageItems == 3 then
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, storageItems + 1)
                                npcHandler:say("Ecelente! Esse Infernal Heart tem altissima qualidade. Ok, traga-me mais " ..itemsLeft.. " item igual a este.", npc, creature)
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItemsTimer, os.time() + 15 * 60)
                                npcHandler:setTopic(playerId, 0)
                            elseif storageItems >= 4 then
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, 0)
                                npcHandler:say("Muito bom! Voce entregou todos os 5 itens de altissima qualidade. Por ter completado essa missao, eu declaro voce um verdadeiro Prospector de Crandoria!", npc, creature)
                                player:addExperience(25000000, true)
                                player:addMoney(300000, true)
                                player:addItem(34109, 1, true)
                                player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                                player:addAchievement("Prospector de Crandoria")
                                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 130)
                                npcHandler:setTopic(playerId, 0)
                            end
                        else
                            npcHandler:say("Traga-me todas as 5 Infernal Hearts com alta qualidade.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        end
                    else
                        if player:removeItem(34139, 1) then
                            npcHandler:say("Sinto muito, mas esse item nao tem boa qualidade.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        else
                            npcHandler:say("Traga-me todas as 5 Infernal Hearts com alta qualidade.", npc, creature)
                            npcHandler:setTopic(playerId, 0)
                        end
                    end
                elseif storage == 130 then
                    npcHandler:say("Bom, " ..dear.. " |PLAYERNAME|... Suas proximas missoes serao para beneficiar a todos de Crandoria. Faremos em breve uma comemoracao do aniversario da cidade e preciso que me traga algumas coisas. \z
                    Tudo o que vou te pedir sera essencial para que corra tudo bem e nao falte nada na festa, entao por favor nos ajude com isso. Primeiramente eu preciso de garrafas de cerveja. Elas podem ser adquiridas com Brugadok em Astralis. \z
                    Preciso de 5 delas. Estarei esperando, por favor nao demore!", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 131)
                elseif storage == 131 then
                    if player:removeItem(21872, 5) then
                        npcHandler:say("Excelente! A cerveja de Astralis sempre foi a melhor cerveja do Novo Continente. Alguns dizem que a agua do lugar tem uma pureza especial... Quem sabe... Bom, aqui esta sua recompensa. Me avise quando quiser iniciar a proxima missao.", npc, creature)
                        player:addExperience(2500000 * (player:getLevel() / 100), true)
                        player:addMoney(300000, true)
                        player:addItem(11587, 1, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 132)
                        local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                        player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 5)
                        player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Preciso de 5 garrafas da cerveja feita em Astralis. Por favor, traga-as para que possamos oferecer a todos na cerimonia.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 132 then
                    npcHandler:say("Para a proxima missao, " ..dear.. " |PLAYERNAME|, precisarei de alguns alimentos especificos para agradar a cada um dos Comandantes que irao comparecer a cerimonia em alguns dias. \z
                    Somos no total 3 comandantes e cada um de nos temos uma comida favorita, por isso precise que preste atencao: Traga 1 Hydra Tongue Salad, 1 Blessed Steak e 1 Rotworm Stew. \z
                    Voce pode obter essas maravilhosas receitas com os comerciantes de Astralis em troca de frutos colhidos nas fazendas. Por favor, nao demore!", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 133)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 133 then
                    if player:getItemCount(9080) >= 1 and player:getItemCount(9086) >= 1 and player:getItemCount(9079) >= 1 then
                        player:removeItem(9080, 1)
                        player:removeItem(9086, 1)
                        player:removeItem(9079, 1)
                        npcHandler:say("Incrivel! Que cheiro magnifico! Muito obrigado, " ..dear.. " |PLAYERNAME|. Agora ja temos quase tudo o que precisamos para nossa grande cerimonia. Aqui, uma recompensa pelas refeicoes.", npc, creature)
                        player:addExperience(2500000 * (player:getLevel() / 100), true)
                        player:addMoney(350000, true)
                        player:addItem(26186, 1, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 134)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Por favor, traga os pratos favoritos de cada comandante. Traga 1 Hydra Tongue Salad, 1 Blessed Steak e 1 Rotworm Stew. Voce pode obter essas maravilhosas receitas com os comerciantes de Astralis em troca de frutos colhidos nas fazendas.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 134 then
                    npcHandler:say("Bom, " ..dear.. " |PLAYERNAME|, o proximo item talvez nao seja tao facil de se conseguir. Queremos um item que demonstre nossa forca sobre os demonios terriveis de forma imponente e de modo que todos possam ver. \z
                    Acredito que a melhor forma de fazer isso seja com um grande Demonic Tapestry estendido na parede. O que acha? Voce conseguira um deles de Prince Drazzak. Nao sera uma tarefa facil, mas com seu poder nao passara de 'apenas mais um desafio'. \z
                    Por favor, traga um Demonic Tapestry para que possamos estende-lo durante a festa para que todos vejam que nos nao tememos essas criaturas!", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 135)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 135 then
                    if player:removeItem(20278, 1) then
                        npcHandler:say("Muito bom, " ..dear.. " |PLAYERNAME|. Este Demonic Tapestry esta impecavel. Aqui sua recompensa. Acredito que so falta uma coisa para que tenhamos tudo para nossa festa!", npc, creature)
                        player:addExperience(2500000 * (player:getLevel() / 100), true)
                        player:addMoney(350000, true)
                        player:addItem(9099, 1, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 136)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Preciso de um Demonic Tapestry para estender em nossa cerimonia. Por favor, nao volte sem um deles!", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 136 then
                    npcHandler:say("Bom, " ..dear.. " |PLAYERNAME|. Por ultimo, mas nao menos importante: Precisamos de presentes! Acredito que um dos melhores presentes que alguem pode receber talvez seja uma Wilfred's Bag. \z
                    Wilfred Storm fica ao lado da loja da Jessica, em Crandoria, e oferece missoes diarias a guerreiros que ja possuem seu poder comprovado. Em troca ele oferece suas Wilfred Bags. Que tal trazer uma para mim? \z
                    Se cada guerreiro trouxer uma, conseguiremos presentear todos os habitantes de Crandoria na nossa comemoracao. Estarei esperando!", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 137)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 137 then
                    if player:removeItem(39577, 1) then
                        npcHandler:say("Sua generosidade nao tem tamanho, " ..dear.. " |PLAYERNAME|. Sei que alguem ficara feliz ao receber este presente. Aqui, te darei uma boa recompensa em troca dele. Agora sim teremos uma festa e tanto! Muito obrigado pela ajuda.", npc, creature)
                        player:addExperience(2500000 * (player:getLevel() / 100), true)
                        player:addMoney(350000, true)
                        player:addItem(26186, 2, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 138)
                        player:addAchievement("Festejando em Crandoria")
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Por favor, traga uma Wilfred's Bag para que possamos usa-la como presente para um de nossos habitantes durante nossa festa.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 138 then
                    npcHandler:say("Saudacoes, " ..dear.. " |PLAYERNAME|. Voce agora vai treinar para se tornar mestre em exploracao! Para iniciar, preciso que voce ajude dois grandes amigos de Crandoria: Captain Donahue, o explorador, e Lady Vandart, a defensora de Hakata. \z
                    Comecaremos sua missao com Lady Vandart. Pelo que soube ela esta precisando muito de ajuda para capturar tres criminosos que vivem importunando a vida dos habitantes do Novo Continente. \z
                    Va ate Hakata e fale com ela. Veja do que ela precisa e, ao terminar sua missao, retorne ate mim. Por favor, nao demore!", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 139)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 139 then
                    if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso) == 16 then
                        npcHandler:say("Entao voces descobriram a localizacao de Hidrox e Rocket Tank? Otimo. Diga a Lady Vandart que mandarei as tropas hoje mesmo para captura-los.", npc, creature)
                        -- player:addItem(9099, 1, true)
                        -- player:addExperience(1500000, true)
                        player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso, 17)
                        npcHandler:setTopic(playerId, 0)
                    elseif player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso) >= 18 then
                        npcHandler:say("Eu soube das noticias, " ..dear.. " |PLAYERNAME|. Finalmente capturamos aqueles malditos criminosos! Soube que voce foi ate Umbra para tal feito. Incrivel! Fico feliz que voce tenha conseguio ajudar nessa importante missao. Aqui esta sua recompensa. Me diga quando estiver preparado para seu proximo desafio.", npc, creature)
                        player:addExperience(2500000 * (player:getLevel() / 100), true)
                        player:addMoney(350000, true)
                        player:addItem(7889, 20, true)
                        player:addItem(20138, 1, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 140)
                        local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                        player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 5)
                        player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Ajude Lady Vandart a capturar os criminosos. Retorne quando todos estiverem presos.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 140 then
                    npcHandler:say("Sua proxima missao sera simples, " ..dear.. " |PLAYERNAME|. Voce deve ajudar Captain Donauhe a recuperar seu tesouro perdido. Va ate seu barco, na praia de Crandoria, e fale com ele sobre o tesouro. \z
                    Dizem que ele oferece seus servicos de navegacao para qualquer um que obtenha o seu tesouro de volta... Estarei esperando pelo seu retorno.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 141)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 141 then
                    if player:getStorageValue(Storage.Quest.Crandoria.CaptainDonahue.Treasure) >= 1 then
                        npcHandler:say("Incrivel, " ..dear.. " |PLAYERNAME|! Voce realmente recuperou o tesouro perdido do Captain Donahue. Sei que ele ficou muito contente. Aqui esta, uma recompensa pelo seu trabalho.", npc, creature)
                        player:addExperience(2500000 * (player:getLevel() / 100), true)
                        player:addMoney(400000, true)
                        player:addItem(26186, 1, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 142)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Va ate Captain Donahue, na praia de Crandoria, e pergunte sobre os itens do seu tesouro perdido. Recupere todos os itens para ele e depois retorne ate mim.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 142 then
                    npcHandler:say("Muito bem, " ..dear.. " |PLAYERNAME|. Agora voce ja possui habilidade de abrir baus com lockpick e tambem pode utilizar dos servicos de navegacao do Captain Donahue. \z
                    Para provar que voce realmente virou um eximio explorador, preciso que voce va ate Squidspot com Captain Donahue e encontre um bau escondido na ilha. Este bau possui um tesouro dentro. \z
                    Sua missao sera ir ate Squidspot e abrir este bau utilizando sua habilidade de Lockpicking. Pegue o tesouro que esta dentro do bau e traga-o para mim! Nao demore, estarei esperando por voce!", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 143)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 143 then
                    npcHandler:say("Va ate Squidspot, encontra o bau trancado e abra-o com um Lock Pick. Traga o tesouro guardado dentro dele para mim!", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 144 then
                    if player:removeItem(4841, 1) then
                        npcHandler:say("Uma Memory Stone? Na verdade, " ..dear.. " |PLAYERNAME|, devo confessar que nao vejo uma pedra dessas ha muitos anos... Vou investigar um pouco mais e verei o que descobrimos sobre isso. Enquanto isso, aqui esta uma recompensa pelo risco que voce correu.", npc, creature)
                        player:addExperience(2500000 * (player:getLevel() / 100), true)
                        player:addMoney(400000, true)
                        player:addItem(9099, 1, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 145)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Traga o tesouro guardado dentro do bau para mim!", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 145 then
                    npcHandler:say("Tenho mais um teste para voce, " ..dear.. " |PLAYERNAME|. Sua proxima missao sera encontrar o caminho para o castelo da Queen Eloise, conhecida atualmente como Former Queen, ou Rainha Aposentada. \z
                    No seu castelo ha um bau especial escondido. Esse bau foi colocado la dentro por mim mesmo, com autorizacao da Rainha. Este e um teste para ver se voce realmente pode ser chamado de Explorador de Crandoria! \z
                    Sua missao sera muito simples: Encontrar o bau, abri-lo e trazer o que tiver la dentro para mim. Se quiser uma pista de como chegar, pergunte a Drulok, na taverna de Anvillux. Va! Estarei esperando pelo seu retorno.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 146)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 146 then
                    npcHandler:say("Encontre o bau escondido no castelo da Former Queen e abra-o utilizando um Lock Pick. Depois traga o conteudo do bau para mim!", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 147 then
                    local barCount = player:getItemCount(9058)
                    if barCount >= 5 then
                        player:removeItem(9058, 5)
                        npcHandler:say("Um, duas... Cinco gold ingots! Exatamente o que eu havia deixado no bau. Bom, " ..dear.. " |PLAYERNAME|, Voce esta ha um passo de me convencer que merece o titulo de Explorador de Crandoria! Aqui esta sua recompensa pela missao.", npc, creature)
                        player:addExperience(2500000 * (player:getLevel() / 100), true)
                        player:addItem(9058, 5, true)
                        player:addItem(22706, 1, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 148)
                        npcHandler:setTopic(playerId, 0)
                    elseif barCount < 5 and barCount > 0 then
                        player:removeItem(9058, barCount)
                        npcHandler:say("Bom, " ..dear.. " |PLAYERNAME|, nao sei o que houve no caminho, mas voce nao trouxe todas as barras que eu havia deixado no bau... De qualquer forma, aqui esta uma pequena recompensa pela missao.", npc, creature)
                        player:addExperience(2500000 * (player:getLevel() / 100), true)
                        player:addItem(9058, 1, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 148)
                        npcHandler:setTopic(playerId, 0)
                    elseif barCount == 0 then
                        npcHandler:say("Encontre o bau escondido no castelo da Former Queen e abra-o utilizando um Lock Pick. Depois traga o conteudo do bau para mim!", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 148 then
                    npcHandler:say("Estou mesmo muito impressionado, " ..dear.. " |PLAYERNAME|. Te darei um ultimo desafio para voce provar sua capacidade em explorar o Novo Continente. Espero que esteja preparado, essa missao nao sera como as outras. \z
                    Em uma pequena ilha do Novo Continente vive um velho chamado Kame. Ele sempre esta tendo problemas em razao da idade avancada e precisa de ajuda de viajantes que passam por la. O problema e que poucos sabem como chegar a ilha. \z
                    Seu objetivo, claramente, sera encontrar a ilha de Kame e ajuda-lo com qualquer missao que ele tiver para te dar. Ao finalizar retorne ate mim com seu relatorio da missao.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 149)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 149 then
                    if player:getStorageValue(Storage.Quest.Crandoria.OldKame.Progresso) == 3 then
                        npcHandler:say("Voce encontrou mesmo o Velho Kame, " ..dear.. " |PLAYERNAME|? HA! Tudo bem, voce me deixou sem palavras. Voce recebeu oficialmente o titulo de Explorador de Crandoria. Meus parabens! Aqui, uma boa recompensa pelo titulo.", npc, creature)
                        player:addExperience(2500000 * (player:getLevel() / 100), true)
                        player:addMoney(400000, true)
                        player:addItem(22706, 1, true)
                        player:addItem(11372, 1, true)
                        player:addOutfitAddon(1095, 2)
                        player:addOutfitAddon(1094, 2)
                        player:addAchievement("Explorador de Crandoria")
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                        player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
                        player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 150)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("Encontre a ilha do Velho Kame! Se nao souber por onde comecar a procurar, va ate a biblioteca...", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                elseif storage == 150 then
                    npcHandler:say("Voce realmente explorou bem as terras do Novo Continente, " ..dear.. " |PLAYERNAME|. Mas seu trabalho de reconhecimento ainda nao acabou! Agora testarei se voce tambem pode explorar locais umidos, obscuros e sombrios. \z
                    Nas proximas missoes voce enfrentara inimigos terriveis, entao se prepare! E eu entenderei caso voce nao sinta que da conta do recado. As proximas missoes nao sao para qualquer um. \z
                    Primeiramente voce tera que buscar pela Pale Worm. Esse monstro terrivel vive em terras so acessadas por um portal no deserto de Valkesh. Encontre esse monstro e derrote-o! Retorne ate mim quando a vitoria for sua.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 151)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 151 then
                    npcHandler:say("Derrote a Pale Worm e retorne ate mim para reportar sua vitoria.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 152 then
                    npcHandler:say("Mais uma vez voce nao decepcionou, " ..dear.. " |PLAYERNAME|. Aquele maldito verme gigante estava causando problemas ha muito tempo! Aqui esta sua recompensa. Me avise quando quiser iniciar a sua proxima missao.", npc, creature)
                    player:addExperience(2500000 * (player:getLevel() / 100), true)
                    player:addMoney(400000, true)
                    player:addItem(9099, 1, true)
                    player:addItem(637, 3, true)
                    player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 153)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 153 then
                    npcHandler:say("Chegou a hora, " ..dear.. " |PLAYERNAME|. Precisamos explorar melhor os perigos do Novo Continente, nao apenas para derrotar criaturas terriveis, mas para resolver problemas que nos cercam. \z
                    Em Squidspot ha um desses problemas, chamado Doctor Marrow. Este cientista maluco esta trabalhando em experimentos terriveis, tentando transformar a si proprio num monstro. Temos medo de que ele utilize isso nao apenas em si, mas nos outros. \z
                    Preciso que voce va ate as profundezas das cavernas de Squidspot e encontre seu esconderijo. Derrote-o de uma vez por todas e retorne ate mim. E tenha muito cuidado!", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 154)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 154 then
                    npcHandler:say("Derrote Doctor Marrow em Squidspot e retorne ate mim.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 155 then
                    npcHandler:say("Nem mesmo o terrivel monstro de Doctor Marrow coseguiu te parar, " ..dear.. " |PLAYERNAME|. Muito impressionante! Aqui esta sua recompensa. Sua proxima missao ja te espera!", npc, creature)
                    player:addExperience(2500000 * (player:getLevel() / 100), true)
                    player:addMoney(400000, true)
                    player:addItem(22724, 25, true)
                    player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 156)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 156 then
                    npcHandler:say("Muito bem, " ..dear.. " |PLAYERNAME|. O Doctor Marrow talvez nao tenha sido um desafio tao grande para voce, mas o proximo desafio com certeza sera muito maior! \z
                    Nas profundezas das cavernas que levam a Pale Worm voce encontrara uma alavanca que o levara para uma gruta sombria e perigosa. Atravessando o lugar voce encontrara um teleport que o levara para uma sala especial. \z
                    Nessa sala voce encontrara os chefes da 'Soul War'! Sua missao sera derrotar todos eles e, por fim, derrotar o temivel Goshnar's Megalomania! Se conseguir terminar a missao, retorne ate mim. Confio no seu poder.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 157)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 157 then
                    npcHandler:say("Derrote Goshnar's Megalomania e retorne ate mim. Te darei uma boa recompensa em troca de sua missao.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 158 then
                    npcHandler:say("Voce demorou, " ..dear.. " |PLAYERNAME|. Mas eu entendo perfeitamente... Goshnar's Megalomania nao seria mesmo um desafio facil. Aqui, sua recompensa. Muito obrigado pela ajuda nessa missao tao importante.", npc, creature)
                    player:addExperience(2500000 * (player:getLevel() / 100), true)
                    player:addMoney(400000, true)
                    player:addItem(22724, 35, true)
                    player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 159)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 159 then
                    npcHandler:say("Vejamos se voce realmente se tornou mestre em explorar cavernas e locais perigosos, " ..dear.. " |PLAYERNAME|. Sua proxima missao sera em uma caverna na Ilha de Sangue, onde fica localizada a cidade de Umbra. \z
                    No leste da ilha voce encontrara um velho chamado Frigard. Ele precisara de ajuda com duas missoes. Finalize as duas missoes de Frigard e retorne ate mim. MAS CUIDADO!! Na segunda missao voce ira para um local muito perigoso. \z
                    Todos que sao derrotados naquele lugar perdem seus pertences. Tome muito cuidado. Leve um time, se achar necessario! Retorne quanto terminar sua missao e te darei uma grande recompensa!", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 160)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 160 or storage == 161 then
                    npcHandler:say("Voce deve ajudar Frigard em suas duas missoes e depois retornar ate mim.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 162 then
                    npcHandler:say("Muito bom, " ..dear.. " |PLAYERNAME|. Espero que voce nao tenha passado por grandes problemas durante as missoes. De qualquer forma, devo dizer que voce esta me impressionando. Aqui, sua recompensa e o novo outfit Cave Explorer, dado apenas aos verdadeiros Exploradores das Profundezas.", npc, creature)
                    player:addExperience(2500000 * (player:getLevel() / 100), true)
                    player:addMoney(400000, true)
                    player:addItem(22724, 30, true)
                    player:addOutfit(575, 0)
                    player:addOutfit(574, 0)
                    local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                    player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
                    player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                    player:addAchievement("Explorador das Profundezas")
                    player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 163)
                    local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                    player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 5)
                    player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 163 then
                    npcHandler:say("" ..dear.. " |PLAYERNAME|, sua coragem realmente inspira todos em Crandoria. Creio que esta na hora de avaliar se voce realmente entendeu como algumas coisas funcionam por aqui... \z
                    Voce passara por um teste que sera dividido em tres missoes. A primeira missao se chama 'Paz na Guerra'. Essa missao sera muito simples: Derrote um jogador que esteja com White Skull ativada. Mas atencao! \z
                    O jogador nao pode ter mais que 100 niveis abaixo do seu! Boa sorte limpando Crandoria dos malfeitores.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 164)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 164 then
                    npcHandler:say("Paz na Guerra: derrote um jogador com skull - White, Red ou Black - que tenha no maximo 100 niveis a menos que voce. A morte precisa ser justa e nao vale personagem do mesmo IP que o seu.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 165 then
                    npcHandler:say("Muito bem, " ..dear.. " |PLAYERNAME|. Um malfeitor a menos nas ruas de Crandoria! Aqui esta sua recompensa. \z
                    A segunda missao se chama 'Justica em Crandoria': derrote tres jogadores DIFERENTES com skull, seguindo a mesma regra - no maximo 100 niveis a menos que voce. Retorne quando terminar.", npc, creature)
                    player:addExperience(2500000 * (player:getLevel() / 100), true)
                    player:addMoney(300000, true)
                    player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.PvpAlvos, 0)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.PvpAlvo1, -1)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.PvpAlvo2, -1)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 166)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 166 then
                    local feitos = math.max(0, player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.PvpAlvos))
                    npcHandler:say("Justica em Crandoria: derrote tres jogadores diferentes com skull, com no maximo 100 niveis a menos que voce. Voce ja derrotou " ..feitos.. " de 3.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 167 then
                    local maosLimpas = player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.PvpMaosLimpas)
                    if maosLimpas < 1 then
                        npcHandler:say("Tres malfeitores derrotados! Crandoria agradece, " ..dear.. " |PLAYERNAME|. Aqui esta sua recompensa. \z
                        Mas um verdadeiro defensor sabe quando NAO lutar. A ultima missao do teste se chama 'Maos Limpas': fique 24 horas sem matar nenhum jogador de forma injustificada e volte sem skull. \z
                        Se matar alguem injustamente, o prazo recomeca.", npc, creature)
                        player:addExperience(2500000 * (player:getLevel() / 100), true)
                        player:addMoney(300000, true)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.PvpMaosLimpas, os.time())
                    elseif player:getSkull() ~= SKULL_NONE then
                        npcHandler:say("Voce esta marcado com uma skull, " ..dear.. " |PLAYERNAME|. Volte quando ela tiver sumido.", npc, creature)
                    elseif os.time() - maosLimpas < 24 * 60 * 60 then
                        local horas = math.ceil((maosLimpas + 24 * 60 * 60 - os.time()) / 3600)
                        npcHandler:say("Maos Limpas: continue sem matar ninguem de forma injustificada. Faltam cerca de " ..horas.. " hora(s).", npc, creature)
                    else
                        npcHandler:say("Maos limpas e cabeca fria. Voce passou no meu teste, " ..dear.. " |PLAYERNAME|! Fale comigo novamente sobre a proxima {missao}.", npc, creature)
                        player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                        player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 168)
                    end
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 168 then
                    npcHandler:say("Bom, " ..dear.. " |PLAYERNAME|, Voce agora tornou Crandoria um local mais seguro. Mas tambem sera importante entender como se sentem os criminosos do nosso mundo... \z
                    Por isso sua proxima missao sera ir para a prisao! Ha ha ha. Voce nao ouviu errado... \z
                    Seja pego pelo Anti Afk respondendo errado a uma checagem ou deixando o tempo acabar antes de responder. Depois disso retorne ate mim e me conte sobre sua experiencia.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 169)
                    player:addExperience(player:getLevel() * 25000)
                    player:addItem(22706, 1)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 169 then
                    npcHandler:say("Seja preso pelo sistema Anti Afk e depois retorne ate mim e me conte sobre sua experiencia.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 170 then
                    npcHandler:say("Como foi a experiencia, " ..dear.. " |PLAYERNAME|? Nao ficou com medo da prisao, ficou? Ha ha ha ha! Claramente eu nao deixaria que voce passasse nenhum minuto preso naquele lugar. Tudo foi planejado. \z
                    Bom, agora voce sabe o que voce passa ao ser pego pelo antiafk... A cada vez que voce for preso, sua pena aumentara em 15 minutos, podendo chegar a 24 horas! Entao tome cuidado... \z
                    Aqui, uma recompensa pelo susto que te fiz passar... Ha ha ha!", npc, creature)
                    player:addExperience(3500000 * (player:getLevel() / 100), true)
                    player:addMoney(200000, true)
                    player:addItem(39136, 3, true)
                    player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 171)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 171 then 
                    npcHandler:say("Voce chegou longe, " ..dear.. " |PLAYERNAME|. Devo dizer que depois de tudo o que passamos estou muito orgulhoso do seu progresso, Te passarei agora a ultima missao que voce fara ao meu lado... Pelo menos por enquanto.  \z
                    Voce agora esta entendendo bem as regras e ja mostrou que tem conhecimento do que evitar para ficar longe da prisao... Muito bem, agora te darei seu ultimo teste, voce esta preparado? ({sim} / {nao})", npc, creature)
                    npcHandler:setTopic(playerId, 26)
                elseif storage == 172 or storage == 173 then
                    npcHandler:say("Volte quando tiver conseguido a permissao de King Tibianus para obter o Perdao Secreto.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 174 then
                    npcHandler:say("Eu sabia, " ..dear.. " |PLAYERNAME|! Voce realmente mostrou ser digno de ser chamado de Defensor de Crandoria! Estou muito contence em dizer que seu treinamento comigo chegou ao fim. \z
                    Mas nao pense que isso significa que suas aventuras pelo reino de Crandoria acabaram. Voce apenas mudara um pouco o rumo das coisas... Va ate Magincia e converse com Kalahar, um dos representantes supremos da Sociedade dos Magos. \z
                    Ele guiara seu caminho para desafios ainda maiores que os meus. Prepare-se... Sera uma jornada e tanto! Boa sorte. E aqui, sua ultima recompensa!", npc, creature)
                    player:addExperience(5000000 * (player:getLevel() / 100), true)
                    player:addItem(14112)
                    player:addItem(22706, 3, true)
                    player:addItem(26186, 2, true)
                    player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 175)
                    local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                    player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 5)
                    player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 175 then
                    npcHandler:say("Nao tenho mais nenhuma missao para voce, " ..dear.. " |PLAYERNAME|.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                else
                    if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso) == 16 then
                        npcHandler:say("Entao voces descobriram a localizacao de Hidrox e Rocket Tank? Otimo. Diga a Lady Vandart que mandarei as tropas hoje mesmo para captura-los.", npc, creature)
                        player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso, 17)
                        npcHandler:setTopic(playerId, 0)
                    end
                end
            elseif itemsTimer > os.time() then
                npcHandler:say("" ..dear.. " |PLAYERNAME|, voce precisa esperar " ..timeLeftItems.." minutos para trazer um novo item. Ainda estou limpando minhas ferramentas de analise.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        else
            npcHandler:say("Voce precisara aguardar " ..timeLeft.. " minutos para iniciar uma nova missao.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "boss eye") then
        npcHandler:say("Gostaria de vender seu Boss Eye por 15 Tokens de Evento?", npc, creature)
        npcHandler:setTopic(playerId, 36)
    elseif MsgContains(message, "special timer") then
        npcHandler:say("Gostaria de vender seu Special Timer por 20 Tokens de Evento?", npc, creature)
        npcHandler:setTopic(playerId, 37)
    elseif MsgContains(message, "passe dos novatos") then
        npcHandler:say("Gostaria de vender seu Passe dos Novatos por 50.000 gold coins?", npc, creature)
        npcHandler:setTopic(playerId, 35)
    elseif MsgContains(message, "cookie") then
        if player:getStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao) == 1 then
            if player:getItemCount(3598) >= 5 then
                player:removeItem(3598, 5)
                npcHandler:say("Um presente de Natal? Ha! Eu estava mesmo com fome. Muito obrigado!", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao, 2)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Eu estava esperando por 5 cookies... sao crocantes e uma rapida refeicao!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "primeiro dragao") then
		if player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso) == 3 then
			npcHandler:say("Voces vivem se metendo em problema... Agora esta em busca do Dragao imortal da lenda, certo? Ha ha ha! \z
            Sim, ja ouvi falar dele. Mas nao faco ideia de como encontra-lo. E, ca entre nos, nao estou ansioso para saber.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
    elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
        if npcHandler:getTopic(playerId) == 1 then
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 1)
            npcHandler:say("Entao se apresse! Basta descer qualquer um dos bueiros da cidade e voce encontrara as Rotworms. Elas sao fracas, mas se voce nao estiver muito forte evite lutar contra \z
            varias de uma so vez. Boa sorte!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 2 then
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 3)
            npcHandler:say("Otimo! Lembre-se que voce podera obter apenas uma das recompensas ao chegar la. Se quiser uma dica, voce pode utilizar o comando !task para selecionar as tasks de Amazonas e de Valkyries e completa-las \z
            enquanto termina sua missao. Pense sempre em boas formas de aproveitar bem seu tempo! Enfim... Estarei esperanco pelo seu retorno! Boa sorte.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 3 then
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 5)
            npcHandler:say("Eu sabia que alguns cyclops nao te desanimariam! Tudo certo entao. Lembre-se que nao seja possivel obter Cyclops Toes de todos os cyclops que voce derrotar, entao tera que derrotar um numero consideravel deles! \z
            Preparado? Entao va! Estarei esperando pelo seu retorno vitorioso.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 4 then
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 7)
            npcHandler:say("Perfeito! HA! Agora esses malditos dragoes terao o que merecem! Estarei te esperando com os 3 green dragon leathers e os 3 green dragon scales.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 6 then
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 9)
            npcHandler:say("Nao te falta coragem. Gosto disso! Entao va ate a Miniboss Room e enfrente um dos chefes. Para isso basta ir ate o local e puxar a alavanca. Estarei te esperando logo apos a batalha.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 7 then
            npcHandler:say("Otimo. Proximo aos dragons de Crandoria voce encontrara uma caverna onde ha variso Heroes e Necromancers. Mas se preferir pode buscar por outros locais, o Novo Continente esta cheio deles. Estarei te esperando com os itens!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 11)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 8 then
            npcHandler:say("Nenhuma missao parece um desafio grande demais para voce, nao e mesmo? Entao va! Busque por frost giants, frost dragons, barbaros e crystal spiders e me traga os 5 shards.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 13)
        elseif npcHandler:getTopic(playerId) == 9 then
            npcHandler:say("Excelente! Estarei esperando pelo escudo aqui mesmo. Voce podera obte-lo facilmente com Dragon Lords ou Frost Dragons.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 15)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 10 then
            npcHandler:say("Coragem nem sempre representa forca... tenha cuidado! Estarei esperando pelo seu retorno.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 21)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 11 then
            npcHandler:say("Ok! Estarei esperando pelo seu retorno, |PLAYERNAME|.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 25)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 12 then
            npcHandler:say("Muito bem. Entao va e retorne apos ter obtido as 5 Silver Tokens.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 29)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 13 then
            npcHandler:say("Ha ha... preparado, voce diz? Quero so ver! Va ate la e so retorne apos completar sua missao.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 31)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 14 then
            npcHandler:say("Muito bem, estarei aguardando pelo seu retorno. Tome cuidado pelo caminho, essas criaturas podem ser mais fortes do que aparentam quando estao em bando... Boa sorte!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 35)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 15 then
            npcHandler:say("Excelente! Nao se esqueca, voce deve derrota-lo, entrar no portal e caminhar ate a ponta do precipicio para ter certeza de que ele esta morto. Estarei te esperando.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 37)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 16 then
            npcHandler:say("Muito bem. Oldrak te guiara melhor, ele fica ao norte de Magincia. Alem disso voce precisara de um Holy Icon para essa missao. Voce podera obte-lo matando 500 demonios pelo sistema de {!task}. Apos terminar a quest e derrotar o Demon Oak retorne ate mim e te recompensarei.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 43)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 17 then
            npcHandler:say("Ok! Lembre-se: 10 tecidos de cada. Marrons, brancos, azuis, verdes, vermelhos e amarelos. Ficarei esperando.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 45)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 18 then
            npcHandler:say("Certo. Estarei esperando por voce com as 3 Hexagonal Rubys. Boa sorte.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 47)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 19 then
            npcHandler:say("Confianca sempre sera o primeiro passo para uma missao bem sucedida. Acredito em voce. Boa sorte!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 49)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 20 then
            npcHandler:say("Excelente! Lembre-se: Voce precisa derrotar pelo menos uma vez Duke Krule, Sir Baeloc, Count Vlarkorth, Earl Osam, Lord Azaram e King Zelos. King Zelos com certeza sera o mais dificil, tome cuidado!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 51)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 21 then
            npcHandler:say("Otimo! Estarei te esperando. Retorne quando completar a Inquisition Quest.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 55)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 22 then  
            npcHandler:say("Ok. Voce podera encontrar os Empty Honey Glasses com Burning Gladiators e Priestess of the Wild Sun proximo a Nivabi. Traga os itens o quanto antes! Estarei esperando por eles.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 57)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 23 then
            npcHandler:say("Certo! Estarei esperando pelo seu retorno com os espolios solicitados!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 59)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 23 then
            npcHandler:say("Muito bem. Lembre-se: Voce pode obter um Watering Can comprando por gold com a NPC Romira, em Astralis, ou pela Store.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Timer, os.time() + 1 * 60 * 60)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 63)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 24 then
            npcHandler:say("Excelente! Va ate Elvenshire e desca por um buraco na parte sudoeste da cidade para chegar a ilha dos insetos gigantes. Retorne apos ajudar Lord Thompson em sua primeira missao. Boa sorte!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 39)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 25 then
            npcHandler:say("Muito bem!! Cuidado, esse item pode ser muito delicado e acabar estragando. Traga apenas um de cada vez! Ficarei esperando.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 115)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, 0)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 26 then
            npcHandler:say("Preste muita atencao! Te contarei agora um segredo que apenas alguns guerreiros de Crandoria conhecem e podem utilizar: O Perdao Secreto do Rei Tibianus. \z
            O Rei Tibianus acredita que nem todo criminoso merece penas tao severas na prisao e, por isso, ele concedera seu Perdao Secreto, reduzindo a zero seu tempo acumulado de prisao. \z
            Va ate o Rei Tibianus e fale a ele sobre o perdao secreto. Se ele perguntar, diga que voce foi enviado por mim. Consiga a aprovacao do Rei para que ele permita seu perdao para a prisao e depois retorne ate mim!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 172)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 30 then
            npcHandler:say("Entao preste atencao: Para ir de Crandoria para Viridia voce precisa estar sem nenhum item equipado, nem mesmo sua mochila. Alem disso, voce retornara ao nivel 8 e perdera 40 pontos de cada skill de valor igual ou superior a 50. \z
            Voce nao podera ter pontos distribuidos na arvore de habilidades, portanto seus pontos serao retirados. Voce tambem nao podera ter nenhum dinheiro no banco ou summons ativos. Nao se preocupe, seus acessos, seus outfits e suas montarias permanecerao registrados. \z
            A partir de sua mudanca sua taxa base de experiencia sera de 1x por toda a sua jornada e, ao sair de la, dependendo do seu progresso e suas conquistas voce podera receber bonus permanentes em skills, exp e loot, alem de alguns itens. Voce esta pronto para ir?", npc, creature)
            npcHandler:setTopic(playerId, 31)
        elseif npcHandler:getTopic(playerId) == 35 then
            if player:getItemCount(9223) >= 1 then
                player:removeItem(9223, 1)
                player:addItem(3043, 5)
                npcHandler:say("Muito bem. Aqui esta!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 36 then
            if player:getItemCount(19369) >= 1 then
                player:removeItem(19369, 1)
                player:addItem(6526, 15)
                npcHandler:say("Muito bem. Aqui esta!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 37 then
            if player:getItemCount(22027) >= 1 then
                player:removeItem(22027, 1)
                player:addItem(6526, 20)
                npcHandler:say("Muito bem. Aqui esta!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "axe") or MsgContains(message, "machado") then
        if npcHandler:getTopic(playerId) == 5 then
            if player:removeItem(5877, 3) and player:removeItem(5920, 3) then
                npcHandler:say("Aqui esta sua recompensa e seu novo machado. Tenha cuidado com essa arma! Armas de duas maos deixam voce mais vulneravel a ataques fisicos.", npc, creature)
                player:addItem(7413, 1, true)
                player:addExperience(1000000, true)
                player:addMoney(40000)
                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 8)
            else
                npcHandler:say("Por favor, me traga os 3 green dragon leathers e as 3 green dragon scales. Estarei aguardando pelo seu retorno.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "sword") or MsgContains(message, "espada") then
        if npcHandler:getTopic(playerId) == 5 then
            if player:removeItem(5877, 3) and player:removeItem(5920, 3) then
                npcHandler:say("Aqui esta sua recompensa e suanova espada. Tenha cuidado com essa arma! Armas de duas maos deixam voce mais vulneravel a ataques fisicos.", npc, creature)
                player:addItem(7386, 1, true)
                player:addExperience(1000000, true)
                player:addMoney(40000)
                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 8)
            else
                npcHandler:say("Por favor, me traga os 3 green dragon leathers e as 3 green dragon scales. Estarei aguardando pelo seu retorno.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "clava") or MsgContains(message, "club") or MsgContains(message, "mace") then
        if npcHandler:getTopic(playerId) == 5 then
            if player:removeItem(5877, 3) and player:removeItem(5920, 3) then
                npcHandler:say("Aqui esta sua recompensa e sua nova clava. Tenha cuidado com essa arma! Armas de duas maos deixam voce mais vulneravel a ataques fisicos.", npc, creature)
                player:addItem(7426, 1, true)
                player:addExperience(1000000, true)
                player:addItem(3043, 2, true)
                player:addItem(3035, 50, true)
                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 8)
            else
                npcHandler:say("Por favor, me traga os 3 green dragon leathers e as 3 green dragon scales. Estarei aguardando pelo seu retorno.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. Fale comigo se estiver interessado em finalizar uma {missao}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)