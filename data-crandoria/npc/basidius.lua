local internalNpcName = "Basidius"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookTypeEx = 748,
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

    local experiencia = (player:getLevel() * 250) * (player:getLevel() / 15)
    -- if player:getLevel() > 800 then
    --     experiencia = (player:getLevel() * 1000) * (player:getLevel() / 15)
    -- end

    if MsgContains(message, "recompensa") or MsgContains(message, "recompensas") or MsgContains(message, "reward") then
        npcHandler:say("Para cada vitoria sua na arena, voce recebera um Arena Token. Como forma de recompensar os guerreiros vitoriosos, estou sempre oferecendo algumas recompensas em troca desses Tokens. \z
        Entre as recompensas estao pontos de {experiencia}, uma {montaria} especial e um {outfit} unico. Esta interessado?", npc, creature)
        npcHandler:setTopic(playerId, 1)
    elseif MsgContains(message, "experiencia") or MsgContains(message, "experience") or MsgContains(message, "exp") then
        if player:getStorageValue(Storage.Quest.Crandoria.TibiaClash.BasidiusTimer) < os.time() then
            npcHandler:say("Gostaria de trocar 10 Arena Tokens por pontos de experiencia relativos ao seu nivel atual?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        else
            npcHandler:say("Voce so podera fazer uma troca a cada 24 horas.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "outfit") or MsgContains(message, "addon") then
        npcHandler:say("Por 1000 Arena Tokens na Arena voce podera receber o Outfit Lion of War e seus Addons. Gostaria de trocar seus pontos pelo outfit?", npc, creature)
        npcHandler:setTopic(playerId, 3)
    elseif MsgContains(message, "montaria") or MsgContains(message, "mount") then
        npcHandler:say("Entao voce esta interessado em uma montaria mais veloz e imponente. Claro, posso te oferecer o grandioso Phant por apenas 500 Arena tokens. Esta interessado?", npc, creature)
        npcHandler:setTopic(playerId, 4)
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
        if npcHandler:getTopic(playerId) == 2 then
            if player:removeItem(22720, 10) then
                -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.WinPoints, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.WinPoints) - 10)
                player:setStorageValue(Storage.Quest.Crandoria.TibiaClash.BasidiusTimer, os.time() + 59 * 60 * 24)
                player:addExperience(experiencia)
                npcHandler:say("Como desejar, aqui esta! Aproveite sua experiencia.", npc, creature)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu " .. experiencia .. " pontos de experiencia.")
            else
                npcHandler:say("Voce nao possui os Arena Tokens necessarios para trocar por experiencia.", npc, creature)
            end
        elseif npcHandler:getTopic(playerId) == 3 then
            if player:removeItem(22720, 1000) then
                -- player:setStorageValue(Storage.Quest.Crandoria.TibiaRoyale.WinPoints, player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.WinPoints) - 1000)
                player:addOutfit(1206)
                player:addOutfit(1207)
                player:addOutfitAddon(1206, 1)
                player:addOutfitAddon(1207, 1)
                player:addOutfitAddon(1206, 2)
                player:addOutfitAddon(1207, 2)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu o outfit Lion of War e seus Addons em troca de 1000 pontos de vitoria da Arena.")
                npcHandler:say("Aqui esta! Seu novo Outfit. Agora ninguem podera discordar que voce se tornou mestre de guerra!", npc, creature)
            else
                npcHandler:say("Voce nao possui os Arena Tokens necessarios para trocar pelo outfit.", npc, creature)
            end
        elseif npcHandler:getTopic(playerId) == 4 then
            if player:removeItem(22720, 500) then
                player:addMount(182)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu a montaria Phant em troca de 1000 pontos de vitoria da Arena.")
                npcHandler:say("Aqui esta! Seu novo Outfit. Agora ninguem podera discordar que voce se tornou mestre de guerra!", npc, creature)
            else
                npcHandler:say("Voce nao possui os Arena Tokens necessarios para trocar pela montaria.", npc, creature)
            end
        end
    elseif MsgContains(message, "no") or MsgContains(message, "nao") then
        if npcHandler:getTopic(playerId) == 1 or npcHandler:getTopic(playerId) == 2 or npcHandler:getTopic(playerId) == 3 or npcHandler:getTopic(playerId) == 4 then
            npcHandler:say("Sem problemas, jovem mestre. Me avise se mudar de ideia.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola, jovem mestre de batalhas. Eu sou Basidius, o Espirito da Arena. Posso oferecer {recompensas} em troca dos seus pontos de batalha.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais! Volte sempre que sentir o falta do calor da batalha!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
