local internalNpcName = "Kradok"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 160,
	lookHead = 0,
	lookBody = 114,
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

    if MsgContains(message, "forja") or MsgContains(message, "dwarven armor") then
        if player:getStorageValue(Storage.Quest.Crandoria.ForgeSystem.Door) == 2 then
            npcHandler:say("Minha forja especial pode ser usada para aprimorar armas Eldritch e Sanguine. Voce pode usa-la quando quiser, mas antes precisara me trazer uma {Dwarven Armor}.", npc, creature)
        elseif player:getStorageValue(Storage.Quest.Crandoria.ForgeSystem.Door) == 1 then
            npcHandler:say("Eu te disse, jovem. Voce podera passar apos me entregar uma Dwarven Armor. Voce tem uma com voce?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        elseif player:getStorageValue(Storage.Quest.Crandoria.ForgeSystem.Door) < 1 then
            npcHandler:say("Ah! Entao voce quer usar a minha forja? Eu posso te deixar acessar a sala da forja sempre que quiser, mas para isso voce tera que me trazer uma Dwarven Armor. Volte quando tiver coneguido uma delas.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.ForgeSystem.Door, 1)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "mission") or MsgContains(message, "missao") then
        if player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 71 then
            npcHandler:say("Ah.. entao foi Crassus quem te mandou. Eu nao gosto daquele sujeito! Sempre se metendo na vida dos outros... Escute, nao tem nada demais para voce fazer aqui. Eu preciso de alguns recursos da mina, é só isso. \z
            Minha forja nao trabalha ha dias por falta de fragmentos de vidro das minas. Voce acha que gostaria de me ajudar com isso?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 72 then
            if player:removeItem(29345, 2) and player:removeItem(29346, 2) and player:removeItem(29347, 2) then
                npcHandler:say("Explendido! Vou correndo para a forja agora mesmo. Obrigado por isso, |PLAYERNAME|. Avise ao Comandante Crassus que estou muito feliz com o servico enviado. Desca as minas abaixo da montanha e procure por Guudatok. Ele precisa da sua ajuda!", npc, creature)
                player:addExperience(5000000, true)
                player:addItem(22724, 20, true)
                player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 73)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Eu preciso de 2 Blue Glass Plates, 2 Green Glass Plates e 2 Violet Glass Plates. Traga-os para mim e direi a Crassus que sua missao foi um sucesso.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "ferramenta") or MsgContains(message, "tool") then
        if player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.PlantasSelvagens) == 2 then
            npcHandler:say("Osric te colocou para trabalhar, nao foi? Ha! Aquele maldito... Ele nao te enviou atoa, me deve um bom dinheiro pelas ultimas ferramentas... \z
            Talvez voce possa pagar a divida de Osric me fazendo um favor. Deixe os 3 Huge Chuk of Crude Iron comigo e trabalharei nas ferramentas. Mas preste atenaco: \z
            Quando voce vier buscar as ferramentas, traga para mim 1 Dragon Scale Mail. Isso resolvera nossa divida. O que acha? Aceita o acordo?", npc, creature)
            npcHandler:setTopic(playerId, 3)
        elseif player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.PlantasSelvagens) == 3 then
            npcHandler:say("Voce trouxe a Dragon Scale Mail?", npc, creature)
            npcHandler:setTopic(playerId, 4)
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            if player:getItemCount(3397) >= 1 then
                npcHandler:say("Ah... Tao brilhante! Era exatamente o que eu queria! Tudo bem, tudo bem. Sinta-se livre para usar a minha forja.", npc, creature)
                player:removeItem(3397, 1)
                player:setStorageValue(Storage.Quest.Crandoria.ForgeSystem.Door, 2)
                local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 15)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Acho que voce nao entendeu.... Eu preciso de uma Dwarven Armor. Nao volte aqui sem ela.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 2 then
            npcHandler:say("Entao combinado! Eu preciso de 2 Blue Glass Plates, 2 Green Glass Plates e 2 Violet Glass Plates. Traga-os para mim e direi ao tal Comandante Crassus que estou satisfeito com a ajuda enviada por Crandoria. Estarei esperando!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 72)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 3 then
            if player:getItemCount(5892) >= 3 then
                player:removeItem(5892, 3)
                player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.PlantasSelvagens, 3)
                npcHandler:say("Muito bem. Estarei esperando com suas ferramentas.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
				npcHandler:say("Voce nao possui todos os itens...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
        elseif npcHandler:getTopic(playerId) == 4 then
            if player:getItemCount(3386) >= 1 then
                if player:getFreeCapacity() >= 200 then
                    player:removeItem(3386, 1)
                    local container = player:addItem(2862, 1)
                    if container then
                        container:addItem(3457, 1)
                        container:addItem(3456, 1)
                        container:addItem(3453, 1)
                    end
                    player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.PlantasSelvagens, 4)
                    npcHandler:say("Excelente! Aqui estao as ferramentas. Diga a Osric que sua divida esta paga!", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                else
                    npcHandler:say("As ferramentas estao muito pesdadas para voce. Voce precisa de ao menos 200 de capacidade para carregar as ferramentas.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                end
            else
				npcHandler:say("Voce nao possui a Dragon Scale Mail. Esta tentando me enganar?", npc, creature)
				npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) and npcHandler:getTopic(playerId) == 1 then
        npcHandler:say("Entao o que voce esta fazendo aqui? Nao desperdice meu tempo!", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola, jovem. Muitos viajantes aparecem por aqui interessados na minha {forja}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais! Volte quando quiser usar a forja.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
