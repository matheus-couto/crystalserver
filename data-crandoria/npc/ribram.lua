local internalNpcName = "Ribram"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 5
npcConfig.walkRadius = 4

npcConfig.outfit = {
	lookType = 128,
	lookHead = 0,
	lookBody = 21,
	lookLegs = 97,
	lookFeet = 116,
	lookAddons = 2
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

    if MsgContains(message, "condenados") then
        npcHandler:say("Com tantos {monstros} em todos os {lugares}, o que voce espera da vida se nao uma morte precoce e solitaria? Mas nao se abale! \z
        Aproveite a vida enquanto pode, busque por amizades verdadeiras e conheca o amor ao menos uma vez. Depois espere pela {morte}, como eu estou fazendo.", npc, creature)
        npcHandler:setTopic(playerId, 1)
    elseif MsgContains(message, "monstros") then
        npcHandler:say("Ha dezenas, se nao centenas, de monstros nas proximidades do reino. Eu explorei alguns {lugares} e posso afirmar: Nao ha local seguro para viver fora das muralhas.", npc, creature)
        npcHandler:setTopic(playerId, 2)
    elseif MsgContains(message, "lugares") then
        npcHandler:say("Posso te dizer onde alguns dos monstros estao apontando em seu mapa. Mas nenhuma informacao sera de graca, estamos entendidos? Atencao... \z
        Por 25 Gold Coins eu posso te dizer onde voce encontrara: {amazons}, {elfs}, {orcs}, {ghouls}, {cyclops}, {minotaurs}, {stone golems}, {tarantulas}, {magicians} ou {dragons}. \z
        Escolha um monstro e pague o preco! Ha Ha Ha!", npc, creature)
        npcHandler:setTopic(playerId, 3)
    elseif MsgContains(message, "amazon") then
        if npcHandler:getTopic(playerId) == 3 then
            if player:removeMoneyBank(25) then
                npcHandler:say("Muito bem, escute... Saindo pelo norte da cidade e seguindo para o noroeste ate aqui, voce encontrara essas malditas guerreiras... Deixarei essa marca em seu mapa. \z
                Eu evitaria ao maximo passar por perto desse local...", npc, creature)
                player:addMapMark(Position(4960, 4900, 7), MAPMARK_SWORD, "Amazons")
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao tem muito dinheiro no banco... Como eu disse, sao 100 gold coins pela informacao.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "elf") then
        if npcHandler:getTopic(playerId) == 3 then
            if player:removeMoneyBank(25) then
                npcHandler:say("Os elfos ficam ao lado da cidade de Elvenshire. Se nao quiser ir de barco ate la, voce pode caminhar no sentido noroeste da cidade. \z
                Estou colocando uma marca em seu mapa de onde fica o local. Boa sorte!", npc, creature)
                player:addMapMark(Position(4800, 4782, 7), MAPMARK_SWORD, "Elfs")
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao tem muito dinheiro no banco... Como eu disse, sao 100 gold coins pela informacao.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "orc") then
        if npcHandler:getTopic(playerId) == 3 then
            if player:removeMoneyBank(25) then
                npcHandler:say("Os orcs sao criaturas extremamente perigosas. Nao me espanta que queira saber onde estao para evita-los. Preste atencao na marca do mapa... \z
                Eles ficam ao norte de Crandoria, numa enorme fortaleza. O local fica todo cercado por agua, tendo como unico ponto de acesso uma ponte a oeste. Tome cuidado por la!", npc, creature)
                player:addMapMark(Position(5047, 4803, 7), MAPMARK_SWORD, "Orcs")
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao tem muito dinheiro no banco... Como eu disse, sao 100 gold coins pela informacao.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "ghoul") then
        if npcHandler:getTopic(playerId) == 3 then
            if player:removeMoneyBank(25) then
                npcHandler:say("Os ghouls se escondem na area putrida a oeste de Crandoria, ao sul dos goblins da montanha. Eu nao chegaria nem perto se fosse voce... \z
                Dizem que ha criaturas ainda mais fortes nas profundezas, mas eu nao tive coragem o suficiente para explorar. Prefiro viver por mais alguns anos! Ha Ha!", npc, creature)
                player:addMapMark(Position(4900, 5013, 7), MAPMARK_SWORD, "Ghouls")
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao tem muito dinheiro no banco... Como eu disse, sao 100 gold coins pela informacao.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "cyclops") then
        if npcHandler:getTopic(playerId) == 3 then
            if player:removeMoneyBank(25) then
                npcHandler:say("Eu quase perdi uma perna fugindo desses monstros terriveis! Para sua sorte, eles ficam no topo de uma montanha ao norte de Crandoria e nao poderao te machucar. \z
                A nao ser que voce escolha subir a montanha... Acho que tem doido pra tudo. Independente de qualquer coisa, o dinheiro importa mais! Aqui, marquei seu mapa.", npc, creature)
                player:addMapMark(Position(4926, 4905, 7), MAPMARK_SWORD, "Cyclops")
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao tem muito dinheiro no banco... Como eu disse, sao 100 gold coins pela informacao.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "minotaurs") then
        if npcHandler:getTopic(playerId) == 3 then
            if player:removeMoneyBank(25) then
                npcHandler:say("Os minotauros ficam a oeste de Crandoria, passando pela ponte de madeira e subindo a montanha. Aqui, marquei o seu mapa. \z
                Eu ja enfrentei alguns minotauros, nao sao criaturas tao inteligentes, mas soube que alguns utilizam armas e ate mesmo magia, mas confesso que nunca os vi...", npc, creature)
                player:addMapMark(Position(4842, 4913, 7), MAPMARK_SWORD, "Minotaurs")
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao tem muito dinheiro no banco... Como eu disse, sao 100 gold coins pela informacao.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "stone golem") then
        if npcHandler:getTopic(playerId) == 3 then
            if player:removeMoneyBank(25) then
                npcHandler:say("Eu evitaria Stone Golems se fosse voce... Mas cada um sabe o que faz. Eles ficam ao norte de Crandoria, andando na planicie e sob o solo. Vou marcar seu mapa.", npc, creature)
                player:addMapMark(Position(4934, 4766, 7), MAPMARK_SWORD, "Stone Golems")
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao tem muito dinheiro no banco... Como eu disse, sao 100 gold coins pela informacao.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "tarantula") then
        if npcHandler:getTopic(playerId) == 3 then
            if player:removeMoneyBank(25) then
                npcHandler:say("Criaturas horrendas sao essas Tarantulas... Se quiser a morte certa, saia da cidade pelo portao leste e siga no sentido sudeste. \z
                Vou deixar uma marca em seu mapa. Boa sorte!", npc, creature)
                player:addMapMark(Position(5231, 5188, 7), MAPMARK_SWORD, "Tarantulas")
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao tem muito dinheiro no banco... Como eu disse, sao 100 gold coins pela informacao.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "magician") then
        if npcHandler:getTopic(playerId) == 3 then
            if player:removeMoneyBank(25) then
                npcHandler:say("Os Magicians ficam na torre proxima a saida leste de Crandoria. Eu nunca subi ate o topo, mas posso afirmar que ha muitos magos poderosos no local. \z
                Aqui esta, vou deixar uma marca no seu mapa. E tome cuidado! Voce pode acabar encontrando criaturas ainda mais poderosas no topo da torre...", npc, creature)
                player:addMapMark(Position(5105, 4965, 7), MAPMARK_SWORD, "Magicians")
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao tem muito dinheiro no banco... Como eu disse, sao 100 gold coins pela informacao.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "dragon") then
        if npcHandler:getTopic(playerId) == 3 then
            if player:removeMoneyBank(25) then
                npcHandler:say("Os dragoes foram os monstros mais fortes que ja enfrentei. Temidos por todos, podem ser um grande desafio para guerreiros inexperientes. Mas voce nao me parece um...\z
                Enfim... eles estao na direcao noroeste de Crandoria. Estou marcando no seu mapa, para que voce saiba. Boa sorte com eles!", npc, creature)
                player:addMapMark(Position(5169, 4861, 7), MAPMARK_SWORD, "Dragons")
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao tem muito dinheiro no banco... Como eu disse, sao 100 gold coins pela informacao.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "morte") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Se estiver buscando pela morte, aconselho que se aventure pelas masmorras de Crandoria, ao sudeste da cidade. Dizem que voce pode encontrar ate mesmo demonios la dentro. \z
            Eu nunca me arrisquei a entrar, prefiro nao morrer tao jovem, sabe? Ha ha ha ha!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    end
end

npcHandler:setMessage(MESSAGE_GREET, "Por que a pressa? Estamos todos {condenados} mesmo... Ha Ha Ha!!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcType:addDialogOptions("bye")
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
-- npcType registering the npcConfig table
npcType:register(npcConfig)
