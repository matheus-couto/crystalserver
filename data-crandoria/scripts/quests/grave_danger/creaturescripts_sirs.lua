local sirNictrosThink = CreatureEvent("SirNictrosThink")
function sirNictrosThink.onThink(creature)
	local maxhealth = creature:getMaxHealth()
	if maxhealth * 0.65 > creature:getHealth() then
		creature:say("Now it's your chance for entertainment, dear brother!", TALKTYPE_MONSTER_SAY)
		creature:teleportTo(Position({ x = 5113, y = 5124, z = 15 }))
		local boss = Tile(Position({ x = 5108, y = 5124, z = 15 })):getTopCreature()
		if boss and boss:isMonster() then
			boss:teleportTo(Position({ x = 5108, y = 5134, z = 15 }))
		end
		creature:unregisterEvent("SirNictrosThink")
	end
	return true
end

sirNictrosThink:register()

local sirBaelocThink = CreatureEvent("SirBaelocThink")
function sirBaelocThink.onThink(creature)
	local maxhealth = creature:getMaxHealth()
	if maxhealth * 0.65 > creature:getHealth() then
		creature:say("Join me in battle, my brother. Let's share the fun!", TALKTYPE_MONSTER_SAY)
		local monster = Tile(Position({ x = 5113, y = 5124, z = 15 })):getTopCreature()
		if monster then
			monster:teleportTo(Position({ x = 5108, y = 5134, z = 15 }))
			creature:unregisterEvent("SirBaelocThink")
		end
	end
	return true
end

sirBaelocThink:register()


local sirBaelocThink = CreatureEvent("SirBaelocThink")
function sirBaelocThink.onThink(creature)
	local maxhealth = creature:getMaxHealth()
	if maxhealth * 0.65 > creature:getHealth() then
		creature:say("Join me in battle, my brother. Let's share the fun!", TALKTYPE_MONSTER_SAY)
		local monstro = Tile(Position({ x = 5113, y = 5124, z = 15 })):getTopCreature()
		if monstro then
			monstro:teleportTo(Position({ x = 5108, y = 5134, z = 15 })) 
			creature:unregisterEvent("SirBaelocThink")
		end
	end
	return true
end

sirBaelocThink:register()
