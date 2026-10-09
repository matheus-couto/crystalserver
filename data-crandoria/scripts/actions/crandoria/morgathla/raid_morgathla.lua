local morgathlaRaid = GlobalEvent("morgathlaRaid")
function morgathlaRaid.onThink(interval, lastExecution)

    local storage = Game.getStorageValue("raidMorgathla")
    local chance = math.random(1, 150)

    if storage > 0 then
        return true
    else
        if chance == 1 then
            Game.broadcastMessage("O terrivel Ancient Spawn of Morgathla esta prestes a surgir nas profundezas. Corram para derrota-lo!", MESSAGE_GAME_HIGHLIGHT)
            Game.setStorageValue("raidMorgathla", 1)
            addEvent(function()
                Game.createMonster("Ancient Spawn of Morgathla", Position(33721, 32375, 15))
            end, 60000)
        end
    end
end

morgathlaRaid:interval(7200000)