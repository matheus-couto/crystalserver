local config = {
	creatureNames = { "Raging Raubritter", "Frozen Raubritter", "Poisoned Raubritter", "Energised Raubritter" },
	arenaFrom = Position(5243, 5463, 2),
	arenaTo = Position(5262, 5481, 2),
}

-- Conta quantos dos 4 Raubritter ainda estão vivos na área, EXCLUINDO
-- explicitamente a criatura que está morrendo agora. Sem isso, ela mesma
-- ainda apareceria na varredura (o engine só remove/substitui por corpo
-- depois que onDeath retorna), fazendo a contagem nunca chegar a zero.
local function countCreaturesInArea(fromPosition, toPosition, creatureNames, excludeCreature)
	local count = 0
	for x = fromPosition.x, toPosition.x do
		for y = fromPosition.y, toPosition.y do
			local pos = Position(x, y, fromPosition.z)
			local tile = Tile(pos)
			if tile then
				local creature = tile:getTopCreature()
				if creature and creature ~= excludeCreature and table.contains(creatureNames, creature:getName()) then
					count = count + 1
				end
			end
		end
	end
	return count
end

-- Lista os tiles livres (sem bloqueio, sem criatura em cima) dentro da área da arena
local function getWalkableTilesInArea(fromPosition, toPosition)
	local walkable = {}
	for x = fromPosition.x, toPosition.x do
		for y = fromPosition.y, toPosition.y do
			local pos = Position(x, y, fromPosition.z)
			local tile = Tile(pos)
			if tile and not tile:hasFlag(TILESTATE_BLOCKSOLID) and not tile:hasFlag(TILESTATE_PROTECTIONZONE) and not tile:getTopCreature() then
				table.insert(walkable, pos)
			end
		end
	end
	return walkable
end

-- Pega todo monstro no andar de cima (arenaFrom.z - 1) e teleporta cada um
-- pra um tile livre sorteado dentro da arena, sem repetir tile entre eles.
local function pullMonstersFromUpperFloor(arenaFrom, arenaTo)
	local upperFrom = Position(arenaFrom.x, arenaFrom.y, arenaFrom.z - 1)
	local upperTo = Position(arenaTo.x, arenaTo.y, arenaTo.z - 1)

	local upperMonsters = {}
	for x = upperFrom.x, upperTo.x do
		for y = upperFrom.y, upperTo.y do
			local pos = Position(x, y, upperFrom.z)
			local tile = Tile(pos)
			if tile then
				local creature = tile:getTopCreature()
				if creature and creature:isMonster() then
					table.insert(upperMonsters, creature)
				end
			end
		end
	end

	if #upperMonsters == 0 then
		return
	end

	local availableTiles = getWalkableTilesInArea(arenaFrom, arenaTo)

	for _, monster in ipairs(upperMonsters) do
		if #availableTiles == 0 then
			break -- sem mais tiles livres; os monstros restantes ficam onde estão
		end

		local index = math.random(1, #availableTiles)
		local destination = availableTiles[index]
		table.remove(availableTiles, index) -- evita sortear o mesmo tile duas vezes

		monster:teleportTo(destination)
		destination:sendMagicEffect(CONST_ME_TELEPORT)
	end
end

local raubritterDeath = CreatureEvent("raubritterDeath")

function raubritterDeath.onDeath(creature)
	local remaining = countCreaturesInArea(config.arenaFrom, config.arenaTo, config.creatureNames, creature)

	if remaining > 0 then
		-- ainda tem outro Raubritter vivo na área, nada acontece
		return true
	end

	-- era o último: puxa tudo que estiver no andar de cima pra dentro da arena
	pullMonstersFromUpperFloor(config.arenaFrom, config.arenaTo)

	return true
end

raubritterDeath:register()