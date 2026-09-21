-- local COOLDOWN_INTERVAL = 10 * 1000

-- local arrLarge = {
-- 	{ 0, 0, 1, 1, 1, 0, 0 },
-- 	{ 0, 1, 1, 0, 1, 1, 0 },
-- 	{ 1, 1, 0, 0, 0, 1, 1 },
-- 	{ 1, 0, 0, 3, 0, 0, 1 },
-- 	{ 1, 1, 0, 0, 0, 1, 1 },
-- 	{ 0, 1, 1, 0, 1, 1, 0 },
-- 	{ 0, 0, 1, 1, 1, 0, 0 },
-- }

-- local arrMedium = {
-- 	{ 0, 0, 0, 0, 0, 0, 0 },
-- 	{ 0, 0, 1, 1, 1, 0, 0 },
-- 	{ 0, 1, 1, 0, 1, 1, 0 },
-- 	{ 0, 1, 0, 3, 0, 1, 0 },
-- 	{ 0, 1, 1, 0, 1, 1, 0 },
-- 	{ 0, 0, 1, 1, 1, 0, 0 },
-- 	{ 0, 0, 0, 0, 0, 0, 0 },
-- }

-- local arrSmall = {
-- 	{ 0, 0, 0, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 0, 0, 0 },
-- 	{ 0, 0, 1, 1, 1, 0, 0 },
-- 	{ 0, 0, 1, 3, 1, 0, 0 },
-- 	{ 0, 0, 1, 1, 1, 0, 0 },
-- 	{ 0, 0, 0, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 0, 0, 0 },
-- }

-- local combatLarge = Combat()
-- combatLarge:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
-- combatLarge:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
-- combatLarge:setArea(createCombatArea(arrLarge))

-- local combatMedium = Combat()
-- combatMedium:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
-- combatMedium:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
-- combatMedium:setArea(createCombatArea(arrMedium))

-- local combatSmall = Combat()
-- combatSmall:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
-- combatSmall:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
-- combatSmall:setArea(createCombatArea(arrSmall))

-- function onGetFormulaValues(player, level, maglevel)
-- 	local level = player:getLevel()

-- 	local min = (level / 5) + (maglevel * 10)
-- 	local max = (level / 5) + (maglevel * 14)

-- 	return -min * 1.1, -max * 1.1 -- TODO : Use New Real Formula instead of an %
-- end

-- function onGetFormulaValuess(player, level, maglevel)
-- 	local level = player:getLevel()	

-- 	local min = (level / 5) + (maglevel * 9)
-- 	local max = (level / 5) + (maglevel * 10)
-- 	return -min * 1.28, -max * 1.28 -- TODO : Use New Real Formula instead of an %
-- end

-- function onGetFormulaValuesss(player, level, maglevel)
-- 	local level = player:getLevel()	

-- 	local min = (level / 5) + (maglevel * 7)
-- 	local max = (level / 5) + (maglevel * 8)
-- 	return -min * 1.28, -max * 1.28 -- TODO : Use New Real Formula instead of an %
-- end

-- local spell = Spell("instant")

-- local combats = {combatSmall, combatMedium, combatLarge }

-- combatLarge:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
-- combatMedium:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValuess")
-- combatSmall:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValuesss")

-- function spell.onCastSpell(creature, var)
--     local currentIndex = 1  -- Reinicializa o índice ao lançar a spell

--     local function executeCombat()
--         if currentIndex <= #combats then
--             local currentCombat = combats[currentIndex]
--             currentCombat:execute(creature, var)
--             currentIndex = currentIndex + 1
--             addEvent(executeCombat, 250)  -- Ajuste conforme necessário
--         end
--     end

--     executeCombat()
-- end

-- spell:group("attack", "focus")
-- spell:id(338)
-- spell:name("Death Scream")
-- spell:words("exevo gran mort nox")
-- spell:impactSound(SOUND_EFFECT_TYPE_SPELL_DEATH_STRIKE)
-- spell:level(120)
-- spell:mana(1200)
-- spell:isSelfTarget(true)
-- spell:isPremium(true)
-- spell:cooldown(30 * 1000)
-- spell:groupCooldown(4 * 1000)
-- spell:needLearn(false)
-- spell:vocation("summoner;true", "ancient summoner;true")
-- spell:register()


local COOLDOWN_INTERVAL = 10 * 1000

