local eradicatorTransform = CreatureEvent("EradicatorTransform")
function eradicatorTransform.onThink(creature)
	if not creature or not creature:isMonster() then
		return false
	end

	if eradicatorReleaseT == true then
		if eradicatorWeak == 0 then
			local pos = creature:getPosition()
			local health = creature:getHealth()
			creature:remove()

			local monster = Game.createMonster("eradicator2", pos, false, true)
			monster:addHealth(-monster:getHealth() + health, COMBAT_PHYSICALDAMAGE)
			Game.createMonster("spark of destruction", {x = 5445, y = 4842, z = 15}, false, true)
			Game.createMonster("spark of destruction", {x = 5454, y = 4842, z = 15}, false, true)
			Game.createMonster("spark of destruction", {x = 5445, y = 4850, z = 15}, false, true)
			Game.createMonster("spark of destruction", {x = 5454, y = 4850, z = 15}, false, true)
			eradicatorWeak = 1 -- Eradicator form
			eradicatorReleaseT = false -- Release spell
			areaEradicator2 = addEvent(function() eradicatorReleaseT = true end, 9000)
		elseif eradicatorWeak == 1 then
			local pos = creature:getPosition()
			local health = creature:getHealth()

			creature:remove()

			local monster = Game.createMonster("eradicator", pos, false, true)
			monster:addHealth(-monster:getHealth() + health, COMBAT_PHYSICALDAMAGE)
			eradicatorWeak = 0
			eradicatorReleaseT = false -- Release spell
			areaEradicator2 = addEvent(function() eradicatorReleaseT = true end, 74000)
		end
	end
	return true
end

eradicatorTransform:register()
