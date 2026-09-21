local DoctorMarrowTransform = CreatureEvent("DoctorMarrowTransform")

function DoctorMarrowTransform.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType)
	if creature and creature:getName() == "Doctor Marrow" then
		if creature:getHealth() < 400000 then
			position = creature:getPosition()
			Game.createMonster("The Monster", position, true, true)
			creature:remove()
		end
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

DoctorMarrowTransform:register()