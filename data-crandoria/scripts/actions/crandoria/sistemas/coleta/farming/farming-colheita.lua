-- =========================================================
-- COLHEITA ACTION 
-- =========================================================
local harvest = Action()

function harvest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local skillCultivoCount = player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.CultivoCount)
    local skillCultivoLevel = player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.CultivoLevel)
    local skillCultivoNext = player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.CultivoNextLevel)

    local function updateCultivoSkill(player, skillCultivoCount, skillCultivoLevel, skillCultivoNext)
        if skillCultivoLevel >= 100 then
            return 
        end

        if skillCultivoCount < 1 then
            player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.CultivoNextLevel, 2)
            player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.CultivoCount, 1)
            player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.CultivoLevel, 1)
            player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Farming Skill +1")
        elseif skillCultivoCount >= 1 then
            if skillCultivoNext == skillCultivoCount + 1 then
                player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.CultivoNextLevel, skillCultivoNext + skillCultivoLevel + 1)
                player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.CultivoCount, skillCultivoCount + 1)
                player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.CultivoLevel, skillCultivoLevel + 1)
                player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Farming Skill +1")
            else
                player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.CultivoCount, skillCultivoCount + 1)
                player:say('+ Farming', TALKTYPE_MONSTER_SAY)
            end
        end
        return true
    end

    if item.itemid == 5094 then -- Bananas
        local count = math.random(2, 4)
        if item:remove(1) then
            item:getPosition():sendMagicEffect(CONST_ME_SLASH)
            player:addItem(3587, count)
            player:sendTextMessage(MESSAGE_FAILURE, "Voce colheu algumas bananas.")
            updateCultivoSkill(player, skillCultivoCount, skillCultivoLevel, skillCultivoNext)
            return true
        end
    elseif items.itemid == 3742 then -- Fresh Fruits
        local count = math.random(1, 2)
        if item:remove(1) then
            item:getPosition():sendMagicEffect(CONST_ME_SLASH)
            player:addItem(25692, count)
            player:sendTextMessage(MESSAGE_FAILURE, "Voce colheu algumas frutas frescas.")
            updateCultivoSkill(player, skillCultivoCount, skillCultivoLevel, skillCultivoNext)
            return true
        end
    elseif items.itemid == 38823 then -- Pineapple
        local count = math.random(1, 2)
        if item:remove(1) then
            item:getPosition():sendMagicEffect(CONST_ME_SLASH)
            player:addItem(11459, count)
            if count == 1 then
                player:sendTextMessage(MESSAGE_FAILURE, "Voce colheu um abacaxi.")
            else
                player:sendTextMessage(MESSAGE_FAILURE, "Voce colheu alguns abacaxis.")
            end
            updateCultivoSkill(player, skillCultivoCount, skillCultivoLevel, skillCultivoNext)
            return true
        end
    elseif items.itemid == 22292 then -- DragonFruits
        local count = math.random(1, 3)
        if item:remove(1) then
            item:getPosition():sendMagicEffect(CONST_ME_SLASH)
            if count < 3 then
                player:addItem(11682, 1)
                player:sendTextMessage(MESSAGE_FAILURE, "Voce colheu um dragonfruit.")
            else
                player:addItem(11682, 2)
                player:sendTextMessage(MESSAGE_FAILURE, "Voce colheu alguns dragonfruits.")
            end
            updateCultivoSkill(player, skillCultivoCount, skillCultivoLevel, skillCultivoNext)
            return true
        end
    elseif items.itemid == 27459 then -- DragonFruits
        local count = math.random(1, 4)
        if item:remove(1) then
            item:getPosition():sendMagicEffect(CONST_ME_SLASH)
            if count < 4 then
                player:addItem(12252, 1)
                player:sendTextMessage(MESSAGE_FAILURE, "Voce colheu uma winterberry.")
            else
                player:addItem(12252, 2)
                player:sendTextMessage(MESSAGE_FAILURE, "Voce colheu algumas winterberries.")
            end
            updateCultivoSkill(player, skillCultivoCount, skillCultivoLevel, skillCultivoNext)
            return true
        end
    end
end

harvest:aid(12340)
harvest:register()