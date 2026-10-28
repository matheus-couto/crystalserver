local hellsinHealth = CreatureEvent("hellsinHealth")

function hellsinHealth.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature:isMonster() or creature:getName() ~= "Hellsin" then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    local storageChange = creature:getStorageValue(Storage.Quest.Crandoria.EventoProgramado.HellsinHealthChange)
    local storageHealth = creature:getStorageValue(Storage.Quest.Crandoria.EventoProgramado.HellsinHealth)
    local timeNow = os.time()

    if storageChange < 1 then
        creature:setStorageValue(Storage.Quest.Crandoria.EventoProgramado.HellsinHealth, 1)
        creature:setStorageValue(Storage.Quest.Crandoria.EventoProgramado.HellsinHealthChange, timeNow + 2 * 60)
    else
        if storageChange < timeNow then
            creature:setStorageValue(Storage.Quest.Crandoria.EventoProgramado.HellsinHealth, storageHealth + 1)
            creature:setStorageValue(Storage.Quest.Crandoria.EventoProgramado.HellsinHealthChange, timeNow + 2 * 60)
            creature:teleportTo(Position(4313, 6082, 7))
            local chance = math.random(1, 5)
            if chance == 1 then
                creature:say('ESTOU FICANDO CADA VEZ MAIS FORTE...', TALKTYPE_MONSTER_SAY)
            elseif chance == 2 then
                creature:say('A CADA DANO SOFRIDO EU FICO AINDA MAIS PODEROSO! HA HA HA!', TALKTYPE_MONSTER_SAY)
            elseif chance == 3 then
                creature:say('SEUS PODERES APRIMORAM MINHAS FORCAS!', TALKTYPE_MONSTER_SAY)
            elseif chance == 4 then
                creature:say('VAO PRECISAR DE MAIS PODER QUE ISSO...', TALKTYPE_MONSTER_SAY)
            elseif chance == 5 then
                creature:say('NEM MESMO TODOS VOCES JUNTOS CONSEGUIRAO ME DERROTAR!', TALKTYPE_MONSTER_SAY)
            end
        end
    end

    if storageHealth == 2 then
        return primaryDamage * 0.9, primaryType, secondaryDamage * 0.9, secondaryType
    elseif storageHealth == 3 then
        return primaryDamage * 0.8, primaryType, secondaryDamage * 0.8, secondaryType
    elseif storageHealth == 4 then
        return primaryDamage * 0.7, primaryType, secondaryDamage * 0.7, secondaryType
    elseif storageHealth == 5 then
        return primaryDamage * 0.6, primaryType, secondaryDamage * 0.6, secondaryType
    elseif storageHealth == 6 then
        return primaryDamage * 0.5, primaryType, secondaryDamage * 0.5, secondaryType
    elseif storageHealth == 7 then
        return primaryDamage * 0.4, primaryType, secondaryDamage * 0.4, secondaryType
    elseif storageHealth == 8 then
        return primaryDamage * 0.3, primaryType, secondaryDamage * 0.3, secondaryType
    elseif storageHealth == 9 then
        return primaryDamage * 0.2, primaryType, secondaryDamage * 0.2, secondaryType
    elseif storageHealth >= 10 then
        return primaryDamage * 0.1, primaryType, secondaryDamage * 0.1, secondaryType
    end

    return primaryDamage, primaryType, secondaryDamage, secondaryType
end

hellsinHealth:register()