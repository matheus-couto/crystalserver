
-- =========================================================
-- WATER CAN ACTION 
-- =========================================================
local waterCan = Action()

function waterCan.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    
    -- Storages
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
    end


    if target.actionid == 12340 then
        --------- ESTAGIO 0 ----------
        if target.itemid == 5462 then
            local factorLevel = player:getLevel() / 50
            -- local factorSorte = player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.LuckLevel)
            local arvore = getArvoreDeForcaValues(player)
	        local storagesorte = arvore.luck
            local skillFactor = math.max(1, (skillCultivoLevel + factorLevel + storagesorte + 2))
            local chancePlant = math.random(skillFactor, 200)
            local growTime1 = 1 * 60 * 60
            local growTime2 = 2 * 60 * 60
            local growTime2 = 3 * 60 * 60

            if chancePlant < 110 then -- bananas
                local newPlantId = 5091
                target:setActionId(13159)
                target:getPosition():sendMagicEffect(CONST_ME_LOSEENERGY)
                addEvent(function()
                    target:transform(newPlantId)
                    target:setActionId(12340)
                    target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
                end, growTime1 * 1000)
                local chanceSkill = math.random(1, 3)
                if chanceSkill > 1 then
                    updateCultivoSkill(player, skillCultivoCount, skillCultivoLevel, skillCultivoNext)
                end
                return true
            elseif chancePlant >= 110 and chancePlant < 170 then -- Fresh Fruit
                local newPlantId = 3748
                target:setActionId(13159)
                target:getPosition():sendMagicEffect(CONST_ME_LOSEENERGY)
                addEvent(function()
                    target:transform(newPlantId)
                    target:setActionId(12340)
                    target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
                end, growTime1 * 1000)
                local chanceSkill = math.random(1, 3)
                if chanceSkill > 1 then
                    updateCultivoSkill(player, skillCultivoCount, skillCultivoLevel, skillCultivoNext)
                end
                return true
            elseif chancePlant >= 170 and chancePlant < 190 then -- pineapple
                local newPlantId = 3693
                target:setActionId(13159)
                target:getPosition():sendMagicEffect(CONST_ME_LOSEENERGY)
                addEvent(function()
                    target:transform(newPlantId)
                    target:setActionId(12340)
                    target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
                end, growTime2 * 1000)
                local chanceSkill = math.random(1, 3)
                if chanceSkill > 1 then
                    updateCultivoSkill(player, skillCultivoCount, skillCultivoLevel, skillCultivoNext)
                end
                return true
            elseif chancePlant >= 190 and chancePlant < 198 then -- dragonfruit
                local newPlantId = 3650
                target:setActionId(13159)
                target:getPosition():sendMagicEffect(CONST_ME_LOSEENERGY)
                addEvent(function()
                    target:transform(newPlantId)
                    target:setActionId(12340)
                    target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
                end, growTime3 * 1000)
                local chanceSkill = math.random(1, 3)
                if chanceSkill > 1 then
                    updateCultivoSkill(player, skillCultivoCount, skillCultivoLevel, skillCultivoNext)
                end
                return true
            else -- winterberries
                local newPlantId = 3747
                target:setActionId(13159)
                target:getPosition():sendMagicEffect(CONST_ME_LOSEENERGY)
                addEvent(function()
                    target:transform(newPlantId)
                    target:setActionId(12340)
                    target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
                end, growTime3 * 1000)
                local chanceSkill = math.random(1, 3)
                if chanceSkill > 1 then
                    updateCultivoSkill(player, skillCultivoCount, skillCultivoLevel, skillCultivoNext)
                end
                return true
            end
        --------- BANANA ----------
        elseif target.itemid == 5091 then -- Banana fase 1
            local newPlantId = 5092
            target:setActionId(13159)
            target:getPosition():sendMagicEffect(CONST_ME_LOSEENERGY)
            addEvent(function()
                target:transform(newPlantId)
                target:setActionId(12340)
                target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
            end, growTime1 * 1000)
            local chanceSkill = math.random(1, 3)
            if chanceSkill > 1 then
                updateCultivoSkill(player, skillCultivoCount, skillCultivoLevel, skillCultivoNext)
            end
            return true
        elseif target.itemid == 5092 then -- Banana Fase 2
            local newPlantId = 5094
            target:setActionId(13159)
            target:getPosition():sendMagicEffect(CONST_ME_LOSEENERGY)
            addEvent(function()
                target:transform(newPlantId)
                target:setActionId(12340)
                target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
            end, growTime1 * 1000)
            local chanceSkill = math.random(1, 3)
            if chanceSkill > 1 then
                updateCultivoSkill(player, skillCultivoCount, skillCultivoLevel, skillCultivoNext)
            end
            return true
        elseif target.itemid == 5094 then -- Banana Pronta
            player:say('Pronta para colher', TALKTYPE_MONSTER_SAY)
            target:getPosition():sendMagicEffect(CONST_ME_POFF)
            return true
        --------- FRESH FRUITS ----------
        elseif target.itemid == 3748 then -- Fresh Fruits - Fase 1
            local newPlantId = 3744
            target:setActionId(13159)
            target:getPosition():sendMagicEffect(CONST_ME_LOSEENERGY)
            addEvent(function()
                target:transform(newPlantId)
                target:setActionId(12340)
                target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
            end, growTime1 * 1000)
            local chanceSkill = math.random(1, 3)
            if chanceSkill > 1 then
                updateCultivoSkill(player, skillCultivoCount, skillCultivoLevel, skillCultivoNext)
            end
            return true
        elseif target.itemid == 3744 then -- Fresh Fruits - Fase 2
            local newPlantId = 3742
            target:setActionId(13159)
            target:getPosition():sendMagicEffect(CONST_ME_LOSEENERGY)
            addEvent(function()
                target:transform(newPlantId)
                target:setActionId(12340)
                target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
            end, growTime1 * 1000)
            local chanceSkill = math.random(1, 3)
            if chanceSkill > 1 then
                updateCultivoSkill(player, skillCultivoCount, skillCultivoLevel, skillCultivoNext)
            end
            return true  
        elseif target.itemid == 3742 then -- Fresh Fruits - Pronta
            player:say('Pronta para colher', TALKTYPE_MONSTER_SAY)
            target:getPosition():sendMagicEffect(CONST_ME_POFF)
            return true
        --------- PINEAPPLE ----------
        elseif target.itemid == 3693 then -- Pineapple - Fase 1
            local newPlantId = 38823
            target:setActionId(13159)
            target:getPosition():sendMagicEffect(CONST_ME_LOSEENERGY)
            addEvent(function()
                target:transform(newPlantId)
                target:setActionId(12340)
                target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
            end, growTime2 * 1000)
            local chanceSkill = math.random(1, 3)
            if chanceSkill > 1 then
                updateCultivoSkill(player, skillCultivoCount, skillCultivoLevel, skillCultivoNext)
            end
            return true  
        elseif target.itemid == 38823 then -- Pineapple - Pronta
            player:say('Pronta para colher', TALKTYPE_MONSTER_SAY)
            target:getPosition():sendMagicEffect(CONST_ME_POFF)
            return true
        --------- DRAGONFRUIT ----------
        elseif target.itemid == 3650 then -- Dragonfruit - Fase 1
            local newPlantId = 22292
            target:setActionId(13159)
            target:getPosition():sendMagicEffect(CONST_ME_LOSEENERGY)
            addEvent(function()
                target:transform(newPlantId)
                target:setActionId(12340)
                target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
            end, growTime3 * 1000)
            local chanceSkill = math.random(1, 3)
            if chanceSkill > 1 then
                updateCultivoSkill(player, skillCultivoCount, skillCultivoLevel, skillCultivoNext)
            end
            return true  
        elseif target.itemid == 22292 then -- Dragonfruit - Pronta
            player:say('Pronta para colher', TALKTYPE_MONSTER_SAY)
            target:getPosition():sendMagicEffect(CONST_ME_POFF)
            return true
        --------- WINTERBERRIES ----------
        elseif target.itemid == 3747 then -- Winterberries - Fase 1
            local newPlantId = 27459
            target:setActionId(13159)
            target:getPosition():sendMagicEffect(CONST_ME_LOSEENERGY)
            addEvent(function()
                target:transform(newPlantId)
                target:setActionId(12340)
                target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
            end, growTime3 * 1000)
            local chanceSkill = math.random(1, 3)
            if chanceSkill > 1 then
                updateCultivoSkill(player, skillCultivoCount, skillCultivoLevel, skillCultivoNext)
            end
            return true  
        elseif target.itemid == 27459 then -- Winterberries - Pronta
            player:say('Pronta para colher', TALKTYPE_MONSTER_SAY)
            target:getPosition():sendMagicEffect(CONST_ME_POFF)
            return true
        end
    end
end

waterCan:id(650)
waterCan:register()