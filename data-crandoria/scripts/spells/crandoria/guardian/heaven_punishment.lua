local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYAREA)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_USECHARGES, 1)
combat:setArea(createCombatArea(AREA_SQUARE1X1))

local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GROUNDSHAKER)
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat1:setArea(createCombatArea(AREA_SQUARE1X1))

local weaponStrong = {
	43864, 43866, 43868, 43870, 43872, 43874
}

local weaponPowerful = {
	43865, 43867, 43869, 43871, 43873, 43875
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

	-- local min = (level / 3) + (skill + 2 * attack) * 1.1
	-- local max = (level / 3) + (skill + 2 * attack) * 2
	
	-- local min = ((level / 5) + (skill + attack) * 0.5)
	-- local max = ((level / 4) + (skill + attack) * 1.5) + (level / 10)

	local min = ((((level / 5) + (skill + attack) * 1.8) * 1.1) + (((attack / 2) * (fist * 0.7)) / 100) + (squareRoot)) * 0.67
	local max = ((((level / 5) + (skill + attack) * 3.3) * 1.1) + (((attack / 2) * (fist * 0.7)) / 100) + (squareRoot)) * 0.67

	if player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell3) == 1 then
		min = ((((level / 5) + (skill + attack) * 1.8) * 1.13) + (((attack / 2) * (fist * 0.7)) / 100) + (squareRoot)) * 0.67
		max = ((((level / 5) + (skill + attack) * 1.8) * 1.13) + (((attack / 2) * (fist * 0.7)) / 100) + (squareRoot)) * 0.67
	elseif player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell3) == 2 then
		min = ((((level / 5) + (skill + attack) * 1.8) * 1.16) + (((attack / 2) * (fist * 0.7)) / 100) + (squareRoot)) * 0.67
		max = ((((level / 5) + (skill + attack) * 1.8) * 1.16) + (((attack / 2) * (fist * 0.7)) / 100) + (squareRoot)) * 0.67
	elseif player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell3) == 3 then
		min = ((((level / 5) + (skill + attack) * 1.8) * 1.2) + (((attack / 2) * (fist * 0.7)) / 100) + (squareRoot)) * 0.67
		max = ((((level / 5) + (skill + attack) * 1.8) * 1.2) + (((attack / 2) * (fist * 0.7)) / 100) + (squareRoot)) * 0.67
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

-- function onGetFormulaValuess(player, skill, attack, factor)
function onGetFormulaValuess(player, level, maglevel, attack)
	local level = player:getLevel()
	local handWeapon = player:getSlotItem(CONST_SLOT_LEFT)
	local fist = player:getEffectiveSkillLevel(SKILL_FIST)
	local squareRoot = math.sqrt(level)

	-- local min = (level / 5) + (skill + 2 * attack) * 1.1
	-- local max = ((level / 4) + (skill + 2 * attack) * 2.3) + (level / 10)

	-- local min = (level / 5) + (maglevel * 3.5)
	-- local max = (level / 4) + (maglevel * 6) + (level / 10)

	local min = (((level / 5) + (maglevel * 3.75) * 1.1) + (((attack / 2) * (fist * 0.7)) / 100) + (squareRoot)) * 0.33
	local max = (((level / 4) + (maglevel * 6.5) * 1.1) + (((attack / 2) * (fist * 0.7)) / 100) + (squareRoot)) * 0.33

	if player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell3) == 1 then
		min = (((level / 5) + (maglevel * 3.75) * 1.13) + (((attack / 2) * (fist * 0.7)) / 100) + (squareRoot)) * 0.33
		max = (((level / 4) + (maglevel * 6.5) * 1.13) + (((attack / 2) * (fist * 0.7)) / 100) + (squareRoot)) * 0.33
	elseif player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell3) == 2 then
		min = (((level / 5) + (maglevel * 3.75) * 1.16) + (((attack / 2) * (fist * 0.7)) / 100) + (squareRoot)) * 0.33
		max = (((level / 4) + (maglevel * 6.5) * 1.16) + (((attack / 2) * (fist * 0.7)) / 100) + (squareRoot)) * 0.33
	elseif player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell3) == 3 then
		min = (((level / 5) + (maglevel * 3.75) * 1.2) + (((attack / 2) * (fist * 0.7)) / 100) + (squareRoot)) * 0.33
		max = (((level / 4) + (maglevel * 6.5) * 1.2) + (((attack / 2) * (fist * 0.7)) / 100) + (squareRoot)) * 0.33
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
-----

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")
combat1:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValuess")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	combat:execute(creature, var)
	combat1:execute(creature, var)
	return true
end

spell:group("attack")
spell:id(332)
spell:name("Heaven Punishment")
spell:words("exori gran san")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_DIVINE_CALDERA)
spell:level(80)
spell:mana(220)
spell:isPremium(true)
spell:isSelfTarget(true)
spell:cooldown(6 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("guardian;true", "celestial guardian;true")
spell:register()