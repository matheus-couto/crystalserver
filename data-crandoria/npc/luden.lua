local internalNpcName = "Luden"
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
	lookBody = 113,
	lookLegs = 0,
	lookFeet = 114,
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

local outfits = {
    ["arbalester"] = {1450, 1449},
    ["armoured archer"] = {1619, 1618},
    ["breezy garb"] = {1246, 1245},
    ["ceremonial garb"] = {694, 695},
    ["conjurer"] = {635, 634},
    ["death herald"] = {666, 667},
    ["entrepreneur"] = {471, 472},
    ["fencer"] = {1576, 1575},
    ["forest warden"] = {1416, 1415},
    ["frost tracer"] = {1613, 1612},
    ["ghost blade"] = {1490, 1489},
    ["herbalist"] = {1020, 1021},
    ["herder"] = {1280, 1279},
    ["merry garb"] = {1383, 1382},
    ["moth cape"] = {1339, 1338},
    ["nordic chieftain"] = {1501, 1500},
    ["owl keeper"] = {1174, 1173},
    ["pharaoh"] = {956, 955},
    ["philosopher"] = {874, 873},
    ["ranger"] = {683, 684},
    ["sea dog"] = {749, 750},
    ["seaweaver"] = {732, 733},
    ["shadowlotus disciple"] = {1582, 1581},
    ["siege master"] = {1050, 1051},
    ["spirit caller"] = {698, 699},
    ["sun priest"] = {1024, 1023},
    ["trailblazer"] = {1293, 1292},
    ["veteran paladin"] = {1205, 1204},
}

