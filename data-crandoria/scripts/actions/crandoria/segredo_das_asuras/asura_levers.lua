local leverPositions = {
    { position = Position(5202, 4768, 15), actionId = 12365 }, -- Primeira alavanca
    { position = Position(5225, 4768, 15), actionId = 12365 }  -- Segunda alavanca
}

local portalPosition = Position(5213, 4768, 15) -- Posição do portal
local portalDestination = Position(5212, 4763, 15) -- Destino do portal

local function createPortal()
    local portal = Game.createItem(22761, 1, portalPosition)
    portal:setDestination(portalDestination)
    addEvent(function()
        portal:remove()
    end, 15000) -- Remove o portal após 15 segundos
end

local function toggleLever(lever)
    local leverItem = Tile(lever.position):getItemById(2772)
    if leverItem then
        leverItem:transform(leverItem:getId() == 2772 and 2773 or 2772)
        leverItem:setActionId(lever.actionId)
        addEvent(function()
            if leverItem and leverItem:getId() == 2773 then
                leverItem:transform(2772)
            end
        end, 2000) -- Transforma de volta para 2772 após 2 segundos
    end
end

local asuraLevers = Action()

function asuraLevers.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    toggleLever({ position = fromPosition, actionId = item:getActionId() })
    local lever1 = Tile(leverPositions[1].position):getItemById(2773)
    local lever2 = Tile(leverPositions[2].position):getItemById(2773)
    if lever1 and lever2 then
        createPortal()
    end
    return true
end

asuraLevers:aid(12365)
asuraLevers:register()
