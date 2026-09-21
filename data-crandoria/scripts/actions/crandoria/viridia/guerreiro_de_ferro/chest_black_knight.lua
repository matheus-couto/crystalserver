local creatureNames = {"Black Knight", "Elder Bonelord", "Blood Priest"}

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

	if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso) == 18 then
		if hasCreatureInArea(Position(4531, 5315, 10), Position(4543, 5326, 10), creatureNames) then
			player:say('Derrote todos os monstros antes de coletar os espolios', TALKTYPE_MONSTER_SAY)
			return false
		else
			player:addItem(3057, 1)
			player:addItem(3030, 5)
			player:addItem(3029, 5)
			player:say('Voce encontrou um item valioso', TALKTYPE_MONSTER_SAY)
			player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 19)
			return false
		end
	elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso) > 18 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O bau esta vazio.")
		return false
	else
		return true
	end
end

chestBarthos:uid(12364)
chestBarthos:register()