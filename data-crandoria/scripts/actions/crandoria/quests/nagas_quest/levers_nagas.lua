local leverNagas = Action()

-- Configurações
local leverIds = {2772, 2773} -- ID das alavancas (normal e puxada)
local stoneId = 1841 -- ID da pedra
local stonePosition = Position(5890, 4394, 9) -- Posição da pedra
local leverPositions = { -- Posições das alavancas
    Position(5844, 4403, 9),
    Position(5863, 4408, 9),
    Position(5881, 4453, 9),
    Position(5932, 4437, 9),
    Position(5911, 4398, 9)
}
local returnTime = 3 * 60 -- Tempo para a pedra voltar (5 minutos)

function checkLevers()
    for _, pos in ipairs(leverPositions) do
        local lever = Tile(pos):getItemById(leverIds[1]) -- Checa se a alavanca está na posição normal
        if lever then
            return false -- Se alguma estiver na posição normal, retorna falso
        end
    end
    return true -- Se todas estiverem puxadas, retorna verdadeiro
end

function restoreStone()
    Game.createItem(stoneId, 1, stonePosition) -- Restaura a pedra
    for _, pos in ipairs(leverPositions) do
        local lever = Tile(pos):getItemById(leverIds[2]) -- Encontra alavancas puxadas
        if lever then
            lever:transform(leverIds[1]) -- Retorna ao estado normal
        end
    end
end

function leverNagas.onUse(player, item, fromPosition, target, toPosition)
    if item.itemid == leverIds[1] then
        item:transform(leverIds[2]) -- Alterna a alavanca para puxada
    else
        item:transform(leverIds[1]) -- Alterna de volta
    end
    
    if checkLevers() then
        local stone = Tile(stonePosition):getItemById(stoneId)
        if stone then
            stone:remove() -- Remove a pedra
            addEvent(restoreStone, returnTime * 1000) -- Agenda a restauração da pedra
        end
    end
    return true
end

leverNagas:aid(13130)
leverNagas:register()