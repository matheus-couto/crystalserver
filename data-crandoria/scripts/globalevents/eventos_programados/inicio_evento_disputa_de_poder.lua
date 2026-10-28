local config = {
	minPlayersTotal = 10, -- 5 por time; apos equilibrar, 10 no total garante 5/5

	red = {
		name = "Vermelho",
		color = 113,
		platform = {
			from = Position(4319, 6126, 7),
			to = Position(4328, 6128, 7),
		},
		arena = {
			from = Position(4319, 6138, 7),
			to = Position(4328, 6140, 7),
		},
	},
	blue = {
		name = "Azul",
		color = 107,
		platform = {
			from = Position(4330, 6126, 7),
			to = Position(4339, 6128, 7),
		},
		arena = {
			from = Position(4330, 6138, 7),
			to = Position(4339, 6140, 7),
		},
	},
}

local function isInArea(pos, area)
	return pos.z == area.from.z
		and pos.x >= area.from.x and pos.x <= area.to.x
		and pos.y >= area.from.y and pos.y <= area.to.y
end

local function getTeamEntries(area)
	local entries = {}
	for _, player in ipairs(Game.getPlayers()) do
		if isInArea(player:getPosition(), area) then
			entries[#entries + 1] = { player = player }
		end
	end
	return entries
end

local function shuffle(list)
	for i = #list, 2, -1 do
		local j = math.random(i)
		list[i], list[j] = list[j], list[i]
	end
	return list
end

local function isKnight(player)
	return player:getVocation():getBaseId() == VOCATION.BASE_ID.KNIGHT
end

-- Passa "amount" jogadores sorteados de um time para o outro
local function movePlayers(source, target, amount)
	shuffle(source)
	for _ = 1, amount do
		local entry = table.remove(source)
		if not entry then
			break
		end
		entry.moved = true
		target[#target + 1] = entry
	end
end

-- Tiles da arena do Y maior (frente) para o Y menor; aleatorio dentro da mesma linha.
-- Tiles inexistentes ou bloqueados sao ignorados.
local function getArenaTilesFrontFirst(area)
	local tiles = {}
	for y = area.to.y, area.from.y, -1 do
		local row = {}
		for x = area.from.x, area.to.x do
			local pos = Position(x, y, area.from.z)
			local tile = Tile(pos)
			if tile and not tile:hasFlag(TILESTATE_BLOCKSOLID) then
				row[#row + 1] = pos
			end
		end
		shuffle(row)
		for _, pos in ipairs(row) do
			tiles[#tiles + 1] = pos
		end
	end
	return tiles
end

-- Define o destino de cada jogador: knights ocupam os tiles da frente, depois os demais.
-- Devolve false se a arena nao tiver tiles suficientes.
local function assignDestinations(entries, arena)
	local tiles = getArenaTilesFrontFirst(arena)
	if #tiles < #entries then
		return false
	end

	local knights, others = {}, {}
	for _, entry in ipairs(entries) do
		if isKnight(entry.player) then
			knights[#knights + 1] = entry
		else
			others[#others + 1] = entry
		end
	end
	shuffle(knights)
	shuffle(others)

	local index = 1
	for _, group in ipairs({ knights, others }) do
		for _, entry in ipairs(group) do
			entry.destination = tiles[index]
			index = index + 1
		end
	end
	return true
end

local function sendToAll(red, blue, message)
	for _, team in ipairs({ red, blue }) do
		for _, entry in ipairs(team) do
			entry.player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
		end
	end
end

local function applyTeamOutfit(player, color)
	local outfit = player:getOutfit()
	outfit.lookHead = color
	outfit.lookBody = color
	outfit.lookLegs = color
	outfit.lookFeet = color

	local condition = Condition(CONDITION_OUTFIT)
	condition:setTicks(-1)
	condition:setOutfit(outfit)
	player:addCondition(condition)
end

local function teleportTeam(entries, team)
	for _, entry in ipairs(entries) do
		local player = entry.player
		local destination = entry.destination

		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:teleportTo(destination)
		destination:sendMagicEffect(CONST_ME_TELEPORT)

		applyTeamOutfit(player, team.color)

		if entry.moved then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Os times foram equilibrados e voce foi movido para o time " .. team.name .. ".")
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "A disputa comecou! Voce esta no time " .. team.name .. ".")
		end
	end
end

local eventoDisputaDePoder = GlobalEvent("eventoDisputaDePoder")

function eventoDisputaDePoder.onTime(interval)

	local day = os.date("%A")

	if day ~= "Sunday" then
		return true
	end

	local red = getTeamEntries(config.red.platform)
	local blue = getTeamEntries(config.blue.platform)

	-- 1) Minimo de jogadores
	if #red + #blue < config.minPlayersTotal then
		sendToAll(red, blue, "A Disputa de Poder foi cancelada: sao necessarios pelo menos 10 jogadores (5 em cada time).")
		Game.broadcastMessage("O evento Disputa de Poder foi cancelada por falta de jogadores.", MESSAGE_EVENT_ADVANCE)
		return true
	end

	-- 2) Equilibrio: se um time tem 2 ou mais jogadores a mais, passa metade da diferenca
	local diff = #red - #blue
	if diff >= 2 then
		movePlayers(red, blue, math.floor(diff / 2))
	elseif diff <= -2 then
		movePlayers(blue, red, math.floor(-diff / 2))
	end

	-- 3) Destinos (depois do equilibrio): knights na frente. Nada e teleportado se algum falhar.
	if not (assignDestinations(red, config.red.arena) and assignDestinations(blue, config.blue.arena)) then
		print("[Disputa de Poder] tiles insuficientes ou invalidos na arena, evento abortado.")
		sendToAll(red, blue, "A Disputa de Poder foi cancelada por um problema na arena. Entrem em contato com um ADM.")
		return true
	end

	-- 4) Largada
	teleportTeam(red, config.red)
	teleportTeam(blue, config.blue)

	return true
end

eventoDisputaDePoder:time("20:00:00")
eventoDisputaDePoder:register()

-- local eventoDisputaDePoder = GlobalEvent("eventoDisputaDePoder")

-- function eventoDisputaDePoder.onTime(interval)

-- 	local day = os.date("%A")

-- 	if day ~= "Sunday" then
-- 		return true
-- 	end
-- end

-- eventoDisputaDePoder:time("20:00:00")