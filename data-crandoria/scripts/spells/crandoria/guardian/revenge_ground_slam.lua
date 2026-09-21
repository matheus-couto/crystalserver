-- local combat = Combat()
-- combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
-- combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GROUNDSHAKER)
-- combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
-- combat:setParameter(COMBAT_PARAM_USECHARGES, 1)

-- local combat1 = Combat()
-- combat1:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_STONES)
-- combat1:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
-- combat1:setParameter(COMBAT_PARAM_USECHARGES, 1)

-- local condition = Condition(CONDITION_PARALYZE)
-- condition:setParameter(CONDITION_PARAM_TICKS, 4000)
-- condition:setFormula(-0.95, 0, -0.95, 0)
-- combat:addCondition(condition)

-- function onGetFormulaValues(player, skill, attack, factor)
-- 	local level = player:getLevel()
-- 	local handWeapon = player:getSlotItem(CONST_SLOT_LEFT)
-- 	local fist = player:getEffectiveSkillLevel(SKILL_FIST)

-- 	local min = (level / 4.5) + (skill + 2 * attack) * 1.1 + (((level / 3) * (fist / 5)) / 100) + (level / 12)
-- 	local max = (level / 4) + (skill + 2 * attack) * 3 + (((level / 3) * (fist / 5)) / 100) + (level / 12)s

-- 	if handWeapon and handWeapon.itemid == 43866 then
-- 		-- Aplica um multiplicador de 15% aos valores min e max
-- 		NewMin = min * 1.15
-- 		NewMax = max * 1.15

-- 		return -NewMin * 1.1, -NewMax * 1.1

-- 	else

-- 		return -min * 1.1, -max * 1.1 -- TODO : Use New Real Formula instead of an %


-- 	end

-- end
-- -----
-- -----

-- local arr = {
-- 	{ 0, 0, 1, 0, 0 },
-- 	{ 0, 1, 1, 1, 0 },
-- 	{ 1, 1, 3, 1, 1 },
-- 	{ 0, 1, 1, 1, 0 },
-- 	{ 0, 0, 1, 0, 0 },
-- }

-- local area = createCombatArea(arr)
-- combat:setArea(area)
-- combat1:setArea(area)

-- combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

-- local spell = Spell("instant")

-- function spell.onCastSpell(creature, var)
-- 	combat:execute(creature, var)
-- 	combat1:execute(creature, var)
-- 	return true
-- end

-- spell:group("attack")
-- spell:id(309)
-- spell:name("Revenge Ground Slam")
-- spell:words("exori gran nox rev")
-- spell:castSound(SOUND_EFFECT_TYPE_SPELL_FIERCE_BERSERK)
-- spell:level(700)
-- spell:mana(400)
-- spell:needDirection(true)
-- spell:isSelfTarget(true)
-- spell:isPremium(true)
-- spell:needWeapon(true)
-- spell:cooldown(6 * 1000)
-- spell:groupCooldown(4 * 1000)
-- spell:needLearn(true)
-- spell:vocation("guardian;true", "celestial guardian;true")
-- spell:register()


local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GROUNDSHAKER)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_USECHARGES, 1)

local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_STONES)
combat1:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat1:setParameter(COMBAT_PARAM_USECHARGES, 1)

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 4000)
condition:setFormula(-0.95, 0, -0.95, 0)
combat:addCondition(condition)

function onGetFormulaValues(player, skill, attack, factor)
	local level = player:getLevel()
	local handWeapon = player:getSlotItem(CONST_SLOT_LEFT)

	local min = (level / 4) + (skill + 2 * attack) * 1.3
	local max = (level / 3.5) + (skill + 2 * attack) * 3.2

	-- if handWeapon and handWeapon.itemid == 43868 or handWeapon.itemid == 43864 or handWeapon.itemid == 43866 then
	-- 	-- Aplica um multiplicador de 15% aos valores min e max
	-- 	NewMin = min * 1.15
	-- 	NewMax = max * 1.15

	-- return -NewMin * 1.1, -NewMax * 1.1

	-- elseif handWeapon and handWeapon.itemid == 43875 or handWeapon.itemid == 43872 or handWeapon.itemid == 43870 then
	-- 	-- Aplica um multiplicador de 15% aos valores min e max
	-- 	NewMin2 = min * 1.15
	-- 	NewMax2 = max * 1.25

	-- return -NewMin2 * 1.1, -NewMax2 * 1.1

	-- elseif handWeapon and handWeapon.itemid == 43865 or handWeapon.itemid == 43867 or handWeapon.itemid == 43869 then
	-- -- Aplica um multiplicador de 15% aos valores min e max
	-- NewMin3 = min * 1.15
	-- NewMax3 = max * 1.25

	-- return -NewMin3 * 1.1, -NewMax3 * 1.1

	-- elseif handWeapon and handWeapon.itemid == 43873 or handWeapon.itemid == 43875 or handWeapon.itemid == 43871 then
	-- -- Aplica um multiplicador de 15% aos valores min e max
	-- NewMin4 = min * 1.25
	-- NewMax4 = max * 1.3

	-- return -NewMin4 * 1.1, -NewMax4 * 1.1

	-- else

	return -min * 1.1, -max * 1.1 -- TODO : Use New Real Formula instead of an %

----
	-- Verifica se o jogador tem o item 43874 equipado na mão
-- end

end
-----
-----

local arr = {
	{ 0, 0, 1, 0, 0 },
	{ 0, 1, 1, 1, 0 },
	{ 1, 1, 3, 1, 1 },
	{ 0, 1, 1, 1, 0 },
	{ 0, 0, 1, 0, 0 },
}

local area = createCombatArea(arr)
combat:setArea(area)
combat1:setArea(area)

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	combat:execute(creature, var)
	combat1:execute(creature, var)
	return true
end

spell:group("attack")
spell:id(309)
spell:name("Revenge Ground Slam")
spell:words("exori gran nox rev")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_FIERCE_BERSERK)
spell:level(250)
spell:mana(400)
spell:needDirection(true)
spell:isSelfTarget(true)
spell:isPremium(true)
spell:needWeapon(true)
spell:cooldown(6 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("guardian;true", "celestial guardian;true")
spell:register()