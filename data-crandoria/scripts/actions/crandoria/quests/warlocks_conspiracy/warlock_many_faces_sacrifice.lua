-- local warlocksAccessTile = MoveEvent()

-- function warlocksAccessTile.onAddItem(moveitem, tileitem, position)
-- 	local stonePosition = {x = 4661, y = 5147, z = 12}
-- 	local removalTime = 180 -- em segundos

-- 	if moveitem.itemid == 33804 then
-- 		moveitem:remove()
-- 		tileitem:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
-- 		Game.createItem(39232, 1, position)

-- 		if Tile(stonePosition):getItemById(1842) then
-- 			Tile(stonePosition):getItemById(1842):remove()
-- 		end
	
-- 		addEvent(function()
-- 			Game.createItem(1842, 1, stonePosition)
-- 		end, removalTime * 1000)  -- Converte o tempo de segundos para milissegundos
-- 		return true
-- 	else
-- 		return true
-- 	end
-- end

-- warlocksAccessTile:type("additem")
-- warlocksAccessTile:uid(12339)
-- warlocksAccessTile:register()


local warlocksAccessTile = MoveEvent()

function warlocksAccessTile.onAddItem(moveitem, tileitem, position, player)
    local stonePosition = {x = 4661, y = 5147, z = 12}
    local removalTime = 180 -- em segundos

    if moveitem.itemid == 33804 then
        -- moveitem:say('Os restos do monstro foram consumidos pela energia do altar. Algo estranho acaba de acontecer...', TALKTYPE_MONSTER_SAY, false, player, position)
        moveitem:remove()
        tileitem:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
        Game.createItem(39232, 1, position)

        if Tile(stonePosition):getItemById(1842) then
            Tile(stonePosition):getItemById(1842):remove()
        end

        addEvent(function()
            -- Remova a chama de ID 39232 quando a pedra 1842 for recolocada
            local stone = Game.createItem(1842, 1, stonePosition)
            if stone then
                -- Verifica se a pedra 1842 foi criada com sucesso antes de remover a chama
                local flame = Tile(Position(4687, 5049, 12)):getItemById(39232)
                if flame then
                    flame:remove()
                end
            end
        end, removalTime * 1000)  -- Converte o tempo de segundos para milissegundos
        return true
    else
        return true
    end
end

warlocksAccessTile:type("additem")
warlocksAccessTile:uid(12339)
warlocksAccessTile:register()