
local config = {
	area = {
		fromPosition = Position(4306, 4396, 7),
		toPosition = Position(4316, 4407, 7)
	},
	centerPosition = Position(4311, 4401, 7)
}

local massiveAnviTowerDeath = CreatureEvent("massiveAnviTowerDeath")

function massiveAnviTowerDeath.onDeath(creature)
	local countLookTypeEx7950 = 0
	
	-- Iterar pela área definida (fromPosition até toPosition)
	for x = config.area.fromPosition.x, config.area.toPosition.x do
		for y = config.area.fromPosition.y, config.area.toPosition.y do
			local tile = Tile(Position(x, y, config.area.fromPosition.z))
			if tile then
				local creatures = tile:getCreatures() -- Obtém todas as criaturas na tile
				if creatures then
					for _, tileCreature in ipairs(creatures) do
						-- Verifica se o monstro tem lookTypeEx == 2107
						if tileCreature:isMonster() and tileCreature:getOutfit().lookTypeEx and tileCreature:getOutfit().lookTypeEx == 7950 then
							countLookTypeEx7950 = countLookTypeEx7950 + 1
							-- Se já houver 2 ou mais monstros, podemos parar a busca
							if countLookTypeEx7950 >= 2 then
								return true -- Cancela a execução se já houver 2 ou mais monstros
							end
						end
					end
				end
			end
		end
	end
	
	-- Se houver menos de 2 monstros com lookTypeEx == 2107, remove o item e cria o totem
	if countLookTypeEx7950 < 2 then
		local tile = Tile(config.centerPosition)
		local item = tile and tile:getItemById(16572) -- Checa a existência do tile e do item
		
		if item then
			item:remove() -- Remove o item 16572
			addEvent(function()
				-- Cria o Chaos Totem
				Game.createMonster("Anvillux Totem", config.centerPosition, true, true)
			end, 500) -- Adiciona um atraso de 500ms
		end
	end

	return true
end

massiveAnviTowerDeath:register()




