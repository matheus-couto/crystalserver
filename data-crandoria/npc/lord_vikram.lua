local internalNpcName = "Lord Vikram"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 667,
	lookHead = 0,
	lookBody = 68,
	lookLegs = 59,
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

npcConfig.voices = {
	interval = 30000,
	chance = 100,
	{text = 'Ja adquiriu o Passe dos Novatos? Realize as missoes do passe comigo!'},
	{text = 'Entrego missoes do Passe dos Novatos! Disponiveis por pouco tempo!'},
}

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()

    local knight = player:getVocation():getBaseId() == VOCATION.BASE_ID.KNIGHT
    local paladin = player:getVocation():getBaseId() == VOCATION.BASE_ID.PALADIN
    local guardian = player:getVocation():getBaseId() == VOCATION.BASE_ID.CELESTIAL_GUARDIAN
    local druid = player:getVocation():getBaseId() == VOCATION.BASE_ID.DRUID
    local sorcerer = player:getVocation():getBaseId() == VOCATION.BASE_ID.SORCERER
    local summoner = player:getVocation():getBaseId() == VOCATION.BASE_ID.ANCIENT_SUMMONER

    function getHighestSkillType(player)
        local skills = {
            SKILL_DISTANCE,
            SKILL_AXE,
            SKILL_SWORD,
            SKILL_CLUB,
            -- SKILL_MAGLEVEL,
        }
    
        local highestSkillValue = -1  
        local highestSkillType = nil
    
        for _, skillId in ipairs(skills) do
            local skillValue = player:getEffectiveSkillLevel(skillId) or 0
            if skillValue > highestSkillValue then
                highestSkillValue = skillValue
                highestSkillType = skillId
            end
        end
    
        return highestSkillType
    end
    
    local highestSkillType = getHighestSkillType(player)

    local exp = player:getLevel() * 2500

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

    if MsgContains(message, "missao") or MsgContains(message, "mission") or MsgContains(message, "passe") then
        if player:getStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso) < 1 then
            npcHandler:say("Voce ainda nao possui um Passe dos Novatos ativado. Voce pode obter o passe na Store e ativa-lo ate o nivel 100.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso) == 1 then
            npcHandler:say("Entao voce ativou um Passe dos Novatos? Certo, vamos iniciar sua jornada... Sua primeira missao sera derrotar 50 Rotworms. \z
            Simples, rapido e facil. Retorne ate mim quando terminar e te farei uma recompensa e sua proxima missao.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Count, 0)
            player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso, 2)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso) == 2 then
            if player:getStorageValue(Storage.Quest.Crandoria.PasseNovatos.Count) < 50 then
                npcHandler:say("Como eu disse, voce deve derrotar 50 rotworms. Retorne ate mim quando finalizar a missao.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                if player:getFreeBackpackSlots() >= 3 and player:getFreeCapacity() >= 220 then
                    npcHandler:say("Finalizou a missao? Excelente! Foi mais rapido do que eu esperava. Aqui esta sua recompensa: 1 Livro Sagrado, 1 Dia de VIP, 1 Plate Set e um pouco de experiencia. \z
                    Me avise quando estiver pronto para a proxima {missao} do seu passe.", npc, creature)
                    local container = player:addItem(2863, 1)
                    if container then
                        container:addItem(3557, 1)
                        container:addItem(3357, 1)
                        container:addItem(3351, 1)
                    end
                    player:addItem(25745, 1)
                    player:addPremiumDays(1)
                    player:addExperience(75000 + exp, true)
                    player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Count, 0)
                    player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso, 3)
                    npcHandler:setTopic(playerId, 0)
                else
                    npcHandler:say("Voce deve possuir 3 espacos no inventario e ao menos 220 de cap livre para obter as recompensas.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                end
            end
        elseif player:getStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso) == 3 then
            npcHandler:say("Preciso de 5 minotaur horns, ou chifres de minotauros. Voce pode encontrar minotauros a oeste de Crandoria, em suas ruinas. \z
            Tenha cuidado ao explorar o local.. Voce pode acabar encontrando minotauros muito fortes para voce. Boa sorte!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso, 4)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso) == 4 then
            npcHandler:say("Voce trouxe os 5 minotaur horns que eu pedi?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        elseif player:getStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso) == 5 then
            npcHandler:say("Vamos a mais uma missao contra monstros! Agora voce tera que derrotar alguns Tarantulas! Mas nao se preocupe, nao pegarei pesado com voce.\z
            Derrote 50 Tarantulas e sua missao estara completa. Voce pode encontrar tarantulas na direcao sudeste de Crandoria. Boa sorte!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Count, 0)
            player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso, 6)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso) == 6 then
            if player:getStorageValue(Storage.Quest.Crandoria.PasseNovatos.Count) < 50 then
                npcHandler:say("Como eu solicitei, voce deve derrotar 50 tarantulas. Retorne ate mim quando finalizar a missao.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                if player:getFreeBackpackSlots() >= 3 and player:getFreeCapacity() >= 20 then
                    npcHandler:say("Otimo! Mostramos a essas malditas tarantulas quem manda na superficie. Aqui, uma modesta recompensa: 1 Livro Sagrado, 1 Exp Boost Potion, 1 Passe dos Teleports e um pouco de experiencia.\z
                    Me informe quando quiser seguir para a proxima {missao}.", npc, creature)
                    player:addExperience(250000 + exp, true)
                    player:addItem(8151, 1)
                    player:addItem(11372, 1)
                    player:addItem(25745, 1)
                    player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Count, 0)
                    player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso, 7)
                    npcHandler:setTopic(playerId, 0)
                else
                    npcHandler:say("Voce deve possuir 3 espacos e ao menos 20 de cap livre para obter as recompensas.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                end
            end
        elseif player:getStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso) == 7 then
            npcHandler:say("Ja enfrentou algum dragao? Aposto que sim! Voce parece ansiar pela morte... Sendo assim, preciso de alguns recursos de dragoes.\z
            Traga para mim 5 Green Dragon Leathers. Voce pode obte-los mais facilmente utilizando uma Obsidian Knife nos corpos... Boa sorte.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso, 8)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso) == 8 then
            npcHandler:say("Voce trouxe os 5 dragon leathers que eu pedi?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif player:getStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso) == 9 then
            npcHandler:say("Vamos ver se voce esta realmente mais forte. Derrote 20 Giant Spiders. Voce pode encontra-las na mesma caverna das Tarantulas. \z
            Tome cuidado, esses monstros podem correr muito rapido e causar muito dano. Estarei esperando!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Count, 0)
            player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso, 10)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso) == 10 then
            if player:getStorageValue(Storage.Quest.Crandoria.PasseNovatos.Count) < 20 then
                npcHandler:say("Como eu disse, voce deve derrotar 20 giant spider. Retorne ate mim quando finalizar a missao.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Essa demorou um pouco mais do que eu pensava... Aqui, sua recompensa: 1 Livro Sagrado, 1 Small Stamina Refill, 3 Dias VIP e um pouco de experiencia. \z
                Me avise quando estiver pronto para a proxima {missao} do seu passe.", npc, creature)
                player:addPremiumDays(3)
                player:addExperience(600000 + exp, true)
                player:addItem(25745, 1)
                player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Count, 0)
                player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso, 11)
                npcHandler:setTopic(playerId, 0)
            end
        elseif player:getStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso) == 11 then
            npcHandler:say("Que tal mais uma busca por itens? Talvez dessa vez voce tenha um pouco mais de trabalho nessa proxima, mas sei que voce consegue! \z
            Traga para mim 3 Red Dragon Scales e 1 Dragon Lance. Boa sorte em sua busca!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso, 12)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso) == 12 then
            npcHandler:say("Voce conseguiu obter os 3 Red Dragon Scales e a Dragon Lance?", npc, creature)
            npcHandler:setTopic(playerId, 3)
        elseif player:getStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso) == 13 then
            npcHandler:say("Sua proxima missao sera muito facil. Tudo o que voce precisara sera ficar online, o que acha? \z
            Traga-me 20 Online Tokens e sua missao estara finalizada! Estou esperando.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso, 14)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso) == 14 then
            npcHandler:say("Voce conseguiu obter os 20 Online Tokens?", npc, creature)
            npcHandler:setTopic(playerId, 4)
        elseif player:getStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso) == 15 then
            npcHandler:say("Que tal um desafio de verdade agora? Ja ouviu falar na Annihilator Quest? Sua proxima missao sera finalizar a quest. \z
            Se voce ja terminou a missao, entao basta me dizer. Estarei esperando.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso, 16)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso) == 16 then
            if player:getStorageValue(Storage.Quest.U7_24.TheAnnihilator.Reward) > 0 then
                npcHandler:say("Incrivel! Voce conseguiu mesmo. Certo, como combinado, aqui esta sua recompensa: 1 Livro Sagrado, 1 Full Stamina Refill, 1 Small Stamina Refill e uma boa quantidade de experiencia. \z
                Me informe quando estiver pronto para sua penultima {missao}!", npc, creature)
                player:addExperience(2500000 + exp, true)
                player:addItem(20138, 1)
                player:addItem(20139, 1)
                player:addItem(25745, 1)
                player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso, 17)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce ainda nao finalizou a Annihilator Quest.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif player:getStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso) == 17 then
            npcHandler:say("Encontre e derrote algumas hydras. Digamos... 200 Hydras. Sei que nao sera um grande desafio para voce, estou certo? \z
            Voce pode encontrar muitas hydras ao norte de Hakata. Acidade pode ser acessada pelo navio do Captain Whitepatch. Boa sorte.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Count, 0)
            player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso, 18)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso) == 18 then
            if player:getStorageValue(Storage.Quest.Crandoria.PasseNovatos.Count) < 200 then
                npcHandler:say("Derrote 200 Hydras para finalizar sua missao.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                if player:getFreeBackpackSlots() >= 3 and player:getFreeCapacity() >= 30 then
                    player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Count, 0)
                    player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso, 19)
                    player:addItem(25745, 1)
                    player:addItem(11372, 1)
                    if druid or sorcerer or summoner then
                        player:addItem(35290, 14400)
                    elseif paladin then
                        player:addItem(35288, 14400)
                    else
                        if highestSkillType == SKILL_SWORD then
                            player:addItem(35285, 14400)
                        elseif highestSkillType == SKILL_CLUB then
                            player:addItem(35287, 14400)
                        elseif highestSkillType == SKILL_AXE then
                            player:addItem(35286, 14400)
                        end
                    end
                    player:addExperience(4000000 + exp)
                    npcHandler:say("Muito bem! Nao acredito que voce matou 200 Hydras tao rapido. Sua recompensa: 1 Livro Sagrado, 1 Exp Boost Potion, 1 Lasting Exercise Weapon e uma boa quantidade de experiencia.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                else
                    npcHandler:say("Voce deve possuir 3 espacos e ao menos 30 de cap livre para obter as recompensas.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                end
            end
        elseif player:getStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso) == 19 then
            npcHandler:say("Finalmente voce chegou a sua ultima missao do Passe dos Novatos. Claro, seu ultimo desafio nao sera facil, entao prepare-se! \z
            Derrote o temivel boss Jaul! Ele pode ser encontrado nas profundezas de Nautis. Boa sorte!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso, 20)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso) == 20 then
            npcHandler:say("Derrote Jaul e retorne ate mim. Lembre-se: Voce deve ataca-lo com todas as suas forcas e te-lo como alvo. Nao basta estar presente quando ele morrer.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso) == 21 then
            npcHandler:say("Incrivel! Voce mostrou ser digno de verdade dos reinos de Crandoria. Aqui, sua recompensa final. 1 Livro Sagrado, uma boa quantidade de experiencia, 150.000 gold coins, 3 dias VIP e 1 montaria especial.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso, 22)
            player:addExperience(5000000 + exp)
            player:addItem(3043, 15)
            player:addPremiumDays(3)
            player:addItem(25745, 1)
            player:addMount(146)
            player:addOutfit(1207)
            player:addOutfit(1206)
            player:addOutfitAddon(1206, 1)
            player:addOutfitAddon(1206, 2)
            player:addOutfitAddon(1207, 1)
            player:addOutfitAddon(1207, 2)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
        if npcHandler:getTopic(playerId) == 1 then
            if player:getItemCount(11472) >= 5 then
                if player:getFreeBackpackSlots() >= 3 and player:getFreeCapacity() >= 125 then
                    player:removeItem(11472, 5)
                    player:addExperience(125000 + exp)
                    player:addItem(3043, 2)
                    player:addItem(9099, 1)
                    player:addItem(25745, 1)
                    player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso, 5)
                    npcHandler:say("Muito bem! Parece que voce nao teve tanta dificuldade com os minotauros afinal. Aqui esta sua recompensa, 1 Livro Sagrado, uma black candle, um pouco de experiencia e 20.000 gold coins. \z
                    Voce pode equipar a Black Candle como fonte de luz para receber regeneracao por tres horas. Me informe quando estiver pronto para a proxima {missao}.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                else
                    npcHandler:say("Voce deve possuir 3 espacos no inventario e ao menos 125 de cap livre para obter as recompensas.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                end
            else
                npcHandler:say("Voce nao possui todos os itens.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getItemCount(5877) >= 5 then
                if player:getFreeBackpackSlots() >= 3 and player:getFreeCapacity() >= 20 then
                    player:removeItem(5877, 5)
                    player:addExperience(350000 + exp)
                    player:addItem(3043, 5)
                    player:addItem(36875, 1)
                    player:addItem(25745, 1)
                    player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso, 9)
                    npcHandler:say("Maravilha! Esse couro dara uma otima roupa para os dias de frio. Aqui, 1 Livro Sagrado, 1 Espelho do Mercador, um pouco de experiencia e 50.000 gold coins. \z
                    O espelho pode ser consumido para gerar um NPC que compra e vende recursos por alguns minutos. Me informe quando estiver pronto para a proxima {missao}.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                else
                    npcHandler:say("Voce deve possuir 3 espacos no inventario e ao menos 20 de cap livre para obter as recompensas.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                end
            else
                npcHandler:say("Voce nao possui todos os itens.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 3 then
            if player:getItemCount(5882) >= 3 and player:getItemCount(3302) >= 1 then
                if player:getFreeBackpackSlots() >= 2 and player:getFreeCapacity() >= 20 then
                    player:removeItem(5882, 3)
                    player:removeItem(3302, 1)
                    player:addItem(25745, 1)
                    player:addExperience(1000000 + exp)
                    npcHandler:say("Couro e... lanca! Muito bem, muito bem... Aos poucos voce esta mostrando seu valor. Aqui, sua recompensa: 1 Livro Sagrado, 1 Durable Exercise Weapon para sua classe e skill e um pouco de experiencia.\z
                    Me diga quando quiser iniciar sua proxima {missao}.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso, 13)
                    if druid or sorcerer or summoner then
                        player:addItem(35284, 1800)
                    elseif paladin then
                        player:addItem(35282, 1800)
                    else
                        if highestSkillType == SKILL_SWORD then
                            player:addItem(35279, 1800)
                        elseif highestSkillType == SKILL_CLUB then
                            player:addItem(35281, 1800)
                        elseif highestSkillType == SKILL_AXE then
                            player:addItem(35280, 1800)
                        end
                    end
                    npcHandler:setTopic(playerId, 0)
                else
                    npcHandler:say("Voce deve possuir 2 espacos no inventario e ao menos 20 de cap livre para obter as recompensas.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                end
            else
                npcHandler:say("Voce nao possui todos os itens.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 4 then
            if player:getItemCount(22723) >= 20 then
                if player:getFreeBackpackSlots() >= 4 and player:getFreeCapacity() >= 30 then
                    player:removeItem(22723, 20)
                    npcHandler:say("Muito bem, voce esta quase finalizando sua jornada inicial. Aqui esta sua recompensa: 1 Livro Sagrado, 80.000 gold coins, 2 Espelhos do Mercador e alguma experiencia.", npc, creature)
                    player:addExperience(1500000 + exp)
                    player:addItem(25745, 1)
                    player:addItem(3043, 8)
                    player:addItem(36875, 1)
                    player:addItem(36875, 1)
                    player:setStorageValue(Storage.Quest.Crandoria.PasseNovatos.Progresso, 15)
                    npcHandler:setTopic(playerId, 0)
                else
                    npcHandler:say("Voce deve possuir 4 espacos no inventario e ao menos 30 de cap livre para obter as recompensas.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                end
            else
                npcHandler:say("Voce nao possui todos os itens.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|... Fale comigo para realizar as missoes do {passe dos novatos}. Estarei em Crandoria durante o mes de Dezembro.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais.") 
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)