local milkChurn = Action()

function milkChurn.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local creature = Creature(target.uid)
    local activeBoost = player:getExpBoostStamina()
	local house = player:getHouse()

    local skillOrdenhaCount = player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.OrdenhaCount)
    local skillOrdenhaLevel = player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.OrdenhaLevel)
    local skillOrdenhaNextLevel = player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.OrdenhaNextLevel)

    local function updateOrdenhaSkill(player, skillOrdenhaCount, skillOrdenhaLevel, skillOrdenhaNextLevel)
        if skillOrdenhaLevel >= 100 then
            return 
        end

        if skillOrdenhaCount < 1 then
            player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.OrdenhaNextLevel, 2)
            player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.OrdenhaCount, 1)
            player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.OrdenhaLevel, 1)
            player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Milking Skill +1")
        elseif skillOrdenhaCount >= 1 then
            if skillOrdenhaNextLevel == skillOrdenhaCount + 1 then
                player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.OrdenhaNextLevel, skillOrdenhaNextLevel + skillOrdenhaLevel)
                player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.OrdenhaCount, skillOrdenhaCount + 1)
                player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.OrdenhaLevel, skillOrdenhaLevel + 1)
                player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Milking Skill +1")
            else
                player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.OrdenhaCount, skillOrdenhaCount + 1)
                player:say('+ Milking', TALKTYPE_MONSTER_SAY)
            end
        end
        return true
    end

    local storagesorte = player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.LuckLevel)

    if creature and creature:isMonster() then
        local mType = creature:getType():getName()

        if mType == "Cow" and player:getStorageValue(Storage.Quest.Crandoria.FarmSystem.Cow) < os.time() then
            local factor = (player:getLevel() / 50) + storagesorte + skillOrdenhaLevel
            local chance = math.random(factor, 200)

            if chance < 80 then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce falhou ao tentar ordenhar a vaca. Tente novamente em algumas horas.")
                player:setStorageValue(Storage.Quest.Crandoria.FarmSystem.Cow, os.time() + 6 * 60 * 60)
                updateOrdenhaSkill(player, skillOrdenhaCount, skillOrdenhaLevel, skillOrdenhaNextLevel)
                return false
            elseif chance >= 80 and chance < 100 then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce falhou ao tentar ordenhar a vaca. Tente novamente.")
                updateOrdenhaSkill(player, skillOrdenhaCount, skillOrdenhaLevel, skillOrdenhaNextLevel)
                return false
            else
                local chanceTC = math.random(1, 75)
                if chanceTC == 75 then
                    player:addTransferableCoins(1)
                    player:addItem(32198, 1)
                    updateOrdenhaSkill(player, skillOrdenhaCount, skillOrdenhaLevel, skillOrdenhaNextLevel)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ordenhou a vaca e encontrou 1 Tibia Coin!")
                    player:setStorageValue(Storage.Quest.Crandoria.FarmSystem.Cow, os.time() + 6 * 60 * 60)
                    return false
                else
                    if chanceTC > 5 then
                        player:addItem(32198, 1)
                        updateOrdenhaSkill(player, skillOrdenhaCount, skillOrdenhaLevel, skillOrdenhaNextLevel)
                        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ordenhou a vaca.")
                        player:setStorageValue(Storage.Quest.Crandoria.FarmSystem.Cow, os.time() + 6 * 60 * 60)
                        return false
                    else
                        player:addItem(32198, 1)
                        updateOrdenhaSkill(player, skillOrdenhaCount, skillOrdenhaLevel, skillOrdenhaNextLevel)
                        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ordenhou a vaca. Ela parece ainda ter leite...")
                        return false
                    end
                end
            end
        end
    end
    return false
end



milkChurn:id(32011)
milkChurn:register()
