--[[
    Aplica dano de agony (percentual da vida máxima) a cada 20s pra jogadores
    dentro da dungeon do Arbaziloth, com a porcentagem diminuindo conforme o
    número de vezes que o jogador já derrotou o boss (storage KillArbaziloth).
]]

local dungeonAreas = {
	{ from = Position(5012, 4172, 8), to = Position(5169, 4321, 8) },
	{ from = Position(5012, 4172, 9), to = Position(5169, 4321, 9) },
	{ from = Position(5012, 4172, 10), to = Position(5169, 4321, 10) },
	{ from = Position(5012, 4172, 11), to = Position(5169, 4321, 11) },
}

local killStorage = Storage.Quest.U14_10.NoRestForTheWicked.Essences

-- Retorna a porcentagem de dano de acordo com o número de vezes que o boss já foi morto
local function getAgonyPercent(kills)
	if kills < 100 then
		return 5.00
	elseif kills < 200 then
		return 4.50
	elseif kills < 400 then
		return 4.00
	elseif kills < 800 then
		return 3.5
	elseif kills < 1600 then
		return 3.00
	elseif kills < 3200 then
		return 2.50
	elseif kills < 6400 then
		return 2.00
	elseif kills < 12800 then
		return 1.50
	elseif kills < 25600 then
		return 1.00
	elseif kills < 51200 then
		return 0.50
	else 
		return 0
	end
end

local function applyAgonyToArea(area)
	local centerX = math.floor((area.from.x + area.to.x) / 2)
	local centerY = math.floor((area.from.y + area.to.y) / 2)
	local rangeX = math.abs(area.to.x - area.from.x)
	local rangeY = math.abs(area.to.y - area.from.y)
	local center = Position(centerX, centerY, area.from.z)

	-- onlyPlayers = true: só interessa jogador aqui, não monstros
	local spectators = Game.getSpectators(center, false, true, rangeX, rangeX, rangeY, rangeY)

	for _, player in ipairs(spectators) do
		local kills = player:getStorageValue(killStorage)
		if kills < 0 then
			kills = 0
		end

		local percent = getAgonyPercent(kills)
		if percent > 0 then
			local damage = math.floor(player:getMaxHealth() * (percent / 100))
			if damage > 0 then
				-- ajuste o efeito visual (CONST_ME_NONE) se quiser um feedback visível
				doTargetCombatHealth(0, player, COMBAT_AGONYDAMAGE, -damage, -damage, CONST_ME_NONE, ORIGIN_NONE)
			end
		end
	end
end

local arbazilothAgony = GlobalEvent("ArbazilothDungeonAgony")

function arbazilothAgony.onThink(interval)
	for _, area in ipairs(dungeonAreas) do
		applyAgonyToArea(area)
	end
	return true
end

arbazilothAgony:interval(20 * 1000)
arbazilothAgony:register()