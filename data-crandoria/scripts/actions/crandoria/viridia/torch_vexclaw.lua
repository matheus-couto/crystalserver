local torchVexclaw = Action()

function torchVexclaw.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local tilePosition = Position(4429, 5363, 11) -- Corrige a posição
    local tile = Tile(tilePosition) -- Obtém o Tile na posição especificada

    if not tile then
        player:sendCancelMessage("This tile does not exist.")
        return true
    end

    local tileItem = tile:getItemById(18619) -- Verifica se há o item no tile

    if tileItem then
        tileItem:transform(32690) -- Transforma o item
        player:sendCancelMessage("Click!")
        addEvent(function()
            local updatedTile = Tile(tilePosition) -- Recarrega o tile
            if updatedTile then
                local updatedItem = updatedTile:getItemById(32690) -- Verifica o item transformado
                if updatedItem then
		            updatedItem:getposition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
                    updatedItem:transform(18619) -- Reverte a transformação após 10 segundos
                end
            end
        end, 10 * 1000)
    else
        player:sendCancelMessage("The required item is not present on this tile.")
    end

    return true
end


torchVexclaw:aid(13108)
torchVexclaw:register()