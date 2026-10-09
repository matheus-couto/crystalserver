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
	}

    local bossName2 = {
        "Lord Retro",
        "Demodras",
    }

local function removeMonstersFromArea(area)
    local monsters = Game.getSpectators(Position(5220, 5131, 7), false, false, 7, 7, 5, 5)
    for _, monster in ipairs(monsters) do
        if monster:isMonster() then
            monster:remove()
        end
    end
end

local interval = 7200000

local minibossRaid = GlobalEvent("minibossRaid")
function minibossRaid.onThink(interval, lastExecution)

	local storage = Game.getStorageValue(GlobalStorage.Crandoria.MinibossArena.ArenaTimer)
	local low = 4400
	local high = 12000
	local timeNow = os.time()
	local random = math.random(low, high)

	local bossIndex = math.random(1, #bossName)
    local bossRaid = bossName[bossIndex]

	local bossIndex2 = math.random(1, #bossName2)
    local bossRaid2 = bossName2[bossIndex2]

	if storage < 1 then
		Game.setStorageValue(GlobalStorage.Crandoria.MinibossArena.ArenaTimer, timeNow + random)
	else
		if storage > os.time() then
			return true
		else
			local newTime = math.random(10800, 18000)
			local chanceRate = math.random(1, 150)
			if chanceRate ~= 1 then
				removeMonstersFromArea()
				Game.setStorageValue(GlobalStorage.Crandoria.MinibossArena.ArenaTimer, timeNow + newTime)
				Game.setStorageValue(GlobalStorage.Crandoria.MinibossArena.PlayerCount, 0)
				local monster = Game.createMonster(bossRaid, Position(5225, 5131, 7), true, true)
				if monster then
					Game.broadcastMessage("Um miniboss surgiu na Arena!", MESSAGE_GAME_HIGHLIGHT)
				end
			else
				removeMonstersFromArea()
				Game.setStorageValue(GlobalStorage.Crandoria.MinibossArena.ArenaTimer, timeNow + newTime)
				Game.setStorageValue(GlobalStorage.Crandoria.MinibossArena.PlayerCount, 0)
				local monster = Game.createMonster(bossRaid2, Position(5225, 5131, 7), true, true)
				if monster then
					Game.broadcastMessage("Um miniboss surgiu na Arena!", MESSAGE_GAME_HIGHLIGHT)
				end
			end
		end
	end
	return true
end

minibossRaid:interval(interval)
minibossRaid:register()