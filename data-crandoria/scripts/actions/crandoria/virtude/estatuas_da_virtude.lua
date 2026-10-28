local estatuasVirtude = Action()
function estatuasVirtude.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    if not player then
        return true
    end

    local pos = item:getPosition()
    local playerPos = player:getPosition()

    local storage = player:getStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso)
    local timer = player:getStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Timer)

    local timeNow = os.time()

    local rep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
    if rep < 1 then
        rep = 0
    end

    if storage < 19 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
		return true
    else
        if timer > timeNow then
            local remaining = timer - timeNow
            local hours = math.floor(remaining / 3600)
			local minutes = math.floor((remaining % 3600) / 60)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce deve aguardar "..hour.." horas e "..minutes.." minutos para fazer um novo tributo.")
		    return true
        else
            if pos == Position(5024, 4837, 7) then
                if player:getItemCount(22720) >= 10 then
                    player:removeItem(22720, 10)
                    player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points, rep + 25)
                    playerPos:sendMagicEffect(CONST_ME_AVATAR_APPEAR)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ofereceu um tributo e recebeu +25 pontos de reputacao.")
                    player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Timer, timeNow + 20 * 60 * 60)
                    return true
                else
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa oferecer 10 Arena Tokens para receber a recompensa da Estatua da Honra.")
                    return true
                end
            elseif pos == Position(5026, 4837, 7) then
                if player:getItemCount(22724) >= 10 then
                    player:removeItem(22724, 10)
                    -- Check dust level
                    local dustAmount = 50
                    local finalDustAmount = targetPlayer:getForgeDusts() + dustAmount
                    if finalDustAmount > targetPlayer:getForgeDustLevel() then
                        dustAmount = targetPlayer:getForgeDustLevel() - targetPlayer:getForgeDusts()
                    end
                    player:addForgeDusts(dustAmount)
                    playerPos:sendMagicEffect(CONST_ME_AVATAR_APPEAR)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ofereceu um tributo e recebeu "..dustAmount.." Dusts.")
                    player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Timer, timeNow + 20 * 60 * 60)
                    return true
                else
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa oferecer 10 Astralis Coins para receber a recompensa da Estatua da Honestidade.")
                    return true
                end
            elseif pos == Position(5028, 4837, 7) then
                if rep >= 25 then
                    local stamina = player:getStamina()
                    if stamina >= 2520 then
                        player:sendCancelMessage("Voce ja esta com a Stamina cheia.")
                        return true
                    else
                        player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points, rep - 25)
                        player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Timer, timeNow + 20 * 60 * 60)
                        player:setStamina(math.min(2520, stamina + 120))
                        playerPos:sendMagicEffect(CONST_ME_AVATAR_APPEAR)
                        player:sendCancelMessage("Voce ofereceu um tributo e teve 1 hora da sua stamina recuperada pela Estatua do Sacrificio.")
                        return true
                    end
                else
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa possuir 25 pontos ou mais de Reputacao para oferecer como tributo para receber a recompensa da Estatua do Sacrificio.")
                    return true
                end
            elseif pos == Position(5031, 4837, 7) then
                if player:getItemCount(11682) >= 5 then
                    player:removeItem(11682, 5)
                    player:addPreyCards(3)
                    playerPos:sendMagicEffect(CONST_ME_AVATAR_APPEAR)
                    player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Timer, timeNow + 20 * 60 * 60)
                    player:sendCancelMessage("Voce ofereceu um tributo e obteve 3 Prey Cards como recompensa da Estatua da Coragem.")
                    return true
                else
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa oferecer 5 Dragonfruits como tributo para receber a recompensa da Estatua da Coragem.")
                    return true
                end
            elseif pos == Position(5033, 4837, 7) then
                if player:getBankBalance() >= 5000000 then
                    local storagePalacio = player:getStorageValue(Storage.Quest.Crandoria.DonateRewards.PalacioAccesso)
                    player:removeMoneyBank(5000000)
                    if storagePalacio < timeNow then
                        player:setStorageValue(Storage.Quest.Crandoria.DonateRewards.PalacioAccesso, timeNow + 3 * 24 * 60 * 60)
                    else
                        player:setStorageValue(Storage.Quest.Crandoria.DonateRewards.PalacioAccesso, storagePalacio + 3 * 24 * 60 * 60)
                    end
                    player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Timer, timeNow + 20 * 60 * 60)
                    playerPos:sendMagicEffect(CONST_ME_AVATAR_APPEAR)
                    player:sendCancelMessage("Voce ofereceu um tributo e obteve 3 Dias de Acesso ao Palacio dos Nobres como recompensa da Estatua da Justica.")
                    return true
                else
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa ter 5.000.000 gold coins no banco para oferecer como tributo e receber a recompensa da Estatua da Justica.")
                    return true
                end
            elseif pos == Position(5035, 4837, 7) then
                if player:getItemCount(22723) >= 25 then
                    local currentExpBoostTime = player:getExpBoostStamina()
                    if activeBoost > 0 then
                        player:say('Voce ja possui um Boost ativo.', TALKTYPE_MONSTER_SAY)
                        player:getPosition():sendMagicEffect(CONST_ME_POFF)
                        return true
                    end
                    if player:getExpBoostStamina() < 3 * 60 * 60 then
                        player:removeItem(22723, 25)
                        player:setStoreXpBoost(50)
                        player:setExpBoostStamina(currentExpBoostTime + 30 * 60)
                        player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Timer, timeNow + 20 * 60 * 60)
                        player:say('Sua hora de 50% de bonus de experiencia foi iniciado!', TALKTYPE_MONSTER_SAY)
                        playerPos:sendMagicEffect(CONST_ME_AVATAR_APPEAR)
                        player:sendCancelMessage("Voce ofereceu um tributo e obteve 30 minutos de Xp Boost como recompensa da Estatua da Humildade.")
                        return true
                    else
                        player:say('Voce ja possui mais de tres horas de Xp Boost.', TALKTYPE_MONSTER_SAY)
                        return true
                    end
                else
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa ter 25 Online Tokens no banco para oferecer como tributo e receber a recompensa da Estatua da Humildade.")
                    return true
                end
            end
        end
    end

