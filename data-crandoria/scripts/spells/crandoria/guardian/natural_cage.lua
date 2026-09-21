local arrLarge = {
	{ 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0 },
	{ 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1 },
	{ 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1 },
	{ 1, 1, 0, 0, 0, 3, 0, 0, 0, 1, 1 },
	{ 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1 },
	{ 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1 },
	{ 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0 },
}

function onCreateWildGrowth(creature, tile)
	local wildGrowth
	if Game.getWorldType() == WORLD_TYPE_NO_PVP then
		wildGrowth = ITEM_WILDGROWTH_SAFE
	else
		wildGrowth = ITEM_WILDGROWTH
	end
	local item = Game.createItem(wildGrowth, 1, tile)
	item:setDuration(3, 5)
end

local combatLarge = Combat()
combatLarge:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
combatLarge:setCallback(CALLBACK_PARAM_TARGETTILE, "onCreateWildGrowth")
combatLarge:setArea(createCombatArea(arrLarge))


local combat = { combatLarge }

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	combatLarge:execute(creature, var)
	return true
end


spell:group("support")
spell:id(337)
spell:name("Natural Cage")
spell:words("exevo gran mas grav")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_WILD_GROWTH_RUNE)
spell:level(800)
spell:mana(2000)
spell:isPremium(true)
spell:needWeapon(true)
spell:isSelfTarget(true)
spell:cooldown(600 * 1000)
spell:groupCooldown(4 * 1000)
spell:needLearn(false)
spell:vocation("guardian;true", "celestial guardian;true")
spell:register()
