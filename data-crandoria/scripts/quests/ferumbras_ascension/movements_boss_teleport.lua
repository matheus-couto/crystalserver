local config = {
	[24830] = {storage = Storage.Quest.U10_90.FerumbrasAscension.Razzagorn},
	[24831] = {storage = Storage.Quest.U10_90.FerumbrasAscension.Ragiaz},
	[24832] = {storage = Storage.Quest.U10_90.FerumbrasAscension.Zamulosh},
	[24833] = {storage = Storage.Quest.U10_90.FerumbrasAscension.Mazoran},
	[24834] = {storage = Storage.Quest.U10_90.FerumbrasAscension.Tarbaz},
	[24835] = {storage = Storage.Quest.U10_90.FerumbrasAscension.Shulgrax},
	[24836] = {storage = Storage.Quest.U10_90.FerumbrasAscension.Plagirath}
}

local bossTeleport = MoveEvent()

function bossTeleport.onStepIn(creature, item, position, fromPosition)
	local teleport = config[item.actionid]
	if not teleport then
		return false
	end
	local player = creature:getPlayer()
	if not player then
		return true
	end
	if player:getStorageValue(teleport.storage) == 1 then
		local position = player:getPosition()
		position.z = position.z - 1
		player:teleportTo(position)
	end
	return true
end

bossTeleport:type("stepin")

for index, value in pairs(config) do
	bossTeleport:aid(index)
end

bossTeleport:register()
