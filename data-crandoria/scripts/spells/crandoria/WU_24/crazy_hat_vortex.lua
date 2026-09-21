-- local arrGiant = {
-- 	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0 },
-- 	{ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0 },
-- 	{ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 },
-- 	{ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 },
-- 	{ 0, 1, 0, 0, 0, 0, 3, 0, 0, 0, 0, 1, 0 },
-- 	{ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 },
-- 	{ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 },
-- 	{ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0 },
-- 	{ 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
-- }

local arrGiant = {
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 },
	{ 0, 1, 0, 0, 0, 0, 3, 0, 0, 0, 0, 1, 0 },
	{ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
}

local arrSuper = {
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 1, 0, 0, 0, 0, 3, 0, 0, 0, 0, 1, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
}

local arrBigger = {
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
}

local arrLarge = {
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
}

local arrMedium = {
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
}

local arrSmall = {
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
}

local arrSmaller = {
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 },
	{ 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0 },
	{ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
}

-- local arrTiny = {
-- 	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
-- }


local combatGiant = Combat()
combatGiant:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combatGiant:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combatGiant:setArea(createCombatArea(arrGiant))

local combatSuper = Combat()
combatSuper:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combatSuper:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combatSuper:setArea(createCombatArea(arrSuper))

local combatBigger = Combat()
combatBigger:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combatBigger:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combatBigger:setArea(createCombatArea(arrBigger))

local combatLarge = Combat()
combatLarge:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combatLarge:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combatLarge:setArea(createCombatArea(arrLarge))

local combatMedium = Combat()
combatMedium:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combatMedium:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combatMedium:setArea(createCombatArea(arrMedium))

local combatSmall = Combat()
combatSmall:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combatSmall:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combatSmall:setArea(createCombatArea(arrSmall))

local combatSmaller = Combat()
combatSmaller:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combatSmaller:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combatSmaller:setArea(createCombatArea(arrSmaller))

-- local combatTiny = Combat()
-- combatTiny:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
-- combatTiny:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
-- combatTiny:setArea(createCombatArea(arrTiny))

-- function onGetFormulaValues(player, level, maglevel)
-- 	local level = player:getLevel()

-- 	local min = (level / 5) + (maglevel * 10)
-- 	local max = (level / 5) + (maglevel * 14)

-- 	return -min * 1.1, -max * 1.1 -- TODO : Use New Real Formula instead of an %
-- end

-- function onGetFormulaValues2(player, level, maglevel)
-- 	local level = player:getLevel()

-- 	local min = (level / 5) + (maglevel * 10)
-- 	local max = (level / 5) + (maglevel * 14)

-- 	return -min * 1.1, -max * 1.1 -- TODO : Use New Real Formula instead of an %
-- end

-- function onGetFormulaValues3(player, level, maglevel)
-- 	local level = player:getLevel()

-- 	local min = (level / 5) + (maglevel * 10)
-- 	local max = (level / 5) + (maglevel * 14)

-- 	return -min * 1.1, -max * 1.1 -- TODO : Use New Real Formula instead of an %
-- end

-- function onGetFormulaValues4(player, level, maglevel)
-- 	local level = player:getLevel()

-- 	local min = (level / 5) + (maglevel * 10)
-- 	local max = (level / 5) + (maglevel * 14)

-- 	return -min * 1.1, -max * 1.1 -- TODO : Use New Real Formula instead of an %
-- end

-- function onGetFormulaValues5(player, level, maglevel)
-- 	local level = player:getLevel()

-- 	local min = (level / 5) + (maglevel * 10)
-- 	local max = (level / 5) + (maglevel * 14)

-- 	return -min * 1.1, -max * 1.1 -- TODO : Use New Real Formula instead of an %
-- end

-- function onGetFormulaValues6(player, level, maglevel)
-- 	local level = player:getLevel()

-- 	local min = (level / 5) + (maglevel * 10)
-- 	local max = (level / 5) + (maglevel * 14)

-- 	return -min * 1.1, -max * 1.1 -- TODO : Use New Real Formula instead of an %
-- end

-- function onGetFormulaValues7(player, level, maglevel)
-- 	local level = player:getLevel()

-- 	local min = (level / 5) + (maglevel * 10)
-- 	local max = (level / 5) + (maglevel * 14)

-- 	return -min * 1.1, -max * 1.1 -- TODO : Use New Real Formula instead of an %
-- end

-- combatGiant:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
-- combatSuper:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues2")
-- combatBigger:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues3")
-- combatLarge:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues4")
-- combatMedium:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues5")
-- combatSmall:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues6")
-- combatSmaller:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues7")


local spell = Spell("instant")

local combats = { combatSmaller, combatSmall, combatMedium, combatLarge, combatBigger, combatSuper, combatGiant }

-- function spell.onCastSpell(creature, var)
--     local currentIndex = 1  -- Reinicializa o índice ao lançar a spell

--     local function executeCombat()
--         if currentIndex <= #combats then
--             local currentCombat = combats[currentIndex]
--             currentCombat:execute(creature, var)
--             currentIndex = currentIndex + 1
--             addEvent(executeCombat, 300)  -- Ajuste conforme necessário
--         end
--     end

--     executeCombat()
-- end

local lastCastTime = {}

function spell.onCastSpell(creature, var)
    local currentTime = os.time()
    local currentIndex = 1  -- Reinicializa o índice ao lançar a spell

    local function executeCombat()
        if currentIndex <= #combats then
            local currentCombat = combats[currentIndex]
            currentCombat:execute(creature, var)
            currentIndex = currentIndex + 1
            addEvent(executeCombat, 500)  -- Ajuste conforme necessário
        else
            -- Atualiza o tempo de lançamento da última spell
            lastCastTime[creature:getId()] = currentTime
        end
    end

    executeCombat()
    return true
end

spell:name("crazy hat vortex")
spell:words("###730")
spell:needLearn(true)
spell:cooldown("2000")
spell:isSelfTarget(true)
spell:register()