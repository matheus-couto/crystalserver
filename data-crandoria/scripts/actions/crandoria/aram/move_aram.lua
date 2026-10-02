local moveAram = MoveEvent()

function moveAram.onStepIn(creature, item, position, fromPosition)
    if not creature then
        return true
    end

    local creatureOutfitChaos = { 113 }
	local creatureOutfitAnvillux = { 84 }
    local creaturePos = creature:getPosition()

	local function isTileWalkable(pos)
        local tile = Tile(pos)
        return tile and tile:isWalkable() and tile:getCreatureCount() == 0 and not tile:hasProperty(CONST_PROP_IMMOVABLEBLOCKSOLID)
    end

	local isAlreadyProcessing = creature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.Walk)
    if isAlreadyProcessing == 1 then
        return false -- Se já estiver em execução, não executa novamente
    end

	local storedPos = creature:getPosition()


	if table.contains(creatureOutfitChaos, creature:getOutfit().lookFeet) and creature:isMonster() then
		creature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.Walk, 1)

		addEvent(function()
			if not creature then
				return false
			end

			if creature:getTarget() then
				return false
			end

			-- if not Tile(position):getTopCreature(creature) then
			-- 	return false
			-- end

			local tile = Tile(position)
			if not tile or tile:getTopCreature() ~= creature then
				return false
			end

			-- local moved = false
				-- Tentar mover para o Oeste
			local westPos = Position(creaturePos.x - 1, creaturePos.y, creaturePos.z)
			if isTileWalkable(westPos) then
				if Tile(storedPos):getTopCreature() == creature then
					creature:move(DIRECTION_WEST)
				end
			else
				local northwestPos = Position(creaturePos.x - 1, creaturePos.y - 1, creaturePos.z)
				local southwestPos = Position(creaturePos.x - 1, creaturePos.y + 1, creaturePos.z)

				local northwestImmediate1 = Position(creaturePos.x - 2, creaturePos.y - 1, creaturePos.z)
				local northwestImmediate2 = Position(creaturePos.x - 2, creaturePos.y - 2, creaturePos.z)
				local southwestImmediate1 = Position(creaturePos.x - 2, creaturePos.y + 1, creaturePos.z)
				local southwestImmediate2 = Position(creaturePos.x - 2, creaturePos.y + 2, creaturePos.z)

				if isTileWalkable(northwestPos) and (isTileWalkable(northwestImmediate1) or isTileWalkable(northwestImmediate2)) then
					if Tile(storedPos):getTopCreature() == creature then
						creature:move(DIRECTION_NORTHWEST)
					end
				else
					if isTileWalkable(southwestPos) and (isTileWalkable(southwestImmediate1) or isTileWalkable(southwestImmediate2)) then
						if Tile(storedPos):getTopCreature() == creature then
							creature:move(DIRECTION_SOUTHWEST)
						end
					else
						if isTileWalkable(northwestPos) then
							if Tile(storedPos):getTopCreature() == creature then
								creature:move(DIRECTION_NORTHWEST)
							end
						else
							if isTileWalkable(southwestPos) then
								if Tile(storedPos):getTopCreature() == creature then
									creature:move(DIRECTION_SOUTHWEST)
								end
							else
								local northTwoPos = Position(creaturePos.x, creaturePos.y - 1, creaturePos.z)
								local southTwoPos = Position(creaturePos.x, creaturePos.y + 1, creaturePos.z)
	
								local canMoveNorth = isTileWalkable(northTwoPos)
								local canMoveSouth = isTileWalkable(southTwoPos)
								local northImmediate = Position(creaturePos.x, creaturePos.y - 2, creaturePos.z)
								local southImmediate = Position(creaturePos.x, creaturePos.y + 2, creaturePos.z)

								if canMoveNorth and isTileWalkable(northImmediate) then
									if Tile(storedPos):getTopCreature() == creature then
										creature:move(DIRECTION_NORTH)
									end
								else
									if canMoveSouth and isTileWalkable(southImmediate) then
										if Tile(storedPos):getTopCreature() == creature then
											creature:move(DIRECTION_SOUTH)
										end
									else
										if canMoveNorth then
											if Tile(storedPos):getTopCreature() == creature then
												creature:move(DIRECTION_NORTH)
											end
										else
											if canMoveSouth then
												if Tile(storedPos):getTopCreature() == creature then
													creature:move(DIRECTION_SOUTH)
												end
											else
												local southeastPos = Position(creaturePos.x + 1, creaturePos.y + 1, creaturePos.z)
												local northeastPos = Position(creaturePos.x + 1, creaturePos.y - 1, creaturePos.z)
				
												local southeastImmediate = Position(creaturePos.x + 2, creaturePos.y + 2, creaturePos.z)
												local northeastImmediate = Position(creaturePos.x + 2, creaturePos.y - 2, creaturePos.z)
				
												local canMoveSoutheast = isTileWalkable(southeastPos)
												local canMoveNortheast = isTileWalkable(northeastPos)

												if isTileWalkable(southeastImmediate) and isTileWalkable(southeastPos) then
													if Tile(storedPos):getTopCreature() == creature then
														creature:move(DIRECTION_SOUTHEAST)
													end
												else
													if isTileWalkable(northeastImmediate) and isTileWalkable(northeastPos) then
														if Tile(storedPos):getTopCreature() == creature then
															creature:move(DIRECTION_NORTHEAST)
														end
													else
														if canMoveSoutheast then
															if Tile(storedPos):getTopCreature() == creature then
																creature:move(DIRECTION_SOUTHEAST)
															end
														else
															if canMoveNortheast then
																if Tile(storedPos):getTopCreature() == creature then
																	creature:move(DIRECTION_NORTHEAST)
																end
															else
																local closestPos = creature:getClosestFreePosition(westPos, 5, true)
																if closestPos and isTileWalkable(closestPos) then
																	local direction = creaturePos:getDirectionTo(closestPos)
																	if Tile(storedPos):getTopCreature() == creature then
																		creature:move(direction)
																	end
																end
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end	
		end, 500)
		addEvent(function()
			if not creature  then
				return false
			end

			if creature and creature:isMonster() and not creature:isRemoved() then
				creature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.Walk, 0) -- Remove a flag após o tempo de execução
			end

		end, 100) -- Ajuste o tempo conforme necessário
		-- if not moved then
		-- 	creature:say("!!!", TALKTYPE_MONSTER_SAY)
		-- end
	elseif table.contains(creatureOutfitAnvillux, creature:getOutfit().lookFeet) and creature:isMonster() then
		creature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.Walk, 1)
		addEvent(function()
			if not creature then
				return false
			end

			if creature:getTarget() then
				return true
			end

			-- if not Tile(position):getTopCreature(creature) then
			-- 	return false
			-- end

			local tile = Tile(position)
			if not tile or tile:getTopCreature() ~= creature then
				return false
			end
			
			local eastPos = Position(creaturePos.x + 1, creaturePos.y, creaturePos.z)
			if isTileWalkable(eastPos) then
				if creature:getPosition() then
					creature:move(DIRECTION_EAST)
				end
			else
				local northeastPos = Position(creaturePos.x + 1, creaturePos.y - 1, creaturePos.z)
				local southeastPos = Position(creaturePos.x + 1, creaturePos.y + 1, creaturePos.z)

				local northeastImmediate1 = Position(creaturePos.x + 2, creaturePos.y - 1, creaturePos.z)
				local northeastImmediate2 = Position(creaturePos.x + 2, creaturePos.y - 2, creaturePos.z)
				local southeastImmediate1 = Position(creaturePos.x + 2, creaturePos.y + 1, creaturePos.z)
				local southeastImmediate2 = Position(creaturePos.x + 2, creaturePos.y + 2, creaturePos.z)

				if isTileWalkable(northeastPos) and (isTileWalkable(northeastImmediate1) or isTileWalkable(northeastImmediate2)) then
					if Tile(storedPos):getTopCreature() == creature then
						creature:move(DIRECTION_NORTHEAST)
					end
				else
					if isTileWalkable(southeastPos) and (isTileWalkable(southeastImmediate1) or isTileWalkable(southeastImmediate2)) then
						if Tile(storedPos):getTopCreature() == creature then
							creature:move(DIRECTION_SOUTHEAST)
						end
					else
						if isTileWalkable(northeastPos) then
							if Tile(storedPos):getTopCreature() == creature then
								creature:move(DIRECTION_NORTHEAST)
							end
						else
							if isTileWalkable(southeastPos) then
								if Tile(storedPos):getTopCreature() == creature then
									creature:move(DIRECTION_SOUTHEAST)
								end
							else
								local northTwoPos = Position(creaturePos.x, creaturePos.y - 1, creaturePos.z)
								local southTwoPos = Position(creaturePos.x, creaturePos.y + 1, creaturePos.z)
	
								local canMoveNorth = isTileWalkable(northTwoPos)
								local canMoveSouth = isTileWalkable(southTwoPos)
								local northImmediate = Position(creaturePos.x, creaturePos.y - 2, creaturePos.z)
								local southImmediate = Position(creaturePos.x, creaturePos.y + 2, creaturePos.z)

								if canMoveNorth and isTileWalkable(northImmediate) then
									if Tile(storedPos):getTopCreature() == creature then
										creature:move(DIRECTION_NORTH)
									end
								else
									if canMoveSouth and isTileWalkable(southImmediate) then
										if Tile(storedPos):getTopCreature() == creature then
											creature:move(DIRECTION_SOUTH)
										end
									else
										if canMoveNorth then
											if Tile(storedPos):getTopCreature() == creature then
												creature:move(DIRECTION_NORTH)
											end
										else
											if canMoveSouth then
												if Tile(storedPos):getTopCreature() == creature then
													creature:move(DIRECTION_SOUTH)
												end
											else
												local southwestPos = Position(creaturePos.x - 1, creaturePos.y + 1, creaturePos.z)
												local northwestPos = Position(creaturePos.x - 1, creaturePos.y - 1, creaturePos.z)
				
												local southwestImmediate = Position(creaturePos.x - 2, creaturePos.y + 2, creaturePos.z)
												local northwestImmediate = Position(creaturePos.x - 2, creaturePos.y - 2, creaturePos.z)
				
												local canMoveSouthwest = isTileWalkable(southwestPos)
												local canMoveNorthwest = isTileWalkable(northwestPos)

												if isTileWalkable(southwestImmediate) and isTileWalkable(southwestPos) then
													if Tile(storedPos):getTopCreature() == creature then
														creature:move(DIRECTION_SOUTHWEST)
													end
												else
													if isTileWalkable(northwestImmediate) and isTileWalkable(northwestPos) then
														if Tile(storedPos):getTopCreature() == creature then
															creature:move(DIRECTION_NORTHWEST)
														end
													else
														if canMoveSouthwest then
															if Tile(storedPos):getTopCreature() == creature then
																creature:move(DIRECTION_SOUTHWEST)
															end
														else
															if canMoveNorthwest then
																if Tile(storedPos):getTopCreature() == creature then
																	creature:move(DIRECTION_NORTHWEST)
																end
															else
																local closestPos = creature:getClosestFreePosition(eastPos, 5, true)
																if closestPos and isTileWalkable(closestPos) then
																	local direction = creaturePos:getDirectionTo(closestPos)
																	if Tile(storedPos):getTopCreature() == creature then
																		creature:move(direction)
																	end
																end
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end	
		end, 500)

		addEvent(function()
			if not creature  then
				return false
			end

			if creature and creature:isMonster() and not creature:isRemoved() then
				creature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.Walk, 0) -- Remove a flag após o tempo de execução
			end
		end, 100) -- Ajuste o tempo conforme necessário
	end
	return true
    -- end
