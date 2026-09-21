local soulCageName = "Soul Cage"
local summonPosition = Position(33709, 31594, 14)
local checkFromPos = Position(33709, 31599, 14)
local checkToPos = Position(33720, 31610, 14)
local timeToWait = 14 -- segundos


local spell = Spell("instant")
function spell.onCastSpell(creature, var)
	Game.createMonster(soulCageName, summonPosition)
	creature:say("GOSHNAR'S MALICE PREPARES TO DEVOUR A TRAPPED SOUL!", TALKTYPE_ORANGE_2)

	addEvent(function()
		local cage = Tile(summonPosition):getTopCreature()
		if cage and cage:getName() == soulCageName then
			cage:remove()
			local spectators = Game.getSpectators(checkFromPos, false, false, 12, 12, 12, 12)
			for _, mob in pairs(spectators) do
				local healthPercent = mob:getHealth() / mob:getMaxHealth()
				local pos = mob:getPosition()
				if mob:getName() == "Goshnar's Malice" then
					local newBoss = Game.createMonster("Goshnar's Malice 2", pos)
					if newBoss then
						newBoss:setHealth(math.floor(newBoss:getMaxHealth() * healthPercent))
						mob:say("GOSHNAR'S MALICE DEVOURS THE SOUL AND BECAME HARDER TO DEFEAT!", TALKTYPE_ORANGE_2)
						mob:remove()
					end
					break
				elseif mob:getName() == "Goshnar's Malice 2" then
					local newBoss = Game.createMonster("Goshnar's Malice 3", pos)
					if newBoss then
						newBoss:setHealth(math.floor(newBoss:getMaxHealth() * healthPercent))
						mob:say("GOSHNAR'S MALICE DEVOURS THE SOUL AND BECAME HARDER TO DEFEAT!", TALKTYPE_ORANGE_2)
						mob:remove()
					end
					break
				end
			end
		end
	end, timeToWait * 1000)

	return true
end

spell:name("goshnars malice cage")
spell:words("###740")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()
