local internalNpcName = "Bartran"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 160,
	lookHead = 112,
	lookBody = 59,
	lookLegs = 81,
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

    if MsgContains(message, "mina") or MsgContains(message, "mine") then
        npcHandler:say("Por 1 Gold Token voce podera acessar nossa mina por 24 horas. Se quiser acessar por 7 dias, pode pagar 5 Gold Tokens. Na mina voce devera se posicionar em uma das plataformas, levar sua crystal pickaxe e deixar que nossos Ancient Dwarfs facam seu trabalho. \z
        Eles absorverao suas habilidades e sabedoria para obter metais preciosos dos cristais 'cultivados' de forma minuciosa por esses grandes mestres. Gostaria de acessar a mina por {um dia} por 1 gold token ou por {uma semana} por 5 gold tokens?", npc, creature)
        npcHandler:setTopic(playerId, 1)
    -- elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
    --     if npcHandler:getTopic(playerId) == 1 then
    --         if player:getStorageValue(Storage.Quest.Crandoria.ForgeSystem.AutoMining) > os.time() then
    --             npcHandler:say("Sua ultima permissao ainda esta ativa. Volte quando o tempo acabar se quiser renovar seu acesso.", npc, creature)
    --             npcHandler:setTopic(playerId, 0)
    --         else
    --             if player:getItemCount(22721) >= 1 then
    --                 npcHandler:say("Excelente! Sua permissao esta garantida, jovem. Acesse as minas e aproveite a sabedoria dos anciaos.", npc, creature)
    --                 player:removeItem(22721, 1)
    --                 player:setStorageValue(Storage.Quest.Crandoria.ForgeSystem.AutoMining, os.time() + 24 * 60 * 60)
    --                 npcHandler:setTopic(playerId, 0)
    --             else
    --                 npcHandler:say("E onde esta seu Gold Token? Volte quando possuir um e te darei acesso ao local.", npc, creature)
    --                 npcHandler:setTopic(playerId, 0)
    --             end
    --         end
    --     end
    elseif MsgContains(message, "dia") then
        if npcHandler:getTopic(playerId) == 1 then
            if player:getStorageValue(Storage.Quest.Crandoria.ForgeSystem.AutoMining) > os.time() then
                npcHandler:say("Sua ultima permissao ainda esta ativa. Volte quando o tempo acabar se quiser renovar seu acesso.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                if player:getItemCount(22721) >= 1 then
                    npcHandler:say("Excelente! Sua permissao esta garantida, jovem. Acesse as minas e aproveite a sabedoria dos anciaos.", npc, creature)
                    player:removeItem(22721, 1)
                    player:setStorageValue(Storage.Quest.Crandoria.ForgeSystem.AutoMining, os.time() + 24 * 60 * 60)
                    npcHandler:setTopic(playerId, 0)
                else
                    npcHandler:say("E onde esta seu Gold Token? Volte quando possuir um e te darei acesso ao local.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                end
            end
        end
    elseif MsgContains(message, "semana") then
        if npcHandler:getTopic(playerId) == 1 then
            if player:getStorageValue(Storage.Quest.Crandoria.ForgeSystem.AutoMining) > os.time() then
                npcHandler:say("Sua ultima permissao ainda esta ativa. Volte quando o tempo acabar se quiser renovar seu acesso.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                if player:getItemCount(22721) >= 5 then
                    npcHandler:say("Excelente! Sua permissao esta garantida, jovem. Acesse as minas e aproveite a sabedoria dos anciaos.", npc, creature)
                    player:removeItem(22721, 5)
                    player:setStorageValue(Storage.Quest.Crandoria.ForgeSystem.AutoMining, os.time() + 7 * 24 * 60 * 60)
                    npcHandler:setTopic(playerId, 0)
                else
                    npcHandler:say("E onde esta seu Gold Token? Volte quando possuir um e te darei acesso ao local.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                end
            end
        end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) and npcHandler:getTopic(playerId) == 1 then
        npcHandler:say("Tudo bem.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Saudacoes, |PLAYERNAME|. Que tal obter recursos preciosos em nossa {mina} ajudando nossos arduos trabalhadores?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
