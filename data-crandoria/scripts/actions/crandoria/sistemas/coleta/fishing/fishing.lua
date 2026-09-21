local exhaustAttackGroup = Condition(CONDITION_SPELLGROUPCOOLDOWN)
exhaustAttackGroup:setParameter(CONDITION_PARAM_SUBID, 1)
exhaustAttackGroup:setParameter(CONDITION_PARAM_TICKS, 5000)

local exhaustHealGroup = Condition(CONDITION_SPELLGROUPCOOLDOWN)
exhaustHealGroup:setParameter(CONDITION_PARAM_SUBID, 2)
exhaustHealGroup:setParameter(CONDITION_PARAM_TICKS, 5000)

local exhaustSupportGroup = Condition(CONDITION_SPELLGROUPCOOLDOWN)
exhaustSupportGroup:setParameter(CONDITION_PARAM_SUBID, 3)
exhaustSupportGroup:setParameter(CONDITION_PARAM_TICKS, 5000)

local exhaustFourthGroup = Condition(CONDITION_SPELLGROUPCOOLDOWN)
exhaustFourthGroup:setParameter(CONDITION_PARAM_SUBID, 4)
exhaustFourthGroup:setParameter(CONDITION_PARAM_TICKS, 5000)

local exhaustFifthGroup = Condition(CONDITION_SPELLGROUPCOOLDOWN)
exhaustFifthGroup:setParameter(CONDITION_PARAM_SUBID, 5)
exhaustFifthGroup:setParameter(CONDITION_PARAM_TICKS, 5000)

local exhaustSixthGroup = Condition(CONDITION_SPELLGROUPCOOLDOWN)
exhaustSixthGroup:setParameter(CONDITION_PARAM_SUBID, 6)
exhaustSixthGroup:setParameter(CONDITION_PARAM_TICKS, 5000)

local exhaustSeventhGroup = Condition(CONDITION_SPELLGROUPCOOLDOWN)
exhaustSeventhGroup:setParameter(CONDITION_PARAM_SUBID, 7)
exhaustSeventhGroup:setParameter(CONDITION_PARAM_TICKS, 5000)


local now = os.date("*t")
local day = now.day
local month = now.month

-- Checar se está entre 21 de junho (21/6) e 21 de setembro (21/9)
local isInRange1 = (month == 6 and day >= 21) or (month == 7) or (month == 8) or (month == 9 and day < 21)

-- Primavera: 21 de setembro até 20 de dezembro
local isInRange2 = (month == 9 and day >= 21) or (month == 10) or (month == 11) or (month == 12 and day < 21)

-- Inverno: 21 de dezembro até 20 de março
local isInRange3 = (month == 12 and day >= 21) or (month == 1) or (month == 2) or (month == 3 and day < 21)

-- Outono: 21 de março até 20 de junho
local isInRange4 = (month == 3 and day >= 21) or (month == 4) or (month == 5) or (month == 6 and day < 21)


local lootTrash = { 3031 }
local lootCommon = { 3031, 3031, 3031, 3031, 3031, 3578, 3578, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035 }
local lootUncommon = { 3031, 3031, 3031, 3031, 3031, 3578, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3161, 3175 }
local lootRare = { 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3191, 3031, 3031, 3031, 3031, 3035 }
local lootVeryRare = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 13992 }
local lootSuperRare =  { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3035, 3035, 13992, 32045, 32045, 32044 }
local lootUltraRare =  { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3043, 32044 }
local lootMegaRare =  { 3035, 3035, 3035, 3035, 3035, 3043, 3043, 32043 }

local lootTrash2 = { 3031 }
local lootCommon2 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035 }
local lootUncommon2 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3161, 3175 }
local lootRare2 = { 3031, 3031, 3031, 3035, 3191, 3031, 3031, 3031, 3031, 3035 }
local lootVeryRare2 = { 3031, 3031, 3031, 3031, 3035, 3035, 3035, 13992 }
local lootSuperRare2 =  { 3031, 3031, 3035, 3035, 3035, 3035, 3035, 3035, 13992, 32045, 32045, 32044 }
local lootUltraRare2 =  { 3043, 32044 }
local lootMegaRare2 =  { 32044, 32043 }


