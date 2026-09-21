local internalNpcName = "Hidrox, o Oportunista"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 957,
	lookHead = 57,
	lookBody = 114,
	lookLegs = 51,
	lookFeet = 115,
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

npcType.onCloseChannel = function(npc, creature)
    npcHandler:onCloseChannel(npc, creature)
end

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()
    local storage = player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso)

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

    if MsgContains(message, "mission") or MsgContains(message, "missao") then
        if storage < 1 then
            npcHandler:say("Quer enganar um criminoso? HAHA!! Eu so converso com quem esta do meu lado.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 1 then
            npcHandler:say("Escute aqui, derrotar algumas amazonas nao ira me convencer. Eu nao te ajudarei em nada a nao ser que voce me mostre que esta do meu lado. Voce por acaso esta entre os criminosos de Umbra?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        elseif storage == 2 then
            npcHandler:say("Voce deve abrir a caixa utilizando um {lockpick}.", npc, creature)
            npcHandler:setTopic(playerId, 5)
        elseif storage == 3 then
            npcHandler:say("HA!! Voce conseguiu. Eu sabia que aquele idiota entregaria o lock pick a um desconhecido... Aquele imprestavel... Mas, como eu disse, isso nao basta. \z
            Prove que voce esta entre nos e aproveite a oportunidade para roubar das amazonas! Rapido! Abra a caixa trancada que esta dentro do deposito e me diga o que tem dentro.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 4 then
            npcHandler:say("Voce conseguiu? Ok, ok... Entao prove me respondendo: o que havia dentro da caixa?", npc, creature)
            npcHandler:setTopic(playerId, 3)
        elseif storage == 5 or storage == 6 then
            npcHandler:say("Consiga outro lock pick e me ajude a abrir este portao!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 7 then
            npcHandler:say("HA HA HA!! Sinto muito, mas eu ja sabia que isso aconteceria. HA HA HA HA... Ok. Me desculpe, eu nao resisti. Mas nao fique com raiva, te ensinarei agora algumas das minhas habilidades com lock picks. \z
            Dessa forma voce podera aproveitar mais oportunidades nas suas hunts arrombando alguns baus. Voce havia falado algo sobre uma missao... Pig, um de meus comparsas, precisa de ajuda. Ele esta em algum lugar de Serpentis, o arquipelago de Chaos. Va ate ele e ajude-o.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso, 8)
            npcHandler:setTopic(playerId, 0)
        elseif storage > 7 and storage < 12 then
            npcHandler:say("Nao posso te ajudar, meu companheiro. Procure por Sr Pig em Chaos e ele vai guiar seus proximos passos!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage >= 12 and storage < 16 then
            npcHandler:say("Sr Pig e Rocket Tank sao os unicos que podem me ajudar agora...", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 16 then
            npcHandler:say("O QUE? Aqueles inuteis... Eles fizeram isso porque tentei aplicar um golpe nos dois imbecis. Ha ha.. Dessa vez eles me pegaram. Nao existe honra entre criminosos, |PLAYERNAME|...", npc, creature)
            npcHandler:setTopic(playerId, 0)
        else
            npcHandler:say("Va embora! Estou cansado de te ver por aqui, me deixe morrer em paz.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "lockpick") then
        if npcHandler:getTopic(playerId) == 2 then
            player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso, 2)
            npcHandler:say("Ah... Sempre me esqueco que lockpicks sao proibidos em Crandoria. Va ate meu encarregado, Tennessee, e compre alguns com ele. Eles nao custam muito caro. Tennessee pode ser encontrado em uma pequena ilha ao norte de Hakata.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 5 then
            npcHandler:say("Ah... Sempre me esqueco que lockpicks sao proibidos em Crandoria. Va ate meu encarregado, Tennessee, e compre alguns com ele. Eles nao custam muito caro. Tennessee pode ser encontrado em uma pequena ilha ao norte de Hakata.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "plate armor") then
        if npcHandler:getTopic(playerId) == 3 then
            if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Riddle) == 3357 then
                npcHandler:say("HAHAHA!! Voce esta certo. Era MINHA plate armor que estava la dentro. Malditas amazonas... Escute, voce me disse a verdade e todos sabem que se voce fosse um de nos teria roubado a armadura para voce. \z 
                Se quiser que eu confie em voce, tera que me tirar daqui utilizando outro lock pick, ou nada feito! Ficarei esperando. Fale comigo apos tentar abrir a cela.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso, 5)
                player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Riddle, 0)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say({"Mentira! HA HA! Como pensei, voce realmente esta do nosso lado. Apenas outro criminoso teria coragem de mentir para mim de forma tao cinica. Bom, voce havia falado algo sobre uma missao, certo?",
                "Antes de sair daqui e desfrutar da minha liberdade, preciso assegurar que as coisas estao tranquilas la fora. Procure por Pig, um dos meus comparsas. Ele se esconde numa caverna proximo de Chaos e sabera o que voce deve fazer a partir daqui.",
                "Como voce me esta se mostrando util, te ensinarei alguns truques com lock picks, assim voce podera desfrutar melhor de outras oportunidades em outros locais. Ate mais!"}, npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso, 8)
                player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Riddle, 0)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "plate legs") then
        if npcHandler:getTopic(playerId) == 3 then
            if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Riddle) == 3557 then
                npcHandler:say("HAHAHA!! Voce esta certo. Era MINHA plate legs que estava la dentro. Malditas amazonas... Escute, voce me disse a verdade e todos sabem que se voce fosse um de nos teria roubado a armadura para voce. \z 
                Se quiser que eu confie em voce, tera que me tirar daqui utilizando outro lock pick, ou nada feito! Ficarei esperando. Fale comigo apos tentar abrir a cela.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso, 5)
                player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Riddle, 0)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say({"Mentira! HA HA! Como pensei, voce realmente esta do nosso lado. Apenas outro criminoso teria coragem de mentir para mim de forma tao cinica. Bom, voce havia falado algo sobre uma missao, certo?",
                    "Antes de sair daqui e desfrutar da minha liberdade, preciso assegurar que as coisas estao tranquilas la fora. Procure por Pig, um dos meus comparsas. Ele se esconde numa caverna proximo de Chaos e sabera o que voce deve fazer a partir daqui.",
                    "Como voce me esta se mostrando util, te ensinarei alguns truques com lock picks, assim voce podera desfrutar melhor de outras oportunidades em outros locais. Ate mais!"}, npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso, 8)
                player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Riddle, 0)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "spike sword") then
        if npcHandler:getTopic(playerId) == 3 then
            if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Riddle) == 3271 then
                npcHandler:say("HAHAHA!! Voce esta certo. Era MINHA spike sword que estava la dentro. Malditas amazonas... Escute, voce me disse a verdade e todos sabem que se voce fosse um de nos teria roubado a armadura para voce. \z 
                Se quiser que eu confie em voce, tera que me tirar daqui utilizando outro lock pick, ou nada feito! Ficarei esperando. Fale comigo apos tentar abrir a cela.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso, 5)
                player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Riddle, 0)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say({"Mentira! HA HA! Como pensei, voce realmente esta do nosso lado. Apenas outro criminoso teria coragem de mentir para mim de forma tao cinica. Bom, voce havia falado algo sobre uma missao, certo?",
                    "Antes de sair daqui e desfrutar da minha liberdade, preciso assegurar que as coisas estao tranquilas la fora. Procure por Pig, um dos meus comparsas. Ele se esconde numa caverna proximo de Chaos e sabera o que voce deve fazer a partir daqui.",
                    "Como voce me esta se mostrando util, te ensinarei alguns truques com lock picks, assim voce podera desfrutar melhor de outras oportunidades em outros locais. Ate mais!"}, npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso, 8)
                player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Riddle, 0)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "fur boots") then
        if npcHandler:getTopic(playerId) == 3 then
            if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Riddle) == 3271 then
                npcHandler:say("HAHAHA!! Voce esta certo. Era MINHA fur boots que estava la dentro. Malditas amazonas... Escute, voce me disse a verdade e todos sabem que se voce fosse um de nos teria roubado a armadura para voce. \z 
                Se quiser que eu confie em voce, tera que me tirar daqui utilizando outro lock pick, ou nada feito! Ficarei esperando. Fale comigo apos tentar abrir a cela.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso, 5)
                player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Riddle, 0)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say({"Mentira! HA HA! Como pensei, voce realmente esta do nosso lado. Apenas outro criminoso teria coragem de mentir para mim de forma tao cinica. Bom, voce havia falado algo sobre uma missao, certo?",
                "Antes de sair daqui e desfrutar da minha liberdade, preciso assegurar que as coisas estao tranquilas la fora. Procure por Pig, um dos meus comparsas. Ele esta na ilha de Chaos e pelo que soube, precisa de ajuda.",
                "Como voce me esta se mostrando util, te ensinarei alguns truques com lock picks, assim voce podera desfrutar melhor de outras oportunidades em outros locais. Ate mais!"}, npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso, 8)
                player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Riddle, 0)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Sera mesmo? Se quer que eu acredite, tera que me provar. Utilize um {lockpick} para abrir uma caixa escondida no deposito das Amazonas, logo ai do lado, e me diga o que tinha la dentro. Aceita a missao?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif npcHandler:getTopic(playerId) == 2 then
            npcHandler:say("Excelente! Estarei esperando.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso, 2)
            npcHandler:setTopic(playerId, 0)
        end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Entao va embora logo!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    end
end



npcHandler:setMessage(MESSAGE_GREET, "Ora, ora... Visitas? Ha ha ha! O que faz aqui?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
