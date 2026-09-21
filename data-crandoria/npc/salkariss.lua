local internalNpcName = "Salkariss"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1539,
	lookHead = 0,
	lookBody = 98,
	lookLegs = 11,
	lookFeet = 63,
    	lookAddons = 0,
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

    if MsgContains(message, "missao") or MsgContains(message, "mission") then
        if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) <= 19 then
            npcHandler:say("Nao tenho nada a tratar com voce, jovem humano. Va cuidar dos assuntos pouco importantes dos demais.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 20 then
            npcHandler:say("Ah... nao vi que era voce. Voce quer falar com a Rainha? Muito bem. Basta me ajudar com a tarefa mais importante do Palacio: Obter alimentos. \z
            Desde o inicio da rebeliao o acesso aos alimentos esta muito dificil. Sera que voce pode ser melhor que nos para obter esses recursos? Eu duvido muito, mas vou pagar para ver. \z
            Se conseguir, traga para mim 5 Dragonfruits, 12 Pineapples, 50 Fresh Fruits e 25 Fire Mushrooms. Se nos ajudar com esses alimentos, te deixarei falar com a Rainha. Estarei esperando.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 21)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 21 then
            npcHandler:say("Precisamos de 5 Dragonfruits, 12 Pineapples, 50 Fresh Fruits e 25 Fire Mushrooms. Trouxe todos os itens com voce?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        end
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
        if npcHandler:getTopic(playerId) == 1 then
            if player:getItemCount(11682) >= 5 and player:getItemCount(11459) >= 12 and player:getItemCount(25692) >= 50 and player:getItemCount(3731) >= 25 then
                player:removeItem(11682, 5)
                player:removeItem(11459, 12)
                player:removeItem(25692, 50)
                player:removeItem(3731, 25)
                player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 22)
                npcHandler:say("Ha! Realmente, parece que os humanos prestam para alguma coisa afinal... Muito bem, como combinado, conversarei com os demais moradores do Palacio e diremos a Rainha que pode confiar em voce. \z
                Aqui, uma recompensa por voce ter ajudado a manter nossa alimentacao em dia. Boa sorte com sua jornada.", npc, creature)
                player:addItem(3043, 50)
                player:addItem(22706, 1)
                player:addExperience(player:getLevel() * 20000)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao esta com todos os itens que eu pedi. Qual o seu problema? Nao consegue entender? Eu disse que preciso de 5 DragonFruits, 12 Pineapples, 50 Fresh Fruits e 25 Fire Mushrooms.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    end

end


npcHandler:setMessage(MESSAGE_GREET, "Se nao tiver assuntos comigo, fique longe da minha cozinha.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