local function calculateChances(skill)
    local chance = math.random(1000) / 10 -- converting to decimal
    local loot = lootTrash
    if skill <= 39 then
        if chance <= 60 then
            loot = lootTrash
        elseif chance <= 95 then
            loot = lootCommon
        elseif chance <= 99 then
            loot = lootUncommon
        elseif chance <= 99.9 then
            loot = lootRare
        elseif chance <= 99.99 then
            loot = lootVeryRare
        elseif chance > 99.99 then
            loot = lootSuperRare
        end
    end

    if skill >= 40 and skill <= 60 then
        if chance <= 55 then
            loot = lootTrash
        elseif chance <= 93.5 then
            loot = lootCommon
        elseif chance <= 99 then
            loot = lootUncommon
        elseif chance <= 99.85 then
            loot = lootRare
        elseif chance <= 99.98 then
            loot = lootVeryRare
        elseif chance > 99.98 then
            loot = lootSuperRare
        end
    end

    if skill > 60 and skill <= 80 then
        if chance <= 45 then
            loot = lootTrash
        elseif chance <= 85 then
            loot = lootCommon
        elseif chance <= 90 then
            loot = lootUncommon
        elseif chance <= 95.5 then
            loot = lootRare
        elseif chance <= 98.5 then
            loot = lootVeryRare
        elseif chance > 99.9 then
            loot = lootSuperRare
        end
    end

    if skill > 80 and skill <= 100 then
        if chance <= 35 then
            loot = lootTrash
        elseif chance <= 80 then
            loot = lootCommon
        elseif chance <= 85 then
            loot = lootUncommon
        elseif chance <= 92 then
            loot = lootRare
        elseif chance <= 95 then
            loot = lootVeryRare
        elseif chance > 98 then
            loot = lootSuperRare
        end
    end

    if skill > 100 and skill <= 120 then
        if chance <= 21.2 then
            loot = lootTrash
        elseif chance <= 60.2 then
            loot = lootCommon
        elseif chance <= 80 then
            loot = lootUncommon
        elseif chance <= 85 then
            loot = lootRare
        elseif chance <= 93 then
            loot = lootVeryRare
        elseif chance > 97 then
            loot = lootSuperRare
        end
    end

    if skill > 120 and skill <= 140 then
        if chance <= 21.2 then
            loot = lootTrash
        elseif chance <= 60.2 then
            loot = lootCommon
        elseif chance <= 80 then
            loot = lootUncommon
        elseif chance <= 85 then
            loot = lootRare
        elseif chance <= 90 then
            loot = lootVeryRare
        elseif chance > 96.5 then
            loot = lootSuperRare
        end
    end

    if skill > 140 and skill <= 150 then
        if chance <= 5 then
            loot = lootTrash
        elseif chance <= 40 then
            loot = lootCommon
        elseif chance <= 50 then
            loot = lootUncommon
        elseif chance <= 68 then
            loot = lootRare
        elseif chance <= 80 then
            loot = lootVeryRare
        elseif chance <= 98 then
            loot = lootSuperRare
        elseif chance > 98 then
            loot = lootUltraRare
        end
    end

    if skill > 150 then
        if chance <= 5 then
            loot = lootTrash
        elseif chance <= 40 then
            loot = lootCommon
        elseif chance <= 50 then
            loot = lootUncommon
        elseif chance <= 68 then
            loot = lootRare
        elseif chance <= 80 then
            loot = lootVeryRare
        elseif chance <= 99.95 then
            loot = lootSuperRare
        elseif chance > 99.95 then
            loot = lootMegaRare
        end
    end

    return loot
end


