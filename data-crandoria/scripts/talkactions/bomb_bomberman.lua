local bombBomberman = TalkAction("!bomb")

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

local breakableBlocks = {
    [8506] = true, [8505] = true, [8504] = true,
    [8503] = true, [9827] = true, [9831] = true
}

local dropItems = {10450, 946, 946, 35336, 35336, 12259}

local directions = {
    {x = 1, y = 0},
    {x = -1, y = 0},
    {x = 0, y = 1},
    {x = 0, y = -1}
}

local cooldownStorage = Storage.Quest.Crandoria.Bomberman.TimerBomb
local powerStorage = Storage.Quest.Crandoria.Bomberman.Power
local moreBombStorage = Storage.Quest.Crandoria.Bomberman.MoreBomb
local lifeStorage = Storage.Quest.Crandoria.Bomberman.Life
local invulnerableStorage = Storage.Quest.Crandoria.Bomberman.Invulneravel
local game = Storage.Quest.Crandoria.Bomberman.Game

local teleportPos = Position(4870, 5112, 7)

local winnerTeleportPos = Position(4870, 5114, 7)

-- Define as áreas conforme o valor da storage da área
local gameAreas = {
    [1] = {fromPos = Position(3956, 4605, 7), toPos = Position(3975, 4621, 7)},
    [2] = {fromPos = Position(3979, 4605, 7), toPos = Position(3997, 4621, 7)},
    [3] = {fromPos = Position(3911, 4605, 7), toPos = Position(3929, 4621, 7)}
}

local function isBomb(item)
    return item and (item:getId() == 8552 or item:getId() == 2133)
end

local explodedPositions = {}

local function posToString(pos)
    return pos.x .. ":" .. pos.y .. ":" .. pos.z
end

local function isPositionInArea(pos, fromPos, toPos)
    return pos.x >= fromPos.x and pos.x <= toPos.x
       and pos.y >= fromPos.y and pos.y <= toPos.y
       and pos.z == fromPos.z
end

local function checkWinnerInArea(gameId)
    local area = gameAreas[gameId]
    if not area then return end

    local alivePlayers = {}
    for x = area.fromPos.x, area.toPos.x do
        for y = area.fromPos.y, area.toPos.y do
            local tile = Tile(Position(x, y, area.fromPos.z))
            if tile then
                local topCreature = tile:getTopCreature()
                if topCreature and topCreature:isPlayer() then
                    local life = topCreature:getStorageValue(lifeStorage)
                    if life > 0 then
                        table.insert(alivePlayers, topCreature)
                    end
                end
            end
        end
    end

    if #alivePlayers == 1 then
        local winner = alivePlayers[1]
		if winner then
			winner:teleportTo(winnerTeleportPos)
            winner:addItem(3035, 50)
			winnerTeleportPos:sendMagicEffect(CONST_ME_TELEPORT)
			winner:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce venceu a partida!")
			if winner:getStorageValue(Storage.Quest.Crandoria.Bomberman.Game) == 1 then
				if winner:getStorageValue(Storage.Quest.Crandoria.Bomberman.TimerToken1) < os.time() then
					winner:setStorageValue(Storage.Quest.Crandoria.Bomberman.TimerToken1, os.time() + 60 * 60 * 20)
					winner:addItem(22720, 1)
				end
			elseif winner:getStorageValue(Storage.Quest.Crandoria.Bomberman.Game) == 2 then
				if winner:getStorageValue(Storage.Quest.Crandoria.Bomberman.TimerToken1) < os.time() then
					winner:setStorageValue(Storage.Quest.Crandoria.Bomberman.TimerToken1, os.time() + 60 * 60 * 12)
					winner:addItem(22720, 1)
				end
			elseif winner:getStorageValue(Storage.Quest.Crandoria.Bomberman.Game) == 3 then
				if winner:getStorageValue(Storage.Quest.Crandoria.Bomberman.TimerToken1) < os.time() then
					winner:setStorageValue(Storage.Quest.Crandoria.Bomberman.TimerToken1, os.time() + 60 * 60 * 6)
					winner:addItem(22720, 1)
				end
			end
		end
    end
