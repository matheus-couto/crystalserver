local internalNpcName = "Espirito de Suon"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 309,
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

    local mTypeA = MonsterType("Dragon Lord")
    local raceIdA = mTypeA:raceId()

    local storage = player:getStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Progresso)

        local area1 = {
        fromPosition = {x = 4457, y = 5464, z = 15},
        toPosition = {x = 4465, y = 5473, z = 15}
    }

    local area2 = {
        fromPosition = {x = 4457, y = 5465, z = 15},
        toPosition = {x = 4465, y = 5473, z = 14}
    }

    local function isInArea(player, area)
        local playerPos = player:getPosition()
        return playerPos.x >= area.fromPosition.x and playerPos.x <= area.toPosition.x
            and playerPos.y >= area.fromPosition.y and playerPos.y <= area.toPosition.y
            and playerPos.z == area.fromPosition.z
    end

    local function hasPlayerInArea(fromPosition, toPosition)
        for x = fromPosition.x, toPosition.x do
            for y = fromPosition.y, toPosition.y do
                local pos = Position(x, y, fromPosition.z)
                local tile = Tile(pos)
                if tile then
                    local creature = tile:getTopCreature()
                    if creature and creature:isPlayer() then
                        return true
                    end
                end
            end
        end
        return false
    end

    if MsgContains(message, "missao") or MsgContains(message, "mission") or MsgContains(message, "amulet") or MsgContains(message, "artefato") then
        if hasPlayerInArea(Position(4458, 5465, 14), Position(4465, 5473, 14)) then
            npcHandler:say("Ha um mortal passando pelo teste agora.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        else
            npcHandler:say("Ao mortal que carrega meu poder concedo o direito de se defender. Veremos se es um mestre de guerra ou apenas adubo pra terra! Pouco tempo e muita luta, assim se resume a guerra ou quase qualquer disputa. \z
            Mostre que tem mesmo o direito de carregar o poder no peito. Prepare-se, mortal! Se terminar o desafio, este sera seu maior feito.", npc, creature)
            addEvent(function()
                if isInArea(player, area1) then
                    player:teleportTo(Position(4461, 5469, 14))
                    Game.createMonster("Ancient Scarab", Position(4460, 5466, 14), true, true)
                    Game.createMonster("Ancient Scarab", Position(4460, 5470, 14), true, true)
                    Game.createMonster("Putrid Mummy", Position(4463, 5468, 14), true, true)
                    Game.createMonster("Putrid Mummy", Position(4458, 5469, 14), true, true)
                    Game.createMonster("Scarab", Position(4459, 5468, 14), true, true)
                    Game.createMonster("Scarab", Position(4464, 5466, 14), true, true)
                    addEvent(function()
                        Game.createMonster("Dragon Lord", Position(4460, 5466, 14), true, true)
                        Game.createMonster("Dragon Lord", Position(4460, 5470, 14), true, true)
                        Game.createMonster("Lizard High Guard", Position(4463, 5468, 14), true, true)
                        Game.createMonster("Lizard High Guard", Position(4458, 5469, 14), true, true)
                        Game.createMonster("Draken Warmaster", Position(4459, 5468, 14), true, true)
                        Game.createMonster("Draken Warmaster", Position(4464, 5466, 14), true, true)
                        addEvent(function()
                            Game.createMonster("Lizard High Guard", Position(4460, 5466, 14), true, true)
                            Game.createMonster("Draken Spellweaver", Position(4460, 5470, 14), true, true)
                            Game.createMonster("Lizard Chosen", Position(4463, 5468, 14), true, true)
                            Game.createMonster("Lizard Chosen", Position(4458, 5469, 14), true, true)
                            Game.createMonster("Draken Warmaster", Position(4459, 5468, 14), true, true)
                            Game.createMonster("Draken Warmaster", Position(4464, 5466, 14), true, true)
                            addEvent(function()
                                Game.createMonster("Lizard High Guard", Position(4460, 5466, 14), true, true)
                                Game.createMonster("Draken Spellweaver", Position(4460, 5470, 14), true, true)
                                Game.createMonster("Lizard Chosen", Position(4463, 5468, 14), true, true)
                                Game.createMonster("Lizard Chosen", Position(4458, 5469, 14), true, true)
                                Game.createMonster("Draken Warmaster", Position(4459, 5468, 14), true, true)
                                Game.createMonster("Draken Warmaster", Position(4464, 5466, 14), true, true)
                                addEvent(function()
                                    Game.createMonster("Ripper Spectre", Position(4460, 5466, 14), true, true)
                                    Game.createMonster("Ripper Spectre", Position(4460, 5470, 14), true, true)
                                    Game.createMonster("Arachnophobica", Position(4463, 5468, 14), true, true)
                                    Game.createMonster("Gazer Spectre", Position(4462, 5468, 14), true, true)
                                    Game.createMonster("Gazer Spectre", Position(4458, 5469, 14), true, true)
                                    Game.createMonster("Burster Spectre", Position(4459, 5468, 14), true, true)
                                    Game.createMonster("Burster Spectre", Position(4464, 5466, 14), true, true)
                                    addEvent(function()
                                        Game.createMonster("White Weretiger", Position(4460, 5466, 14), true, true)
                                        Game.createMonster("Feral Werecrocodile", Position(4460, 5470, 14), true, true)
                                        Game.createMonster("Weretiger", Position(4460, 5470, 14), true, true)
                                        Game.createMonster("Werecrocodile", Position(4463, 5468, 14), true, true)
                                        Game.createMonster("White Weretiger", Position(4462, 5468, 14), true, true)
                                        Game.createMonster("Werecrocodile", Position(4458, 5469, 14), true, true)
                                        Game.createMonster("Feral Werecrocodile", Position(4459, 5468, 14), true, true)
                                        Game.createMonster("Cunning Werepanther", Position(4464, 5466, 14), true, true)
                                        addEvent(function()
                                            Game.createMonster("Demon", Position(4460, 5466, 14), true, true)
                                            Game.createMonster("Grim Reaper", Position(4460, 5470, 14), true, true)
                                            Game.createMonster("Demon", Position(4460, 5470, 14), true, true)
                                            Game.createMonster("Destroyer", Position(4463, 5468, 14), true, true)
                                            Game.createMonster("Demon", Position(4462, 5468, 14), true, true)
                                            Game.createMonster("Destroyer", Position(4458, 5469, 14), true, true)
                                            Game.createMonster("Grim Reaper", Position(4459, 5468, 14), true, true)
                                            Game.createMonster("Grim Reaper", Position(4464, 5466, 14), true, true)
                                            addEvent(function()
                                                Game.createMonster("Tormento de Suon", Position(4460, 5466, 14), true, true)
                                            end, 60000)
                                        end, 20000)
                                    end, 20000)
                                end, 20000)
                            end, 20000)
                        end, 20000)
                    end, 10000)
                end
            end, 15000)

        end

        npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "O que faz em meu centro de treinamento?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
