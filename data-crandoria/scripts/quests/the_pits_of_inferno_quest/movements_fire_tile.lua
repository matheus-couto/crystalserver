-- local fires = {
-- 	[2040] = {vocationIds = VOCATION.BASE_ID.SORCERER, damage = 300},
-- 	[2041] = {vocationIds = VOCATION.BASE_ID.SORCERER, damage = 600},
-- 	[2042] = {vocationIds = VOCATION.BASE_ID.SORCERER, damage = 1200},
-- 	[2043] = {vocationIds = VOCATION.BASE_ID.SORCERER, damage = 2400},
-- 	[2044] = {vocationIds = VOCATION.BASE_ID.SORCERER, damage = 3600},
-- 	[2045] = {vocationIds = VOCATION.BASE_ID.SORCERER, damage = 7200},
-- 	[2046] = {vocationIds = VOCATION.BASE_ID.DRUID, damage = 300},
-- 	[2047] = {vocationIds = VOCATION.BASE_ID.DRUID, damage = 600},
-- 	[2048] = {vocationIds = VOCATION.BASE_ID.DRUID, damage = 1200},
-- 	[2049] = {vocationIds = VOCATION.BASE_ID.DRUID, damage = 2400},
-- 	[2050] = {vocationIds = VOCATION.BASE_ID.DRUID, damage = 3600},
-- 	[2051] = {vocationIds = VOCATION.BASE_ID.DRUID, damage = 7200},
-- 	[2052] = {vocationIds = VOCATION.BASE_ID.PALADIN, damage = 300},
-- 	[2053] = {vocationIds = VOCATION.BASE_ID.PALADIN, damage = 600},
-- 	[2054] = {vocationIds = VOCATION.BASE_ID.PALADIN, damage = 1200},
-- 	[2055] = {vocationIds = VOCATION.BASE_ID.PALADIN, damage = 2400},
-- 	[2056] = {vocationIds = VOCATION.BASE_ID.PALADIN, damage = 3600},
-- 	[2057] = {vocationIds = VOCATION.BASE_ID.PALADIN, damage = 7200},
-- 	[2058] = {vocationIds = VOCATION.BASE_ID.KNIGHT, damage = 300},
-- 	[2059] = {vocationIds = VOCATION.BASE_ID.KNIGHT, damage = 600},
-- 	[2060] = {vocationIds = VOCATION.BASE_ID.KNIGHT, damage = 1200},
-- 	[2061] = {vocationIds = VOCATION.BASE_ID.KNIGHT, damage = 2400},
-- 	[2062] = {vocationIds = VOCATION.BASE_ID.KNIGHT, damage = 3600},
-- 	[2063] = {vocationIds = VOCATION.BASE_ID.KNIGHT, damage = 7200}
	
-- }

-- local fireTile = MoveEvent()

-- function fireTile.onStepIn(creature, item, position, fromPosition)
-- 	local player = creature:getPlayer()
-- 	if not player then
-- 		return true
-- 	end

-- 	local fire = fires[item.actionid]
-- 	if not fire then
-- 		return true
-- 	end

-- 	if player:getVocation():getBaseId() == fire.vocationIds then
-- 		doTargetCombatHealth(0, player, COMBAT_FIREDAMAGE, -300, -300, CONST_ME_HITBYFIRE)
-- 	else
-- 		local combatType = COMBAT_FIREDAMAGE
-- 		if fire.damage > 300 then
-- 			combatType = COMBAT_PHYSICALDAMAGE
-- 		end
-- 		doTargetCombatHealth(0, player, combatType, -fire.damage, -fire.damage, CONST_ME_FIREATTACK)
-- 	end
-- 	return true
-- end

-- fireTile:type("stepin")

-- for index, value in pairs(fires) do
-- 	fireTile:aid(index)
-- end

-- fireTile:register()

