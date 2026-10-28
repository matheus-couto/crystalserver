-- AJUSTE: 10 posicoes de destino da armadilha 2
local teleportPositions = {
	Position(4429, 6134, 7),
	Position(4460, 6179, 7),
    Position(4495, 6132, 7),
    Position(4458, 6116, 7),
    Position(4468, 6162, 7),
    Position(4416, 6155, 7),
    Position(4427, 6153, 7),
}

-- Embaralha uma lista (Fisher-Yates)
local function shuffle(list)
	for i = #list, 2, -1 do
		local j = math.random(i)
		list[i], list[j] = list[j], list[i]
	end
	return list
end

-- Posicoes vagas em um quadrado de "radius" sqm para cada lado do centro (exceto o centro)
local function getFreePositionsAround(center, radius)
	local free = {}
	for dx = -radius, radius do
		for dy = -radius, radius do
			if dx ~= 0 or dy ~= 0 then
				local pos = Position(center.x + dx, center.y + dy, center.z)
				local tile = Tile(pos)
				if tile
					and tile:getCreatureCount() == 0
					and not tile:hasFlag(TILESTATE_BLOCKSOLID)
					and not tile:hasFlag(TILESTATE_FLOORCHANGE)
					and not tile:hasFlag(TILESTATE_PROTECTIONZONE) then
					free[#free + 1] = pos
				end
			end
		end
	end
	return free
end

-- Remove os scarabs da lista informada (somente os criados por um disparo especifico)
local function removeScarabsByIds(ids)
	for _, id in ipairs(ids) do
		local scarab = Monster(id)
		if scarab and scarab:getName() == "Annoying Scarab" then
			scarab:getPosition():sendMagicEffect(CONST_ME_POFF)
			scarab:remove()
		end
	end
end

local tileEventoArtefato = MoveEvent()

function tileEventoArtefato.onStepIn(creature, item, position, fromPosition)

    local player = creature:getPlayer()
    if not player then
        return true
    end

    local storageEvent = Game.getStorageValue(GlobalStorage.Crandoria.Eventos.EventoProgramado)
    local storageGlobal = Game.getStorageValue(GlobalStorage.Crandoria.Eventos.TileCooldown)
    local timeNow = os.time()
    local chance = math.random(1, 3)
    local chanceTrap = math.random(1, 3)

    if storageEvent > 0 then
        if chance > 1 or storageGlobal > timeNow then
            player:say('Click!', TALKTYPE_MONSTER_SAY)
            return true
        else
            if chanceTrap == 1 then
                -- Ate 10 Annoying Scarabs nos sqm vagos em volta (3 sqm para cada lado)
                local free = shuffle(getFreePositionsAround(player:getPosition(), 3))
                local createdIds = {}
                for i = 1, math.min(10, #free) do
                    local scarab = Game.createMonster("Annoying Scarab", free[i], false)
                    if scarab then
                        createdIds[#createdIds + 1] = scarab:getId()
                    end
                end
                -- Apos 30s, remove somente os scarabs DESTE disparo que ainda estiverem vivos
                if #createdIds > 0 then
                    addEvent(removeScarabsByIds, 30 * 1000, createdIds)
                end
                player:say('Pfff!', TALKTYPE_MONSTER_SAY)
            elseif chanceTrap == 2 then
                -- Teleporta o jogador para uma das 10 posicoes
                local destination = teleportPositions[math.random(#teleportPositions)]
                if Tile(destination) then
                    player:getPosition():sendMagicEffect(271)
                    player:teleportTo(destination)
                    destination:sendMagicEffect(271)
                end
                player:say('Click!', TALKTYPE_MONSTER_SAY)
            elseif chanceTrap == 3 then
                -- Tomb Thief na posicao livre mais proxima do jogador
                Game.createMonster("Tomb Thief", player:getPosition(), true)
                player:say('Click!', TALKTYPE_MONSTER_SAY)
            end
        end
    end

    return true
end

tileEventoArtefato:aid(13228)
tileEventoArtefato:register()


