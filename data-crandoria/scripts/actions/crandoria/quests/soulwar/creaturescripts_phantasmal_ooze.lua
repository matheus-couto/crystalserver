local phantasmalOoze = MoveEvent()

function phantasmalOoze.onStepIn(creature, item, position, fromPosition)

	if creature:getName() == "Lesser Splinter of Madness" or creature:getName() == "Greater Splinter of Madness" or creature:getName() == "Mighty Splinter of Madness" then
		creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		creature:remove()
		item:transform(33950)
		return true
	elseif creature:isPlayer() then
		if item.itemid == 33949 then
			creature:setStorageValue(Storage.Quest.U12_40.SoulWar.TormentCount, 0)
			creature:setStorageValue(Storage.Quest.U12_40.SoulWar.PhantasmalTimer, os.time() + 15)
			creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The ooze calms your dread but leaves you vulnerable to phantasmal attacks!")
			return true
		elseif item.itemid == 33984 then
			creature:setStorageValue(Storage.Quest.U12_40.SoulWar.TormentCount, 0)
			creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your soul is weakened by the destruction of the remains but the intensity of madness is lessened!")
			return true
		end
	end
	return true
end

phantasmalOoze:id(33949, 33984)
phantasmalOoze:register()