local asuraNikido = TalkAction("nikido")

function asuraNikido.onSay(player, words, param)    

    if player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.Reward) < 1 then
        local tile = player:getPosition():getTile()
        local ground = tile:getGround()
        local actionID = ground:getActionId()
        if actionID == 12368 then
            player:teleportTo(Position(5184, 4636, 15))
            player:say("5", TALKTYPE_MONSTER_SAY)
            addEvent(function() player:say("4", TALKTYPE_MONSTER_SAY) end, 1000)
            addEvent(function() player:say("3", TALKTYPE_MONSTER_SAY) end, 2000)
            addEvent(function() player:say("2", TALKTYPE_MONSTER_SAY) end, 3000)
            addEvent(function() player:say("1", TALKTYPE_MONSTER_SAY) end, 4000)
            addEvent(function() player:teleportTo(Position(5186, 4778, 15)) end, 5000)
        else
            return false
        end
    else
        return false
    end
end


asuraNikido:groupType("normal")
asuraNikido:register()

