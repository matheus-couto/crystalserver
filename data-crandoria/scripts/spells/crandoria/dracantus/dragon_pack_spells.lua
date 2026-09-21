-- -- local combatMaliz1 = Combat()
-- -- combatMaliz1:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
-- -- combatMaliz1:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_BIGPLANTS)

-- -- local combatMaliz2 = Combat()
-- -- combatMaliz2:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
-- -- combatMaliz2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GREEN_RINGS)

-- -- local combatMaliz3 = Combat()
-- -- combatMaliz3:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
-- -- combatMaliz3:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SMALLPLANTS)

-- -- MALIZ --
-- local skillMaliz = Combat()
-- skillMaliz:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
-- skillMaliz:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
-- skillMaliz:setParameter(COMBAT_PARAM_CHAIN_EFFECT, CONST_ME_MORTAREA)
-- function getChainValue(creature)
-- 	return 2, 3, false
-- end
-- skillMaliz:setCallback(CALLBACK_PARAM_CHAINVALUE, "getChainValue")

-- -- VENGAR --
-- local skillVengar = Combat()
-- skillVengar:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
-- skillVengar:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
-- skillVengar:setParameter(COMBAT_PARAM_CHAIN_EFFECT, CONST_ME_MORTAREA)
-- local conditionVengar = Condition(CONDITION_FEARED)
-- conditionVengar:setParameter(CONDITION_PARAM_TICKS, 3000)
-- skillVengar:addCondition(conditionVengar)
-- local areaVengar = createCombatArea(AREA_CIRCLE3X3)
-- skillVengar:setArea(areaVengar)


-- local conditionRoot = Condition(CONDITION_ROOTED)
-- condition:setParameter(CONDITION_PARAM_TICKS, 3000)
-- combatRoot:addCondition(condition)

-- local area = createCombatArea(AREA_ROOT_OPRESSOR)
-- combatMaliz3:setArea(area)

-- arr = {
-- 	{ 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
-- 	{ 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
-- 	{ 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
-- 	{ 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0 },
-- 	{ 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0 },
-- }

-- local area1 = createCombatArea(arr)
-- combat:setArea(area1)

-- local bossNames = {
-- 	[name = "Maliz", spell1 = combatMaliz1, spell2 = combatMaliz2, spell3 = combatMaliz3],
-- 	"Vengar",
-- 	"Bruton",
-- 	"Greedok",
-- 	"Vilear",
-- 	"Crultor",
-- 	"Despor"
-- }

-- local skills = {
-- 	skillMaliz,
-- 	skillVengar,
-- }

-- local spell = Spell("instant")

-- local storageMaliz = Game.getStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Maliz)
-- local storageVengar = Game.getStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Vengar)

-- function spell.onCastSpell(creature, var)
-- 	local chanceDragon = math.random(1, 7)
-- 	local chanceSpell = math.random(1, 3)
-- 	local randomSkill = skills[math.random(1, #skills)]
-- 	if chanceDragon == 1 then
-- 		if creature:getName() == "Maliz" then
-- 			if chanceSpell < 3 then
-- 				return skillMaliz:execute(creature, var)
-- 			else
-- 				return skills.randomSkill:execute(creature, var)
-- 			end
-- 	elseif chanceDragon == 2 then
-- 	end

-- 	return combat:execute(creature, var)
-- end

-- spell:name("dragonpack spells")
-- spell:words("###802")
-- spell:isAggressive(true)
-- spell:blockWalls(true)
-- spell:needLearn(true)
-- spell:needDirection(true)
-- spell:register()
