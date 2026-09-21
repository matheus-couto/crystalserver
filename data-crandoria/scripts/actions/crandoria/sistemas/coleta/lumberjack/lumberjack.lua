-- =========================================================
-- LUMBERJACK ACTION 
-- =========================================================
local lumberjack = Action()

function lumberjack.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    local pos = target:getPosition()
    local x = pos.x
    local y = pos.y

    local level = player:getLevel()
    -- local sorte = player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.LuckLevel)

    local arvore = getArvoreDeForcaValues(player)
	local storagesorte = arvore.luck

    if storagesorte < 1 then
        storagesorte = 0
    end

    local skillLumberjackCount = player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.LumberjackCount)
    local skillLumberjackLevel = player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.LumberjackLevel)
    local skillLumberjackNext = player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.LumberjackNextLevel)

    local function updateLumberjackSkill(player, skillLumberjackCount, skillLumberjackLevel, skillLumberjackNext)
        if skillLumberjackLevel >= 100 then
            return 
        end

        if skillLumberjackCount < 1 then
            player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.LumberjackNextLevel, 11)
            player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.LumberjackCount, 1)
            player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.LumberjackLevel, 1)
            player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Lumberjack Skill +1")
        elseif skillLumberjackCount >= 1 then
            if skillLumberjackNext == skillLumberjackCount + 1 then
                player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.LumberjackNextLevel, skillLumberjackNext + (skillLumberjackLevel * 10))
                player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.LumberjackCount, skillLumberjackCount + 1)
                player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.LumberjackLevel, skillLumberjackLevel + 1)
                player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Lumberjack Skill +1")
            else
                player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.LumberjackCount, skillLumberjackCount + 1)
                player:say('+ Lumberjack', TALKTYPE_MONSTER_SAY)
            end
        end
        return true
    end

    local trees = {
    [957] = true,
    [3616] = true,
    [3615] = true,
    [3614] = true,
    [3622] = true,
    [3621] = true,
    }

    if x >= 4968 and x <= 5070 and y >= 4862 and y <= 4945 then
        -- if target.itemid == 957 or target.itemid == 3616 or target.itemid == 3615 or target.itemid == 3622 or target.itemid == 3621 or target.itemid == 3614 then
        if trees[target.itemid] then
            if player:getStorageValue(Storage.Quest.Crandoria.Lumberjack.HitTimer) > os.time() then
                player:sendTextMessage(MESSAGE_FAILURE, "Nao va tao rapido.")
                return true
            else
                local chanceHit1 = math.random(1, 2)
                if chanceHit1 > 1 then
                    player:say("TOC", TALKTYPE_MONSTER_SAY, false, nil, toPosition)
                    toPosition:sendMagicEffect(CONST_ME_BLOCKHIT)
                    player:setStorageValue(Storage.Quest.Crandoria.Lumberjack.HitTimer, os.time() + 1)
                    local chanceSkill = math.random(1, 5)
                    if chanceSkill == 5 then
                        updateLumberjackSkill(player, skillLumberjackCount, skillLumberjackLevel, skillLumberjackNext)
                    end
                    return true
                else
                    local factor = (level / 50) + storagesorte + (skillLumberjackLevel / 4)
                    local chance = math.random(factor, 100)
                    if chance <= 40 then
                        player:setStorageValue(Storage.Quest.Crandoria.Lumberjack.HitTimer, os.time() + 1)
                        local chanceHit2 = math.random(1, 2)
                        if chanceHit2 == 1 then
                            player:say("miss", TALKTYPE_MONSTER_SAY, false, nil, toPosition)
                            pos:sendMagicEffect(CONST_ME_POFF)
                            return true
                        else
                            player:say("TOC", TALKTYPE_MONSTER_SAY, false, nil, toPosition)
                            toPosition:sendMagicEffect(CONST_ME_BLOCKHIT)
                            local chanceSkill = math.random(1, 5)
                            if chanceSkill == 5 then
                                updateLumberjackSkill(player, skillLumberjackCount, skillLumberjackLevel, skillLumberjackNext)
                            end
                            return true
                        end
                    else
                        player:say("TOC", TALKTYPE_MONSTER_SAY, false, nil, toPosition)
                        toPosition:sendMagicEffect(CONST_ME_BLOCKHIT)
                        local previousId = target.itemid
                        local finalEffect = math.random(1, 50)
                        target:transform(7958)
                        player:setStorageValue(Storage.Quest.Crandoria.Lumberjack.HitTimer, os.time() + 1)
                        local timer1 = math.random(10, 18)
                        local timer2 = math.random(3, 6)
                        if finalEffect == 50 then
                            addEvent(function()
                                target:transform(3613)
                            end, timer1 * 60 * 1000)
                            return true
                        elseif finalEffect < 50 and finalEffect > 35 then
                            addEvent(function()
                                target:transform(previousId)
                            end, timer2 * 60 * 1000)
                            return true
                        end

                        local chanceSkill = math.random(1, 3)
                        if chanceSkill == 3 then
                            updateLumberjackSkill(player, skillLumberjackCount, skillLumberjackLevel, skillLumberjackNext)
                        end

                        if chance > 40 and chance <= 60 then
                            player:addItem(3127, 1)
                            player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce recebeu algum produto da arvore.")
                            return true
                        elseif chance > 60 and chance <= 75 then
                            player:addItem(3129, 1)
                            player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce recebeu algum produto da arvore.")
                            return true
                        elseif chance > 75 and chance <= 85 then
                            player:addItem(3130, 1)
                            player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce recebeu algum produto da arvore.")
                            return true
                        elseif chance > 85 and chance <= 92 then
                            player:addItem(36722, 1)
                            player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce recebeu algum produto da arvore.")
                            return true
                        elseif chance > 92 and chance <= 98 then
                            player:addItem(31982, 1)
                            player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce recebeu algum produto da arvore.")
                            return true
                        else
                            player:addItem(26074, 1)
                            player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce recebeu algum produto da arvore.")
                            return true
                        end
                    end
                end
            end
        elseif target.itemid == 3613 then
            if player:getStorageValue(Storage.Quest.Crandoria.Lumberjack.HitTimer) > os.time() then
                player:sendTextMessage(MESSAGE_FAILURE, "Nao va tao rapido.")
                return true
            else
                local chanceHit1 = math.random(1, 3)
                if chanceHit1 > 1 then
                    player:say("TOC", TALKTYPE_MONSTER_SAY, false, nil, toPosition)
                    toPosition:sendMagicEffect(CONST_ME_BLOCKHIT)
                    player:setStorageValue(Storage.Quest.Crandoria.Lumberjack.HitTimer, os.time() + 1)
                    local chanceSkill = math.random(1, 5)
                    if chanceSkill == 5 then
                        updateLumberjackSkill(player, skillLumberjackCount, skillLumberjackLevel, skillLumberjackNext)
                    end
                    return true
                else
                    local factor = (level / 50) + storagesorte + (skillLumberjackLevel / 4)
                    local chance = math.random(factor, 100)
                    if chance <= 40 then
                        player:setStorageValue(Storage.Quest.Crandoria.Lumberjack.HitTimer, os.time() + 1)
                        local chanceHit2 = math.random(1, 2)
                        if chanceHit2 == 1 then
                            player:say("miss", TALKTYPE_MONSTER_SAY, false, nil, toPosition)
                            pos:sendMagicEffect(CONST_ME_POFF)
                            return true
                        else
                            player:say("TOC", TALKTYPE_MONSTER_SAY, false, nil, toPosition)
                            toPosition:sendMagicEffect(CONST_ME_BLOCKHIT)
                            local chanceSkill = math.random(1, 5)
                            if chanceSkill == 5 then
                                updateLumberjackSkill(player, skillLumberjackCount, skillLumberjackLevel, skillLumberjackNext)
                            end
                            return true
                        end
                    else
                        player:say("TOC", TALKTYPE_MONSTER_SAY, false, nil, toPosition)
                        toPosition:sendMagicEffect(CONST_ME_BLOCKHIT)
                        local previousId = target.itemid
                        local finalEffect = math.random(1, 50)
                        target:transform(7958)
                        player:setStorageValue(Storage.Quest.Crandoria.Lumberjack.HitTimer, os.time() + 1)

                        local chanceSkill = math.random(1, 2)
                        if chanceSkill == 2 then
                            updateLumberjackSkill(player, skillLumberjackCount, skillLumberjackLevel, skillLumberjackNext)
                        end
                        
                        if chance > 40 and chance <= 65 then
                            player:addItem(36722, 1)
                            player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce recebeu algum produto da arvore.")
                            return true
                        elseif chance > 65 and chance <= 80 then
                            player:addItem(31982, 1)
                            player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce recebeu algum produto da arvore.")
                            return true
                        elseif chance > 80 and chance <= 92 then
                            player:addItem(26074, 1)
                            player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce recebeu algum produto da arvore.")
                            return true
                        else
                            local chanceItem = math.random(1, 3)
                            if chanceItem == 1 then
                                player:addItem(11551, 1)
                                player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce recebeu algum produto especial da arvore.")
                                return true
                            elseif chanceItem == 2 then
                                player:addItem(11547, 1)
                                player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce recebeu algum produto especial da arvore.")
                                return true
                            elseif chanceItem == 3 then
                                player:addItem(11550, 1)
                                player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce recebeu algum produto especial da arvore.")
                                return true
                            end
                        end
                    end
                end
            end
        else
            player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce nao pode usar o machado neste item.")
            toPosition:sendMagicEffect(CONST_ME_POFF)
            return true
        end
    else
        player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce esta fora da area permitida para coleta de madeira.")
        toPosition:sendMagicEffect(CONST_ME_POFF)
        return true
    end
end

lumberjack:id(30283)
lumberjack:register()