local function calculateChances2(skill)
    local chance = math.random(1000) / 10 -- converting to decimal
    local loot = lootTrash2
    if skill <= 39 then
        if chance <= 60 then
            loot = lootTrash2
        elseif chance <= 95 then
            loot = lootCommon2
        elseif chance <= 99 then
            loot = lootUncommon2
        elseif chance <= 99.9 then
            loot = lootRare2
        elseif chance <= 99.99 then
            loot = lootVeryRare2
        elseif chance > 99.99 then
            loot = lootSuperRare2
        end
    end

    if skill >= 40 and skill <= 60 then
        if chance <= 55 then
            loot = lootTrash2
        elseif chance <= 93.5 then
            loot = lootCommon2
        elseif chance <= 99 then
            loot = lootUncommon2
        elseif chance <= 99.85 then
            loot = lootRare2
        elseif chance <= 99.98 then
            loot = lootVeryRare2
        elseif chance > 99.98 then
            loot = lootSuperRare2
        end
    end

    if skill > 60 and skill <= 80 then
        if chance <= 45 then
            loot = lootTrash2
        elseif chance <= 85 then
            loot = lootCommon2
        elseif chance <= 90 then
            loot = lootUncommon2
        elseif chance <= 95.5 then
            loot = lootRare2
        elseif chance <= 98.5 then
            loot = lootVeryRare2
        elseif chance > 99.9 then
            loot = lootSuperRare2
        end
    end

    if skill > 80 and skill <= 100 then
        if chance <= 35 then
            loot = lootTrash2
        elseif chance <= 80 then
            loot = lootCommon2
        elseif chance <= 85 then
            loot = lootUncommon2
        elseif chance <= 92 then
            loot = lootRare2
        elseif chance <= 95 then
            loot = lootVeryRare2
        elseif chance > 98 then
            loot = lootSuperRare2
        end
    end

    if skill > 100 and skill <= 120 then
        if chance <= 21.2 then
            loot = lootTrash2
        elseif chance <= 60.2 then
            loot = lootCommon2
        elseif chance <= 80 then
            loot = lootUncommon2
        elseif chance <= 85 then
            loot = lootRare2
        elseif chance <= 93 then
            loot = lootVeryRare2
        elseif chance > 97 then
            loot = lootSuperRare2
        end
    end

    if skill > 120 and skill <= 130 then
        if chance <= 21.2 then
            loot = lootTrash2
        elseif chance <= 60.2 then
            loot = lootCommon2
        elseif chance <= 80 then
            loot = lootUncommon2
        elseif chance <= 85 then
            loot = lootRare2
        elseif chance <= 90 then
            loot = lootVeryRare2
        elseif chance <= 96.5 then
            loot = lootSuperRare2
        elseif chance > 99.5 then
            loot = lootUltraRare2
        end
    end

    if skill > 130 and skill <= 140 then
        if chance <= 5 then
            loot = lootTrash2
        elseif chance <= 40 then
            loot = lootCommon2
        elseif chance <= 50 then
            loot = lootUncommon2
        elseif chance <= 68 then
            loot = lootRare2
        elseif chance <= 80 then
            loot = lootVeryRare2
        elseif chance <= 98 then
            loot = lootSuperRare2
        elseif chance > 98 then
            loot = lootUltraRare2
        end
    end

    if skill > 140 then
        if chance <= 5 then
            loot = lootTrash2
        elseif chance <= 40 then
            loot = lootCommon2
        elseif chance <= 60 then
            loot = lootUncommon2
        elseif chance <= 75 then
            loot = lootRare2
        elseif chance <= 86 then
            loot = lootVeryRare2
        elseif chance <= 94 then
            loot = lootSuperRare2
        elseif chance <= 99.5 then
            loot = lootUltraRare2
        elseif chance > 99.5 then
            loot = lootMegaRare2
        end
    end

    return loot
end


local area1 = {
    fromPosition = {x = 5056, y = 5024, z = 7},
    toPosition = {x = 5067, y = 5027, z = 7}
}
 
local area2 = {
    fromPosition = {x = 5053, y = 5027, z = 7},
    toPosition = {x = 5067, y = 5037, z = 7}
}

local function isInArea(player, area)
    local playerPos = player:getPosition()
    return playerPos.x >= area.fromPosition.x and playerPos.x <= area.toPosition.x
        and playerPos.y >= area.fromPosition.y and playerPos.y <= area.toPosition.y
        and playerPos.z == area.fromPosition.z
end

function removeSummonsInAreas()
    local areas = {area1, area2}
    for _, area in ipairs(areas) do
        for x = area.fromPosition.x, area.toPosition.x do
            for y = area.fromPosition.y, area.toPosition.y do
                local position = Position(x, y, area.fromPosition.z)
                local spectators = Game.getSpectators(position, false, true)
                for _, spectator in ipairs(spectators) do
                    if spectator:isMonster() then
                        spectator:remove()
                    end
                end
            end
        end
    end
end

local function checkIPInArea(area)
    for x = area.fromPosition.x, area.toPosition.x do
        for y = area.fromPosition.y, area.toPosition.y do
            for z = area.fromPosition.z, area.toPosition.z do
                local position = Position(x, y, z)
                local tile = Tile(position)
                if tile then
                    local creatures = tile:getCreatures()
                    for _, creature in ipairs(creatures) do
                        if creature:isPlayer() and creature:getIp() == playerIP and creature ~= player then
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end


