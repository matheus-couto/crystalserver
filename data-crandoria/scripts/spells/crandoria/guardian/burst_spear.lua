local arr = {
	{ 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 1, 1, 3, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0 },
}


local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ETHEREALSPEAR)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setArea(createCombatArea(arr))


function onGetFormulaValues(player, skill, attack)
	local level = player:getLevel()
	local skill = player:getEffectiveSkillLevel(SKILL_DISTANCE)
	local magicLevel = player:getMagicLevel()

	local min = (level / 6) + ((skill + attack) / 3) + (magicLevel / 2)
	local max = (level / 5) + (skill + attack / 1.5) + (magicLevel)

	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	local handWeapon = player:getSlotItem(CONST_SLOT_LEFT)
	if handWeapon then
		if handWeapon.itemid == 3277 or handWeapon.itemid == 3347 or handWeapon.itemid == 7367 or handWeapon.itemid == 7378 or handWeapon.itemid == 21158 or handWeapon.itemid == 6534 or handWeapon.itemid == 40535 or handWeapon.itemid == 32225 or handWeapon.itemid == 31414 or handWeapon.itemid == 23297 or handWeapon.itemid == 23251  or handWeapon.itemid == 23337 or handWeapon.itemid == 23298 or handWeapon.itemid == 23261 or handWeapon.itemid == 23338 then
			return combat:execute(creature, var)
		else
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			player:sendCancelMessage("You need a spear to use this spell.")
			return true
		end
    else
    	player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendCancelMessage("You need a spear to use this spell.")
		return true
	end
end

spell:group("attack")
spell:id(340)
spell:name("Burst Spear")
spell:words("exori con mas")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_ETHEREAL_SPEAR)
spell:level(65)
spell:mana(125)
spell:isPremium(true)
spell:range(4)
spell:needTarget(true)
spell:blockWalls(true)
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("guardian;true", "celestial guardian;true")
spell:register()
