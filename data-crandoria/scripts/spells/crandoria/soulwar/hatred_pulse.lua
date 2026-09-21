local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_LIFEDRAIN)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_NONE)

local damageMin, damageMax = -300, -600
local areaMatrix = AREA_SQUARE1X1

-- Função para obter todos os jogadores em volta de um centro, excluindo o central
local function getPlayersAround(center, matrix)
	local players = {}
	local startX = center.x - math.floor(#matrix[1] / 2)
	local startY = center.y - math.floor(#matrix / 2)

	for y = 1, #matrix do
		for x = 1, #matrix[y] do
			local pos = Position(startX + (x - 1), startY + (y - 1), center.z)

			-- Ignora o centro
			if not (pos.x == center.x and pos.y == center.y) and (matrix[y][x] == 1 or matrix[y][x] == 3) then
				local tile = Tile(pos)
				if tile then
					local creature = tile:getTopCreature()
					if creature and creature:isPlayer() then
						table.insert(players, creature)
					end
				end
			end
		end
	end
	return players
end

-- Envia efeitos visuais em volta da posição (3x3), incluindo o centro
local function sendEffectArea(center, matrix, effect)
	local startX = center.x - math.floor(#matrix[1] / 2)
	local startY = center.y - math.floor(#matrix / 2)

	for y = 1, #matrix do
		for x = 1, #matrix[y] do
			if matrix[y][x] == 1 or matrix[y][x] == 3 then
				local pos = Position(startX + (x - 1), startY + (y - 1), center.z)
				pos:sendMagicEffect(effect)
			end
		end
	end
end

-- Lógica da spell
local function spellEffect(caster, variant)
	local centerPos = Position(33743, 31599, 14)
	local areaRadius = 10

	if caster:getName() == "Goshnar's Megalomania" or caster:getName() == "Goshnar's Megalomania 2" then
		centerPos = Position(33710, 31634, 14)
	end

	for x = -areaRadius, areaRadius do
		for y = -areaRadius, areaRadius do
			local pos = Position(centerPos.x + x, centerPos.y + y, centerPos.z)
			local tile = Tile(pos)
			if tile then
				local topCreature = tile:getTopCreature()
				if topCreature and topCreature:isPlayer() then
					-- Aplica dano apenas aos jogadores ao redor (excluindo o central)
					local targets = getPlayersAround(pos, areaMatrix)
					for _, target in pairs(targets) do
						doTargetCombatHealth(caster, target, COMBAT_LIFEDRAIN, damageMin, damageMax, CONST_ME_NONE)
					end
					-- Efeitos visuais em volta (inclui o central)
					sendEffectArea(pos, areaMatrix, CONST_ME_PINK_ENERGY_SPARK)
				end
			end
		end
	end
	return true
end

-- Registro do feitiço
local spell = Spell("instant")
function spell.onCastSpell(creature, variant)
	return spellEffect(creature, variant)
end

spell:name("hatred pulse")
spell:words("###753")
spell:isAggressive(true)
spell:needLearn(false)
spell:register()


-- local combat = Combat()
-- combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_LIFEDRAIN)
-- combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_NONE) -- sem efeito global

-- local damageMin, damageMax = -300, -600
-- local areaMatrix = AREA_SQUARE1X1 -- Use diretamente a matriz, não createCombatArea()

-- -- Função para obter todos os jogadores dentro da matriz de área
-- local function getPlayersInArea(center, matrix)
-- 	local players = {}
-- 	local startX = center.x - math.floor(#matrix[1] / 2)
-- 	local startY = center.y - math.floor(#matrix / 2)

-- 	for y = 1, #matrix do
-- 		for x = 1, #matrix[y] do
-- 			if matrix[y][x] == 1 or matrix[y][x] == 3 then
-- 				local tilePos = Position(startX + (x - 1), startY + (y - 1), center.z)
-- 				local tile = Tile(tilePos)
-- 				if tile then
-- 					local creature = tile:getTopCreature()
-- 					if creature and creature:isPlayer() then
-- 						table.insert(players, creature)
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end
-- 	return players
-- end

-- -- Envia efeitos visuais em volta da posição (3x3)
-- local function sendEffectArea(center, matrix, effect)
-- 	local startX = center.x - math.floor(#matrix[1] / 2)
-- 	local startY = center.y - math.floor(#matrix / 2)

-- 	for y = 1, #matrix do
-- 		for x = 1, #matrix[y] do
-- 			if matrix[y][x] == 1 or matrix[y][x] == 3 then
-- 				local pos = Position(startX + (x - 1), startY + (y - 1), center.z)
-- 				pos:sendMagicEffect(effect)
-- 			end
-- 		end
-- 	end
-- end

-- -- Efeito da magia
-- local function spellEffect(caster, variant)
-- 	local centerPos = Position(33743, 31599, 14)
-- 	local areaRadius = 10

-- 	for x = -areaRadius, areaRadius do
-- 		for y = -areaRadius, areaRadius do
-- 			local pos = Position(centerPos.x + x, centerPos.y + y, centerPos.z)
-- 			local tile = Tile(pos)
-- 			if tile then
-- 				local topCreature = tile:getTopCreature()
-- 				if topCreature and topCreature:isPlayer() then
-- 					-- Aplica dano a todos os jogadores em volta (3x3)
-- 					local targets = getPlayersInArea(pos, areaMatrix)
-- 					for _, target in pairs(targets) do
-- 						doTargetCombatHealth(caster, target, COMBAT_LIFEDRAIN, damageMin, damageMax, CONST_ME_NONE)
-- 					end
-- 					-- Envia efeito visual 3x3 ao redor do jogador afetado
-- 					sendEffectArea(pos, areaMatrix, CONST_ME_PINK_ENERGY_SPARK)
-- 				end
-- 			end
-- 		end
-- 	end
-- 	return true
-- end

-- -- Registro do feitiço
-- local spell = Spell("instant")
-- function spell.onCastSpell(creature, variant)
-- 	return spellEffect(creature, variant)
-- end

-- spell:name("Hatred Pulse")
-- spell:words("###753")
-- spell:isAggressive(true)
-- spell:needLearn(false)
-- spell:register()