end

moveAram:aid(13070)
moveAram:register()



























-- local moveAram = MoveEvent()

-- function moveAram.onStepIn(creature, item, position, fromPosition)
--     if not creature then
--         return true
--     end

--     local creatureOutfitChaos = { 113 }
-- 	local creatureOutfitAnvillux = { 84 }
--     local creaturePos = creature:getPosition()

-- 	local function isTileWalkable(pos)
--         local tile = Tile(pos)
--         return tile and tile:isWalkable() and tile:getCreatureCount() == 0 and not tile:hasProperty(CONST_PROP_IMMOVABLEBLOCKSOLID)
--     end

-- 	local isAlreadyProcessing = creature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.Walk)
--     if isAlreadyProcessing == 1 then
--         return false -- Se já estiver em execução, não executa novamente
--     end


-- 	if table.contains(creatureOutfitChaos, creature:getOutfit().lookFeet) and creature:isMonster() then
-- 		creature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.Walk, 1)

-- 		addEvent(function()
-- 			if not creature then
-- 				return false
-- 			end

-- 			if creature:getTarget() then
-- 				return false
-- 			end

-- 			if not Tile(position):getTopCreature(creature) then
-- 				return false
-- 			end
-- 			-- local moved = false
-- 				-- Tentar mover para o Oeste
-- 			local westPos = Position(creaturePos.x - 1, creaturePos.y, creaturePos.z)
-- 			if isTileWalkable(westPos) then
-- 				if creature:getPosition() then
-- 					creature:move(DIRECTION_WEST)
-- 				end
-- 			else
-- 				local northwestPos = Position(creaturePos.x - 1, creaturePos.y - 1, creaturePos.z)
-- 				local southwestPos = Position(creaturePos.x - 1, creaturePos.y + 1, creaturePos.z)

-- 				local northwestImmediate1 = Position(creaturePos.x - 2, creaturePos.y - 1, creaturePos.z)
-- 				local northwestImmediate2 = Position(creaturePos.x - 2, creaturePos.y - 2, creaturePos.z)
-- 				local southwestImmediate1 = Position(creaturePos.x - 2, creaturePos.y + 1, creaturePos.z)
-- 				local southwestImmediate2 = Position(creaturePos.x - 2, creaturePos.y + 2, creaturePos.z)

-- 				if isTileWalkable(northwestPos) and (isTileWalkable(northwestImmediate1) or isTileWalkable(northwestImmediate2)) then
-- 					if creature:getPosition() then
-- 						creature:move(DIRECTION_NORTHWEST)
-- 					end
-- 				else
-- 					if isTileWalkable(southwestPos) and (isTileWalkable(southwestImmediate1) or isTileWalkable(southwestImmediate2)) then
-- 						if creature:getPosition() then
-- 							creature:move(DIRECTION_SOUTHWEST)
-- 						end
-- 					else
-- 						if isTileWalkable(northwestPos) then
-- 							if creature:getPosition() then
-- 								creature:move(DIRECTION_NORTHWEST)
-- 							end
-- 						else
-- 							if isTileWalkable(southwestPos) then
-- 								if creature:getPosition() then
-- 									creature:move(DIRECTION_SOUTHWEST)
-- 								end
-- 							else
-- 								local northTwoPos = Position(creaturePos.x, creaturePos.y - 1, creaturePos.z)
-- 								local southTwoPos = Position(creaturePos.x, creaturePos.y + 1, creaturePos.z)
	
-- 								local canMoveNorth = isTileWalkable(northTwoPos)
-- 								local canMoveSouth = isTileWalkable(southTwoPos)
-- 								local northImmediate = Position(creaturePos.x, creaturePos.y - 2, creaturePos.z)
-- 								local southImmediate = Position(creaturePos.x, creaturePos.y + 2, creaturePos.z)

-- 								if canMoveNorth and isTileWalkable(northImmediate) then
-- 									if creature:getPosition() then
-- 										creature:move(DIRECTION_NORTH)
-- 									end
-- 								else
-- 									if canMoveSouth and isTileWalkable(southImmediate) then
-- 										if creature:getPosition() then
-- 											creature:move(DIRECTION_SOUTH)
-- 										end
-- 									else
-- 										if canMoveNorth then
-- 											if creature:getPosition() then
-- 												creature:move(DIRECTION_NORTH)
-- 											end
-- 										else
-- 											if canMoveSouth then
-- 												if creature:getPosition() then
-- 													creature:move(DIRECTION_SOUTH)
-- 												end
-- 											else
-- 												local southeastPos = Position(creaturePos.x + 1, creaturePos.y + 1, creaturePos.z)
-- 												local northeastPos = Position(creaturePos.x + 1, creaturePos.y - 1, creaturePos.z)
				
-- 												local southeastImmediate = Position(creaturePos.x + 2, creaturePos.y + 2, creaturePos.z)
-- 												local northeastImmediate = Position(creaturePos.x + 2, creaturePos.y - 2, creaturePos.z)
				
-- 												local canMoveSoutheast = isTileWalkable(southeastPos)
-- 												local canMoveNortheast = isTileWalkable(northeastPos)

-- 												if isTileWalkable(southeastImmediate) and isTileWalkable(southeastPos) then
-- 													if creature:getPosition() then
-- 														creature:move(DIRECTION_SOUTHEAST)
-- 													end
-- 												else
-- 													if isTileWalkable(northeastImmediate) and isTileWalkable(northeastPos) then
-- 														if creature:getPosition() then
-- 															creature:move(DIRECTION_NORTHEAST)
-- 														end
-- 													else
-- 														if canMoveSoutheast then
-- 															if creature:getPosition() then
-- 																creature:move(DIRECTION_SOUTHEAST)
-- 															end
-- 														else
-- 															if canMoveNortheast then
-- 																creature:move(DIRECTION_NORTHEAST)
-- 															else
-- 																local closestPos = creature:getClosestFreePosition(westPos, 5, true)
-- 																if closestPos and isTileWalkable(closestPos) then
-- 																	local direction = creaturePos:getDirectionTo(closestPos)
-- 																	if creature:getPosition() then
-- 																		creature:move(direction)
-- 																	end
-- 																end
-- 															end
-- 														end
-- 													end
-- 												end
-- 											end
-- 										end
-- 									end
-- 								end
-- 							end
-- 						end
-- 					end
-- 				end
-- 			end	
-- 		end, 500)
-- 		addEvent(function()
-- 			if not creature  then
-- 				return false
-- 			end

-- 			if creature:isMonster() then
-- 				creature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.Walk, 0) -- Remove a flag após o tempo de execução
-- 			else
-- 				return false
-- 			end

