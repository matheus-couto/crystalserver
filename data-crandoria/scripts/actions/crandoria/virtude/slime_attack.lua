local slimeAttack = CreatureEvent("slimeAttack")

function slimeAttack.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature:isMonster() or creature:getName() ~= "Friendly Slime" then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    if attacker then
    local storage = attacker:getStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso)

        if storage == 6 then
            attacker:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 7)
            attacker:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce atacou um Friendly Slime e quebrou parte do seu juramento. Tenha cuidado!")
        end
    end
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end

slimeAttack:register()