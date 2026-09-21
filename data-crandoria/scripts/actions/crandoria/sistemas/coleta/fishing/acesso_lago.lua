-- local pescaAcesso = Action()
-- function pescaAcesso.onUse(player, item, fromPosition, target, toPosition, isHotkey)
-- 	if player:getPosition() == Position(5053,5029,7) or player:getPosition() == Position(5053,5030,7) or player:getPosition() == Position(5053,5031,7) then
-- 		player:teleportTo(Position(5051,5030,7))
-- 		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
-- 	elseif player:getPosition() == Position(5051,5029,7) or player:getPosition() == Position(5051,5030,7) or player:getPosition() == Position(5051,5031,7) then
-- 		if player:getStorageValue(Storage.Quest.Crandoria.PescaCustom.Access) > os.time() then
-- 			player:teleportTo(Position(5053,5030,7))
-- 			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
-- 			return true
-- 		else
-- 			player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa comprar um ticket com o Pescador Parrudo para acessar o lago.")
-- 			return true
-- 		end
-- 	end
-- end

-- pescaAcesso:aid(12358)
-- pescaAcesso:register()


local pescaAcesso = Action()

function pescaAcesso.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local playerIP = player:getIp()

    local area1 = {
        fromPosition = {x = 5056, y = 5024, z = 7},
        toPosition = {x = 5067, y = 5027, z = 7}
    }
    local area2 = {
        fromPosition = {x = 5053, y = 5027, z = 7},
        toPosition = {x = 5067, y = 5037, z = 7}
    }

    local function checkIPInArea(area)
        for x = area.fromPosition.x, area.toPosition.x do
            for y = area.fromPosition.y, area.toPosition.y do
                for z = area.fromPosition.z, area.toPosition.z do
                    local position = Position(x, y, z)
                    local tile = Tile(position)
                    if tile then
                        local creatures = tile:getCreatures()
                        for _, creature in ipairs(creatures) do
                            if creature:isPlayer() and creature:getIp() == playerIP and creature ~= player then
                                return true
                            end
                        end
                    end
                end
            end
        end
        return false
    end

    if player:getPosition() == Position(5053,5029,7) or player:getPosition() == Position(5053,5030,7) or player:getPosition() == Position(5053,5031,7) then
        player:teleportTo(Position(5051,5030,7))
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    elseif player:getPosition() == Position(5051,5029,7) or player:getPosition() == Position(5051,5030,7) or player:getPosition() == Position(5051,5031,7) then
        local allowedAccess = true
        -- Verificar se há outros jogadores com o mesmo IP nas áreas
        if checkIPInArea(area1) or checkIPInArea(area2) then
            allowedAccess = false
        end
        if allowedAccess then
            if player:getSkull() == SKULL_NONE then
                if (player:getStorageValue(Storage.Quest.Crandoria.PescaCustom.Access) > os.time() or player:getVipDays() > 0) and player:getSkillLevel(SKILL_FISHING) > 79 then
                    player:teleportTo(Position(5053,5030,7))
                    player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
                    return true
                else
                    player:getPosition():sendMagicEffect(CONST_ME_POFF)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa ter 80 de Fishing e comprar um Ticket com o Dave Johnes para acessar o lago.")
                    return true
                end
            else
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Apenas jogadores sem nenhum nivel de Skull pode acessar o lago.")
                return true
            end
        else
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Apenas um personagem por jogador pode pescar no Lago da Avareza.")
            return false
        end
    end
end

pescaAcesso:aid(12358)
pescaAcesso:register()


