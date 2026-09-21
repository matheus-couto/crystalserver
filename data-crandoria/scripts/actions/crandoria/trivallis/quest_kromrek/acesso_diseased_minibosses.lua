local teleport = MoveEvent()

-- =========================
-- CONFIGURAÇÕES GERAIS
-- =========================

local REQUIRED_STORAGE = Storage.Quest.Crandoria.QuestKromrek.Progresso
local REQUIRED_VALUE = 6

local fightTime = 10 * 60 * 1000 -- 10 minutos
local exitPos = Position(5873, 5576, 8)

-- =========================
-- CONFIGURAÇÃO DOS TELEPORTS
-- =========================

local teleportConfigs = {
    [Position(5868, 5577, 8):toString()] = {
        entryPos = Position(5860, 5571, 8),
        bossName = "Diseased Fred",
        bossSpawn = Position(5860, 5571, 8),
        timerStorage = Storage.Quest.Crandoria.QuestKromrek.BossTimer1,
        areaFrom = Position(5841, 5566, 8),
        areaTo   = Position(5859, 5583, 8)
    },

    [Position(5874, 5577, 8):toString()] = {
        entryPos = Position(5868, 5559, 8),
        bossName = "Diseased Dan",
        bossSpawn = Position(5868, 5559, 8),
        timerStorage = Storage.Quest.Crandoria.QuestKromrek.BossTimer2,
        areaFrom = Position(5860, 5555, 8),
        areaTo   = Position(5879, 5571, 8)
    },

    [Position(5880, 5577, 8):toString()] = {
        entryPos = Position(5897, 5575, 8),
        bossName = "Diseased Bill",
        bossSpawn = Position(5897, 5575, 8),
        timerStorage = Storage.Quest.Crandoria.QuestKromrek.BossTimer3,
        areaFrom = Position(5887, 5571, 8),
        areaTo   = Position(5906, 5587, 8)
    }
}

-- =========================
-- FUNÇÕES AUXILIARES
-- =========================

local function hasPlayerInArea(fromPos, toPos)
    for x = fromPos.x, toPos.x do
        for y = fromPos.y, toPos.y do
            local tile = Tile(Position(x, y, fromPos.z))
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

local function kickPlayer(playerId, areaFrom, areaTo)
    local player = Player(playerId)
    if not player then
        return
    end

    if player:getPosition():isInRange(areaFrom, areaTo) then
        player:teleportTo(exitPos)
        exitPos:sendMagicEffect(CONST_ME_TELEPORT)
        player:sendTextMessage(
            MESSAGE_EVENT_ADVANCE,
            "Seu tempo acabou. Você foi expulso da sala."
        )
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

-- =========================
-- TELEPORT
-- =========================

function teleport.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local config = teleportConfigs[position:toString()]
    if not config then
        return true
    end

    -- Progresso da quest
    if player:getStorageValue(REQUIRED_STORAGE) < REQUIRED_VALUE then
        player:teleportTo(fromPosition)
        fromPosition:sendMagicEffect(CONST_ME_POFF)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
        return true
    end

    -- Cooldown
    if player:getStorageValue(config.timerStorage) > os.time() then
        player:teleportTo(fromPosition)
        fromPosition:sendMagicEffect(CONST_ME_POFF)
        player:sendTextMessage(
            MESSAGE_EVENT_ADVANCE,
            "Voce deve aguardar antes de enfrentar este boss novamente."
        )
        return true
    end

    -- Sala ocupada
    if hasPlayerInArea(config.areaFrom, config.areaTo) then
        player:teleportTo(fromPosition)
        fromPosition:sendMagicEffect(CONST_ME_POFF)
        player:sendTextMessage(
            MESSAGE_EVENT_ADVANCE,
            "Outra luta esta acontecendo nesta sala. Aguarde."
        )
        return true
    end

    -- Entrada
    player:teleportTo(config.entryPos)
    config.entryPos:sendMagicEffect(CONST_ME_TELEPORT)

    player:setStorageValue(config.timerStorage, os.time() + (10 * 60))

    removeBossInArea(config.areaFrom, config.areaTo, config.bossName)

    addEvent(function()
        Game.createMonster(config.bossName, config.bossSpawn, true, true)
    end, 500)

    -- Kick após 10 minutos
    addEvent(
        kickPlayer,
        fightTime,
        player:getId(),
        config.areaFrom,
        config.areaTo
    )

    return true
end

teleport:aid(13186)
teleport:register()
