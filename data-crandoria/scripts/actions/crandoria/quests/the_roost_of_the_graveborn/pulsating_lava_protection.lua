--[[
    Impede que o monstro morra de verdade: se um golpe fosse reduzir a vida
    pra 0 ou menos, o dano é limitado de forma que a vida pare exatamente no
    piso mínimo (EldritchFight.minHealthFloor). Isso é feito a cada golpe,
    então funciona como "imortalidade" enquanto estiver nesse piso — não é
    uma invulnerabilidade fixa, é um limite dinâmico recalculado a cada hit.

    Registre esse evento em monster.events do Pulsating Lava. Veja a nota no
    final sobre se você também quer isso no Eruption/Flame Totem.
]]

local pulsatingLavaProtection = CreatureEvent("PulsatingLavaProtection")

function pulsatingLavaProtection.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if not creature or not creature:isMonster() then
		return primaryDamage, primaryType, secondaryDamage, secondaryType, origin
	end

	local totalDamage = (primaryDamage or 0) + (secondaryDamage or 0)
	if totalDamage >= 0 then
		-- não é dano (é cura ou zero), deixa passar sem mexer
		return primaryDamage, primaryType, secondaryDamage, secondaryType, origin
	end

	local currentHealth = creature:getHealth()
	local floor = EldritchFight.minHealthFloor

	if currentHealth + totalDamage > floor then
		-- esse golpe não chega perto do piso, deixa passar normal
		return primaryDamage, primaryType, secondaryDamage, secondaryType, origin
	end

	-- Limita o dano total pra vida parar exatamente no piso
	local allowedTotalDamage = -(currentHealth - floor)
	if allowedTotalDamage > 0 then
		allowedTotalDamage = 0
	end

	return allowedTotalDamage, primaryType, 0, secondaryType, origin
end

pulsatingLavaProtection:register()
