local MikarahTransform = CreatureEvent("MikarahTransform")

function MikarahTransform.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType)
	if creature and creature:getName() == "Mikarah Sarcophagus" then
		if creature:getHealth() < 300000 then
			position = creature:getPosition()
			Game.createMonster("The Sealed Mikarah", position, true, true)
			creature:remove()
		end
	elseif creature and creature:getName() == "The Sealed Mikarah" then
		if creature:getHealth() < 150000 then
			position = creature:getPosition()
			Game.createMonster("Mikarah", position, true, true)
			creature:remove()
		end
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

MikarahTransform:register() 