-- 		end, 100) -- Ajuste o tempo conforme necessário
-- 		-- if not moved then
-- 		-- 	creature:say("!!!", TALKTYPE_MONSTER_SAY)
-- 		-- end
-- 	elseif table.contains(creatureOutfitAnvillux, creature:getOutfit().lookFeet) and creature:isMonster() then
-- 		creature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.Walk, 1)
-- 		addEvent(function()
-- 			if not creature then
-- 				return false
-- 			end

-- 			if creature:getTarget() then
-- 				return true
-- 			end

-- 			if not Tile(position):getTopCreature(creature) then
-- 				return false
-- 			end
			
-- 			local eastPos = Position(creaturePos.x + 1, creaturePos.y, creaturePos.z)
-- 			if isTileWalkable(eastPos) then
-- 				if creature:getPosition() then
-- 					creature:move(DIRECTION_EAST)
-- 				end
-- 			else
-- 				local northeastPos = Position(creaturePos.x + 1, creaturePos.y - 1, creaturePos.z)
-- 				local southeastPos = Position(creaturePos.x + 1, creaturePos.y + 1, creaturePos.z)

-- 				local northeastImmediate1 = Position(creaturePos.x + 2, creaturePos.y - 1, creaturePos.z)
-- 				local northeastImmediate2 = Position(creaturePos.x + 2, creaturePos.y - 2, creaturePos.z)
-- 				local southeastImmediate1 = Position(creaturePos.x + 2, creaturePos.y + 1, creaturePos.z)
-- 				local southeastImmediate2 = Position(creaturePos.x + 2, creaturePos.y + 2, creaturePos.z)

-- 				if isTileWalkable(northeastPos) and (isTileWalkable(northeastImmediate1) or isTileWalkable(northeastImmediate2)) then
-- 					if creature:getPosition() then
-- 						creature:move(DIRECTION_NORTHEAST)
-- 					end
-- 				else
-- 					if isTileWalkable(southeastPos) and (isTileWalkable(southeastImmediate1) or isTileWalkable(southeastImmediate2)) then
-- 						if creature:getPosition() then
-- 							creature:move(DIRECTION_SOUTHEAST)
-- 						end
-- 					else
-- 						if isTileWalkable(northeastPos) then
-- 							if creature:getPosition() then
-- 								creature:move(DIRECTION_NORTHEAST)
-- 							end
-- 						else
-- 							if isTileWalkable(southeastPos) then
-- 								if creature:getPosition() then
-- 									creature:move(DIRECTION_SOUTHEAST)
-- 								end
-- 							else
-- 								local northTwoPos = Position(creaturePos.x, creaturePos.y - 1, creaturePos.z)
-- 								local southTwoPos = Position(creaturePos.x, creaturePos.y + 1, creaturePos.z)
	
-- 								local canMoveNorth = isTileWalkable(northTwoPos)
-- 								local canMoveSouth = isTileWalkable(southTwoPos)
-- 								local northImmediate = Position(creaturePos.x, creaturePos.y - 2, creaturePos.z)
-- 								local southImmediate = Position(creaturePos.x, creaturePos.y + 2, creaturePos.z)

-- 								if canMoveNorth and isTileWalkable(northImmediate) then
-- 									if creature:getPosition() then
-- 										creature:move(DIRECTION_NORTH)
-- 									end
-- 								else
-- 									if canMoveSouth and isTileWalkable(southImmediate) then
-- 										if creature:getPosition() then
-- 											creature:move(DIRECTION_SOUTH)
-- 										end
-- 									else
-- 										if canMoveNorth then
-- 											if creature:getPosition() then
-- 												creature:move(DIRECTION_NORTH)
-- 											end
-- 										else
-- 											if canMoveSouth then
-- 												if creature:getPosition() then
-- 													creature:move(DIRECTION_SOUTH)
-- 												end
-- 											else
-- 												local southwestPos = Position(creaturePos.x - 1, creaturePos.y + 1, creaturePos.z)
-- 												local northwestPos = Position(creaturePos.x - 1, creaturePos.y - 1, creaturePos.z)
				
-- 												local southwestImmediate = Position(creaturePos.x - 2, creaturePos.y + 2, creaturePos.z)
-- 												local northwestImmediate = Position(creaturePos.x - 2, creaturePos.y - 2, creaturePos.z)
				
-- 												local canMoveSouthwest = isTileWalkable(southwestPos)
-- 												local canMoveNorthwest = isTileWalkable(northwestPos)

-- 												if isTileWalkable(southwestImmediate) and isTileWalkable(southwestPos) then
-- 													if creature:getPosition() then
-- 														creature:move(DIRECTION_SOUTHWEST)
-- 													end
-- 												else
-- 													if isTileWalkable(northwestImmediate) and isTileWalkable(northwestPos) then
-- 														if creature:getPosition() then
-- 															creature:move(DIRECTION_NORTHWEST)
-- 														end
-- 													else
-- 														if canMoveSouthwest then
-- 															if creature:getPosition() then
-- 																creature:move(DIRECTION_SOUTHWEST)
-- 															end
-- 														else
-- 															if canMoveNorthwest then
-- 																if creature:getPosition() then
-- 																	creature:move(DIRECTION_NORTHWEST)
-- 																end
-- 															else
-- 																local closestPos = creature:getClosestFreePosition(eastPos, 5, true)
-- 																if closestPos and isTileWalkable(closestPos) then
-- 																	local direction = creaturePos:getDirectionTo(closestPos)
-- 																	if creature:getPosition() then
-- 																		creature:move(direction)
-- 																	end
-- 																end
-- 															end
-- 														end
-- 													end
-- 												end
-- 											end
-- 										end
-- 									end
-- 								end
-- 							end
-- 						end
-- 					end
-- 				end
-- 			end	
-- 		end, 500)

