-- local expscroll = Action()

-- function expscroll.onUse(cid, item, fromPosition, itemEx, toPosition)
--     local player = Player(cid)
--     local remainingBoost = player:getExpBoostStamina()
--     local currentExpBoostTime = player:getExpBoostStamina()
--     local expBoostCount = player:getStorageValue(GameStore.Storages.expBoostCount)

--     if expBoostCount >= 3 then -- Xp boost can only be used 3 times a day
--         player:say('Voce ja usou o numero maximo de boosts por um dia.', TALKTYPE_MONSTER_SAY)
--         return true
--     end
    
--     if (remainingBoost > 0) then -- If player still has an active xp boost, don't let him use another one
--         player:say('Voce ja tem um boost de experiencia ativo.', TALKTYPE_MONSTER_SAY)
--         return true
--     end
    
--     player:setStoreXpBoost(50)
--     -- player:setExpBoostStamina(currentExpBoostTime + 3600)
--     player:setExpBoostStamina(0)
--     Item(item.uid):remove(1)
--     player:say('Sua hora de 50% de bonus de experiencia foi iniciado!', TALKTYPE_MONSTER_SAY)
--     return true
-- end

-- expscroll:id(11372)
-- expscroll:register()


local expscroll = Action()

function expscroll.onUse(cid, item, fromPosition, itemEx, toPosition)
    local player = Player(cid)
    local remainingBoost = player:getExpBoostStamina()
    local currentExpBoostTime = player:getExpBoostStamina()
    local expBoostCount = player:getStorageValue(GameStore.Storages.expBoostCount)
    local house = player:getHouse()
    local activeBoost = player:getExpBoostStamina()

    -- if expBoostCount >= 3 then -- Xp boost can only be used 3 times a day
    --     player:say('Voce ja usou o numero maximo de boosts por um dia.', TALKTYPE_MONSTER_SAY)
    --     return true
    -- end
    
    -- if (remainingBoost > 0) then -- If player still has an active xp boost, don't let him use another one
    --     player:say('Voce ja tem um boost de experiencia ativo.', TALKTYPE_MONSTER_SAY)
    --     return true
    -- end
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
                if player:getStorageValue(Storage.Quest.Crandoria.ExpBoost.PotionCooldown) < os.time() then
                    player:setStoreXpBoost(50)
                    player:setExpBoostStamina(currentExpBoostTime + 60 * 60)
                    -- player:setExpBoostStamina(0)
                    Item(item.uid):remove(1)
                    player:setStorageValue(Storage.Quest.Crandoria.ExpBoost.PotionCooldown, os.time() + 4 * 60 * 60)
                    player:say('Sua hora de 50% de bonus de experiencia foi iniciado!', TALKTYPE_MONSTER_SAY)
                    return true
                else
                    player:say('Voce so pode usar uma pocao de Exp Boost a cada 4 horas', TALKTYPE_MONSTER_SAY)
                    player:getPosition():sendMagicEffect(CONST_ME_POFF)
                end
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

            if player:getStorageValue(Storage.Quest.Crandoria.ExpBoost.PotionCooldown) < os.time() then
                if player:getExpBoostStamina() < 3 * 60 * 60 then
                    player:setStoreXpBoost(50)
                    player:setExpBoostStamina(currentExpBoostTime + 60 * 60)
                    -- player:setExpBoostStamina(0)
                    Item(item.uid):remove(1)
                    player:setStorageValue(Storage.Quest.Crandoria.ExpBoost.PotionCooldown, os.time() + 4 * 60 * 60)
                    player:say('Sua hora de 50% de bonus de experiencia foi iniciado!', TALKTYPE_MONSTER_SAY)
                    return true
                else
                    player:say('Voce ja possui mais de tres horas de Xp Boost.', TALKTYPE_MONSTER_SAY)
                    return true
                end
            else
                player:say('Voce so pode usar uma pocao de Exp Boost a cada 4 horas', TALKTYPE_MONSTER_SAY)
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            end
        end
    end


end

expscroll:id(11372)
expscroll:register()