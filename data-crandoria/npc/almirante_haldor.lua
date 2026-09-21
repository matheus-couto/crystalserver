local internalNpcName = "Almirante Haldor"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 1436,
	lookHead = 0,
	lookBody = 68,
	lookLegs = 59,
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

    local monsterMappingA = {
        [1] = "Dwarf",
        [2] = "Rotworm",
        [3] = "Minotaur",
        [4] = "Orc",
    }
    
    local monsterMappingB = {
        [1] = "Cyclops",
        [2] = "Elf Scout",
        [3] = "Tarantula",
        [4] = "Stone Golem",
    }

    local monsterMappingC = {
        [1] = "Dragon",
    }
    
    
    
    local monsterA = { 
        { name = "Dwarf", id = 1 },
        { name = "Rotworm", id = 2 },
        { name = "Minotaur", id = 3 },
        { name = "Orc", id = 4 },
    }
    
    local monsterB = {
        { name = "Cyclops", id = 1 },
        { name = "Elf Scout", id = 2 },
        { name = "Tarantula", id = 3 },
    }

    local monsterC = {
        { name = "Dragon", id = 1 },
    }
    
    
    local function getMonsterNameByIdA(monsterA, id)
        for _, monster in ipairs(monsterA) do
            if monster.id == id then
                return monster.name
            end
        end
        return "Unknown"
    end
    
    local function getMonsterNameByIdB(monsterB, id)
        for _, monster in ipairs(monsterB) do
            if monster.id == id then
                return monster.name
            end
        end
        return "Unknown"
    end

    local function getMonsterNameByIdC(monsterC, id)
        for _, monster in ipairs(monsterC) do
            if monster.id == id then
                return monster.name
            end
        end
        return "Unknown"
    end
    
    local selectedMonsterA = monsterA[math.random(1, #monsterA)]
    
    local monsterNameA = selectedMonsterA.name
    local mTypeA = MonsterType(monsterNameA)
    local raceIdA = mTypeA:raceId()
    local monsteridA = selectedMonsterA.id
    local bestiaryA = (player:getStorageValue(61305000 + raceIdA)) + 2
    local monsterNameAA = getMonsterNameByIdA(monsterA, player:getStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraHunt))
    
    
    local selectedMonsterB = monsterB[math.random(1, #monsterB)]
    
    local monsterNameB = selectedMonsterB.name
    local mTypeB = MonsterType(monsterNameB)
    local raceIdB = mTypeB:raceId()
    local monsteridB = selectedMonsterB.id
    local bestiaryB = (player:getStorageValue(61305000 + raceIdB)) + 2
    local monsterNameBB = getMonsterNameByIdB(monsterB, player:getStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraHunt))

    local selectedMonsterC = monsterC[math.random(1, #monsterC)]
    
    local monsterNameC = selectedMonsterC.name
    local mTypeC = MonsterType(monsterNameC)
    local raceIdC = mTypeC:raceId()
    local monsteridC = selectedMonsterC.id
    local bestiaryC = (player:getStorageValue(61305000 + raceIdC)) + 2
    local monsterNameCC = getMonsterNameByIdC(monsterC, player:getStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraHunt))
    
    local storage = player:getStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso)

    if MsgContains(message, "mission") or MsgContains(message, "missao") then
        if storage < 1 then
            npcHandler:say("Ha! Mais um... Entao voce acha que vai aguentar passar por toda a dor e sofrimento que te aguarda em Viridia? Ja vou avisando que nao adianta chorar para os amigos quando for tarde demais... HA HA HA HA HA! \z
            Se voce vai iniciar sua jornada em Viridia deve entender tres coisas muito importantes: Seu caminho nao sera facil, nao sera uma jornada rapida e voce so podera sair daqui quando completar todos os meus testes! \z
            Tenha isso em mente antes de continuar seu desafio para se tornar um Guerreiro de Ferro de Crandoria. Voce tem certeza de que voce esta pronto para iniciar essa jornada?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        elseif storage == 1 then
            player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraItem, bestiaryA)
            player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraHunt, monsteridA)
            player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraRaceId, raceIdA)
            player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraCount, 1)
            player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 2)
            npcHandler:say("Para iniciar suas missoes, faremos um teste de poder de batalha. Quero que voce derrote alguns monstros. Para comecar, derrote 25 " ..monsterNameA.. " e retorne ate mim. \z
            Voce encontrara essa criatura proxima a cidade, entao nao se preocupe. Caso sinta que ainda nao esta pronto, treine um pouco mais suas skills ou evolua um pouco mais nos trolls. \z
            Se o nome do monstro falhar, fale novamente {missao}. Estarei aguardando pelo seu retorno.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 2 then
            if player:getStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraCount) < 25 then
                npcHandler:say("Como eu havia dito, eu preciso que voce derrote 25 " ..monsterNameAA.." . Retorne quando tiver conseguido.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Excelente! Aqui esta uma pequena quantia de experiencia. Me diga quando estiver preparado para a proxima {missao}.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 3)
                player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraItem, 0)
                player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraHunt, 0)
                player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraRaceId, 0)
                player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraCount, 0)
                player:addExperience(10000)
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 3 then
            if player:getLevel() < 15 then
                npcHandler:say("Sem pressa, jovem gafanhoto... Para sua proxima missao acho melhor voce se preparar um pouco mais. Pegue nivel 15 e retorne ate mim e te entregarei o proximo desafio.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Sua missao agora sera um pouco mais desafiadora. Na saida oeste de Viridia voce encontrara um vilarejo de Amazonas e Valkyries. Preciso que voce entre no local e recupere uma sacola roubada. \z
                Dentro da sacola ha varios itens de valor sentimental de um de nossos guerreiros que foi ha algum tempo derrotado pelas terriveis amazonas. Agora buscamos recuperar os itens para devolver a sua familia. \z
                A sacola provavelmente estara escondida em algum container no local. Procure com cuidado e, quando encontrar, traga de volta para mim. Estarei esperando por voce.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 4)
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 4 then
            if player:getItemCount(12237) >= 1 then
                npcHandler:say("Muito obrigado! Com certeza os pertences daquele guerreiro terao um grande valor para sua familia. Como recompensa, a partir de agora voce tera permissao de acessar o ultimo andar da Academia de Crandoria. \z
                No ultimo andar voce encontrara o King Tibianus e, com ele, voce podera comprar sua Promotion, que custara 20.000 moedas de ouro. Me avise quando estiver preparado para sua proxima {missao}.", npc, creature)
                player:addExperience(20000)
                player:removeItem(12237, 1)
                player:addItem(3035, 20)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 5)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Encontre a sacola roubada no vilarejo das amazonas e traga-a para mim.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 5 then
            player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraItem, bestiaryB)
            player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraHunt, monsteridB)
            player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraRaceId, raceIdB)
            player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraCount, 1)
            player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 6)
            npcHandler:say("Voce esta no caminho certo, |PLAYERNAME|, mas ha ainda muitas missoes a serem concluidas antes que voce possa partir para Crandoria. Na sua proxima missao testaremos seus poderes com monstros um pouco mais fortes. \z
            Pegue uma das saidas a oeste da cidade e derrote 50 " ..monsterNameBB.. ". Cuidado! Essa missao pode ser pouco mais perigosa que a ultima. Caso tenha um companheiro de batalha, aconselho leva-lo com voce. \z
            Se o nome do monstro falhar, fale novamente {missao}. Ao terminar o desafio retorne ate mim e te darei uma boa recompensa pelo seu esforco. Boa sorte.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 6 then
            if player:getStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraCount) < 50 then
                npcHandler:say("Como eu havia dito, eu preciso que voce derrote 50 " ..monsterNameBB.." . Retorne quando tiver conseguido.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Muito bem! Foi mais rapido do que eu imaginava. Vejo isso como um bom sinal. Aqui, uma boa recompensa em ouro pelo seu trabalho bem executado. Me avise quando estiver em busca de outra {missao}.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 7)
                player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraItem, 0)
                player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraHunt, 0)
                player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraRaceId, 0)
                player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraCount, 0)
                player:addExperience(35000)
                player:addItem(3035, 30)
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 7 then
            npcHandler:say("Bom, |PLAYERNAME|... batalhas sao importantes, mas os guerreiros tambem precisam desenvolver uma forma de obter ouro e comprar seus suprimentos e equipamentos. \z
            Orlando, localizado no segundo andar do depot, compra diversos itens de criaturas por um preco razoavel, mas para evitar contrabando de mercadorias, ele compra apenas de guerreiros que possuem minha permissao. \z
            Para essa missao, preciso que voce me traga 1 Bat Wing, 3 Frost Giant Pelts e 1 Iron Ore, pois Orlando precisa desses itens com urgencia. Caso voce complete a missao, te darei permissao para negociar com ele quando quiser. Va! Estarei esperando.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 8)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 8 then
            npcHandler:say("Voce conseguiu todos os itens?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif storage == 9 then
            npcHandler:say("Seguindo rumo ao norte de Viridia ha um pantano que ja foi a casa de um antigo aliado da cidade, o velho Barthos. Ele viveu por anos no local mas foi embora apos a chegada de algumas bruxas que agora vivem ali. \z
            Recentemente recebemos uma carta de Barthos pedindo que alguem fosse ate sua casa no meio do pantano e buscasse o restante de seus pertences e, adivinhe so? Esse alguem sera voce, |PLAYERNAME|! Ha ha ha... \z
            Va ate a casa de Barthos no pantano e vasculhe o local. Traga qualquer coisa de valor que voce encontrar ali. E tenha cuidado!! Ha muito tempo ninguem vai la, nao sabemos o que podera encontrar ao entrar. Estarei esperando pelo seu retorno.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 10)
        elseif storage == 10 then
            npcHandler:say("Retorne com os pertences de Barthos se quiser continuar sua jornada em Viridia.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 11 then
            npcHandler:say("Voce trouxe os pertences de Barthos?", npc, creature)
            npcHandler:setTopic(playerId, 3)
        elseif storage == 12 then
            if player:getLevel() >= 30 then
                npcHandler:say("Os necromancers que vivem ao noroeste de Viridia possuem um grande podem e planejam utilizar tal poder para atacar Viridia em breve. Preciso da sua ajuda para evitar que isso aconteca. \z
                Para isso, quero que voce invada suas torres a oeste do pantano e obtenha algum registro de seus planos, para que assim possamos nos preparar e evitar seu ataque. \z
                Vasculhe a torre e traga algum documento que registre seus planos. Uma carta, um pergaminho, qualquer coisa. Seja cuidadoso, mas nao tenha misericordia dos inimigos que encontrar no caminho!", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 13)
            else
                npcHandler:say("Voce ainda esta fraco para a proxima missao. Alcance o nivel 30 e retorne ate mim.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 13 then
            npcHandler:say("Encontre algum registro dos planos dos necromancers e traga ate mim.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 14 then
            if player:getItemCount(4846) >= 1 then
                player:removeItem(4846, 1)
                player:addExperience(55000)
                player:addItem(3035, 40)
                npcHandler:say("Hmm... Muito interessante. Voce parece nao ser tao inutil quanto eu imaginava... Talvez em breve consiga passar por desafios ainda mais dificeis! Aqui, uma singela recompensa.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 15)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Onde estao os registros dos necromancers?", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 15 then
            if player:getLevel() >= 40 then
                player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraItem, bestiaryC)
                player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraHunt, monsteridC)
                player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraRaceId, raceIdC)
                player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraCount, 1)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 16)
                npcHandler:say("Vamos direto ao ponto: Se voce quer mostrar sua bravura, precisa conseguir derrotar alguns dragoes. Muitos dragoes... Derrote 100 dragons e retorne ate mim, se voce conseguir...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce ainda esta fraco para a proxima missao. Alcance o nivel 40 e retorne para seu proximo desafio.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 16 then
            if player:getStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraCount) < 99 then
                npcHandler:say("Como eu havia dito, eu preciso que voce derrote 100 dragons. Retorne quando tiver conseguido.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Muito bem! Demorou um pouco, mas pelo menos obteve um bom resultado e, para a surpresa de muitos, retornou com vida! Hahaha. Aqui, uma recompensa pela sua bravura.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 17)
                player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraItem, 0)
                player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraHunt, 0)
                player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraRaceId, 0)
                player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraCount, 0)
                player:addExperience(100000)
                player:addItem(3035, 50)
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 17 then
            if player:getLevel() >= 50 then
                npcHandler:say("No extremo norte do pantano voce encontrara os restos do que ja foi uma torre um dia. No local ha uma escada que leva ao esconderijo dos Heroes e do temivel Black Knight! \z
                Sua forca nao sera um problema em si, mas o caminho ate ele pode ser muito dificil. Sua missao sera chegar ate a sala do Black Knight, derrota-lo e pegar seu tesouro dentro do bau. \z
                Caso ele possua servos na sala, voce tambem devera derrota-los. E nao demore!", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 18)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce ainda esta fraco para a proxima missao. Alcance o nivel 50 e retorne para seu proximo desafio.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 18 then
            npcHandler:say("Derrote o Black Knight e seus servos, pegue seu tesouro e retorne ate mim.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 19 then
            npcHandler:say("Muito bom... Eu soube do seu feito. Muito bom mesmo! Estou comecando a ter fe no seu progresso, |PLAYERNAME|... Fique com todo o espolio do Black Knight, voce vai precisar. \z
            Bom, acredito que voce esteja pronto para passar por alguns desafios por conta propria. Retorne para sua proxima missao apos o nivel 100.", npc, creature)
            player:addExperience(120000)
            player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 20)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 20 then
            if player:getLevel() >= 100 then
                npcHandler:say("Como voce ainda nao saiu de Viridia acredito que voce realmente acha que tem o que precisa para se tornar um dos mais fortes seguidores do Caminho de Ferro, nao e mesmo? \z
                Veremos se sua confianca permanecera a mesma apos essa missao... Argentus, um antigo general de Crandoria, se perdeu na selva a leste daqui enquanto corria atras de um individuo dos povos Iks.  \z
                Muitas vezes entramos naquela mata e buscamos por ele e pelo povoado, que parece se esconder em algum local ao norte da selva. Encontre a civilizacao dos Iks e descubra alguma informacao sobre Argentus. Estarei esperando!", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 21)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao esta pronto para o proximo desafio. Retorne quando alcancar o nivel 100.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 21 then
            npcHandler:say("Por favor, encontre alguma pista que nos leve ao paradeiro de Argentus.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 22 then
            npcHandler:say("Foi o que pensei... os Iks nao costumam perdoar quem tenta acessar suas terras. Mas vejo que voce conseguiu entrar e sair do local. Isso quase me impressiona... \z
            Aqui. uma pequena recompensa pelo seu esforco nessa incursao. Me procure novamente quando estiver procurando por mais um desafio.", npc, creature)
            player:addExperience(200000)
            player:addItem(3043, 3)
            player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 23)
        elseif storage == 23 then
            if player:getLevel() >= 150 then
                npcHandler:say("Entao voce ainda nao desistiu? Ha ha ha! Estou impressionado com sua persistencia, |PLAYERNAME|. A maioria nao chega ate aqui. Dizem ser 'muito dificil'. Um bando de fracos! \z
                Bom... 'cof cof'... Seguindo com suas missoes... Agora voce tera um desafio duplo: Derrotar os mestres Drakens no fundo da Selva de Viridia e obter seus tesouros. Para acessar o local voce tera que entrar na fortaleza da selva. \z
                Quando encontrar o esconderijo dos lizards e drakens, busque pelas portas que levam aos mestres: Draken Elite e Draken Abomination, nessa ordem. Derrote-os, obtenha os tesouros de cada um e retorne ate mim, se voce conseguir...", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 24)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Sua proxima missao exigira muito de voce. Retorne quanto estiver no nivel 150 ou maior.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 24 or storage == 25 then
            npcHandler:say("Derrote o Draken Elite, roube seu tesouro e depois repita o processo com o Draken Abomination.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 26 then
            if player:getLevel() < 180 then
                npcHandler:say("Voce retornou com vida? HA! Confesso que achei que voce desistiria nessa missao. Mas parece que voce esta entendendo que quando as coisas nao sao tao faceis a recompensa tem um gosto melhor, nao e mesmo? \z
                Nao se preocupe, fique com os espolios dos Drakens como recompensa. Voce mereceu. Retorne no nivel 180 e te darei sua ultima missao e, dessa forma, voce tera minha permissao para sair de Viridia.", npc, creature)
                player:addExperience(1000000)
                player:addItem(26186, 2)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 27)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce retornou com vida? HA! Confesso que achei que voce desistiria nessa missao. Mas parece que voce esta entendendo que quando as coisas nao sao tao faceis a recompensa tem um gosto melhor, nao e mesmo? \z
                Nao se preocupe, fique com os espolios dos Drakens como recompensa. Voce mereceu. Me diga quando estiver pronto e te darei sua ultima {missao} e, apos completa-la, voce tera minha permissao para sair de Viridia.", npc, creature)
                player:addExperience(1000000)
                player:addItem(26186, 1)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 27)
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 27 then
            if player:getLevel() >= 180 then
                npcHandler:say("Sua proxima missao nao sera tao dificil, mas voce talvez tenha dificuldade para encontrar o que voce busca... A oeste de Viridia ha um castelo abandonado em uma pequena ilha. Nesse castelo vivem varios vampiros e outros monstros. \z
                Ha uma lenda de que nesse castelo ha uma fonte de sangue em algum lugar. De acordo com a historia, esse sangue tem propriedades magicas especiais, que podem ser usadas em pocoes magicas. Sua missao sera encontrar essa fonte e coletar um pouco do sangue. \z
                Ao encontrar a fonte basta usar o frasco comum vazio para enche-lo com o sangue e, em seguida, traze-lo a mim. Aqui, jogue o conteudo deste frasco fora e use ele mesmo. Boa sorte!", npc, creature)
                player:addItem(2874, 1)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 28)
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 28 then
            npcHandler:say("Encontre a fonte de sangue no castelo dos vampiros e traga um frasco com Sangue de Lorde Vampiro para mim. Se tiver perdido seu frasco, basta usar uma pocao e utilizar o frasco que receber. Lembre-se do comando !flask on/off.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 29 then
            npcHandler:say("Voce conseguiu? Sensacional! Olhe como esse sangue tem uma cor forte e vibrante! Enviarei aos estudiosos de Magincia para que possam estudar a fundo. Aqui, uma recompensa pelo seu esforco.", npc, creature)
            player:addExperience()
            player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 30)
            player:addExperience(1500000)
            player:addItem(26186, 2)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 30 then
            npcHandler:say("Voce realmente progrediu muito e estou convencido de que voce podera se tornar um Mestre do Caminho de Ferro. Mas para provar isso para todos em Viridia voce tera que completar um grande desafio! \z
            Nas profundezas das ruinas onde residem os Heroes ha uma porta que leva a uma antiga masmorra. Essa masmorra a entrada da antiga Catedral das Trevas. O problema maior sera que nao se sabe mais qual o sacrificio deve ser entregue para entrar. \z
            Voce deve descobrir como entrar no local e derrotar dois Vexclaws que residem no local, obtendo em seguida seus tesouros. Cuidado! Uma vez na sala dos Vexclaws voce so podera sair apos derrota-los! Retorne quanto finalizar sua missao.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 31)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 31 then
            npcHandler:say("Derrote os Vexclaws nas masmorras abaixo dos Heroes e retorne ate mim. Estarei esperando!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 32 then
            npcHandler:say("Otimo! Voce conseguiu derrotas aquelas malditas criaturas demoniacas. Aqui, sua recompensa pela missao. Nao gaste tudo em um so lugar! Ha Ha Ha!", npc, creature)
            player:addExperience(2500000)
            player:addItem(3043, 20)
            player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 33)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 33 then
            npcHandler:say("Muito bem, |PLAYERNAME|. Voce esta a um passo de se tornar um Mestre do Caminho de Ferro. Para finalizar sua jornada, exigirei alguns itens de altissima raridade em Viridia. Voce devera obter cada um deles e traze-los juntos ate mim. \z
            Entao chega de enrolar, os itens que preciso sao: 1 Rift Shield, 1 Golden Legs, 1 Magic Plate Armor e 1 Ornate Crossbow. Traga todos os itens e te concederei uma grande recompensa e, claro, sua {conquista} de missoes. Va! Estarei aguardando.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 34)
            npcHandler:setTopic(playerId, 0)
            -- npcHandler:say("Muito bem, |PLAYERNAME|. Voce esta a um passo de se tornar um Mestre do Caminho de Ferro. Voce tem apenas mais uma missao e talvez nao seja a mais dificil... \z
            -- Para completar seus desafios, voce tera que provar que nao tem pena daqueles que entrarem em seu caminho ou medo daqueles que aparentam ser mais fortes que voce. Sendo assim, sua proxima missao sera simples e objetiva: \z
            -- Voce tera que derrotar tres jogadores que possuam no maximo 50 niveis abaixo do seu ou que possuam nivel superior ao seu. Apenas assim voce conseguira terminar sua {conquista} de missoes. Va! Estarei esperando pelo seu retorno.", npc, creature)
            -- player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 34)
            npcHandler:setTopic(playerId, 0)
        -- elseif storage >= 34 and storage <= 36 then
        --     npcHandler:say("Como eu disse, voce precisa derrotar tres jogadores que tenham nivel maior que o seu. Apenas quando voce cumprir a missao voce podera finalizar o Caminho de Ferro.", npc, creature)
        --     npcHandler:setTopic(playerId, 0)
        elseif storage == 34 then
            npcHandler:say("Preciso que me traga 1 Rift Shield, 1 Golden Legs, 1 Magic Plate Armor e 1 Ornate Crossbow. Voce possui todos os itens?", npc, creature)
            npcHandler:setTopic(playerId, 8)
        -- elseif storage == 37 then
        --     npcHandler:say("Voce derrotou mesmo tres outros guerreiros de Viridia? Estou impressionado! Realmente impressionado... Parabens! Voce concluiu as minhas missoes e recebera a recompensa por mais essa {conquista} ao sair de Viridia. Alem disso, te entregarei um pouco de experiencia e uma humilde recompensa pela missao.", npc, creature)
        --     player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 38)
        --     player:addItem(14112, 1)
        --     player:addItem(9099, 1)
        --     player:addExperience(10000000)
            -- if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Conquistas.Exp) < 1 then
            --     player:setStorageValue(Storage.Quest.Crandoria.Viridia.Conquistas.Exp, 1)
            -- else
            --     player:setStorageValue(Storage.Quest.Crandoria.Viridia.Conquistas.Exp, player:getStorageValue(Storage.Quest.Crandoria.Viridia.Conquistas.Exp) + 1)
            -- end
            -- npcHandler:setTopic(playerId, 0)
        elseif storage == 35 then
            npcHandler:say("Nao tenho mais nenhuma missao para voce. Agora voce podera obter a {conquista} pelas missoes finalizadas.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
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
    elseif MsgContains(message, "volk galugha") then
        if player:getStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Progresso) == 9 then
            npcHandler:say("Hum... nao ouvia isso ha muito tempo... Entao voce esta buscando pela Arena do Caos? Escute, jovem |PLAYERNAME|, poucos sao os que sabem chegar naquele local e muitos dos que encontraram jamais retornaram. \z
            Eu nao sei como chegar na Arena, mas sei algumas informacoes que podem te ajudar: A Arena hoje esta sendo comandada por Tyrtus, o Imortal. Ele so respondera a voce com o codigo secreto e cumpre a funcao de guardiao, permitindo ou proibindo a entrada de quem chega no local. \z
            Pelo que eu soube, a entrada do lugar fica muito bem escondida, mas me deram uma pista uma vez: A entrada para a Arena passa por um local com monstros vermelhos, verdes e tambem azuis. Nao posso te ajudar alem disso. Boa sorte em sua jornada!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "permissao") then
        if player:getLevel() >= 100 then
            npcHandler:say("Voce atingiu o nivel 100, portanto te concedo permissao para deixar Viridia. Porem, preste atencao! Ha diversas {conquistas} que podem ser alcancadas neste local e que te darao bonus permanentes. \z
            Tenha certeza de que alcancou tudo o que voce buscava, pois nunca mais podera retornar a Viridia novamente! Caso queira mesmo ir embora, fale com Mlepnus, o guardiao do Tapete Magico.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Permissao, 1)
            npcHandler:setTopic(playerId, 0)
        else
            npcHandler:say("Voce precisa chegar ao nivel 100 antes que receba permissao para deixar Viridia. Prove que voce realmente merece deixar o lugar!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "conquista") then
        npcHandler:say("Aqui estao os tipos de conquistas que voce pode completar em Virida: {nivel}, {montaria}, {missoes}, {combate} e {outfit}. Selecione qual voce gostaria de reportar.", npc, creature)
        npcHandler:setTopic(playerId, 5)
    elseif MsgContains(message, "nivel") then
        if npcHandler:getTopic(playerId) == 5 then
            if player:getLevel() >= 100 and player:getLevel() < 200 then
                npcHandler:say("Vejo que atingiu ao menos o nivel 100. Como recompensa te darei {permissao} para sair de Viridia quando quiser.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Permissao, 1)
                npcHandler:setTopic(playerId, 0)
            elseif player:getLevel() >= 200 and player:getLevel() < 300 then
                npcHandler:say("Vejo que atingiu ao menos o nivel 200. Como recompensa te darei {permissao} para sair de Viridia e, ao sair, voce recebera mais 0.1x de bonus na sua taxa de experiencia.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Permissao, 1)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Conquistas.Level, 1)
                npcHandler:setTopic(playerId, 0)
            elseif player:getLevel() >= 300 and player:getLevel() < 400 then
                npcHandler:say("Vejo que atingiu ao menos o nivel 300. Muito bom... Como recompensa te darei {permissao} para sair de Viridia e, ao sair, voce recebera mais 0.1x de bonus na sua taxa de experiencia e um Pacote de Progresso I para te auxiliar na sua nova jornada.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Permissao, 1)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Conquistas.Level, 2)
                npcHandler:setTopic(playerId, 0)
            elseif player:getLevel() >= 400 then
                npcHandler:say("Vejo que atingiu o nivel 400. Incrivel! Como recompensa te darei {permissao} para sair de Viridia e, ao sair, voce recebera mais 0.2x de bonus na sua taxa de experiencia e um Pacote de Progresso I.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Permissao, 1)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Conquistas.Level, 3)
                npcHandler:setTopic(playerId, 0)
            elseif player:getLevel() < 100 then
                npcHandler:say("A primeira conquista de nivel sera atingir o nivel 100. Volte quando conseguir alcancar o objetivo.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "boss eye") then
        npcHandler:say("Gostaria de vender seu Boss Eye por 15 Tokens de Evento?", npc, creature)
        npcHandler:setTopic(playerId, 36)
    elseif MsgContains(message, "special timer") then
        npcHandler:say("Gostaria de vender seu Special Timer por 20 Tokens de Evento?", npc, creature)
        npcHandler:setTopic(playerId, 37)
    elseif MsgContains(message, "montaria") then
        if npcHandler:getTopic(playerId) == 5 then
            if player:hasMount(201) then
                npcHandler:say("Muito bem! Vejo que conseguiu domar uma criatura especial em Viridia! Como recompensa, ao sair deste local, voce recebera um bonus de 5% na sua taxa de loot permanentemente.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Conquistas.Montaria, 2)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce ainda nao domou uma criatura especial em Viridia.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "missoes") then
        if npcHandler:getTopic(playerId) == 5 then
            if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso) == 35 then
                npcHandler:say("Muito bem! Como voce terminou todos os meus desafios recebera tambem uma recompensa pela conquista de missoes quando sair de Viridia. Parabens, |PLAYERNAME|.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Conquistas.Missoes, 1)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 36)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce ainda nao terminou todos os meus desafios.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "combate") then
        if npcHandler:getTopic(playerId) == 5 then
            npcHandler:say("Entre as conquistas de combate estao a derrota de {jaul} e a derrota de {mikarah}. Qual dessas conquistas voce completou?", npc, creature)
            npcHandler:setTopic(playerId, 6)
        end
    elseif MsgContains(message, "jaul") then
        if npcHandler:getTopic(playerId) == 6 then
            if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Conquistas.Jaul) == 1 then
                npcHandler:say("Voce derrotou mesmo o temivel Jaul? Impressonante! Muito bem, sua conquista foi registrada e por isso voce recebera um bonus permanente de 5% no progresso de skills ao sair de Viridia.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Conquistas.Jaul, 2)
                npcHandler:setTopic(playerId, 0)
            elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Conquistas.Jaul) == 2 then
                npcHandler:say("Voce ja registrou essa conquista.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce precisa derrotar o temivel boss Jaul para registrar essa conquista.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "mikarah") then
        if npcHandler:getTopic(playerId) == 6 then
            if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Conquistas.Mikarah) == 1 then
                npcHandler:say("Incrivel! Voce conseguiu derrotar o grande Mikarah! Muito bem, sua conquista esta registrada.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Conquistas.Mikarah, 2)
                npcHandler:setTopic(playerId, 0)
            elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Conquistas.Mikarah) == 2 then
                npcHandler:say("Voce ja registrou essa conquista.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce precisa derrotar o temivel boss Mikarah para registrar essa conquista.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "outfit") then
        if npcHandler:getTopic(playerId) == 5 then
            if player:getStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Reward) == 2 then
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Reward, 3)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Conquistas.Outfit, 1)
                npcHandler:say("Muito bem! Pela obtencao do Warmaster Outfits completo voce registrou sua conquista de Outfits e recebera, por isso, um bonus permanente de 0.1x de exp ao sair de Viridia.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Para esta conquista voce precisa obter o Warmaster Outfit alem dos dois addons.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Muito bem! Sendo assim, seja bem vindo ao caminho do Guerreiro de Ferro de Crandoria. Quando estiver preparado basta me dizer e te darei sua primeira {missao}.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 1)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getItemCount(5894) >= 1 and player:getItemCount(5880) >= 1 and player:getItemCount(9658) >= 3 then
                player:removeItem(5894, 1)
                player:removeItem(5880, 1)
                player:removeItem(9658, 3)
                npcHandler:say("Excelente! Orlando ficara muito satisfeito. Como combinado, direi a Orlando que voce tem minha permissao para vender seus produtos de criaturas a ele. Me avise quando quiser iniciar outra {missao}.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 9)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui todos os itens necessarios. Preciso de 1 Bat Wing, 1 Iron Ore e 3 Frost Giant Pelts. Retorne quanto possuir todos os itens.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 3 then
            if player:getItemCount(3456) >= 1 and player:getItemCount(3349) >= 1 and player:getItemCount(3028) >= 5 then
                player:removeItem(3456, 1)
                player:removeItem(3349, 1)
                player:addExperience(5000)
                npcHandler:say("Muito bom, |PLAYERNAME|! Esperto que voce nao tenha enfrentado muitos problemas para completar o desafio. Aqui, fique com os diamantes. Barthos disse que seu crossbow era o que ele mais queria.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 12)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Timer, 0)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce por acaso esta tentando me enganar? Barthos sabia o que tinha na casa. Nao me faca perder tempo!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 8 then
            if player:getItemCount(3366) >= 1 and player:getItemCount(3364) >= 1 and player:getItemCount(22726) >= 1 and player:getItemCount(14247) >= 1 then
                player:removeItem(3366, 1)
                player:removeItem(3364, 1)
                player:removeItem(22726, 1)
                player:removeItem(14247, 1)
                npcHandler:say("Incrivel! Estou muito satisfeito com suas habilidades em Viridia. Voce esta de parabens. A partir de agora voce pode registrar sua {conquista} das missoes. \z
                Aqui, sua ultima recompensa.", npc, creature)
                player:addItem(14112, 1)
                player:addItem(9099, 1)
                player:addExperience(10000000)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 35)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui todos os itens necessarios.", npc, creature)
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
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) and npcHandler:getTopic(playerId) == 1 then
        npcHandler:say("Ok, ok... Entao nao desperdice meu tempo.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. Se esta vivendo em Viridia, tem que estar sempre pronto para a proxima {missao}! Ou, quem sabe, voce esteja buscando por uma {permissao} para deixar o local... Ja finalizou suas {conquistas}?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais e boa sorte!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")

-- npcType registering the npcConfig table
npcType:register(npcConfig)



-- local internalNpcName = "Almirante Haldor"
-- local npcType = Game.createNpcType(internalNpcName)
-- local npcConfig = {}

-- npcConfig.name = internalNpcName
-- npcConfig.description = internalNpcName

-- npcConfig.health = 100
-- npcConfig.maxHealth = npcConfig.health
-- npcConfig.walkInterval = 2000
-- npcConfig.walkRadius = 2

-- npcConfig.outfit = {
-- 	lookType = 1436,
-- 	lookHead = 0,
-- 	lookBody = 68,
-- 	lookLegs = 59,
-- 	lookFeet = 59,
-- 	lookAddons = 1,
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

--     local monsterMappingA = {
--         [1] = "Dwarf",
--         [2] = "Rotworm",
--         [3] = "Minotaur",
--         [4] = "Orc",
--     }
    
--     local monsterMappingB = {
--         [1] = "Cyclops",
--         [2] = "Elf Scout",
--         [3] = "Tarantula",
--         [4] = "Stone Golem",
--     }

--     local monsterMappingC = {
--         [1] = "Dragon",
--     }
    
    
    
--     local monsterA = { 
--         { name = "Dwarf", id = 1 },
--         { name = "Rotworm", id = 2 },
--         { name = "Minotaur", id = 3 },
--         { name = "Orc", id = 4 },
--     }
    
--     local monsterB = {
--         { name = "Cyclops", id = 1 },
--         { name = "Elf Scout", id = 2 },
--         { name = "Tarantula", id = 3 },
--     }

--     local monsterC = {
--         { name = "Dragon", id = 1 },
--     }
    
    
--     local function getMonsterNameByIdA(monsterA, id)
--         for _, monster in ipairs(monsterA) do
--             if monster.id == id then
--                 return monster.name
--             end
--         end
--         return "Unknown"
--     end
    
--     local function getMonsterNameByIdB(monsterB, id)
--         for _, monster in ipairs(monsterB) do
--             if monster.id == id then
--                 return monster.name
--             end
--         end
--         return "Unknown"
--     end

--     local function getMonsterNameByIdC(monsterC, id)
--         for _, monster in ipairs(monsterB) do
--             if monster.id == id then
--                 return monster.name
--             end
--         end
--         return "Unknown"
--     end
    
--     local selectedMonsterA = monsterA[math.random(1, #monsterA)]
    
--     local monsterNameA = selectedMonsterA.name
--     local mTypeA = MonsterType(monsterNameA)
--     local raceIdA = mTypeA:raceId()
--     local monsteridA = selectedMonsterA.id
--     local bestiaryA = (player:getStorageValue(61305000 + raceIdA)) + 2
--     local monsterNameAA = getMonsterNameByIdA(monsterA, player:getStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraHunt))
    
    
--     local selectedMonsterB = monsterB[math.random(1, #monsterB)]
    
--     local monsterNameB = selectedMonsterB.name
--     local mTypeB = MonsterType(monsterNameB)
--     local raceIdB = mTypeB:raceId()
--     local monsteridB = selectedMonsterB.id
--     local bestiaryB = (player:getStorageValue(61305000 + raceIdB)) + 2
--     local monsterNameBB = getMonsterNameByIdB(monsterB, player:getStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraHunt))

--     local selectedMonsterC = monsterB[math.random(1, #monsterB)]
    
--     local monsterNameC = selectedMonsterC.name
--     local mTypeC = MonsterType(monsterNameC)
--     local raceIdC = mTypeB:raceId()
--     local monsteridC = selectedMonsterC.id
--     local bestiaryC = (player:getStorageValue(61305000 + raceIdC)) + 2
--     local monsterNameCC = getMonsterNameByIdB(monsterC, player:getStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraHunt))
    
--     local storage = player:getStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso)

--     if MsgContains(message, "mission") or MsgContains(message, "missao") then
--         if storage < 1 then
--             npcHandler:say("Ha! Mais um... Entao voce acha que vai aguentar passar por toda a dor e sofrimento que te aguarda em Viridia? Ja vou avisando que nao adianta chorar para os amigos quando for tarde demais... HA HA HA HA HA! \z
--             Se voce vai iniciar sua jornada em Viridia deve entender tres coisas muito importantes: Seu caminho nao sera facil, nao sera uma jornada rapida e voce so podera sair daqui quando completar todos os meus testes! \z
--             Tenha isso em mente antes de continuar seu desafio para se tornar um Guerreiro de Ferro de Crandoria. Voce tem certeza de que voce esta pronto para iniciar essa jornada?", npc, creature)
--             npcHandler:setTopic(playerId, 1)
--         elseif storage == 1 then
--             npcHandler:say("Para iniciar suas missoes, faremos um teste de poder de batalha. Quero que voce derrote alguns monstros. Para comecar, derrote 25 " ..monsterNameA.. " e retorne ate mim. \z
--             Voce encontrara essa criatura proxima a cidade, entao nao se preocupe. Caso sinta que ainda nao esta pronto, treine um pouco mais suas skills ou evolua um pouco mais nos trolls. Estarei aguardando.", npc, creature)
--             player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraItem, bestiaryA)
--             player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraHunt, monsteridA)
--             player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraRaceId, raceIdA)
--             player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraCount, 1)
--             player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 2)
--             npcHandler:setTopic(playerId, 0)
--         elseif storage == 2 then
--             if player:getStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraCount) < 25 then
--                 npcHandler:say("Como eu havia dito, eu preciso que voce derrote 25 " ..monsterNameAA.." . Retorne quando tiver conseguido.", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             else
--                 npcHandler:say("Excelente! Aqui esta uma pequena quantia de experiencia. Me diga quando estiver preparado para a proxima {missao}.", npc, creature)
--                 player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 3)
--                 player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraItem, 0)
--                 player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraHunt, 0)
--                 player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraRaceId, 0)
--                 player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraCount, 0)
--                 player:addExperience(3000)
--                 npcHandler:setTopic(playerId, 0)
--             end
--         elseif storage == 3 then
--             if player:getLevel() < 15 then
--                 npcHandler:say("Sem pressa, jovem gafanhoto... Para sua proxima missao acho melhor voce se preparar um pouco mais. Pegue nivel 15 e retorne ate mim e te entregarei o proximo desafio.", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             else
--                 npcHandler:say("Sua missao agora sera um pouco mais desafiadora. Na saida leste de Viridia voce encontrara um vilarejo de Amazonas e Valkyries. Preciso que voce entre no local e recupere uma sacola roubada. \z
--                 Dentro da sacola ha varios itens de valor sentimental de um de nossos guerreiros que foi ha algum tempo derrotado pelas terriveis amazonas. Agora buscamos recuperar os itens para devolver a sua familia. \z
--                 A sacola provavelmente estara escondida em algum container no local. Procure com cuidado e, quando encontrar, traga de volta para mim. Estarei esperando por voce.", npc, creature)
--                 player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 4)
--                 npcHandler:setTopic(playerId, 0)
--             end
--         elseif storage == 4 then
--             if player:getItemCount(12237) >= 1 then
--                 npcHandler:say("Muito obrigado! Com certeza os pertences daquele guerreiro terao um grande valor para sua familia. Como recompensa, a partir de agora voce tera permissao de acessar o ultimo andar da Academia de Crandoria. \z
--                 No ultimo andar voce encontrara o King Tibianus e, com ele, voce podera comprar sua Promotion, que custara 20.000 moedas de ouro. Me avise quando estiver preparado para sua proxima {missao}.", npc, creature)
--                 player:addExperience(3000)
--                 player:removeItem(12237, 1)
--                 player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 5)
--                 npcHandler:setTopic(playerId, 0)
--             else
--                 npcHandler:say("Encontre a sacola roubada no vilarejo das amazonas e traga-a para mim.", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             end
--         elseif storage == 5 then
--             npcHandler:say("Voce esta no caminho certo, |PLAYERNAME|, mas ha ainda muitas missoes a serem concluidas antes que voce possa partir para Crandoria. Na sua proxima missao testaremos seus poderes com monstros um pouco mais fortes. \z
--             Pegue uma das saidas a oeste da cidade e derrote 50 " ..monsterNameBB.. ". Cuidado! Essa missao pode ser pouco mais perigosa que a ultima. Caso tenha um companheiro de batalha, aconselho leva-lo com voce. \z
--             Ao terminar o desafio retorne ate mim e te darei uma boa recompensa pelo seu esforco. Boa sorte.", npc, creature)
--             player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraItem, bestiaryB)
--             player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraHunt, monsteridB)
--             player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraRaceId, raceIdB)
--             player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraCount, 1)
--             player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 6)
--         elseif storage == 6 then
--             if player:getStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraCount) < 50 then
--                 npcHandler:say("Como eu havia dito, eu preciso que voce derrote 50 " ..monsterNameBB.." . Retorne quando tiver conseguido.", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             else
--                 npcHandler:say("Muito bem! Foi mais rapido do que eu imaginava. Vejo isso como um bom sinal. Aqui, uma boa recompensa em ouro pelo seu trabalho bem executado. Me avise quando estiver em busca de outra {missao}.", npc, creature)
--                 player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 7)
--                 player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraItem, 0)
--                 player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraHunt, 0)
--                 player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraRaceId, 0)
--                 player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraCount, 0)
--                 player:addExperience(15000)
--                 player:addItem(3035, 20)
--                 npcHandler:setTopic(playerId, 0)
--             end
--         elseif storage == 7 then
--             npcHandler:say("Bom, |PLAYERNAME|... batalhas sao importantes, mas os guerreiros tambem precisam desenvolver uma forma de obter ouro e comprar seus suprimentos e equipamentos. \z
--             Orlando, localizado no segundo andar do depot, compra diversos itens de criaturas por um preco razoavel, mas para evitar contrabando de mercadorias, ele compra apenas de guerreiros que possuem minha permissao. \z
--             Para essa missao, preciso que voce me traga 1 Bat Wing, 3 Frost Giant Pelts e 1 Iron Ore, pois Orlando precisa desses itens com urgencia. Caso voce complete a missao, te darei permissao para negociar com ele quando quiser. Va! Estarei esperando.", npc, creature)
--             player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 8)
--             npcHandler:setTopic(playerId, 0)
--         elseif storage == 8 then
--             npcHandler:say("Voce conseguiu todos os itens?", npc, creature)
--             npcHandler:setTopic(playerId, 2)
--         elseif storage == 9 then
--             npcHandler:say("Seguindo rumo ao norte de Viridia ha um pantano que ja foi a casa de um antigo aliado da cidade, o velho Barthos. Ele viveu por anos no local mas foi embora apos a chegada de algumas bruxas que agora vivem ali. \z
--             Recentemente recebemos uma carta de Barthos pedindo que alguem fosse ate sua casa no meio do pantano e buscasse o restante de seus pertences e, adivinhe so? Esse alguem sera voce, |PLAYERNAME|! Ha ha ha... \z
--             Va ate a casa de Barthos no pantano e vasculhe o local. Traga qualquer coisa de valor que voce encontrar ali. E tenha cuidado!! Ha muito tempo ninguem vai la, nao sabemos o que podera encontrar ao entrar. Estarei esperando pelo seu retorno.", npc, creature)
--             player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 10)
--         elseif storage == 10 then
--             npcHandler:say("Retorne com os pertences de Barthos se quiser continuar sua jornada em Viridia.", npc, creature)
--             npcHandler:setTopic(playerId, 0)
--         elseif storage == 11 then
--             npcHandler:say("Voce trouxe os pertences de Barthos?", npc, creature)
--             npcHandler:setTopic(playerId, 3)
--         elseif storage == 12 then
--             if player:getLevel() >= 30 then
--                 npcHandler:say("Os necromancers que vivem ao noroeste de Viridia possuem um grande podem e planejam utilizar tal poder para atacar Viridia em breve. Preciso da sua ajuda para evitar que isso aconteca. \z
--                 Para isso, quero que voce invada suas torres a oeste do pantano e obtenha algum registro de seus planos, para que assim possamos nos preparar e evitar seu ataque. \z
--                 Vasculhe a torre e traga algum documento que registre seus planos. Uma carta, um pergaminho, qualquer coisa. Seja cuidadoso, mas nao tenha misericordia dos inimigos que encontrar no caminho!", npc, creature)
--                 player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 13)
--             else
--                 npcHandler:say("Voce ainda esta fraco para a proxima missao. Alcance o nivel 30 e retorne ate mim.", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             end
--         elseif storage == 13 then
--             npcHandler:say("Por favor, retorne com os pertences de Barthos.", npc, creature)
--             npcHandler:setTopic(playerId, 0)
--         elseif storage == 14 then
--             if player:getItemCount(4846) >= 1 then
--                 player:removeItem(4846, 1)
--                 player:addExperience(45000)
--                 player:addItem(3035, 30)
--                 npcHandler:say("Hmm... Muito interessante. Voce parece nao ser tao inutil quanto eu imaginava... Talvez em breve consiga passar por desafios ainda mais dificeis! Aqui, uma singela recompensa.", npc, creature)
--                 player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 15)
--                 npcHandler:setTopic(playerId, 0)
--             else
--                 npcHandler:say("Onde estao os registros dos necromancers?", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             end
--         elseif storage == 15 then
--             if player:getLevel() >= 40 then
--                 npcHandler:say("Vamos direto ao ponto: Se voce quer mostrar sua bravura, precisa conseguir derrotar alguns dragoes. Muitos dragoes... Derrote 100 dragons e retorne ate mim, se voce conseguir...", npc, creature)
--                 player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraItem, bestiaryC)
--                 player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraHunt, monsteridC)
--                 player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraRaceId, raceIdC)
--                 player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraCount, 1)
--                 player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 16)
--                 npcHandler:setTopic(playerId, 0)
--             else
--                 npcHandler:say("Voce ainda esta fraco para a proxima missao. Alcance o nivel 40 e retorne para seu proximo desafio.", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             end
--         elseif storage == 16 then
--             if player:getStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraCount) < 99 then
--                 npcHandler:say("Como eu havia dito, eu preciso que voce derrote 100 dragons. Retorne quando tiver conseguido.", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             else
--                 npcHandler:say("Muito bem! Demorou um pouco, mas pelo menos obteve um bom resultado e, para a surpresa de muitos, retornou com vida! Hahaha. Aqui, uma recompensa pela sua bravura.", npc, creature)
--                 player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 17)
--                 player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraItem, 0)
--                 player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraHunt, 0)
--                 player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraRaceId, 0)
--                 player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraCount, 0)
--                 player:addExperience(60000)
--                 player:addItem(3035, 50)
--                 npcHandler:setTopic(playerId, 0)
--             end
--         elseif storage == 17 then
--             if player:getLevel() >= 50 then
--                 npcHandler:say("No extremo norte do pantano voce encontrara os restos do que ja foi uma torre um dia. No local ha uma escada que leva ao esconderijo dos Heroes e do temivel Black Knight! \z
--                 Sua forca nao sera um problema em si, mas o caminho ate ele pode ser muito dificil. Sua missao sera chegar ate a sala do Black Knight, derrota-lo e pegar seu tesouro dentro do bau. \z
--                 Caso ele possua servos na sala, voce tambem devera derrota-los. E nao demore!", npc, creature)
--                 player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 18)
--                 npcHandler:setTopic(playerId, 0)
--             else
--                 npcHandler:say("Voce ainda esta fraco para a proxima missao. Alcance o nivel 50 e retorne para seu proximo desafio.", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             end
--         elseif storage == 18 then
--             npcHandler:say("Derrote o Black Knight e seus servos, pegue seu tesouro e retorne ate mim.", npc, creature)
--             npcHandler:setTopic(playerId, 0)
--         elseif storage == 19 then
--             npcHandler:say("Muito bom... Eu soube do seu feito. Muito bom mesmo! Estou comecando a ter fe no seu progresso, |PLAYERNAME|... Fique com todo o espolio do Black Knight, voce vai precisar. \z
--             Bom, acredito que voce esteja pronto para passar por alguns desafios por conta propria. Retorne para sua proxima missao apos o nivel 100.", npc, creature)
--             player:addExperience(85000)
--             player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 20)
--             npcHandler:setTopic(playerId, 0)
--         elseif storage == 20 then
--             if player:getLevel() >=100 then
--                 npcHandler:say("Entao voce ainda nao desistiu? Ha ha ha! Estou impressionado com sua persistencia, |PLAYERNAME|. A maioria nao chega ate aqui. Dizem ser 'muito dificil'. Um bando de fracos! \z
--                 Bom... 'cof cof'... Seguindo com suas missoes... Agora voce tera um desafio duplo: Derrotar os mestres Drakens no fundo da Selva de Viridia e obter seus tesouros. Para acessar o local voce tera que entrar na fortaleza da selva. \z
--                 Quando encontrar o esconderijo dos lizards e drakens, busque pelas portas que levam aos mestres: Draken Elite e Draken Abomination. Derrote ambos, obtenha os tesouros de cada um e retorne ate mim, se voce conseguir...", npc, creature)
--                 player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 21)
--                 npcHandler:setTopic(playerId, 0)
--             else
--                 npcHandler:say("Sua proxima missao exigira muito de voce. Retorne quanto estiver no nivel 100 ou maior.", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             end
--         elseif storage == 21 or storage == 22 then
--             npcHandler:say("Voce deve derrotar e obter os espolios dos dois mestre dos Drakens: O Draken Elite e o Draken Abomination. Depois de fazer isso, retorne ate mim.", npc, creature)
--             npcHandler:setTopic(playerId, 0)
--         elseif storage == 23 then
--             if player:getLevel() < 150 then
--                 npcHandler:say("Voce retornou com vida? HA! Confesso que achei que voce desistiria nessa missao. Mas parece que voce esta entendendo que quando as coisas nao sao tao faceis a recompensa tem um gosto melhor, nao e mesmo? \z
--                 Nao se preocupe, fique com os espolios dos Drakens como recompensa. Voce mereceu. Retorne no nivel 150 e te darei sua ultima missao e, dessa forma, voce tera minha permissao para sair de Viridia.", npc, creature)
--                 player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 24)
--                 npcHandler:setTopic(playerId, 0)
--             else
--                 npcHandler:say("Voce retornou com vida? HA! Confesso que achei que voce desistiria nessa missao. Mas parece que voce esta entendendo que quando as coisas nao sao tao faceis a recompensa tem um gosto melhor, nao e mesmo? \z
--                 Nao se preocupe, fique com os espolios dos Drakens como recompensa. Voce mereceu. Me diga quando estiver pronto e te darei sua ultima {missao} e, apos completa-la, voce tera minha permissao para sair de Viridia.", npc, creature)
--                 player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 24)
--                 npcHandler:setTopic(playerId, 0)
--             end
--         elseif storage == 24 then
--             if player:getLevel() > 100 then
--                 npcHandler:say("Como voce ainda nao saiu de Viridia acredito que voce realmente acha que tem o que precisa para se tornar um dos mais fortes seguidores do Caminho de Ferro, nao e mesmo? \z
--                 Veremos se sua confianca permanecera a mesma apos essa missao... Argentus, um antigo general de Crandoria, se perdeu na selva a leste daqui enquanto corria atras de um individuo dos povos Iks.  \z
--                 Muitas vezes entramos naquela mata e buscamos por ele e pelo povoado, que parece se esconder em algum local ao norte da selva. Encontre a civilizacao dos Iks e descubra alguma informacao sobre Argentus. Estarei esperando!", npc, creature)
--                 player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 25)
--                 npcHandler:setTopic(playerId, 0)
--             end
--         end
--     elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
--         if npcHandler:getTopic(playerId) == 1 then
--             npcHandler:say("Muito bem! Sendo assim, seja bem vindo ao caminho do Guerreiro de Ferro de Crandoria. Quando estiver preparado basta me dizer e te darei sua primeira {missao}.", npc, creature)
--             player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 1)
--             npcHandler:setTopic(playerId, 0)
--         elseif npcHandler:getTopic(playerId) == 2 then
--             if player:getItemCount(5894) >= 1 and player:getItemCount(5880) >= 1 and player:getItemCount(9658) >= 3 then
--                 player:removeItem(5894, 1)
--                 player:removeItem(5880, 1)
--                 player:removeItem(9658, 3)
--                 npcHandler:say("Excelente! Orlando ficara muito satisfeito. Como combinado, direi a Orlando que voce tem minha permissao para vender seus produtos de criaturas a ele. Me avise quando quiser iniciar outra {missao}.", npc, creature)
--                 player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 9)
--                 npcHandler:setTopic(playerId, 0)
--             else
--                 npcHandler:say("Voce nao possui todos os itens necessarios. Preciso de 1 Bat Wing, 1 Iron Ore e 2 Tarantula Eggs. Retorne quanto possuir todos os itens.", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             end
--         elseif npcHandler:getTopic(playerId) == 3 then
--             if player:getItemCount(3456) >= 1 and player:getItemCount(3349) >= 1 and player:getItemCount(3028) >= 5 then
--                 player:removeItem(3456, 1)
--                 player:removeItem(3349, 1)
--                 player:addExperience(5000)
--                 npcHandler:say("Muito bom, |PLAYERNAME|! Esperto que voce nao tenha enfrentado muitos problemas para completar o desafio. Aqui, fique com os diamantes. Barthos disse que seu crossbow era o que ele mais queria.", npc, creature)
--                 player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 12)
--                 player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Timer, 0)
--                 npcHandler:setTopic(playerId, 0)
--             else
--                 npcHandler:say("Voce por acaso esta tentando me enganar? Barthos sabia o que tinha na casa. Nao me faca perder tempo!", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             end
--         end
--     elseif (MsgContains(message, "no") or MsgContains(message, "nao")) and npcHandler:getTopic(playerId) == 1 then
--         npcHandler:say("Ok, ok... Entao nao desperdice meu tempo.", npc, creature)
--         npcHandler:setTopic(playerId, 0)
--     end
-- end


-- npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. Se esta vivendo em Viridia, tem que estar sempre pronto para a proxima {missao}!")
-- npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais e boa sorte!")
-- npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

-- npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- -- npcType registering the npcConfig table
-- npcType:register(npcConfig)
