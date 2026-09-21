--[[
    ARBAZILOTH — funções e configs compartilhadas entre as duas formas do boss
    (Arbaziloth normal e Weakened Arbaziloth). Antes, essas funções estavam
    duplicadas nos dois arquivos de monstro e já tinham divergido entre si
    (um tinha um `mType:register` a mais, o outro não).

    IMPORTANTE: este arquivo precisa carregar ANTES dos monstros "Arbaziloth"
    e "Weakened Arbaziloth". Scripts de monstro não fazem parte do sistema de
    revscripts (data/scripts/), então não existe uma pasta lib/ com carregamento
    garantido automaticamente — confirme onde seu fork carrega arquivos .lua
    globais antes da pasta data/monster/ (geralmente algo como data/lib/) e
    coloque este arquivo lá.
]]

ArbazilothShared = ArbazilothShared or {}

ArbazilothShared.aditionalMonsters = {
	{ name = "Overcharged Demon", pos = Position(5061, 4239, 12) },
	{ name = "Overcharged Demon", pos = Position(5060, 4247, 12) },
}

ArbazilothShared.areaTopLeft = Position(5060, 4238, 12)
ArbazilothShared.areaBottomRight = Position(5070, 4248, 12)

ArbazilothShared.effectInterval = 2000
ArbazilothShared.effectDuration = 5000

ArbazilothShared.forgemasterAreaTopLeft = Position(5058, 4236, 12)
ArbazilothShared.forgemasterAreaBottomRight = Position(5072, 4250, 12)

ArbazilothShared.fireSpawnTopLeft = Position(5059, 4239, 12)
ArbazilothShared.fireSpawnBottomRight = Position(5061, 4247, 12)

-- Trava contra múltiplas cadeias de invocação simultâneas: antes, cada chamada
-- de onThink que via "faltam demônios" podia iniciar seu próprio effectLoop()
-- de 5 segundos, e várias cadeias corriam em paralelo até os demônios aparecerem.
local summoningInProgress = false

function ArbazilothShared.countMonstersInArea(fromPos, toPos, monsterName)
	for x = fromPos.x, toPos.x do
		for y = fromPos.y, toPos.y do
			local tile = Tile(Position(x, y, fromPos.z))
			if tile then
				local creatures = tile:getCreatures()
				for _, creature in ipairs(creatures) do
					if creature:isMonster() and creature:getName():lower() == monsterName:lower() then
						return true
					end
				end
			end
		end
	end
	return false
end

function ArbazilothShared.healMaster(monster)
	if not monster or not monster:isMonster() then
		return
	end

	local healCount = Game.getStorageValue("globalArbazilothHeal") or 0
	if healCount >= 1 then
		return
	end
	monster:addHealth(monster:getMaxHealth() - monster:getHealth())
	monster:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	Game.setStorageValue("globalArbazilothHeal", healCount + 1)
end

function ArbazilothShared.replaceMaster(monster)
	if monster and monster:isMonster() then
		local pos = monster:getPosition()
		monster:remove()
		Game.createMonster("Weakened Arbaziloth", pos)
	end
end

function ArbazilothShared.countDemonsInArea(fromPos, toPos)
	local count = 0
	for x = fromPos.x, toPos.x do
		for y = fromPos.y, toPos.y do
			local tile = Tile(Position(x, y, fromPos.z))
			if tile then
				local creatures = tile:getCreatures()
				for _, creature in ipairs(creatures) do
					if creature:isMonster() and creature:getName():lower() == "overcharged demon" then
						count = count + 1
						if count >= 2 then
							return count
						end
					end
				end
			end
		end
	end
	return count
end

function ArbazilothShared.showEffectsAndSummon(monster)
	if summoningInProgress then
		return
	end
	summoningInProgress = true

	local times = 0

	local function effectLoop()
		if times < (ArbazilothShared.effectDuration / ArbazilothShared.effectInterval) then
			for _, monsterData in ipairs(ArbazilothShared.aditionalMonsters) do
				if ArbazilothShared.countDemonsInArea(ArbazilothShared.areaTopLeft, ArbazilothShared.areaBottomRight) < 2 then
					monsterData.pos:sendMagicEffect(CONST_ME_TELEPORT)
				end
			end
			times = times + 1
			addEvent(effectLoop, ArbazilothShared.effectInterval)
		else
			local currentCount = ArbazilothShared.countDemonsInArea(ArbazilothShared.areaTopLeft, ArbazilothShared.areaBottomRight)
			if currentCount < 2 then
				local demonsToSummon = 2 - currentCount
				for i = 1, demonsToSummon do
					local monsterData = ArbazilothShared.aditionalMonsters[i]
					if monsterData then
						Game.createMonster(monsterData.name, monsterData.pos)
					end
				end
			end
			summoningInProgress = false
		end
	end

	effectLoop()
end

function ArbazilothShared.getRandomPosition(fromPos, toPos)
	local x = math.random(fromPos.x, toPos.x)
	local y = math.random(fromPos.y, toPos.y)
	local z = fromPos.z
	return Position(x, y, z)
end

function ArbazilothShared.createItemInRandomPosition(itemId, fromPos, toPos)
	local maxAttempts = 10
	for _ = 1, maxAttempts do
		local pos = ArbazilothShared.getRandomPosition(fromPos, toPos)
		local tile = Tile(pos)
		if tile and not tile:getItemById(itemId) then
			-- CORRIGIDO: a versão original tinha um "if condição then else criar end"
			-- com o primeiro ramo vazio (fazia nada e "createItem" só rodava no else).
			-- Funcionalmente igual, só limpo.
			if Game.getStorageValue("globalArbazilothFire") < 1 then
				Game.createItem(itemId, 1, pos)
			end
			return true
		end
	end
	return false
end