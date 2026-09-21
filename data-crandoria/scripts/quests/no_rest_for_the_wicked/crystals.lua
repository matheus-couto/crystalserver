local crystalNoRestForTheWicked = Action()

function crystalNoRestForTheWicked.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    local storage = player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Questlog)

    local crystal1 = player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Crystal1)
	local crystal2 = player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Crystal2)
	local crystal3 = player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Crystal3)
	local crystal4 = player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Crystal4)

    local pos = item:getPosition()

    if storage == 3 then
        if pos == Position(33811, 32375, 3) then  
            if crystal1 < 1 then
                pos:sendMagicEffect(CONST_ME_HOLYAREA)
                player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Crystal1, 1)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ativou um cristal.")
                return true
            else
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja ativou este cristal.")
                return true
            end
        elseif pos == Position(33859, 32375, 3) then  
            if crystal2 < 1 then
                pos:sendMagicEffect(CONST_ME_HOLYAREA)
                player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Crystal2, 1)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ativou um cristal.")
                return true
            else
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja ativou este cristal.")
                return true
            end
        elseif pos == Position(33859, 32329, 3) then  
            if crystal3 < 1 then
                pos:sendMagicEffect(CONST_ME_HOLYAREA)
                player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Crystal3, 1)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ativou um cristal.")
                return true
            else
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja ativou este cristal.")
                return true
            end
        elseif pos == Position(33811, 32329, 3) then  
            if crystal4 < 1 then
                pos:sendMagicEffect(CONST_ME_HOLYAREA)
                player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Crystal4, 1)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ativou um cristal.")
                return true
            else
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja ativou este cristal.")
                return true
            end
        end
    elseif storage == 6 then
        if pos == Position(5169, 4169, 9) then
            pos:sendMagicEffect(CONST_ME_HOLYAREA)
            player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Questlog, 7)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ativou o cristal. Fale com Lai.")
            return true
        end
    else
        return true
    end

end

crystalNoRestForTheWicked:aid(13212)
crystalNoRestForTheWicked:register()