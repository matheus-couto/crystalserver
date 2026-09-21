local internalNpcName = "Comandante Sivyna"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 1539,
	lookHead = 79,
	lookBody = 79,
	lookLegs = 79,
	lookFeet = 79,
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

    if MsgContains(message, "missao") or MsgContains(message, "mission") then
        if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 8 then
            if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Timer) < os.time() then
                npcHandler:say("Ah... Shiraks te enviou, certo? Muito bem. Eu preciso de um humano que consiga se esgueiras pelos monstros da ilha para uma tarefa importante: buscar um carregamento! \z
                Um pirata de confianca trouxe um carregamento de suprimentos e deixou em um bau na costa, a oeste da ilha. O carregamento contem alimentos, entao voce nao podera demorar para obte-lo. \z
                Atravesse a ilha e busque o carregamento para nosso povo. Voce tem trinta minutos para busca-lo e traze-lo para mim. Va, depressa!", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Timer, os.time() + 60 * 31)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("O que esta fazendo aqui? Corra! O carregamento nao vai esperar para sempre.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 9 then
            if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Timer) > os.time() then
                npcHandler:say("Voce conseguiu! Como passou por todos aqueles monstros tao rapido? Realmente, impressionante. Seu nome esta ficando conhecido pela ilha... \z
                Acredito que seja um bom sinal. Aqui, uma recompensa pela sua ajuda ate aqui. Alem disso, a partir de agora voce tera permissao para acessar nossas torres. \z
                Elas ficam espalhadas pela ilha e facilitam o acesso entre a montanha das Ancient Hydras e a planicie. Me avise quando estiver pronto para a proxima {missao}.", npc, creature)
                player:addExperience(player:getLevel() * 10000)
                player:addItem(20138, 1)
                player:addItem(11587, 1)
                player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 10)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Ah... Isso e terrivel. O carregamento estragou porque nao chegou a tempo. Nao tem problema, temos mais um chegando nesse exato momento. \z
                Te darei outra chance. Corre ate a costa novamente e busque o carregamento. Voce tem 30 minutos!", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 8)
                player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Timer, os.time() + 60 * 30)
                npcHandler:setTopic(playerId, 0)
            end
        elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 10 then
            npcHandler:say("Se terminar a proxima missao com sucesso, direi a Visanis para garantir sua entrada no Palacio das Nagas. Entao preste atencao, pois nao ser facil! \z
            Passando pela porta a esquerda de Shiraks, voce tera acesso a uma caverna extremamente perigosa. Voce tera que acessar o local e derrotar um terrivel monstro para completar a missao. \z
            Voce esta preparado para esse teste?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 11 then
            npcHandler:say("Derrote o monstro que vive nas profundezas!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 12 then
            npcHandler:say("Voce derrotou mesmo o temivel Grugarosh? Incrivel! Sendo assim cumprirei minha parte do combinado. Direi a Visanis que te conceda a entrada no Palacio das Nagas. \z
            Tambem te ofereco uma humilde recompensa pela sua ajuda. Um item raro e valioso: uma Gema Antiga. Voce nao podera fazer muito com ela agora, mas se conseguir provar seu valor, talvez possa utiliza-la um dia... \z
            Va! Siga sua jornada.", npc, creature)
            player:addItem(33309, 1)
            player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 13)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("O monstro das profundezas estava selado ha muitos anos, mas parece ter conseguido uma forma de retornar ao nosso mundo. Ha uma barreira ativa no local. \z
            Descubra uma forma de derrubar a barreira e ir de encontro com o monstro e, quando conseguir, derrote-o. Se voce conseguir matar a terrivel criatura, tera minha confianca. \z
            Leve o tempo que quiser. Estarei aguardando pelo seu retorno.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 11)
        end
    end

end


npcHandler:setMessage(MESSAGE_GREET, "Hoje parece um belo dia para morrer lutando!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
