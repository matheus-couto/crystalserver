--[[
    LABIRINTO DA PRISÃO — configs de rotas dos teleports.

    Cada config mapeia POSIÇÃO DO TELEPORT (como chave de texto "x:y:z", não
    como Position — veja mazePosKey) para:
      - area: número da área onde esse teleport fica
      - areaPos: posição física de entrada dessa área (usada quando OUTRO
        teleport aponta destinationArea pra cá)
      - destinationArea: pra qual área esse teleport te manda. Pode ser um
        número (área normal) ou uma Position direta (ex: saída do labirinto)

    Adicione config3, config4... seguindo o mesmo formato. O importante é
    manter "area"/"areaPos" idênticos entre configs (é a estrutura física do
    labirinto) — só o "destinationArea" de cada teleport deve mudar.
]]

MazeState = MazeState or {}

function mazePosKey(pos)
	return pos.x .. ":" .. pos.y .. ":" .. pos.z
end

local mazeConfigs = {}

-- Áreas usadas pelo caminho principal nesta config (não usar como destino de
-- outros teleports pra não formar atalho): 2, 3, 5, 6, 9
mazeConfigs.config1 = {
	[mazePosKey(Position(4233, 5227, 7))] = { area = 1, areaPos = Position(4232, 5231, 7), destinationArea = 3 },
	[mazePosKey(Position(4232, 5227, 7))] = { area = 1, areaPos = Position(4232, 5231, 7), destinationArea = 3 },
	[mazePosKey(Position(4230, 5231, 7))] = { area = 2, areaPos = Position(4229, 5227, 7), destinationArea = 9 },
	[mazePosKey(Position(4228, 5231, 7))] = { area = 2, areaPos = Position(4229, 5227, 7), destinationArea = 1 },
	[mazePosKey(Position(4226, 5227, 7))] = { area = 3, areaPos = Position(4225, 5231, 7), destinationArea = 7 },
	[mazePosKey(Position(4224, 5227, 7))] = { area = 3, areaPos = Position(4225, 5231, 7), destinationArea = 5 },
	[mazePosKey(Position(4233, 5225, 7))] = { area = 4, areaPos = Position(4229, 5224, 7), destinationArea = 1 },
	[mazePosKey(Position(4233, 5223, 7))] = { area = 4, areaPos = Position(4229, 5224, 7), destinationArea = 8 },
	[mazePosKey(Position(4224, 5225, 7))] = { area = 5, areaPos = Position(4227, 5224, 7), destinationArea = 6 },
	[mazePosKey(Position(4222, 5225, 7))] = { area = 5, areaPos = Position(4227, 5224, 7), destinationArea = 7 },
	[mazePosKey(Position(4228, 5219, 7))] = { area = 6, areaPos = Position(4224, 5220, 7), destinationArea = 8 },
	[mazePosKey(Position(4226, 5221, 7))] = { area = 6, areaPos = Position(4224, 5220, 7), destinationArea = 4 },
	[mazePosKey(Position(4230, 5219, 7))] = { area = 7, areaPos = Position(4231, 5221, 7), destinationArea = 1 },
	[mazePosKey(Position(4233, 5219, 7))] = { area = 7, areaPos = Position(4231, 5221, 7), destinationArea = 4 },
	[mazePosKey(Position(4233, 5217, 7))] = { area = 8, areaPos = Position(4229, 5216, 7), destinationArea = 2 },
	[mazePosKey(Position(4233, 5215, 7))] = { area = 8, areaPos = Position(4229, 5216, 7), destinationArea = 7 },
	[mazePosKey(Position(4227, 5217, 7))] = { area = 9, areaPos = Position(4226, 5215, 7), destinationArea = Position(5000, 5000, 6) }, -- saída
	[mazePosKey(Position(4224, 5217, 7))] = { area = 9, areaPos = Position(4226, 5215, 7), destinationArea = 4 },
}

