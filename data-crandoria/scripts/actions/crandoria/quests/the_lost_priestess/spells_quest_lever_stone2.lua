local lever = Action()

-- Define um valor para controlar o tempo que a pedra ficará removida (em segundos)
local removalTime = 60 -- em segundos

-- Define uma variável para controlar se a alavanca pode ser usada durante a remoção da pedra
local canUseLever = true

function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local stonePosition = {x = 4847, y = 4462, z = 14}

	if item.itemid == 2772 and canUseLever then
		-- Remove a pedra e transforma a alavanca para 2773
		Tile(stonePosition):getItemById(1841):remove()
		item:transform(2773)

		-- Define que a alavanca não pode ser usada durante o tempo de remoção
		canUseLever = false

		-- Cria um timer para restaurar a alavanca e a pedra após o tempo especificado
		addEvent(function()
			-- Restaura a alavanca para 2772
			item:transform(2772)

			-- Cria uma nova pedra na posição original
			Game.createItem(1841, 1, stonePosition)

			-- Define que a alavanca pode ser usada novamente
			canUseLever = true
		end, removalTime * 1000)  -- Converte o tempo de segundos para milissegundos
	end

	return true
end

lever:uid(12272)
lever:register()