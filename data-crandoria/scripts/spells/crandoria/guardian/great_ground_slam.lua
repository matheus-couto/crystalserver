local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GROUNDSHAKER)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_USECHARGES, 1)

local combat1 = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_STONES)

-- function onGetFormulaValues(player, skill, attack, factor)
-- 	local level = player:getLevel()
-- 	local handWeapon = player:getSlotItem(CONST_SLOT_LEFT)

-- 	local min = (level / 5) + (skill + 2 * attack) * 1.18
-- 	local max = (level / 4) + (skill + 2 * attack) * 3

-- 	return -min * 1.1, -max * 1.1 -- TODO : Use New Real Formula instead of an %

-- ----
-- end
local weaponStrong = {
	23297, 23251, 23337
}

local weaponPowerful = {
	23298, 23261, 23338, 31414
}

function table.contains(table, element)
	for _, value in pairs(table) do
		if value == element then
			return true
		end
	end
	return false
end

function onGetFormulaValues(player, skill, attack, factor)
	local level = player:getLevel()
	local handWeapon = player:getSlotItem(CONST_SLOT_LEFT)
	local fist = player:getEffectiveSkillLevel(SKILL_FIST)
	local fist = player:getEffectiveSkillLevel(SKILL_FIST)
	local squareRoot = math.sqrt(level)


	local min = (((level / 5) + (skill + 2 * attack) * 1.1) * 1.1) + (((attack / 2) * (fist * 0.9)) / 100) + (squareRoot)
	local max = (((level / 5) + (skill + 2 * attack) * 2.2) * 1.1) + (((attack / 2) * (fist * 0.9)) / 100) + (squareRoot)

	if handWeapon then
        if table.contains(weaponStrong, handWeapon.itemid) then
            return -min * 1.05, -max * 1.1
		elseif table.contains(weaponPowerful, handWeapon.itemid) then
            return -min * 1.1, -max * 1.15
        else
            return -min, -max
        end
	else
		return -min, -max
    end


end
-----

local arr = {
	{ 1, 1, 1, 1, 1 },
	{ 1, 1, 1, 1, 1 },
	{ 0, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 0 },
	{ 0, 0, 1, 0, 0 },
	{ 0, 0, 3, 0, 0 },
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
spell:id(308)
spell:name("Great Ground Slam")
spell:words("exori gran nox")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_FIERCE_BERSERK)
spell:level(110)
spell:mana(200)
spell:isPremium(true)
spell:needWeapon(true)
spell:needDirection(true)
spell:cooldown(6 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("guardian;true", "celestial guardian;true")
spell:register()