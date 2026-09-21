local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_AGONYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_AGONY)
combat:setParameter(COMBAT_PARAM_CREATEITEM, 43626)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_AGONYDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_AGONY)
combat2:setParameter(COMBAT_PARAM_CREATEITEM, 43626)

local combat3 = Combat()
combat3:setParameter(COMBAT_PARAM_TYPE, COMBAT_AGONYDAMAGE)
combat3:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_AGONY)
combat3:setParameter(COMBAT_PARAM_CREATEITEM, 43626)

local combat4 = Combat()
combat4:setParameter(COMBAT_PARAM_TYPE, COMBAT_AGONYDAMAGE)
combat4:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_AGONY)
combat4:setParameter(COMBAT_PARAM_CREATEITEM, 43626)

local combat5 = Combat()
combat5:setParameter(COMBAT_PARAM_TYPE, COMBAT_AGONYDAMAGE)
combat5:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_AGONY)
combat5:setParameter(COMBAT_PARAM_CREATEITEM, 43626)

local arr = {
	{ 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0 },
	{ 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0 },
	{ 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0 },
	{ 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1 },
	{ 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1 },
	{ 1, 0, 0, 0, 1, 1, 3, 0, 0, 0, 1, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0 },
	{ 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1 },
	{ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0 },
}

local arr2 = {
	{ 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1 },
	{ 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0 },
	{ 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1 },
	{ 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 1, 0 },
	{ 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0 },
	{ 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1 },
	{ 0, 0, 0, 0, 1, 0, 3, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
	{ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1 },
	{ 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0 },
	{ 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0 },
}

local arr3 = {
	{ 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0 },
	{ 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0 },
	{ 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0 },
	{ 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1 },
	{ 1, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0 },
	{ 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0 },
	{ 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1 },
	{ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0 },
	{ 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0 },
	{ 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0 },
	{ 0, 1, 0, 0, 1, 1, 0, 1, 0, 0, 0, 1, 1 },
}

local arr4 = {
	{ 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 1 },
	{ 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0 },
	{ 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1 },
	{ 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0 },
	{ 1, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1 },
	{ 0, 0, 0, 1, 0, 0, 3, 1, 0, 0, 0, 0, 0 },
	{ 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0 },
	{ 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1 },
	{ 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1 },
	{ 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0 },
	{ 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0 },
	{ 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
}

local arr5 = {
	{ 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0 },
	{ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 },
	{ 0, 0, 0, 1, 0, 0, 1, 1, 0, 1, 0, 0, 0 },
	{ 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1 },
	{ 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0 },
	{ 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0 },
	{ 0, 0, 1, 1, 0, 1, 3, 0, 0, 0, 0, 0, 1 },
	{ 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0 },
	{ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1 },
	{ 0, 0, 1, 0, 1, 1, 0, 1, 0, 0, 0, 0, 1 },
	{ 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0 },
	{ 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0 }, 
	{ 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0 },
}

local area1 = createCombatArea(arr)
local area2 = createCombatArea(arr2)
local area3 = createCombatArea(arr3)
local area4 = createCombatArea(arr4)
local area5 = createCombatArea(arr5)


combat:setArea(area1)
combat2:setArea(area2) 
combat3:setArea(area3) 
combat4:setArea(area4) 
combat5:setArea(area5) 

local combats = {combat, combat2, combat3, combat4, combat5}

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
    -- Seleciona aleatoriamente um dos combates da lista
    local selectedCombat = combats[math.random(1, #combats)]
    -- Executa o combate selecionado
    return selectedCombat:execute(creature, var) 
end

spell:name("vemiath explosion")
spell:words("###718")
spell:needLearn(true)
spell:cooldown("10000")
spell:isSelfTarget(true)
spell:register()