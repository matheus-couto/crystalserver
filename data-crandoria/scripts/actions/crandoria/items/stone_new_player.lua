local stonePosition = {x = 4994, y = 4996, z = 6}
local stoneActionID = 12350
local originalStoneID = 1791
local transformedStoneID = 1841
local resetTime = 300 -- 5 minutos em segundos

function transformStone()
    local tile = Tile(stonePosition)
    local stone = tile:getItemById(originalStoneID)

    if stone then
        stone:transform(1841)

        addEvent(function()
            local tile = Tile(stonePosition)
            local transformedStone = tile:getItemById(transformedStoneID)

            if transformedStone then
                transformedStone:transform(originalStoneID)
            end
        end, resetTime * 1000)  -- Converte o tempo de segundos para milissegundos
    end
end
local stoneTile = MoveEvent()

function stoneTile.onStepIn(creature, item, position, fromPosition)
    transformStone()
    return true
end


stoneTile:type("stepin")
stoneTile:aid(12350)
stoneTile:register()
