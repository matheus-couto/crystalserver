local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GROUNDSHAKER)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_USECHARGES, 1)
combat:setArea(createCombatArea(AREA_SQUARE1X1))

-- function onGetFormulaValues(player, skill, attack, factor)
-- 	local level = player:getLevel()
	
-- 	local min = (level / 4) + (skill + attack) * 0.9
-- 	local max = (level / 4) + (skill + attack) * 1.6

-- 	return -min * 1.1, -max * 1.1 -- TODO : Use New Real Formula instead of an %
-- end
-----

local weaponStrong = {
	23269, 23285, 23277, 23224, 23246, 23248, 23309, 23317, 23325, 
}

local weaponPowerful = {
	36658, 36660, 36662, 23270, 23278, 23286, 23254, 23256, 23258, 23310, 23318, 23326
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
	local squareRoot = math.sqrt(level)

 	local min = (((level / 5) + (skill + attack) * 0.5) * 1.1 ) + (((attack / 2) * (fist * 0.7)) / 100) + (squareRoot)
 	local max = (((level / 5) + (skill + attack) * 1.65) * 1.1 ) + (((attack / 2) * (fist * 0.7)) / 100) + (squareRoot)

	 if player:getClient().version < 1200 then
		if player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell2) == 1 then
			min = ((((level / 5) + (skill + attack) * 0.5) * 1.1 ) * 1.03) + (((attack / 2) * (fist * 0.7)) / 100) + (squareRoot)
			max = ((((level / 5) + (skill + attack) * 1.65) * 1.1 ) * 1.03) + (((attack / 2) * (fist * 0.7)) / 100) + (squareRoot)
		elseif player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell2) == 2 then
			min = ((((level / 5) + (skill + attack) * 0.5) * 1.1 ) * 1.07) + (((attack / 2) * (fist * 0.7)) / 100) + (squareRoot)
			max = ((((level / 5) + (skill + attack) * 1.65) * 1.1 ) * 1.07) + (((attack / 2) * (fist * 0.7)) / 100) + (squareRoot)
		elseif player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell2) == 3 then
			min = ((((level / 5) + (skill + attack) * 0.5) * 1.1 ) * 1.12) + (((attack / 2) * (fist * 0.7)) / 100) + (squareRoot)
			max = ((((level / 5) + (skill + attack) * 1.65) * 1.1 ) * 1.12) + (((attack / 2) * (fist * 0.7)) / 100) + (squareRoot)
		end
	end

	if handWeapon then
        if table.contains(weaponStrong, handWeapon.itemid) then
            return -min * 1.05, -max * 1.1
		elseif table.contains(weaponPowerful, handWeapon.itemid) then
            return -min * 1.1, -max * 1.15
        else
            return -min, -max
        end
    end

end

-- local arr = {
-- 	{ 0, 0, 0, 0, 0 },
-- 	{ 0, 0, 0, 0, 0 },
-- 	{ 0, 1, 3, 1, 0 },
-- 	{ 0, 1, 0, 1, 0 },
-- 	{ 0, 0, 0, 0, 0 },
-- }

-- local arr = {
-- 	{ 0, 0, 0, 0, 0 },
-- 	{ 0, 1, 1, 1, 0 },
-- 	{ 0, 1, 3, 1, 0 },
-- 	{ 0, 1, 1, 1, 0 },
-- 	{ 0, 0, 0, 0, 0 },
-- }

-- local area = createCombatArea(arr)
-- combat:setArea(area)

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(306)
spell:name("Slash")
spell:words("exori max")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_FIERCE_BERSERK)
spell:level(35)
spell:mana(150)
-- spell:needDirection(true)
spell:isPremium(true)
spell:needWeapon(true)
spell:cooldown(4 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("guardian;true", "celestial guardian;true")
spell:register()