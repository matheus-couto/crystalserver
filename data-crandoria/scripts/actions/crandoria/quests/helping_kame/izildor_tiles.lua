local tileIzildor = MoveEvent()


function tileIzildor.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	local chance = math.random(1, 10)


	if creature:isMonster() and creature:getName() == "Monster Izildor" then
		if chance >= 4 then
			local newItem = Game.createItem(2886, 6, position)
			-- Game.createItem(2886, 6, position)
			if newItem then
				newItem:setDuration(16, 24)
				return true
			end
		else
			return true
		end
	end

end

tileIzildor:aid(13057)
tileIzildor:register()