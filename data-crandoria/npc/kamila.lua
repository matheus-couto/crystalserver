local internalNpcName = "Kamila"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 150,
	lookHead = 5,
	lookBody = 77,
	lookLegs = 114,
	lookFeet = 122,
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

    if MsgContains(message, "bons modos") then
        npcHandler:say("Se quer aprender bons modos, talvez deva entender melhor sobre a historia de Valkesh e do meu pai, Olvird. Uma biblioteca talvez seja o lugar certo para um jovem espirito como voce.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    elseif MsgContains(message, "doruma") then 
        if player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress) < 1 then
            npcHandler:say("Ora, ora... Parece que um estrangeiro aprendeu bons modos para se virar em Valkesh. Doruma, jovem! Talvez agora queira usar seu precioso tempo para me ajudar em uma {missao}.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress, 1)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
            npcHandler:setTopic(playerId, 1)
        elseif player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress) == 1 then
            npcHandler:say("Voce tem cara de alguem que precisa de uma boa {missao} para terminar bem o dia...", npc, creature)
            npcHandler:setTopic(playerId, 1)
        elseif player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress) == 2 then
            npcHandler:say("Doruma! Por favor, encontre uma Flor de Asura e traga para mim!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress) == 3 then
            npcHandler:say("Voce nao esta com a flor, entao por que perde nosso tempo? Preciso de uma Flor de Asura.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress) == 4 then
            npcHandler:say("Doruma! Doruma! Nao posso acreditar! Meu pai sempre me prometeu uma dessas flores e voce realmente trouxe ela para mim! Muito obrigada! Bom... Agora que voce me trouxe a flor, podemos passar para a proxima parte da {missao}.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress, 5)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
            npc:getPosition()
            npcHandler:setTopic(playerId, 2)
        elseif player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress) == 5 then
            npcHandler:say("Vou usar um pouco do polen dessa flor em uma pocao e vou jogar em voce. Ops!! Pronto. Com essa pocao voce toma a 'graca das asuras'. Essa bencao te proporciona um caminho seguro pela porta da Citadela. \z
            Apos passar pela porta, nao sei o que voce podera encontrar. So poderei te ajudar ate aqui. Por favor, chegue ao fim do enigma e me traga qualquer informacao.", npc, creature)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
            player:getPosition():createItem(2886, 1)
            player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress, 6)
            player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.AccessDoor, 1)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress) == 6 or player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress) == 7 then
            npcHandler:say("Doruma! Por favor, passe pela porta e me conte se voce conseguir desvendar o segredo das asuras!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress) == 8 then
            npcHandler:say("Doruma! Tem alguma novidade sobre a sua {missao}?", npc, creature)
            npcHandler:setTopic(playerId, 4)
        elseif player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.Reward) == 1 then
            npcHandler:say("Doruma! Por favor, me diga que voce finalmente terminou a sua {missao}!", npc, creature)
            npcHandler:setTopic(playerId, 6)
        elseif player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress) == 10 then
            npcHandler:say("Doruma! Ja decidiu se prefere o {Magic Crystal} ou as 5 Barras de {Ouro}? Escolha!", npc, creature)
            npcHandler:setTopic(playerId, 9)
        elseif player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress) > 10 then
            npcHandler:say("Doruma! Serei sempre grata pela sua ajuda, nobre alma!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "missao") or MsgContains(message, "mission") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Eu ja vivi muitas vidas em uma so. Em uma das minhas vidas eu fui uma Asura, acredite ou nao. Mas durante minha estadia no local eu descobri que as Asuras guardavam um segredo e, quando estava prestes a descobri-lo, fui capturada e banida. \z
            Alguns anos se passaram e nao consegui convencer ninguem a buscar por respostas. Infelizmente eu nao sou forte o suficiente para ir ate la por conta propria. Entao ofereco uma boa recompensa para qualquer um que esteja disposto a isso. Voce poderia me ajudar?", npc, creature)
            npcHandler:setTopic(playerId, 3)
        elseif npcHandler:getTopic(playerId) == 2 or player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress) == 5 then
            npcHandler:say("Vou usar um pouco do polen dessa flor em uma pocao e vou jogar em voce. Ops!! Pronto. Com essa pocao voce toma a 'graca das asuras'. Essa bencao te proporciona um caminho seguro pela porta da Citadela. \z
            Apos passar pela porta, nao sei o que voce podera encontrar. So poderei te ajudar ate aqui. Por favor, chegue ao fim do enigma e me traga qualquer informacao.", npc, creature)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
            player:getPosition():createItem(2886, 1)
            player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress, 6)
            player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.AccessDoor, 1)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress) == 8 then
            npcHandler:say("Uma carta? Voce pode me entregar?", npc, creature)
            npcHandler:setTopic(playerId, 5)
        elseif npcHandler:getTopic(playerId) == 6 then
            npcHandler:say("Entao voce encontrou uma chave em um bau? Isso pode soar estranho, mas acho que sei o que ela abre. Voce me daria a chave para eu fazer o teste?", npc, creature)
            npcHandler:setTopic(playerId, 7)
        end
    elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
        if npcHandler:getTopic(playerId) == 3 then
            npcHandler:say("Excelente! Eu vi em seus olhos que voce tem forca e espirito para grandes desafios. Primeiramente eu preciso descobrir como nascem as Flores de Asura. Voce pode obte-las \z
            na Citadela das Asuras, mas nao tenho certeza de como ela pode ser adquirida. Meu pai me dizia que a resposta poderia estar em alguns documentos e escrituras. Volte quando descobrir como essas flores surgem e traga uma para mim!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress, 2)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 4 then
            npcHandler:say("Uma carta? Voce pode me entregar?", npc, creature)
            npcHandler:setTopic(playerId, 5)
        elseif npcHandler:getTopic(playerId) == 5 then
            if player:getItemCount(3220) >= 1 then
                player:removeItem(3220, 1)
                player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress, 9)
                player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.StatuePortal, 1)
                npcHandler:say("Deixe-me ver. Meu deus! Era uma carta do meu proprio pai para mim! As Asuras devem ter escondido de mim na epoca que eu estava la. Ele disse que o segredo das Asuras esta na estatua de Fafnar que fica na Citadela. \z
                Disse tambem que a Tiara pode ser a chave para conseguir acessar a ultima peca do quebra cabecas. Eu nao acredito, meu proprio pai estava em busca de desvendar esse segredo! Por favor, leve a Tiara com voce e descubra o que aconteceu!", npc, creature)
            else
                npcHandler:say("Onde esta? Por favor, traga a carta para mim!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 7 then
            if player:getItemCount(28476) >= 1 then
                player:removeItem(28476, 1)
                player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress, 10)
                npcHandler:say("Eu sabia! Meu pai havia me deixado um cofre antes de morrer. Ele nunca me disse nada sobre esse cofre mas protegeu ele como se protegesse a propria vida. Vou usar a chave para abri-lo e... Funcionou! \z
                Dentro do bau ha um cristal brilhante e... Quem diria, algumas barras de ouro! Bom, eu prometi uma recompensa, entao deixarei que voce escolha: O que voce prefere, um {Magic Crystal} ou 3 Barras de {Ouro}?", npc, creature)
                npcHandler:setTopic(playerId, 8)
            else
                npcHandler:say("Onde esta? Me entregue a Chave de Lotus!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 10 then
            if player:removeMoneyBank(25000000) then
                player:addItem(11552, 1)
                npcHandler:say("Bom, trato feito! Ha ha ha. Esse cristal so me deu dor de cabeca mesmo... Boa sorte com ele! E cuidado! Ele pode ser mais valioso do que parece. Nao o passe para o primeiro que demonstrar interesse nele.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.Reward, 2)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif  MsgContains(message, "magic crystal") or MsgContains(message, "cristal magico")  then
        if player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress) == 10 then
            player:addExperience(2500000)
            player:addItem(11552, 1)
            player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.Reward, 2)
            player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress, 11)
            npcHandler:say("HA HA! Trato feito! Fique com sua pedra e eu fico com todo o ouro... Obrigada! Ha ha ha... Mas ei! Nao desanime. Tenho certeza que alguem em Valkesh tera interesse nesse Magic Crystal. Nao custa nada perguntar, nao e mesmo?", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress) < 10 then
            npcHandler:say("Do que voce esta falando?", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress) == 11 then
            if player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.Reward) < 2 then
                npcHandler:say("Continua querendo o Cristal Magico mesmo apos o dinheiro? HA! Tudo bem... Eu te dou o cristal, mas vai te custar 25.000.000 moedas de ouro. Voce aceita?", npc, creature)
                npcHandler:setTopic(playerId, 10)
            else
                npcHandler:say("Do que voce esta falando? Voce ja pegou o cristal!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        else
            npcHandler:say("Voce ja escolheu sua recompensa, nao ha nada que eu possa fazer agora!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif  MsgContains(message, "ouro") or MsgContains(message, "gold")  then
        if player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress) == 10 then
            player:addExperience(2500000)
            player:addItem(14112, 3)
            player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress, 11)
            npcHandler:say("Ouro, ouro ouro... Voces so pensam nisso, nao e mesmo? Pois bem, aqui esta. Mas nao venha ate mim quando eu descobrir todo o valor desse cristal e seu ouro acabar! Hahaha!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress) < 10 then
            npcHandler:say("Do que voce esta falando?", npc, creature)
            npcHandler:setTopic(playerId, 0)
        else
            npcHandler:say("Voce ja escolheu sua recompensa, nao ha nada que eu possa fazer agora!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Kamila, a Mae dos Ciganos. Essa sou eu! Cade as boas maneiras? Aprenda {bons modos} e talvez eu fale com voce.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais, jovem espirito.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais, jovem espirito.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
