local creatureNames = {"Demon Skeleton", "Monk"}

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


local chestBarthos = Action()

function chestBarthos.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso) == 10 then
		if hasCreatureInArea(Position(4509, 5309, 7), Position(4516, 5313, 7), creatureNames) then
			player:say('Derrote os monstros antes de vasculhar pelo local', TALKTYPE_MONSTER_SAY)
			return false
		else
			player:addItem(3456, 1)
			player:addItem(3349, 1)
			player:addItem(3028, 5)
			player:say('Voce encontrou os pertences de Barthos', TALKTYPE_MONSTER_SAY)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou os pertences de Barthos.")
			player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 11)
			return false
		end
	elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso) > 10 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O bau esta vazio.")
		return false
	else
		return true
	end
end

chestBarthos:uid(12363)
chestBarthos:register()