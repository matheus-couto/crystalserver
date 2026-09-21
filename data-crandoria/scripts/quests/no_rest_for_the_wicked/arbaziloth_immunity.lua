-- CRANDORIA EDIT --

local ArbazilothImmunity = CreatureEvent("ArbazilothImmunity")

function ArbazilothImmunity.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if creature and creature:isMonster() then
		creature:getPosition():sendMagicEffect(CONST_ME_HITAREA)
	end
	-- Zera o dano pra realmente aplicar a imunidade.
	-- Retornar só "true" (como estava antes) não bloqueia nada — o engine
	-- aplica o dano original do mesmo jeito, só não modifica os valores.
	return 0, primaryType, 0, secondaryType, origin
end

ArbazilothImmunity:register()

-- local ArbazilothImmunity = CreatureEvent("ArbazilothImmunity")

-- function ArbazilothImmunity.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
-- 	if creature and creature:isMonster() then
-- 		creature:getPosition():sendMagicEffect(CONST_ME_HITAREA)
-- 	end
-- 	return true
-- end

-- ArbazilothImmunity:register()
