local internalNpcName = "Vekandor"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 516,
	lookHead = 38,
	lookBody = 44,
	lookLegs = 114,
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
    
    local storage = player:getStorageValue(Storage.Quest.Crandoria.TheFalseGod.Progresso)

    if MsgContains(message, "missao") or MsgContains(message, "mission") then
        if storage < 1 then
            npcHandler:say("Do que voce esta falando?", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 1 then
            npcHandler:say("O que esta esperando? Va ate Filandrel e fale com ele sobre o Falso Deus. Precisamos de toda ajuda possivel.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 5 then
            npcHandler:say("Uma pocao com o sangue de um Minotaur Idol? Ha! Esses alquimistas... Isso explica esse seu cheiro. Certo, farei o encantamento agora mesmo. \z
            'Exana Nox!' <pshhhh>. Encantamento feito! Agora, se tudo der certo, voce passara pela barreira. Mas CUIDADO! Nao fazemos ideia do que ha do outro lado. \z
            Provavelmente nao sera tao facil chegar ao False God. Va devagar e cuidado com armadilhas. Caso voce consiga encontra-lo, por favor, derrote-o!", npc, creature)
            player:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
            player:setStorageValue(Storage.Quest.Crandoria.TheFalseGod.Progresso, 6)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 6 then
            npcHandler:say("Por favor, derrote o terrivel False God. Precisamos da sua ajuda!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 7 then
            npcHandler:say("Um livro?... hum, Bulltaurs... Eu ja ouvi algo sobre eles. De acordo com as historias ha um guardiao no local que exige um sacrificio para entrar. \z
            As historias sempre dizem sobre um carrinho em minas escondidas que levaria ao local, talvez voce devesse buscar em Anvillux por uma dessas minas.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.TheFalseGod.Progresso, 8)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 8 or storage == 9 then
            npcHandler:say("Encontre a mina que leva aos Bulltaurs e derrote o Falso Deus!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 10 then
            npcHandler:say("Vitoria para nosso povo! Ainda bem. Confesso que estava com medo de que voce nao conseguisse retornar... Mas voce se mostrou forte. \z
            Aqui, uma simples recompensa pela sua dedicacao. Muito obrigado!", npc, creature)
            player:addExperience(5000000)
            player:addItem(3043, 10)
            player:addItem(26186, 1)
            player:addItem(26186, 1)
            player:setStorageValue(Storage.Quest.Crandoria.TheFalseGod.Progresso, 11)
            local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
            player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 8)
            player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
            npcHandler:setTopic(playerId, 0)
        end
    elseif (MsgContains(message, "god") or MsgContains(message, "deus")) then 
        if storage < 1 then
            npcHandler:say("Nem todos em Magincia acreditam em divindades, mas acredite, isso nao me espanta nem me preocupa. Cada um tem seu modo de ver o mundo. \z
            O problema aparece quando monstros decidem se misturar com deuses, sabe? Monstros nao deviam se proclamar deuses, oras! Eu chamo esses monstros de falsos deuses. \z
            Estamos montando um time especial para uma incursao para encontrar o ultimo Falso Deus auto proclamado. Talvez voce pudesse ajudar... O que acha? Voce acha que consegue ajudar?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Hum... voce respondeu sem nem pensar. Nao sei se voce entende o quanto essa missao pode ser perigosa. Mas toda ajuda pode ser util. \z
            Mas ha alguns problemas: O primeiro deles sera uma grande busca. De acordo com o que ja descobrimos, ha uma passagem protegida por uma barreira no covil do monstro. \z
            Para acessar o local precisaremos encontrar uma forma de quebrar ou passar por essa barreira. Nao fazemos ideia de como fazer isso, talvez a gente precise de ajuda de um alquimista. \z
            Ja sei! Va ate Filandrel, em Astralis, e explique a ele sobre o Falso Deus. Talvez ele possa nos ajudar.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.TheFalseGod.Progresso, 1)
            npcHandler:setTopic(playerId, 0)
        end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Saudacoes, |PLAYERNAME|")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Que os deuses estejam do seu lado!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
