local teleportConfig = {
		creatureNames = {"The Rootkraken Immortal"}
	}

local function removeCreatureInArea(fromPosition, toPosition, creatureNames)
    for x = fromPosition.x, toPosition.x do
        for y = fromPosition.y, toPosition.y do
            local pos = Position(x, y, fromPosition.z)
            local tile = Tile(pos)
            if tile then
                local creature = tile:getTopCreature()
                if creature and table.contains(creatureNames, creature:getName()) then
					local hp = creature:getHealth()
                    creature:remove()
					local newmonster = Game.createMonster("The Rootkraken", pos)
					if newmonster then
						newmonster:setHealth(hp)
						addEvent(function()
							if newmonster then
								local newhp = newmonster:getHealth()
								local newpos = newmonster:getPosition()
								newmonster:remove()
								local creatureback = Game.createMonster("The Rootkraken Immortal", newpos)
								if creatureback then
									creatureback:setHealth(newhp)
								end
							end
						end, 30000)
					end
					return true
                end
            end
        end
    end
    return false
end

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local pos = Position(6203, 4382, 8)
	local hasCreature = getTopCreature(pos)
	if hasCreature and hasCreature:isMonster() and hasCreature:getName() == "Power Generator" then
		if creature:getName() == "Doctor Marrow Podzilla" then
			local health = creature:getHealth()
			creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			creaturete:say('Preciso consertar isso!', TALKTYPE_MONSTER_SAY)
			creature:remove()
			removeCreatureInArea(Position(6191, 4379, 8), Position(6219, 4399, 8), "The Rootkraken Immortal")
			local monster = Game.createMonster("Doctor Marrow Podzilla Fix", Position(6203, 4383, 8))
			if monster then
				monster:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				monster:setHealth(health)
				monster:say('Preciso consertar isso!', TALKTYPE_MONSTER_SAY)
				addEvent(function()
					if monster then
						GENERATOR_POS:sendMagicEffect(CONST_ME_HITAREA)
					end
				end, 5000)
				addEvent(function()
					if monster then
						GENERATOR_POS:sendMagicEffect(CONST_ME_HITAREA)
					end
				end, 10000)
				addEvent(function()
					if monster then
						GENERATOR_POS:sendMagicEffect(CONST_ME_HITAREA)
					end
				end, 15000)
				addEvent(function()
					if monster then
						GENERATOR_POS:sendMagicEffect(CONST_ME_HITAREA)
					end
				end, 20000)
				addEvent(function()
					if monster then
						GENERATOR_POS:sendMagicEffect(CONST_ME_HITAREA)
					end
				end, 25000)
				addEvent(function()
					if monster then
						GENERATOR_POS:sendMagicEffect(CONST_ME_HITAREA)
						local monsterHealth = monster:getHealth()
						local monsterPos = monster:getPosition()
						monster:say('Agora sim! Ha ha ha!', TALKTYPE_MONSTER_SAY)
						monster:remove()
						local marrow = Game.createMonster("Doctor Marrow Podzilla", monsterPos)
						if marrow then
							marrow:setHealth(monsterHealth)
						end
					end
				end, 30000)
			end
		elseif creature:getName() == "Doctor Marrow Podzilla Fix" then
			creature:setDirection(NORTH)
		end
	end
	return true
end

spell:name("generator fix") -- use esse mesmo nome no "name" da entrada em monster.attacks
spell:words("###778") -- ajuste se seu fork exigir um identificador único diferente
spell:isAggressive(true)
spell:blockWalls(true)
spell:register()