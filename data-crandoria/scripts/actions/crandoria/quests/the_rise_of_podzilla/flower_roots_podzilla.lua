local rootPos = {
	{ id = 45602, position = Position(6085, 4381, 8) },
	{ id = 45602, position = Position(6091, 4382, 8) },
	{ id = 45602, position = Position(6092, 4397, 8) },
	{ id = 45602, position = Position(6100, 4397, 8) },
	{ id = 45602, position = Position(6105, 4393, 8) },
	{ id = 45604, position = Position(6080, 4405, 8) },
	{ id = 45604, position = Position(6081, 4402, 8) },
	{ id = 45604, position = Position(6076, 4397, 8) },
	{ id = 45604, position = Position(6068, 4395, 8) },
	{ id = 45602, position = Position(6070, 4390, 8) },
	{ id = 45602, position = Position(6079, 4393, 8) },
	{ id = 45602, position = Position(6083, 4391, 8) },
	{ id = 45604, position = Position(6085, 4387, 8) },
}

-- TODO: troque pela storage real que deve ser setada quando todas as raízes sumirem
local questStorage = Storage.Quest.Crandoria.TheRiseOfPodzilla

local flowerRootIsland = Action()

function flowerRootIsland.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	-- Se já foi concluído antes, nem precisa reconferir as posições de novo
	if player:getStorageValue(questStorage) >= 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja eliminou todas as raizes deste local.")
		return true
	end

	local remaining = 0
	for _, root in ipairs(rootPos) do
		local tile = Tile(root.position)
		if tile and tile:getItemById(root.id) then
			remaining = remaining + 1
		end
	end

	if remaining > 0 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ainda ha raizes vivas no local.")
		return true
	end

    if player:getStorageValue(questStorage) == 2 then
	    player:setStorageValue(questStorage, 3)
	    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Todas as raizes foram eliminadas!")
    end
	return true
end

flowerRootIsland:id(45673, 45674, 45675, 45676, 45679, 45680, 45681, 45682)
flowerRootIsland:register()

-- local rootPos = {
--         { id = 45602, position = Position(6085, 4381, 8)},
--         { id = 45602, position = Position(6091, 4382, 8)},
--         { id = 45602, position = Position(6092, 4397, 8)},
--         { id = 45602, position = Position(6100, 4397, 8)},
--         { id = 45602, position = Position(6105, 4393, 8)},
--         { id = 45604, position = Position(6080, 4405, 8)},
--         { id = 45604, position = Position(6081, 4402, 8)},
--         { id = 45604, position = Position(6076, 4397, 8)},
--         { id = 45604, position = Position(6068, 4395, 8)},
--         { id = 45602, position = Position(6070, 4390, 8)},
--         { id = 45602, position = Position(6079, 4393, 8)},
--         { id = 45602, position = Position(6083, 4391, 8)},
--         { id = 45604, position = Position(6085, 4387, 8)},
--     }

-- local flowerRootIsland = Action()

-- function flowerRootIsland.onUse(player, item, fromPosition, target, toPosition, isHotkey)



-- flowerRootIsland:id(45673, 45674, 45675, 45676, 45679, 45680, 45681, 45682)
-- flowerRootIsland:register()