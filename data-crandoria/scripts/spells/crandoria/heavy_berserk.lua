local COOLDOWN_INTERVAL = 10 * 1000

local arrLarge = {
	{ 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 1, 0, 1, 0, 1, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 1, 1, 3, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 1, 0, 1, 0, 1, 0 },
	{ 0, 0, 0, 0, 0, 0, 0 },
}

local arrMedium = {
	{ 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 1, 0, 0, 0, 1, 0 },
	{ 0, 0, 1, 0, 1, 0, 0 },
	{ 0, 0, 0, 3, 0, 0, 0 },
	{ 0, 0, 1, 0, 1, 0, 0 },
	{ 0, 1, 0, 0, 0, 1, 0 },
	{ 0, 0, 0, 0, 0, 0, 0 },
}

local arrSmall = {
	{ 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 1, 1, 3, 1, 1, 0 },
	{ 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0 },
}

local combatLarge = Combat()
combatLarge:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatLarge:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combatLarge:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combatLarge:setArea(createCombatArea(arrLarge))

local combatMedium = Combat()
combatMedium:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatMedium:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combatMedium:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combatMedium:setArea(createCombatArea(arrMedium))

local combatSmall = Combat()
combatSmall:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatSmall:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combatSmall:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combatSmall:setArea(createCombatArea(arrSmall))

function onGetFormulaValues(player, skill, attack, factor)
	local level = player:getLevel()
	local handWeapon = player:getSlotItem(CONST_SLOT_LEFT)

	local min = (level / 5) + (skill + 2 * attack) * 1.1
	local max = (level / 5) + (skill + 2 * attack) * 3

	return -min * 1.1, -max * 1.1 -- TODO : Use New Real Formula instead of an %
end

function onGetFormulaValuess(player, skill, attack, factor)
	local level = player:getLevel()
	local handWeapon = player:getSlotItem(CONST_SLOT_LEFT)

	local level = player:getLevel()	
	local min = (level / 5) + (skill + attack) * 0.8
	local max = (level / 5) + (skill + attack) * 1.1
	return -min * 1.28, -max * 1.28 -- TODO : Use New Real Formula instead of an %
end

function onGetFormulaValuesss(player, skill, attack, factor)
	local level = player:getLevel()
	local handWeapon = player:getSlotItem(CONST_SLOT_LEFT)

	local level = player:getLevel()	
	local min = (level / 5) + (skill + attack) * 0.5
	local max = (level / 5) + (skill + attack) * 1.1
	return -min * 1.28, -max * 1.28 -- TODO : Use New Real Formula instead of an %
end

local spell = Spell("instant")

local combats = {combatSmall, combatMedium, combatLarge }

combatLarge:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")
combatMedium:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValuess")
combatSmall:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValuesss")

function spell.onCastSpell(creature, var)
    local currentIndex = 1  -- Reinicializa o índice ao lançar a spell

    local function executeCombat()
        if currentIndex <= #combats then
            local currentCombat = combats[currentIndex]
            currentCombat:execute(creature, var)
            currentIndex = currentIndex + 1
            addEvent(executeCombat, 500)  -- Ajuste conforme necessário
        end
    end

    executeCombat()
end

spell:group("attack", "focus")
spell:id(300)
spell:name("Heavy Berserk")
spell:words("exori gran ton")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_FIERCE_BERSERK)
spell:level(600)
spell:mana(500)
spell:isSelfTarget(true)
spell:isPremium(true)
spell:needWeapon(true)
spell:cooldown(10000)
spell:groupCooldown(4000)
spell:needLearn(true)
spell:vocation("knight;true", "elite knight;true")
spell:register()