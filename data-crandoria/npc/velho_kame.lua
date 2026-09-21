local internalNpcName = "Velho Kame"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 153,
    -- lookType = 472,
	lookHead = 0,
	lookBody = 129,
	lookLegs = 77,
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

    if MsgContains(message, "help") or MsgContains(message, "ajuda") then
        if player:getStorageValue(Storage.Quest.Crandoria.OldKame.Progresso) < 1 then
            npcHandler:say({"Como voce sabia que eu estava falando sobre mim? Ha ha ha... Talvez voce seja quase tao esperto quanto alguns outros guerreiros que conheci em outros tempos... Sendo assim sei que voce podera me ajudar!",
            "Bom... Na verdade eu fiquei preso do lado de fora de casa e preciso que alguem consiga entrar e pegar pelo menos uma das minhas chaves reservas. Ha tres delas dentro da casa. Traga-me pelo menos uma e te darei uma boa recompensa por ela. Voce aceita essa missao?",}, npc, creature)
            npcHandler:setTopic(playerId, 1)
        elseif player:getStorageValue(Storage.Quest.Crandoria.OldKame.Progresso) == 1 then
            npcHandler:say("Por favor, traga pelo menos uma das minhas chaves de casa de volta. Pegue algumas ferramentas para te ajudar, com certeza voce vai precisar.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.OldKame.Progresso) == 2 then
            if player:getStorageValue(Storage.Quest.Crandoria.OldKame.Keys) < 1 then
                npcHandler:say("Otimo, voce pegou a chave do porao. Agora entre e procure uma das chaves reservas da porta da frente. Ha tres delas la dentro.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            elseif player:getStorageValue(Storage.Quest.Crandoria.OldKame.Keys) == 1 and player:getStorageValue(Storage.Quest.Crandoria.OldKame.Progresso) < 3 then
                npcHandler:say("Voce encontrou uma chave! Muito bom. Aqui esta sua recompensa. Esse canivete serve como corda, picareta, machete, pa, colher e faca de cozinha. Te ajudara a salvar espaco na mochila!", npc, creature)
                player:addExperience(player:getLevel() * 5000, true)
                player:addItem(9594, 1, true)
                player:setStorageValue(Storage.Quest.Crandoria.OldKame.Progresso, 3)
                local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                npcHandler:setTopic(playerId, 0)
            elseif player:getStorageValue(Storage.Quest.Crandoria.OldKame.Keys) == 2 and player:getStorageValue(Storage.Quest.Crandoria.OldKame.Progresso) < 3 then
                npcHandler:say("Voce encontrou duas chaves! Que otimo. Aqui esta sua recompensa. Esse canivete serve como corda, picareta, machete, pa, pe de cabra e faca de cozinha. Te ajudara a salvar espaco na mochila!", npc, creature)
                player:addExperience(player:getLevel() * 10000, true)
                player:addItem(9598, 1, true)
                player:setStorageValue(Storage.Quest.Crandoria.OldKame.Progresso, 3)
                local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                npcHandler:setTopic(playerId, 0)
            elseif player:getStorageValue(Storage.Quest.Crandoria.OldKame.Keys) == 3 and player:getStorageValue(Storage.Quest.Crandoria.OldKame.Progresso) < 3 then
                npcHandler:say("Voce encontrou todas as chaves! Isso quase me assusta um pouco. Por onde voce andou? Achou alguma... revista la dentro? Enfim... Deixe pra la. Aqui esta sua recompensa. Esse canivete serve como espremedor de sucos, corda, pa, picareta, machete e dois tipos de foice. Te ajudara a salvar espaco na mochila! \z
                Como voce se mostrou extremamente util e sagaz, talvez queira me ajudar com uma {missao} especial...", npc, creature)
                player:addExperience(player:getLevel() * 15000, true)
                player:addItem(9596, 1, true)
                player:setStorageValue(Storage.Quest.Crandoria.OldKame.Progresso, 4)
                npcHandler:setTopic(playerId, 0)
            end
        elseif player:getStorageValue(Storage.Quest.Crandoria.OldKame.Progresso) == 3 then
            npcHandler:say("Sempre serei grato pela sua ajuda, |PLAYERNAME|. Fique a vontade para entrar na minha casa quando quiser.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgFind(message, "mission") or MsgFind(message, "missao") then
        if player:getStorageValue(Storage.Quest.Crandoria.OldKame.Progresso) == 4 then
            npcHandler:say("Tenho uma MISSAO SECRETA! No fundo do meu porao ha um corredor que leva a um portal magico. Esse portal pode ser usado para acessar a antiga prisao escondida de Magincia. Esse local abrigava os mais terriveis criminosos capturados no Novo Continente... \z
                'Cof Cof..' Mas isso ja faz muito tempo. O problema maior de agora esta sendo a infestacao de criaturas malignas no local. Albinius, um antigo amigo, foi para a prisao para tentar conter a multiplicacao dos monstros, mas ainda nao retornou. \z
                Sendo assim, jovem |PLAYERNAME|, a missao que te entrego sera acessar o local, encontrar Albinius e, se voce conseguir, ajuda-lo com a situacao. Posso contar com voce?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif player:getStorageValue(Storage.Quest.Crandoria.OldKame.Progresso) == 5 then
            npcHandler:say("Va ate a antiga prisao pelos fundos do meu porao e encontre Albinius.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.OldKame.Progresso) == 6 or player:getStorageValue(Storage.Quest.Crandoria.OldKame.Progresso) == 7 then
            npcHandler:say("Albinius esta vivo? Sensacional! Entao Izildor esta vivendo na prisao... entendo. Bom, ajude Albinius com o que ele precisar e depois retorne ate mim.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.OldKame.Progresso) == 8 then
            npcHandler:say("Voce conseguiu derrotar Izildor? Sensacional! Bom, parece que seu trabalho aqui esta feito, jovem. Aqui, uma singela recompensa para voce.", npc, creature)
            player:addItem(20138, 1)
            player:addExperience(player:getLevel() * 15000)
            player:setStorageValue(Storage.Quest.Crandoria.OldKame.Progresso, 9)
            local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
            player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 7)
            player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgFind(message, "secret mission") or MsgFind(message, "missao secreta") then
        if player:getStorageValue(Storage.Quest.Crandoria.OldKame.Progresso) == 3 or player:getStorageValue(Storage.Quest.Crandoria.OldKame.Progresso) == 4 then
            npcHandler:say("No fundo do meu porao ha um corredor que leva a um portal magico. Esse portal pode ser usado para acessar a antiga prisao escondida de Magincia. Esse local abrigava os mais terriveis criminosos capturados no Novo Continente... \z
            'Cof Cof..' Mas isso ja faz muito tempo. O problema maior de agora esta sendo a infestacao de criaturas malignas no local. Albinius, um antigo amigo, foi para a prisao para tentar conter a multiplicacao dos monstros, mas ainda nao retornou. \z
            Sendo assim, jovem |PLAYERNAME|, a missao que te entrego sera acessar o local, encontrar Albinius e, se voce conseguir, ajuda-lo com a situacao. Posso contar com voce?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say({"Perfeito! Eu acredito que a melhor forma de comecar a busca seja pelo buraco logo ali do lado. Voce podera encontrar um bau com a chave do meu porao e entrar na minha casa por ali. Eu mesmo iria, mas eu nao conseguiria voltar. Minha colua, sabe como e...",
            "Ah! Quase me esqueci. Ao subir as escadas voce encontrara uma pedra enorma nas escadas. Provavelmente tera que quebra-la com alguma ferramenta. Utilize as ferramentas certas e tudo ficara bem. Estarei esperando aqui fora, traga pelo menos uma das minhas chaves!"}, npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.OldKame.Progresso, 1)
        elseif npcHandler:getTopic(playerId) == 2 then
            npcHandler:say("Magnifico! Aqui esta a chave da porta que da acesso ao teleport. Boa sorte!", npc, creature)
            player:say('Voce agora possui acesso aos fundos do porao.', TALKTYPE_MONSTER_SAY)
            player:setStorageValue(Storage.Quest.Crandoria.OldKame.Progresso, 5)
            npcHandler:setTopic(playerId, 0)
        end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|... Lembre-se que todos precisamosde {ajuda} em um momento ou outro.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais.") 
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
