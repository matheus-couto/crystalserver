local internalNpcName = "Lord Holtten"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2
npcConfig.walkRadius = 1

npcConfig.outfit = {
	lookType = 1436,
	lookHead = 0,
	lookBody = 58,
	lookLegs = 114,
	lookFeet = 57,
	lookAddons = 1,
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

    local monsterA = { 
        { name = "Gore Horn", id = 1, count = 200 },
        { name = "Emerald Tortoise", id = 2, count = 200 },
        { name = "Sulphider", id = 3, count = 200 },
        { name = "Sulphur Spouter", id = 4, count = 200 },
        { name = "Mantosaurus", id = 5, count = 200 },
        { name = "Rotten Golem", id = 6, count = 200 },
        { name = "Icecold Book", id = 7, count = 200 },
        { name = "Bony Sea Devil", id = 8, count = 50 },
        { name = "Infernal Phantom", id = 9, count = 50 },
        { name = "Juggernaut", id = 10, count = 50 },
        { name = "Lava Lurker", id = 11, count = 50 },
        { name = "Hellflayer", id = 12, count = 400 },
        { name = "Vexclaw", id = 13, count = 400 },
        { name = "Grimeleech", id = 14, count = 400 },
        { name = "Tremendous Tyrant", id = 15, count = 200 },
        { name = "Hellhound", id = 16, count = 50 },
        { name = "Knowledge Elemental", id = 17, count = 50 },
        { name = "Energuardian of Tales", id = 18, count = 50 },
        { name = "Squid Warden", id = 19, count = 200 },
        { name = "Energetic Book", id = 20, count = 200 },
        { name = "Turbulent Elemental", id = 21, count = 50 },
        { name = "Mercurial Menace", id = 22, count = 50 },
        { name = "Stalking Stalk", id = 23, count = 100 },
        { name = "Undead Dragon", id = 24, count = 200 },
        { name = "Burning Gladiator", id = 25, count = 400 },
        { name = "Ink Blob", id = 26, count = 100 },
        { name = "Cliff Strider", id = 27, count = 400 },
        { name = "Varnished Diremaw", id = 28, count = 200 },
        { name = "Falcon Knight", id = 29, count = 300 },
        { name = "Venerable Girtablilu", id = 30, count = 200 },
        { name = "Cobra Vizier", id = 31, count = 300 },
        { name = "Cobra Scout", id = 32, count = 300 },
        { name = "Sphinx", id = 33, count = 300 },
        { name = "True Dawnfire Asura", id = 34, count = 300 },
        { name = "Adult Goanna", id = 35, count = 200 },
        { name = "Bashmu", id = 36, count = 300 },
        { name = "Cave Chimera", id = 37, count = 200 },
        { name = "Poisonous Carnisylvan", id = 38, count = 200 },
        { name = "Undead Elite Gladiator", id = 39, count = 300 },
        { name = "Dark Carnisylvan", id = 40, count = 200 },
        { name = "Lion Warlock", id = 41, count = 200 },
        { name = "Dark Torturer", id = 42, count = 200 },
        { name = "Lion Archer", id = 43, count = 200 },
        { name = "Weeper", id = 44, count = 300 },
        { name = "Burster Spectre", id = 45, count = 200 },
        { name = "Guzzlemaw", id = 46, count = 500 },
        { name = "Lost Berserker", id = 47, count = 500 },
        { name = "Choking Fear", id = 48, count = 500 },
        { name = "Draken Warmaster", id = 49, count = 500 },
        { name = "Crazed Winter Rearguard", id = 50, count = 500 },
        { name = "Two-Headed Turtle", id = 51, count = 500 },
        { name = "Arachnophobica", id = 52, count = 300 },
        { name = "Magma Crawler", id = 53, count = 300 },
        { name = "Naga Archer", id = 54, count = 500 },
        { name = "Hideous Fungus", id = 55, count = 500 },
        { name = "Gazer Spectre", id = 56, count = 500 },
        { name = "Medusa", id = 57, count = 500 },
        { name = "Fury", id = 58, count = 500 },
        { name = "Behemoth", id = 59, count = 600 },
        { name = "Grim Reaper", id = 60, count = 600 },
        { name = "Ripper Spectre", id = 61, count = 500 },
        { name = "Infernalist", id = 62, count = 500 },
        { name = "Pirat Mate", id = 63, count = 600 },
        { name = "Midnight Asura", id = 64, count = 600 },
        { name = "Spiky Carnivor", id = 65, count = 750 },
        { name = "Glooth Bandit", id = 66, count = 750 },
        { name = "Lost Basher", id = 67, count = 750 },
        { name = "Hydra", id = 68, count = 1000 },
        { name = "Sea Serpent", id = 69, count = 1000 },
        { name = "Dragon Lord", id = 70, count = 1000 },
        { name = "Deepling Warrior", id = 71, count = 1000 },
        { name = "Wyrm", id = 72, count = 1000 },
        { name = "Frost Dragon", id = 73, count = 1000 },
        
    }

    local function getMonsterNameById(monsterA, id)
        for _, monster in ipairs(monsterA) do
            if monster.id == id then
                return monster.name
            end
        end
        return "Unknown"
    end

    local selectedMonsterA = monsterA[math.random(1, #monsterA)]

    local monsterNameA = selectedMonsterA.name
    local mTypeA = MonsterType(monsterNameA)
    local raceIdA = mTypeA:raceId()
    local monsteridA = selectedMonsterA.id
    local monsterCount = selectedMonsterA.count
    local bestiaryA = (player:getStorageValue(61305000 + raceIdA)) + 2
    local monsterNameAA = getMonsterNameById(monsterA, player:getStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraHunt))


    local storageTC = Game.getStorageValue(GlobalStorage.Crandoria.HolttenQuest.HolttenTC)
    local storageQuest = Game.getStorageValue(GlobalStorage.Crandoria.HolttenQuest.Quest)
    local storageDiaGlobal = Game.getStorageValue(GlobalStorage.Crandoria.HolttenQuest.Dia)
    local storageDia = player:getStorageValue(Storage.Quest.Crandoria.QuestHoltten.Dia)
    local storageCount = player:getStorageValue(Storage.Quest.Crandoria.QuestHoltten.Contagem)
    local storageTotalCount = player:getStorageValue(Storage.Quest.Crandoria.QuestHoltten.ContagemTotal)

    local now = os.date("*t")
	local day = now.day

    if MsgContains(message, "missao") or MsgContains(message, "mission") then
        -- if storageDiaGlobal ~= day then
        --     Game.setStorageValue(GlobalStorage.Crandoria.HolttenQuest.Dia, day)
        --     Game.setStorageValue(GlobalStorage.Crandoria.HolttenQuest.Quest, 0)
        -- end
        if storageTC < 1 then
            if storageDia ~= day then
                npcHandler:say("Se voce busca por fortuna, pode ser que voce a encontre. O guerreiro que finalizar a missao diaria primeiro e reportar a mim recebera o premio. \z
                Esta preparado para a missao de hoje?", npc, creature)
                npcHandler:setTopic(playerId, 1)
            else
                if storageCount >= storageTotalCount then
                    npcHandler:say("Velocidade ao matar. Esse sim pode ser um bom indicador de um poderoso guerreiro. Muito bem! Aqui esta sua recompensa.", npc, creature)
                    player:addTransferableCoins(5)
                    player:addExperience(3000000)
                    player:getPosition():sendMagicEffect(CONST_ME_BLUE_FIREWORKS)
                    setGlobalStorage(GlobalStorage.Crandoria.TibiaCoinsColeta.CoinsTotal, getGlobalStorage(GlobalStorage.Crandoria.TibiaCoinsColeta.CoinsTotal) + 5)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 5 Tibia Coins como recompensa da missao.")
                    player:setStorageValue(Storage.Quest.Crandoria.QuestHoltten.Contagem, 1)
                    player:setStorageValue(Storage.Quest.Crandoria.QuestHoltten.ContagemTotal, 0)
                    player:setStorageValue(Storage.Quest.Crandoria.QuestHoltten.Bestiary, 0)
                    player:setStorageValue(Storage.Quest.Crandoria.QuestHoltten.MonsterId, 0)
                    player:setStorageValue(Storage.Quest.Crandoria.QuestHoltten.MonsterRace, 0)
                    Game.setStorageValue(GlobalStorage.Crandoria.HolttenQuest.HolttenTC, 1)
                    Game.setStorageValue(GlobalStorage.Crandoria.HolttenQuest.Quest, 0)
                    local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                	player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
                	player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                    npcHandler:setTopic(playerId, 0)
                else
                    npcHandler:say("Voce ainda nao derrotou todos os monstros.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                end
            end
        else
            npcHandler:say("A missao do dia ja foi finalizada e entregue por outra pessoa. Tente novamente amanha.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            if storageQuest < 1 then
                player:setStorageValue(Storage.Quest.Crandoria.QuestHoltten.Contagem, 1)
                player:setStorageValue(Storage.Quest.Crandoria.QuestHoltten.Dia, day)
                player:setStorageValue(Storage.Quest.Crandoria.QuestHoltten.ContagemTotal, monsterCount)
                player:setStorageValue(Storage.Quest.Crandoria.QuestHoltten.Bestiary, bestiaryA)
                player:setStorageValue(Storage.Quest.Crandoria.QuestHoltten.MonsterId, monsteridA)
                player:setStorageValue(Storage.Quest.Crandoria.QuestHoltten.MonsterRace, raceIdA)
                npcHandler:say("O desafio do dia sera derrotar "..monsterCount.." " ..monsterNameA..". Quem finalizar e reportar primeiro a missao, levara 5 Tibia Coins. Boa sorte!", npc, creature)
                npcHandler:setTopic(playerId, 0)
                Game.setStorageValue(GlobalStorage.Crandoria.HolttenQuest.Quest, monsteridA)
                Game.setStorageValue(GlobalStorage.Crandoria.HolttenQuest.Dia, day)
            else
                local monsterIdToday = storageQuest  
                local monsterNameToday = getMonsterNameById(monsterA, monsterIdToday)
                local monsterCountToday = 0
                for _, monster in ipairs(monsterA) do
                    if monster.id == monsterIdToday then
                        monsterCountToday = monster.count
                        break
                    end
                end

                npcHandler:say("O desafio do dia sera derrotar " ..monsterCountToday.. " " ..monsterNameToday..". Quem finalizar e reportar primeiro a missao, levara 5 Tibia Coins. Boa sorte!", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.QuestHoltten.Contagem, 1)
                player:setStorageValue(Storage.Quest.Crandoria.QuestHoltten.Dia, day)
                local mTypeToday = MonsterType(monsterNameToday)
                if mTypeToday then
                    local raceIdToday = mTypeToday:raceId()
                    local bestiaryToday = player:getStorageValue(61305000 + raceIdToday) + 2

                    player:setStorageValue(Storage.Quest.Crandoria.QuestHoltten.Bestiary, bestiaryToday)
                    player:setStorageValue(Storage.Quest.Crandoria.QuestHoltten.MonsterRace, raceIdToday)
                else
                    print("Erro: MonsterType nao encontrado para " .. monsterNameToday)
                end
                player:setStorageValue(Storage.Quest.Crandoria.QuestHoltten.MonsterId, monsterIdToday)
                player:setStorageValue(Storage.Quest.Crandoria.QuestHoltten.ContagemTotal, monsterCountToday)
                npcHandler:setTopic(playerId, 0)
            end
            npcHandler:setTopic(playerId, 0)
        end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Se quiser receber Tibia Coins, veio ao local certo! Uma {missao} sera o preco e apenas um podera levar a recompensa!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("trade", "bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
