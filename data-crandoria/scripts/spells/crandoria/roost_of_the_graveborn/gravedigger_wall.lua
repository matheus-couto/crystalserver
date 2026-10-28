--[[
    "gravedigger wall" — parede de 2 sqm de espessura que varre a sala de cima
    pra baixo, 1 sqm/segundo, com um buraco de 3 sqm (posição sorteada a cada
    nova parede, fixa durante toda aquela varredura) pros jogadores passarem.

    Cada acerto: 500-800 de dano de morte + incrementa um contador por
    jogador. Se o contador já estiver em 20 (ou mais) no momento do acerto,
    em vez do dano normal aplica 100000 de dano agony e reseta o contador.

    A cada nova parede: remove os "Bonelord Totem" existentes na área de
    totens e cria 2 novos em posições aleatórias distintas dentro dela.

    IMPORTANTE: crie a storage Storage.Quest.Crandoria.GravediggerWall.HitCounter
    na sua árvore central (ajuste o nome/caminho conforme o nome real do boss).
]]

local config = {
	arenaFrom = Position(4489, 4956, 9),
	arenaTo = Position(4505, 4976, 9),

	totemAreaFrom = Position(4494, 4964, 9),
	totemAreaTo = Position(4502, 4971, 9),
	totemName = "Bonelord Totem",

	gapWidth = 3,
	stepInterval = 600, -- 1 sqm por segundo

	minDamage = 500,
	maxDamage = 800,
	counterThreshold = 20,
	bigDamage = 100000,

	counterStorage = Storage.Quest.Crandoria.RoostOfTheGraveborn.GravediggerWallCounter,
}

local wallInProgress = false

local function getWalkableTilesInArea(fromPos, toPos)
	local walkable = {}
	for x = fromPos.x, toPos.x do
		for y = fromPos.y, toPos.y do
			local pos = Position(x, y, fromPos.z)
			local tile = Tile(pos)
			if tile and not tile:hasFlag(TILESTATE_BLOCKSOLID) and not tile:hasFlag(TILESTATE_PROTECTIONZONE) and not tile:getTopCreature() then
				table.insert(walkable, pos)
			end
		end
	end
	return walkable
end

local function spawnTotems()
	-- Remove os totems existentes na área
	for x = config.totemAreaFrom.x, config.totemAreaTo.x do
		for y = config.totemAreaFrom.y, config.totemAreaTo.y do
			local tile = Tile(Position(x, y, config.totemAreaFrom.z))
			local creature = tile and tile:getTopCreature()
			if creature and creature:isMonster() and creature:getName():lower() == config.totemName:lower() then
				creature:remove()
			end
		end
	end

	-- Cria 2 novos, em posições aleatórias e distintas
	local available = getWalkableTilesInArea(config.totemAreaFrom, config.totemAreaTo)
	for i = 1, 2 do
		if #available == 0 then
			break
		end
		local index = math.random(1, #available)
		local pos = available[index]
		table.remove(available, index)
		Game.createMonster(config.totemName, pos, true, true)
	end
end

local function applyWallHitToPlayer(player)
	local counter = player:getStorageValue(config.counterStorage)
	if counter < 0 then
		counter = 0
	end

	if counter >= config.counterThreshold then
		player:setIcon("gravedigger", CreatureIconCategory_Quests, CreatureIconQuests_RedShield, counter + 1)
		player:setStorageValue(config.counterStorage, 0)
		addEvent(function()
			doTargetCombatHealth(0, player, COMBAT_AGONYDAMAGE, -config.bigDamage, -config.bigDamage, CONST_ME_REAPER, ORIGIN_NONE)
		end, 200)
	else
		local factorMin = config.minDamage * (1 + counter * 0.1)
		local factorMin = config.maxDamage * (1 + counter * 0.1)
		local damage = math.random(factorMin, factorMin)
		player:setStorageValue(config.counterStorage, counter + 1)
		player:setIcon("gravedigger", CreatureIconCategory_Quests, CreatureIconQuests_RedShield, counter + 1)
		doTargetCombatHealth(0, player, COMBAT_DEATHDAMAGE, -damage, -damage, CONST_ME_REAPER, ORIGIN_NONE)
	end
end

local function sweepStep(currentY, gapStartX)
	if currentY + 1 > config.arenaTo.y then
		wallInProgress = false
		return
	end

	for x = config.arenaFrom.x, config.arenaTo.x do
		local inGap = x >= gapStartX and x < gapStartX + config.gapWidth
		if not inGap then
			for _, y in ipairs({ currentY, currentY + 1 }) do
				local pos = Position(x, y, config.arenaFrom.z)
				pos:sendMagicEffect(CONST_ME_REAPER)

				local tile = Tile(pos)
				local creature = tile and tile:getTopCreature()
				if creature and creature:isPlayer() then
					applyWallHitToPlayer(creature)
				end
			end
		end
	end

	addEvent(sweepStep, config.stepInterval, currentY + 1, gapStartX)
end

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	if wallInProgress then
		return true -- já tem uma parede em andamento, não inicia outra por cima
	end

	wallInProgress = true
	spawnTotems()

	local maxGapStart = config.arenaTo.x - config.gapWidth + 1
	local gapStartX = math.random(config.arenaFrom.x, maxGapStart)

	sweepStep(config.arenaFrom.y, gapStartX)

	return true
end

spell:name("gravedigger wall")
spell:words("###781")
spell:isAggressive(true)
spell:register()