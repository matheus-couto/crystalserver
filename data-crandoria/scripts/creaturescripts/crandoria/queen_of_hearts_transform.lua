local QueenOfHeartsTransform = CreatureEvent("QueenOfHeartsTransform")

function QueenOfHeartsTransform.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType)
	if creature and creature:getName() == "The Queen of Hearts" then
		if creature:getHealth() < 500000 then
			position = creature:getPosition()
			position:sendMagicEffect(CONST_ME_AVATAR_APPEAR)
			Game.createMonster("The Enraged Queen", position, true, true)
			creature:remove()
		end
	elseif creature and creature:getName() == "The Enraged Queen" then
		if creature:getHealth() < 250000 then
			position = creature:getPosition()
			position:sendMagicEffect(CONST_ME_AVATAR_APPEAR)
			Game.createMonster("The Abomination of Hearts", position, true, true)
			creature:remove()
		end
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

QueenOfHeartsTransform:register()