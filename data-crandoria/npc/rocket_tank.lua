local internalNpcName = "Rocket Tank, o Ladrao"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 884,
	lookHead = 59,
	lookBody = 114,
	lookLegs = 114,
	lookFeet = 75,
    	lookAddons = 0,
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

    local storage = player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso)

    if MsgContains(message, "rulo") then
        if storage == 13 then
            npcHandler:say({"Entendo... Entao Hidrox foi capturado. Aquele idiota... Ele nao sabe agir de forma discreta. Sempre descuidado e desrespeitoso... Um grande idiota!",
            "Acredito que se ele esta preso foi Sr Pig quem te ajudou a me encontrar aqui, estou certo? Claro que estou... Escute, eu posso te ajudar, mas antes preciso da sua ajuda.",
            "Meu ouro foi perdido na minha ultima fuga e estou completamente miseravel. Traga-me 2 Bars of Gold e eu te ajudarei com isso. Trato feito?"}, npc, creature)
            npcHandler:setTopic(playerId, 1)
        elseif storage == 14 then
            npcHandler:say("Voce trouxe as 2 Bars of Gold?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif storage >= 16 then
            if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Scissors) < 1 then
                npcHandler:say("Voce so pode estar brincando... O que faz aqui? Seu verme insolente! Eu estava prestes a te ensinar a arte do {roubo}. Voce ficaria rico!!!", npc, creature)
                npcHandler:setTopic(playerId, 4)
            elseif player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Scissors) == 1 then
                npcHandler:say("Voce trouxe as 5 Bars of Gold?", npc, creature)
                npcHandler:setTopic(playerId, 5)
            else
                npcHandler:say("Va embora! Nao quero mais ver sua cara na minha frente.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "mission") or MsgContains(message, "missao") then
        if storage == 14 then
            npcHandler:say("Voce trouxe as 2 Bars of Gold?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif storage >= 16 then
            if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Scissors) < 1 then
                npcHandler:say("Voce so pode estar brincando... O que faz aqui? Seu verme insolente! Eu estava prestes a te ensinar a arte do {roubo}. Voce ficaria rico!!!", npc, creature)
                npcHandler:setTopic(playerId, 4)
            elseif player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Scissors) == 1 then
                npcHandler:say("Voce trouxe as 5 Bars of Gold?", npc, creature)
                npcHandler:setTopic(playerId, 5)
            else
                npcHandler:say("Va embora! Nao quero mais ver sua cara na minha frente.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "roubo") then
        if npcHandler:getTopic(playerId) == 4 then
            npcHandler:say("HAHAHA! Ainda quer aprender? Tudo bem, mas voce tera que me trazer 5 Bars of Gold dessa vez. E sem reclamar! Estarei esperando!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Scissors, 1)
            npcHandler:setTopic(playerId, 0)
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Otimo. Estarei esperando!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso, 14)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:removeItem(14112, 2) then
                npcHandler:say({"Ha ha ha! Maravilhoso! Era tudo que eu queria... Escute aqui, |PLAYERNAME|, eu e Sr Pig fomos os responsaveis pela captura de Hidrox. Ele sempre foi um estorvo.",
                "Ele tentou usar nossos tesouros numa troca estranha que, de acordo com ele, multiplicaria tudo o que temos. Mas o imbecil perdeu tudo! Aquele idiota! Que fique preso por um bom tempo.",
                "Mas nao se preocupe. Vou te dar uma boa recompensa. Segure essa tesoura especial. Com ela voce pode cortar as alcas das bolsas de guerreiros desavisados e fugir com suas riquezas. Nao precisa agradecer!"}, npc, creature)
                player:addItem(31327, 1, true)
                player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso, 15)
                player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Scissors, 2)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE,"Use a tesoura em personagens AFK para roubar gold diretamente de suas bps ou do banco. Voce ficara com White Skull ao fazer isso.")
                player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Nao tente enganar um bom ladrao, |PLAYERNAME| ...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 5 then
            if player:removeItem(14112, 5) then
                npcHandler:say("Muito bom... Pelo menos agora tenho algo para usar como suborno para esses malditos guardas de Crandoria... Aqui esta essa tesoura especial. Use-a para cortar as alcas das bolsas de guerreiros distraidos. \z 
                Vai ganhar muito outro com ela, acredite em mim! Ha ha ha ha. Adeus, idiota!", npc, creature)
                player:addItem(31327, 1, true)
                player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Scissors, 2)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Nao tente enganar um bom ladrao, |PLAYERNAME| ...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) then
        if npcHandler:getTopic(playerId) == 1 or npcHandler:getTopic(playerId) == 2 then
            npcHandler:say("Entao o que voce esta fazendo aqui? Nao desperdice meu tempo!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Por favor, nao me incomode.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
