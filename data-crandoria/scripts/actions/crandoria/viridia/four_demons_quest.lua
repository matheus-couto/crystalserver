-- local fourDemons = Action()

-- function fourDemons.onUse(player, item, fromPosition, target, toPosition, isHotkey)

-- 	local area1 = {
-- 		fromPosition = {x = 4423, y = 5342, z = 4},
-- 		toPosition = {x = 4426, y = 5345, z = 4}
-- 	}

--     local area2 = {
-- 		fromPosition = {x = 4423, y = 5350, z = 4},
-- 		toPosition = {x = 4426, y = 5353, z = 4}
-- 	}

--     local area3 = {
-- 		fromPosition = {x = 4431, y = 5342, z = 4},
-- 		toPosition = {x = 4434, y = 5345, z = 4}
-- 	}

--     local area4 = {
-- 		fromPosition = {x = 4431, y = 5350, z = 4},
-- 		toPosition = {x = 4434, y = 5353, z = 4}
-- 	}


local fourDemons = Action()

-- Função auxiliar para verificar se um dos itens existe em uma área
local function checkItemsInArea(area, itemIds)
    for x = area.fromPosition.x, area.toPosition.x do
        for y = area.fromPosition.y, area.toPosition.y do
            local tile = Tile(Position(x, y, area.fromPosition.z))
            if tile then
                for _, itemId in ipairs(itemIds) do
                    if tile:getItemById(itemId) then
                        return true -- Encontrou o item, pode parar de procurar
                    end
                end
            end
        end
    end
    return false -- Não encontrou nenhum item
end

function fourDemons.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    -- Definindo as áreas
    local area1 = {
        fromPosition = {x = 4423, y = 5342, z = 4},
        toPosition = {x = 4426, y = 5345, z = 4}
    }

    local area2 = {
        fromPosition = {x = 4423, y = 5350, z = 4},
        toPosition = {x = 4426, y = 5353, z = 4}
    }

    local area3 = {
        fromPosition = {x = 4431, y = 5342, z = 4},
        toPosition = {x = 4434, y = 5345, z = 4}
    }

    local area4 = {
        fromPosition = {x = 4431, y = 5350, z = 4},
        toPosition = {x = 4434, y = 5353, z = 4}
    }

    -- Definindo os itens que precisam ser checados
    local requiredItems = {5995, 4097}

    -- Verificando se todos os itens estão presentes em todas as áreas
    if checkItemsInArea(area1, requiredItems) and
       checkItemsInArea(area2, requiredItems) and
       checkItemsInArea(area3, requiredItems) and
       checkItemsInArea(area4, requiredItems) then
        -- Se todos os itens estão presentes, teletransporta o jogador
        player:teleportTo(Position(4429, 5348, 3))
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    else
        return true
    end

    return true
end

fourDemons:aid(13064) -- Troque pelo ActionID correspondente
fourDemons:register()