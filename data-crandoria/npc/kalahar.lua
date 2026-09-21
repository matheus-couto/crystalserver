local internalNpcName = "Kalahar"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 1069,
	lookHead = 0,
	lookBody = 68,
	lookLegs = 57,
	lookFeet = 59,
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

--     local monsterMappingA = {
--         [1] = "Dwarf",
--         [2] = "Rotworm",
--         [3] = "Minotaur",
--         [4] = "Orc",
--     }
    
--     local monsterMappingB = {
--         [1] = "Cyclops",
--         [2] = "Elf Scout",
--         [3] = "Tarantula",
--         [4] = "Stone Golem",
--     }

--     local monsterMappingC = {
--         [1] = "Dragon",
--     }
    
    
    
--     local monsterA = { 
--         { name = "Dwarf", id = 1 },
--         { name = "Rotworm", id = 2 },
--         { name = "Minotaur", id = 3 },
--         { name = "Orc", id = 4 },
--     }
    
--     local monsterB = {
--         { name = "Cyclops", id = 1 },
--         { name = "Elf Scout", id = 2 },
--         { name = "Tarantula", id = 3 },
--     }

--     local monsterC = {
--         { name = "Dragon", id = 1 },
--     }
    
    
--     local function getMonsterNameByIdA(monsterA, id)
--         for _, monster in ipairs(monsterA) do
--             if monster.id == id then
--                 return monster.name
--             end
--         end
--         return "Unknown"
--     end
    
--     local function getMonsterNameByIdB(monsterB, id)
--         for _, monster in ipairs(monsterB) do
--             if monster.id == id then
--                 return monster.name
--             end
--         end
--         return "Unknown"
--     end

--     local function getMonsterNameByIdC(monsterC, id)
--         for _, monster in ipairs(monsterB) do
--             if monster.id == id then
--                 return monster.name
--             end
--         end
--         return "Unknown"
--     end
    
