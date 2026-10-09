local eyeGralvalon = Action()
function eyeGralvalon.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    if not player then
        return true
    end

    local storageCount = Game.getStorageValue(GlobalStorage.Crandoria.AzzilonMiniBosses.EyeCount)
    local storageCooldown = Game.getStorageValue(GlobalStorage.Crandoria.AzzilonMiniBosses.GralvalonTimer)
    local timeNow = os.time()

    if storageCount < 0 then
        storageCount = 0
    end

    if target.itemid == 49407 then
        if target:getPosition() == Position(5071, 4194, 10) then
            if storageCooldown > timeNow then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O ritual so pode ser realizado a cada 1 hora. Por favor, aguarde.")
                return true
            else
                if storageCount < 9 then
                    item:remove(1)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce usou um Hellhunter Eye como sacrificio no Altar.")
                    Game.setStorageValue(GlobalStorage.Crandoria.AzzilonMiniBosses.EyeCount, storageCount + 1)
                    return true
                else
                    Game.setStorageValue(GlobalStorage.Crandoria.AzzilonMiniBosses.EyeCount, 0)
                    Game.setStorageValue(GlobalStorage.Crandoria.AzzilonMiniBosses.GralvalonTimer, timeNow + 60 * 60)
                    player:say('Voce sente uma aura maligna se aproximando.', TALKTYPE_MONSTER_SAY)
                    addEvent(function()
                        local boss = Game.createMonster("Gralvalon", Position(5070, 4193, 10))
                        Game.createMonster("Hellhunter Inferniarch", Position(5068, 4194, 10))
                        Game.createMonster("Hellhunter Inferniarch", Position(5066, 4196, 10))
                        Game.createMonster("Hellhunter Inferniarch", Position(5073, 4198, 10))
                        Game.createMonster("Hellhunter Inferniarch", Position(5068, 4200, 10))
                        Game.broadcastMessage("Gralvalon foi invocado por meio de um Ritual.", MESSAGE_GAME_HIGHLIGHT)
                    end, 10000)
                    addEvent(function()
                        Game.createMonster("Hellhunter Inferniarch", Position(5068, 4194, 10))
                        Game.createMonster("Hellhunter Inferniarch", Position(5073, 4198, 10))
                        Game.createMonster("Hellhunter Inferniarch", Position(5068, 4200, 10))
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

eyeGralvalon:id(50055)
eyeGralvalon:register()