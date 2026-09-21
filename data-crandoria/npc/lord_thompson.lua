local internalNpcName = "Lord Thompson"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
    lookType = 465,
    lookHead = 0,
    lookBody = 3,
    lookLegs = 3,
    lookFeet = 79,
    lookAddons = 3,
    lookMount = 0
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

    if MsgContains(message, "outfit") then
        npcHandler:say("Are you interested in a new outfit to enhance your appearance and cause fear to those disgusting insects?", npc, creature)
        npcHandler:setTopic(playerId, 1)
    elseif MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 1 then
        npcHandler:say("I can provide you with a mighty outfit. To earn it, you must prove your worth by collecting specific items. Do you accept the challenge?", npc, creature)
        npcHandler:setTopic(playerId, 2)
    elseif MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 2 then
        npcHandler:say("For the outfit, bring me the following items: 10 kollos shell, 25 spitter nose, 20 crawler head plating, 20 waspoid claw, 20 waspoid wings, 15 spidris mandible, and 20 compound eye. Do you accept this challenge?", npc, creature)
        npcHandler:setTopic(playerId, 3)
    elseif MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 3 then
        if player:getItemCount(14077) >= 10 and player:getItemCount(14078) >= 25 and player:getItemCount(14079) >= 20 and player:getItemCount(14080) >= 20 and player:getItemCount(14081, 20) and player:getItemCount(14082) >= 15 and player:getItemCount(14083) >= 20 then
            player:removeItem(14077, 10)
            player:removeItem(14078, 25)
            player:removeItem(14079, 20)
            player:removeItem(14080, 20)
            player:removeItem(14081, 20)
            player:removeItem(14082, 15)
            player:removeItem(14083, 20)
            player:addOutfit(465, 0)
            player:addOutfit(466, 0)
            local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
            player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
            player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
            player:setStorageValue(Storage.Quest.Crandoria.InsectoidOutfit.Outfit, 1)
            npcHandler:say("Impressive! You've proven your valor. Here are your new outfits. Wear them with pride.", npc, creature)
        else
            npcHandler:say("Well, you don't have all the required items yet. Return when you have collected them, and the outfit shall be yours.", npc, creature)
        end
        npcHandler:setTopic(playerId, 0)
    elseif MsgContains(message, "no") then
        npcHandler:say("Come back when you're ready to face the challenge and earn the new outfits.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    elseif MsgContains(message, "addon") then
        local outfitStorage = player:getStorageValue(Storage.Quest.Crandoria.InsectoidOutfit.Outfit)
        if outfitStorage == 1 then
            npcHandler:say("Are you interested in one or two addons to your insectoid outfit?", npc, creature)
            npcHandler:setTopic(playerId, 4)
        else
            npcHandler:say("You must obtain the main outfit first. Come back when you're ready.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif npcHandler:getTopic(playerId) == 4 then
        if MsgContains(message, "yes") then
            local outfitStorage = player:getStorageValue(Storage.Quest.Crandoria.InsectoidOutfit.Outfit)
            if outfitStorage == 1 then
                npcHandler:say("I provide two addons. For the first one I need you to bring me five calopteryx capes. For the second addon, you need four grasshopper legs. Do you want one of these addons?", npc, creature)
                npcHandler:setTopic(playerId, 5)
            else
                npcHandler:say("You must obtain the main outfit first. Come back when you're ready.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif MsgContains(message, "no") then
            npcHandler:say("Come back when you want some improvement!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif npcHandler:getTopic(playerId) == 5 then
        if MsgContains(message, "yes") then
            local outfitStorage = player:getStorageValue(Storage.Quest.Crandoria.InsectoidOutfit.Outfit)
            if outfitStorage == 1 then
                npcHandler:say("What do you have for me: the {calopteryx capes} or the {grasshopper legs}?", npc, creature)
                npcHandler:setTopic(playerId, 6)
            else
                npcHandler:say("You must obtain the main outfit first. Come back when you're ready.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif MsgContains(message, "no") then
            npcHandler:say("Come back when you want some improvement!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif npcHandler:getTopic(playerId) == 6 then
        if MsgContains(message, "calopteryx capes") then
            if player:removeItem(14086, 5) then
                player:addOutfitAddon(465, 1)
                player:addOutfitAddon(466, 1)
                local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                npcHandler:say("Very good! You gained the first addon to the insectoid outfit.", npc, creature)
            else
                npcHandler:say("You don't have enough calopteryx capes.", npc, creature)
            end
        elseif MsgContains(message, "grasshopper legs") then
            if player:removeItem(14087, 4) then
                player:addOutfitAddon(465, 2)
                player:addOutfitAddon(466, 2)
                local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                npcHandler:say("Very good! You gained the second addon to the insectoid outfit.", npc, creature)
            else
                npcHandler:say("You don't have enough grasshopper legs.", npc, creature)
            end
        end
        npcHandler:setTopic(playerId, 0)
    end
    return true
end

npcHandler:setMessage(MESSAGE_GREET, "Greetings, brave warrior! Are you interested in a new {outfit} or some {addon} to help fight the insects?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Farewell. Return when you're prepared for the challenge.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Farewell.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
