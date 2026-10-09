	local bossName = {
		"Gorgo",
		"Ice Overlord",
		"Fire Overlord",
		"Energy Overlord",
		"Earth Overlord",
		"Sharptooth",
		"Merikh the Slaughterer",
		"Fahim the Wise",
		"Bruise Payne",
		"Fleshcrawler",
		"Mozradek",
		"Zarabustor",
		"Hatebreeder",
		"Deathbine",
		"Hirintror",
		"Grorlam",
		"The Old Widow",
		"Yakchal",
		"Stonecracker",
		"Kroazur",
		"Irgix the Flimsy",
		"Unaz the Mean",
		"Vok the Freakish",
		"Grand Canon Dominus",
		"Preceptor Lazare",
		"Grand Commander Soeren",
		"Grand Chaplain Gaunder",
		"Mad Mage",
		"Xogixath",
        "Bibby Bloodbath",
        "Diblis the Fair",
        "Grandfather Tridian",
        "Gravelord Oshuran",
        "Warlord Ruzad",
        "Rahemos",
        "The Voice of Ruin",
        "Fleshslicer",
        "Sugar Mommy",
        "Sugar Daddy",
        "Tropical Desolator",
        "Gralvalon",
        "Bragrumol",
        "Clavius",
        "Glooth Fairy",
        "Maw",
		"Bloodback",
		"Darkfang",
		"Sharpclaw",
		"Shadowpelt",
		"Black Vixen",
		"Paiz the Pauperizer",
		"Srezz Yellow Eyes",
		"Utua Stone Sting",
		"Yirkas Blue Scales",
		"Katex Blood Tongue",
        "Lord Retro",
        "Demodras",
	}

local function hasCreatureInArea(fromPosition, toPosition, creatureNames)
    for x = fromPosition.x, toPosition.x do
        for y = fromPosition.y, toPosition.y do
            local pos = Position(x, y, fromPosition.z)
            local tile = Tile(pos)
            if tile then
                local creature = tile:getTopCreature()
                if creature and table.contains(creatureNames, creature:getName()) then
                    return true
                end
            end
        end
    end
    return false
end

local arena = {
	from = Position(5215, 5128, 7),
	to = Position(5229, 5136, 7),  
}

local function isInArena(pos)
	return pos.z == arena.from.z
		and pos.x >= arena.from.x and pos.x <= arena.to.x
		and pos.y >= arena.from.y and pos.y <= arena.to.y
end

-- Verifica se já existe na arena outro jogador com o mesmo IP
local function hasSameIpInArena(player)
	local ip = player:getIp()
	local playerId = player:getId()
	for _, other in ipairs(Game.getPlayers()) do
		if other:getId() ~= playerId and isInArena(other:getPosition()) and other:getIp() == ip then
			return true
		end
	end
	return false
end

local miniBossArena = MoveEvent()

function miniBossArena.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if hasSameIpInArena(player) then
		player:teleportTo(fromPosition)
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce so pode usar um personagem de cada vez para uma batalha na Arena.")
		return true
	end

	local storageFight = Game.getStorageValue(GlobalStorage.Crandoria.MinibossArena.PlayerCount)
    local storageCrassus = player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso)

	if storageFight >= 2 then
		player:teleportTo(fromPosition)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Dois jogadores ja tentaram enfrentar esse boss. Aguarde pela proxima invasao.")
		return true
	else
        if hasCreatureInArea(Position(5214, 5127, 7), Position(5228, 5136, 7), teleportConfig.bossName) then
            player:teleportTo(Position(5214, 5131, 7))
            if storageCrassus == 22 then
                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 23)
            end
            Game.setStorageValue(GlobalStorage.Crandoria.MinibossArena.PlayerCount, storageFight + 1)
            addEvent(function()
                if player then
                    if isPlayerInArea(Position(5214, 5127, 7), Position(5228, 5136, 7)) then
                        player:teleportTo(Position(5213, 5134, 6))
                        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O seu tempo acabou.")
                    end
                end
            end, 1000 * 60 * 10)
        else
            player:teleportTo(fromPosition)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nao ha nenhum miniboss na Arena.")
            return true
        end
		return true
	end
end

miniBossArena:aid(13225)
miniBossArena:register()