end

-- Função modificada damagePlayersInExplosionArea com chamada a checkWinnerInArea
local function damagePlayersInExplosionArea(pos, player)
    local creatures = Game.getSpectators(pos, false, true, 0, 0, 0, 0)
    for _, target in ipairs(creatures) do
        if target:isPlayer() then
            local targetPos = target:getPosition()
            if targetPos.x == pos.x and targetPos.y == pos.y and targetPos.z == pos.z then
                if target:getStorageValue(invulnerableStorage) < os.time() then
                    local life = target:getStorageValue(lifeStorage)
                    if life == -1 then life = 3 end
                    life = math.max(0, life)
                    if life <= 1 then
                        -- jogador derrotado, teleporta
                        target:teleportTo(teleportPos)
                        teleportPos:sendMagicEffect(CONST_ME_TELEPORT)
                        target:setStorageValue(lifeStorage, 0)
						target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce foi derrotado!")
						if target:getStorageValue(Storage.Quest.Crandoria.Bomberman.Game) == 1 then
							if target:getStorageValue(Storage.Quest.Crandoria.Bomberman.TimerToken1) < os.time() then
								target:setStorageValue(Storage.Quest.Crandoria.Bomberman.TimerToken1, os.time() + 60 * 60 * 20)
							end
						elseif target:getStorageValue(Storage.Quest.Crandoria.Bomberman.Game) == 2 then
							if target:getStorageValue(Storage.Quest.Crandoria.Bomberman.TimerToken1) < os.time() then
								target:setStorageValue(Storage.Quest.Crandoria.Bomberman.TimerToken1, os.time() + 60 * 60 * 12)
							end
						elseif target:getStorageValue(Storage.Quest.Crandoria.Bomberman.Game) == 3 then
							if target:getStorageValue(Storage.Quest.Crandoria.Bomberman.TimerToken1) < os.time() then
								target:setStorageValue(Storage.Quest.Crandoria.Bomberman.TimerToken1, os.time() + 60 * 60 * 6)
							end
						end
                        -- checa vencedor na área do jogador derrotado
                        local gameId = target:getStorageValue(Storage.Quest.Crandoria.Bomberman.Game)
                        if gameId > 0 then
							addEvent(function()
								checkWinnerInArea(gameId)
							end, 100) -- 100ms de atraso, tempo suficiente para processar todos os danos
                        end
                    else
                        target:setStorageValue(lifeStorage, life - 1)
                        target:setStorageValue(invulnerableStorage, os.time() + 2)
						target:getPosition():sendMagicEffect(CONST_ME_FIREAREA)
						local newLife = life - 1
						target:say('HP: ' ..newLife.. ' ', TALKTYPE_MONSTER_SAY)
                        addEvent(function()
                            if target:isPlayer() then
                                target:getPosition():sendMagicEffect(CONST_ME_PRISMATIC_SPARK)
                            end
                        end, 500)
                        addEvent(function()
                            if target:isPlayer() then
                                target:getPosition():sendMagicEffect(CONST_ME_PRISMATIC_SPARK)
                            end
                        end, 1000)
                        addEvent(function()
                            if target:isPlayer() then
                                target:getPosition():sendMagicEffect(CONST_ME_PRISMATIC_SPARK)
                            end
                        end, 1500)
                    end
                end
            end
        end
    end
end



