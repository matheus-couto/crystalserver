local internalNpcName = "Visanis"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1537,
	lookHead = 84,
	lookBody = 6,
	lookLegs = 35,
	lookFeet = 35,
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

    if MsgContains(message, "missao") or MsgContains(message, "mission") or MsgContains(message, "acesso") then
        if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) < 1 then
            npcHandler:say("Um humano fraco com assuntos a tratar com as Nagas? Ha! Eu duvido muito... Eu sou Visanis, a protetora do Santuario. Se quiser acessar o local tera provar seu valor. \z
            Nao sera facil para voce, mas se passar por todos os testes podera encontrar com a propria Naga Queen. Esta pronto para essa missao?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 1 then
            if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.KillCount) > 99 then
                npcHandler:say("Otimo! Sua ajuda foi o suficiente para que pudessemos infiltrar um espiao entre os rebeldes. Estamos buscando por informacoes enquanto conversamos. Aqui, uma pequena recompensa. \z
                Enquanto investigamos, procure por Shiraks no posto de guarda. Voce podera encontrar o posto a leste daqui, passando pela ponte de madeira. Ele esta esperando por voce.", npc, creature)
                player:addExperience(player:getLevel() * 10000)
                player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.KillCount, 0)
                player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 2)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce ainda nao derrotou as 100 Rebel Nagas.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 1 then
            npcHandler:say("Shiraks esta te esperando no Posto de Guarda a leste daqui. Encontre-o, ele precisa de ajuda.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) > 1 and player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) < 13 then
            npcHandler:say("Voce ainda nao possui permissao para acessar o Palacio. Ajude o pessoal do Posto de Guarda primeiro.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 13 then
            npcHandler:say("De acordo com a Comandante Sivyna voce derrotou Grugarosh. Nao consigo esconder meu espanto! Nao imaginei que conseguiria passr por tal desafio. \z
            Sua passagem pelo Palacio esta concedida... SE... voce pagar o preco. Serao 10 Gold Tokens. Voce so precisa pagar uma unica vez. Esta com os Tokens?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        end
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
        if npcHandler:getTopic(playerId) == 1 then
            player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 1)
            player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.KillCount, 0)
            npcHandler:say("Muito bem! Primeiramente, voce precisara nos ajudar com a rebeliao que se instalou na area externa ao Palacio. Como pode ver, algumas das Nagas se rebelou contra a Rainha e estao cercando o local. \z
            Dessa forma, nao conseguimos sair para pegar suprimentos. Derrote ao menos 100 das Rebel Nagas, sozinho ou em grupo. As Nagas devem ser derrotadas na area em frente ao palacio, ou eu nao verei que voce as derrotou. Nao demore!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getItemCount(22721) >= 10 then
                player:removeItem(22721, 10)
                npcHandler:say("Bom, bom... A proxima parte de sua jornada comeca agora. Seu acesso ao Palacio esta permitido permanentemente. Aconselho falar com Zynaka ao entrar... Boa sorte!", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 14)
            else
                npcHandler:say("Esta tentando me passar para tras? Onde estao os Gold Tokens?", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    end

end


npcHandler:setMessage(MESSAGE_GREET, "Ola, humano. Certifique-se de possuir {acesso} antes de entrar na fortaleza das Nagas.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
