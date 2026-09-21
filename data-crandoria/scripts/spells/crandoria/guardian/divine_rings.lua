local arrSmall = {
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 1, 1, 3, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
}

local arrLarge = {
	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0 },
	{ 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0 },
	{ 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1 },
	{ 1, 1, 0, 0, 0, 3, 0, 0, 0, 1, 1 },
	{ 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1 },
	{ 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0 },
	{ 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
}

local combatSmall = Combat()
combatSmall:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatSmall:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_STONES)
combatSmall:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combatSmall:setArea(createCombatArea(arrSmall))

local combatSmall1 = Combat()
combatSmall1:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combatSmall1:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
combatSmall1:setArea(createCombatArea(arrSmall))

local combatLarge = Combat()
combatLarge:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combatLarge:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
combatLarge:setArea(createCombatArea(arrLarge))

local combatLarge1 = Combat()
combatLarge1:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatLarge1:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_STONES)
combatLarge1:setArea(createCombatArea(arrLarge))

local condition = Condition(CONDITION_DAZZLED)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:addDamage(14, 3000, -100)
combatLarge:addCondition(condition)


function onGetFormulaValues(player, skill, attack, factor)
	local level = player:getLevel()
	local handWeapon = player:getSlotItem(CONST_SLOT_LEFT)

	local min = (level / 5) + (skill + 2 * attack) * 1.25
	local max = (level / 4) + (skill + 2 * attack) * 3.25

	if handWeapon and handWeapon.itemid == 43866 then
		-- Aplica um multiplicador de 15% aos valores min e max
		NewMin = min * 1.1
		NewMax = max * 1.1

	return -NewMin * 1.1, -NewMax * 1.1

	elseif handWeapon and handWeapon.itemid == 43875 then
		-- Aplica um multiplicador de 15% aos valores min e max
		NewMin2 = min * 1.15
		NewMax2 = max * 1.25

	return -NewMin2 * 1.1, -NewMax2 * 1.1

	elseif handWeapon and handWeapon.itemid == 43875 then
	-- Aplica um multiplicador de 15% aos valores min e max
	NewMin4 = min * 1.25
	NewMax4 = max * 1.25

	return -NewMin4 * 1.1, -NewMax4 * 1.1

	else

	return -min * 1.1, -max * 1.1-- TODO : Use New Real Formula instead of an %

----
end

end
-----
function onGetFormulaValuess(player, level, maglevel)
	local min = (level / 5) + (maglevel * 4) * 1.25
	local max = (level / 5) + (maglevel * 6) * 1.25

	return -min, -max

end




local combats = {combatSmall, combatLarge, combatSmall1, combatLarge1 }

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if player:getStorageValue(Storage.Quest.Crandoria.Spells.Spell1) < 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to learn this spell first.")
		return false
	else
		combatSmall:execute(creature, var)
		combatSmall1:execute(creature, var)
		combatLarge:execute(creature, var)
		combatLarge1:execute(creature, var)
	end
	-- combatSmall:execute(creature, var)
	-- combatSmall1:execute(creature, var)
	-- combatLarge:execute(creature, var)
	-- combatLarge1:execute(creature, var)
	return true
end

combatSmall:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")
combatLarge:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValuess")


spell:group("attack")
spell:id(310)
spell:name("Divine Rings")
spell:words("exevo mas nox")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_DIVINE_CALDERA)
spell:level(700)
spell:mana(2200)
spell:isPremium(true)
spell:needWeapon(true)
spell:isSelfTarget(true)
spell:cooldown(10 * 1000)
spell:groupCooldown(4 * 1000)
spell:needLearn(false)
spell:vocation("guardian;true", "celestial guardian;true")
spell:register()

-- local arrSmall = {
-- 	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 1, 1, 3, 1, 1, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
-- }

