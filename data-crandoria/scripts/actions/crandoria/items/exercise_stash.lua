local exerciseItem = Action()

function exerciseItem.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    local druid = player:getVocation():getBaseId() == VOCATION.BASE_ID.DRUID
	local sorcerer = player:getVocation():getBaseId() == VOCATION.BASE_ID.SORCERER
	local monk = player:getVocation():getBaseId() == VOCATION.BASE_ID.MONK
    
    function getHighestSkillType(player)
        local skills = {
            SKILL_DISTANCE,
            SKILL_AXE,
            SKILL_SWORD,
            SKILL_CLUB,
			SKILL_FIST,
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

	if druid then
		if chance <= 50 then
			player:addItem(28556, 500)
			item:remove()
		elseif chance > 50 and chance <= 80 then
			player:addItem(35283, 1800) 
			item:remove()
		elseif chance > 80 then
			player:addItem(35289, 14400) 
			item:remove()
		end
	elseif sorcerer then
		if chance <= 50 then
			player:addItem(28557, 500)
			item:remove()
		elseif chance > 50 and chance <= 80 then
			player:addItem(35284, 1800) 
			item:remove()
		elseif chance > 80 then
			player:addItem(35290, 14400) 
			item:remove()
		end
	else
		if highestSkillType == SKILL_SWORD then
			if chance <= 50 then
				player:addItem(28552, 500)
				item:remove()
			elseif chance > 50 and chance <= 80 then
				player:addItem(35279, 1800)
				item:remove()
			elseif chance > 80 then
				player:addItem(35285, 14400)
				item:remove()
			end
		elseif highestSkillType == SKILL_AXE then
			if chance <= 50 then
				player:addItem(28553, 500)
				item:remove()
			elseif chance > 50 and chance <= 80 then
				player:addItem(35280, 1800) 
				item:remove()
			elseif chance > 80 then
				player:addItem(35286, 14400) 
				item:remove()
			end
		elseif highestSkillType == SKILL_CLUB then
			if chance <= 50 then
				player:addItem(28554, 500)
				item:remove()
			elseif chance > 50 and chance <= 80 then
				player:addItem(35281, 1800) 
				item:remove()
			elseif chance > 80 then
				player:addItem(35287, 14400) 
				item:remove()
			end
		elseif highestSkillType == SKILL_DISTANCE then
			if chance <= 50 then
				player:addItem(28555, 500)
				item:remove()
			elseif chance > 50 and chance <= 80 then
				player:addItem(35282, 1800) 
				item:remove()
			elseif chance > 80 then
				player:addItem(35288, 14400) 
				item:remove()
			end
		elseif highestSkillType == SKILL_FIST then
			if chance <= 50 then
				player:addItem(50293, 500)
				item:remove()
			elseif chance > 50 and chance <= 80 then
				player:addItem(50294, 1800) 
				item:remove()
			elseif chance > 80 then
				player:addItem(50295, 14400) 
				item:remove()
			end
		else
			player:sendTextMessage(MESSAGE_STATUS_WARNING, "No valid skill found.")
		end
	end
end

exerciseItem:id(26186)
exerciseItem:register()