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

local forgeEldritch = Action()
function forgeEldritch.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso) >= 10 then
		if item.actionid == 13051 then
			if item.itemid == 1642 then
				player:teleportTo(toPosition, true)
				item:transform(item.itemid + 1)
				if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso) == 10 then
					if not hasCreatureInArea(Position(4509, 5309, 7), Position(4516, 5313, 7), creatureNames) then
						if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Timer) < os.time() then
							Game.createMonster("Demon Skeleton", Position(4510, 5310, 7), false, true)
							Game.createMonster("Demon Skeleton", Position(4512, 5310, 7), false, true)
							Game.createMonster("Demon Skeleton", Position(4513, 5311, 7), false, true)
							player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Timer, os.time() + 60 * 15)
						end
					end
				end
			elseif item.itemid == 1643 then
				if Creature.checkCreatureInsideDoor(player, toPosition) then
					return true
				end
				if item.itemid == 1643 then
					item:transform(item.itemid - 1)
					return true
				end
			end
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao possui permissao para acessar este local.")
	end
	return true
end

forgeEldritch:aid(13051)
forgeEldritch:register()