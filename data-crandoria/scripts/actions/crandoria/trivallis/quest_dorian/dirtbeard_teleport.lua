local teleport = MoveEvent()
local roomFromPos = Position(5981, 5572, 7)
local roomToPos   = Position(5998, 5582, 7)

local entryPos = Position(5986, 5577, 7)
local exitPos  = Position(5967, 5577, 7)

local kickTime = 15 * 60 * 1000 -- 15 minutos em ms

local bossName = "Dirtbeard"
local bossSpawnPos = Position(5995, 5577, 7)

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
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Seu tempo acabou. Dirtbeard te expulsou do barco.")
    end
end

local function removeBossInArea(fromPosition, toPosition, bossName)
    for x = fromPosition.x, toPosition.x do
        for y = fromPosition.y, toPosition.y do
            local pos = Position(x, y, fromPosition.z)
            local tile = Tile(pos)
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

    if player:getStorageValue(Storage.Quest.U12_60.APiratesTail.DirtbeardTimer) > os.time() then
        player:teleportTo(fromPosition)
        fromPosition:sendMagicEffect(CONST_ME_POFF)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce deve esperar 20 horas entre cada batalha contra Dirtbeard.")
        return true
    end

    if hasPlayerInArea(roomFromPos, roomToPos) then
        player:teleportTo(fromPosition)
        fromPosition:sendMagicEffect(CONST_ME_POFF)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Outra luta esta acontecendo neste momento. Aguarde.")
        return true
    end

    player:teleportTo(entryPos)
    player:setStorageValue(Storage.Quest.U12_60.APiratesTail.DirtbeardTimer, os.time() + 20 * 60 * 60)
    entryPos:sendMagicEffect(CONST_ME_TELEPORT)

    removeBossInArea(roomFromPos, roomToPos, bossName)
    
    addEvent(function()
        Game.createMonster(bossName, bossSpawnPos, true, true)
    end, 500)

    addEvent(kickPlayer, kickTime, player:getId())

    return true
end

teleport:aid(13190)
teleport:register()