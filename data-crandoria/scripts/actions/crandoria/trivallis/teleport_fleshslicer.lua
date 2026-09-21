local teleport = MoveEvent()
local roomFromPos = Position(5694, 5642, 10)
local roomToPos   = Position(5717, 5662, 10)

local entryPos = Position(5699, 5652, 10)
local exitPos  = Position(5743, 5615, 9)

local kickTime = 15 * 60 * 1000 -- 15 minutos em ms

local bossName = "Fleshslicer"
local bossSpawnPos = Position(5712, 5651, 10)

local function hasPlayerInArea(fromPosition, toPosition)
    for x = fromPosition.x, toPosition.x do
        for y = fromPosition.y, toPosition.y do
            local pos = Position(x, y, fromPosition.z)
            local tile = Tile(pos)
            if tile then
                local creature = tile:getTopCreature()
                if creature and creature:isPlayer() then
                    return true
                end
            end
        end
    end
    return false
end

-- FUNÇÃO PARA REMOVER O JOGADOR APÓS 15 MIN
local function kickPlayer(playerId)
    local player = Player(playerId)
    if not player then
        return
    end

    if player:getPosition():isInRange(roomFromPos, roomToPos) then
        player:teleportTo(exitPos)
        exitPos:sendMagicEffect(CONST_ME_TELEPORT)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Seu tempo acabou e voce foi expulso da sala.")
    end
end

local function removeBossInArea(fromPos, toPos, bossName)
    for x = fromPos.x, toPos.x do
        for y = fromPos.y, toPos.y do
            local tile = Tile(Position(x, y, fromPos.z))
            if tile then
                local creature = tile:getTopCreature()
                if creature and creature:isMonster() then
                    if creature:getName():lower() == bossName:lower() then
                        creature:remove()
                    end
                end
            end
        end
    end
end

function teleport.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if player:getStorageValue(Storage.Quest.Crandoria.Fleshslicer) > os.time() then
        player:teleportTo(fromPosition)
        fromPosition:sendMagicEffect(CONST_ME_POFF)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce deve esperar 20 horas entre cada batalha com Jesse the Wicked.")
        return true
    end

    if hasPlayerInArea(roomFromPos, roomToPos) then
        player:teleportTo(fromPosition)
        fromPosition:sendMagicEffect(CONST_ME_POFF)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Outra luta esta acontecendo neste momento. Aguarde.")
        return true
    end

    player:teleportTo(entryPos)
    player:setStorageValue(Storage.Quest.Crandoria.Fleshslicer, os.time() + 20 * 60 * 60)
    entryPos:sendMagicEffect(CONST_ME_TELEPORT)

    removeBossInArea(config.areaFrom, config.areaTo, config.bossName)
    
    addEvent(function()
        Game.createMonster(bossName, bossSpawnPos, true, true)
    end, 500)

    addEvent(kickPlayer, kickTime, player:getId())

    return true
end

teleport:aid(13187)
teleport:register()