--     local selectedMonsterA = monsterA[math.random(1, #monsterA)]
    
--     local monsterNameA = selectedMonsterA.name
--     local mTypeA = MonsterType(monsterNameA)
--     local raceIdA = mTypeA:raceId()
--     local monsteridA = selectedMonsterA.id
--     local bestiaryA = (player:getStorageValue(61305000 + raceIdA)) + 2
--     local monsterNameAA = getMonsterNameByIdA(monsterA, player:getStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraHunt))
    
    
--     local selectedMonsterB = monsterB[math.random(1, #monsterB)]
    
--     local monsterNameB = selectedMonsterB.name
--     local mTypeB = MonsterType(monsterNameB)
--     local raceIdB = mTypeB:raceId()
--     local monsteridB = selectedMonsterB.id
--     local bestiaryB = (player:getStorageValue(61305000 + raceIdB)) + 2
--     local monsterNameBB = getMonsterNameByIdB(monsterB, player:getStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraHunt))

--     local selectedMonsterC = monsterB[math.random(1, #monsterB)]
    
--     local monsterNameC = selectedMonsterC.name
--     local mTypeC = MonsterType(monsterNameC)
--     local raceIdC = mTypeB:raceId()
--     local monsteridC = selectedMonsterC.id
--     local bestiaryC = (player:getStorageValue(61305000 + raceIdC)) + 2
--     local monsterNameCC = getMonsterNameByIdB(monsterC, player:getStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraHunt))
    
    local storage = player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso)

    if MsgContains(message, "mission") or MsgContains(message, "missao") then
        if storage == 175 then
            if player:getStorageValue(Storage.Quest.Crandoria.WorldTeleports.Access) < 1 then
                npcHandler:say("E quem seria voce? Escute, jovem... Eu nao me importo se voce foi mandado pelo Comandante Crassus ou pelo proprio Rei Tibianus. \z
                Eu nao guiarei nenhum ze ninguem pelas minhas missoes. Entre para a Sociedade dos Magos e talvez eu reconsidere...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Nao se afobe, |PLAYERNAME|... Entao Crassus enviou voce, certo? Aquele miseravel... Ele me deve boas horas de aventuras, voce sabia? Mas esta sempre enrolando para treinar novos recrutas como voce... \z
                Mas eu entendo, sao tempos dificeis. Estou buscando apenas os melhores e mais fortes para finalizarem algumas missoes importantes pelo bem de Crandoria e do Novo Continente. \z
                Para comecar, estou criando uma incursao para a Secret Library. Terriveis monstros estao se fortalecendo la dentro e precisamos de ajuda para derrota-los. Voce acha que tem o necessario para esse desafio?", npc, creature)
                npcHandler:setTopic(playerId, 1)
            end
        elseif storage == 176 then
            npcHandler:say("Va ate a Secret Library, no sudeste de Crandoria, e encontra algum documento que nos explique como derrotar o Scourge of Oblivion.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 177 then
            npcHandler:say("Otimo! Voce encontrou algo mesmo? Deixe-me ver... Hmm.. Hmm... Como eu suspeitava... Voce tera que derrotar os terriveis demonios que protegem o terrivel monstro. Todos os quatro estao em locais diferentes da Biblioteca. \z
            Ha quatro deles: Gholush, Gorzindrel, Lokathmor e Mazzinor. Ao derrotar os quatro voce obtera acesso aos aposentos do grande monstro que se esconde na Biblioteca Secreta. \z
            Derrote todos eles e, em seguida, derrote o Scourge of Oblivion. Ele pode ser mais forte do que imaginamos, portanto tome cuidado e leve um bom time com voce! Boa sorte.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 178)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 178 then
            npcHandler:say("Por favor, derrote o Scourge of Oblivion e controle seu poder.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 179 then
            npcHandler:say("Voce derrotou mesmo aquele monstro terrivel? Talvez voce seja mais poderoso do que eu imaginava, |PLAYERNAME|. Aqui, tome essa recompensa pela sua grande ajuda! Procure-me novamente e te entregarei uma nova {missao}.", npc, creature)
            player:addExperience(2500000 * (player:getLevel() / 100))
            player:addItem(20138, 1)
            player:addItem(36726, 1)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 180)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 180 then
            npcHandler:say("Voce parece gostar de correr risco de vida... He he he. Mas nao se engane! Se voce quer mesmo seguir com os desafios, nao ha problema para mim. \z
            Que tal resolver um problema um pouco mais complicado? No interior de Gnomprona ha monstros terriveis. Entre eles os Mantosaurus. \z
            Preciso que voce derrote alguns deles e me traga 20 Mantosaurus Jaws. Com elas eu farei um feitico para que voce utilize na segunda parte da missao. Nao demore, estarei te esperando!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 181)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 181 then
            npcHandler:say("Voce trouxe as 20 Mantosaurus Jaws?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif storage == 182 then
            npcHandler:say("Derrote a terrivel Magma Bubble e retorne ate mim.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 183 then
            npcHandler:say("Eu nao acredito! Voce derrotou mesmo aquela terrivel criatura? Com certeza levou um bom time para te ajudar. Muito bem, nao importa. O importante sempre sera garantir a seguranca do Novo Continente. \z
            Aqui, como combinado, sua recompensa. Tenho uma nova {missao} para voce, me avise quando estiver pronto.", npc, creature)
            player:addExperience(2800000 * (player:getLevel() / 100))
            player:addItem(20139, 1)
            player:addItem(14112, 3)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 184)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 184 then
            npcHandler:say("Bem, |PLAYERNAME|... A Sociedade dos Magos agora tem um pedido de extrema importancia para fazer pra voce. Nao sera uma tarefa facil, entao preste atencao: \z
            Ao sul  \z
            Ela esta localizada em algum lugar em Gnomprona. Encontre seu esconderijo e derrote-a! Retorne vitorioso e te darei uma boa recompensa.", npc, creature)
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Mesmo? Bom, veremos... Ha ha ha! A entrada para a Secret Library fica a sudeste de Crandoria, em uma fortaleza abandonada. La dentro ha diversos monstros que sao comandados por bosses poderosos. \z
            Sua primeira missao sera encontrar algum documento na biblioteca que traga informacoes sobre como chegar ao boss final, The Scourge of Oblivion. Apos encontrar o documento, retorne ate mim.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 176)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getItemCount(39386) >= 20 then
                player:removeItem(39386, 20)
                npcHandler:say("Excelente! Voce foi veloz. Muito bem, deixe-me misturar algumas coisas... Aqui... E um pouco disso... Pronto! Um.. dois... tres... <poff> \z
                Perfeito. Acabei de te lancar um encantamento. Sua proxima missao sera derrotar a terrivel Magma Bubble enquanto carrega esse encantamento. Ao fazer isso, voce nos ajudara a controlar seu poder \z
                Ela esta localizada em algum lugar em Gnomprona. Encontre seu esconderijo e derrote-a! Retorne vitorioso e te darei uma boa recompensa.", npc, creature)
                player:getPosition():sendMagicEffect(CONST_ME_GREENSMOKE)
                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 182)
            else
                npcHandler:say("Estao faltando alguns itens...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. Guerreiros do Novo Continente tem que estar sempre prontos para a proxima {missao}!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais e boa sorte!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
