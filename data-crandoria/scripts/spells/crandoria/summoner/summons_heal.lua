local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local weapon = {
	30400, 28716, 34151, 43885, 43886, 36674, 36675, 34091, 43883, 34152, 36668, 36669, 28717, 34090, 43882, 30399
}

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
    local player = creature:getPlayer()
    local position = player:getPosition()
    local handWeapon = player:getSlotItem(CONST_SLOT_LEFT)

    -- Calcula a quantidade de cura usando o valor máximo
    local healthAmount = (player:getLevel() * 0.2 + player:getMagicLevel() * 2) + 20
    local manaCost = 60


    if player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell5) == 1 then
        healthAmount = ((player:getLevel() * 0.2 + player:getMagicLevel() * 2) + 20) * 1.15
        manaCost = 60
    elseif player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell5) == 2 then
        healthAmount = ((player:getLevel() * 0.2 + player:getMagicLevel() * 2) + 20) * 1.2
        manaCost = 60
    end

	if handWeapon then
		if table.contains(weapon, handWeapon.itemid) then 
			if handWeapon.actionid == 13139 then
				healthAmount = healthAmount * 1.02
			elseif handWeapon.actionid == 13140 then
				healthAmount = healthAmount * 1.04
			elseif handWeapon.actionid == 13141 then
				healthAmount = healthAmount * 1.06
			elseif handWeapon.actionid == 13142 then
				local chance = math.random(1, 100)
				if chance < 98 then
                    healthAmount = healthAmount * 1.08
				else
                    healthAmount = healthAmount * 100
				end
			end
		end
	end

    -- Aplica a cura em cada summon do jogador
    local summons = player:getSummons()
    for _, summon in ipairs(summons) do
        if summon:getName() ~= "Anti Afk Orb Anti Noob" and summon:getName() ~= "" and summon:getName() ~= "Healing Totem" then
        summon:addHealth(healthAmount)
        end
    end

    -- Reduz a mana do jogador
    player:addMana(-manaCost)
    player:addManaSpent(manaCost)

    -- Efeito visual
    position:sendMagicEffect(CONST_ME_MAGIC_BLUE)

    return true
end

spell:name("Summons Heal")
spell:words("onora sio")
spell:group("healing")
spell:vocation("summoner;true", "ancient summoner;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_HEAL_FRIEND)
spell:id(312)
spell:cooldown(2000)
spell:groupCooldown(1000)
spell:level(20)
spell:allowOnSelf(false)
spell:isAggressive(false)
spell:isPremium(true)
spell:register()
