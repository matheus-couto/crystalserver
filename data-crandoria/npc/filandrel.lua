local internalNpcName = "Filandrel"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 325,
	lookHead = 0,
	lookBody = 114,
	lookLegs = 75,
	lookFeet = 26,
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

    if MsgContains(message, "alquimia") or MsgContains(message, "alchemy") then
        if player:getStorageValue(Storage.Quest.Crandoria.AlchemySystem.Door) == 2 then
            npcHandler:say("Fique a vontade para subir as escadas e utilizar meu laboratorio.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.AlchemySystem.Door) == 1 then
            npcHandler:say("Voce podera acessar o laboratorio apos obter uma Soft Boots e uma Soul Stone. Voce possui esses itens com voce?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        elseif player:getStorageValue(Storage.Quest.Crandoria.AlchemySystem.Door) < 1 then
            npcHandler:say("Eu possuo um laboratorio subindo as escadas que voce pode utilizar para fazer diversas pocoes especiais. Mas para acessa-lo voce precisa trazer dois itens importantes para mim: Uma Soft Boots e uma Soul Stone. Traga-os para mim e eu te deixarei subir.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.AlchemySystem.Door, 1)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "nillux") then
        if player:getStorageValue(Storage.Quest.Crandoria.NilluxQuest.Progresso) < 1 then
            npcHandler:say("Ah... a Nillux. Sabia que essa pocao foi criada ha apenas alguns anos? Mas para ser sincero nao faco a menor ideia de como produzi-la, ate porque ja foi considerada altamente proibida. \z
            Ha algum tempo nao ouco falar sobre alguem que tenha utilizado uma Nillux, mas tenho uma ideia de quem pode ser o responsavel por produzi-la, embora nao possa provar... \z
            As pessoas o chamavam de Ginger Floyd, um mago nomade poderoso e um alquimista incomparavel. O unico problema sera encontra-lo. Ninguem sabe onde ele vive, apesar dele sempre aparecer em tavernas do Novo Continente.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.NilluxQuest.Progresso, 1)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "mission") or MsgContains(message, "missao") then
        if player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 75 then
            npcHandler:say("Finalmente voce chegou. Achei que o Comandante Crassus havia se esquecido de mim. Escute, minha demanda sera simples, mas exigira um esforco tremendo. Eu preciso de 10 Magic Sulphurs para algumas pocoes. Consegue esses itens para mim?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 76 then
            if player:removeItem(5904, 10) then
                npcHandler:say("Voce foi mais rapido do que eu imaginava! Realmente subestimei suas habilidades. Aqui esta sua recompensa. Seu trabalho em Astralis esta finalizado.", npc, creature)
                player:addItem(36727, 1, true)
                player:addExperience(5000000, true)
                player:addItem(22724, 15, true)
                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 77)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Preciso de 10 Magic Sulphurs. Traga-os para mim.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "elixir") then
        if player:getStorageValue(Storage.Quest.U10_80.Grimvale.MissaoWagner) == 2 then
            npcHandler:say("Ah... Entao Wagner foi quem enviou voce. Sim, sim... Eu encontrei o terceiro ingrediente para o elixir de protecao. \z
            Se ele confia em voce, talvez nao tenha problemas para conseguir encontra-lo. Va ate as terras geladas de Icehold e consiga tres Frosty Hearts. \z
            Leve-os para Wagner e diga para ele macerar todos os ingredientes juntos com um pouco de agua e tomar o elixir por completo.", npc, creature)
            player:setStorageValue(Storage.Quest.U10_80.Grimvale.MissaoWagner, 3)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "deus") or MsgContains(message, "god") then
        if player:getStorageValue(Storage.Quest.Crandoria.TheFalseGod.Progresso) == 1 then
            npcHandler:say("Hum... um falso deus, certo? Uma combinacao perigosa de poder e sabedoria podem ter levado esse monstro a pensar ocupar tal posto de deus. \z
            Infelizmente nao possuo nenhum conhecimento sobre a tal barreira da qual Vekandor te contou, mas podemos fazer alguns testes para descobrir se consigo ajudar. \z
            Mas voce precisara fazer os testes por conta propria. Acha que consegue?", npc, creature)
            npcHandler:setTopic(playerId, 4)
        elseif player:getStorageValue(Storage.Quest.Crandoria.TheFalseGod.Progresso) == 2 then
            npcHandler:say("Voce conferiu a entrada do local? Qual monstro guarda a barreira?", npc, creature)
            npcHandler:setTopic(playerId, 5)
        elseif player:getStorageValue(Storage.Quest.Crandoria.TheFalseGod.Progresso) == 3 then
            npcHandler:say("Leve o frasco e encha-o com sangue de um Minotaur Idol.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.TheFalseGod.Progresso) == 4 then  
            if player:getItemCount(18992) >= 1 then
                player:removeItem(18992, 1)
                player:setStorageValue(Storage.Quest.Crandoria.TheFalseGod.Progresso, 5)
                player:addExperience(500000)
                npcHandler:say("Trouxe o frasco cheio? Muito bem, vamos ao teste... Um pouco disso... uma pitada disso... pronto! Vou derramar sobre voce e veremos. <Vushh>\z
                Ainda nao esta pronto. Agora, retorne a Vekandor e peca a ele que utilize o encantamento da passagem sobre voce. Junto a essa pocao que fiz, isso deve funcionar. \z
                Te desejo boa sorte em sua missao.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "minotaur idol") then
        if npcHandler:getTopic(playerId) == 5 then
            npcHandler:say("Hmm.. Isso parece correto. Certo, entao vamos ao trabalho: Leve este frasco vazio ate o local, derrote um dos Minotaur Idol e encha o vial com seu sangue fresco. \z
            Traga o frasco para mim e tentarei fazer um encantamento para que voce consiga se passar por um deles. Estarei aqui esperando pelo seu retorno. Boa sorte.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.TheFalseGod.Progresso, 3)
            player:addItem(18991, 1)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
        if npcHandler:getTopic(playerId) == 1 then
            if player:getItemCount(6529) >= 1 and player:getItemCount(5809) >= 1 then
                npcHandler:say("Perfeito! Exatamente o que eu precisava! Muito obrigado. Voce agora podera acessar o meu laboratorio quando quiser.", npc, creature)
                player:removeItem(6529, 1)
                player:removeItem(5809, 1)
                player:setStorageValue(Storage.Quest.Crandoria.AlchemySystem.Door, 2)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao trouxe os itens que eu precisava. Lembre-se: Preciso de uma Soul Stone e uma Soft Boots.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 2 then
            npcHandler:say("Muito bem. Estarei aguardando aqui em minha torre. Boa sorte!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 76)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 3 then
            if player:removeItem(3251, 5) and player:removeItem() and player:removeMoneyBank(5000000) then
                player:addItem(33892, 1, true)
                npcHandler:say("Excelente! Basta mexer aqui e ali... E aqui esta sua pocao! Foi um prazer fazer negocios com voce. Volte quando precisar de mais alguma.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Eu preciso de 5 Luminescent Crystals, 5 Blood orbs e 5.000.000 gold coins. Traga tudo ou nada feito.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 4 then
            npcHandler:say("Certo! Entao preste atencao. Acredito que a barreira seja protegida por monstros, certo? Se voce nao tiver essa informacao, preciso que encontre o local e descubra para mim. \z
            Apos descobrir, me diga qual monstro esta no local. Se ja tiver essa informacao, por favor me diga: Qual monstro protege a barreira?", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.TheFalseGod.Progresso, 2)
            npcHandler:setTopic(playerId, 5)
        end
    elseif MsgContains(message, "luminescent") or MsgContains(message, "heart potion") or MsgContains(message, "pocao") or MsgContains(message, "potion") then
        if player:getStorageValue(Storage.Quest.Crandoria.WarlocksConspiracy.Progresso) == 11 then
            npcHandler:say({"Quem te falou sobre isso? Escute aqui! Essa pocao nao esta entre as minhas receitas do laboratorio por um bom motivo! Fazer essas pocoes pode ser muito perigoso...",
            "Se quiser Luminescent Heart Potions eu mesmo terei que produzi-las, mas havera um preco! Para isso, precisarei de 5 Luminescent Crystals, 5 Blood Orbs e 5.000.000 gold coins. ...", 
            "Os Luminescent Crystals podem ser obtidos dos mais habilidosos mineradores nas Minas de Astralis. Os Blood Orbs sao obtidos de criaturas poderosas do submundo. Traga tudo com voce e te darei sua pocao."}, npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.WarlocksConspiracy.Progresso, 12)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.WarlocksConspiracy.Progresso) >= 12 then
            npcHandler:say("Deseja obter uma Luminescent Heart Potion em troca de 5 Luminescent Crystals, 5 Blood Orbs e 5.000.000 gold coins?", npc, creature)
            npcHandler:setTopic(playerId, 3)
        end
    elseif MsgContains(message, "no") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Ok entao...", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    end
end

npcHandler:setMessage(MESSAGE_GREET, "Ola, jovem alma. Voce gostaria de trabalhar com um pouco de {alquimia}?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
