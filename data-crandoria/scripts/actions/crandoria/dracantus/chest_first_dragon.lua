local chestFirstDragon = Action()

function chestFirstDragon.onUse(creature, item, fromPosition, target, toPosition, isHotkey)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local storage = player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso)
	local reset = player:getStorageValue(Storage.Quest.Crandoria.Reset.Count)
	local storageReward = player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.Reward)
	local storageNextReward = player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.NextReward)

	local bossConfig = {
    creatureNames = {"The First Dragon"}
	}

	local function hasCreatureInArea(fromPosition, toPosition, creatureNames)
		for x = fromPosition.x, toPosition.x do
			for y = fromPosition.y, toPosition.y do
				local pos = Position(x, y, fromPosition.z)
				local tile = Tile(pos)
				if tile then
					local creature = tile:getTopCreature()
					if creature and table.contains(creatureNames, creature:getName()) then
						return true
					end
				end
			end
		end
		return false
	end

	if not hasCreatureInArea(Position(4547, 5010, 15), Position(4567, 5029, 15), bossConfig.creatureNames) then
		if storage == 10 then
			if storageReward == 1 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce obteve os espolios do Primeiro Dragao e recebeu a montaria Rustwurm.")
				player:setStorageValue(Storage.Quest.U11_02.TheFirstDragon.Reward, 2)
				local container = player:addItem(10326, 1)
				if container then
					container:addItem(3043, 25)
					container:addItem(9099, 1)
					container:addItem(36727, 1)
					container:addItem(36728, 1)
					container:addItem(39707, 1)
				end
				player:addMount(188)
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O bau esta vazio.")
				return true
			end
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "ERRO.")
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Derrote o First Dragon e seus dragoes para acessar seu tesouro.")
	end
	return true

end

chestFirstDragon:aid(13195)
chestFirstDragon:register()