-- Mesma estrutura física (area/areaPos idênticos), só o destinationArea muda,
-- pra formar um caminho diferente através do labirinto.
mazeConfigs.config2 = {
	[mazePosKey(Position(4233, 5227, 7))] = { area = 1, areaPos = Position(4232, 5231, 7), destinationArea = 6 },
	[mazePosKey(Position(4232, 5227, 7))] = { area = 1, areaPos = Position(4232, 5231, 7), destinationArea = 4 },
	[mazePosKey(Position(4230, 5231, 7))] = { area = 2, areaPos = Position(4229, 5227, 7), destinationArea = 7 },
	[mazePosKey(Position(4228, 5231, 7))] = { area = 2, areaPos = Position(4229, 5227, 7), destinationArea = 9 },
	[mazePosKey(Position(4226, 5227, 7))] = { area = 3, areaPos = Position(4225, 5231, 7), destinationArea = 1 },
	[mazePosKey(Position(4224, 5227, 7))] = { area = 3, areaPos = Position(4225, 5231, 7), destinationArea = 8 },
	[mazePosKey(Position(4233, 5225, 7))] = { area = 4, areaPos = Position(4229, 5224, 7), destinationArea = 5 },
	[mazePosKey(Position(4233, 5223, 7))] = { area = 4, areaPos = Position(4229, 5224, 7), destinationArea = 2 },
	[mazePosKey(Position(4224, 5225, 7))] = { area = 5, areaPos = Position(4227, 5224, 7), destinationArea = 3 },
	[mazePosKey(Position(4222, 5225, 7))] = { area = 5, areaPos = Position(4227, 5224, 7), destinationArea = 1 },
	[mazePosKey(Position(4228, 5221, 7))] = { area = 6, areaPos = Position(4224, 5220, 7), destinationArea = 7 },
	[mazePosKey(Position(4226, 5221, 7))] = { area = 6, areaPos = Position(4224, 5220, 7), destinationArea = 9 },
	[mazePosKey(Position(4230, 5219, 7))] = { area = 7, areaPos = Position(4231, 5221, 7), destinationArea = 8 },
	[mazePosKey(Position(4233, 5219, 7))] = { area = 7, areaPos = Position(4231, 5221, 7), destinationArea = 3 },
	[mazePosKey(Position(4233, 5217, 7))] = { area = 8, areaPos = Position(4229, 5216, 7), destinationArea = 4 },
	[mazePosKey(Position(4233, 5215, 7))] = { area = 8, areaPos = Position(4229, 5216, 7), destinationArea = 6 },
	[mazePosKey(Position(4227, 5217, 7))] = { area = 9, areaPos = Position(4226, 5215, 7), destinationArea = Position(5000, 5000, 6) }, -- saída
	[mazePosKey(Position(4224, 5217, 7))] = { area = 9, areaPos = Position(4226, 5215, 7), destinationArea = 2 },
}

mazeConfigs.config3 = { -- 3, 4, 8, 9
	[mazePosKey(Position(4233, 5227, 7))] = { area = 1, areaPos = Position(4232, 5231, 7), destinationArea = 3 },
	[mazePosKey(Position(4232, 5227, 7))] = { area = 1, areaPos = Position(4232, 5231, 7), destinationArea = 3 },
	[mazePosKey(Position(4230, 5231, 7))] = { area = 2, areaPos = Position(4229, 5227, 7), destinationArea = 1 },
	[mazePosKey(Position(4228, 5231, 7))] = { area = 2, areaPos = Position(4229, 5227, 7), destinationArea = 5 },
	[mazePosKey(Position(4226, 5227, 7))] = { area = 3, areaPos = Position(4225, 5231, 7), destinationArea = 7 },
	[mazePosKey(Position(4224, 5227, 7))] = { area = 3, areaPos = Position(4225, 5231, 7), destinationArea = 8 },
	[mazePosKey(Position(4233, 5225, 7))] = { area = 4, areaPos = Position(4229, 5224, 7), destinationArea = 9 },
	[mazePosKey(Position(4233, 5223, 7))] = { area = 4, areaPos = Position(4229, 5224, 7), destinationArea = 6 },
	[mazePosKey(Position(4224, 5225, 7))] = { area = 5, areaPos = Position(4227, 5224, 7), destinationArea = 2 },
	[mazePosKey(Position(4222, 5225, 7))] = { area = 5, areaPos = Position(4227, 5224, 7), destinationArea = 1 },
	[mazePosKey(Position(4228, 5221, 7))] = { area = 6, areaPos = Position(4224, 5220, 7), destinationArea = 7 },
	[mazePosKey(Position(4226, 5221, 7))] = { area = 6, areaPos = Position(4224, 5220, 7), destinationArea = 2 },
	[mazePosKey(Position(4230, 5219, 7))] = { area = 7, areaPos = Position(4231, 5221, 7), destinationArea = 6 },
	[mazePosKey(Position(4233, 5219, 7))] = { area = 7, areaPos = Position(4231, 5221, 7), destinationArea = 2 },
	[mazePosKey(Position(4233, 5217, 7))] = { area = 8, areaPos = Position(4229, 5216, 7), destinationArea = 5 },
	[mazePosKey(Position(4233, 5215, 7))] = { area = 8, areaPos = Position(4229, 5216, 7), destinationArea = 4 },
	[mazePosKey(Position(4227, 5217, 7))] = { area = 9, areaPos = Position(4226, 5215, 7), destinationArea = 1 }, -- saída
	[mazePosKey(Position(4224, 5217, 7))] = { area = 9, areaPos = Position(4226, 5215, 7), destinationArea = Position(5000, 5000, 6) },
}

local function buildAreaPositions(config)
	local areaPositions = {}
	for _, data in pairs(config) do
		areaPositions[data.area] = data.areaPos
	end
	return areaPositions
end

-- Sorteia uma config entre as disponíveis e a torna a "ativa"
function activateRandomMazeConfig()
	local configNames = {}
	for name in pairs(mazeConfigs) do
		table.insert(configNames, name)
	end

	local chosenName = configNames[math.random(1, #configNames)]
	local chosenConfig = mazeConfigs[chosenName]

	MazeState.config = chosenConfig
	MazeState.areaPositions = buildAreaPositions(chosenConfig)
	MazeState.configName = chosenName
end

-- Garante que já exista uma config ativa assim que o servidor sobe,
-- sem esperar a primeira hora rodar.
if not MazeState.config then
	activateRandomMazeConfig()
end