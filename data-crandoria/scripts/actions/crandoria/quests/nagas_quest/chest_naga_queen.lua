local chestQueenNaga = Action()

function chestQueenNaga.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 23 then
		player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 24)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Era uma armadilha!!!")
		Game.createMonster("Naga Guard", Position(5815, 4390, 5))
		Game.createMonster("Naga Guard", Position(5823, 4396, 5))
		Game.createMonster("Naga Guard", Position(5817, 4393, 5))
		Game.createMonster("Naga Guard", Position(5826, 4393, 5))
		Game.createMonster("Naga Guard", Position(5821, 4390, 5))
		Game.createMonster("Naga Guard", Position(5822, 4390, 5))
		Game.createMonster("Naga Sentinel", Position(5816, 4394, 5))
		Game.createMonster("Naga Sentinel", Position(5818, 4394, 5))
		Game.createMonster("Naga Sentinel", Position(5821, 4394, 5))
		Game.createMonster("Naga Sentinel", Position(5828, 4393, 5))
		Game.createMonster("Naga Sentinel", Position(5814, 4397, 5))
		Game.createMonster("Naga Sentinel", Position(5815, 4397, 5))
	else
		return false
	end
	return false
end

chestQueenNaga:uid(14501)
chestQueenNaga:register()