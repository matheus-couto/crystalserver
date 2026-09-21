local internalNpcName = "Zynaka"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 1537,
	lookHead = 113,
	lookBody = 6,
	lookLegs = 0,
	lookFeet = 0,
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

    if MsgContains(message, "missao") or MsgContains(message, "mission") or MsgContains(message, "rainha") then
        if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 14 then
            npcHandler:say("Estamos tendo alguns problemas com nosso proprio povo, como voce deve ter notado. Por isso nossa Rainha nao confiara facilmente em voce \z
            Claro, com a ajuda de alguns de nos, que vivemos no palacio, voce podera conseguir tal confianca. Basta mostrar que esta disposto a nos ajudar com o que precisamos. \z
            Gostaria de me ajudar com uma busca?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 15 then
            npcHandler:say("Preciso de 1 Abyssador's Lash, 3 Ancient Leech Bones, 3 Huge Chunk of Crude Iron e 5 Colourful Snail Shells. Voce trouxe todos os itens?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 16 then
            npcHandler:say("Voce ja me ajudou o suficiente. Procure por Nehzzara", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
        if npcHandler:getTopic(playerId) == 1 then
            player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 15)
            npcHandler:say("Muito bem. Voce nao tera muito trabalho com o que preciso no momento. Como a responsavel pelos estudos de alquimia do Palacio, preciso de ingredientes para produzir pocoes. \z
            Saia e traga-me os seguintes itens para que eu possa produzir minhas pocoes: 1 Abyssador's Lash, 1 Ancient Liche Bone, 1 Huge Chunk of Crude Iron e 1 Colourful Snail Shell. \z
            Estarei aguardando pelos itens. Nao volte de maos vazias!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getItemCount(16206) >= 1 and player:getItemCount(31588) >= 1 and player:getItemCount(5892) >= 1 and player:getItemCount(25696) >= 1 then
                player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 16)
                npcHandler:say("Maravilha! Nem acredito que poderei continuar a minha pesquisa. Muito obrigada! Procure por Nehzzara dentro do Palacio. Ela tambem esta precisando de ajuda por aqui. \z
                Aqui, uma modesta recompensa pelo que voce fez por mim. Ate mais!", npc, creature)
                player:removeItem(16206, 1)
                player:removeItem(31588, 1)
                player:removeItem(5892, 1)
                player:removeItem(25696, 1)
                player:addExperience(player:getLevel() * 12000)
                player:addItem(3043, 30)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Acredito que voce tenha se confundido. Preciso de 1 Abyssador's Lash, 1 Ancient Liche Bone, 1 Huge Chunk of Crude Iron e 1 Colourful Snail Shell.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    end

end


npcHandler:setMessage(MESSAGE_GREET, "Ola, humano. Buscando pela {rainha}?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
