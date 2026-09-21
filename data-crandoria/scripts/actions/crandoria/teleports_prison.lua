

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

local mazeRotation = GlobalEvent("PrisonMazeRotation")

function mazeRotation.onThink(interval)
	activateRandomMazeConfig()
	return true
end

mazeRotation:interval(60 * 60 * 1000) -- 1 hora
mazeRotation:register()


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local teleportPrison = MoveEvent()

function teleportPrison.onStepIn(creature, item, position, fromPosition)
	if not creature or not creature:isPlayer() then
		return true
	end

	local config = MazeState.config
	if not config then
		return true
	end

	local entry = config[mazePosKey(position)]
	if not entry then
		return true -- essa tile não é um teleport conhecido na config atual
	end

	local destination = entry.destinationArea
	local destinationPos

	if type(destination) == "number" then
		destinationPos = MazeState.areaPositions[destination]
	else
		destinationPos = destination -- já é uma Position direta (ex: saída do labirinto)
	end

	if not destinationPos then
		return true
	end

	creature:teleportTo(destinationPos)
	destinationPos:sendMagicEffect(CONST_ME_TELEPORT)

	return true
end

teleportPrison:type("stepin")
-- Registre aqui TODAS as posições físicas dos teleports do labirinto (os 18
-- da config1/config2, que são as mesmas coordenadas em todas as configs —
-- só o destino muda, não a posição do teleport em si).
teleportPrison:aid(13215)
teleportPrison:register()










-- local teleportPrison = MoveEvent()

-- function teleportPrison.onStepIn(creature, item, position, fromPosition)

--     local config1 = { -- areas utilizadas pelo caminho principal e que nao devem ser usadas como areas de destino por outros teleports na config1: 2, 3, 5, 6, 9
--         [Position(4233, 5227, 7)] = { number = 1, area = 1, areaPos = Position(4232, 5231, 7), destinationArea = 3 }
--         [Position(4232, 5227, 7)] = { number = 2, area = 1, areaPos = Position(4232, 5231, 7), destinationArea = 3 }
--         [Position(4230, 5231, 7)] = { number = 3, area = 2, areaPos = Position(4229, 5227, 7), destinationArea = 9 }
--         [Position(4228, 5231, 7)] = { number = 4, area = 2, areaPos = Position(4229, 5227, 7), destinationArea = 1 }
--         [Position(4226, 5227, 7)] = { number = 5, area = 3, areaPos = Position(4225, 5231, 7), destinationArea = 7 }
--         [Position(4224, 5227, 7)] = { number = 6, area = 3, areaPos = Position(4225, 5231, 7), destinationArea = 5 }
--         [Position(4233, 5225, 7)] = { number = 7, area = 4, areaPos = Position(4229, 5224, 7), destinationArea = 1 }
--         [Position(4233, 5223, 7)] = { number = 8, area = 4, areaPos = Position(4229, 5224, 7), destinationArea = 8 }
--         [Position(4224, 5225, 7)] = { number = 9, area = 5, areaPos = Position(4227, 5224, 7), destinationArea = 6 }
--         [Position(4222, 5225, 7)] = { number = 10, area = 5, areaPos = Position(4227, 5224, 7), destinationArea = 7 }
--         [Position(4228, 5221, 7)] = { number = 11, area = 6, areaPos = Position(4224, 5220, 7), destinationArea = 8 }
--         [Position(4226, 5221, 7)] = { number = 12, area = 6, areaPos = Position(4224, 5220, 7), destinationArea = 4  }
--         [Position(4230, 5219, 7)] = { number = 13, area = 7, areaPos = Position(4231, 5221, 7), destinationArea = 1 }
--         [Position(4233, 5219, 7)] = { number = 14, area = 7, areaPos = Position(4231, 5221, 7), destinationArea = 4 }
--         [Position(4233, 5217, 7)] = { number = 15, area = 8, areaPos = Position(4229, 5216, 7), destinationArea = 2 }
--         [Position(4233, 5215, 7)] = { number = 16, area = 8, areaPos = Position(4229, 5216, 7), destinationArea = 7 }
--         [Position(4227, 5217, 7)] = { number = 17, area = 9, areaPos = Position(4226, 5215, 7), destinationArea = Position(5000, 5000, 6) } -- saida
--         [Position(4224, 5217, 7)] = { number = 18, area = 9, areaPos = Position(4226, 5215, 7), destinationArea = 4 }
--     }





--     local config2 = {
--         [Position(4233, 5227, 7)] = { number = 1, area = 1, areaPos = Position(4232, 5231, 7), destination = Position() }
--         [Position(4232, 5227, 7)] = { number = 2, area = 1, areaPos = Position(4232, 5231, 7), destination = Position() }
--         [Position(4230, 5231, 7)] = { number = 3, area = 2, areaPos = Position(), destination = Position() }
--         [Position(4228, 5231, 7)] = { number = 4, area = 2, areaPos = Position(), destination = Position() }
--         [Position(4226, 5227, 7)] = { number = 5, area = 3, areaPos = Position(), destination = Position() }
--         [Position(4224, 5227, 7)] = { number = 6, area = 3, areaPos = Position(), destination = Position() }
--         [Position(4233, 5225, 7)] = { number = 7, area = 4, areaPos = Position(), destination = Position() }
--         [Position(4233, 5223, 7)] = { number = 8, area = 4, areaPos = Position(), destination = Position() }
--         [Position(4224, 5225, 7)] = { number = 9, area = 5, areaPos = Position(), destination = Position() }
--         [Position(4222, 5225, 7)] = { number = 10, area = 5, areaPos = Position(), destination = Position() }
--         [Position(4228, 5221, 7)] = { number = 11, area = 6, areaPos = Position(), destination = Position() }
--         [Position(4226, 5221, 7)] = { number = 12, area = 6, areaPos = Position(), destination = Position() }
--         [Position(4230, 5219, 7)] = { number = 13, area = 7, areaPos = Position(), destination = Position() }
--         [Position(4233, 5219, 7)] = { number = 14, area = 7, areaPos = Position(), destination = Position() }
--         [Position(4233, 5217, 7)] = { number = 15, area = 8, areaPos = Position(), destination = Position() }
--         [Position(4233, 5215, 7)] = { number = 16, area = 8, areaPos = Position(), destination = Position() }
--         [Position(4227, 5217, 7)] = { number = 17, area = 9, areaPos = Position(), destination = Position() }
--         [Position(4224, 5217, 7)] = { number = 18, area = 9, areaPos = Position(), destination = Position() }
--     }

    

-- end

-- teleportPrison:aid(13215)
-- teleportPrison:register()