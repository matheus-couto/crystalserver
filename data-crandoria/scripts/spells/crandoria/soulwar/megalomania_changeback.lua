local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
    if not creature or not creature:isMonster() then
        return false
    end

    -- Captura vida atual e posição do monstro original
    local currentHealth = creature:getHealth()
    local pos = creature:getPosition()

    -- Remove o monstro atual
    creature:remove()

    -- Cria o novo monstro no mesmo lugar
    local newBoss = Game.createMonster("Goshnar's Megalomania", pos)
    if newBoss then
        newBoss:setHealth(currentHealth)
    else
        print("[Warning] Failed to create 'Goshnar's Megalomania' at position:", pos)
    end

    return true
end

spell:name("megalomania changeback")
spell:words("###757")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()
