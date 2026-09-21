local internalNpcName = "Iggmor"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 1

npcConfig.outfit = {
	lookType = 251,
	lookHead = 0,
	lookBody = 62,
	lookLegs = 84,
	lookFeet = 26,
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


    if MsgContains(message, "mission") or MsgContains(message, "missao") then
        if player:getStorageValue(Storage.Quest.Crandoria.Viridia.SeaSerpentQuest) < 1 then
            if player:getLevel() < 20 then
                npcHandler:say("Eu possuo uma tarefa, mas voce ainda esta fraco para executa-la. Volte quando estiver no nivel 20.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Tenho uma missao importante que precisa ser executada. Ela levara algumas etapas, mas te garanto que voce conseguira boas recompensas no caminho. Esta interessado(a)? ( {sim} / {nao})", npc, creature)
                npcHandler:setTopic(playerId, 1)
            end
        elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.SeaSerpentQuest) == 1 then
            npcHandler:say("Voce trouxe a Mammoth Fur Cape?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.SeaSerpentQuest) == 2 then
            if player:getLevel() < 30 then
                npcHandler:say("Para sua proxima tarefa voce precisa evoluir um pouco. Retorne quando estiver no nivel 30.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Sua proxima missao sera um pouco mais dificil... Eu preciso de uma Ice Rapier. Essas armas nao possuem muita utilizade em batalha, mas sao otimos ornamentos nas Terras Frias. \z
                Traga-me uma Ice Rapier e te darei uma recompensa um pouco melhor que a ultima. Mas atencao! A arma deve estar impecavel, sem nenhum arranhao na lamina! Ficarei esperando!", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.SeaSerpentQuest, 3)
                npcHandler:setTopic(playerId, 0)
            end
        elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.SeaSerpentQuest) == 3 then
            npcHandler:say("Voce tem uma Ice Rapier com voce?", npc, creature)
            npcHandler:setTopic(playerId, 3)
        elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.SeaSerpentQuest) == 4 then
            if player:getLevel() < 40 then
                npcHandler:say("Para sua proxima tarefa voce precisa evoluir um pouco. Retorne quando estiver no nivel 40.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce esta mais forte, entao vamos partir para os assuntos serios: Preciso de alguem que possa me ajudar com meu trabalho. Mas antes preciso saber se voce realmente tera capacidade para isso. \z
                Por isso desejo testar sua forca. Para isso voce devera buscar por alguns itens obtidos das criaturas das Terras Frias. Traga-me 5 Ice Cubes, 1 Crystal Sword e 1 Shard. Traga todos os itens e te darei sua missao final.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.SeaSerpentQuest, 5)
                npcHandler:setTopic(playerId, 0)
            end
        elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.SeaSerpentQuest) == 5 then
            npcHandler:say("Como te disse antes, preciso de 5 Ice Cubes, 1 Crystal Sword e 1 Shard. Voce tem tudo com voce?", npc, creature)
            npcHandler:setTopic(playerId, 4)
        elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.SeaSerpentQuest) == 6 then
            if player:getLevel() < 50 then
                npcHandler:say("Para a ultima missao, voce precisara ser mais forte. Retorne quando estiver no nivel 50.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce parece ter o que precisa para me ajudar com meu trabalho. Eu cuido do covil das Sea Serpents. De modo geral, mantenho elas vivas e mato aquelas que causam muitos problemas. \z
                O problema maior esta sendo a falta de Glacier Amulets, dropados das proprias Sea Serpents. Esse amuleto me ajuda a resistir aos ataques de gelo dos monstros, entao realmente preciso deles. \z
                Sua missao sera simples e direta: Passe pela porta e entre no vortex abaixo para acessar o covil das Sea Serpents. Derrote-as e consiga pelo menos 2 Glacier Amulets para mim. Ficarei aguardando com sua recompensa!", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.SeaSerpentQuest, 7)
                npcHandler:setTopic(playerId, 0)
            end
        elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.SeaSerpentQuest) == 7 then
            npcHandler:say("Preciso de ao menos 2 Glacier Amulets. Voce possui os itens com voce?", npc, creature)
            npcHandler:setTopic(playerId, 5)
        elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.SeaSerpentQuest) == 8 then
            npcHandler:say("Nao tenho mais nenhuma missao para voce. Acesse o Covil das Sea Serpents sempre que quiser.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end

    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Muito bem! Preste atencao: os barbaros que vivem na regiao nordeste das Terras Frias possuem os melhores agasalhos feitos de pele de mamute. Primeiramente preciso que voce busque um deles para mim. \z
            Eles dao o nome a essa roupa de Mammoth Fur Cape. Ao conseguir uma basta retornar ate mim com o item. Te darei uma modesta recompensa e passaremos para a proxima etapa da missao. Espero por voce!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.Viridia.SeaSerpentQuest, 1)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getItemCount(7463) >= 1 then
                player:removeItem(7463, 1)
                player:addExperience(50000)
                player:addItem(3035, 20)
                npcHandler:say("Excelente! Essa capa me ajudara a enfrentar o frio e continuar meu trabalho. Aqui, uma modesta recompensa pela primeira tarefa.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.SeaSerpentQuest, 2)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("E onde esta o item?", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 3 then
            local chance = math.random(1, 5)
            if player:getItemCount(3284) >= 1 then
                if chance >= 3 then
                    player:removeItem(3284, 1)
                    player:addExperience(100000)
                    player:addItem(3035, 30)
                    player:addItem(3029, 10)
                    npcHandler:say("Sensacional! Ela esta em perfeito estado. Aqui, uma recompensa por ter completado a tarefa. Muito obrigado!", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.Viridia.SeaSerpentQuest, 4)
                    npcHandler:setTopic(playerId, 0)
                else
                    player:removeItem(3284, 1)
                    npcHandler:say("Ah.. Que pena. Essa arma estava danificada e se quebrou assim que segurei sua lamina. Infelizmente precisarei de outra.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                end
            else
                npcHandler:say("E onde esta o item?", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 4 then
            if player:getItemCount(7441) >= 5 and player:getItemCount(7449) >= 1 and player:getItemCount(7290) >= 1 then
                player:removeItem(7441, 5)
                player:removeItem(7449, 1)
                player:removeItem(7290, 1)
                player:addExperience(200000)
                player:addItem(3035, 50)
                npcHandler:say("Voce conseguiu! Bom, talvez seja realmente capaz de me ajudar com meu trabalho. Aqui, sua recompensa pela missao.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.SeaSerpentQuest, 6)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Sinto muito, mas voce nao trouxe todos os itens. Preciso de 5 ice cubes, 1 crystal sword e 1 shard. Nao se esqueca.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 5 then
            if player:getItemCount(815) >= 2 then
                player:removeItem(815, 2)
                player:addExperience(500000)
                player:addItem(3043, 1)
                npcHandler:say("Perfeito! Voce trouxe mesmo os amuletos. Aqui esta sua recompensa. E a partir de agora permito que voce acesse o covil das Sea Serpents sempre que quiser. Obrigado pela ajuda!", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.SeaSerpentQuest, 8)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Preciso de 2 Glacier Amulets novos para enfrentar as Sea Serpents.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) and npcHandler:getTopic(playerId) == 1 then
        npcHandler:say("Tudo bem...", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola, viajante. O que busca nessas terras frias?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
