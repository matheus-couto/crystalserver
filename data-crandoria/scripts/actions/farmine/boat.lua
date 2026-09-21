local boats = {
	{pos = {x = 4986, y = 4460, z = 7}, destination = Position(4811, 4462, 7), unlockShortcut = Storage.Quest.U11_80.TheSecretLibrary.ShortcutToBastion},
	{pos = {x = 4810, y = 4463, z = 7}, destination = Position(4987, 4460, 7)},
	{pos = {x = 4839, y = 4469, z = 7}, destination = Position(4848, 4454, 7)},
	{pos = {x = 4848, y = 4455, z = 7}, destination = Position(4840, 4471, 3), access = Storage.Quest.U11_80.TheSecretLibrary.ShortcutToBastion}
}

local boat = Action()

function boat.onUse(player, item, fromPosition, itemEx, toPosition)
	for b = 1, #boats do
		if item:getPosition() == Position(boats[b].pos) then
			if boats[b].unlockShortcut then
				if player:getStorageValue(boats[b].unlockShortcut) < 1 then
					player:setStorageValue(boats[b].unlockShortcut, 1)
				end
			end
			if boats[b].access then
				if player:getStorageValue(boats[b].access) == 1 then
					player:teleportTo(boats[b].destination)
					player:getPosition():sendMagicEffect(CONST_ME_WATERSPLASH)
					return true
				end
			else
				player:teleportTo(boats[b].destination)
				player:getPosition():sendMagicEffect(CONST_ME_WATERSPLASH)
				return true
			end
		end
	end
end

for a = 1, #boats do
	boat:position(boats[a].pos)
end
boat:register()