end

estatuasVirtude:aid(13231)
estatuasVirtude:register()

function Player:sendStatueModalWindow(player, title, message)
    local modal = ModalWindow({
        title = title,
        message = message,
    })

    modal:addButton("Ok", internalConfirm)
    modal:setDefaultEnterButton("Ok")

    modal:sendToPlayer(player)
end


local tilesEstatuas = MoveEvent()

function tilesEstatuas.onStepIn(player, item, position, fromPosition)

    if not player then
        return true
    end

    local pos = item:getPosition()

    local title = "Estatua da Virtude"
    local message = [[  :: Honra ::

    Tributo: 10 Arena Tokens

    Recompensa: +25 Reputacao
    ]]

    if pos == Position(5026, 4838, 7) then
        message = [[    :: Honestidade ::

    Tributo: 10 Astralis Coins

    Recompensa: +50 Dusts

    Obs: Maximo de dusts = 4600
    ]]
    elseif pos == Position(5028, 4838, 7) then
        message = [[    :: Sacrificio ::

    Tributo: -25 Reputacao

    Recompensa: +1h Stamina
    ]] 
    elseif pos == Position(5031, 4838, 7) then
        message = [[    :: Coragem ::

    Tributo: 5 Dragonfruit

    Recompensa: +3 Prey Cards
    ]] 
    elseif pos == Position(5033, 4838, 7) then
        message = [[    :: Justica ::

    Tributo: 5.000.000 gold coins

    Recompensa: +3 Dias no Palacio dos Nobres
    ]] 
    elseif pos == Position(5035, 4838, 7) then
        message = [[    :: Humildade ::

    Tributo: 25 Online Tokens

    Recompensa: +30 min. Xp Boost

    Obs: Nao pode possuir Boost Ativo.
    ]] 
    end
		
    player:sendStatueModalWindow(player, title, message)

end

tilesEstatuas:aid(13232)
tilesEstatuas:register()