-- 		addEvent(function()
-- 			if not creature  then
-- 				return false
-- 			end

-- 			if creature:isMonster() then
-- 				creature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.Walk, 0) -- Remove a flag após o tempo de execução
-- 			else
-- 				return false
-- 			end
-- 		end, 100) -- Ajuste o tempo conforme necessário
-- 	end
-- 	return true
--     -- end
-- end

-- moveAram:aid(13070)
-- moveAram:register()

























-- local moveAram = MoveEvent()

-- function moveAram.onStepIn(creature, item, position, fromPosition)
--     if not creature then
--         return true
--     end

--     local creatureOutfitChaos = { 113 }
-- 	local creatureOutfitAnvillux = { 84 }
--     local creaturePos = creature:getPosition()

-- 	local function isTileWalkable(pos)
--         local tile = Tile(pos)
--         return tile and tile:isWalkable() and tile:getCreatureCount() == 0 and not tile:hasProperty(CONST_PROP_IMMOVABLEBLOCKSOLID)
--     end

-- 	local isAlreadyProcessing = creature:getStorageValue(Storage.Quest.Crandoria.TibiaAram.Walk)
--     if isAlreadyProcessing == 1 then
--         return false -- Se já estiver em execução, não executa novamente
--     end


-- 	if table.contains(creatureOutfitChaos, creature:getOutfit().lookFeet) and creature:isMonster() then
-- 		creature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.Walk, 1)
-- 		addEvent(function()
-- 			if not creature or creature:getTarget() then
-- 				return false
-- 			end

-- 			if not Tile(position):getTopCreature(creature) then
-- 				return false
-- 			end
-- 			-- local moved = false
-- 				-- Tentar mover para o Oeste
-- 			local westPos = Position(creaturePos.x - 1, creaturePos.y, creaturePos.z)
-- 			if isTileWalkable(westPos) then
-- 				creature:move(DIRECTION_WEST)
-- 					-- moved = true
-- 			else
-- 				local northwestPos = Position(creaturePos.x - 1, creaturePos.y - 1, creaturePos.z)
-- 				local southwestPos = Position(creaturePos.x - 1, creaturePos.y + 1, creaturePos.z)

-- 				local northwestImmediate1 = Position(creaturePos.x - 2, creaturePos.y - 1, creaturePos.z)
-- 				local northwestImmediate2 = Position(creaturePos.x - 2, creaturePos.y - 2, creaturePos.z)
-- 				local southwestImmediate1 = Position(creaturePos.x - 2, creaturePos.y + 1, creaturePos.z)
-- 				local southwestImmediate2 = Position(creaturePos.x - 2, creaturePos.y + 2, creaturePos.z)

-- 				if isTileWalkable(northwestPos) and (isTileWalkable(northwestImmediate1) or isTileWalkable(northwestImmediate2)) then
-- 					creature:move(DIRECTION_NORTHWEST)
-- 					-- moved = true
-- 				else
-- 					if isTileWalkable(southwestPos) and (isTileWalkable(southwestImmediate1) or isTileWalkable(southwestImmediate2)) then
-- 						creature:move(DIRECTION_SOUTHWEST)
-- 					-- moved = true
-- 					else
-- 						if isTileWalkable(northwestPos) then
-- 							creature:move(DIRECTION_NORTHWEST)
-- 					-- moved = true
-- 						else
-- 							if isTileWalkable(southwestPos) then
-- 								creature:move(DIRECTION_SOUTHWEST)
-- 					-- moved = true
-- 							else
-- 								local northTwoPos = Position(creaturePos.x, creaturePos.y - 1, creaturePos.z)
-- 								local southTwoPos = Position(creaturePos.x, creaturePos.y + 1, creaturePos.z)
	
-- 								local canMoveNorth = isTileWalkable(northTwoPos)
-- 								local canMoveSouth = isTileWalkable(southTwoPos)
-- 								local northImmediate = Position(creaturePos.x, creaturePos.y - 2, creaturePos.z)
-- 								local southImmediate = Position(creaturePos.x, creaturePos.y + 2, creaturePos.z)

-- 								if canMoveNorth and isTileWalkable(northImmediate) then
-- 									creature:move(DIRECTION_NORTH)
-- 					-- moved = true
-- 								else
-- 									if canMoveSouth and isTileWalkable(southImmediate) then
-- 										creature:move(DIRECTION_SOUTH)
-- 					-- moved = true
-- 									else
-- 										if canMoveNorth then
-- 											creature:move(DIRECTION_NORTH)
-- 					-- moved = true
-- 										else
-- 											if canMoveSouth then
-- 												creature:move(DIRECTION_SOUTH)
-- 					-- moved = true
-- 											else
-- 												local southeastPos = Position(creaturePos.x + 1, creaturePos.y + 1, creaturePos.z)
-- 												local northeastPos = Position(creaturePos.x + 1, creaturePos.y - 1, creaturePos.z)
				
-- 												local southeastImmediate = Position(creaturePos.x + 2, creaturePos.y + 2, creaturePos.z)
-- 												local northeastImmediate = Position(creaturePos.x + 2, creaturePos.y - 2, creaturePos.z)
				
-- 												local canMoveSoutheast = isTileWalkable(southeastPos)
-- 												local canMoveNortheast = isTileWalkable(northeastPos)

-- 												if isTileWalkable(southeastImmediate) and isTileWalkable(southeastPos) then
-- 													creature:move(DIRECTION_SOUTHEAST)
-- 					-- moved = true
-- 												else
-- 													if isTileWalkable(northeastImmediate) and isTileWalkable(northeastPos) then
-- 														creature:move(DIRECTION_NORTHEAST)
-- 					-- moved = true
-- 													else
-- 														if canMoveSoutheast then
-- 															creature:move(DIRECTION_SOUTHEAST)
-- 					-- moved = true
-- 														else
-- 															if canMoveNortheast then
-- 																creature:move(DIRECTION_NORTHEAST)
-- 															else
-- 																local closestPos = creature:getClosestFreePosition(westPos, 5, true)
-- 																if closestPos and isTileWalkable(closestPos) then
-- 																	local direction = creaturePos:getDirectionTo(closestPos)
-- 																	creature:move(direction)
-- 																end
-- 															end
-- 														end
-- 													end
-- 												end
-- 											end
-- 										end
-- 									end
-- 								end
-- 							end
-- 						end
-- 					end
-- 				end
-- 			end	
-- 		end, 500)
-- 		addEvent(function()
-- 			creature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.Walk, 0) -- Remove a flag após o tempo de execução
-- 		end, 100) -- Ajuste o tempo conforme necessário
-- 		-- if not moved then
-- 		-- 	creature:say("!!!", TALKTYPE_MONSTER_SAY)
-- 		-- end
-- 	elseif table.contains(creatureOutfitAnvillux, creature:getOutfit().lookFeet) and creature:isMonster() then
-- 		creature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.Walk, 1)
-- 		addEvent(function()
-- 			if not creature or creature:getTarget() then
-- 				return false
-- 			end
-- 			if not Tile(position):getTopCreature(creature) then
-- 				return false
-- 			end
-- 			local eastPos = Position(creaturePos.x + 1, creaturePos.y, creaturePos.z)
-- 			if isTileWalkable(eastPos) then
-- 				creature:move(DIRECTION_EAST)
-- 					-- moved = true
-- 			else
-- 				local northeastPos = Position(creaturePos.x + 1, creaturePos.y - 1, creaturePos.z)
-- 				local southeastPos = Position(creaturePos.x + 1, creaturePos.y + 1, creaturePos.z)

-- 				local northeastImmediate1 = Position(creaturePos.x + 2, creaturePos.y - 1, creaturePos.z)
-- 				local northeastImmediate2 = Position(creaturePos.x + 2, creaturePos.y - 2, creaturePos.z)
-- 				local southeastImmediate1 = Position(creaturePos.x + 2, creaturePos.y + 1, creaturePos.z)
-- 				local southeastImmediate2 = Position(creaturePos.x + 2, creaturePos.y + 2, creaturePos.z)

-- 				if isTileWalkable(northeastPos) and (isTileWalkable(northeastImmediate1) or isTileWalkable(northeastImmediate2)) then
-- 					creature:move(DIRECTION_NORTHEAST)
-- 					-- moved = true
-- 				else
-- 					if isTileWalkable(southeastPos) and (isTileWalkable(southeastImmediate1) or isTileWalkable(southeastImmediate2)) then
-- 						creature:move(DIRECTION_SOUTHEAST)
-- 					-- moved = true
-- 					else
-- 						if isTileWalkable(northeastPos) then
-- 							creature:move(DIRECTION_NORTHEAST)
-- 					-- moved = true
-- 						else
-- 							if isTileWalkable(southeastPos) then
-- 								creature:move(DIRECTION_SOUTHEAST)
-- 					-- moved = true
-- 							else
-- 								local northTwoPos = Position(creaturePos.x, creaturePos.y - 1, creaturePos.z)
-- 								local southTwoPos = Position(creaturePos.x, creaturePos.y + 1, creaturePos.z)
	
-- 								local canMoveNorth = isTileWalkable(northTwoPos)
-- 								local canMoveSouth = isTileWalkable(southTwoPos)
-- 								local northImmediate = Position(creaturePos.x, creaturePos.y - 2, creaturePos.z)
-- 								local southImmediate = Position(creaturePos.x, creaturePos.y + 2, creaturePos.z)

-- 								if canMoveNorth and isTileWalkable(northImmediate) then
-- 									creature:move(DIRECTION_NORTH)
-- 					-- moved = true
-- 								else
-- 									if canMoveSouth and isTileWalkable(southImmediate) then
-- 										creature:move(DIRECTION_SOUTH)
-- 					-- moved = true
-- 									else
-- 										if canMoveNorth then
-- 											creature:move(DIRECTION_NORTH)
-- 					-- moved = true
-- 										else
-- 											if canMoveSouth then
-- 												creature:move(DIRECTION_SOUTH)
-- 					-- moved = true
-- 											else
-- 												local southwestPos = Position(creaturePos.x - 1, creaturePos.y + 1, creaturePos.z)
-- 												local northwestPos = Position(creaturePos.x - 1, creaturePos.y - 1, creaturePos.z)
				
-- 												local southwestImmediate = Position(creaturePos.x - 2, creaturePos.y + 2, creaturePos.z)
-- 												local northwestImmediate = Position(creaturePos.x - 2, creaturePos.y - 2, creaturePos.z)
				
-- 												local canMoveSouthwest = isTileWalkable(southwestPos)
-- 												local canMoveNorthwest = isTileWalkable(northwestPos)

-- 												if isTileWalkable(southwestImmediate) and isTileWalkable(southwestPos) then
-- 													creature:move(DIRECTION_SOUTHWEST)
-- 					-- moved = true
-- 												else
-- 													if isTileWalkable(northwestImmediate) and isTileWalkable(northwestPos) then
-- 														creature:move(DIRECTION_NORTHWEST)
-- 					-- moved = true
-- 													else
-- 														if canMoveSouthwest then
-- 															creature:move(DIRECTION_SOUTHWEST)
-- 					-- moved = true
-- 														else
-- 															if canMoveNorthwest then
-- 																creature:move(DIRECTION_NORTHWEST)
-- 															else
-- 																local closestPos = creature:getClosestFreePosition(eastPos, 5, true)
-- 																if closestPos and isTileWalkable(closestPos) then
-- 																	local direction = creaturePos:getDirectionTo(closestPos)
-- 																	creature:move(direction)
-- 																end
-- 															end
-- 														end
-- 													end
-- 												end
-- 											end
-- 										end
-- 									end
-- 								end
-- 							end
-- 						end
-- 					end
-- 				end
-- 			end	
-- 		end, 500)

-- 		addEvent(function()
-- 			creature:setStorageValue(Storage.Quest.Crandoria.TibiaAram.Walk, 0) -- Remove a flag após o tempo de execução
-- 		end, 100) -- Ajuste o tempo conforme necessário
-- 	end
-- 	return true
--     -- end
-- end

-- moveAram:aid(13070)
-- moveAram:register()