local internalNpcName = "Drulok"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 160,
	lookHead = 0,
	lookBody = 129,
	lookLegs = 123,
	lookFeet = 76,
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

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

    if MsgContains(message, "mission") or MsgContains(message, "missao") then
        if player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 107 then
            npcHandler:say({"Ah! Entao foi o tal Comandante Crassus quem te enviou?... 'hiccup!'... Olha, eu sou um aventureiro e a verdade e que eu preciso de alguns itens para repor na minha colecao. ...",
            "Ja nao tenho mais tanta disposicao para cacar, sabe? He he... 'hicup!'... Traga-me 10 Vexclaw Talons e 10 Some Grimeleech Wings. Estarei esperando aqui mesmo na taverna! Ha ha ha! 'hicup!'... ",
            }, npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 108)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 108 then
            if player:removeItem(22728, 10) and player:removeItem(22730, 10) then
                npcHandler:say("Estao em perfeito estado! Muito bom... 'hicup!'.. Direi ao Crassus, digo... Comandante... 'hicup!' Crassus... Direi a ele que deu tudo certo.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 109)
                player:addExperience(5000000, true)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("10 Vexclaw Talons e 10 Grimeleech Wings... 'hicup!' ... Vai ser tudo que eu vou precisar.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
	elseif MsgContains(message, "primeiro dragao") then
		if player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso) == 3 then
			npcHandler:say("Ah... um aventureiro em busca de um ser majestoso. Meu tipo favorito de historia, sem duvidas! \z
            Claro, eu sei um pouco sobre isso. Viver em uma taverna tem seus beneficios. Mas nao posso te dar isso de graca. \z
            Que tal um {acordo}? Assim podemos nos ajudar.", npc, creature)
			npcHandler:setTopic(playerId, 2)
        elseif player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso) == 4 then
            npcHandler:say("Voce trouxe a garrafa de vinho feito em Astralis?", npc, creature)
            npcHandler:setTopic(playerId, 3)
		end
    elseif MsgContains(message, "acordo") then
        if player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso) == 3 then
            if npcHandler:getTopic(playerId) == 2 then
                npcHandler:say("Sera muito simples: Traga-me uma garrafa de Vinho feito com dragonfruits em Astralis. \z
                Me entregue o vinho e te contarei o que eu sei. Garanto que nao vai se arrepender. Quando retornar, me lembre do nosso {acordo}.", npc, creature)
                player:setStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso, 4)
                npcHandler:setTopic(playerId, 0)
            end
        elseif player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso) == 4 then
            npcHandler:say("Voce trouxe a garrafa de vinho feito em Astralis?", npc, creature)
            npcHandler:setTopic(playerId, 3)
        end
    elseif MsgContains(message, "ginger") or MsgContains(message, "floyd") then
        if player:getStorageValue(Storage.Quest.Crandoria.NilluxQuest.Progresso) == 4 then
            npcHandler:say("Ah, sim! O alquimista. Um otimo artesao, mas uma pessima companhia para beber! Esta sempre pesando o clima com seu mau humor. \z
            Eu sei como chegar ate ele, mas voce tera que me dar algo em troca dessa informacao. Que tal... 3 garrafas de rum de Astralis? Tem essas bebidas com voce?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        end
    elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
        if npcHandler:getTopic(playerId) == 1 then
            if player:getItemCount(36601) >= 3 then
                player:removeItem(36601, 3)
                npcHandler:say("Aah! Que maravilha! 'hicup!'. Ja bebi um pouco hoje, mas acredito que um pouco de rum nao fara mal a ninguem nao e mesmo? \z
                Sobre o alquimista... Eu soube que Bugozd estava disposto a ajuda-lo com um abrigo. Parece que ele conseguiu, mas voce tera que confirmar com ele.\z
                Va ate seu pequeno bar, no andar de cima, e pergunte voce mesmo. Diga que foi 'Drulok' quem o enviou.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.NilluxQuest.Progresso, 5)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Acho que voce ja bebeu mais que eu...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 3 then
            if player:getItemCount(27461) >= 1 then
                player:removeItem(27461, 1)
                player:setStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso, 5)
                npcHandler:say("Maravilha! Um dos meus favoritos! Bom, como prometido, o que sei sobre o Primeiro Dragao: \z
                De acordo com o que ouvi, aquele que obtiver quatro itens especiais dos guardioes podera executar um 'ritual'. \z
                Esse ritual garante o acesso do individuo ao local onde o dragao reside. Nao sei nada alem disso.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Esta tentando me enganar? Posso estar sempre bebado, mas eu sei identificar um vinho feito em Astralis e voce nao possui um!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    end
end


keywordHandler:addKeyword({"historias"}, StdModule.say,
    {
        npcHandler = npcHandler,
        text = "Eu tenho muitas historias sobre varias aventuras... 'hiccup'... Desde historias para criancas dormirem ate aventuras inimaginaveis nas costas de {tartarugas}."
    }
)

keywordHandler:addKeyword({"tortoise"}, StdModule.say,
    {
        npcHandler = npcHandler,
		text = "Eu me lembro como se fosse ontem... 'hiccup!'... Captain Donahue e eu estavamos explorando os moares quando encontramos um enorme canion a nossa frente... Nos atracamos o barco e tudo estava bem ate que... 'hiccup!'... Nos descemos as escadas, lutamos contra algumas bestas como de costume e quando continuamos adentro... Outras escadas nos levaram a uma pequena ilha com uma TARTARUGA GIGANTE na costa!! 'hiccup!' Nao pensei duas vezes, pulei nas costas da tartaruga e... Oh deus... 'hiccup!' Foi INCRIVEL! A criatura me levou para uma ilha maravilhosa. Eu chamaria o lugar de... 'hiccup!' Paraiso!"
    }
)

keywordHandler:addKeyword({"tartaruga"}, StdModule.say,
    {
        npcHandler = npcHandler,
		text = "Eu me lembro como se fosse ontem... 'hiccup!'... Captain Donahue e eu estavamos explorando os moares quando encontramos um enorme canion a nossa frente... Nos atracamos o barco e tudo estava bem ate que... 'hiccup!'... Nos descemos as escadas, lutamos contra algumas bestas como de costume e quando continuamos adentro... Outras escadas nos levaram a uma pequena ilha com uma TARTARUGA GIGANTE na costa!! 'hiccup!' Nao pensei duas vezes, pulei nas costas da tartaruga e... Oh deus... 'hiccup!' Foi INCRIVEL! A criatura me levou para uma ilha maravilhosa. Eu chamaria o lugar de... 'hiccup!' Paraiso!"
    }
)

keywordHandler:addKeyword({"tartarugas"}, StdModule.say,
    {
        npcHandler = npcHandler,
		text = "Eu me lembro como se fosse ontem... 'hiccup!'... Captain Donahue e eu estavamos explorando os moares quando encontramos um enorme canion a nossa frente... Nos atracamos o barco e tudo estava bem ate que... 'hiccup!'... Nos descemos as escadas, lutamos contra algumas bestas como de costume e quando continuamos adentro... Outras escadas nos levaram a uma pequena ilha com uma TARTARUGA GIGANTE na costa!! 'hiccup!' Nao pensei duas vezes, pulei nas costas da tartaruga e... Oh deus... 'hiccup!' Foi INCRIVEL! A criatura me levou para uma ilha maravilhosa. Eu chamaria o lugar de... 'hiccup!' Paraiso!"
    }
)

npcHandler:setMessage(MESSAGE_GREET, "Ola, viajante... Eu tenho muitas {historias} para contar, sabia? 'Hiccup!'")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais. Que suas aventuras sejam memoraveis!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)