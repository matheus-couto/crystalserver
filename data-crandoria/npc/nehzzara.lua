local internalNpcName = "Nehzzara"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1539,
	lookHead = 0,
	lookBody = 6,
	lookLegs = 55,
	lookFeet = 42,
    	lookAddons = 2,
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
        if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) <= 15 then
            npcHandler:say("Ainda nao sei se posso confiar uma missao a voce...", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 16 then
            npcHandler:say("Zynaka me disse que voce obteve todos os recursos que ela precisava para sua pesquisa... Parece que voce realmente pode surpreender. Mas sera que voce passara em meu desafio? \z
            Eu cuido das preces e de tudo que envolve a espiritualidade no Palacio. Preciso de alguns recursos para realizar um ritual para a Rainha. preste muita atencao! \z
            Traga-me 10 Mad Froth, 10 Blue Pieces of Cloth, 10 Holy Orchids e 10 Ensouled Essences. Com esses itens poderemos realizar o ritual. Por favor, nao demore.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 17)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 17 then
            npcHandler:say("Para o ritual serao necessarios 10 Mad Froth, 10 Blue Pieces of Cloth, 10 Holy Orchids e 10 Ensouled Essences. Voce tem todos os itens?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        end
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
        if npcHandler:getTopic(playerId) == 1 then
            if player:getItemCount(17854) >= 10 and player:getItemCount(5912) >= 10 and player:getItemCount(5922) >= 10 and player:getItemCount(32698) >= 10 then
                player:removeItem(17854, 10)
                player:removeItem(5912, 10)
                player:removeItem(5922, 10)
                player:removeItem(32698, 10)
                player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 18)
                npcHandler:say("Hum... Parece que esta tudo aqui. Muito bem, voce realmente conseguiu. Zynaka me convenceu a te entregar uma recompensa pela ajuda. \z
                Aqui, utilize com sabedoria. Nazhuk, meu irmao, disse que gostaria de falar com voce. Ele esta no salao dos livros magicos. Boa sorte.", npc, creature)
                player:addItem(3043, 40)
                player:addItem(26186, 1)
                player:addExperience(player:getLevel() * 15000)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao tem todos os itens...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    end

end


npcHandler:setMessage(MESSAGE_GREET, "Esta perdido por aqui?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
