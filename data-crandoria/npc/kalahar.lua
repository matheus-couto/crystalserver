local internalNpcName = "Kalahar"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 1069,
	lookHead = 0,
	lookBody = 68,
	lookLegs = 57,
	lookFeet = 59,
	lookAddons = 3,
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
        {name = "Magic Plate Armors", id = 3366, count = 3},
        {name = "Demon Shields", id = 3420, count = 3},
        {name = "Skull Helmets", id = 5741, count = 3},
        {name = "Golden Legs", id = 3364, count = 3},
        {name = "Zaoan Helmets", id = 10385, count = 3},
        {name = "Steel Boots", id = 3554, count = 3},
        {name = "Mastermind Shields", id = 3414, count = 3},
    }

    local possibleItems2 = {
        {name = "Demonic Matters", id = 49894, count = 20},
        {name = "Gorger Antlers", id = 50059, count = 20},
        {name = "Stag Parchments", id = 52664, count = 20},
        {name = "Demon Roots", id = 48510, count = 20},
        {name = "Resinous Fish Fins", id = 48509, count = 20},
        {name = "Prehemoth Claws", id = 39383, count = 20},
        {name = "Brachiodemon Hands", id = 33936, count = 20},
    }

    local possibleItems3 = {
        {name = "Figurine of Cruelty", id = 34019, count = 1},
        {name = "Figurine of Spite", id = 33952, count = 1},
        {name = "Figurine of Malice", id = 34018, count = 1},
        {name = "Figurine of Hatred", id = 34020, count = 1},
        {name = "Figurine of Greed", id = 34021, count = 1},
    }

    local selectedItem1 = possibleItems1[math.random(1, #possibleItems1)]
    local selectedItem2 = possibleItems2[math.random(1, #possibleItems2)]
    local selectedItem3 = possibleItems3[math.random(1, #possibleItems3)]

    local timeNow = os.time()

    local storage = player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso)
    local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
    local timer = player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItemsTimer)
    local questItem = player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade)

    local knight = player:getVocation():getBaseId() == VOCATION.BASE_ID.KNIGHT
    local paladin = player:getVocation():getBaseId() == VOCATION.BASE_ID.PALADIN
    local monk = player:getVocation():getBaseId() == VOCATION.BASE_ID.MONK
    local druid = player:getVocation():getBaseId() == VOCATION.BASE_ID.DRUID
    local sorcerer = player:getVocation():getBaseId() == VOCATION.BASE_ID.SORCERER

    if MsgContains(message, "mission") or MsgContains(message, "missao") or MsgContains(message, "desafio") then
        if storage < 175 then
            npcHandler:say("Eu sinto muito, mas minhas missoes sao dadas apenas para os verdadeiros Defensores de Crandoria.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 175 then
            if storageRep < 275 then
                npcHandler:say("Eu entendo que tenha passado pela provacao do Comandante Crassus, mas voce ainda nao tem o necessario, jovem... \z
                Minhas missoes especiais sao entregues apenas aqueles com reputacao Nobre ou superior.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Nao se afobe, |PLAYERNAME|... Entao Crassus enviou voce, certo? Aquele miseravel... Ele me deve boas horas de aventuras, voce sabia? Mas esta sempre enrolando para treinar novos recrutas como voce... \z
                Mas eu entendo, sao tempos dificeis. Estou buscando apenas os melhores e mais fortes para finalizarem algumas missoes importantes pelo bem de Crandoria e do Novo Continente. \z
                Aviso de antemao que sua jornada nao sera muito facil, mas sei que se chegou ate aqui voce tem potencial para passar pelos desafios que vem pela frente. E voce, acha que da conta?", npc, creature)
                npcHandler:setTopic(playerId, 1)
            end
        elseif storage == 176 then
            if player:getStorageValue(Storage.Quest.Crandoria.TheFalseGod.Progresso) >= 11 then
                if player:getFreeBackpackSlots() < 1 then
                    npcHandler:say("Abra espaco no seu inventario.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                else
                    npcHandler:say("Entao voce ja encontrou o esconderijo do tal Falso Deus e conseguiu derrota-lo... Isso realmente me tranquiliza. Parece que voce podera nos ajudar e muito! \z
                    Aqui, sua recompensa. O que foi? Esperava mais? Voce esta apenas iniciando sua jornada comigo, nao pense que te darei as melhores recompensas logo no inicio.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 177)
                    player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 8)
                    player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                    player:addExperience(20000000, true)
                    player:addItem(20139, 1)
                    npcHandler:setTopic(playerId, 0)
                end
            else
                npcHandler:say("Ajude Vekandor a encontrar e derrotar o Falso Deus.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 177 then
            npcHandler:say("Bom, agora que voce conseguiu encontrar os Bulltaurs em seu esconderijo, que tal uma simples missao de coleta? Mas essa nao sera tao facil quanto as do Crassus... \z
            Quero que me traga 50 Bulltaur Horns e 25 Strange Substances. Facil, nao? Sei que nao sera um grande desafio para voce. O que esta esperando? Va! Boa sorte com a tarefa.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 178)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 178 then
            npcHandler:say("Voce trouxe os 50 Bulltaur Horns e as 25 Strange Substances?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif storage == 179 then
            npcHandler:say("Bom, |PLAYERNAME|.. Como voce ja deve saber, pelo teleport num pequeno relevo ao norte de Crandoria voce tem acesso as chamadas Warzones. \z
            Sua proxima missao podera ser muito facil ou muito dificil para voce. Tudo dependera de quanto poder voce tem e de quem serao seus aliados nessa tarefa. \z
            Voce devera derrotar o Brainstealer. Nos ultimos tempos ele causou muitas baixas entre nossos guerreiros e sua missao se resumira simplesmente em VINGANCA! \z
            Va! Mostre para aquele monstro do que somos capazes!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 180)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 180 then
            npcHandler:say("Contenha os poderes do Brainstealer o derrotando em batalha.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 181 then    
            if player:getFreeBackpackSlots() < 1 then
                npcHandler:say("Abra espaco no seu inventario.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Eu soube da sua conquista antes mesmo de voce chegar em Magincia, |PLAYERNAME|. Voce realmente esta trazendo honra ao povo de nossas terras. \z
                Aqui esta sua recompensa. Magincia e Crandoria agradecem pela sua ajuda.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 182)
                player:addExperience(25000000, true)
                local bag = player:addItem(2859, 1)
                if bag then
                    bag:addItem(51450, 1)
                    bag:addItem(51453, 1)
                    bag:addItem(51458, 1)
                    bag:addItem(51459, 1)
                    bag:addItem(51465, 1)
                    bag:addItem(3043, 50)
                end
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 8)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 182 then 
            npcHandler:say("Voce parece ser muito habilidoso para derrotar bosses, |PLAYERNAME|. Depois do False God e do Branstealer nao restam duvidas. \z
            Entao talvez voce possa fazer um favor para a Sociedade dos Magos. Acredito que esse sera mais facil que muitos desafios pelos quais voce ja passou. \z
            Voce deve derrotar The Scourge of Oblivion, nas profundezas da Livraria, a sudeste de Crandoria. Voce ja deve conhecer o local a esse ponto, certo? \z
            Sei que nao sera problemas para voce. A Sociedade dos Magos ficara grata pelos seus servicos.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 183)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 183 then
            npcHandler:say("Derrote The Scourge of Oblivion.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 184 then
            if player:getFreeBackpackSlots() < 1 then
                npcHandler:say("Abra espaco no seu inventario.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Mais uma vez Magincia te agradece, |PLAYERNAME|, assim como toda a Sociedade dos Magos. Aqui, uma recompensa. \z
                Coloquei um pequeno brinde na sacola. Um ticket da roleta especial de Crandoria. Espero que tenha sorte!", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 185)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 8)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                player:addExperience(25000000, true)
                local bag = player:addItem(2859, 1)
                if bag then
                    bag:addItem(51447, 1)
                    bag:addItem(51448, 1)
                    bag:addItem(51449, 1)
                    bag:addItem(51454, 1)
                    bag:addItem(51457, 1)
                    bag:addItem(51461, 1)
                    bag:addItem(22706, 1)
                    bag:addItem(3043, 50)
                end
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 185 then
            npcHandler:say("Muito bem, |PLAYERNAME|... de acordo com o Comandante Crassus voce ja chegou a derrotar o First Dragon para Drako, na ilha de Dracantus. Estou certo? \z
            Bom, sua missao agora sera basicamente uma continuacao da sua jornada por Dracantus. Mas agora voce devera derrotar o que chamam de Dragon Pack. Uma familia de dragoes que vive nas profundezas. \z
            Se voce realmente ajudou Drako, ele ja conceceu a voce permissao para acessar o local. Entao va ate la e derrota a familia de dragoes acessivel pela alavanca. Retorne com vida e tera sua recompensa.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 186)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 186 then
            npcHandler:say("Derrote a familia de dragoes nas profundezas de Dracantus.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 187 then
            if player:getFreeBackpackSlots() < 1 then
                npcHandler:say("Abra espaco no seu inventario.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Tem sido uma honra testemunhar suas vitorias, |PLAYERNAME|. Realmente voce esta me surpreendendo. Aqui, sua recompensa e, claro, fale comigo caso esteja pronto para uma nova {missao}.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 188)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 8)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                player:addExperience(25000000, true)
                local bag = player:addItem(2859, 1)
                if bag then
                    bag:addItem(3043, 50)
                    bag:addItem(20138, 1)
                    bag:addItem(11372, 1)
                    bag:addItem(637, 1)
                    bag:addItem(637, 1)
                    bag:addItem(637, 1)
                end
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 188 then
            npcHandler:say("Agora te darei uma missao pela qual voce ja pode ate mesmo ter passado, mas tera que enfrentar mais uma vez pelo bem do nosso povo. \z
            Voce ja ajudou Anaztassja Moroia a derrotar os quatro lordes. Agora voce devera derrotar, talvez novamente, o boss Vladrukh, mas profundezas da masmorra dos Norcfeartus. \z
            Derrote-o 3 vezes. Caso ainda nao tenha passado por isso, fale com Anaztassja Moroia, ela te guiara ate ele. Sei que retornara com a vitoria.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 189)
            npcHandler:setTopic(playerId, 0)
        elseif storage >= 189 and storage < 192 then
            npcHandler:say("Derrote Vladrukh 3 vezes. Ele se esconde na ilha secreta dos vampiros.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 192 then
            if player:getFreeBackpackSlots() < 1 then
                npcHandler:say("Abra espaco no seu inventario.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Em breve estarao contando historias sobre voce, |PLAYERNAME|! Ha ha ha ha. Nao leve as coisas tao a serio e, claro, nao deixe que isso te suba a cabeca. \z
                Espero que Vladrukh nao tenha causado muitos problemas. Aqui esta sua recompensa.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 193)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 8)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                player:addExperience(30000000, true)
                local bag = player:addItem(2859, 1)
                if bag then
                    bag:addItem(14112, 1)
                    bag:addItem(51526, 1)
                end
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 193 then
            npcHandler:say("Escute, |PLAYERNAME|... voce ja ouviu falar no Castelo de Azzilon, lar dos Inferniarchs? Pois esse sera seu proximo destino! Entao preste atencao: \z
            Ha uma cabana a oeste de Astralis onde a Sociedade dos Magos criou um teleport que o levara direto ate o castelo. Mas apenas quem faz parte da Sociedade pode acessa-lo. \z
            Passando pelo teleport voce devera encontrar com Lai, nos andares superiores do castelo. Ajude-a com a missao de derrotar as forcas do mal que reinam o local e retorne ate mim vitorioso.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 194)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 194 then
            if player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Questlog) >= 10 then
                npcHandler:say("Ajude Lai a derrotar as forcas do mal no castelo de Azzilon. Apos finalizar sua missao, retorne ate mim.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce derrotou mesmo Arbaziloth, |PLAYERNAME|. Incrivel! Agora acredito que podemos passar para um novo desafio que estive guardando para voce. \z
                Mas antes disso, aqui esta sua recompensa.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 195)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 8)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                player:addExperience(30000000, true)
                local bag = player:addItem(2859, 1)
                if bag then
                    bag:addItem(14112, 1)
                    bag:addItem(50067, 1)
                end
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 195 then
            npcHandler:say("Muito bem, " ..dear.. " |PLAYERNAME|. O Arbaziloth talvez nao tenha sido um desafio tao grande para voce, mas o proximo desafio com certeza sera mais dificil se voce nao estiver com o time certo! \z
            Nas profundezas das cavernas que levam a Pale Worm voce encontrara uma alavanca que o levara para uma gruta sombria e perigosa. Atravessando o lugar voce encontrara um teleport para uma sala especial. \z
            Nessa sala voce tera acesso aos chefes da 'Soul War'! Sua missao sera derrotar todos eles e, por fim, derrotar o temivel Goshnar's Megalomania! Se conseguir terminar a missao, retorne ate mim. Confio no seu poder.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 196)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 196 then
            npcHandler:say("Derrote Goshnar's Megalomania e retorne ate mim. Te darei uma boa recompensa em troca de sua missao.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 197 then
            npcHandler:say("Voce demorou, |PLAYERNAME|. Mas eu entendo perfeitamente... Goshnar's Megalomania nao seria mesmo um desafio facil. Aqui, sua recompensa. Muito obrigado pela ajuda nessa missao tao importante.", npc, creature)
            player:addExperience(2500000 * (player:getLevel() / 100), true)
            player:addMoney(400000, true)
            player:addItem(22724, 35, true)
            player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 198)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 198 then
            npcHandler:say("Vejamos se voce realmente se tornou mestre em explorar cavernas e locais perigosos, |PLAYERNAME|. Sua proxima missao sera em uma caverna na Ilha de Sangue, onde fica localizada a cidade de Umbra. \z
            No leste da ilha voce encontrara um velho chamado Frigard. Ele precisara de ajuda com duas missoes. Finalize as duas missoes de Frigard e retorne ate mim. MAS CUIDADO!! Na segunda missao voce ira para um local muito perigoso. \z
            Todos que sao derrotados naquele lugar perdem seus pertences. Tome muito cuidado. Leve um time, se achar necessario! Retorne quanto terminar sua missao e te darei uma grande recompensa!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 199)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 199 or storage == 200 then
            npcHandler:say("Voce deve ajudar Frigard em suas duas missoes e depois retornar ate mim.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 201 then
            npcHandler:say("Muito bom, |PLAYERNAME|. Espero que voce nao tenha passado por grandes problemas durante as missoes. De qualquer forma, devo dizer que voce esta me impressionando. Aqui, sua recompensa e o novo outfit Cave Explorer, dado apenas aos verdadeiros Exploradores das Profundezas.", npc, creature)
            player:addExperience(2500000 * (player:getLevel() / 100), true)
            player:addMoney(1000000, true)
            player:addItem(22724, 30, true)
            player:addOutfit(575, 0)
            player:addOutfit(574, 0)
            player:addAchievement("Explorador das Profundezas")
            player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 202)
            player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 8)
            player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 202 then
            npcHandler:say("|PLAYERNAME|, algumas missoes podem exigir muito de alguns guerreiros, mas vejo que voce tem potencial para lidar com grandes desafios. \z
            Sua missao agora o levara a Gnomprona, lar da Magma Bubble, seu proximo alvo. Derrote-a 5 vezes e te darei uma boa recompensa em troca do seu esforco.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 203)
            npcHandler:setTopic(playerId, 0)
        elseif storage >= 203 and storage < 208 then
            npcHandler:say("Voce deve derrotar a Magma Bubble 5 vezes. Cheque seu Quest Log para confirmar o seu progresso.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 208 then
            npcHandler:say("Muito bem, |PLAYERNAME|. Seus esforcos estao mantendo nosso mundo em ordem. Aqui, sua recompensa: Um Full Stamina Refill e 300k em gold.", npc, creature)
            player:addExperience(30000000, true)
            player:addMoney(300000, true)
            player:addItem(20139, 1)
            player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 209)
            player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 8)
            player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 209 then
            npcHandler:say("Agora que voce se habituou com Gnomprona, acredito que voce consiga lidar com um monstro um pouco mais problematico do local: O Primal Menace! \z
            Mas dessa vez preciso que ele seja derrotado apenas 3 vezes. Sei que dara conta dessa missao! Conto com voce.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 210)
            npcHandler:setTopic(playerId, 0)
        elseif storage >= 210 and storage < 213 then
            npcHandler:say("Voce deve derrotar a Primal Menace 3 vezes. Cheque seu Quest Log para confirmar o seu progresso.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 213 then
            npcHandler:say("Como foi a experiencia, |PLAYERNAME|? Espero que nao tenha sido muito dificil, mas tenho certeza que voce obteve muita experiencia de batalha agora. \z
            Aqui, sua recompensa. Voce finalizou esta etapa e agora pode ser considerado um verdadeiro Defensor de Crandoria. Mas seus desafios nao terminaram. Procure por Kalahar, em Magincia. \z
            Ele esta sendo responsavel pelos guerreiros de Crandoria apos sua provacao. Boa sorte!", npc, creature)
            player:addExperience(30000000, true)
            player:addMoney(1000000, true)
            player:addItem(51589, 1, true)
            player:addItem(39546, 1, true)
            player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 214)
            player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 8)
            player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 214 then
            npcHandler:say("Bom, |PLAYERNAME|... antes de caminharmos para sua proxima jornada, preciso que faca algumas tarefas de coleta de recursos para mim. Serao coisas muito simples, nao se preocupe. \z
            Mas voce tera um tempo limite para obter os itens que eu irei pedir. Esta preparado para comecar?", npc, creature)
            npcHandler:setTopic(playerId, 3)
        elseif storage == 215 then
            if timer < timeNow then
                npcHandler:say("Que pena, |PLAYERNAME|, voce nao conseguiu terminar sua missao de coleta a tempo. Deseja tentar novamente?", npc, creature)
                npcHandler:setTopic(playerId, 3)
            else
                if player:getItemCount(questItem) >= 3 then
                    npcHandler:say("Otimo! Voce realmente foi rapido na primeira missao. Vamos passar para algum um pouco mais desafiador na proxima vez. Aqui esta sua recompensa.", npc, creature)
                    player:removeItem(questItem, 3)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 216)
                    player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 8)
                    player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                    player:addExperience(10000000, true)
                    player:addMoney(1000000, true)
                    local bag = player:addItem(2859, 1)
                    if bag then
                        bag:addItem(22724, 25)
                        bag:addItem(22721, 25)
                        bag:addItem(8778, 1)
                    end
                    npcHandler:setTopic(playerId, 0)
                else
                    local name = getItemName(questItem)
                    npcHandler:say("Voce nao trouxe todos os itens que eu solicitei. Preciso de 3 unidades de "..name..".", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                end
            end
        elseif storage == 216 then
            npcHandler:say("Vamos para mais uma missao de coleta, |PLAYERNAME|. Nessa te darei mais tempo. Esta preparado?", npc, creature)
            npcHandler:setTopic(playerId, 4)
        elseif storage == 217 then
            if timer < timeNow then
                npcHandler:say("Que pena, |PLAYERNAME|... Voce nao conseguiu terminar sua missao de coleta a tempo. Deseja tentar novamente?", npc, creature)
                npcHandler:setTopic(playerId, 4)
            else
                if player:getItemCount(questItem) >= 20 then
                    npcHandler:say("17... 18... 19... e VINTE! Muito bem, esta tudo aqui. Acho que o reino de Crandoria deveria te conceder uma medalha! Ha ha ha. \z
                    Aqui, sua recompensa. Te passei apenas mais uma missao de coleta e teremos finalizado essa etapa. Me avise quando estiver pronto para a proxima {missao}.", npc, creature)
                    player:removeItem(questItem, 20)
                    player:addExperience(15000000, true)
                    player:addMoney(1000000, true)
                    local bag = player:addItem(2859, 1)
                    if bag then
                        bag:addItem(20139, 1)
                        bag:addItem(22771, 1)
                    end
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 218)
                    player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 8)
                    player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                    npcHandler:setTopic(playerId, 0)
                else
                    local name = getItemName(questItem)
                    npcHandler:say("Voce nao trouxe todos os itens que eu solicitei. Preciso de 20 "..name..".", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                end
            end
        elseif storage == 218 then
            npcHandler:say("A proxima missao de coleta sera a ultima com tempo limite que passarei a voce. Esta preparado?", npc, creature)
            npcHandler:setTopic(playerId, 5)
        elseif storage == 219 then
            if timer < timeNow then
                npcHandler:say("Que pena, |PLAYERNAME|... Voce nao conseguiu terminar sua missao de coleta a tempo. Deseja tentar novamente?", npc, creature)
                npcHandler:setTopic(playerId, 5)
            else
                if player:getItemCount(questItem) >= 1 then
                    npcHandler:say("Mais um artefato para a nossa colecao! Muito bem, |PLAYERNAME|. Aqui esta sua recompensa. Boa sorte ao usa-la!", npc, creature)
                    player:removeItem(questItem, 1)
                    player:addExperience(15000000, true)
                    player:addMoney(1000000, true)
                    player:addItem(12811, 1)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 220)
                    player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 8)
                    player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                    npcHandler:setTopic(playerId, 0)
                else
                    local name = getItemName(questItem)
                    npcHandler:say("Voce nao trouxe o que eu solicitei. Preciso de 1 "..name..".", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                end
            end
        elseif storage == 220 then
            if level >= 800 then
                npcHandler:say("Preste muita atencao, |PLAYERNAME|. Forcas do mal estao retornando e causando um enorme desequilibrio em nossas terras e voce sera o responsavel por para-las. \z
                A mensagem que recebi veio de Umbra, de um sacerdote reptil chamado S'Zallar M'Andar. Ele disse que o Bone Overlord precisa ser eliminado. Encontre-o e ajude-o com sua missao e, ao final, derrote o boss. \z
                Caso ja tenha ajudado S'Zallar M'Andar antes, saiba que o Bone Overlord retornou. Entao apenas derrote-o! Consiga um bom time para essa missao. Boa sorte!", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 221)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce precisa ficar um pouco mais forte para executar as proximas missoes que tenho para voce. E espero que voce nao demore, o mundo depende de voce. \z
                Retorne apos o nivel 800.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 221 then
            npcHandler:say("Ajude S'Zallar M'Andar em Umbra e derrote o Bone Overlord.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 222 then
            npcHandler:say("Eu estaria te subestimando se dissesse que sua vitoria me impressionou. Eu ja sabia que voce tinha potencial para tal missao. \z
            Aqui esta sua recompensa.", npc, creature)
            player:addExperience(30000000, true)
            player:addMoney(1000000, true)
            local bag = player:addItem(2859, 1)
            if bag then
                bag:addItem(20138, 1)
                bag:addItem(11372, 1)
                bag:addItem(26186, 1)
            end
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 223)
            player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 8)
            player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 223 then
            npcHandler:say("Agora que voce possui acesso as criptas de Dracantus podera conseguir materiais valiosos para a Sociedade dos Magos... Se me ajudar com isso posso ate te oferecer mais poder. \z
            Vamos comecar com algo simples: Consiga 30 Necromantic Cores para mim. Leve quanto tempo for necessario. Se me trouxer ", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 224)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 224 then
            npcHandler:say("Voce trouxe os 30 Necromantic Cores?", npc, creature)
            npcHandler:setTopic(playerId, 6)
        elseif storage == 225 then
            npcHandler:say("Certo, ja temos os Necromantic Cores. Para a proxima missao preciso que me traga 1 Fetid Heart e 1 Cryptic Fossil. \z
            Lembre-se que Cryptic Fossil so podem ser obtidos na Forsaken Crypt.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 226)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 226 then
            npcHandler:say("Voce conseguiu os itens que eu pedi?", npc, creature)
            npcHandler:setTopic(playerId, 7)
        elseif storage == 227 then
            npcHandler:say("O ultimo recurso sera um pouco mais dificil de ser obtido. Talvez voce demore um tempo, mas sei que conseguira. \z
            Preciso de 1 Ancient Eye Stalk, obtido apenas do Bone Overlord. Sei que ele vale muito, nao se preocupe, voce recebera cada centavo. \z
            Apos conseguir esse item, poderei realizar um ritual para te conceder um poder especial. Agora va!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 228)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 228 then
            npcHandler:say("Voce obteve o Ancient Eye Stalk?", npc, creature)
            npcHandler:setTopic(playerId, 8)
        elseif storage == 229 then
            npcHandler:say("Nao possuo mais nenhuma missao para voce. Avise ao Comandante Crassus que foi uma honra obter sua ajuda.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Otimo! Gostei da confianca. Entao vamos comecar. Sua primeira missao sera buscar por uma divindade. Alias... uma falsa divindade auto proclamada, melhor dizendo. \z
            Para iniciar essa missao, fale com Vekandor, aqui mesmo em Magincia. Ele tem mais informacoes sobre esse tal Falso Deus. Ajude-o a enfrentar esse problema e te darei uma recompensa. \z
            Demore o tempo que quiser, estarei aqui esperando pelo seu retorno ou pela sua morte. Ha ha ha!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 176)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getItemCount(44736) >= 50 and player:getItemCount(44740) >= 25 then
                if player:getFreeBackpackSlots() < 1 then
                    npcHandler:say("Abra espaco no seu inventario.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                else
                    player:removeItem(44736, 50)
                    player:removeItem(44740, 25)
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 179)
                    player:addExperience(20000000, true)
                    player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 8)
                    player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                    local bag = player:addItem(2859, 1)
                    if bag then
                        bag:addItem(51462, 1)
                        bag:addItem(51464, 1)
                        bag:addItem(51467, 1)
                        bag:addItem(3043, 50)
                    end
                    npcHandler:say("Excelente! Esta tudo aqui. Aqui, pegue um pouco de gold e esses imbuement scrolls. Acredito que ajudarao voce no seu proximo desafio..", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                end
            else
                npcHandler:say("Preciso de 50 Bulltaur Horns e 25 Strange Substances. Voce nao possui todos os itens.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 3 then
            npcHandler:say("Muito bem, entao vamos a primeira missao: Obtenha " ..selectedItem1.count.." " ..selectedItem1.name.." em no maximo 4 horas e traga para mim. \z
            Caso voce nao consiga a tempo, podera reiniciar a missao, mas pode ser que eu ja nao precise mais desse item especificamente... Boa sorte!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 215)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItemsTimer, os.time() + 4 * 60 * 60)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, selectedItem1.id)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 4 then
            npcHandler:say("Quero agora que me traga " ..selectedItem2.count.." " ..selectedItem2.name.." em no maximo 24 horas. \z
            Caso voce nao consiga a tempo, podera reiniciar a missao mas, como na anterior, pode ser que eu ja nao precise mais desse item especificamente... Boa sorte!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 217)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItemsTimer, os.time() + 24 * 60 * 60)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, selectedItem2.id)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 5 then
            npcHandler:say("Quero agora que me traga " ..selectedItem3.count.." " ..selectedItem3.name.." em no maximo 5 dias. \z
            Mais uma vez, caso voce nao termine a tempo podera reiniciar, mas pode ser que eu ja nao precise mais desse item especificamente. Sugiro que nao demore!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 219)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItemsTimer, os.time() + 5 * 24 * 60 * 60)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.ItensDeQualidade, selectedItem3.id)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 6 then
            if player:getItemCount(52705) >= 30 then
                player:removeItem(52705, 30)
                player:addExperience(10000000, true)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 8)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 225)
                npcHandler:say("Muito bem, |PLAYERNAME|. Voce completou o primeiro passo. Me avise quando estiver pronto para a proxima etapa da sua {missao}.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui todos os itens. Preciso de 30 Necromantic Cores.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 7 then
            if player:getItemCount(52708) >= 1 and player:getItemCount(52709) >= 1 then
                player:removeItem(52708, 1)
                player:removeItem(52709, 1)
                player:addExperience(10000000, true)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 8)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 227)
                npcHandler:say("Excelente, |PLAYERNAME|! Estamos quase la! Me avise quando estiver preparado para o proximo {desafio}.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui todos os itens. Preciso de 1 Fetid Heart e 1 Cryptic Fossil.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 8 then
            if player:getItemCount(52716) >= 1 then
                if knight then
                    npcHandler:say("Sensacional! Agora poderemos realizar novos rituais de protecao para Magincia. O pagamento pelo item foi entregue diretamente a voce e, como recompensa... \z
                    Estou te concedendo um novo poder: o Greater Challenge (exeta gran res). Essa spell possui cooldown de 4 segundos e se resume em um Challenge com area maior. Pode salvar seus amigos em certas ocasioes.", npc, creature)
                elseif paladin then
                    npcHandler:say("Sensacional! Agora poderemos realizar novos rituais de protecao para Magincia. O pagamento pelo item foi entregue diretamente a voce e, como recompensa... \z
                    Estou te concedendo um novo poder: o Paralyze Missile (exori ani san). A spell tem 8 segundos e causa dano de Holy alem de 50% de chande de causar 2s de Paralyze no alvo. Pode ser muito util na hora de fugir ou perseguir um alvo.", npc, creature)
                elseif sorverer then
                    npcHandler:say("Sensacional! Agora poderemos realizar novos rituais de protecao para Magincia. O pagamento pelo item foi entregue diretamente a voce e, como recompensa... \z
                    Estou te concedendo um novo poder: o Fear Death Beam (exevo nox mort). Essa spell tem cooldown de 60 segundos e se consiste num Beam de morte que causa dano de morte e 30% de chance de causar 2s de fear. Pode ser extremamente util em batalhas.", npc, creature)
                elseif druid then
                    npcHandler:say("Sensacional! Agora poderemos realizar novos rituais de protecao para Magincia. O pagamento pelo item foi entregue diretamente a voce e, como recompensa... \z
                    Estou te concedendo um novo poder: o Ice Freezing Wave (exevo max frigo hur). Com essa wave de gelo voce tem 30% de chance de congelar seus inimigos por 2 segundos. Ela possui alto dano de gelo e cooldown de 2 minutos.", npc, creature)
                elseif monk then
                    npcHandler:say("Sensacional! Agora poderemos realizar novos rituais de protecao para Magincia. O pagamento pelo item foi entregue diretamente a voce e, como recompensa... \z
                    Estou te concedendo um novo poder: o Greater Sweeping Takedown (exori max nia). Semelhante ao Sweeping Takedown, esse poder possui uma area total em volta de voce, com leve aumento de dano e cooldown de 16 segundos. Use com sabedoria.", npc, creature)
                end
                player:addMoney(3500000, true)
                player:removeItem(52716)
                player:addExperience(30000000, true)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 8)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 229)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Onde esta o item? Acho que voce se confundiu dessa vez...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. Guerreiros do Novo Continente tem que estar sempre prontos para a proxima {missao}!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais e boa sorte!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
