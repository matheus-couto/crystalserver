local pocaoReinicio = Action()
function pocaoReinicio.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    local baseVocation = Vocation(VOCATION.ID.NONE)
	local level = player:getLevel()

    local storage = player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Geral)
    local storagelife = player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.LifeLevel)
    local storagemana = player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.ManaLevel)
    local storagesorte = player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.LuckLevel)
    local storagerep = player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.RepLevel)


    if storage > 0 then

        if storagelife > 0 then
            player:setMaxHealth(newlife)
            player:setStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.LifeLevel, 0)
        end

        if storagemana > 0 then
            player:setMaxHealth(newmana)
            player:setStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.ManaLevel, 0)
        end

        if storagesorte > 0 then
            player:setStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.LuckLevel, 0)
        end

        if storagerep > 0 then
            player:setStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.RepLevel, 0)
        end

        player:setStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell1, 0)
        player:setStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell2, 0)
        player:setStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell3, 0)
        player:setStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell4, 0)
        player:setStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell5, 0)
        player:setStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell6, 0)
        player:setStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Spell7, 0)
        player:setStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Geral, 0)
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "Seus pontos de habilidade foram reiniciados.")
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
        item:remove(1)
        return true

    else
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "Voce nao possui pontos distribuidos para reiniciar.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true

    end

end

pocaoReinicio:id(39145)
pocaoReinicio:register()