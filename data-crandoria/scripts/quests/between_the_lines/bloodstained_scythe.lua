local scytheMalvaroth = Action()
function scytheMalvaroth.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    if not player then
        return true
    end

    local storageCount = Game.getStorageValue(GlobalStorage.Crandoria.AzzilonMiniBosses.ScytheCount)
    local storageCooldown = Game.getStorageValue(GlobalStorage.Crandoria.AzzilonMiniBosses.MalvarothTimer)
    local timeNow = os.time()

    if storageCount < 0 then
        storageCount = 0
    end

    if target.itemid == 49407 then
        if target:getPosition() == Position(5032, 4291, 8) then
            if storageCooldown > timeNow then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O ritual so pode ser realizado a cada 1 hora. Por favor, aguarde.")
                return true
            else
                if storageCount < 9 then
                    item:remove(1)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce usou um Hellhunter Eye como sacrificio no Altar.")
                    Game.setStorageValue(GlobalStorage.Crandoria.AzzilonMiniBosses.ScytheCount, storageCount + 1)
                    return true
                else
                    Game.setStorageValue(GlobalStorage.Crandoria.AzzilonMiniBosses.ScytheCount, 0)
                    Game.setStorageValue(GlobalStorage.Crandoria.AzzilonMiniBosses.MalvarothTimer, timeNow + 60 * 60)
                    player:say('Voce sente uma aura maligna se aproximando.', TALKTYPE_MONSTER_SAY)
                    addEvent(function()
                        local boss = Game.createMonster("Malvaroth", Position(5034, 4293, 8))
                        Game.createMonster("Brinebrute Inferniarch", Position(5034, 4288, 8))
                        Game.createMonster("Brinebrute Inferniarch", Position(5035, 4293, 8))
                        Game.createMonster("Brinebrute Inferniarch", Position(5038, 4291, 8))
                        Game.broadcastMessage("Malvaroth foi invocado por meio de um Ritual.", MESSAGE_GAME_HIGHLIGHT)
                    end, 10000)
                    addEvent(function()
                        Game.createMonster("Brinebrute Inferniarch", Position(5034, 4288, 8))
                        Game.createMonster("Brinebrute Inferniarch", Position(5035, 4293, 8))
                        Game.createMonster("Brinebrute Inferniarch", Position(5038, 4291, 8))
                    end, 30000)
                    addEvent(function()
                        Game.createMonster("Hellhunter Inferniarch", Position(5073, 4198, 10))
                        Game.createMonster("Hellhunter Inferniarch", Position(5068, 4200, 10))
                    end, 60000)
                    addEvent(function()
                        if boss then
                            boss:remove()
                        end
                    end, 10 * 60 * 1000)
                end
            end
        end
    end
    return true
end

scytheMalvaroth:id(50101)
scytheMalvaroth:register()