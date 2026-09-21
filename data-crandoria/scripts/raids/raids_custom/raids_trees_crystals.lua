local raids2 = {
	"Cyclops",
	"Dwarves Guard",
	"Golems",
	"Crystals",
	"Elves",
	"Lions",
	"Undead Chaos",
	"Hunters",
	"OrcWoods",
	"Elves",
	"WaspBear",
	"Badger",
	"Kongras",
	"Tigers",
	"Barbarian",
	"Frost Trolls",
	"Ice Golem",
	"Orcss",
	"Pirates",
	"Priestesses",
	"Warlock",
	"Night Harpy",
	"Ogres",
	"Quaras",
	"Deeplings",
	"Nomad",
	"Scarab",
	"Dragons",
	"Undead Valkesh",
	"Mawhawk",
	"Kroazur",
	"Irgix",
	"Unaz",
	"Vok",
	"Grorlam",
	"Hirintror",
	"Zarabustor",
	"Neferi",
	"Yakchal",
	"Crystal Wolf",
	"Draptor",
    "Suggar Mommy",
	"Hibernal Moth",
	"Piratas One",
	"Piratas Two",
	"Piratas Three",
	"Crustacea Gigantica treasure",
	"Crustacea Gigantica treasure1",
}

local raids3 = {
	"Orobuus",
    "Sugar Daddy",
	"Lacewing Moth",
	"Morgaroth",
	"Orc Backpack",
	"Piratas Four",
	"Hive Overseer",
	"Midnight Panther One",
	"Midnight Panther Two",
	"Midnight Panther Three",
	"Ghazbaran",
	"Orshabaal",
	"Gaz",
	"Omrafir",
	"Raging Mage",
	"Gryphon",
	"Water Buffalo",
	"Wild Horses",
	"Gnarlhounds",
	"Crustacea Gigantica treasure2",
	"Jungle Queen",
	"Giant Beaver",
	"Jaul",
	-- "Feroxa",
	"Giant Beaver",
	"Jungle Queen",
	"Thornfire Wolf",
}

local raids4 = {
	"Horned Fox",
	"Horned Fox",
	"Horned Fox",
	"Horned Fox",
	"Horned Fox",
	"Horned Fox",
	"Horned Fox",
	"Horned Fox",
	"Horned Fox",
	"Horned Fox",
	"Horned Fox",
	"Horned Fox",
	"Horned Fox",
	"Horned Fox",
	-- "Ferumbras",
}

--[[
    Histórico de raids já sorteadas HOJE, só em memória (reseta sozinho quando
    a data muda, e também "reseta de fato" em qualquer reinício do servidor,
    já que é uma tabela local recriada no load do script).
]]
local raidHistory = {
	date = os.date("%Y-%m-%d"),
	used = {},
}

local function resetRaidHistoryIfNewDay()
	local today = os.date("%Y-%m-%d")
	if raidHistory.date ~= today then
		raidHistory.date = today
		raidHistory.used = {}
	end
end

