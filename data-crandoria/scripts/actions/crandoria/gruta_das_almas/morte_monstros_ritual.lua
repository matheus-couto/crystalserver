local monsters = {
    { name = "Bony Sea Devil Ritual", class = 1},
    { name = "Capricious Phantom Ritual", class = 1},
    { name = "Hazardous Phantom Ritual", class = 1},
    { name = "Turbulent Elemental Ritual", class = 1},
    { name = "Cloak of Terror Ritual", class = 2},
    { name = "Courage Leech Ritual", class = 2},
    { name = "Vibrant Phantom Ritual", class = 2},
    { name = "Branchy Crawler Ritual", class = 3},
    { name = "Mould Phantom Ritual", class = 3},
    { name = "Rotten Golem Ritual", class = 3},
    { name = "Distorted Phantom Ritual", class = 4},
    { name = "Druid's Apparition Ritual", class = 4},
    { name = "Sorcerer's Apparition Ritual", class = 4},
    { name = "Knight's Apparition Ritual", class = 4},
    { name = "Paladin's Apparition Ritual", class = 4},
    { name = "Brachiodemon Ritual", class = 5},
    { name = "Infernal Demon Ritual", class = 5},
    { name = "Infernal Phantom Ritual", class = 5},
}

local ritualMonsters = {
    ["Bony Sea Devil Ritual"] = true,
    ["Capricious Phantom Ritual"] = true,
    ["Hazardous Phantom Ritual"] = true,
    ["Turbulent Elemental Ritual"] = true,
    ["Cloak of Terror Ritual"] = true,
    ["Courage Leech Ritual"] = true,
    ["Vibrant Phantom Ritual"] = true,
    ["Branchy Crawler Ritual"] = true,
    ["Mould Phantom Ritual"] = true,
    ["Rotten Golem Ritual"] = true,
    ["Distorted Phantom Ritual"] = true,
    ["Druid's Apparition Ritual"] = true,
    ["Sorcerer's Apparition Ritual"] = true,
    ["Knight's Apparition Ritual"] = true,
    ["Paladin's Apparition Ritual"] = true,
    ["Brachiodemon Ritual"] = true,
    ["Infernal Demon Ritual"] = true,
    ["Infernal Phantom Ritual"] = true
}

local bosses = {
    "Goshnars Megalomania Ritual",
    "Goshnars Greed Ritual",
    "Goshnars Cruelty Ritual",
    "Goshnars Malice Ritual",
    "Goshnars Spite Ritual",
    "Goshnars Hatred Ritual",
}

-- Quantidade de monstros por progresso atingido
local ritualMonsterAmount = {
    [2] = 5,
    [7] = 6,
    [13] = 7,
    [20] = 8,
    [28] = 9,
    [38] = 10,
    [48] = 12,
    [60] = 13,
    [73] = 14,
    [87] = 15,
    [92] = 16,
    [108] = 20,
    [128] = 21,
    [149] = 22,
    [171] = 23,
    [194] = 24,
    [318] = 30,
}

local ritualPosition = Position(5506, 4639, 15)

local function keepRitual()

    local progresso = Game.getStorageValue(GlobalStorage.Crandoria.Ritual.Progresso)
    local amount = ritualMonsterAmount[progresso]

    -- Só cria nova wave se o progresso estiver na tabela
    if not amount then
        return true
    end

    local hour = tonumber(os.date("%H"))
    local selectedClass = nil

    -- Define classe baseada na hora
    if hour >= 4 and hour < 8 then
        selectedClass = 1
    elseif hour >= 8 and hour < 12 then
        selectedClass = 2
    elseif hour >= 12 and hour < 16 then
        selectedClass = 3
    elseif hour >= 16 and hour < 20 then
        selectedClass = 4
    elseif hour >= 20 then
        selectedClass = 5
    end
    -- 00–04 fica nil (qualquer classe)

    -- Filtra monstros válidos
    local availableMonsters = {}

    for i = 1, #monsters do
        if not selectedClass or monsters[i].class == selectedClass then
            table.insert(availableMonsters, monsters[i])
        end
    end

    if #availableMonsters == 0 then
        return false
    end

    -- Escolhe 1 monstro aleatório da classe válida
    local chosen = availableMonsters[math.random(#availableMonsters)]

    -- Cria a nova wave
    for i = 1, amount do

        -- Escolhe um monstro aleatório da classe válida A CADA SPAWN
        local chosen = availableMonsters[math.random(#availableMonsters)]

        local spawnPos = Position(
            ritualPosition.x + math.random(-9, 9),
            ritualPosition.y + math.random(-10, 10),
            ritualPosition.z
        )

        local monster = Game.createMonster(chosen.name, spawnPos, true, true)
    end

    ritualPosition:sendMagicEffect(CONST_ME_MORTAREA)
    return true
end

local ritualCandles = {
    [2]  = Position(5505, 4641, 15),
    [7]  = Position(5506, 4641, 15),
    [13] = Position(5507, 4641, 15),
    [20] = Position(5508, 4641, 15),
    [28] = Position(5508, 4640, 15),
    [38] = Position(5508, 4639, 15),
    [48] = Position(5508, 4638, 15),
    [60] = Position(5508, 4637, 15),
    [73] = Position(5507, 4637, 15),
    [87] = Position(5506, 4637, 15),
    [102] = Position(5505, 4637, 15),
    [118] = Position(5504, 4637, 15),
    [138] = Position(5504, 4638, 15),
    [204] = Position(5504, 4639, 15),
    [228] = Position(5504, 4640, 15),
    [280] = Position(5504, 4641, 15)
}

local function removeAllCandles()
    for _, pos in pairs(ritualCandles) do
        local tile = Tile(pos)
        if tile then
            local item = tile:getItemById(5024)
            if item then
                item:remove()
            end
        end
    end
end

local function spawnRandomBoss()
    local bossName = bosses[math.random(#bosses)]
    local boss = Game.createMonster(bossName, ritualPosition, true, true)
    if boss then
        ritualPosition:sendMagicEffect(CONST_ME_FIREAREA)
    end
end

local ritualSoulDeath = CreatureEvent("ritualSoulDeath")

function ritualSoulDeath.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)

    if not creature or not creature:isMonster() then
        return true
    end

    if Game.getStorageValue(GlobalStorage.Crandoria.Ritual.Active) < 1 then
        return true
    end

    local name = target:getName():lower()
    local progresso = Game.getStorageValue(GlobalStorage.Crandoria.Ritual.Progresso)

    if ritualMonsters[name] then
        if progresso < 257 then
            keepRitual()

            local candlePos = ritualCandles[progresso]
            if candlePos then
                Game.createItem(5024, 1, candlePos)
            end

            Game.setStorageValue(GlobalStorage.Crandoria.Ritual.Progresso, progresso + 1)
        else
            removeAllCandles()
            spawnRandomBoss()
        end
    else
        Game.setStorageValue(GlobalStorage.Crandoria.Ritual.Progresso, 0)
        Game.setStorageValue(GlobalStorage.Crandoria.Ritual.Active, 0)
        Game.setStorageValue(GlobalStorage.Crandoria.Ritual.Timer, os.time() + 4 * 60 * 60)
        
        local damageMap = creature:getMonster():getDamageMap()
        for key, _ in pairs(damageMap) do
            local player = Player(key)
            if player then
                local rep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, rep + 5)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce concluiu o Ritual.")
            end
        end
    end

    return true
end

ritualSoulDeath:register()