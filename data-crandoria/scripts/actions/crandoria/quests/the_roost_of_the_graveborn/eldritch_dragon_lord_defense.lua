--[[
    Registre esse evento em monster.events do Eldritch Dragon Lord.
    A cada golpe recebido, checa AO VIVO o estado dos 4 cantos (sem Condition,
    sem ticks) e aplica a redução/invulnerabilidade correspondente.
]]

local eldritchDefense = CreatureEvent("EldritchDragonLordDefense")

function eldritchDefense.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if not creature or not creature:isMonster() then
		return primaryDamage, primaryType, secondaryDamage, secondaryType, origin
	end

	if (primaryDamage or 0) >= 0 and (secondaryDamage or 0) >= 0 then
		-- cura ou zero, não mexe
		return primaryDamage, primaryType, secondaryDamage, secondaryType, origin
	end

	local flameTotemCount = 0

	for _, pos in ipairs(EldritchFight.lavaPositions) do
		local tile = Tile(pos)
		local occupant = tile and tile:getTopCreature()
		if occupant and occupant:isMonster() and occupant:getName():lower() == "flame totem" then
			flameTotemCount = flameTotemCount + 1
		end
	end

	if flameTotemCount >= EldritchFight.invulnerabilityFlameTotemThreshold then
		return 0, primaryType, 0, secondaryType, origin
	end

	local reductionPercent = math.min(100, flameTotemCount * EldritchFight.damageReductionPerFlameTotem)
	if reductionPercent <= 0 then
		return primaryDamage, primaryType, secondaryDamage, secondaryType, origin
	end

	local factor = 1 - (reductionPercent / 100)
	local newPrimary = math.ceil((primaryDamage or 0) * factor)
	local newSecondary = math.ceil((secondaryDamage or 0) * factor)

	return newPrimary, primaryType, newSecondary, secondaryType, origin
end

eldritchDefense:register()
