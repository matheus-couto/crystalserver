local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
    -- Verificações de segurança
    if not creature or not creature:isMonster() then
        return false
    end

    local healthThreshold = 260000
    local storageCooldown = 66626
    local currentTime = os.time()

    -- Verifica se a vida está abaixo do limite
    if creature:getHealth() >= healthThreshold then
        return false
    end

    -- Verifica o cooldown via storage
    local lastTime = Game.getStorageValue(storageCooldown)
    if lastTime == -1 then lastTime = 0 end
    if currentTime < lastTime then
        return false
    end

    -- Define nova duração de cooldown (20 minutos)
    Game.setStorageValue(storageCooldown, currentTime + 20 * 60)

    -- Envia a mensagem em cor laranja
    creature:say("ENOUGH! I WILL MAKE YOU SUFFER FOR YOUR INSOLENCE! NOW - I - WILL - ANIHILATE - YOU!", TALKTYPE_MONSTER_YELL, false, nil, creature:getPosition(), TEXTCOLOR_ORANGE)
    local hp = creature:getHealth()
    -- Salva a posição e remove o boss atual
    local pos = creature:getPosition()
    creature:remove()

    -- Cria o novo monstro na posição do anterior
    local newBoss = Game.createMonster("Goshnar's Megalomania 3", pos)
        if newBoss then
            newBoss:setHealth(hp)
        end

    return true
end

spell:name("megalomania blue")
spell:words("###762")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()