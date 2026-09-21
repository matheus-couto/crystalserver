

local rewardExercise = TalkAction("!reward")

function rewardExercise.onSay(player, words, param)

	local druid = player:getVocation():getBaseId() == VOCATION.BASE_ID.DRUID
	local sorcerer = player:getVocation():getBaseId() == VOCATION.BASE_ID.SORCERER
	local summoner = player:getVocation():getBaseId() == VOCATION.BASE_ID.ANCIENT_SUMMONER

	if player:getLevel() < 20 or player:getTown():getId() < TOWNS_LIST.CRANDORIA then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa possuir nivel 20 ou superior e ser habitante de Crandoria para obter sua recompensa.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end

	if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce podera obter essa recompensa apos sair de Viridia.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end
    
    function getHighestSkillType(player)
        local skills = {
            SKILL_DISTANCE,
            SKILL_AXE,
            SKILL_SWORD,
            SKILL_CLUB,
            -- SKILL_MAGLEVEL,
        }
    
        local highestSkillValue = -1  
        local highestSkillType = nil
    
        for _, skillId in ipairs(skills) do
            local skillValue = player:getEffectiveSkillLevel(skillId) or 0
            if skillValue > highestSkillValue then
                highestSkillValue = skillValue
                highestSkillType = skillId
            end
        end
    
        return highestSkillType
    end
    
    local highestSkillType = getHighestSkillType(player)
	local chance = math.random(1, 100)
	if player:getStorageValue(12943) < 1 then
		if druid then
				local exercise = player:addItem(35283, 1800) 
				if exercise then
					exercise:setActionId(player:getGuid())
				end
		elseif sorcerer or summoner then
			local exercise = player:addItem(35284, 1800) 
			if exercise then
				exercise:setActionId(player:getGuid())
			end
		else
			if highestSkillType == SKILL_SWORD then
				local exercise = player:addItem(35279, 1800)
				if exercise then
					exercise:setActionId(player:getGuid())
				end
			elseif highestSkillType == SKILL_AXE then
				local exercise = player:addItem(35280, 1800) 
				if exercise then
					exercise:setActionId(player:getGuid())
				end
			elseif highestSkillType == SKILL_CLUB then
				local exercise = player:addItem(35281, 1800) 
				if exercise then
					exercise:setActionId(player:getGuid())
				end
			elseif highestSkillType == SKILL_DISTANCE then
				local exercise = player:addItem(35282, 1800)
				if exercise then
					exercise:setActionId(player:getGuid())
				end
			else
				player:sendTextMessage(MESSAGE_STATUS_WARNING, "No valid skill found.")
			end
		end
		player:setStorageValue(12943, 2)
	else
		player:sendTextMessage(MESSAGE_STATUS_WARNING, "Voce ja obteve sua recompensa.")
	end

	return true
end

rewardExercise:groupType("normal")
rewardExercise:register()



-- local rewardExercise = TalkAction("!reward")

-- function rewardExercise.onSay(player, words, param)

-- 	local druid = player:getVocation():getBaseId() == VOCATION.BASE_ID.DRUID
-- 	local sorcerer = player:getVocation():getBaseId() == VOCATION.BASE_ID.SORCERER
-- 	local summoner = player:getVocation():getBaseId() == VOCATION.BASE_ID.ANCIENT_SUMMONER

-- 	if player:getLevel() < 20 or player:getTown():getId() < TOWNS_LIST.CRANDORIA then
-- 		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa possuir nivel 20 ou superior e ser habitante de Crandoria para obter sua recompensa.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return true
-- 	end

-- 	if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
-- 		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce podera obter essa recompensa apos sair de Viridia.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return true
-- 	end
    
--     function getHighestSkillType(player)
--         local skills = {
--             SKILL_DISTANCE,
--             SKILL_AXE,
--             SKILL_SWORD,
--             SKILL_CLUB,
--             -- SKILL_MAGLEVEL,
--         }
    
--         local highestSkillValue = -1  
--         local highestSkillType = nil
    
--         for _, skillId in ipairs(skills) do
--             local skillValue = player:getEffectiveSkillLevel(skillId) or 0
--             if skillValue > highestSkillValue then
--                 highestSkillValue = skillValue
--                 highestSkillType = skillId
--             end
--         end
    
--         return highestSkillType
--     end
    
--     local highestSkillType = getHighestSkillType(player)
-- 	local chance = math.random(1, 100)
-- 	if player:getStorageValue(12943) < 1 then
-- 		if druid then
-- 				local exercise = player:addItem(35283, 1800) 
-- 				if exercise then
-- 					exercise:setActionId(player:getGuid())
-- 				end
-- 		elseif sorcerer or summoner then
-- 			local exercise = player:addItem(35284, 1800) 
-- 			if exercise then
-- 				exercise:setActionId(player:getGuid())
-- 			end
-- 		else
-- 			if highestSkillType == SKILL_SWORD then
-- 				local exercise = player:addItem(35279, 1800)
-- 				if exercise then
-- 					exercise:setActionId(player:getGuid())
-- 				end
-- 			elseif highestSkillType == SKILL_AXE then
-- 				local exercise = player:addItem(35280, 1800) 
-- 				if exercise then
-- 					exercise:setActionId(player:getGuid())
-- 				end
-- 			elseif highestSkillType == SKILL_CLUB then
-- 				local exercise = player:addItem(35281, 1800) 
-- 				if exercise then
-- 					exercise:setActionId(player:getGuid())
-- 				end
-- 			elseif highestSkillType == SKILL_DISTANCE then
-- 				local exercise = player:addItem(35282, 1800)
-- 				if exercise then
-- 					exercise:setActionId(player:getGuid())
-- 				end
-- 			else
-- 				player:sendTextMessage(MESSAGE_STATUS_WARNING, "No valid skill found.")
-- 			end
-- 		end
-- 		player:setStorageValue(12943, 2)
-- 	else
-- 		player:sendTextMessage(MESSAGE_STATUS_WARNING, "Voce ja obteve sua recompensa.")
-- 	end

-- 	return true
-- end

-- rewardExercise:groupType("normal")
-- rewardExercise:register()