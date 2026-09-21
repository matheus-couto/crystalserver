local internalNpcName = "Rock In A Viridian Place"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookTypeEx = 13424
}

npcConfig.flags = {
	floorchange = false
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
{ itemName = "animate dead rune", clientId = 3203, buy = 375 },
	{ itemName = "arrow", clientId = 3447, buy = 3 },
	{ itemName = "avalanche rune", clientId = 3161, buy = 57 },
	{ itemName = "axe", clientId = 3274, buy = 20, sell = 6 },
	{ itemName = "backpack", clientId = 2854, buy = 20 },
	{ itemName = "basket", clientId = 2855, buy = 6 },
	{ itemName = "battle axe", clientId = 3266, buy = 235, sell = 64 },
	{ itemName = "battle hammer", clientId = 3305, buy = 350, sell = 96 },
	{ itemName = "battle shield", clientId = 3413, sell = 76 },
	{ itemName = "blank rune", clientId = 3147, buy = 10 },
	{ itemName = "blue quiver", clientId = 35848, buy = 400 },
	{ itemName = "bolt", clientId = 3446, buy = 4 },
	{ itemName = "bone club", clientId = 3337, sell = 4 },
	{ itemName = "bone sword", clientId = 3338, buy = 75, sell = 16 },
	{ itemName = "bottle", clientId = 2875, buy = 3 },
	{ itemName = "bow", clientId = 3350, buy = 400, sell = 80 },
	{ itemName = "brass armor", clientId = 3359, buy = 450, sell = 120 },
	{ itemName = "brass helmet", clientId = 3354, buy = 120, sell = 24 },
	{ itemName = "brass legs", clientId = 3372, buy = 195, sell = 39 },
	{ itemName = "brass shield", clientId = 3411, buy = 65, sell = 20 },
	{ itemName = "bucket", clientId = 2873, buy = 4 },
	{ itemName = "calopteryx cape", clientId = 14086, sell = 12000 },
	{ itemName = "candelabrum", clientId = 2911, buy = 8 },
	{ itemName = "candlestick", clientId = 2917, buy = 2 },
	{ itemName = "carapace shield", clientId = 14088, sell = 25600 },
	{ itemName = "carlin sword", clientId = 3283, buy = 473, sell = 94 },
	{ itemName = "chain armor", clientId = 3358, buy = 200, sell = 56 },
	{ itemName = "chain helmet", clientId = 3352, buy = 52, sell = 13 },
	{ itemName = "chain legs", clientId = 3558, buy = 80, sell = 20 },
	{ itemName = "chameleon rune", clientId = 3178, buy = 210 },
	{ itemName = "closed trap", clientId = 3481, buy = 280, sell = 60 },
	{ itemName = "club", clientId = 3270, buy = 5, sell = 1 },
	{ itemName = "coat", clientId = 3562, buy = 8, sell = 1 },
	{ itemName = "compound eye", clientId = 14083, sell = 120 },
	{ itemName = "convince creature rune", clientId = 3177, buy = 80 },
	{ itemName = "copper shield", clientId = 3430, sell = 40 },
	{ itemName = "crawler head plating", clientId = 14079, sell = 168 },
	{ itemName = "crossbow", clientId = 3349, buy = 500, sell = 96 },
	{ itemName = "crowbar", clientId = 3304, buy = 260, sell = 40 },
	{ itemName = "crowbar", clientId = 3304, buy = 260 },
	{ itemName = "crystalline arrow", clientId = 15793, buy = 20 },
	{ itemName = "cure poison rune", clientId = 3153, buy = 65 },
	{ itemName = "dagger", clientId = 3267, buy = 5, sell = 1 },
	{ itemName = "deepling axe", clientId = 13991, sell = 32000 },
	{ itemName = "deepling breaktime snack", clientId = 14011, sell = 72 },
	{ itemName = "deepling claw", clientId = 14044, sell = 344 },
	{ itemName = "deepling guard belt buckle", clientId = 14010, sell = 184 },
	{ itemName = "deepling ridge", clientId = 14041, sell = 288 },
	{ itemName = "deepling scales", clientId = 14017, sell = 64 },
	{ itemName = "deepling squelcher", clientId = 14250, sell = 5600 },
	{ itemName = "deepling staff", clientId = 13987, sell = 3200 },
	{ itemName = "deepling warts", clientId = 14012, sell = 144 },
	{ itemName = "deeptags", clientId = 14013, sell = 232 },
	{ itemName = "depth calcei", clientId = 13997, sell = 20000 },
	{ itemName = "depth galea", clientId = 13995, sell = 28000 },
	{ itemName = "depth lorica", clientId = 13994, sell = 24000 },
	{ itemName = "depth ocrea", clientId = 13996, sell = 12800 },
	{ itemName = "depth scutum", clientId = 13998, sell = 28800 },
	{ itemName = "desintegrate rune", clientId = 3197, buy = 26 },
	{ itemName = "destroy field rune", clientId = 3148, buy = 15 },
	{ itemName = "diamond arrow", clientId = 35901, buy = 100 },
	{ itemName = "double axe", clientId = 3275, sell = 208 },
	{ itemName = "doublet", clientId = 3379, buy = 16, sell = 2 },
	{ itemName = "drill bolt", clientId = 16142, buy = 12 },
	{ itemName = "dung ball", clientId = 14225, sell = 104 },
	{ itemName = "dwarven shield", clientId = 3425, buy = 500, sell = 80 },
	{ itemName = "earth arrow", clientId = 774, buy = 5 },
	{ itemName = "empty potion flask", clientId = 283, sell = 4 },
	{ itemName = "empty potion flask", clientId = 284, sell = 4 },
	{ itemName = "empty potion flask", clientId = 285, sell = 4 },
	{ itemName = "energy bomb rune", clientId = 3149, buy = 203 },
	{ itemName = "energy field rune", clientId = 3164, buy = 38 },
	{ itemName = "energy wall rune", clientId = 3166, buy = 85 },
	{ itemName = "envenomed arrow", clientId = 16143, buy = 12 },
	{ itemName = "explosion rune", clientId = 3200, buy = 31 },
	{ itemName = "eye of a deepling", clientId = 12730, sell = 120 },
	{ itemName = "fire bomb rune", clientId = 3192, buy = 147 },
	{ itemName = "fire field rune", clientId = 3188, buy = 28 },
	{ itemName = "fire sword", clientId = 3280, sell = 800 },
	{ itemName = "fire wall rune", clientId = 3190, buy = 61 },
	{ itemName = "fireball rune", clientId = 3189, buy = 30 },
	{ itemName = "fishing rod", clientId = 3483, buy = 150, sell = 32 },
	{ itemName = "flaming arrow", clientId = 763, buy = 5 },
	{ itemName = "flash arrow", clientId = 761, buy = 5 },
	{ itemName = "grasshopper legs", clientId = 14087, sell = 12000 },
	{ itemName = "great fireball rune", clientId = 3191, buy = 57 },
	{ itemName = "great health potion", clientId = 239, buy = 240 },
	{ itemName = "great mana potion", clientId = 238, buy = 173 },
	{ itemName = "great spirit potion", clientId = 7642, buy = 278 },
	{ itemName = "guardian axe", clientId = 14043, sell = 7200 },
	{ itemName = "halberd", clientId = 3269, sell = 320 },
	{ itemName = "hand auger", clientId = 31334, buy = 25 },
	{ itemName = "hand axe", clientId = 3268, buy = 8, sell = 3 },
	{ itemName = "hatchet", clientId = 3276, sell = 20 },
	{ itemName = "health potion", clientId = 266, buy = 53 },
	{ itemName = "heavy magic missile rune", clientId = 3198, buy = 12 },
	{ itemName = "hive bow", clientId = 14246, sell = 22400 },
	{ itemName = "hive scythe", clientId = 14089, sell = 13600 },
	{ itemName = "holy missile rune", clientId = 3182, buy = 16 },
	{ itemName = "icicle rune", clientId = 3158, buy = 30 },
	{ itemName = "intense healing rune", clientId = 3152, buy = 95 },
	{ itemName = "iron helmet", clientId = 3353, buy = 390, sell = 120 },
	{ itemName = "jacket", clientId = 3561, buy = 12, sell = 1 },
	{ itemName = "katana", clientId = 3300, sell = 28 },
	{ itemName = "key to the drowned library", clientId = 14009, sell = 264 },
	{ itemName = "kollos shell", clientId = 14077, sell = 336 },
	{ itemName = "label", clientId = 3507, buy = 1 },
	{ itemName = "leather armor", clientId = 3361, buy = 35, sell = 9 },
	{ itemName = "leather boots", clientId = 3552, buy = 10, sell = 1 },
	{ itemName = "leather helmet", clientId = 3355, buy = 12, sell = 3 },
	{ itemName = "leather legs", clientId = 3559, buy = 10, sell = 7 },
	{ itemName = "legion helmet", clientId = 3374, sell = 17 },
	{ itemName = "letter", clientId = 3505, buy = 8 },
	{ itemName = "light magic missile rune", clientId = 3174, buy = 4 },
	{ itemName = "longsword", clientId = 3285, buy = 160, sell = 40 },
	{ itemName = "mace", clientId = 3286, buy = 90, sell = 24 },
	{ itemName = "machete", clientId = 3308, buy = 35, sell = 4 },
	{ itemName = "magic wall rune", clientId = 3180, buy = 116 },
	{ itemName = "mana potion", clientId = 268, buy = 60 },
	{ itemName = "morning star", clientId = 3282, buy = 430, sell = 80 },
	{ itemName = "necklace of the deep", clientId = 13990, sell = 2400 },
	{ itemName = "net", clientId = 31489, buy = 50 },
	{ itemName = "onyx arrow", clientId = 7365, buy = 7 },
	{ itemName = "orcish axe", clientId = 3316, sell = 280 },
	{ itemName = "ornate chestplate", clientId = 13993, sell = 48000 },
	{ itemName = "ornate crossbow", clientId = 14247, sell = 9600 },
	{ itemName = "ornate legs", clientId = 13999, sell = 32000 },
	{ itemName = "ornate mace", clientId = 14001, sell = 33600 },
	{ itemName = "ornate shield", clientId = 14000, sell = 33600 },
	{ itemName = "paralyze rune", clientId = 3165, buy = 700 },
	{ itemName = "parcel", clientId = 3503, buy = 15 },
	{ itemName = "pick", clientId = 3456, buy = 50, sell = 12 },
	{ itemName = "piercing bolt", clientId = 7363, buy = 5 },
	{ itemName = "plate armor", clientId = 3357, buy = 1200, sell = 320 },
	{ itemName = "plate legs", clientId = 3557, sell = 92 },
	{ itemName = "plate shield", clientId = 3410, buy = 125, sell = 36 },
	{ itemName = "poison bomb rune", clientId = 3173, buy = 85 },
	{ itemName = "poison field rune", clientId = 3172, buy = 21 },
	{ itemName = "poison wall rune", clientId = 3176, buy = 52 },
	{ itemName = "power bolt", clientId = 3450, buy = 7 },
	{ itemName = "present", clientId = 2856, buy = 10 },
	{ itemName = "prismatic bolt", clientId = 16141, buy = 20 },
	{ itemName = "quiver", clientId = 35562, buy = 400 },
	{ itemName = "rapier", clientId = 3272, buy = 15, sell = 4 },
	{ itemName = "red quiver", clientId = 35849, buy = 400 },
	{ itemName = "rope", clientId = 3003, buy = 50, sell = 12 },
	{ itemName = "royal spear", clientId = 7378, buy = 15 },
	{ itemName = "sabre", clientId = 3273, buy = 35, sell = 9 },
	{ itemName = "scale armor", clientId = 3377, buy = 260, sell = 60 },
	{ itemName = "scythe", clientId = 3453, buy = 50, sell = 8 },
	{ itemName = "shiver arrow", clientId = 762, buy = 5 },
	{ itemName = "short sword", clientId = 3294, buy = 26, sell = 8 },
	{ itemName = "shovel", clientId = 3457, buy = 50, sell = 6 },
	{ itemName = "sickle", clientId = 3293, buy = 7, sell = 2 },
	{ itemName = "small axe", clientId = 3462, sell = 4 },
	{ itemName = "sniper arrow", clientId = 7364, buy = 5 },
	{ itemName = "soldier helmet", clientId = 3375, buy = 110, sell = 12 },
	{ itemName = "soulfire rune", clientId = 3195, buy = 46 },
	{ itemName = "spear", clientId = 3277, buy = 9, sell = 2 },
{ itemName = "spectral bolt", clientId = 35902, buy = 70 },
{ itemName = "spellsinger's seal", clientId = 14008, sell = 224 },
{ itemName = "spidris mandible", clientId = 14082, sell = 360 },
{ itemName = "spike sword", clientId = 3271, buy = 8000, sell = 192 },
{ itemName = "spitter nose", clientId = 14078, sell = 272 },
{ itemName = "stalagmite rune", clientId = 3179, buy = 12 },
{ itemName = "steel helmet", clientId = 3351, buy = 580, sell = 234 },
{ itemName = "steel shield", clientId = 3409, buy = 240, sell = 64 },
{ itemName = "stone shower rune", clientId = 3175, buy = 37 },
{ itemName = "strong health potion", clientId = 236, buy = 125 },
{ itemName = "strong mana potion", clientId = 237, buy = 118 },
{ itemName = "studded armor", clientId = 3378, buy = 90, sell = 20 },
{ itemName = "studded club", clientId = 3336, sell = 8 },
{ itemName = "studded helmet", clientId = 3376, buy = 63, sell = 16 },
{ itemName = "studded legs", clientId = 3362, buy = 50, sell = 12 },
{ itemName = "studded shield", clientId = 3426, buy = 50, sell = 12 },
{ itemName = "sudden death rune", clientId = 3155, buy = 135 },
{ itemName = "supreme health potion", clientId = 23375, buy = 685 },
{ itemName = "swampling club", clientId = 17824, sell = 32 },
{ itemName = "swarmer antenna", clientId = 14076, sell = 104 },
{ itemName = "sword", clientId = 3264, buy = 85, sell = 20 },
{ itemName = "tarsal arrow", clientId = 14251, buy = 6 },
{ itemName = "throwing knife", clientId = 3298, buy = 25, sell = 1 },
{ itemName = "throwing star", clientId = 3287, buy = 42 },
{ itemName = "thunderstorm rune", clientId = 3202, buy = 47 },
{ itemName = "torch", clientId = 2920, buy = 2 },
{ itemName = "two handed sword", clientId = 3265, buy = 950, sell = 360 },
{ itemName = "ultimate healing rune", clientId = 3160, buy = 175 },
{ itemName = "ultimate health potion", clientId = 7643, buy = 398 },
{ itemName = "ultimate mana potion", clientId = 23373, buy = 535 },
{ itemName = "ultimate spirit potion", clientId = 23374, buy = 535 },
{ itemName = "vial", clientId = 2874, sell = 4 },
{ itemName = "viking helmet", clientId = 3367, buy = 265, sell = 52 },
{ itemName = "viking shield", clientId = 3431, buy = 260, sell = 68 },
{ itemName = "vortex bolt", clientId = 14252, buy = 6 },
{ itemName = "war hammer", clientId = 3279, buy = 10000, sell = 376 },
{ itemName = "warrior's axe", clientId = 14040, sell = 8800 },
{ itemName = "warrior's shield", clientId = 14042, sell = 7200 },
{ itemName = "waspoid claw", clientId = 14080, sell = 256 },
{ itemName = "waspoid wing", clientId = 14081, sell = 152 },
{ itemName = "watch", clientId = 2906, buy = 20, sell = 4 },
{ itemName = "wild growth rune", clientId = 3156, buy = 160 },
{ itemName = "wooden hammer", clientId = 3459, sell = 12 },
{ itemName = "wooden shield", clientId = 3412, buy = 15, sell = 4 },
{ itemName = "worm", clientId = 3492, buy = 1 }
}
-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType)
end

npcType:register(npcConfig)
