local function removeMonstersInArea(fromPos, toPos)
    for x = fromPos.x, toPos.x do
        for y = fromPos.y, toPos.y do
            for z = fromPos.z, fromPos.z do
                local tile = Tile(Position(x, y, z))
                if tile then
                    local creature = tile:getTopCreature()
                    if creature and creature:isMonster() then
                        creature:remove() -- Remove o monstro da área
                    end
                end
            end
        end
    end
end

local teleportsWicked = MoveEvent()

function teleportsWicked.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player or player:isInGhostMode() then
		return true
	end

    local artheiTimer = player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.ArtheiTimer)
    local lersatioTimer = player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.LersatioTimer)
    local borethTimer = player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.BorethTimer)
    local marzielTimer = player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.MarzielTimer)
    local zevelonTimer = player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.ZevelonTimer)

	local storage = player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.Questline)
    local fromPos
    local toPos

    local pos = item:getPosition()

    if storage < 1 then
        player:sendCancelMessage("Acesso negado.")
        player:teleportTo(fromPosition)
        return true
    end

    if pos == Position(4529, 4273, 1) then
        fromPos = Position(4525, 4271, 0)
        toPos = Position(4534, 4279, 0)
        if hasPlayerInarea(fromPos, toPos) then
            player:sendCancelMessage("Alguem esta enfrentando o boss no momento.")
            player:teleportTo(fromPosition)
            return true
        else
            if artheiTimer < os.time() then
                player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.ArtheiTimer, os.time() + 12 * 60 * 60)
                removeMonstersInArea(fromPos, toPos)
                player:teleportTo(Position(4529, 4277, 0))
                player:sendCancelMessage("Derrote Arthei.")
                Game.createMonster("Arthei", Position(4529, 4273, 0))
                return true
            else
                local timeLeft = math.floor((player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.ArtheiTimer) - os.time()) / 60)
                player:sendCancelMessage("Voce podera enfrentar o boss novamente em "..timeLeft.." minutos.")
                player:teleportTo(fromPosition)
                return true
            end
        end
    elseif pos == Position(4529, 4291, 1) then
        fromPos = Position(4525, 4290, 0)
        toPos = Position(4533, 4297, 0)
        if hasPlayerInarea(fromPos, toPos) then
            player:sendCancelMessage("Alguem esta enfrentando o boss no momento.")
            player:teleportTo(fromPosition)
            return true
        else
            if borethTimer < os.time() then
                player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.BorethTimer, os.time() + 12 * 60 * 60)
                removeMonstersInArea(fromPos, toPos)
                player:teleportTo(Position(4529, 4296, 0))
                player:sendCancelMessage("Derrote Boreth.")
                Game.createMonster("Boreth", Position(4529, 4291, 0))
                return true
            else
                local timeLeft = math.floor((player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.BorethTimer) - os.time()) / 60)
                player:sendCancelMessage("Voce podera enfrentar o boss novamente em "..timeLeft.." minutos.")
                player:teleportTo(fromPosition)
                return true
            end
        end
    elseif pos == Position(4556, 4273, 1) then
        fromPos = Position(4553, 4272, 0)
        toPos = Position(4560, 4279, 0)
        if hasPlayerInarea(fromPos, toPos) then
            player:sendCancelMessage("Alguem esta enfrentando o boss no momento.")
            player:teleportTo(fromPosition)
            return true
        else
            if lersatioTimer < os.time() then
                player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.BorethTimer, os.time() + 12 * 60 * 60)
                removeMonstersInArea(fromPos, toPos)
                player:teleportTo(Position(4556, 4278, 0))
                player:sendCancelMessage("Derrote Lersatio.")
                Game.createMonster("Lersatio", Position(4556, 4273, 0))
                return true
            else
                local timeLeft = math.floor((player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.LersatioTimer) - os.time()) / 60)
                player:sendCancelMessage("Voce podera enfrentar o boss novamente em "..timeLeft.." minutos.")
                player:teleportTo(fromPosition)
                return true
            end
        end
    elseif pos == Position(4556, 4291, 1) then
        fromPos = Position(4553, 4290, 0)
        toPos = Position(4560, 4297, 0)
        if hasPlayerInarea(fromPos, toPos) then
            player:sendCancelMessage("Alguem esta enfrentando o boss no momento.")
            player:teleportTo(fromPosition)
            return true
        else
            if marzielTimer < os.time() then
                player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.MarzielTimer, os.time() + 12 * 60 * 60)
                removeMonstersInArea(fromPos, toPos)
                player:teleportTo(Position(4556, 4296, 0))
                player:sendCancelMessage("Derrote Marziel.")
                Game.createMonster("Marziel", Position(4556, 4291, 0))
                return true
            else
                local timeLeft = math.floor((player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.MarzielTimer) - os.time()) / 60)
                player:sendCancelMessage("Voce podera enfrentar o boss novamente em "..timeLeft.." minutos.")
                player:teleportTo(fromPosition)
                return true
            end
        end
    elseif pos == Position(4542, 4256, 1) then
        fromPos = Position(4538, 4254, 0)
        toPos = Position(4546, 4262, 0)
        if hasPlayerInarea(fromPos, toPos) then
            player:sendCancelMessage("Alguem esta enfrentando o boss no momento.")
            player:teleportTo(fromPosition)
            return true
        else
            if zevelonTimer < os.time() then
                player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.ZevelonTimer, os.time() + 12 * 60 * 60)
                removeMonstersInArea(fromPos, toPos)
                player:teleportTo(Position(4542, 4261, 0))
                player:sendCancelMessage("Derrote Zevelon.")
                Game.createMonster("Zevelon Duskbringer", Position(4542, 4256, 0))
                return true
            else
                local timeLeft = math.floor((player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.ZevelonTimer) - os.time()) / 60)
                player:sendCancelMessage("Voce podera enfrentar o boss novamente em "..timeLeft.." minutos.")
                player:teleportTo(fromPosition)
                return true
            end
        end 
    elseif pos == Position(4545, 4260, 8) then
        if storage >= 2 then
            player:teleportTo(Position(4547, 4260, 8))
            return true
        else
            player:sendCancelMessage("Acesso negado.")
            player:teleportTo(fromPosition)
            return true
        end
    elseif pos == Position(4528, 4290, 7) then
        if storage >= 4 then
            player:teleportTo(Position(4525, 4290, 7))
            return true
        else
            player:sendCancelMessage("Acesso negado.")
            player:teleportTo(fromPosition)
            return true
        end
    elseif pos == Position(4501, 4246, 7) then
        if storage >= 5 then
            player:teleportTo(Position(4500, 4244, 7))
            return true
        else
            player:sendCancelMessage("Acesso negado.")
            player:teleportTo(fromPosition)
            return true
        end
    end

end


teleportsWicked:aid(13214)
teleportsWicked:register()