local fishingEvent = {}
local MINING_STORAGE = Storage.Quest.Crandoria.ForgeSystem.AutoMiningTimer

local function leaveFishing(playerId)
    if fishingEvent[playerId] then
        stopEvent(fishingEvent[playerId].event)
        fishingEvent[playerId] = nil
    end

    local player = Player(playerId)
    if player then
        player:setStorageValue(MINING_STORAGE, 0)
    end
    return
end


local function fishingCycle(playerId, targetTile, pickaxeId, startPosition, hitCount, target)
    local player = Player(playerId)

    if not player then
        return leaveFishing(playerId)
    end

    if player:getPosition() ~= startPosition then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce se moveu da posicao, a pesca parou.")
        return leaveFishing(playerId)
    end

    if not isInArea(player, area1) and not isInArea(player, area2) then
        player:sendTextMessage(MESSAGE_FAILURE, "Essa vara so pode ser usada na area do Lago da Avareza.")
        return leaveFishing(playerId)
    end

    if player:getStorageValue(MINING_STORAGE) ~= 1 then
        return leaveFishing(playerId)
    end

    if player:getItemCount(9306) < 1 then
        player:sendTextMessage(MESSAGE_FAILURE, "Voce nao possui uma mechanical fishing rod.")
        leaveFishing(playerId)
        return false
    end

    local tile = Tile(player:getPosition())

    if player:getIp() == 0 then
        player:save()
        addEvent(function()
            player:remove()
        end, 3000)
        return false
    end

	local stamina = player:getStamina()
	if stamina < 480 then
		player:sendTextMessage(MESSAGE_FAILURE, "Voce esta muito cansado para continuar pescando.")
        leaveFishing(playerId)
        return false
    end

    if player:getStorageValue(Storage.Quest.Crandoria.PescaCustom.Time) > os.time() then
        player:sendTextMessage(MESSAGE_FAILURE, "Voce nao pode pescar tao rapido.")
        leaveFishing(playerId)
        return false
    end

	if player:getStorageValue(Storage.Quest.Crandoria.PescaCustom.Access) < os.time() then
        leaveFishing(playerId)
		player:teleportTo(Position(5000, 5000, 6))
		player:sendTextMessage(MESSAGE_FAILURE, "Seu tempo de acesso ao lago se esgotou.")
        return false
    end

	if player:getFreeBackpackSlots() < 1 then
		leaveFishing(playerId)
		player:sendTextMessage(MESSAGE_FAILURE, "Voce nao possui espaco para armazenar mais itens.")
        return false
    end

    local fishOption = 1

    if player:getItemCount(8177) >= 1 then
        local chanceWorm = math.random(1, 30)
        if chanceWorm == 30 then
            player:removeItem(8177, 1)
        end
    else
        if player:getItemCount(3492) >= 1 then
            local chanceWorm2 = math.random(1, 10)
            if chanceWorm2 > 8 then
                player:removeItem(3492, 1)
            end
        else
            leaveFishing(playerId)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa de minhocas para pescar.")
            return false
        end
    end

	-- local storagesorte = player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.LuckLevel)
    local arvore = getArvoreDeForcaValues(player)
	local storagesorte = arvore.luck
    if storagesorte < 1 then
        storagesorte = 0
    end
    local level = player:getLevel()
	local skill = player:getEffectiveSkillLevel(SKILL_FISHING) + storagesorte + math.max(1, level / 80)

    if isInRange1 then
        skill = skill - 10
    elseif isInRange3 then
        skill = skill + 5
    end

    local lootTable = calculateChances(skill)
    local lootTable2 = calculateChances2(skill)

    local chance = math.random(1, 10)
    local chanceShoes = math.random(1, 500000)
	local chanceStamina = math.random(1, 300)
	local chance2 = math.random(1, 3000)

    if checkIPInArea(area1) or checkIPInArea(area2) then
        player:sendTextMessage(MESSAGE_FAILURE, "Voce so pode pescar com um personagem por vez.")
        leaveFishing(playerId)
        player:teleportTo(Position(4934, 4962, 6))
        return false
    end

		
    if player:getItemCount(8177) >= 1 then

        targetTile:sendMagicEffect(CONST_ME_PLUNGING_FISH)
        player:say("GLUP!", TALKTYPE_MONSTER_SAY, false, nil, targetTile)
        player:getPosition():sendSingleSoundEffect(SOUND_EFFECT_TYPE_MONSTER_MELEE_ATK_RIP)

        player:addItem(lootTable2[math.random(#lootTable2)], 1)
        if player:getStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffColeta) > os.time() then
            player:addItem(lootTable2[math.random(#lootTable2)], 1)
        end 

        if player:getItemCount(3035) >= 100 then
            if player:removeItem(3035, 100) then
                player:addItem(3043, 1)
            end
        end

        if player:getItemCount(3031) >= 100 then
            if player:removeItem(3031, 100) then
                player:addItem(3035, 1)
            end
        end

        player:addCondition(exhaustHealGroup)
        player:addCondition(exhaustSupportGroup)
        player:addCondition(exhaustAttackGroup)
        player:addCondition(exhaustFourthGroup)
        player:addCondition(exhaustFifthGroup)
        player:addCondition(exhaustSixthGroup)
        player:addCondition(exhaustSeventhGroup)

        if chanceShoes == 500000 then
            player:addItem(9017, 1)
            player:sendTextMessage(MESSAGE_FAILURE, "Voce encontrou um Worker Shoes!")
        elseif chanceShoes < 500000 and chanceShoes >= 499800 then
            if player:getSkillLevel(SKILL_FISHING) >= 140 then
                player:addItem(32043, 1)
            end
        end

        if player:getSkillLevel(SKILL_FISHING) >= 110 then
            if chanceShoes < 100 then
                player:addItem(lootTable2[math.random(#lootTable2)], 1) 
                player:sendTextMessage(MESSAGE_FAILURE, "Voce pescou um Item Extra! (Bonus de Skill)")
            end
        end

        if chance > 8 then
            player:setDirection(SOUTH)
        else
            player:setDirection(NORTH)
        end
    else
        if player:getItemCount(3492) >= 1 then
            targetTile:sendMagicEffect(CONST_ME_PLUNGING_FISH)
            player:say("GLUP!", TALKTYPE_MONSTER_SAY, false, nil, targetTile)
            
            player:addItem(lootTable[math.random(#lootTable)], 1)
            if player:getStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffColeta) > os.time() then
                player:addItem(lootTable[math.random(#lootTable)], 1)
            end 

            player:addCondition(exhaustHealGroup)
            player:addCondition(exhaustSupportGroup)
            player:addCondition(exhaustAttackGroup)
            player:addCondition(exhaustFourthGroup)
            player:addCondition(exhaustFifthGroup)
            player:addCondition(exhaustSixthGroup)
            player:addCondition(exhaustSeventhGroup)

            player:addSkillTries(SKILL_FISHING, 2, true)

            if chanceShoes < 500000 and chanceShoes >= 499950 then
                if player:getEffectiveSkillLevel(SKILL_FISHING) >= 140 then
                    player:addItem(32043, 1)
                end
            end

            if chance > 7 then
                player:setDirection(SOUTH)
            else
                player:setDirection(NORTH)
            end
        else

            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa de minhocas para pescar.")
            leaveFishing(playerId)
            return false
        end
    end



        player:setStorageValue(Storage.Quest.Crandoria.PescaCustom.Time, os.time() + 4)
    local vocation = player:getVocation()
    fishingEvent[playerId].event = addEvent(fishingCycle, 5000, playerId, targetTile, pickaxeId, startPosition, hitCount)
    return true
end

local fishingAction = Action()


function fishingAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not target then
        return
    end

    local playerId = player:getId()
    local targetId = target:getId()

    if player:getStorageValue(Storage.Quest.Crandoria.PescaCustom.Time) > os.time() then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Espere alguns segundos.")
        leaveFishing(playerId)
        return true
    end

    if target and target.actionid == 12305 then
        if fishingEvent[playerId] then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja esta pescando.")
            leaveFishing(playerId)
            return true
        end

        if player:getIp() == 0 then 
            player:save()
            player:remove()
            return false
        end

        fishingEvent[playerId] = fishingEvent[playerId] or {}

        if not fishingEvent[playerId].event then
            local startPosition = player:getPosition()
            fishingEvent[playerId].event = addEvent(fishingCycle, 0, playerId, target:getPosition(), item.itemid, startPosition, 0)  -- Inicializa o contador de batidas
            player:setStorageValue(MINING_STORAGE, 1)
        end

        return true
    end
    return false
end

fishingAction:id(9306)
fishingAction:allowFarUse(true)
fishingAction:register()