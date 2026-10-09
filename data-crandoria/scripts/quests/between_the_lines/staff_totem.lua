local staffTotem = Action()
function staffTotem.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    if not player then
        return true
    end

    local storageCount = Game.getStorageValue(GlobalStorage.Crandoria.AzzilonMiniBosses.StaffCount)
    local storageCooldown = Game.getStorageValue(GlobalStorage.Crandoria.AzzilonMiniBosses.TwisterrorTimer)
    local timeNow = os.time()

    if storageCount < 0 then
        storageCount = 0
    end

    if target.itemid == 49407 then
        if target:getPosition() == Position(5086, 4194, 9) then
            if storageCooldown > timeNow then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O ritual so pode ser realizado a cada 1 hora. Por favor, aguarde.")
                return true
            else
                if storageCount < 9 then
                    item:remove(1)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce usou um Spellreaper Staff Totem como sacrificio no Altar.")
                    Game.setStorageValue(GlobalStorage.Crandoria.AzzilonMiniBosses.StaffCount, storageCount + 1)
                    return true
                else
                    Game.setStorageValue(GlobalStorage.Crandoria.AzzilonMiniBosses.StaffCount, 0)
                    Game.setStorageValue(GlobalStorage.Crandoria.AzzilonMiniBosses.TwisterrorTimer, timeNow + 60 * 60)
                    player:say('Voce sente uma aura maligna se aproximando.', TALKTYPE_MONSTER_SAY)
                    addEvent(function()
                        local boss = Game.createMonster("Twisterror", Position(5087, 4193, 9))
                        Game.createMonster("Spellreaper Inferniarch", Position(5084, 4195, 9))
                        Game.createMonster("Spellreaper Inferniarch", Position(5088, 4197, 9))
                        Game.createMonster("Spellreaper Inferniarch", Position(5089, 4176, 9))
                        Game.broadcastMessage("Twisterror foi invocado por meio de um Ritual.", MESSAGE_GAME_HIGHLIGHT)
                    end, 10000)
                    addEvent(function()
                        Game.createMonster("Spellreaper Inferniarch", Position(5084, 4195, 9))
                    end, 30000)
                    addEvent(function()
                        Game.createMonster("Spellreaper Inferniarch", Position(5089, 4176, 9))
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

staffTotem:id(50054)
staffTotem:register()