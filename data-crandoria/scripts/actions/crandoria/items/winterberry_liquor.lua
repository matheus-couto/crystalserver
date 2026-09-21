local liquor = Action()

function liquor.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	    local player = Player(cid)
    local remainingBoost = player:getExpBoostStamina()
    local currentExpBoostTime = player:getExpBoostStamina()
    local expBoostCount = player:getStorageValue(GameStore.Storages.expBoostCount)
    local house = player:getHouse()
    local activeBoost = player:getExpBoostStamina()

    if activeBoost > 0 then
        player:say('Voce ja possui um Boost ativo.', TALKTYPE_MONSTER_SAY)
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
    else
        if house then
            if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickPrison) > os.time() then
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
                player:say('Voce nao pode utilizar essa pocao pois foi preso nas ultimas 48 horas.', TALKTYPE_MONSTER_SAY)
                return true
            end

            if house:getTown():getId() ~= 13 then
                    player:setStoreXpBoost(50)
                    player:setExpBoostStamina(currentExpBoostTime + 30 * 60)
                    -- player:setExpBoostStamina(0)
                    Item(item.uid):remove(1)
                    player:say('Voce recebeu 30 minutos de Xp Boost!', TALKTYPE_MONSTER_SAY)
                    return true
            else
                player:say('Residentes de Cabanas Amaldicoadas nao podem usar essa pocao.', TALKTYPE_MONSTER_SAY)
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            end
        else
            if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPickPrison) > os.time() then
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
                player:say('Voce nao pode utilizar essa pocao pois foi preso nas ultimas 48 horas.', TALKTYPE_MONSTER_SAY)
                return true
            end
            if player:getExpBoostStamina() < 3 * 60 * 60 then
                player:setStoreXpBoost(50)
                player:setExpBoostStamina(currentExpBoostTime + 30 * 60)
                -- player:setExpBoostStamina(0)
                Item(item.uid):remove(1)
                player:say('Voce recebeu 30 minutos de Xp Boost!', TALKTYPE_MONSTER_SAY)
                return true
            else
                player:say('Voce ja possui mais de tres horas de Xp Boost.', TALKTYPE_MONSTER_SAY)
                return true
            end
        end
    end
end

liquor:id(30202)
liquor:register()