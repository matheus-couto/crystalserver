local config = {
	{position = Position(5492, 4755, 8), itemId = 2063},
	{position = Position(5497, 4757, 8), itemId = 2063},
	{position = Position(5487, 4757, 8), itemId = 2062},
	{position = Position(5489, 4763, 8), itemId = 2062},
	{position = Position(5495, 4763, 8), itemId = 2062}
}

local coffinPosition = Position(5484, 4771, 8)

local function revertCoffin()
	local coffinItem = Tile(coffinPosition):getItemById(167)
	if coffinItem then
		coffinItem:transform(162)
	end
end

local kosheiSwitch = Action()
function kosheiSwitch.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local statuesInOrder, statueItem = true
	for i = 1, #config do
		local statue = config[i]
		statueItem = Tile(statue.position):getItemById(statue.itemId)
		if not statueItem then
			statuesInOrder = false
			break
		end
	end

	if not statuesInOrder or Tile(coffinPosition):getItemById(167) then
		player:say('Nothing happens', TALKTYPE_MONSTER_SAY, false, player, toPosition)
		return true
	end

	local coffinItem = Tile(coffinPosition):getItemById(162)
	if coffinItem then
		coffinItem:transform(167)
		addEvent(revertCoffin, 2 * 60 * 1000)
		player:say('CLICK', TALKTYPE_MONSTER_SAY, false, player, coffinPosition)
	end
	return true
end

kosheiSwitch:uid(3070)
kosheiSwitch:register()