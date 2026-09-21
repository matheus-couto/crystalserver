local clashSpecial = Action()

local function setCreaturesHealthInArea(fromPosition, toPosition, lookLegs)
    for x = fromPosition.x, toPosition.x do
        for y = fromPosition.y, toPosition.y do
            local tile = Tile(Position(x, y, fromPosition.z))
            if tile then
                for _, creature in ipairs(tile:getCreatures()) do
                    if not creature:isPlayer() then
                        local outfit = creature:getOutfit()
                        if outfit.lookLegs == lookLegs then
							local newLife = creature:getHealth() / 2
                            creature:setHealth(newLife) -- 🔥 Reduz a vida apenas dos monstros corretos
							creature:getPosition():sendMagicEffect(CONST_ME_EXPLOSIONHIT)
                        end
                    end
                end
            end
        end
    end
end

function clashSpecial.onUse(player, item, fromPosition, target, toPosition)
    if player:getStorageValue(Storage.Quest.Crandoria.TibiaClash.Special) == 1 then
        local itemPos = item:getPosition()
        if (itemPos == Position(3958, 4765, 7) or itemPos == Position(3966, 4765, 7)) and player:getStorageValue(Storage.Quest.Crandoria.TibiaClash.Time) == 1 then
            setCreaturesHealthInArea(Position(3957, 4761, 7), Position(3970, 4763, 7), 114)
			player:setStorageValue(Storage.Quest.Crandoria.TibiaClash.Special, 0)
        elseif (itemPos == Position(3993, 4765, 7) or itemPos == Position(4003, 4765, 7)) and player:getStorageValue(Storage.Quest.Crandoria.TibiaClash.Time) == 2 then
            setCreaturesHealthInArea(Position(3391, 4761, 7), Position(4004, 4763, 7), 0)
			player:setStorageValue(Storage.Quest.Crandoria.TibiaClash.Special, 0)
        end
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce so pode utilizar o Poder Especial uma vez por partida.")
    end
	return false
end

clashSpecial:aid(13121)
clashSpecial:register()



-- local clashSpecial = Action()

-- function clashSpecial.onUse(player, item, fromPosition, target, toPosition)

-- 	if player:getStorageValue(Storage.Quest.Crandoria.TibiaClash.Special) == 1 then
-- 		if item:getPosition() == Position(3958, 4765, 7) or item:getPosition() == Position(3966, 4765, 7) then
-- 			if player:getStorageValue(Storage.Quest.Crandoria.TibiaClash.Time) == 1 then
				
-- 		elseif item:getPosition() == Position(3993, 4765, 7) or item:getPosition() == Position(4003, 4765, 7) then
-- 			if player:getStorageValue(Storage.Quest.Crandoria.TibiaClash.Time) == 2 then

-- 		end
-- end


-- clashSpecial:aid(13121)
-- clashSpecial:register()