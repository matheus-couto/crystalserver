local internalNpcName = "Roger Oakson"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 143,
	lookHead = 95,
	lookBody = 77,
	lookLegs = 57,
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

    local timerDefault = player:getStorageValue(Storage.Quest.Crandoria.Lumberjack.DefaultTimer)
    local timeLeft = math.floor((player:getStorageValue(Storage.Quest.Crandoria.Lumberjack.DefaultTimer) - os.time()) / 60)

    local skillLumberjackLevel = player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.LumberjackLevel)

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

    if MsgContains(message, "missao") or MsgContains(message, "mission") then
        if player:getLevel() >= 500 then
            if timerDefault < os.time() then
                if player:getStorageValue(Storage.Quest.Crandoria.Lumberjack.Status) < 1 then
                    npcHandler:say({"Preciso encontrar algumas unidades de um cogumelo chamado Strange Mushrooms para preparar um medicamento para Judith, minha esposa. Ela precisa toma-lo todos os dias.",
                    "Esses cogumelos crescem no interior das arvores desse pomar e ficam em aberturas de troncos mais fracos. Eu mesmo poderia pega-los, mas como sou muito forte acabo estragando os cogumelos ao acertar as arvores com meu machado... Ha ha ha. ",
                    "Te dou permissao para derrubar 5 arvores no pomar em busca dos Strange Mushrooms, qualquer outro recurso que voce conseguir no processo podera vender para minha esposa em nossa loja. Voce aceita essa missao?"}, npc, creature)
                    npcHandler:setTopic(playerId, 1)
                else
                    npcHandler:say("Voce pode cortar ate 5 arvores. Se encontrar Strange Mushrooms de qualidade traga-os para mim e faremos uma {troca} justa.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                end
            else
                npcHandler:say("Voce cortou muitas arvores recentemente. Volte em " ..timeLeft.. " minutos se quiser buscar por mais recursos.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        else
            npcHandler:say("Me desculpe, jovem, mas acho que voce nao tem experiencia suficiente para minha missao. Volta quando tiver nivel 500 ou mais.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "box") then
        npcHandler:say("Te ofereco uma caixa contendo uma recompensa surpresa em troca de 3 de seus Strange Mushrooms. Voce aceita?", npc, creature)
        npcHandler:setTopic(playerId, 3)
    elseif MsgContains(message, "machado especial") then
        npcHandler:say("Ha dois machados capazes de cortar essas arvores: O Ice Hatchet, vendido por Judith em nossa loja, e o Golden Axe, que pode ser forjado na forja do Kradok.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
        if npcHandler:getTopic(playerId) == 1 then
            if player:getItemCount(30283) < 1 and player:getItemCount(29286) < 1 then
                npcHandler:say("Excelente! Pode comecar quando quiser. Mas vejo que voce nao tem uma ferramenta adequada para o trabalho... Essas arvores sao resistentes e exigem um {machado especial} para conseguir corta-las.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Lumberjack.Status, 1)
                player:setStorageValue(Storage.Quest.Crandoria.Lumberjack.Tree, 0)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Excelente! Pode comecar quando quiser. Corte ate 5 das arvores!", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Lumberjack.Tree, 0)
                player:setStorageValue(Storage.Quest.Crandoria.Lumberjack.Status, 1)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 3 then
            if player:getItemCount(31982) < 3 then
                npcHandler:say("Voce nao possui o numero suficiente de Strange Mushrooms. Preciso de pelo menos 3 deles.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            elseif player:getItemCount(31982) >= 3 then
                player:removeItem(31982, 3)
                player:addItem(39710, 1)
                npcHandler:say("Muito obrigado! Aqui esta sua recompensa.", npc, creature)
            end
        end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) and npcHandler:getTopic(playerId) == 1 then
        npcHandler:say("Retorne se mudar de ideia.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. Gostaria de realizar uma rapida {missao} em troca de uma boa recompensa? Se ja tiver alguns Strange Mushrooms com voce, basta me oferecer e te darei uma {box} especial por eles.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
