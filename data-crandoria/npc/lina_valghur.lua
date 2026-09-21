local internalNpcName = "Lina Valghur"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2
npcConfig.walkRadius = 3

npcConfig.outfit = {
	lookType = 140,
	lookHead = 0,
	lookBody = 99,
	lookLegs = 32,
	lookFeet = 116,
	lookAddons = 3
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

    if MsgContains(message, "aventura") then
        npcHandler:say("A familia Valghur ja teve um grande renome nos primeiros anos da cidade de Crandoria. Meu marido, Moe Valghur, foi um dos exploradores do local junto ao Captain Donahue. \z
        Enquanto Donahue explorava os mares, Moe explorava as terras e, em especial, as cavernas. ele ja descobriu lugares extremamente {perigosos}, mas com valiosas recompensas...", npc, creature)
        npcHandler:setTopic(playerId, 1)
    elseif MsgContains(message, "perigoso") then
        npcHandler:say("Voce realmente quer saber mais sobre esses lugares? Tudo bem... Eu posso te dar informacoes sobre a localizacao de algumas quests se quiser. Mas toda informacao tera um preco... \z
        Por 5.000 gold coins, posso marcar em seu mapa a entrada das quests {Demon Helmet} e {Annihilator}, do set {Yalahar}, do {Vampire Shield}, do {Noble Axe}, do {Royal Helmet}, das {Warzones} e da {Secret Library}. \z
        Qual dessas quests voce gostaria de conhecer?", npc, creature)
        npcHandler:setTopic(playerId, 2)
    elseif MsgContains(message, "demon helmet") or MsgContains(message, "annihi") then
        if npcHandler:getTopic(playerId) == 2 then
            if player:removeMoneyBank(5000) then
                npcHandler:say("As quests Demon Helmet e Annihilator possuem o mesmo ponto de acesso, nas ruinas a sudeste de Crandoria. Meu marido conseguiu finalizar ambos os desafios quando ainda era vivo... \z
                Aqui, vou marcar seu mapa para que voce possa chegar ao local.", npc, creature)
                player:addMapMark(Position(5198, 5077, 7), MAPMARK_EXCLAMATION, "Demon Helmet")
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Sinto muito, mas sem o valor de 5.000 gold coins nao posso te oferecer essas informacoes. Meu", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "yalahar") then
        if npcHandler:getTopic(playerId) == 2 then
            if player:removeMoneyBank(5000) then
                npcHandler:say("Embora a cidade de Yalahar nao exista mais, de acordo com as anotacoes do meu marido ha um caminho para se obter um item do famoso set de Yalahar... \z
                Saindo pelo norte, siga até a montanha no extremo norte, um pouco a esquerda, apos os Stone Golems. Marcarei a entrada do local no seu mapa.", npc, creature)
                player:addMapMark(Position(4944, 4694, 7), MAPMARK_EXCLAMATION, "Yalahar")
                player:addMapMark(Position(4944, 4694, 5), MAPMARK_EXCLAMATION, "Yalahar")
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Sinto muito, mas sem o valor de 5.000 gold coins nao posso te oferecer essas informacoes. Meu", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "vampire shield") then
        if npcHandler:getTopic(playerId) == 2 then
            if player:removeMoneyBank(5000) then
                npcHandler:say("Esta em busca de um escudo melhor? Meu marido sempre falava que o Vampire Shield pode ser um bom escudo para guerreiros iniciantes. Preste atencao: \z
                Para chegar ao local, entre na area do antigo cemiterio ao oeste da cidade. Explore as cavernas ate encontrar os vampiros e la encontrara seu Vampire Shield. Aqui, uma marca no mapa.", npc, creature)
                player:addMapMark(Position(4896, 5010, 7), MAPMARK_EXCLAMATION, "Vamp Shield")
                player:addMapMark(Position(4958, 5042, 9), MAPMARK_EXCLAMATION, "Vamp Shield")
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Sinto muito, mas sem o valor de 5.000 gold coins nao posso te oferecer essas informacoes. Meu", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "noble axe") then
        if npcHandler:getTopic(playerId) == 2 then
            if player:removeMoneyBank(5000) then
                npcHandler:say("De acordo com os registros de Moe, o Noble Axe fica guardado por necromancers e blood priests na mesma caverna dos Heroes, mas nao ha mais detalhes... \z
                Marcarei a entrada da caverna dos Heroes no seu mapa. O local fica proximo a montanha dos dragons, na regiao a nordeste da cidade.", npc, creature)
                player:addMapMark(Position(5195, 4868, 7), MAPMARK_EXCLAMATION, "Vamp Shield")
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Sinto muito, mas sem o valor de 5.000 gold coins nao posso te oferecer essas informacoes. Meu", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "royal helmet") then
        if npcHandler:getTopic(playerId) == 2 then
            if player:removeMoneyBank(5000) then
                npcHandler:say("A quest do Royal Helmet pode ser facilmente encontrada. Basta encontrar um acesso aos Demon Skeletons e Zombies ao norte de Crandoria e entrar na masmorra proxima. \z
                Aqui esta, uma marcacao no local. Mas cuidado! Ha criaturas fortes vigiando o local.", npc, creature)
                player:addMapMark(Position(4909, 4664, 7), MAPMARK_EXCLAMATION, "Royal Helmet")
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Sinto muito, mas sem o valor de 5.000 gold coins nao posso te oferecer essas informacoes. Meu", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "warzone") then
        if npcHandler:getTopic(playerId) == 2 then
            if player:removeMoneyBank(5000) then
                npcHandler:say("Confesso que me sinto mal cobrando por uma informacao como essa, mas preciso muito do dinheiro agora que nao tenho mais o Moe... \z
                O acesso a todas as warzones pode ser feito pelo teleport ao norte da cidade. Aqui esta uma marca em seu mapa.", npc, creature)
                player:addMapMark(Position(5046, 4889, 7), MAPMARK_EXCLAMATION, "Warzones")
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Sinto muito, mas sem o valor de 5.000 gold coins nao posso te oferecer essas informacoes. Meu", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "secret library") then
        if npcHandler:getTopic(playerId) == 2 then
            if player:removeMoneyBank(5000) then
                npcHandler:say("Ah... A Secret Library. Esse foi o ultimo lugar explorado por Moe antes de sua morte tragica. Tenha muito cuidado com as criaturas do lugar! \z
                A entrada do local fica no extremo sudeste da ilha, passando pela montanha dos Dragons e Dragon Lords. Aqui esta uma marcacao. Boa sorte!", npc, creature)
                player:addMapMark(Position(5352, 5311, 7), MAPMARK_EXCLAMATION, "Secret Library")
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Sinto muito, mas sem o valor de 5.000 gold coins nao posso te oferecer essas informacoes. Meu", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    end
end

npcHandler:setMessage(MESSAGE_GREET, "Ola, amante de {aventuras}. Eu ja te conheco?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais, jovem!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
