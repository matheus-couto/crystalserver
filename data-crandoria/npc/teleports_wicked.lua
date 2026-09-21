local teleportsWicked = MoveEvent()

function teleportsWicked.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player or player:isInGhostMode() then
		return true
	end

    local storage = player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Questlog)
    local storageEssence = player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Essences)
    local storageMageSociety = player:getStorageValue(Storage.Quest.Crandoria.WorldTeleports.Access)
    local storageNillux = player:getStorageValue(Storage.Quest.Crandoria.NilluxQuest.TimerEffect)

    if position == Position(5145, 4305, 8) then
        if storage >= 4 then
            player:teleportTo(Position(5163, 4308, 8))
            return true
        else
            player:teleportTo(fromPosition)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
            return true
        end
    elseif position == Position(5130, 4186, 9) then
        if storage == 6 then
            player:teleportTo(Position(5167, 4194, 9))
            return true
        else
            player:teleportTo(fromPosition)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
            return true
        end
    elseif position == Position(5098, 4247, 10) then
        if storageEssence >= 1600 then
            player:teleportTo(Position(5099, 4250, 11))
            return true
        else
            player:teleportTo(fromPosition)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce deve entregar 1600 essencias ou mais para acessar o proximo andar.")
            return true
        end
    elseif position == Position(5138, 4300, 10) then
        if storage >= 8 then
            player:teleportTo(Position(5068, 4281, 12))
            return true
        else
            player:teleportTo(fromPosition)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
            return true
        end
    elseif position == Position(4602, 4525, 5) then
        if player:getLevel() >= 400 and (storageMageSociety >= 1 or player:isVip() or storageNillux > os.time()) then
            player:teleportTo(5123, 4311, 6)
            return true
        else
            player:teleportTo(fromPosition)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce deve possuir nivel 400 e ser membro da Sociedade dos Magos para acessar este teleport.")
            return true
        end
    end

end


teleportsWicked:aid(13213)
teleportsWicked:register()