local arrLarge = {
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 1, 1, 0, 1, 1, 0 },
	{ 1, 1, 0, 0, 0, 1, 1 },
	{ 1, 0, 0, 3, 0, 0, 1 },
	{ 1, 1, 0, 0, 0, 1, 1 },
	{ 0, 1, 1, 0, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
}

local arrMedium = {
	{ 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 1, 1, 0, 1, 1, 0 },
	{ 0, 1, 0, 3, 0, 1, 0 },
	{ 0, 1, 1, 0, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0 },
}

local arrSmall = {
	{ 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 0, 1, 3, 1, 0, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0 },
}

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

function onGetFormulaValues(player, level, maglevel)
	local level = player:getLevel()

	local min = (level / 5) + (maglevel * 8)
	local max = (level / 5) + (maglevel * 12)

	if player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell1) == 1 then
		min = (level / 5) + (maglevel * 8) * 1.05
		max = (level / 5) + (maglevel * 12) * 1.05
	elseif player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell1) == 2 then
		min = (level / 5) + (maglevel * 8) * 1.1
		max = (level / 5) + (maglevel * 12) * 1.1
	elseif player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell1) == 3 then
		min = (level / 5) + (maglevel * 8) * 1.15
		max = (level / 5) + (maglevel * 12) * 1.15
	end

	return -min * 1.1, -max * 1.1 -- TODO : Use New Real Formula instead of an %
end

function onGetFormulaValuess(player, level, maglevel)
	local level = player:getLevel()	

	local min = (level / 5) + (maglevel * 8)
	local max = (level / 5) + (maglevel * 10)

	if player:getClient().version < 1200 then
		if player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell1) == 1 then
			min = (level / 5) + (maglevel * 8) * 1.05
			max = (level / 5) + (maglevel * 10) * 1.05
		elseif player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell1) == 2 then
			min = (level / 5) + (maglevel * 8) * 1.1
			max = (level / 5) + (maglevel * 10) * 1.1
		elseif player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell1) == 3 then
			min = (level / 5) + (maglevel * 8) * 1.15
			max = (level / 5) + (maglevel * 10) * 1.15
		end
	end

	return -min * 1.1, -max * 1.1 -- TODO : Use New Real Formula instead of an %
end

function onGetFormulaValuesss(player, level, maglevel)
	local level = player:getLevel()	

	local min = (level / 5) + (maglevel * 7)
	local max = (level / 5) + (maglevel * 8)

	if player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell1) == 1 then
		min = (level / 5) + (maglevel * 7) * 1.05
		max = (level / 5) + (maglevel * 8) * 1.05
	elseif player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell1) == 2 then
		min = (level / 5) + (maglevel * 7) * 1.1
		max = (level / 5) + (maglevel * 8) * 1.1
	elseif player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell1) == 3 then
		min = (level / 5) + (maglevel * 7) * 1.15
		max = (level / 5) + (maglevel * 8) * 1.15
	end

	return -min * 1.1, -max * 1.1 -- TODO : Use New Real Formula instead of an %
end

local spell = Spell("instant")

local combats = {combatSmall, combatMedium, combatLarge }

combatLarge:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
combatMedium:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValuess")
combatSmall:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValuesss")

local lastCastTime = {}

function spell.onCastSpell(creature, var)
    local currentTime = os.time()

    -- Verifica se o cooldown já passou
    if lastCastTime[creature:getId()] and (currentTime - lastCastTime[creature:getId()]) < (spell:cooldown() / 1000) then
        creature:getPlayer():sendCancelMessage("Ainda está em cooldown.")
        return false
    end

    local currentIndex = 1  -- Reinicializa o índice ao lançar a spell

    local function executeCombat()
        if currentIndex <= #combats then
            local currentCombat = combats[currentIndex]
            currentCombat:execute(creature, var)
            currentIndex = currentIndex + 1
            addEvent(executeCombat, 250)  -- Ajuste conforme necessário
        else
            -- Atualiza o tempo de lançamento da última spell
            lastCastTime[creature:getId()] = currentTime
        end
    end

    executeCombat()
    return true
end

spell:group("attack", "focus")
spell:id(338)
spell:name("Death Scream")
spell:words("exevo gran mort nox")
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_DEATH_STRIKE)
spell:level(120)
spell:mana(1200)
spell:isSelfTarget(true)
spell:isPremium(true)
spell:cooldown(10 * 1000)
spell:groupCooldown(4 * 1000)
spell:needLearn(false)
spell:vocation("summoner;true", "ancient summoner;true")
spell:register()