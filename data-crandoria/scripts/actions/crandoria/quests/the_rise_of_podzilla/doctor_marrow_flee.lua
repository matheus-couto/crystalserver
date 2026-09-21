local DoctorMarrowFlee = CreatureEvent("DoctorMarrowFlee")

function DoctorMarrowFlee.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType)
	if creature and creature:getName() == "Doctor Marrow Podzilla" then
		if creature:getHealth() < 100000 then
			position = creature:getPosition()
			position:sendMagicEffect(CONST_ME_POFF)
			creature:say('Estou saindo. Boa sorte com meu monstro!', TALKTYPE_MONSTER_SAY)
			creature:remove()
			return true
		end
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

DoctorMarrowFlee:register()