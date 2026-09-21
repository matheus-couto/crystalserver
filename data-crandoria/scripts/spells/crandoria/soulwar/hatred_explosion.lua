local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONHIT)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

-- Posição onde o item será verificado
local checkPos = Position(33743, 31599, 14)

-- Tabela de valores de dano baseada no item presente
local itemIdMap = {
	[34009] = {min = -1400, max = -2900},
	[34010] = {min = -1700, max = -3300},
	[34011] = {min = -2000, max = -3700},
	[34012] = {min = -2300, max = -4100},
	[34013] = {min = -2600, max = -4500}
}

function onTargetCreature(creature, target)
	local min, max = -1400, -2900 -- default

	local tile = Tile(checkPos)
	if tile then
		for id, values in pairs(itemIdMap) do
			local item = tile:getItemById(id)
			if item then
				min = values.min
				max = values.max
				break
			end
		end
	end

	doTargetCombatHealth(creature, target, COMBAT_DEATHDAMAGE, min, max, CONST_ME_EXPLOSIONHIT)
	return true
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local spell = Spell("instant")
function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:name("hatred explosion")
spell:words("###749")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()
