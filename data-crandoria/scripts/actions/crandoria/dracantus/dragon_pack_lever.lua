local config = {
	boss = {
		name = "Dragon",
		position = Position(4471, 4863, 12)
	},
	requiredLevel = 300,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 25 * 60,
	playerPositions = {
		{pos = Position(4505, 4903, 12), teleport = Position(4471, 4892, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(4506, 4903, 12), teleport = Position(4471, 4892, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(4507, 4903, 12), teleport = Position(4471, 4892, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(4508, 4903, 12), teleport = Position(4471, 4892, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(4509, 4903, 12), teleport = Position(4471, 4892, 12), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(4458, 4858, 12),
		to = Position(4488, 4899, 12)
	},
	exit = Position(4511, 4903, 12),
	storage = Storage.Quest.Crandoria.TwentyYearsCook.BossCooldown
}

local dragonPackLever = Action()
function dragonPackLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if hasPlayerInArea(Position(4458, 4858, 12), Position(4488, 4899, 12)) then
    	return CreateDefaultLeverBoss(player, config)
	else
		Game.setStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Maliz, 0)
		Game.setStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Vengar, 0)
		Game.setStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Bruton, 0)
		Game.setStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Greedok, 0)
		Game.setStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Vilear, 0)
		Game.setStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Crultor, 0)
		Game.setStorageValue(GlobalStorage.Crandoria.DragonPack.Effects.Despor, 0)
		return CreateDefaultLeverBoss(player, config)
	end
end

dragonPackLever:position({x = 4504, y = 4903, z = 12})
dragonPackLever:register()