local function giveRandomOutfit(player)
    local keys = {}
    for k in pairs(outfits) do
        table.insert(keys, k)
    end

    local maxTries = #keys
    for i = 1, maxTries do
        local randomKey = keys[math.random(#keys)]
        local maleId, femaleId = unpack(outfits[randomKey])

        if not player:hasOutfit(maleId) and not player:hasOutfit(femaleId) then
            player:addOutfit(maleId, 0)
            player:addOutfit(femaleId, 0)
            player:addOutfitAddon(maleId, 1)
            player:addOutfitAddon(femaleId, 1)
            player:addOutfitAddon(maleId, 2)
            player:addOutfitAddon(femaleId, 2)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu o outfit: " .. randomKey)
            return true
        end
    end

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already have all available outfits!")
    return false
end

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

    local chance = math.random(1, 10)
    local chance2 = math.random(1, 20)
    local cost = 3000000

    if MsgContains(message, "oferta") or MsgContains(message, "offer") then
        local nearbyPlayers = 0
        local npcPosition = npc:getPosition()
        local spectators = Game.getSpectators(npcPosition, false, true, 8, 8, 8, 8)
        for _, entity in pairs(spectators) do
            if entity:isPlayer() then
                nearbyPlayers = nearbyPlayers + 1
            end
        end
    
        if nearbyPlayers > 1 then
            npcHandler:say("Ha muitas pessoas por perto. Espere ate que estejamos sozinhos para nao levantar suspeitas.", npc, creature)
            npcHandler:setTopic(playerId, 0)
            addEvent(function()
                npc:getPosition():sendMagicEffect(CONST_ME_POFF)
                npc:say("FUI", TALKTYPE_MONSTER_SAY, false, nil, npc:getPosition())
                Game.broadcastMessage("Luden foi embora sem deixar rastros.", MESSAGE_EVENT_ADVANCE)
                npc:remove()
            end, 1000 * 5 * 60)
            return true
        end

        npcHandler:say("Pela singela quantia de " ..cost.. " gold coins te entregarei um recurso unico de dentro da minha bolsa. Eu carrego apenas {itens} valiosos comigo. \z
        Mas ATENCAO: Eu nao olharei o item que entregarei a voce. Pegarei o dinheiro, te entregarei um item aleatorio e irei embora. Gostaria de fazer essa aposta?", npc, creature)
        npcHandler:setTopic(playerId, 1)

    elseif MsgContains(message, "itens") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Entre os itens da minha bolsa estao Tibia Coins, Stamina Refills, Dragonfruits, Exercise Stashes, alguns artigos raros, como Holy Falcons e Holy Scarabs, \z
            Chaotic Gambles, Medalhas de Honra e talvez alguns addons... Se quiser, podera pagar " ..cost.. " gold coins para obter um desses itens aleatoriamente. O que acha, quer tentar a sorte?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        end
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
        local money = player:getBankBalance() + player:getMoney()
        if npcHandler:getTopic(playerId) == 1 then
            if player:getFreeCapacity() >= 50 and player:getFreeBackpackSlots() >= 1 then
                -- if Game.getStorageValue(GlobalStorage.Crandoria.LudenRaid) <= os.time() then
                    if money >= cost then
                        player:removeMoneyBank(cost)
                        if chance == 1 then
                            local container = player:addItem(8861, 1)
                            container:addItem(26186, 1)
                            container:addItem(26186, 1)
                            container:addItem(26186, 1)
                            container:addItem(26186, 1)
                            container:addItem(26186, 1)
                            npc:say("FUI", TALKTYPE_MONSTER_SAY, false, nil, npc:getPosition())
                            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 5 Exercise Stashes de Luden.")
                            Game.broadcastMessage("Luden foi embora sem deixar rastros.", MESSAGE_EVENT_ADVANCE)
                            Game.setStorageValue(GlobalStorage.Crandoria.LudenRaid, os.time() + 20 * 60 * 60)
                            npc:getPosition():sendMagicEffect(CONST_ME_POFF)
                            npcHandler:setTopic(playerId, 0)
                            npc:remove()
                        elseif chance == 2 then
                            player:addTransferableCoins(100)
                            setGlobalStorage(GlobalStorage.Crandoria.TibiaCoinsColeta.CoinsTotal, getGlobalStorage(GlobalStorage.Crandoria.TibiaCoinsColeta.CoinsTotal) + 100)
                            npc:say("FUI", TALKTYPE_MONSTER_SAY, false, nil, npc:getPosition())
                            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 100 Tibia Coins de Luden.")
                            Game.broadcastMessage("Luden foi embora sem deixar rastros.", MESSAGE_EVENT_ADVANCE)
                            Game.setStorageValue(GlobalStorage.Crandoria.LudenRaid, os.time() + 20 * 60 * 60)
                            npc:getPosition():sendMagicEffect(CONST_ME_POFF)
                            npcHandler:setTopic(playerId, 0)
                            npc:remove()
                        elseif chance == 3 then
                            player:addItem(3024, 1)
                            npc:say("FUI", TALKTYPE_MONSTER_SAY, false, nil, npc:getPosition())
                            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu um Holy Falcon de Luden.")
                            Game.broadcastMessage("Luden foi embora sem deixar rastros.", MESSAGE_EVENT_ADVANCE)
                            Game.setStorageValue(GlobalStorage.Crandoria.LudenRaid, os.time() + 20 * 60 * 60)
                            npc:getPosition():sendMagicEffect(CONST_ME_POFF)
                            npcHandler:setTopic(playerId, 0)
                            npc:remove()
                        elseif chance == 4 then
                            player:addItem(3023, 1)
                            npc:say("FUI", TALKTYPE_MONSTER_SAY, false, nil, npc:getPosition())
                            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu um Holy Scarab de Luden.")
                            Game.broadcastMessage("Luden foi embora sem deixar rastros.", MESSAGE_EVENT_ADVANCE)
                            Game.setStorageValue(GlobalStorage.Crandoria.LudenRaid, os.time() + 20 * 60 * 60)
                            npc:getPosition():sendMagicEffect(CONST_ME_POFF)
                            npcHandler:setTopic(playerId, 0)
                            npc:remove()
                        elseif chance == 5 then
                            local container = player:addItem(8861, 1)
                            container:addItem(11682, 50)
                            npc:say("FUI", TALKTYPE_MONSTER_SAY, false, nil, npc:getPosition())
                            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu um 50 Dragonfruits de Luden.")
                            Game.broadcastMessage("Luden foi embora sem deixar rastros.", MESSAGE_EVENT_ADVANCE)
                            Game.setStorageValue(GlobalStorage.Crandoria.LudenRaid, os.time() + 20 * 60 * 60)
                            npc:getPosition():sendMagicEffect(CONST_ME_POFF)
                            npcHandler:setTopic(playerId, 0)
                            npc:remove()
                        elseif chance == 6 then
                            player:addItem(20138, 3)
                            npc:say("FUI", TALKTYPE_MONSTER_SAY, false, nil, npc:getPosition())
                            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu um 3 Small Stamina Refills de Luden.")
                            Game.broadcastMessage("Luden foi embora sem deixar rastros.", MESSAGE_EVENT_ADVANCE)
                            Game.setStorageValue(GlobalStorage.Crandoria.LudenRaid, os.time() + 20 * 60 * 60)
                            npc:getPosition():sendMagicEffect(CONST_ME_POFF)
                            npcHandler:setTopic(playerId, 0)
                            npc:remove()
                        elseif chance == 7 then
                            player:addItem(20139, 2)
                            npc:say("FUI", TALKTYPE_MONSTER_SAY, false, nil, npc:getPosition())
                            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu um 2 Full Stamina Refills de Luden.")
                            Game.broadcastMessage("Luden foi embora sem deixar rastros.", MESSAGE_EVENT_ADVANCE)
                            Game.setStorageValue(GlobalStorage.Crandoria.LudenRaid, os.time() + 20 * 60 * 60)
                            npc:getPosition():sendMagicEffect(CONST_ME_POFF)
                            npcHandler:setTopic(playerId, 0)
                            npc:remove()
                        elseif chance == 8 then
                            player:addItem(12811, 1)
                            npc:say("FUI", TALKTYPE_MONSTER_SAY, false, nil, npc:getPosition())
                            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu um 1 Basic Chaotic Gamble de Luden.")
                            Game.broadcastMessage("Luden foi embora sem deixar rastros.", MESSAGE_EVENT_ADVANCE)
                            Game.setStorageValue(GlobalStorage.Crandoria.LudenRaid, os.time() + 20 * 60 * 60)
                            npc:getPosition():sendMagicEffect(CONST_ME_POFF)
                            npcHandler:setTopic(playerId, 0)
                            npc:remove()
                        elseif chance == 9 then
                            player:addItem(9219, 1)
                            npc:say("FUI", TALKTYPE_MONSTER_SAY, false, nil, npc:getPosition())
                            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu um 1 Medalha de Honra de Luden.")
                            Game.broadcastMessage("Luden foi embora sem deixar rastros.", MESSAGE_EVENT_ADVANCE)
                            Game.setStorageValue(GlobalStorage.Crandoria.LudenRaid, os.time() + 20 * 60 * 60)
                            npc:getPosition():sendMagicEffect(CONST_ME_POFF)
                            npcHandler:setTopic(playerId, 0)
                            npc:remove()
                        elseif chance == 10 then
                            local receivedOutfit = giveRandomOutfit(player)
                            if receivedOutfit then
                                -- giveRandomOutfit(player)
                                npc:say("FUI", TALKTYPE_MONSTER_SAY, false, nil, npc:getPosition())
                                Game.setStorageValue(GlobalStorage.Crandoria.LudenRaid, os.time() + 20 * 60 * 60)
                                npc:getPosition():sendMagicEffect(CONST_ME_POFF)
                                Game.broadcastMessage("Luden foi embora sem deixar rastros.", MESSAGE_EVENT_ADVANCE)
                                npcHandler:setTopic(playerId, 0)
                                npc:remove()
                            else
                                local container = player:addItem(8861, 1)
                                container:addItem(26186, 1)
                                container:addItem(26186, 1)
                                container:addItem(26186, 1)
                                container:addItem(26186, 1)
                                container:addItem(26186, 1)
                                npc:say("FUI", TALKTYPE_MONSTER_SAY, false, nil, npc:getPosition())
                                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 5 Exercise Stashes de Luden.")
                                Game.broadcastMessage("Luden foi embora sem deixar rastros.", MESSAGE_EVENT_ADVANCE)
                                Game.setStorageValue(GlobalStorage.Crandoria.LudenRaid, os.time() + 20 * 60 * 60)
                                npc:getPosition():sendMagicEffect(CONST_ME_POFF)
                                npcHandler:setTopic(playerId, 0)
                                npc:remove()
                            end
                        end
                    else
                        npcHandler:say("Voce nao possui dinheiro o suficiente...", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                -- else
                --     npc:say("FUI", TALKTYPE_MONSTER_SAY, false, nil, npc:getPosition())
                --     npc:getPosition():sendMagicEffect(CONST_ME_POFF)
                --     Game.broadcastMessage("Luden foi embora sem deixar rastros.", MESSAGE_EVENT_ADVANCE)
                --     npcHandler:setTopic(playerId, 0)
                --     npc:remove()
                -- end
            else
                npcHandler:say("Voce precisa de 50 de Cap e 1 Slot vazio no inventario para realizar a troca.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end

    end

end


npcHandler:setMessage(MESSAGE_GREET, "Ola, jovem. Esta interessado em uma {oferta} especial?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Boa sorte!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
