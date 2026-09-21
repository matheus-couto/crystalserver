local internalNpcName = "Vaanuk"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 1591,
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

    if MsgContains(message, "addon") or MsgContains(message, "outfit") then
        if (player:hasOutfit(1598) or player:hasOutfit(1597)) and (player:hasOutfit(1598, 1) or player:hasOutfit(1597, 1)) then
            npcHandler:say("Ha! Bom, bom... Tem primeiro addon, pode pegar segundo. Preciso itens: 3 broken iks faulds, 3 broken iks cuirass e 5 Galhos Santos. \z
            Trazer tudo, ganhar addon! Tem itens?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        else
            npcHandler:say("Ha ha ha... Voce precisa Ancient Aucar Outfit e primeiro addon para obter segundo addon Iks.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
        if npcHandler:getTopic(playerId) == 1 then
            if player:getItemCount(40531) >= 3 and player:getItemCount(40533) >= 3 and player:getItemCount(39137) >= 5 then
                player:removeItem(40531, 3)
                player:removeItem(40533, 3)
                player:removeItem(39137, 5)
                npcHandler:say("Um, dois, tres... Um dois tres... Hum... Certo. Itens aqui. Addon entregue.", npc, creature)
                player:addOutfitAddon(1598, 2)
                player:addOutfitAddon(1597, 2)
                local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Nao itens, nao addon. Precisa 3 broken iks faulds, 3 broken iks cuirass e 5 Galhos Santos.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    end

end


npcHandler:setMessage(MESSAGE_GREET, "Interessar em {addon} de grandes Iks?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
