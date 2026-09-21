local combatPhysical = Combat()
combatPhysical:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatPhysical:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combatPhysical:setParameter(COMBAT_PARAM_USECHARGES, 1)
combatPhysical:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_WHITE_TIGERCLASH) -- ajuste o efeito visual se quiser outro

local combatEnergy = Combat()
combatEnergy:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combatEnergy:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combatEnergy:setParameter(COMBAT_PARAM_USECHARGES, 1)
combatEnergy:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_PINK_TIGERCLASH)

local combatEarth = Combat()
combatEarth:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combatEarth:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combatEarth:setParameter(COMBAT_PARAM_USECHARGES, 1)
combatEarth:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GREEN_TIGERCLASH)

function onGetFormulaValues(player, skill, weaponDamage, attackFactor, basePower)
	local attackValue = calculateAttackValue(player, skill, weaponDamage)
	local spellFactor = 0.9 -- ajuste a intensidade do dano aqui
	local total = calculateMonkSpellDamage(player, skill, weaponDamage, basePower, spellFactor)
	return -total * 0.95, -total * 1.15
end

onGetFormulaValuesEnergy = onGetFormulaValues
onGetFormulaValuesEarth = onGetFormulaValues
onGetFormulaValuesPhysical = onGetFormulaValues

combatPhysical:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValuesPhysical")
combatEnergy:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValuesEnergy")
combatEarth:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValuesEarth")

local combatTypes = {
	["physical"] = combatPhysical,
	["energy"] = combatEnergy,
	["earth"] = combatEarth,
}

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()

	if player:getStorageValue(Storage.Quest.Crandoria.Spells.Spell1) < 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to learn this spell first.")
		return false
	end

	local target = creature:getTarget()
	if not target then
		return false
	end

	local targetPos = target:getPosition()
	local newPos = target:getClosestFreePosition(targetPos, 1, true)

	if not newPos or newPos.x == 0 then
		creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Algo bloqueia seu caminho ate o alvo.")
		return false
	end

	if not creature:getPathTo(newPos) then
		creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Algo bloqueia seu caminho ate o alvo.")
		creature:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	if creature:getPosition().x - target:getPosition().x > 4 or target:getPosition().x - creature:getPosition().x > 4 or creature:getPosition().y - target:getPosition().y > 4 or target:getPosition().y - creature:getPosition().y > 4 then
		creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O alvo esta muito longe.")
		creature:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	creature:getPosition():sendMagicEffect(CONST_ME_THUNDER)
	creature:teleportTo(newPos)
	target:getPosition():sendMagicEffect(CONST_ME_STUN)
	newPos:sendMagicEffect(CONST_ME_POFF)

	local condition = Condition(CONDITION_ROOTED)
	condition:setParameter(CONDITION_PARAM_TICKS, 1000)
	target:addCondition(condition)

	-- Seleciona o combat de acordo com o elemento da arma (mesma lógica do Double Jab)
	local combat = combatPhysical
	local weapon = creature:getSlotItem(CONST_SLOT_LEFT)
	if weapon then
		local itemType = weapon:getType()
		if itemType then
			local elementalBondType = itemType:getElementalBond()
			if elementalBondType then
				combat = combatTypes[elementalBondType] or combat
			end
		end
	end

	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(346)
spell:name("fighter jump")
spell:words("exeta hur")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_DIVINE_CALDERA)
spell:level(8)
spell:mana(400)
spell:basePower(40) -- PLACEHOLDER: ajuste testando em jogo até o dano bater com o esperado
spell:isPremium(true)
spell:needTarget(true)
spell:blockWalls(true)
spell:cooldown(60 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("monk;true", "exalted monk;true")
spell:register()

-- local combat = Combat()
-- combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
-- combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
-- combat:setParameter(COMBAT_PARAM_USECHARGES, 1)

-- function onGetFormulaValues(player, skill, attack, factor)
--     local level = player:getLevel()
--     local fist = player:getSkillLevel(SKILL_FIST)

--     local min = (((level / 5) + (skill + 2 * attack) * 1.1) * 1.2) + (((attack / 6) * fist) / 100)
--     local max = (((level / 5) + (skill + 2 * attack) * 3) * 1.2) + (((attack / 6) * fist) / 100)

--     return -min, -max
-- end

-- combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

-- local spell = Spell("instant")

-- function spell.onCastSpell(creature, var)
--     local target = creature:getTarget()
--     local targetPos = target:getPosition()
--     local newPos = target:getClosestFreePosition(targetPos, 1, true)
--     local player = creature:getPlayer()


--     if player:getStorageValue(Storage.Quest.Crandoria.Spells.Spell1) < 1 then
-- 		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to learn this spell first.")
-- 		return false
--     end

--     if not newPos or newPos.x == 0 then
--         creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Algo bloqueia seu caminho ate o alvo.")
--         return false
--     end

--     if not creature:getPathTo(newPos) then
--         creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Algo bloqueia seu caminho ate o alvo.")
--         creature:getPosition():sendMagicEffect(CONST_ME_POFF)
--         return false
--     end

--     if creature:getPosition().x - target:getPosition().x > 4 or target:getPosition().x - creature:getPosition().x > 4 or creature:getPosition().y - target:getPosition().y > 4 or target:getPosition().y - creature:getPosition().y > 4 then
--         creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O alvo esta muito longe.")
--         creature:getPosition():sendMagicEffect(CONST_ME_POFF)
--         return false
--     end

--     creature:getPosition():sendMagicEffect(CONST_ME_THUNDER)
--     creature:teleportTo(newPos)
--     target:getPosition():sendMagicEffect(CONST_ME_STUN)
--     newPos:sendMagicEffect(CONST_ME_POFF)
--     local condition = Condition(CONDITION_ROOTED)
--     condition:setParameter(CONDITION_PARAM_TICKS, 1000)
--     target:addCondition(condition)
--     combat:execute(creature, var)
--     return true
-- end


-- spell:group("attack")
-- spell:id(346)
-- spell:name("fighter jump")
-- spell:words("exeta hur")
-- spell:castSound(SOUND_EFFECT_TYPE_SPELL_DIVINE_CALDERA)
-- spell:level(8)
-- spell:mana(400)
-- spell:isPremium(true)
-- spell:needTarget(true)
-- spell:blockWalls(true)
-- spell:cooldown(60 * 1000)
-- spell:groupCooldown(2 * 1000)
-- spell:needLearn(false)
-- spell:vocation("monk;true", "exalted monk;true")
-- spell:register()