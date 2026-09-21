local spell = Spell("instant")

function spell.onCastSpell(player, variant)
	local spellStorage = Storage.Quest.Crandoria.ArvoreDeForca.Spell7
	local cd = 0
	local cdStorage = Storage.Quest.Crandoria.ArvoreDeForca.FamiliarCooldown -- use uma storage só para cooldown da spell

	if player:getStorageValue(cdStorage) > os.time() then
		local remaining = player:getStorageValue(cdStorage) - os.time()
		player:sendCancelMessage("Voce precisa esperar " .. math.ceil(remaining ) .. " segundos para usar essa magia novamente.")
		return false
	end

	local grade = player:getStorageValue(spellStorage)
	if grade == 1 then
		cd = 1710
	elseif grade == 2 then
		cd = 1620
	elseif grade == 3 then
		cd = 1530
	elseif grade == 4 then
		cd = 1350
	else
		cd = configManager.getNumber(configKeys.FAMILIAR_TIME) * 60
	end

	player:setStorageValue(cdStorage, os.time() + cd)

	player:CreateFamiliarSpell()
	return true
end

spell:group("support")
spell:id(339)
spell:name("Guardian familiar")
spell:words("utevo gran res guard")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_SUMMON_KNIGHT_FAMILIAR)
spell:level(200)
spell:mana(1000)
spell:cooldown(1) -- valor mínimo aqui, pois vamos controlar por storage
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:isAggressive(false)
spell:vocation("guardian;true", "celestial guardian;true")
spell:register()

-- local spell = Spell("instant")

-- function spell.onCastSpell(player, variant)

-- 	local realcd = 0
-- 	if player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell7) < 1 then
-- 		realcd = configManager.getNumber(configKeys.FAMILIAR_TIME) * 60 * 1000
-- 	elseif player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell7) == 1 then
-- 		realcd = 1710 * 1000
-- 	elseif player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell7) == 2 then
-- 		realcd = 1620 * 1000
-- 	elseif player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell7) == 3 then
-- 		realcd = 1530 * 1000
-- 	elseif player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell7) == 4 then
-- 		realcd = 1350 * 1000
-- 	else
-- 		realcd = configManager.getNumber(configKeys.FAMILIAR_TIME) * 60 * 1000
-- 	end

-- 	player:CreateFamiliarSpell()
-- 	return true
-- end

-- spell:group("support")
-- spell:id(339)
-- spell:name("Guardian familiar")
-- spell:words("utevo gran res guard")
-- spell:castSound(SOUND_EFFECT_TYPE_SPELL_SUMMON_KNIGHT_FAMILIAR)
-- spell:level(200)
-- spell:mana(1000)
-- spell:cooldown(realcd)
-- spell:groupCooldown(2 * 1000)
-- spell:needLearn(false)
-- spell:isAggressive(false)
-- spell:vocation("guardian;true", "celestial guardian;true")
-- spell:register()