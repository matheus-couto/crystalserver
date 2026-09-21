local teleportConfig = {
		creatureNames = {"Giant Spider"}
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

local parcelEspecial = Action()

function parcelEspecial.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.EntregasEspeciais.Progresso) == 1 then
		if hasCreatureInArea(Position(5535, 5028, 10), Position(5553, 5044, 10), teleportConfig.creatureNames) then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Derrote a Giant Spider para poder abrir o pacote sem que o conteúdo seja destruído.")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			return false
		end
		if player:getFreeCapacity() >= 20 then
			player:addItem(6092, 1)
			player:setStorageValue(Storage.Quest.Crandoria.EntregasEspeciais.Progresso, 2)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce obteve o conteúdo do pacote.")
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa de pelo menos 20 oz de capacidade livre para pegar o item.")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		end
	end
	return true
end

parcelEspecial:uid(14506)
parcelEspecial:register()
