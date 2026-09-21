-- local lever = Action()
-- local removalTime = 30 -- em segundos
-- local canUseLever = true

-- function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
--     local stonePosition = {x = fromPosition.x, y = fromPosition.y, z = fromPosition.z - 2}
--     if player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Outfit) < 1 then
--         if item.itemid == 3514 and canUseLever then
--             if item:getPosition() == Position(5745, 4524, 7) then
--                 Game.createItem(39232, 1, stonePosition)
--                 item:transform(3513)
--                 canUseLever = false
--                 player:sendTextMessage(MESSAGE_INFO_DESCR, "1 CHECK.")
--                 addEvent(function()
--                     item:transform(3514)
--                     Tile(stonePosition):getItemById(39232):remove()
--                     canUseLever = true
--                 end, removalTime * 1000)
--             elseif item:getPosition() == Position(5709, 4489, 7) then
--                 Game.createItem(39232, 1, stonePosition)
--                 item:transform(3513)
--                 canUseLever = false
--                 player:sendTextMessage(MESSAGE_INFO_DESCR, "2 CHECK.")
--                 addEvent(function()
--                     item:transform(3514)
--                     Tile(stonePosition):getItemById(39232):remove()
--                     canUseLever = true
--                 end, removalTime * 1000)
--             elseif item:getPosition() == Position(5718, 4625, 7) then
--                 Game.createItem(39232, 1, stonePosition)
--                 item:transform(3513)
--                 canUseLever = false
--                 player:sendTextMessage(MESSAGE_INFO_DESCR, "3 CHECK.")
--                 addEvent(function()
--                     item:transform(3514)
--                     Tile(stonePosition):getItemById(39232):remove()
--                     canUseLever = true
--                 end, removalTime * 1000)
--             end
--         else
--             player:sendTextMessage(MESSAGE_INFO_DESCR, "FAIL CHECK.")
--             return true
--         end
--     else
--         player:sendTextMessage(MESSAGE_INFO_DESCR, "FAIL CHECK.")
-- 	    return true
--     end
-- end

-- lever:aid(12369)
-- lever:register()


local lever = Action()
local removalTime = 24 * 60 -- em segundos
local canUseLever = true
local canUseLever2 = true
local canUseLever3 = true
local canUseLever4 = true
local canUseLever5 = true
local canUseLever6 = true
local canUseLever7 = true
local canUseLever8 = true
local canUseLever9 = true
local canUseLever10 = true
local canUseLever11 = true
local canUseLever12 = true