-- local arrLarge = {
-- 	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0 },
-- 	{ 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0 },
-- 	{ 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0 },
-- 	{ 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1 },
-- 	{ 1, 1, 0, 0, 0, 3, 0, 0, 0, 1, 1 },
-- 	{ 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1 },
-- 	{ 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0 },
-- 	{ 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0 },
-- 	{ 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
-- }

-- local combatSmall = Combat()
-- combatSmall:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
-- combatSmall:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
-- combatSmall:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_DRAWBLOOD)
-- combatSmall:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
-- combatSmall:setArea(createCombatArea(arrSmall))

-- local combatLarge = Combat()
-- combatLarge:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
-- combatLarge:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYAREA)
-- combatLarge:setArea(createCombatArea(arrLarge))

-- local condition = Condition(CONDITION_DAZZLED)
-- condition:setParameter(CONDITION_PARAM_DELAYED, 1)
-- condition:addDamage(14, 3000, -100)
-- combatLarge:addCondition(condition)

-- function onGetFormulaValues(player, skill, attack, factor)
-- 	local level = player:getLevel()
-- 	local handWeapon = player:getSlotItem(CONST_SLOT_LEFT)

-- 	local min = (level / 5) + (skill + 2 * attack) * 1.1
-- 	local max = (level / 5) + (skill + 2 * attack) * 3

-- 	if handWeapon and handWeapon.itemid == 43868 or handWeapon.itemid == 43864 or handWeapon.itemid == 43866 then
-- 		-- Aplica um multiplicador de 15% aos valores min e max
-- 		NewMin = min * 1.1
-- 		NewMax = max * 1.1

-- 	return -NewMin, -NewMax

-- 	elseif handWeapon and handWeapon.itemid == 43875 or handWeapon.itemid == 43872 or handWeapon.itemid == 43870 then
-- 		-- Aplica um multiplicador de 15% aos valores min e max
-- 		NewMin2 = min * 1.15
-- 		NewMax2 = max * 1.25

-- 	return -NewMin2, -NewMax2

-- 	elseif handWeapon and handWeapon.itemid == 43865 or handWeapon.itemid == 43867 or handWeapon.itemid == 43869 then
-- 	-- Aplica um multiplicador de 15% aos valores min e max
-- 	NewMin3 = min * 1.15
-- 	NewMax3 = max * 1.15

-- 	return -NewMin3, -NewMax3

-- 	elseif handWeapon and handWeapon.itemid == 43873 or handWeapon.itemid == 43875 or handWeapon.itemid == 43871 then
-- 	-- Aplica um multiplicador de 15% aos valores min e max
-- 	NewMin4 = min * 1.25
-- 	NewMax4 = max * 1.25

-- 	return -NewMin4, -NewMax4

-- 	else

-- 	return -min * 1.1, -max * 1.1-- TODO : Use New Real Formula instead of an %

-- ----
-- end

-- end
-- -----
-- function onGetFormulaValuess(player, level, maglevel)
-- 	local min = (level / 5) + (maglevel * 4)
-- 	local max = (level / 5) + (maglevel * 6)

-- 	return -min, -max

-- end




-- local combats = {combatSmall, combatLarge }

-- local spell = Spell("instant")

-- function spell.onCastSpell(creature, var)
-- 	combatSmall:execute(creature, var)
-- 	combatLarge:execute(creature, var)
-- 	return true
-- end

-- combatSmall:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")
-- combatLarge:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValuess")

-- spell:group("attack")
-- spell:id(310)
-- spell:name("Divine Rings")
-- spell:words("exevo mas nox")
-- spell:castSound(SOUND_EFFECT_TYPE_SPELL_DIVINE_CALDERA)
-- spell:level(700)
-- spell:mana(2200)
-- spell:isPremium(true)
-- spell:needWeapon(true)
-- spell:cooldown(10 * 1000)
-- spell:groupCooldown(4 * 1000)
-- spell:needLearn(true)
-- spell:vocation("guardian;true", "celestial guardian;true")
-- spell:register()