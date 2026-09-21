local internalNpcName = "Mestre dos Teleports"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 908,
	lookHead = 94,
	lookBody = 114,
	lookLegs = 39,
	lookFeet = 57,
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
    local storageCrassus = player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso)
    local storage = player:getStorageValue(Storage.Quest.Crandoria.HuntTeleports.Acesso)

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

    if MsgContains(message, "teleport") or MsgContains(message, "portal") then
        npcHandler:say({"Meus teleports podem te levar para diversos locais diferentes, mas cada um deles tem um preco. Alem disso, para utilizar teleports avancados voce precisara passar por {missoes} importantes. ...",
        "Tenho teleports {iniciais}, {basicos}, {intermediarios}, {avancados} e de {bosses}. Para alcancar cada novo nivel, voce tem que ter passado pelos anteriores."}, npc, creature)
        npcHandler:setTopic(playerId, 1)
    elseif MsgContains(message, "missao") or MsgContains(message, "mission") or MsgContains(message, "missoes") or MsgContains(message, "iniciais") or MsgContains(message, "basicas") or MsgContains(message, "intermediarias") or MsgContains(message, "avancadas") or MsgContains(message, "bosses") then
        if storage < 1 then
            if storageCrassus < 10 then
                npcHandler:say({"Vejo que voce possui acesso apenas aos teleports iniciais. Para acessar a area dos teleports basicos voce precisara completar a Missao 5 do Comandante Crassus. Apos isso, precisarei que voce pegue alguns itens para mim. ...",
                "Ajude Crassus com suas cinco primeiras missoes e retorne para que eu te passe os detalhes da sua proxima missao!"},npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say({"Muito bem. Ja que voce provou seu valor ajudando Crassus em suas missoes, esta na hora de provar sua forca para utilizar os proximos portais. Para isso, precisarei de alguns produtos de criaturas para continuar alimentando as chamas dos portais iniciais. ...",
                "Traga-me 2 Protective Charms, 3 Elvish Talismans, 3 Minotaur Horns, 1 Brown Piece of Cloth, 3 Cyclops Toes, 1 Iron Ore, 1 Spider Silk, 2 Dragon's Tails, 1 Bonelord Eye, 3 Books of Necromantic Rituals e 1 Ice Cube. Traga todos os itens de uma vez. Acha que consegue?"},npc, creature)
                npcHandler:setTopic(playerId, 1)
            end
        elseif storage == 1 then
            npcHandler:say("Para provar seu valor e passar para a proxima secao de portais voce precisa me trazer 2 Protective Charms, 3 Elvish Talismans, 3 Minotaur Horns, 1 Brown Piece of Cloth, 3 Cyclops Toes, 1 Iron Ore, 1 Spider Silk, 2 Dragon's Tails, 1 Bonelord Eye, 3 Books of Necromantic Rituals e 1 Ice Cube. Traga todos os itens de uma vez. Voce tem tudo ai?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif storage == 2 then
            if storageCrassus < 28 then
                npcHandler:say({"Pelo visto voce ja possui acesso aos teleports de nivel basico. Para acessar a area dos teleports de nivel intermediario voce precisara completar a Missao 14 do Comandante Crassus. Apos isso, precisarei que voce pegue mais alguns itens para mim. ...",
                "Ajude Crassus com suas missoes ate a de numero 14 e retorne para que eu te passe os detalhes da sua proxima missao!"},npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say({"Certo. Crassus parece satisfeito com sua ajuda nas missoes, entao esta na hora de provar seu poder e mostrar que voce merece utilizar os proximos portais. Para isso, precisarei de alguns produtos de criaturas para continuar alimentando as chamas dos portais basicos. ...",
                "Traga-me 3 Vampire Teeth, 2 Red Pieces of Cloth, 3 Mutated Bat Ears, 3 Boggy Dreads, 3 Wyrm Scales, 3 Compound Eyes, 3 Red Hair Dyes, 2 Red Dragon Scales, 3 Deepling Breaktime Snacks, 1 Hydra Egg, 1 Werewolf Amulet, 2 Quara Bones, 1 Shard e 2 Lizard Leathers. Traga todos os itens de uma vez. Acha que consegue?"},npc, creature)
                npcHandler:setTopic(playerId, 3)
            end
        elseif storage == 3 then
            npcHandler:say("Para provar seu valor e liberar os portais intermediarios voce precisa me trazer 3 Vampire Teeth, 2 Red Pieces of Cloth, 3 Mutated Bat Ears, 3 Boggy Dreads, 3 Wyrm Scales, 3 Compound Eyes, 3 Red Hair Dyes, 2 Red Dragon Scales, 3 Deepling Breaktime Snacks, 1 Hydra Egg, 1 Werewolf Amulet, 2 Quara Bones, 1 Shard e 2 Lizard Leathers. Voce possui todos os itens?", npc, creature)
            npcHandler:setTopic(playerId, 4)
        elseif storage == 4 then
            if storageCrassus < 60 then
                npcHandler:say({"No momento voce pode acessar as areas inicial, basica e intermediaria. Para acessar a area Avancada voce precisa antes provar que voce pode ser um bom prospector. ...",
                "Para isso voce devera ajudar Comandante Crassus com suas missoes ate finalizar a missao de numero 30! Voce pode conferir em qual missao voce esta olhando seu Quest Log. retorne quando tiver terminado."},npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say({"Parece que o Comandante Crassus esta extremamente satisfeito com sua capacidade para a coleta de itens de criatuars. E nunca foi muito facil impressionar aquele velho Comandante. Mas agora chegou a minha vez. ...",
                "Para obter acesso aos portais de nivel avancado voce precisara me trazer os seguintes itens: 10 Demonic Essences, 3 Golden Lotus Brooches, 1 Glooth Amulet, 2 Bone Shoulderplates, 1 Cluster of Solace, 1 Werecrocodile Tongue, 1 Weretiger Tooth, 2 Empty Honey Glasses, 2 Mystical Hour Glasses, 2 Bashmu Fangs, 3 Naga Earrings, 5 Onyx Chips e 1 Behemoth Claw. Traga tudo e podera usar os portais avancados. Acha que consegue?"},npc, creature)
                npcHandler:setTopic(playerId, 5)
            end
        elseif storage == 5 then
            npcHandler:say("Para provar seu valor e liberar os portais avancados voce precisa me trazer 10 Demonic Essences, 3 Golden Lotus Brooches, 1 Glooth Amulet, 2 Bone Shoulderplates, 1 Cluster of Solace, 1 Werecrocodile Tongue, 1 Weretiger Tooth, 2 Empty Honey Glasses, 2 Mystical Hour Glasses, 2 Bashmu Fangs, 3 Naga Earrings, 5 Onyx Chips e 1 Behemoth Claw. Voce tem tudo ai?", npc, creature)
            npcHandler:setTopic(playerId, 6)
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            player:setStorageValue(Storage.Quest.Crandoria.HuntTeleports.Acesso, 1)
            npcHandler:say("Muito bem, estarei aguardando pelos itens. Lembre-se: Voce deve trazer todos de uma so vez!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getItemCount(11444) >= 2 and player:getItemCount(9635) >= 3 and player:getItemCount(11472) >= 3 and player:getItemCount(5913) >= 1 and player:getItemCount(9657) >= 3 and player:getItemCount(5880) >= 1 and player:getItemCount(5879) >= 1 and player:getItemCount(11457) >= 2 and player:getItemCount(5898) >= 1 and player:getItemCount(10320) >= 3 and player:getItemCount(7441) >= 1 then
                player:removeItem(11444, 2)
                player:removeItem(9635, 3)
                player:removeItem(11472, 3)
                player:removeItem(5913, 1)
                player:removeItem(9657, 3)
                player:removeItem(5880, 1)
                player:removeItem(5879, 1)
                player:removeItem(11457, 2)
                player:removeItem(5898, 1)
                player:removeItem(10320, 3)
                player:removeItem(7441, 1)
                player:setStorageValue(Storage.Quest.Crandoria.HuntTeleports.Acesso, 2)
                player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                player:addExperience(1000000, true)
                npcHandler:say("Voce provou que alguns monstros fracos nao sao nada para voce e seu espirito. Entao siga. Os Teleports Basicos estao liberados para voce. Me procure quando quiser uma {missao} mais desafiadora.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui todos os itens.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 3 then
            player:setStorageValue(Storage.Quest.Crandoria.HuntTeleports.Acesso, 3)
            npcHandler:say("Muito bem, estarei aguardando pelos itens. Lembre-se: Voce deve trazer todos de uma so vez!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 4 then
            if player:getItemCount(9685) >= 3 and player:getItemCount(5911) >= 1 and player:getItemCount(9662) >= 3 and player:getItemCount(9667) >= 2 and player:getItemCount(9665) >= 3 and player:getItemCount(14083) >= 3 and player:getItemCount(17855) >= 3 and player:getItemCount(5882) >= 2 and player:getItemCount(14011) >= 3 and player:getItemCount(4839) >= 1 and player:getItemCount(22060) >= 1 and player:getItemCount(11491) >= 2 and player:getItemCount(7290) >= 1 and player:getItemCount(5876) >= 2 then
                player:removeItem(9585, 3)
                player:removeItem(5911, 1)
                player:removeItem(9662, 3)
                player:removeItem(9667, 2)
                player:removeItem(9665, 3)
                player:removeItem(14083, 3)
                player:removeItem(17855, 3)
                player:removeItem(5882, 2)
                player:removeItem(14011, 3)
                player:removeItem(4839, 1)
                player:removeItem(22060, 1)
                player:removeItem(11491, 2)
                player:removeItem(7290, 1)
                player:removeItem(5876, 2)
                player:setStorageValue(Storage.Quest.Crandoria.HuntTeleports.Acesso, 4)
                player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
                player:addExperience(5000000, true)
                npcHandler:say("Muito bom... esta tudo aqui, realmente. Fico impressionado pela sua competencia, |PLAYERNAME|. Tudo bem, voce a partir de agora esta livre para acessar a area dos teleports intermediarios. Tenha cuidado!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui todos os itens. Lembre-se, preciso de 3 Vampire Teeth, 2 Red Pieces of Cloth, 3 Mutated Bat Ears, 3 Boggy Dreads, 3 Wyrm Scales, 3 Compound Eyes, 3 Red Hair Dyes, 2 Red Dragon Scales, 3 Deepling Breaktime Snacks, 1 Hydra Egg, 1 Werewolf Amulet, 2 Quara Bones, 1 Shard e 2 Lizard Leathers.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 5 then
            player:setStorageValue(Storage.Quest.Crandoria.HuntTeleports.Acesso, 5)
            npcHandler:say("Muito bem, estarei aguardando pelos itens. Lembre-se: Voce deve trazer todos de uma so vez!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 6 then
            if player:getItemCount(6499) >= 10 and player:getItemCount(21974) >= 3 and player:getItemCount(20062) >= 1 and player:getItemCount(21183) >= 1 and player:getItemCount(10404) >= 2 and player:getItemCount(43729) >= 1 and player:getItemCount(43730) >= 1 and player:getItemCount(31331) >= 2 and player:getItemCount(9660) >= 2 and player:getItemCount(36820) >= 2 and player:getItemCount(39412) >= 3 and player:getItemCount(22193) >= 5 and player:getItemCount(5930) >= 1 then
                player:removeItem(21183, 1)
                player:removeItem(6499, 10)
                player:removeItem(21974, 3)
                player:removeItem(20062, 1)
                player:removeItem(10404, 2)
                player:removeItem(43729, 1)
                player:removeItem(43730, 1)
                player:removeItem(31331, 2)
                player:removeItem(9660, 2)
                player:removeItem(36820, 2)
                player:removeItem(39412, 3)
                player:removeItem(22193, 5)
                player:removeItem(5930, 1)
                player:setStorageValue(Storage.Quest.Crandoria.HuntTeleports.Acesso, 6)
            else
                npcHandler:say("Voce nao possui todos os itens. Lembre-se, preciso de 10 Demonic Essences, 3 Golden Lotus Brooches, 1 Glooth Amulet, 2 Bone Shoulderplates, 1 Cluster of Solace, 1 Werecrocodile Tongue, 1 Weretiger Tooth, 2 Empty Honey Glasses, 2 Mystical Hour Glasses, 2 Bashmu Fangs, 3 Naga Earrings, 5 Onyx Chips e 1 Behemoth Claw.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola. Os {teleports} ajudam muito quando estamos sem tempo.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais! Volte quando quiser usar algum dos meus teleports.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
