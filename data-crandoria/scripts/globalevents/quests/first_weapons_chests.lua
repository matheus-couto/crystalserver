-- Os baus das armas das amazonas estao no mapa como baus comuns (id 2343), sem action id,
-- entao o script first_weapons.lua (aid 13223) nunca disparava: o jogador abria o bau,
-- pegava os itens na mao e o storage FirstWeaponReward ficava em 0 (o Crassus nao aceitava).
-- Marca os baus no startup, sem precisar editar o mapa.
local CHEST_ID = 2343
local CHEST_ACTION_ID = 13223
local CHEST_Y = 4859
local CHEST_Z = 9
local CHEST_X_LIST = { 4907, 4909, 4911, 4913, 4915, 4917, 4919 }

local firstWeaponsChests = GlobalEvent("FirstWeaponsChests")

function firstWeaponsChests.onStartup()
	for _, x in ipairs(CHEST_X_LIST) do
		local tile = Tile(Position(x, CHEST_Y, CHEST_Z))
		local chest = tile and tile:getItemById(CHEST_ID)
		if chest then
			chest:setAttribute(ITEM_ATTRIBUTE_ACTIONID, CHEST_ACTION_ID)
		else
			logger.warn("[FirstWeaponsChests] bau {} nao encontrado em {}, {}, {}", CHEST_ID, x, CHEST_Y, CHEST_Z)
		end
	end
end

firstWeaponsChests:register()