-- Sorteia um nome da lista que ainda não rodou hoje. Se a lista inteira já
-- tiver rodado hoje, libera todas de novo (nunca fica sem opção pra sortear).
local function pickRaidNotUsedToday(raidList)
	resetRaidHistoryIfNewDay()

	local candidates = {}
	for _, name in ipairs(raidList) do
		if not raidHistory.used[name] then
			candidates[#candidates + 1] = name
		end
	end

	if #candidates == 0 then
		candidates = raidList
	end

	local chosen = candidates[math.random(1, #candidates)]
	raidHistory.used[chosen] = true
	return chosen
end

-- NOTA: startRandomRaid() (não incluída aqui) referenciava uma tabela "raids"
-- que não existe em lugar nenhum do arquivo original. Como ela nunca é
-- chamada (a chamada está comentada em raidEvent.onThink), não tirei nem
-- recriei essa função — só deixando registrado que ela está quebrada, caso
-- você queira reativá-la um dia.

local function startRandomRaid2()
	local raidName2 = pickRaidNotUsedToday(raids2)
	Game.startRaid(raidName2)
end

local function startRandomRaid3()
	local raidName3 = pickRaidNotUsedToday(raids3)
	Game.startRaid(raidName3)
end

local function startRandomRaid4()
	local raidName4 = pickRaidNotUsedToday(raids4)
	Game.startRaid(raidName4)
end

local interval1 = math.random(2500000, 3000000)

local raidEvent = GlobalEvent("random raid")
function raidEvent.onThink(interval, lastExecution)
	local chanceHoltten = math.random(1, 100)
	local chance = math.random(1, 10)

	local now = os.date("*t")
	local day = now.day
	local month = now.month
	local hour = now.hour
	local minute = now.minute

	if (day == 12 or day == 13 or day == 14) and hour == 20 and minute < 50 then
		Game.createMonster("Feroxa", Position(4786, 4522, 11))
		Game.broadcastMessage("Feroxa surgiu nas profundezas. Defendam Crandoria do monstro!", MESSAGE_EVENT_ADVANCE)
	end

	if hour < 12 then
		if chanceHoltten == 100 and Game.getStorageValue(GlobalStorage.Crandoria.HolttenQuest.Spawn) < 1 then
			Game.setStorageValue(GlobalStorage.Crandoria.HolttenQuest.Spawn, 1)
			if chance == 1 then
				Game.createNpc("Lord Holtten", Position(4971, 5073, 7))
				Game.broadcastMessage("Lord Holtten esta passando por Crandoria e ficara no navio ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			elseif chance == 2 then
				Game.createNpc("Lord Holtten", Position(4750, 4825, 7))
				Game.broadcastMessage("Lord Holtten esta passando por Elvenshire e ficara no navio ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			elseif chance == 3 then
				Game.createNpc("Lord Holtten", Position(4660, 4572, 7))
				Game.broadcastMessage("Lord Holtten esta passando por Astralis e ficara no navio ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			elseif chance == 4 then
				Game.createNpc("Lord Holtten", Position(5096, 5379, 7))
				Game.broadcastMessage("Lord Holtten esta passando por Icehold e ficara no navio ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			elseif chance == 5 then
				Game.createNpc("Lord Holtten", Position(5335, 4676, 5))
				Game.broadcastMessage("Lord Holtten esta passando por Valkesh e ficara sobre o Depot ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			elseif chance == 6 then
				Game.createNpc("Lord Holtten", Position(5082, 4467, 4))
				Game.broadcastMessage("Lord Holtten esta passando por Chaos e ficara sobre o Depot ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			elseif chance == 7 then
				Game.createNpc("Lord Holtten", Position(4746, 5226, 4))
				Game.broadcastMessage("Lord Holtten esta passando por Magincia e ficara na cidade ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			elseif chance == 8 then
				Game.createNpc("Lord Holtten", Position(5713, 4531, 4))
				Game.broadcastMessage("Lord Holtten esta passando por Nivabi e ficara na cidade ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			elseif chance == 9 then
				Game.createNpc("Lord Holtten", Position(5552, 5122, 7))
				Game.broadcastMessage("Lord Holtten esta passando por Hakata e ficara na cidade ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			elseif chance == 10 then
				Game.createNpc("Lord Holtten", Position(5438, 4475, 9))
				Game.broadcastMessage("Lord Holtten esta passando por Anvillux e ficara na cidade ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			end
		end
	elseif hour >= 12 and hour < 18 then
		if chanceHoltten > 98 and Game.getStorageValue(GlobalStorage.Crandoria.HolttenQuest.Spawn) < 1 then
			Game.setStorageValue(GlobalStorage.Crandoria.HolttenQuest.Spawn, 1)
			if chance == 1 then
				Game.createNpc("Lord Holtten", Position(4971, 5073, 7))
				Game.broadcastMessage("Lord Holtten esta passando por Crandoria e ficara no navio ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			elseif chance == 2 then
				Game.createNpc("Lord Holtten", Position(4750, 4825, 7))
				Game.broadcastMessage("Lord Holtten esta passando por Elvenshire e ficara no navio ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			elseif chance == 3 then
				Game.createNpc("Lord Holtten", Position(4660, 4572, 7))
				Game.broadcastMessage("Lord Holtten esta passando por Astralis e ficara no navio ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			elseif chance == 4 then
				Game.createNpc("Lord Holtten", Position(5096, 5379, 7))
				Game.broadcastMessage("Lord Holtten esta passando por Icehold e ficara no navio ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			elseif chance == 5 then
				Game.createNpc("Lord Holtten", Position(5335, 4676, 5))
				Game.broadcastMessage("Lord Holtten esta passando por Valkesh e ficara sobre o Depot ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			elseif chance == 6 then
				Game.createNpc("Lord Holtten", Position(5082, 4467, 4))
				Game.broadcastMessage("Lord Holtten esta passando por Chaos e ficara sobre o Depot ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			elseif chance == 7 then
				Game.createNpc("Lord Holtten", Position(4746, 5226, 4))
				Game.broadcastMessage("Lord Holtten esta passando por Magincia e ficara na cidade ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			elseif chance == 8 then
				Game.createNpc("Lord Holtten", Position(5713, 4531, 4))
				Game.broadcastMessage("Lord Holtten esta passando por Nivabi e ficara na cidade ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			elseif chance == 9 then
				Game.createNpc("Lord Holtten", Position(5552, 5122, 7))
				Game.broadcastMessage("Lord Holtten esta passando por Hakata e ficara na cidade ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			elseif chance == 10 then
				Game.createNpc("Lord Holtten", Position(5438, 4475, 9))
				Game.broadcastMessage("Lord Holtten esta passando por Anvillux e ficara na cidade ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			end
		end
	elseif hour >= 18 and hour < 21 then
		if chanceHoltten > 90 and Game.getStorageValue(GlobalStorage.Crandoria.HolttenQuest.Spawn) < 1 then
			Game.setStorageValue(GlobalStorage.Crandoria.HolttenQuest.Spawn, 1)
			if chance == 1 then
				Game.createNpc("Lord Holtten", Position(4971, 5073, 7))
				Game.broadcastMessage("Lord Holtten esta passando por Crandoria e ficara no navio ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			elseif chance == 2 then
				Game.createNpc("Lord Holtten", Position(4750, 4825, 7))
				Game.broadcastMessage("Lord Holtten esta passando por Elvenshire e ficara no navio ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			elseif chance == 3 then
				Game.createNpc("Lord Holtten", Position(4660, 4572, 7))
				Game.broadcastMessage("Lord Holtten esta passando por Astralis e ficara no navio ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			elseif chance == 4 then
				Game.createNpc("Lord Holtten", Position(5096, 5379, 7))
				Game.broadcastMessage("Lord Holtten esta passando por Icehold e ficara no navio ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			elseif chance == 5 then
				Game.createNpc("Lord Holtten", Position(5335, 4676, 5))
				Game.broadcastMessage("Lord Holtten esta passando por Valkesh e ficara sobre o Depot ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			elseif chance == 6 then
				Game.createNpc("Lord Holtten", Position(5082, 4467, 4))
				Game.broadcastMessage("Lord Holtten esta passando por Chaos e ficara sobre o Depot ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			elseif chance == 7 then
				Game.createNpc("Lord Holtten", Position(4746, 5226, 4))
				Game.broadcastMessage("Lord Holtten esta passando por Magincia e ficara na cidade ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			elseif chance == 8 then
				Game.createNpc("Lord Holtten", Position(5713, 4531, 4))
				Game.broadcastMessage("Lord Holtten esta passando por Nivabi e ficara na cidade ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			elseif chance == 9 then
				Game.createNpc("Lord Holtten", Position(5552, 5122, 7))
				Game.broadcastMessage("Lord Holtten esta passando por Hakata e ficara na cidade ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			elseif chance == 10 then
				Game.createNpc("Lord Holtten", Position(5438, 4475, 9))
				Game.broadcastMessage("Lord Holtten esta passando por Anvillux e ficara na cidade ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
			end
		end
	end

	return true
end

raidEvent:interval(interval1)
raidEvent:register()

local interval3 = math.random(4000000, 7000000)

local raidEvent2 = GlobalEvent("random raids")
function raidEvent2.onThink(interval, lastExecution)
	local chance = math.random(1, 305)

	if Game.getStorageValue(GlobalStorage.Crandoria.LudenRaid) > os.time() then
		chance = math.random(1, 300)
	end

	if chance < 280 then
		startRandomRaid2()
		return true
	elseif chance >= 280 and chance <= 299 then
		startRandomRaid3()
		return true
	elseif chance == 300 then
		startRandomRaid4()
		return true
	elseif chance > 300 then
		local chanceLuden = math.random(1, 49)
		if chanceLuden == 1 then
			Game.createNpc("Luden", Position(4818, 4523, 2))
			Game.broadcastMessage("Luden foi avistado entrando na fortaleza de Oberon!", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 2 then
			Game.createNpc("Luden", Position(5435, 4846, 9))
			Game.broadcastMessage("Tropas de Valkesh avistaram um mercador misterioso acessando as montanhas.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 3 then
			Game.createNpc("Luden", Position(5092, 4494, 12))
			Game.broadcastMessage("Luden foi visto vagando pela peninsula de Nivabi.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 4 then
			Game.createNpc("Luden", Position(4818, 4483, 7))
			Game.broadcastMessage("Luden foi avistado entrando na fortaleza de Oberon!", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 5 then
			Game.createNpc("Luden", Position(4621, 4562, 9))
			Game.broadcastMessage("Habitantes de Astralis acabam de se despedir de um comerciante de itens raros...", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 6 then
			Game.createNpc("Luden", Position(4659, 4486, 4))
			Game.broadcastMessage("Habitantes de Astralis acabam de se despedir de um comerciante de itens raros...", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 7 then
			Game.createNpc("Luden", Position(4628, 5089, 11))
			Game.broadcastMessage("Corvos de Magincia avistaram um homem carregando diversas riquezas.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 8 then
			Game.createNpc("Luden", Position(4656, 5160, 8))
			Game.broadcastMessage("Corvos de Magincia avistaram um homem carregando diversas riquezas.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 9 then
			Game.createNpc("Luden", Position(4599, 5233, 9))
			Game.broadcastMessage("Corvos de Magincia avistaram um homem carregando diversas riquezas.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 10 then
			Game.createNpc("Luden", Position(4985, 5530, 7))
			Game.broadcastMessage("Relatos de barbaros de Icehold apontam para a presenca de Luden em suas terras.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 11 then
			Game.createNpc("Luden", Position(5147, 5545, 4))
			Game.broadcastMessage("Relatos de barbaros de Icehold apontam para a presenca de Luden em suas terras.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 12 then
			Game.createNpc("Luden", Position(4698, 5468, 9))
			Game.broadcastMessage("Relatos de barbaros de Icehold apontam para a presenca de Luden em suas terras.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 13 then
			Game.createNpc("Luden", Position(5528, 5556, 15))
			Game.broadcastMessage("Luden foi visto explorando a ilha de Ilshenar.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 14 then
			Game.createNpc("Luden", Position(5340, 5476, 11))
			Game.broadcastMessage("Luden foi visto explorando a ilha de Ilshenar.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 15 then
			Game.createNpc("Luden", Position(5788, 5357, 5))
			Game.broadcastMessage("Um mercador misterioso esta explorando Warmwind nesse momento.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 16 then
			Game.createNpc("Luden", Position(5868, 5297, 10))
			Game.broadcastMessage("Um mercador misterioso esta explorando Warmwind nesse momento.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 17 then
			Game.createNpc("Luden", Position(5579, 5215, 14))
			Game.broadcastMessage("Um mercador misterioso esta explorando Warmwind nesse momento.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 18 then
			Game.createNpc("Luden", Position(5943, 4938, 7))
			Game.broadcastMessage("Sentinelas de Roshamuul avistaram um individuo carregando itens raros na ilha.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 19 then
			Game.createNpc("Luden", Position(5855, 5055, 11))
			Game.broadcastMessage("Sentinelas de Roshamuul avistaram um individuo carregando itens raros na ilha.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 20 then
			Game.createNpc("Luden", Position(6019, 4940, 6))
			Game.broadcastMessage("Sentinelas de Roshamuul avistaram um individuo carregando itens raros na ilha.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 21 then
			Game.createNpc("Luden", Position(5989, 5305, 3))
			Game.broadcastMessage("Emissarios do reino relataram a presenca de um viajante transportando artigos de valor em Umbra.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 22 then
			Game.createNpc("Luden", Position(6132, 5301, 8))
			Game.broadcastMessage("Emissarios do reino relataram a presenca de um viajante transportando artigos de valor em Umbra.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 23 then
			Game.createNpc("Luden", Position(6055, 5275, 6))
			Game.broadcastMessage("Emissarios do reino relataram a presenca de um viajante transportando artigos de valor em Umbra.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 24 then
			Game.createNpc("Luden", Position(5324, 5002, 10))
			Game.broadcastMessage("Um portador de riquezas imensuraveis se esconde pela selva de Hakata.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 25 then
			Game.createNpc("Luden", Position(5521, 5036, 12))
			Game.broadcastMessage("Um portador de riquezas imensuraveis se esconde pela selva de Hakata.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 26 then
			Game.createNpc("Luden", Position(33599, 31461, 10))
			Game.broadcastMessage("Luden foi visto explorando Ravencrest.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 27 then
			Game.createNpc("Luden", Position(5549, 4957, 11))
			Game.broadcastMessage("Tesouros valiosos se escondem em Nautis com um bravo explorador...", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 28 then
			Game.createNpc("Luden", Position(5739, 4867, 11))
			Game.broadcastMessage("Tesouros valiosos se escondem em Nautis com um bravo explorador...", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 29 then
			Game.createNpc("Luden", Position(6005, 4598, 8))
			Game.broadcastMessage("Luden foi visto vagando pela peninsula de Nivabi.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 30 then
			Game.createNpc("Luden", Position(6119, 4614, 7))
			Game.broadcastMessage("Captain Donahue acaba de deixar Luden em Krotkah!", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 31 then
			Game.createNpc("Luden", Position(5761, 4701, 1))
			Game.broadcastMessage("Viajantes relatam ter visto um comerciante de itens raros vagando pela ilha de Scarlett Etzel.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 32 then
			Game.createNpc("Luden", Position(5728, 4856, 8))
			Game.broadcastMessage("Viajantes relatam ter visto um comerciante de itens raros vagando pela ilha de Scarlett Etzel.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 33 then
			Game.createNpc("Luden", Position(5354, 4611, 10))
			Game.broadcastMessage("Os anoes de Anvillux alertam sobre a passagem do vendedor de itens raros por suas terras.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 34 then
			Game.createNpc("Luden", Position(5428, 4488, 13))
			Game.broadcastMessage("Os anoes de Anvillux alertam sobre a passagem do vendedor de itens raros por suas terras.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 35 then
			Game.createNpc("Luden", Position(5572, 4290, 9))
			Game.broadcastMessage("O caixeiro viajante foi visto nos Emerald Gardens ha pouco tempo.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 36 then
			Game.createNpc("Luden", Position(5513, 4314, 9))
			Game.broadcastMessage("O caixeiro viajante foi visto nos Emerald Gardens ha pouco tempo.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 37 then
			Game.createNpc("Luden", Position(5149, 4651, 9))
			Game.broadcastMessage("Mensageiros de Chaos enviam noticias sobre a possibilidade de uma barganha por itens valiosos em suas terras!", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 38 then
			Game.createNpc("Luden", Position(4922, 4439, 10))
			Game.broadcastMessage("Mensageiros de Chaos enviam noticias sobre a possibilidade de uma barganha por itens valiosos em suas terras!", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 39 then
			Game.createNpc("Luden", Position(4986, 4627, 4))
			Game.broadcastMessage("Mensageiros de Chaos enviam noticias sobre a possibilidade de uma barganha por itens valiosos em suas terras!", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 40 then
			Game.createNpc("Luden", Position(5194, 4430, 6))
			Game.broadcastMessage("Um espiao entregou uma mensagem sobre o paradeiro de um contrabandista de artigos de alto valor: 'Ele esta em Bounac'.", MESSAGE_EVENT_ADVANCE)
		elseif chanceLuden == 40 then
			Game.createNpc("Luden", Position(5242, 4447, 9))
			Game.broadcastMessage("Um espiao entregou uma mensagem sobre o paradeiro de um contrabandista de artigos de alto valor: 'Ele esta em Bounac'.", MESSAGE_EVENT_ADVANCE)
		end
		Game.setStorageValue(GlobalStorage.Crandoria.LudenRaid, os.time() + 20 * 60 * 60)
	end
	return true
end

raidEvent2:interval(interval3)
raidEvent2:register()

-- -- local raids = {
-- --     "umbra tree",
-- --     "ilshenar tree",
-- --     "krotkah tree",
-- --     "gnomprona tree",
-- --     "roshamuul tree",
-- --     "umbra crystal",
-- --     "umbra crystal2",
-- --     "ilshenar crystal",
-- --     "krotkah crystal",
-- --     "gnomprona crystal",
-- --     "roshamuul crystal",
-- -- }

-- local raids2 = {
--     "Cyclops",
--     "Dwarves Guard",
--     "Golems",
--     "Crystals",
--     "Elves",
--     "Lions",
--     "Undead Chaos",
--     "Hunters",
--     "OrcWoods",
--     "Elves",
--     "WaspBear",
--     "Badger",
--     "Kongras",
--     "Tigers",
--     "Barbarian",
--     "Frost Trolls",
--     "Ice Golem",
--     "Orcss",
--     "Pirates",
--     "Priestesses",
--     "Warlock",
--     "Night Harpy"
--     "Ogres",
--     "Quaras",
--     "Deeplings",
--     "Nomad",
--     "Scarab",
--     "Dragons",
--     "Undead Valkesh",
--     "Mawhawk",
--     "Kroazur",
--     "Irgix",
--     "Unaz",
--     "Vok",
--     "Grorlam",
--     "Hirintror",
--     "Zarabustor",
--     "Neferi",
--     "Yakchal",
--     "Crystal Wolf",
--     "Draptor",
--     "Hibernal Moth",
--     "Piratas One",
--     "Piratas Two",
--     "Piratas Three",
--     "Crustacea Gigantica treasure",
--     "Crustacea Gigantica treasure1",
-- }

-- local raids3 = {
--     "Orobuus",
--     "Lacewing Moth",
--     "Morgaroth",
--     "Orc Backpack",
--     "Piratas Four",
--     "Hive Overseer",
--     "Midnight Panther One",
--     "Midnight Panther Two",
--     "Midnight Panther Three",
--     "Ghazbaran",
--     "Orshabaal",
--     "Gaz",
--     "Omrafir",
--     "Raging Mage",
--     "Gryphon",
--     "Water Buffalo",
--     "Wild Horses",
--     "Gnarlhounds",
--     "Crustacea Gigantica treasure2",
--     "Jungle Queen",
--     "Giant Beaver",
--     "Jaul",
--     -- "Feroxa",
--     "Giant Beaver",
--     "Jungle Queen",
--     "Thornfire Wolf",
-- }

-- local raids4 = {
--     "Horned Fox",
--     "Horned Fox",
--     "Horned Fox",
--     "Horned Fox",
--     "Horned Fox",
--     "Horned Fox",
--     "Horned Fox",
--     "Horned Fox",
--     "Horned Fox",
--     "Horned Fox",
--     "Horned Fox",
--     "Horned Fox",
--     "Horned Fox",
--     "Horned Fox",
--     -- "Ferumbras",
-- }


-- -- local interval1 = math.random(3600000, 5200000)

-- local function startRandomRaid()
--     local randomIndex = math.random(1, #raids)
--     local raidName = raids[randomIndex]
--     Game.startRaid(raidName)
-- end

-- local function startRandomRaid2()
--     local randomIndex2 = math.random(1, #raids2)
--     local raidName2 = raids2[randomIndex2]
--     Game.startRaid(raidName2)
-- end

-- local function startRandomRaid3()
--     local randomIndex3 = math.random(1, #raids3)
--     local raidName3 = raids3[randomIndex3]
--     Game.startRaid(raidName3)
-- end

-- local function startRandomRaid4()
--     local randomIndex4 = math.random(1, #raids4)
--     local raidName4 = raids4[randomIndex4]
--     Game.startRaid(raidName4)
-- end



-- -- local interval1 = math.random(2500000, 3000000)
-- local interval1 = math.random(2500000, 3000000)

-- local raidEvent = GlobalEvent("random raid")
-- function raidEvent.onThink(interval, lastExecution)

--     local chanceHoltten = math.random(1, 100)
--     local chance = math.random(1, 10)

--     local now = os.date("*t")
--     local day = now.day
--     local month = now.month
--     local hour = now.hour
--     local minute = now.minute

--     if (day == 12 or day == 13 or day == 14) and hour == 20 and minute < 50 then
--         Game.createMonster("Feroxa", Position(4786, 4522, 11))
--         Game.broadcastMessage("Feroxa surgiu nas profundezas. Defendam Crandoria do monstro!", MESSAGE_EVENT_ADVANCE)
--     end

--     if hour < 12 then
--         if chanceHoltten == 100 and Game.getStorageValue(GlobalStorage.Crandoria.HolttenQuest.Spawn) < 1 then
--             Game.setStorageValue(GlobalStorage.Crandoria.HolttenQuest.Spawn, 1)
--             if chance == 1 then
--                 Game.createNpc("Lord Holtten", Position(4971, 5073, 7))
--                 Game.broadcastMessage("Lord Holtten esta passando por Crandoria e ficara no navio ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             elseif chance == 2 then
--                 Game.createNpc("Lord Holtten", Position(4750, 4825, 7))
--                 Game.broadcastMessage("Lord Holtten esta passando por Elvenshire e ficara no navio ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             elseif chance == 3 then
--                 Game.createNpc("Lord Holtten", Position(4660, 4572, 7))
--                 Game.broadcastMessage("Lord Holtten esta passando por Astralis e ficara no navio ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             elseif chance == 4 then
--                 Game.createNpc("Lord Holtten", Position(5096, 5379, 7))
--                 Game.broadcastMessage("Lord Holtten esta passando por Icehold e ficara no navio ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             elseif chance == 5 then
--                 Game.createNpc("Lord Holtten", Position(5335, 4676, 5))
--                 Game.broadcastMessage("Lord Holtten esta passando por Valkesh e ficara sobre o Depot ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             elseif chance == 6 then
--                 Game.createNpc("Lord Holtten", Position(5082, 4467, 4))
--                 Game.broadcastMessage("Lord Holtten esta passando por Chaos e ficara sobre o Depot ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             elseif chance == 7 then
--                 Game.createNpc("Lord Holtten", Position(4746, 5226, 4))
--                 Game.broadcastMessage("Lord Holtten esta passando por Magincia e ficara na cidade ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             elseif chance == 8 then
--                 Game.createNpc("Lord Holtten", Position(5713, 4531, 4))
--                 Game.broadcastMessage("Lord Holtten esta passando por Nivabi e ficara na cidade ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             elseif chance == 9 then
--                 Game.createNpc("Lord Holtten", Position(5552, 5122, 7))
--                 Game.broadcastMessage("Lord Holtten esta passando por Hakata e ficara na cidade ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             elseif chance == 10 then
--                 Game.createNpc("Lord Holtten", Position(5438, 4475, 9))
--                 Game.broadcastMessage("Lord Holtten esta passando por Anvillux e ficara na cidade ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             end
--         end
--     elseif hour >= 12 and hour < 18 then
--         if chanceHoltten > 98 and Game.getStorageValue(GlobalStorage.Crandoria.HolttenQuest.Spawn) < 1 then
--             Game.setStorageValue(GlobalStorage.Crandoria.HolttenQuest.Spawn, 1)
--             if chance == 1 then
--                 Game.createNpc("Lord Holtten", Position(4971, 5073, 7))
--                 Game.broadcastMessage("Lord Holtten esta passando por Crandoria e ficara no navio ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             elseif chance == 2 then
--                 Game.createNpc("Lord Holtten", Position(4750, 4825, 7))
--                 Game.broadcastMessage("Lord Holtten esta passando por Elvenshire e ficara no navio ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             elseif chance == 3 then
--                 Game.createNpc("Lord Holtten", Position(4660, 4572, 7))
--                 Game.broadcastMessage("Lord Holtten esta passando por Astralis e ficara no navio ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             elseif chance == 4 then
--                 Game.createNpc("Lord Holtten", Position(5096, 5379, 7))
--                 Game.broadcastMessage("Lord Holtten esta passando por Icehold e ficara no navio ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             elseif chance == 5 then
--                 Game.createNpc("Lord Holtten", Position(5335, 4676, 5))
--                 Game.broadcastMessage("Lord Holtten esta passando por Valkesh e ficara sobre o Depot ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             elseif chance == 6 then
--                 Game.createNpc("Lord Holtten", Position(5082, 4467, 4))
--                 Game.broadcastMessage("Lord Holtten esta passando por Chaos e ficara sobre o Depot ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             elseif chance == 7 then
--                 Game.createNpc("Lord Holtten", Position(4746, 5226, 4))
--                 Game.broadcastMessage("Lord Holtten esta passando por Magincia e ficara na cidade ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             elseif chance == 8 then
--                 Game.createNpc("Lord Holtten", Position(5713, 4531, 4))
--                 Game.broadcastMessage("Lord Holtten esta passando por Nivabi e ficara na cidade ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             elseif chance == 9 then
--                 Game.createNpc("Lord Holtten", Position(5552, 5122, 7))
--                 Game.broadcastMessage("Lord Holtten esta passando por Hakata e ficara na cidade ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             elseif chance == 10 then
--                 Game.createNpc("Lord Holtten", Position(5438, 4475, 9))
--                 Game.broadcastMessage("Lord Holtten esta passando por Anvillux e ficara na cidade ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             end
--         end
--     elseif hour >= 18 and hour < 21 then
--         if chanceHoltten > 90 and Game.getStorageValue(GlobalStorage.Crandoria.HolttenQuest.Spawn) < 1 then
--             Game.setStorageValue(GlobalStorage.Crandoria.HolttenQuest.Spawn, 1)
--             if chance == 1 then
--                 Game.createNpc("Lord Holtten", Position(4971, 5073, 7))
--                 Game.broadcastMessage("Lord Holtten esta passando por Crandoria e ficara no navio ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             elseif chance == 2 then
--                 Game.createNpc("Lord Holtten", Position(4750, 4825, 7))
--                 Game.broadcastMessage("Lord Holtten esta passando por Elvenshire e ficara no navio ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             elseif chance == 3 then
--                 Game.createNpc("Lord Holtten", Position(4660, 4572, 7))
--                 Game.broadcastMessage("Lord Holtten esta passando por Astralis e ficara no navio ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             elseif chance == 4 then
--                 Game.createNpc("Lord Holtten", Position(5096, 5379, 7))
--                 Game.broadcastMessage("Lord Holtten esta passando por Icehold e ficara no navio ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             elseif chance == 5 then
--                 Game.createNpc("Lord Holtten", Position(5335, 4676, 5))
--                 Game.broadcastMessage("Lord Holtten esta passando por Valkesh e ficara sobre o Depot ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             elseif chance == 6 then
--                 Game.createNpc("Lord Holtten", Position(5082, 4467, 4))
--                 Game.broadcastMessage("Lord Holtten esta passando por Chaos e ficara sobre o Depot ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             elseif chance == 7 then
--                 Game.createNpc("Lord Holtten", Position(4746, 5226, 4))
--                 Game.broadcastMessage("Lord Holtten esta passando por Magincia e ficara na cidade ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             elseif chance == 8 then
--                 Game.createNpc("Lord Holtten", Position(5713, 4531, 4))
--                 Game.broadcastMessage("Lord Holtten esta passando por Nivabi e ficara na cidade ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             elseif chance == 9 then
--                 Game.createNpc("Lord Holtten", Position(5552, 5122, 7))
--                 Game.broadcastMessage("Lord Holtten esta passando por Hakata e ficara na cidade ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             elseif chance == 10 then
--                 Game.createNpc("Lord Holtten", Position(5438, 4475, 9))
--                 Game.broadcastMessage("Lord Holtten esta passando por Anvillux e ficara na cidade ate o fim do dia.", MESSAGE_EVENT_ADVANCE)
--             end
--         end
--     end

--     -- startRandomRaid()
--     return true
-- end

-- raidEvent:interval(interval1)
-- raidEvent:register()


-- local interval3 = math.random(4000000, 7000000)

-- local raidEvent2 = GlobalEvent("random raids")
-- function raidEvent2.onThink(interval, lastExecution)
--     local chance = math.random(1, 305)

--     if Game.getStorageValue(GlobalStorage.Crandoria.LudenRaid) > os.time() then
--         chance = math.random(1, 300)
--     end

--     if chance < 280 then
--         startRandomRaid2()
--         return true
--     elseif chance >= 280 and chance <= 299 then
--         startRandomRaid3()
--         return true
--     elseif chance == 300 then
--         startRandomRaid4()
--         return true
--     elseif chance > 300 then
--         local chanceLuden = math.random(1, 49)
--         if chanceLuden == 1 then
--             Game.createNpc("Luden", Position(4818, 4523, 2))
--             Game.broadcastMessage("Luden foi avistado entrando na fortaleza de Oberon!", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 2 then
--             Game.createNpc("Luden", Position(5435, 4846, 9))
--             Game.broadcastMessage("Tropas de Valkesh avistaram um mercador misterioso acessando as montanhas.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 3 then
--             Game.createNpc("Luden", Position(5092, 4494, 12))
--             Game.broadcastMessage("Luden foi visto vagando pela peninsula de Nivabi.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 4 then
--             Game.createNpc("Luden", Position(4818, 4483, 7))
--             Game.broadcastMessage("Luden foi avistado entrando na fortaleza de Oberon!", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 5 then
--             Game.createNpc("Luden", Position(4621, 4562, 9))
--             Game.broadcastMessage("Habitantes de Astralis acabam de se despedir de um comerciante de itens raros...", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 6 then
--             Game.createNpc("Luden", Position(4659, 4486, 4))
--             Game.broadcastMessage("Habitantes de Astralis acabam de se despedir de um comerciante de itens raros...", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 7 then
--             Game.createNpc("Luden", Position(4628, 5089, 11))
--             Game.broadcastMessage("Corvos de Magincia avistaram um homem carregando diversas riquezas.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 8 then
--             Game.createNpc("Luden", Position(4656, 5160, 8))
--             Game.broadcastMessage("Corvos de Magincia avistaram um homem carregando diversas riquezas.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 9 then
--             Game.createNpc("Luden", Position(4599, 5233, 9))
--             Game.broadcastMessage("Corvos de Magincia avistaram um homem carregando diversas riquezas.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 10 then
--             Game.createNpc("Luden", Position(4985, 5530, 7))
--             Game.broadcastMessage("Relatos de barbaros de Icehold apontam para a presenca de Luden em suas terras.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 11 then
--             Game.createNpc("Luden", Position(5147, 5545, 4))
--             Game.broadcastMessage("Relatos de barbaros de Icehold apontam para a presenca de Luden em suas terras.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 12 then
--             Game.createNpc("Luden", Position(4698, 5468, 9))
--             Game.broadcastMessage("Relatos de barbaros de Icehold apontam para a presenca de Luden em suas terras.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 13 then
--             Game.createNpc("Luden", Position(5528, 5556, 15))
--             Game.broadcastMessage("Luden foi visto explorando a ilha de Ilshenar.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 14 then
--             Game.createNpc("Luden", Position(5340, 5476, 11))
--             Game.broadcastMessage("Luden foi visto explorando a ilha de Ilshenar.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 15 then
--             Game.createNpc("Luden", Position(5788, 5357, 5))
--             Game.broadcastMessage("Um mercador misterioso esta explorando Warmwind nesse momento.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 16 then
--             Game.createNpc("Luden", Position(5868, 5297, 10))
--             Game.broadcastMessage("Um mercador misterioso esta explorando Warmwind nesse momento.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 17 then
--             Game.createNpc("Luden", Position(5579, 5215, 14))
--             Game.broadcastMessage("Um mercador misterioso esta explorando Warmwind nesse momento.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 18 then
--             Game.createNpc("Luden", Position(5943, 4938, 7))
--             Game.broadcastMessage("Sentinelas de Roshamuul avistaram um individuo carregando itens raros na ilha.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 19 then
--             Game.createNpc("Luden", Position(5855, 5055, 11))
--             Game.broadcastMessage("Sentinelas de Roshamuul avistaram um individuo carregando itens raros na ilha.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 20 then
--             Game.createNpc("Luden", Position(6019, 4940, 6))
--             Game.broadcastMessage("Sentinelas de Roshamuul avistaram um individuo carregando itens raros na ilha.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 21 then
--             Game.createNpc("Luden", Position(5989, 5305, 3))
--             Game.broadcastMessage("Emissarios do reino relataram a presenca de um viajante transportando artigos de valor em Umbra.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 22 then
--             Game.createNpc("Luden", Position(6132, 5301, 8))
--             Game.broadcastMessage("Emissarios do reino relataram a presenca de um viajante transportando artigos de valor em Umbra.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 23 then
--             Game.createNpc("Luden", Position(6055, 5275, 6))
--             Game.broadcastMessage("Emissarios do reino relataram a presenca de um viajante transportando artigos de valor em Umbra.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 24 then
--             Game.createNpc("Luden", Position(5324, 5002, 10))
--             Game.broadcastMessage("Um portador de riquezas imensuraveis se esconde pela selva de Hakata.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 25 then
--             Game.createNpc("Luden", Position(5521, 5036, 12))
--             Game.broadcastMessage("Um portador de riquezas imensuraveis se esconde pela selva de Hakata.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 26 then
--             Game.createNpc("Luden", Position(33599, 31461, 10))
--             Game.broadcastMessage("Luden foi visto explorando Ravencrest.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 27 then
--             Game.createNpc("Luden", Position(5549, 4957, 11))
--             Game.broadcastMessage("Tesouros valiosos se escondem em Nautis com um bravo explorador...", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 28 then
--             Game.createNpc("Luden", Position(5739, 4867, 11))
--             Game.broadcastMessage("Tesouros valiosos se escondem em Nautis com um bravo explorador...", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 29 then
--             Game.createNpc("Luden", Position(6005, 4598, 8))
--             Game.broadcastMessage("Luden foi visto vagando pela peninsula de Nivabi.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 30 then
--             Game.createNpc("Luden", Position(6119, 4614, 7))
--             Game.broadcastMessage("Captain Donahue acaba de deixar Luden em Krotkah!", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 31 then
--             Game.createNpc("Luden", Position(5761, 4701, 1))
--             Game.broadcastMessage("Viajantes relatam ter visto um comerciante de itens raros vagando pela ilha de Scarlett Etzel.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 32 then
--             Game.createNpc("Luden", Position(5728, 4856, 8))
--             Game.broadcastMessage("Viajantes relatam ter visto um comerciante de itens raros vagando pela ilha de Scarlett Etzel.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 33 then
--             Game.createNpc("Luden", Position(5354, 4611, 10))
--             Game.broadcastMessage("Os anoes de Anvillux alertam sobre a passagem do vendedor de itens raros por suas terras.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 34 then
--             Game.createNpc("Luden", Position(5428, 4488, 13))
--             Game.broadcastMessage("Os anoes de Anvillux alertam sobre a passagem do vendedor de itens raros por suas terras.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 35 then
--             Game.createNpc("Luden", Position(5572, 4290, 9))
--             Game.broadcastMessage("O caixeiro viajante foi visto nos Emerald Gardens ha pouco tempo.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 36 then
--             Game.createNpc("Luden", Position(5513, 4314, 9))
--             Game.broadcastMessage("O caixeiro viajante foi visto nos Emerald Gardens ha pouco tempo.", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 37 then
--             Game.createNpc("Luden", Position(5149, 4651, 9))
--             Game.broadcastMessage("Mensageiros de Chaos enviam noticias sobre a possibilidade de uma barganha por itens valiosos em suas terras!", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 38 then
--             Game.createNpc("Luden", Position(4922, 4439, 10))
--             Game.broadcastMessage("Mensageiros de Chaos enviam noticias sobre a possibilidade de uma barganha por itens valiosos em suas terras!", MESSAGE_EVENT_ADVANCE)
--         elseif chanceLuden == 39 then
--             Game.createNpc("Luden", Position(4986, 4627, 4))
--             Game.broadcastMessage("Mensageiros de Chaos enviam noticias sobre a possibilidade de uma barganha por itens valiosos em suas terras!", MESSAGE_EVENT_ADVANCE)  
--         elseif chanceLuden == 40 then
--             Game.createNpc("Luden", Position(5194, 4430, 6))
--             Game.broadcastMessage("Um espiao entregou uma mensagem sobre o paradeiro de um contrabandista de artigos de alto valor: 'Ele esta em Bounac'.", MESSAGE_EVENT_ADVANCE) 
--         elseif chanceLuden == 40 then
--             Game.createNpc("Luden", Position(5242, 4447, 9))
--             Game.broadcastMessage("Um espiao entregou uma mensagem sobre o paradeiro de um contrabandista de artigos de alto valor: 'Ele esta em Bounac'.", MESSAGE_EVENT_ADVANCE) 
--         end
--         Game.setStorageValue(GlobalStorage.Crandoria.LudenRaid, os.time() + 20 * 60 * 60)
--     end
--     return true
-- end

-- raidEvent2:interval(interval3)
-- raidEvent2:register()