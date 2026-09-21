-- local area = createCombatArea({
-- 	{ 0, 0, 1, 0, 0 },
-- 	{ 0, 1, 1, 1, 0 },
-- 	{ 1, 1, 3, 1, 1 },
-- 	{ 0, 1, 1, 1, 0 },
-- 	{ 0, 0, 1, 0, 0 },
-- })

-- local combat = Combat()
-- combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
-- combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
-- combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SPEAR)
-- combat:setParameter(COMBAT_PARAM_IMPACTSOUND, SOUND_EFFECT_TYPE_DIST_ATK_THROW)
-- combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
-- function onGetFormulaValues(player, skill, attack, factor)
-- 	local distanceSkill = player:getEffectiveSkillLevel(SKILL_DISTANCE)
-- 	local min = (player:getLevel() / 5)
-- 	local max = (0.09 * factor) * distanceSkill * 25 + (player:getLevel() / 5)
-- 	return -min, -max
-- end

-- combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")
-- combat:setArea(area)

-- local normalSpear = Weapon(WEAPON_MISSILE)


-- function normalSpear.onUseWeapon(player, variant)
-- 	-- if player:getVocation():getId() == VOCATION_KNIGHT then
-- 	return combat:execute(player, variant)
-- 	-- end
-- end
 

-- normalSpear:id(3277)
-- normalSpear:attack(25)
-- normalSpear:maxHitChance(76)
-- normalSpear:shootType(CONST_ANI_SPEAR)
-- normalSpear:breakChance(0)
-- normalSpear:wieldUnproperly(true)
-- normalSpear:register()
