local spell = Spell("instant")
function spell.onCastSpell(creature, var)
	local position = creature:getPosition()

	if creature:getName() == "Weak Soul" then
		creature:remove()
		Game.createMonster("Strong Soul", position)
	elseif creature:getName() == "Strong Soul" then
		creature:remove()
		Game.createMonster("Powerful Soul", position)
	elseif creature:getName() == "Lesser Splinter of Madness" then
		creature:remove()
		Game.createMonster("Greater Splinter of Madness", position)
	elseif creature:getName() == "Greater Splinter of Madness" then
		creature:remove()
		Game.createMonster("Mighty Splinter of Madness", position)
	end

	return true
end


spell:name("soulchange")
spell:words("###741")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()
