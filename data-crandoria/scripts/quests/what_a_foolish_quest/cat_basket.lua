local effectPositions = {
	Position(5103, 4383, 8),
	Position(5104, 4383, 8),
	Position(5105, 4383, 8),
	Position(5106, 4383, 8),
	Position(5107, 4383, 8),
	Position(5108, 4383, 8),
}

local function removeKitty(monsterId)
	local monster = Monster(monsterId)
	if monster then
		monster:remove()
	end
end

local whatFoolishCat = Action()
function whatFoolishCat.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.WhatAFoolish.Questline) ~= 19 or player:getStorageValue(Storage.WhatAFoolish.CatBasket) == 1 then
		return false
	end

	player:setStorageValue(Storage.WhatAFoolish.CatBasket, 1)
	player:say("The queen's cat is not amused!", TALKTYPE_MONSTER_SAY)
	player:getPosition():sendMagicEffect(CONST_ME_DRAWBLOOD)
	player:say("Fchhhhh", TALKTYPE_MONSTER_SAY, false, player, effectPositions[1])

	for i = 1, #effectPositions do
		effectPositions[i]:sendMagicEffect(CONST_ME_POFF)
	end

	Game.createItem(123, 1, toPosition)
	toPosition:sendMagicEffect(CONST_ME_POFF)
	local monster = Game.createMonster("Kitty", Position(toPosition.x, toPosition.y + 1, toPosition.z))
	addEvent(removeKitty, 10000, monster.uid)
	return true
end

whatFoolishCat:id(122)
whatFoolishCat:register()