function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local stonePosition = {x = fromPosition.x, y = fromPosition.y, z = fromPosition.z - 2}
    if player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Outfit) < 1 then
        if item.itemid == 39444 then
            if player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights) >= os.time() then
                if item:getPosition() == Position(5749, 4503, 7) then
                    if canUseLever then
                        if player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) == 12 then
                            Game.createItem(39232, 1, stonePosition)
                            item:transform(39445)
                            canUseLever = false
                            addEvent(function()
                                item:transform(39444)
                                Tile(stonePosition):getItemById(39232):remove()
                                canUseLever = true
                            end, removalTime * 1000)


                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, 13)
                            player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce acendeu todos os farois no tempo certo. Fale com Yggaro para obter sua recompensa.")
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, 0)

                            -- player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce acendeu um dos farois. Voce tem 5 minutos para acender o proximo.")
                            -- player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, os.time() + 300)
                            -- player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) + 1)
                        else
                            player:sendTextMessage(MESSAGE_INFO_DESCR, "Este deve ser o ultimo farol a ser aceso.")
                        end
                    else
                        player:sendTextMessage(MESSAGE_INFO_DESCR, "O farol ja esta aceso, por favor aguarde para usar novamente.")
                        return true
                    end
                elseif item:getPosition() == Position(5709, 4489, 7) then
                    if canUseLever2 then
                        Game.createItem(39232, 1, stonePosition)
                        item:transform(39445)
                        canUseLever2 = false
                        addEvent(function()
                            item:transform(39444)
                            Tile(stonePosition):getItemById(39232):remove()
                            canUseLever2 = true
                        end, removalTime * 1000)

                        if player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) == 12 then
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, 13)
                            player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce acendeu todos os farois no tempo certo. Fale com Yggaro para obter sua recompensa.")
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, 0)
                        else
                            player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce acendeu um dos farois. Voce tem 5 minutos para acender o proximo.")
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, os.time() + 300)
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) + 1)
                        end
                    else
                        player:sendTextMessage(MESSAGE_INFO_DESCR, "O farol ja esta aceso, por favor aguarde para usar novamente.")
                        return true
                    end
                elseif item:getPosition() == Position(5718, 4625, 7) then
                    if canUseLever3 then
                        Game.createItem(39232, 1, stonePosition)
                        item:transform(39445)
                        canUseLever3 = false
                        addEvent(function()
                            item:transform(39444)
                            Tile(stonePosition):getItemById(39232):remove()
                            canUseLever3 = true
                        end, removalTime * 1000)

                        if player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) == 12 then
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, 13)
                            player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce acendeu todos os farois no tempo certo. Fale com Yggaro para obter sua recompensa.")
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, 0)
                        else
                            player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce acendeu um dos farois. Voce tem 5 minutos para acender o proximo.")
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, os.time() + 300)
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) + 1)
                        end
                    else
                        player:sendTextMessage(MESSAGE_INFO_DESCR, "O farol ja esta aceso, por favor aguarde para usar novamente.")
                        return true
                    end
                elseif item:getPosition() == Position(5648, 4491, 7) then
                    if canUseLever4 then
                        Game.createItem(39232, 1, stonePosition)
                        item:transform(39445)
                        canUseLever4 = false
                        addEvent(function()
                            item:transform(39444)
                            Tile(stonePosition):getItemById(39232):remove()
                            canUseLever4 = true
                        end, removalTime * 1000)

                        if player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) == 12 then
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, 13)
                            player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce acendeu todos os farois no tempo certo. Fale com Yggaro para obter sua recompensa.")
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, 0)
                        else
                            player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce acendeu um dos farois. Voce tem 5 minutos para acender o proximo.")
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, os.time() + 300)
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) + 1)
                        end
                    else
                        player:sendTextMessage(MESSAGE_INFO_DESCR, "O farol ja esta aceso, por favor aguarde para usar novamente.")
                        return true
                    end
                elseif item:getPosition() == Position(5579, 4506, 6) then
                    if canUseLever5 then
                        Game.createItem(39232, 1, stonePosition)
                        item:transform(39445)
                        canUseLever5 = false
                        addEvent(function()
                            item:transform(39444)
                            Tile(stonePosition):getItemById(39232):remove()
                            canUseLever5 = true
                        end, removalTime * 1000)

                        if player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) == 12 then
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, 13)
                            player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce acendeu todos os farois no tempo certo. Fale com Yggaro para obter sua recompensa.")
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, 0)
                        else
                            player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce acendeu um dos farois. Voce tem 5 minutos para acender o proximo.")
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, os.time() + 300)
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) + 1)
                        end
                    else
                        player:sendTextMessage(MESSAGE_INFO_DESCR, "O farol ja esta aceso, por favor aguarde para usar novamente.")
                        return true
                    end
                elseif item:getPosition() == Position(5611, 4551, 7) then
                    if canUseLever6 then
                        Game.createItem(39232, 1, stonePosition)
                        item:transform(39445)
                        canUseLever6 = false
                        addEvent(function()
                            item:transform(39444)
                            Tile(stonePosition):getItemById(39232):remove()
                            canUseLever6 = true
                        end, removalTime * 1000)

                        if player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) == 12 then
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, 13)
                            player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce acendeu todos os farois no tempo certo. Fale com Yggaro para obter sua recompensa.")
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, 0)
                        else
                            player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce acendeu um dos farois. Voce tem 5 minutos para acender o proximo.")
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, os.time() + 300)
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) + 1)
                        end
                    else
                        player:sendTextMessage(MESSAGE_INFO_DESCR, "O farol ja esta aceso, por favor aguarde para usar novamente.")
                        return true
                    end
                elseif item:getPosition() == Position(5631, 4594, 7) then
                    if canUseLever7 then
                        Game.createItem(39232, 1, stonePosition)
                        item:transform(39445)
                        canUseLever7 = false
                        addEvent(function()
                            item:transform(39444)
                            Tile(stonePosition):getItemById(39232):remove()
                            canUseLever7 = true
                        end, removalTime * 1000)

                        if player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) == 12 then
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, 13)
                            player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce acendeu todos os farois no tempo certo. Fale com Yggaro para obter sua recompensa.")
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, 0)
                        else
                            player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce acendeu um dos farois. Voce tem 5 minutos para acender o proximo.")
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, os.time() + 300)
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) + 1)
                        end
                    else
                        player:sendTextMessage(MESSAGE_INFO_DESCR, "O farol ja esta aceso, por favor aguarde para usar novamente.")
                        return true
                    end
                elseif item:getPosition() == Position(5808, 4649, 7) then
                    if canUseLever8 then
                        Game.createItem(39232, 1, stonePosition)
                        item:transform(39445)
                        canUseLever8 = false
                        addEvent(function()
                            item:transform(39444)
                            Tile(stonePosition):getItemById(39232):remove()
                            canUseLever8 = true
                        end, removalTime * 1000)

                        if player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) == 12 then
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, 13)
                            player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce acendeu todos os farois no tempo certo. Fale com Yggaro para obter sua recompensa.")
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, 0)
                        else
                            player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce acendeu um dos farois. Voce tem 5 minutos para acender o proximo.")
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, os.time() + 300)
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) + 1)
                        end
                    else
                        player:sendTextMessage(MESSAGE_INFO_DESCR, "O farol ja esta aceso, por favor aguarde para usar novamente.")
                        return true
                    end
                elseif item:getPosition() == Position(5776, 4508, 7) then
                    if canUseLever9 then
                        Game.createItem(39232, 1, stonePosition)
                        item:transform(39445)
                        canUseLever9 = false
                        addEvent(function()
                            item:transform(39444)
                            Tile(stonePosition):getItemById(39232):remove()
                            canUseLever9 = true
                        end, removalTime * 1000)

                        if player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) == 12 then
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, 13)
                            player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce acendeu todos os farois no tempo certo. Fale com Yggaro para obter sua recompensa.")
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, 0)
                        else
                            player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce acendeu um dos farois. Voce tem 5 minutos para acender o proximo.")
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, os.time() + 300)
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) + 1)
                        end
                    else
                        player:sendTextMessage(MESSAGE_INFO_DESCR, "O farol ja esta aceso, por favor aguarde para usar novamente.")
                        return true
                    end
                elseif item:getPosition() == Position(5900, 4611, 7) then
                    if canUseLever10 then
                        Game.createItem(39232, 1, stonePosition)
                        item:transform(39445)
                        canUseLever10 = false
                        addEvent(function()
                            item:transform(39444)
                            Tile(stonePosition):getItemById(39232):remove()
                            canUseLever10 = true
                        end, removalTime * 1000)

                        if player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) == 12 then
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, 13)
                            player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce acendeu todos os farois no tempo certo. Fale com Yggaro para obter sua recompensa.")
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, 0)
                        else
                            player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce acendeu um dos farois. Voce tem 5 minutos para acender o proximo.")
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, os.time() + 300)
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) + 1)
                        end
                    else
                        player:sendTextMessage(MESSAGE_INFO_DESCR, "O farol ja esta aceso, por favor aguarde para usar novamente.")
                        return true
                    end
                elseif item:getPosition() == Position(5826, 4528, 7) then
                    if canUseLever11 then
                        Game.createItem(39232, 1, stonePosition)
                        item:transform(39445)
                        canUseLever11 = false
                        addEvent(function()
                            item:transform(39444)
                            Tile(stonePosition):getItemById(39232):remove()
                            canUseLever11 = true
                        end, removalTime * 1000)

                        if player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) == 12 then
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, 13)
                            player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce acendeu todos os farois no tempo certo. Fale com Yggaro para obter sua recompensa.")
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, 0)
                        else
                            player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce acendeu um dos farois. Voce tem 5 minutos para acender o proximo.")
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, os.time() + 300)
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) + 1)
                        end
                    else
                        player:sendTextMessage(MESSAGE_INFO_DESCR, "O farol ja esta aceso, por favor aguarde para usar novamente.")
                        return true
                    end
                elseif item:getPosition() == Position(5905, 4496, 7) then
                    if canUseLever12 then
                        Game.createItem(39232, 1, stonePosition)
                        item:transform(39445)
                        canUseLever12 = false
                        addEvent(function()
                            item:transform(39444)
                            Tile(stonePosition):getItemById(39232):remove()
                            canUseLever12 = true
                        end, removalTime * 1000)

                        if player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) == 12 then
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, 13)
                            player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce acendeu todos os farois no tempo certo. Fale com Yggaro para obter sua recompensa.")
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, 0)
                        else
                            player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce acendeu um dos farois. Voce tem 5 minutos para acender o proximo.")
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, os.time() + 300)
                            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) + 1)
                        end
                    else
                        player:sendTextMessage(MESSAGE_INFO_DESCR, "O farol ja esta aceso, por favor aguarde para usar novamente.")
                        return true
                    end
                end
            elseif player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights) == 0 then
                player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce ja completou a missao dos farois de Nivabi.")
                return true
            else
                player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce nao pode usar esse farol agora. Fale com Yggaro.")
                -- player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, 0)
                -- player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, -1)
                return true
            end
        else
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Envie uma mensagem ao ADM.")
            return true
        end
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce ja realizou essa tarefa.")
	    return true
    end
end

lever:aid(12369)
lever:register()