local spell = Spell("instant")

function spell.onCastSpell(player, variant)
    local position = player:getPosition()
    local summonName = "Poison Minion"  -- Nome do monstro a ser invocado
	if player:getStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso) >= 16 then
        summonName = "Poison Minion Stronger"
    end

    if #player:getSummons() >= 2 then
        player:sendCancelMessage("You cannot summon more creatures.")
        position:sendMagicEffect(CONST_ME_POFF)
        return false
    end

    local manaCost = 100  -- Custo de mana para a invocação do Ghoul

    if player:getMana() < manaCost and not player:hasFlag(PlayerFlag_HasInfiniteMana) then
        player:sendCancelMessage(RETURNVALUE_NOTENOUGHMANA)
        position:sendMagicEffect(CONST_ME_POFF)
        return false
    end

    ---
    local spellStorage = Storage.Quest.Crandoria.ArvoreDeForca.Spell7
	local cd = 0
	local cdStorage = Storage.Quest.Crandoria.CooldownSummons.Earth -- use uma storage só para cooldown da spell

	if player:getStorageValue(cdStorage) > os.time() then
		local remaining = player:getStorageValue(cdStorage) - os.time()
		player:sendCancelMessage("Voce precisa esperar " .. math.ceil(remaining ) .. " segundos para usar essa magia novamente.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	local grade = player:getStorageValue(spellStorage)
	if grade == 1 then
		cd = 171
	elseif grade == 2 then
		cd = 162
	elseif grade == 3 then
		cd = 153
	elseif grade == 4 then
		cd = 135
	else
		cd = 180
	end
    ----

    local summon = Game.createMonster(summonName, position, true, false, player)
    if not summon then
        player:sendCancelMessage(RETURNVALUE_NOTENOUGHROOM)
        position:sendMagicEffect(CONST_ME_POFF)
        return false
    end

    -- if player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell7) < 1 then
	-- 	realcd = 180 * 1000
	-- elseif player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell7) == 1 then
	-- 	realcd = 171 * 1000
	-- elseif player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell7) == 2 then
	-- 	realcd = 162 * 1000
	-- elseif player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell7) == 3 then
	-- 	realcd = 153 * 1000
	-- elseif player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell7) == 4 then
	-- 	realcd = 135 * 1000
	-- else
	-- 	realcd = 180 * 1000
	-- end

	player:setStorageValue(cdStorage, os.time() + cd)
    player:addMana(-manaCost)
    player:addManaSpent(manaCost)
    position:sendMagicEffect(CONST_ME_MAGIC_BLUE)
    summon:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    summon:changeSpeed(math.max(player:getSpeed() + ((player:getSpeed() / 10) + 20), 0))
    return true
end

spell:group("focus")
spell:id(316)
spell:name("Summon Poison Minion")
spell:words("onora res tera")
spell:vocation("summonar;true", "ancient summoner")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_CREATURE_ILLUSION)
spell:level(10)
spell:isAggressive(false)
spell:needLearn(false)
spell:cooldown(60 * 1000)
spell:groupCooldown(60 * 1000)
spell:register()
