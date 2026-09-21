local taskCreature = CreatureEvent("TaskCreature")

function taskCreature.onKill(player, target)
    if target:isPlayer() or target:getMaster() then
        return true
    end

    local targetName = target:getName():lower()
    local data = getTaskByMonsterName(targetName)
    if not data then
        return true
    end

    local damageMap = target:getDamageMap()
    if not damageMap then
        return true
    end

    for cid, damage in pairs(damageMap) do
        local participant = Player(cid)
        if participant and participant:isPlayer() and participant:hasStartedTask(data.storage) then
            if participant:getStorageValue(10102) >= os.time() then
                participant:addTaskKill(data.storage, 2)
            else
                participant:addTaskKill(data.storage, 1)
            end
        end
    end

    return true
end

taskCreature:register()


-- local taskCreature = CreatureEvent("TaskCreature")

-- function taskCreature.onKill(player, target)
-- 	if target:isPlayer() or target:getMaster() then
-- 		return true
-- 	end

-- 	local targetName = target:getName():lower()
-- 	local data = getTaskByMonsterName(targetName)
-- 	if data ~= false and player:hasStartedTask(data.storage) then
-- 		if player:getStorageValue(10102) >= os.time() then
-- 		player:addTaskKill(data.storage, 2)
-- 		else
-- 		player:addTaskKill(data.storage, 1)
-- 		end
-- 	end
-- 	return true
-- end

-- taskCreature:register()