local statuesPuzzle = Action()

-- Configurações
local statues = {
    A = {uid = 12394, position = Position(4558, 5681, 8), ids = {2060, 2061, 2026, 2059}, initialId = 2061},
    B = {uid = 12395, position = Position(4561, 5681, 8), ids = {2060, 2061, 2026, 2059}, initialId = 2060},
    C = {uid = 12396, position = Position(4564, 5681, 8), ids = {2060, 2061, 2026, 2059}, initialId = 2059},
}

local stonePosition = Position(4561, 5676, 8)
local stoneId = 1841 -- ID da pedra
local resetTime = 30 -- Tempo para a pedra retornar, em segundos

-- Função para obter o próximo ID da estátua com base na rotação
local function rotateStatue(currentId, ids, clockwise, steps)
    steps = steps or 1
    local index = table.find(ids, currentId)
    if not index then return currentId end
    local newIndex = clockwise and (index + steps - 1) % #ids + 1 or (index - steps - 1) % #ids + 1
    return ids[newIndex]
end

-- Função para verificar se todas as estátuas estão alinhadas ao norte
local function areAllStatuesAligned()
    for _, statue in pairs(statues) do
        local tile = Tile(statue.position)
        local currentStatue = tile and tile:getItemById(statue.ids[1])
        if not currentStatue then return false end
    end
    return true
end

-- Função principal ao usar uma estátua
function statuesPuzzle.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local statueConfig = nil

	local stone = Tile(stonePosition):getItemById(stoneId)

	if not stone then
		return false
	end

    -- Identificar qual estátua foi usada
    for _, statue in pairs(statues) do
        if item.uid == statue.uid then
            statueConfig = statue
            break
        end
    end

    if not statueConfig then return false end

    -- Efeitos ao usar cada estátua
    local tileA = Tile(statues.A.position)
    local tileB = Tile(statues.B.position)
    local tileC = Tile(statues.C.position)

    local statueA = tileA and tileA:getTopDownItem()
    local statueB = tileB and tileB:getTopDownItem()
    local statueC = tileC and tileC:getTopDownItem()

    if item.uid == statues.A.uid then
        if statueA then statueA:transform(rotateStatue(statueA:getId(), statues.A.ids, true)) end
        if statueB then statueB:transform(rotateStatue(statueB:getId(), statues.B.ids, false)) end
    elseif item.uid == statues.B.uid then
        if statueA then statueA:transform(rotateStatue(statueA:getId(), statues.A.ids, true, 2)) end
        if statueB then statueB:transform(rotateStatue(statueB:getId(), statues.B.ids, true)) end
        if statueC then statueC:transform(rotateStatue(statueC:getId(), statues.C.ids, false)) end
    elseif item.uid == statues.C.uid then
        if statueA then statueA:transform(rotateStatue(statueA:getId(), statues.A.ids, true)) end
        if statueB then statueB:transform(rotateStatue(statueB:getId(), statues.B.ids, true, 2)) end
        if statueC then statueC:transform(rotateStatue(statueC:getId(), statues.C.ids, true)) end
    end

    -- Verificar se todas as estátuas estão alinhadas ao norte
    if areAllStatuesAligned() then
        local stone = Tile(stonePosition):getItemById(stoneId)
        if stone then 
			stone:remove() 
		end

        -- Agendar retorno da pedra e reset das estátuas
        addEvent(function()
            Game.createItem(stoneId, 1, stonePosition)
            for _, statue in pairs(statues) do
                local tile = Tile(statue.position)
                local currentStatue = tile and tile:getTopDownItem()
                if currentStatue then
                    currentStatue:transform(statue.initialId)
                end
            end
        end, resetTime * 1000)
    end

    return true
end

-- Registrar action
statuesPuzzle:aid(13104)
statuesPuzzle:register()


-- local statuesHoradron = Action()

-- function statuesHoradron.onUse(player, item, fromPosition, target, toPosition, isHotkey)

-- 	local tile1 = Tile(Position(4558, 4681, 8))
-- 	local tile2 = Tile(Position(4561, 4681, 8))
-- 	local tile3 = Tile(Position(4564, 4681, 8))

-- 	local statue1n = tile1:getItemById(2060)
-- 	local statue1e = tile1:getItemById(2061)
-- 	local statue1s = tile1:getItemById(2026)
-- 	local statue1w = tile1:getItemById(2059)
-- 	local statue2n = tile2:getItemById(2060)
-- 	local statue2e = tile2:getItemById(2061)
-- 	local statue2s = tile2:getItemById(2026)
-- 	local statue2w = tile2:getItemById(2059)
-- 	local statue3n = tile3:getItemById(2060)
-- 	local statue3e = tile3:getItemById(2061)
-- 	local statue3s = tile3:getItemById(2026)
-- 	local statue3w = tile3:getItemById(2059)

-- 	if not tile1 or not tile2 or not tile3 then
--         -- player:sendTextMessage(MESSAGE_STATUS_SMALL, "Erro: Uma ou mais tiles estão faltando!")
--         return false
--     end

-- 	if item.uid == 12394 then
-- 		if item.itemid == 2026 then
-- 			item:transform(2061)
-- 			if statue2w then
-- 				statue2w:remove()
-- 				Game.createItem(2062, 1, tile2)
-- 			end
-- 		end
-- 	end
-- end



-- statuesHoradron:aid(13104)
-- statuesHoradron:register()