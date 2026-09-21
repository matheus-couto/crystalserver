-- local teleportIks = Action()
-- function teleportIks.onUse(player, item, fromPosition, target, toPosition, isHotkey)

-- 	local teleport = Game.createItem(1949, Position(4611, 5362, 6), true, true)

-- 	if teleport and teleport:isTeleport() then
-- 		teleport:setDestination(Position(4530, 5295, 7))
-- 		addEvent(function()
-- 			local tile = Tile(Position(4611, 5362, 6))
-- 			local tp = tile:getItemById(1949)
-- 			--if tp then
-- 			--	tp:remove()
-- 			--end
-- 			teleport:remove()
-- 		end, 15 * 1000)
-- 	end
-- end

-- teleportIks:aid(13064)
-- teleportIks:register()


local teleportIks = Action()

function teleportIks.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    -- Corrigido: cria o item teleport corretamente
    local teleport = Game.createItem(1949, 1, Position(4611, 5362, 6)) -- ID 1387 é o ID padrão para teleport

    if teleport then
        teleport:setDestination(Position(4530, 5295, 7)) -- Define o destino do teleport

        -- Remove o teleport após 15 segundos
        addEvent(function()
            local tile = Tile(Position(4611, 5362, 6))
            if tile then
                local tp = tile:getItemById(1949) -- Verifica o teleport pelo ID correto
                if tp then
                    tp:remove() -- Remove o teleport
                end
            end
        end, 5 * 1000) -- Remove após 5 segundos
    else
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Nao foi possivel criar o teleport.")
    end
end

teleportIks:aid(13066)
teleportIks:register()