local function explodeAtPosition(pos, player)
    local posKey = posToString(pos)
    if explodedPositions[posKey] then return end
    explodedPositions[posKey] = true

    local tile = Tile(pos)
    if not tile then return end

    for _, item in ipairs(tile:getItems() or {}) do
        if isBomb(item) then
            item:remove()
        end
    end

    pos:sendMagicEffect(CONST_ME_EXPLOSIONHIT)
    damagePlayersInExplosionArea(pos, player)

    local range = math.max(1, player:getStorageValue(powerStorage))

    for _, dir in ipairs(directions) do
        for i = 1, range do
            local targetPos = Position(pos.x + dir.x * i, pos.y + dir.y * i, pos.z)
            local tile2 = Tile(targetPos)
            if not tile2 then break end

            local topItem = tile2:getTopVisibleThing()
            local itemId = topItem and topItem:getId()
            local isBreakable = breakableBlocks[itemId] == true

            local hasBomb = false
            for _, item in ipairs(tile2:getItems() or {}) do
                if isBomb(item) then
                    hasBomb = true
                    break
                end
            end

            if not isBreakable and not tile2:isWalkable() and not hasBomb then
                break
            end

            for _, item in ipairs(tile2:getItems() or {}) do
                if isBomb(item) then
                    item:remove()
                    explodeAtPosition(targetPos, player)
                end
            end

            for _, thing in ipairs(tile2:getItems() or {}) do
                if thing:getActionId() == 100 then
                    thing:remove()
					thing:getPosition():sendMagicEffect(CONST_ME_POFF)
                end
            end

            damagePlayersInExplosionArea(targetPos, player)

            if isBreakable then
                if itemId == 9827 then
                    targetPos:sendMagicEffect(CONST_ME_HITBYFIRE)
                elseif itemId == 9831 then
                    targetPos:sendMagicEffect(CONST_ME_FIREATTACK)
                else
                    targetPos:sendMagicEffect(CONST_ME_GROUNDSHAKER)
                end

                topItem:remove()

                if math.random(100) <= 20 then
                    local dropId = dropItems[math.random(#dropItems)]
                    local newItem = Game.createItem(dropId, 1, targetPos)
                    if newItem then
                        newItem:setActionId(100)
                        addEvent(function()
                            local stillThere = Tile(targetPos):getItemById(dropId)
                            if stillThere then
                                stillThere:remove()
                            end
                        end, 10000)
                    end
                end

                break
            else
                targetPos:sendMagicEffect(CONST_ME_EXPLOSIONHIT)
            end
        end
    end
end

local function countPlayerBombs(player)
    local pos = player:getPosition()
    local count = 0
    local range = 7

    for x = pos.x - range, pos.x + range do
        for y = pos.y - range, pos.y + range do
            local tile = Tile(Position(x, y, pos.z))
            if tile then
                for _, item in ipairs(tile:getItems() or {}) do
                    if item:getId() == 8552 and item:getActionId() == player:getGuid() then
                        count = count + 1
                    end
                end
            end
        end
    end

    return count
end

function bombBomberman.onSay(player, words, param)
    if not isPlayerInArea(Position(3910, 4604, 7), Position(3998, 4622, 7)) then
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "Você só pode usar bombas na Arena Bomberman.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    local maxBombs = math.max(1, player:getStorageValue(moreBombStorage))
    if countPlayerBombs(player) >= maxBombs then
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "Você já colocou o número máximo de bombas simultâneas.")
        return true
    end

    local pos = player:getPosition()

    local bombVisual = Game.createItem(8552, 1, pos)
    if bombVisual then
        bombVisual:setActionId(player:getGuid())
    end

    local bombVisual2 = Game.createItem(2133, 1, pos)

    explodedPositions = {}

	player:addCondition(exhaustHealGroup)
	player:addCondition(exhaustSupportGroup)
	player:addCondition(exhaustAttackGroup)
	player:addCondition(exhaustFourthGroup)
	player:addCondition(exhaustFifthGroup)
	player:addCondition(exhaustSixthGroup)
	player:addCondition(exhaustSeventhGroup)

    addEvent(function()
        if bombVisual then bombVisual:remove() end
        if bombVisual2 then bombVisual2:remove() end
        explodeAtPosition(pos, player)
    end, 2500)

    return true
end

bombBomberman:groupType("normal")
bombBomberman:register()