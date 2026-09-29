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

local function beginRitual(position)
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

    -- Escolhe 1 monstro aleatório da lista filtrada
    local chosen = availableMonsters[math.random(#availableMonsters)]

    -- Cria 3 monstros da MESMA classe
    for i = 1, 3 do
        local spawnPos = Position(
            position.x + math.random(-9, 9),
            position.y + math.random(-10, 10),
            position.z
        )

        Game.createMonster(chosen.name, spawnPos, true, true)
    end

    Game.setStorageValue(GlobalStorage.Crandoria.Ritual.Active, 1)
	Game.setStorageValue(GlobalStorage.Crandoria.Ritual.Progresso, 0)
    position:sendMagicEffect(CONST_ME_MORTAREA)
    return true
end

local altarGrutaAlmas = MoveEvent()

local function sendRitualWindow(player, position)

    local window = ModalWindow{
        title = "Ritual",
        message = "Deseja iniciar um Ritual?"
    }

    window:addButton("Sim", function()
        beginRitual(position)
        Game.createItem(5024, 1, Position(5504, 4641, 15))
		player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points) - 20)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O Ritual foi iniciado!")
    end)

    window:addButton("Nao")

    window:sendToPlayer(player)
end

function altarGrutaAlmas.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local rep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
	local cooldown = Game.getStorageValue(GlobalStorage.Crandoria.Ritual.GrutaAlmasCooldown)
	local active = Game.getStorageValue(GlobalStorage.Crandoria.Ritual.Active)
	local timeLeft = math.floor((Game.getStorageValue(GlobalStorage.Crandoria.Ritual.GrutaAlmasCooldown) - os.time()) / 60)
    local reset = player:getStorageValue(Storage.Quest.Crandoria.Reset.Count)
    local level = player:getLevel()

    if item:getPosition() == Position(5522, 4877, 7) then
        if rep < 100 or player:getStorageValue(Storage.Quest.U12_40.SoulWar.QuestReward) < 1 then
            player:teleportTo(fromPosition)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa possuir Reputacao Ilustre ou superior e ter completado a Soul War para acessar a Gruta das Almas.")
		    return true
        else
            player:teleportTo(Position(5428, 4618, 14))
            return true
        end
    else
        if rep < 20 then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao possui Reputacao o suficiente para iniciar um Ritual.")
            position:sendMagicEffect(CONST_ME_POFF)
            return true
        end

        if cooldown > os.time() then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O altar esta sem forcas para iniciar um novo ritual. Voce deve aguardar por mais "..timeLeft.." minutos..")
            position:sendMagicEffect(CONST_ME_POFF)
            return true
        end

        if active >= 1 then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ha um ritual em andamento.")
            position:sendMagicEffect(CONST_ME_POFF)
            return true
        end

        sendRitualWindow(player, position)
    end

	return true
end

altarGrutaAlmas:aid(13199)
altarGrutaAlmas:register()

-- local altarGrutaAlmas = MoveEvent()

-- function altarGrutaAlmas.onStepIn(creature, item, position, fromPosition)
-- 	local player = creature:getPlayer()
-- 	if not player then
-- 		return true
-- 	end

-- 	local hour = tonumber(os.date("%H"))

-- 	local rep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
-- 	local cooldown = Game.getStorageValue(GlobalStorage.Crandoria.Ritual.GrutaAlmasCooldown)
-- 	local active = Game.getStorageValue(GlobalStorage.Crandoria.Ritual.Active)

-- 	if rep < 50 then
-- 		player:sendTextMessage("Voce nao possui Reputacao o suficiente para iniciar um Ritual.")
-- 		position:sendMagicEffect(CONST_ME_POFF)
-- 		return true
-- 	end

-- 	if cooldown > os.time() then
-- 		player:sendTextMessage("O altar esta sem forcas para iniciar um novo ritual. Voce deve aguardar um pouco mais.")
-- 		position:sendMagicEffect(CONST_ME_POFF)
-- 		return true
-- 	end

-- 	if active >= 1 then
-- 		player:sendTextMessage("Ha um ritual em andamento.")
-- 		position:sendMagicEffect(CONST_ME_POFF)
-- 		return true
-- 	end

-- 	beginRitual(position)
-- 	Game.createItem(5024, 1, Position(5504, 4641, 15))

-- end


-- altarGrutaAlmas:aid(13199)
-- altarGrutaAlmas:register()
