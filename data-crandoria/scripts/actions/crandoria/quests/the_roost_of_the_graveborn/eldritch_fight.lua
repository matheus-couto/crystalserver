--[[
    ELDRITCH DRAGON LORD — configuração compartilhada da luta.

    As 4 posições são as "vagas" fixas dos cantos da sala. Elas nunca mudam
    durante a luta — o que muda é qual estágio (Pulsating Lava / Eruption /
    Flame Totem) ocupa cada uma, via transformação no mesmo lugar (remove +
    cria de novo), preservando a vida atual.
]]

EldritchFight = EldritchFight or {}

EldritchFight.lavaPositions = {
	Position(4483, 4998, 9),
	Position(4492, 4998, 9),
	Position(4482, 5008, 9),
	Position(4492, 5007, 9),
}

EldritchFight.arenaFrom = Position(4478, 4994, 9)
EldritchFight.arenaTo = Position(4498, 5011, 9)

-- Limiares de transformação (vida atual do monstro no canto)
EldritchFight.thresholds = {
	eruption = 6000,    -- Pulsating Lava > 6000 vira Eruption; Eruption < 6000 volta a Pulsating Lava
	flameTotem = 9000,  -- Eruption > 9000 vira Flame Totem; Flame Totem < 9000 volta a Eruption
}

-- Regras de defesa do boss
EldritchFight.damageReductionPerFlameTotem = 25 -- % de redução de dano por Flame Totem vivo
EldritchFight.invulnerabilityFlameTotemThreshold = 3 -- com pelo menos 3 Flame Totems ativos, boss invulnerável

-- Piso de vida que impede os monstros dos cantos de morrerem de verdade
EldritchFight.minHealthFloor = 1

function EldritchFight.getCornerOccupants()
	local occupants = {}
	for i, pos in ipairs(EldritchFight.lavaPositions) do
		local tile = Tile(pos)
		local creature = tile and tile:getTopCreature()
		occupants[i] = (creature and creature:isMonster()) and creature or nil
	end
	return occupants
end
