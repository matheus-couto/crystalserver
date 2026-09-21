local config = {
	[36835] = { mountId = 183, message = "You receive the permission to ride the Shellodon!" },
}

local customMountEgg = Action()

function customMountEgg.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local mount = config[item.itemid]

	if not mount then
		return true
	end

	if not player:hasMount(mount.mountId) then
		player:addMount(mount.mountId)
		player:say(mount.message, TALKTYPE_MONSTER_SAY)
		item:remove(1)
	else
		player:sendTextMessage(19, "You already have this mount")
	end
	return true
end

for itemId, info in pairs(config) do
	customMountEgg:id(itemId)
end

customMountEgg:register()
