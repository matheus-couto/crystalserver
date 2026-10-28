local fetidHeart = Action()
function fetidHeart.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    if not player then
        return true
    end

    local storage = player:getStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Progresso)
	local storageForsaken = player:getStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Forsaken)

    if storageForsaken < 1 then
        storageForsaken = 0
    end

    if storage < 12 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ainda nao sabe como usar esse item.")
        return true
    else
        local newcount = storageForsaken + 1
        player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Forsaken, newcount)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu mais uma permissao para acessar a Forsaken Crypt. Voce possui um total de " ..newcount.." permissoes de acesso.")
        return true
    end

    

end

fetidHeart:id(52708)
fetidHeart:register()


local crypticFossil = Action()
function crypticFossil.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    if not player then
        return true
    end

    local storage = player:getStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Progresso)
	local storageUnhallowed = player:getStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Unhallowed)

    if storageUnhallowed < 1 then
        storageUnhallowed = 0
    end

    if storage < 12 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ainda nao sabe como usar esse item.")
        return true
    else
        local newcount = storageUnhallowed + 1
        player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Unhallowed, newcount)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu mais uma permissao para acessar a Unhallowed Crypt. Voce possui um total de " ..newcount.." permissoes de acesso.")
        return true
    end

    

end

crypticFossil:id(52709)
crypticFossil:register()



local jadeHeadCrypts = Action()
function jadeHeadCrypts.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    if not player then
        return true
    end

    local storage = player:getStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Progresso)
    local storageForsaken = player:getStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Forsaken)
	local storageUnhallowed = player:getStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Unhallowed)
    local storageDragonHead = player:getStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.JadeHead)

    local timeNow = os.time()
    
    if storageUnhallowed < 1 then
        storageUnhallowed = 0
    end

    if storageForsaken < 1 then
        storageForsaken = 0
    end

    if storage < 13 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ainda nao sabe como usar esse item.")
        return true
    else
        if storageDragonHead > timeNow then
            local timeLeft = 0
            timeLeft = timePrison - timeNow

            days = math.floor(timeLeft / 86400)
            timeLeft = timeLeft % 86400

            hours = math.floor(timeLeft / 3600)
            timeLeft = timeLeft % 3600

            minutes = math.floor(timeLeft / 60)
            local timeLeft = math.floor((player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Timer) - os.time()) / 60)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ainda precisa aguardar "..days.." dias, "..hours.." horas e "..minutes.." minutos para usar o item novamente. Voce atualmente possui permissoes para acessar Forsaken: "..storageForsaken.." e Unhallowed: "..storageHallowed..".")
            player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.JadeHead, timeNow + 14 * 24 * 60 * 60)
            return true
        else
            local newcount1 = storageUnhallowed + 1
            local newcount2 = storageForsaken + 1
            player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Unhallowed, newcount1)
            player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Forsaken, newcount2)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu mais uma permissao para acessar a as criptas. Voce possui um total de " ..newcount2.." permissoes para Forsaken Crypt e " ..newcount1.." permissoes para Unhallowed Crypt.")
            return true
        end
    end

    

end

jadeHeadCrypts:id(52874)
jadeHeadCrypts:register()

