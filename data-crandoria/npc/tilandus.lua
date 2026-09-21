local internalNpcName = "Tilandus"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 151,
	lookHead = 0,
	lookBody = 95,
	lookLegs = 57,
	lookFeet = 69,
	lookAddons = 3,
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


local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end
    
    local storage = player:getStorageValue(Storage.Quest.Crandoria.VaroQuest.Progresso)

    if MsgContains(message, "mission") or MsgContains(message, "missao") or MsgContains(message, "missoes") then
        if storage == 12 then
            npcHandler:say("Entao Varo por alguma razao passou a confiar em voce, nao e mesmo? Aquele idiota tem o coracao muito mole... \z
            Escute, eu nao te darei missoes tao simples e faceis como as daquele insolente. Se quiser ganhar minha confianca tera que provar sua forca! \z
            Talvez, se conseguir finalizar meus desafios, voce goste das ofertas que estou disposto a fazer por seus itens. O que acha? Esta preparado?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        elseif storage == 13 then
            npcHandler:say("Conseguiu o Ornate Shield?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif storage == 14 then
            npcHandler:say("Nao sei se voce realmente derrotou Jaul para conseguir o escudo, mas de qualquer forma voce cumpriu a missao dada - e eu respeito isso. \z
            Sua proxima missao exigira um pouco mais de voce... Um guardiao chamado Elendor vive numa ilha ao norte de Astrali chamada de Ilha Perdida, ou Lost Island. \z
            O unico barco de acesso esta sendo guardado por Howard Rottberg, que vive nas montanhas. Voce devera levar um carregamento para Elendor. Ao chegar diga a ele 'carregamento' e ele sabera do que se trata. Aqui esta o item.", npc, creature)
            player:addItem(5884, 1)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 Spirit Container.")
            player:setStorageValue(Storage.Quest.Crandoria.VaroQuest.Progresso, 15)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 15 then
            npcHandler:say("Leve o Spirit Container para Elendor, na ilha ao norte de Astralis. O que esta esperando?", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 16 then
            npcHandler:say("Elendor me enviou uma ave com uma carta, avisando que recebeu a encomenda. Nao gosto disso, mas devo confessar que voce esta sendo de grande ajuda. \z
            Aqui, uma recompensa pela tarefa finalizada. Mais uma simples {missao} e eu te concederei o direito de negociar comigo. Me avise quando estiver pronto.", npc, creature)
            player:addExperience(5000000)
            player:addItem(20138, 1)
            player:setStorageValue(Storage.Quest.Crandoria.VaroQuest.Progresso, 17)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 17 then
            npcHandler:say("Um dos nossos clientes distantes esta buscando por um equipamento que so pode ser obtido aqui, nessas terras: O Demon Helmet! \z
            Apesar de nao ser muito valioso, eu nao possuo poder o suficiente para obter um sozinho, por isso preciso de ajuda.\z
            Enfim... Traga o Demon Helmet para mim e negociarei alguns itens com voce. Leve o tempo que quiser.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.VaroQuest.Progresso, 18)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 18 then
            npcHandler:say("Voce trouxe o Demon Helmet?", npc, creature)
            npcHandler:setTopic(playerId, 3)
        elseif storage == 19 then
            npcHandler:say("Nao tenho mais missoes para voce. Me avise se quiser negociar", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("HAA HAA! Otimo! Vou pegar leve com voce no inicio, porque nao quero que voce morra (ainda..). Preste bastante atencao:\z
            Uma criatura maldita afundou um de nossos barcos com todo o nosso carregamento. Nao apenas quero que voce o derrote, mas que traga para mim um de seus tesouros. \z
            A criatura em questao se chama Jaul e o tesouro que preciso se chama Ornate Shield. Simples assim. Traga o Ornate Shield e passara na primeira missao.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.VaroQuest.Progresso, 13)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getItemCount(14000) >= 1 then
                player:removeItem(14000, 1)
                player:addExperience(5000000)
                player:addItem(3043, 10)
                player:setStorageValue(Storage.Quest.Crandoria.VaroQuest.Progresso, 14)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 10 Crystal Coins.")
                npcHandler:say("HA! Parece que voce pode realmente ser util e de muita confianca. Mas nao se anime ainda. Tera mais {missoes} a cumprir se quiser mesmo negociar comigo. \z
                Aqui, uma pequena recompensa pela sua ajuda. Me avise quando estiver pronto para a proxima tarefa.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("E onde esta o escudo?", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 3 then
            if player:getItemCount(3387) >= 1 then
                player:removeItem(3387, 1)
                player:addExperience(7500000)
                player:addItem(3043, 10)
                player:setStorageValue(Storage.Quest.Crandoria.VaroQuest.Progresso, 19)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 10 Crystal Coins.")
                npcHandler:say("Hum... nao esta em condicoes tao ruins. Vou aceitar! Voce realmente demonstrou ser um recurso util para o mercado clandestino do Novo Continente.\z
                Caso queira negociar alguns equipamentos, estou disposto a comprar algumas coisas. Basta dizer!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("E onde esta o helmet?", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    end
end

local function onTradeRequest(npc, creature)
    local player = creature:getPlayer()
	if player:getStorageValue(Storage.Quest.Crandoria.VaroQuest.Progresso) < 19 then
		npcHandler:say('Sinto muito, jovem. Mas voce nao se mostrou digno de negociar comigo ainda.', npc, creature)
		return false
	end
    if (os.date("%A") ~= "Sunday") then
		npcHandler:say('Por motivos de seguranca, so negocio aos domingos. Retorne depois.', npc, creature)
		return false
	end

	return true
end

npcConfig.shop = {
	{ itemName = "demon trophy", clientId = 7393, sell = 44000 },
	{ itemName = "dragon lord trophy", clientId = 7399, sell = 11000 },
	{ itemName = "disgusting trophy", clientId = 10421, sell = 3300 },
	{ itemName = "werebadger trophy", clientId = 22101, sell = 9900 },
	{ itemName = "wereboar trophy", clientId = 22102, sell = 11000 },
	{ itemName = "werebear trophy", clientId = 22103, sell = 12100 },
	{ itemName = "werefox trophy", clientId = 27706, sell = 9900 },
	{ itemName = "werehyaena trophy", clientId = 34219, sell = 13200 },
	{ itemName = "fur armor", clientId = 22085, sell = 5500 },
	{ itemName = "abyss hammer", clientId = 7414, sell = 22000 },
	{ itemName = "amber staff", clientId = 7426, sell = 8800 },
	{ itemName = "assassin dagger", clientId = 7404, sell = 22000 },
	{ itemName = "beastslayer axe", clientId = 3344, sell = 1650 },
	{ itemName = "beetle necklace", clientId = 10457, sell = 1650 },
	{ itemName = "berserker", clientId = 7403, sell = 44000 },
	{ itemName = "blacksteel sword", clientId = 7406, sell = 6600 },
	{ itemName = "blessed sceptre", clientId = 7429, sell = 44000 },
	{ itemName = "bonelord helmet", clientId = 3408, sell = 8250 },
	{ itemName = "bright sword", clientId = 3295, sell = 6600 },
	{ itemName = "brutetamer's staff", clientId = 7379, sell = 1650 },
	{ itemName = "buckle", clientId = 17829, sell = 7700 },
	{ itemName = "castle shield", clientId = 3435, sell = 5500 },
	{ itemName = "chain bolter", clientId = 8022, sell = 44000 },
	{ itemName = "chaos mace", clientId = 7427, sell = 9900 },
	{ itemName = "cobra crown", clientId = 11674, sell = 55000 },
	-- { itemName = "coconut shoes", clientId = 9017, sell = 550 },
	{ itemName = "composite hornbow", clientId = 8027, sell = 27500 },
	{ itemName = "cranial basher", clientId = 7415, sell = 33000 },
	{ itemName = "crocodile boots", clientId = 3556, sell = 1100 },
	{ itemName = "crystal crossbow", clientId = 16163, sell = 38500 },
	{ itemName = "crystal mace", clientId = 3333, sell = 13200 },
	{ itemName = "crystal necklace", clientId = 3008, sell = 440 },
	{ itemName = "crystal sword", clientId = 7449, sell = 660 },
	{ itemName = "crystalline armor", clientId = 8050, sell = 17600 },
	{ itemName = "daramian waraxe", clientId = 3328, sell = 1100 },
	{ itemName = "death ring", clientId = 6299, sell = 1100 },
	{ itemName = "demon shield", clientId = 3420, sell = 33000 },
	{ itemName = "demonbone amulet", clientId = 3019, sell = 35200 },
	{ itemName = "demonrage sword", clientId = 7382, sell = 39600 },
	{ itemName = "devil helmet", clientId = 3356, sell = 1100 },
	{ itemName = "diamond sceptre", clientId = 7387, sell = 3300 },
	{ itemName = "divine plate", clientId = 8057, sell = 55000 },
	{ itemName = "djinn blade", clientId = 3339, sell = 16500 },
	{ itemName = "dragon scale mail", clientId = 3386, sell = 44000 },
	{ itemName = "dragon slayer", clientId = 7402, sell = 16500 },
	{ itemName = "dragonbone staff", clientId = 7430, sell = 3300 },
	{ itemName = "dwarven armor", clientId = 3397, sell = 33000 },
	{ itemName = "elvish bow", clientId = 7438, sell = 2200 },
	{ itemName = "epee", clientId = 3326, sell = 8800 },
	{ itemName = "flower dress", clientId = 9015, sell = 1100 },
	{ itemName = "fur boots", clientId = 7457, sell = 2200 },
	{ itemName = "furry club", clientId = 7432, sell = 1100 },
	{ itemName = "glacier amulet", clientId = 815, sell = 1650 },
	{ itemName = "glacier kilt", clientId = 823, sell = 12100 },
	{ itemName = "glacier mask", clientId = 829, sell = 2750 },
	{ itemName = "glacier robe", clientId = 824, sell = 12100 },
	{ itemName = "glacier shoes", clientId = 819, sell = 2750 },
	{ itemName = "gold ring", clientId = 3063, sell = 8800 },
	{ itemName = "golden armor", clientId = 3360, sell = 22000 },
	{ itemName = "golden legs", clientId = 3364, sell = 33000 },
	{ itemName = "goo shell", clientId = 19372, sell = 4400 },
	{ itemName = "griffin shield", clientId = 3433, sell = 3300 },
	{ itemName = "guardian halberd", clientId = 3315, sell = 12100 },
	{ itemName = "hammer of wrath", clientId = 3332, sell = 33000 },
	{ itemName = "headchopper", clientId = 7380, sell = 6600 },
	{ itemName = "heavy mace", clientId = 3340, sell = 55000 },
	{ itemName = "heavy trident", clientId = 12683, sell = 2200 },
	{ itemName = "helmet of the lost", clientId = 17852, sell = 2200 },
	{ itemName = "heroic axe", clientId = 7389, sell = 33000 },
	{ itemName = "hibiscus dress", clientId = 8045, sell = 3300 },
	{ itemName = "jade hammer", clientId = 7422, sell = 27500 },
	{ itemName = "lavos armor", clientId = 8049, sell = 17600 },
	{ itemName = "leopard armor", clientId = 3404, sell = 1100 },
	{ itemName = "leviathan's amulet", clientId = 9303, sell = 3300 },
	{ itemName = "lightning boots", clientId = 820, sell = 2750 },
	{ itemName = "lightning headband", clientId = 828, sell = 2750 },
	{ itemName = "lightning legs", clientId = 822, sell = 12100 },
	{ itemName = "lightning pendant", clientId = 816, sell = 1650 },
	{ itemName = "lightning robe", clientId = 825, sell = 12100 },
	{ itemName = "lunar staff", clientId = 7424, sell = 5500 },
	{ itemName = "magic plate armor", clientId = 3366, sell = 99000 },
	{ itemName = "magma amulet", clientId = 817, sell = 1650 },
	{ itemName = "magma boots", clientId = 818, sell = 2750 },
	{ itemName = "magma coat", clientId = 826, sell = 12100 },
	{ itemName = "magma legs", clientId = 821, sell = 12100 },
	{ itemName = "magma monocle", clientId = 827, sell = 2750 },
	{ itemName = "mammoth fur cape", clientId = 7463, sell = 6600 },
	{ itemName = "mammoth fur shorts", clientId = 7464, sell = 935 },
	{ itemName = "mastermind shield", clientId = 3414, sell = 55000 },
	{ itemName = "medusa shield", clientId = 3436, sell = 9900 },
	{ itemName = "mercenary sword", clientId = 7386, sell = 13200 },
	{ itemName = "model ship", clientId = 2994, sell = 1100 },
	{ itemName = "mycological bow", clientId = 16164, sell = 38500 },
	{ itemName = "mystic blade", clientId = 7384, sell = 33000 },
	{ itemName = "naginata", clientId = 3314, sell = 2200 },
	{ itemName = "nightmare blade", clientId = 7418, sell = 38500 },
	{ itemName = "noble axe", clientId = 7456, sell = 11000 },
	{ itemName = "norse shield", clientId = 7460, sell = 1650 },
	{ itemName = "onyx pendant", clientId = 22195, sell = 3850 },
	{ itemName = "orcish maul", clientId = 7392, sell = 6600 },
	{ itemName = "oriental shoes", clientId = 21981, sell = 16500 },
	{ itemName = "pair of iron fists", clientId = 17828, sell = 4400 },
	{ itemName = "paladin armor", clientId = 8063, sell = 16500 },
	{ itemName = "pharaoh banner", clientId = 12483, sell = 1100 },
	{ itemName = "pharaoh sword", clientId = 3334, sell = 25300 },
	{ itemName = "pirate boots", clientId = 5461, sell = 3300 },
	{ itemName = "pirate hat", clientId = 6096, sell = 1100 },
	{ itemName = "platinum amulet", clientId = 3055, sell = 2750 },
	{ itemName = "relic sword", clientId = 7383, sell = 27500 },
	{ itemName = "rift bow", clientId = 22866, sell = 49500 },
	{ itemName = "rift crossbow", clientId = 22867, sell = 49500 },
	{ itemName = "rift lance", clientId = 22727, sell = 33000 },
	{ itemName = "rift shield", clientId = 22726, sell = 55000 },
	{ itemName = "ring of the sky", clientId = 3006, sell = 33000 },
	{ itemName = "royal axe", clientId = 7434, sell = 44000 },
	{ itemName = "ruby necklace", clientId = 3016, sell = 2200 },
	{ itemName = "ruthless axe", clientId = 6553, sell = 49500 },
	{ itemName = "sacred tree amulet", clientId = 9302, sell = 3300 },
	{ itemName = "sapphire hammer", clientId = 7437, sell = 7700 },
	{ itemName = "scarab shield", clientId = 3440, sell = 2200 },
	{ itemName = "shockwave amulet", clientId = 9304, sell = 3300 },
	{ itemName = "skull helmet", clientId = 5741, sell = 44000 },
	{ itemName = "skullcracker armor", clientId = 8061, sell = 19800 },
	{ itemName = "spiked squelcher", clientId = 7452, sell = 5500 },
	{ itemName = "steel boots", clientId = 3554, sell = 33000 },
	{ itemName = "swamplair armor", clientId = 8052, sell = 17600 },
	{ itemName = "taurus mace", clientId = 7425, sell = 550 },
	{ itemName = "tempest shield", clientId = 3442, sell = 38500 },
	{ itemName = "terra amulet", clientId = 814, sell = 1650 },
	{ itemName = "terra boots", clientId = 813, sell = 2750 },
	{ itemName = "terra hood", clientId = 830, sell = 2750 },
	{ itemName = "terra legs", clientId = 812, sell = 12100 },
	{ itemName = "terra mantle", clientId = 811, sell = 12100 },
	{ itemName = "the justice seeker", clientId = 7390, sell = 44000 },
	{ itemName = "vile axe", clientId = 7388, sell = 33000 },
	{ itemName = "war axe", clientId = 3342, sell = 13200 },
	{ itemName = "war horn", clientId = 2958, sell = 8800 },
	{ itemName = "witch hat", clientId = 9653, sell = 5500 },
	{ itemName = "wyvern fang", clientId = 7408, sell = 1650 },
	{ itemName = "batwing hat", clientId = 9103, sell = 8800 },
	{ itemName = "focus cape", clientId = 8043, sell = 6600 },
	{ itemName = "jade hat", clientId = 10451, sell = 9900 },
	{ itemName = "magicians robe", clientId = 7991, buy = 495 },
	{ itemName = "spellweavers rob", clientId = 10438, sell = 13200 },
	{ itemName = "zaoan robe", clientId = 10439, sell = 13200 },
	{ itemName = "angelic axe", clientId = 7436, sell = 5500 },
	{ itemName = "blue robe", clientId = 3567, sell = 11000 },
	{ itemName = "bonelord shield", clientId = 3418, sell = 1320 },
	{ itemName = "boots of haste", clientId = 3079, sell = 33000 },
	{ itemName = "broadsword", clientId = 3301, sell = 550 },
	{ itemName = "butcher's axe", clientId = 7412, sell = 19800 },
	{ itemName = "crown armor", clientId = 3381, sell = 13200 },
	{ itemName = "crown helmet", clientId = 3385, sell = 2750 },
	{ itemName = "crown legs", clientId = 3382, sell = 13200 },
	{ itemName = "crown shield", clientId = 3419, sell = 8800 },
	{ itemName = "crusader helmet", clientId = 3391, sell = 6600 },
	{ itemName = "dragon lance", clientId = 3302, sell = 9900 },
	{ itemName = "dragon shield", clientId = 3416, sell = 4400 },
	{ itemName = "fire axe", clientId = 3320, sell = 8800 },
	{ itemName = "fire sword", clientId = 3280, sell = 4400 },
	{ itemName = "glorious axe", clientId = 7454, sell = 3300 },
	{ itemName = "guardian shield", clientId = 3415, sell = 2200 },
	{ itemName = "ice rapier", clientId = 3284, sell = 1100 },
	{ itemName = "noble armor", clientId = 3380, sell = 990 },
	{ itemName = "obsidian lance", clientId = 3313, sell = 550 },
	{ itemName = "phoenix shield", clientId = 3439, sell = 17600 },
	{ itemName = "queen's sceptre", clientId = 7410, sell = 22000 },
	{ itemName = "royal helmet", clientId = 3392, sell = 33000 },
	{ itemName = "shadow sceptre", clientId = 7451, sell = 11000 },
	{ itemName = "spike sword", clientId = 3271, sell = 1100 },
	{ itemName = "thaian sword", clientId = 7391, sell = 17600 },
	{ itemName = "war hammer", clientId = 3279, sell = 1320 },
	{ itemName = "collar of blue plasma", clientId = 23542, sell = 6600 },
	{ itemName = "collar of green plasma", clientId = 23543, sell = 6600 },
	{ itemName = "collar of red plasma", clientId = 23544, sell = 6600 },
	{ itemName = "ring of blue plasma", clientId = 23529, sell = 8800 },
	{ itemName = "ring of green plasma", clientId = 23531, sell = 8800 },
	{ itemName = "ring of red plasma", clientId = 23533, sell = 8800 },
	{ itemName = "ancient shield", clientId = 3432, sell = 990 },
	{ itemName = "black shield", clientId = 3429, sell = 880 },
	{ itemName = "bonebreaker", clientId = 7428, sell = 11000 },
	{ itemName = "dark armor", clientId = 3383, sell = 440 },
	{ itemName = "dragon hammer", clientId = 3322, sell = 2200 },
	{ itemName = "dreaded cleaver", clientId = 7419, sell = 16500 },
	{ itemName = "giant sword", clientId = 3281, sell = 18700 },
	{ itemName = "haunted blade", clientId = 7407, sell = 8800 },
	{ itemName = "ice rapier", clientId = 3284, buy = 5500 },
	{ itemName = "knight armor", clientId = 3370, sell = 5500 },
	{ itemName = "knight axe", clientId = 3318, sell = 2200 },
	{ itemName = "knight legs", clientId = 3371, sell = 5500 },
	{ itemName = "onyx flail", clientId = 7421, sell = 24200 },
	{ itemName = "ornamented axe", clientId = 7411, sell = 22000 },
	{ itemName = "serpent sword", clientId = 3297, sell = 990 },
	{ itemName = "skull staff", clientId = 3324, sell = 6600 },
	{ itemName = "strange helmet", clientId = 3373, sell = 550 },
	{ itemName = "titan axe", clientId = 7413, sell = 4400 },
	{ itemName = "tower shield", clientId = 3428, sell = 8800 },
	{ itemName = "vampire shield", clientId = 3434, sell = 16500 },
	{ itemName = "warrior helmet", clientId = 3369, sell = 5500 },
	{ itemName = "halberd", clientId = 3269, sell = 440 },
	{ itemName = "plate armor", clientId = 3357, sell = 440 },
	{ itemName = "two handed sword", clientId = 3265, sell = 495 },
	{ itemName = "twin hooks", clientId = 10392, buy = 1210 },
	{ itemName = "zaoan halberd", clientId = 10406, buy = 1320 },
	{itemName = "twin hooks", clientId = 10392, sell = 550 },
	{itemName = "zaoan halberd", clientId = 10406, sell = 550 },
	{itemName = "wailing widow's necklace", clientId = 10412, sell = 3300 },
	{itemName = "zaoan shoes", clientId = 10386, sell = 5500 },
	{itemName = "drachaku", clientId = 10391, sell = 11000 },
	{itemName = "drakinata", clientId = 10388, sell = 11000 },
	{itemName = "zaoan armor", clientId = 10384, sell = 15400 },
	{itemName = "zaoan legs", clientId = 10387, sell = 15400 },
	{itemName = "sai", clientId = 10389, sell = 18150 },
	{itemName = "twiceslicer", clientId = 11657, sell = 30800 },
	{itemName = "zaoan sword", clientId = 10390, sell = 33000 },
	{itemName = "guardian boots", clientId = 10323, sell = 38500 },
	{itemName = "draken boots", clientId = 4033, sell = 44000 },
	{itemName = "zaoan helmet", clientId = 10385, sell = 49500 },
	{itemName = "Elite Draken Mail", clientId = 11651, sell = 55000 },
	{ itemName = "calopteryx cape", clientId = 14086, sell = 16500 },
	{ itemName = "carapace shield", clientId = 14088, sell = 35200 },
	{ itemName = "deepling axe", clientId = 13991, sell = 44000 },
	{ itemName = "deepling squelcher", clientId = 14250, sell = 7700 },
	{ itemName = "deepling staff", clientId = 13987, sell = 4400 },
	{ itemName = "depth calcei", clientId = 13997, sell = 27500 },
	{ itemName = "depth galea", clientId = 13995, sell = 38500 },
	{ itemName = "depth lorica", clientId = 13994, sell = 33000 },
	{ itemName = "depth ocrea", clientId = 13996, sell = 17600 },
	{ itemName = "depth scutum", clientId = 13998, sell = 39600 },
	{ itemName = "grasshopper legs", clientId = 14087, sell = 16500 },
	{ itemName = "guardian axe", clientId = 14043, sell = 9900 },
	{ itemName = "hive bow", clientId = 14246, sell = 30800 },
	{ itemName = "hive scythe", clientId = 14089, sell = 18700 },
	{ itemName = "ornate chestplate", clientId = 13993, sell = 66000 },
	{ itemName = "ornate crossbow", clientId = 14247, sell = 13200 },
	{ itemName = "ornate legs", clientId = 13999, sell = 44000 },
	{ itemName = "ornate mace", clientId = 14001, sell = 46200 },
	{ itemName = "ornate shield", clientId = 14000, sell = 46200 },
	{ itemName = "plate armor", clientId = 3357, buy = 1200, sell = 440 },
	{ itemName = "two handed sword", clientId = 3265, buy = 950, sell = 495 },
	{ itemName = "warrior's axe", clientId = 14040, sell = 12100 },
	{ itemName = "warrior's shield", clientId = 14042, sell = 9900 },
}

npcHandler:setCallback(CALLBACK_ON_TRADE_REQUEST, onTradeRequest)

npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. Comigo seus itens podem ter mais valor...")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("trade", "bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
