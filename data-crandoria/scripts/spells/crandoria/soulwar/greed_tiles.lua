local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	if not creature or not creature:isMonster() then
		return false
	end

	-- Posições dos itens na sala
	local itemPositions = {
		Position(33739, 31666, 14),
		Position(33743, 31662, 14),
		Position(33749, 31661, 14),
		Position(33751, 31663, 14),
		Position(33754, 31665, 14),
		Position(33747, 31666, 14),
		Position(33745, 31671, 14),
		Position(33751, 31670, 14)
	}

	local id1 = 39532
	local id2 = 20121

	local group1 = {} -- itens com id1
	local group2 = {} -- itens com id2

	-- Classificar os itens por ID
	for _, pos in ipairs(itemPositions) do
		local tile = Tile(pos)
		if tile then
			local item = tile:getItemById(id1)
			if item then
				table.insert(group1, item)
			else
				item = tile:getItemById(id2)
				if item then
					table.insert(group2, item)
				end
			end
		end
	end

	-- Função para selecionar aleatoriamente N itens
	local function pickRandomItems(list, count)
		local chosen = {}
		local available = { unpack(list) }

		for i = 1, math.min(count, #available) do
			local index = math.random(1, #available)
			table.insert(chosen, available[index])
			table.remove(available, index)
		end

		return chosen
	end

	-- Escolher 2 itens aleatórios de cada grupo
	local toSwap1 = pickRandomItems(group1, 2)
	local toSwap2 = pickRandomItems(group2, 2)

	-- Transformar os itens
	for _, item in ipairs(toSwap1) do
		item:transform(id2)
	end

	for _, item in ipairs(toSwap2) do
		item:transform(id1)
	end

	return true
end

spell:name("greed tiles")
spell:words("###742")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()