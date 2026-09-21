local internalNpcName = "Taburok"
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
	lookHead = 3,
	lookBody = 77,
	lookLegs = 68,
	lookFeet = 76,
	lookAddons = 0
}

npcConfig.flags = {
	floorchange = false
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
        if player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 65 then
            npcHandler:say("Entao era de voce que Gondariel estava falando? Hehehehe... Voce nao tem cara de quem entende de agricultura, mas tudo bem... Eu preciso de 15 pineapples, Voce pode pega-las na area comunitaria. \z
			Ela fica acima do curral comunitario, ao norte da cidade, ou sua propria fazenda. Sera que voce consegue pegar as 15 pineapples para mim?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		elseif player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 66 then
			if player:removeItem(11459, 15) then
				npcHandler:say("Confesso que eu duvidei de voce por um momento, jovem... MAs voce conseguiu. Agradeco muito pelo esforco e, como prometido, aqui esta sua recompensa. Esse alimento nao te ajudara em nenhuma batalha, mas com certeza te dara boas historias de pescador para contar... HA HA HA!! \z
				Va ate Calante, ela tambem tem uma encomenda para voce, jovem viajante.", npc, creature)
				player:addItem(29413, 1, true)
				player:addItem(22724, 15, true)
				player:addExperience(5000000, true)
				player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 67)
			else
				npcHandler:say("Nao se esqueca, preciso de 15 Pineapples! Traga-as para mim e direi a Comandante Crassus que eu estou satisfeito.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	elseif MsgContains(message, "mina") or MsgContains(message, "mine") then
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
	elseif MsgContains(message, "um dia") then
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
	elseif MsgContains(message, "uma semana") then
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

    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 2 then
			npcHandler:say("Ok, ok... Veremos se da conta do recado. Se trouxer todas para mim te darei uma recompensa. Estarei esperando!", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 66)
			player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.CountGondariel, 0)
			npcHandler:setTopic(playerId, 0)
		end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) and npcHandler:getTopic(playerId) == 1 then
        npcHandler:say("Tudo bem, sem problemas.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end


-- npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
-- npcConfig.currency = 11460

-- npcConfig.shop = {
-- 	{ name = "blessed acorn", clientId = 26074, buy = 5},
-- 	{ name = "blessed steak", clientId = 9086, buy = 200},
-- 	{ name = "blueberry cupcake", clientId = 28484, buy = 225},
-- 	{ name = "carrion casserole", clientId = 29414, buy = 25},
-- 	{ name = "carrot cake", clientId = 9087, buy = 180},
-- 	{ name = "carrot pie", clientId = 29409, buy = 130},
-- 	-- { name = "coconut shrimp bake", clientId = 11584, buy = 50},
-- 	{ name = "consecrated beef", clientId = 29415, buy = 40},
-- 	{ name = "delicatessen salad", clientId = 29411, buy = 125},
-- 	{ name = "filled jalapeno peppers", clientId = 9085, buy = 75},
-- 	{ name = "hydra tongue salad", clientId = 9080, buy = 75},
-- 	{ name = "pot of blackjack", clientId = 11586, buy = 125},
-- 	-- { name = "roasted wyvern wings", clientId = 29408, buy = 175},
-- 	{ name = "rotworm stew", clientId = 9079, buy = 100},
-- 	{ name = "strawberry cupcake", clientId = 28485, buy = 125},
-- 	-- { name = "svargrond salmon filet", clientId = 29413, buy = 275},
-- 	{ name = "sweet mangonaise elixir", clientId = 11588, buy = 200},
-- 	{ name = "tropical marinated tiger", clientId = 29410, buy = 180},
-- 	-- { name = "demonic candy ball", clientId = 11587, buy = 150},


-- }

npcHandler:setMessage(MESSAGE_GREET, "Saudacoes, |PLAYERNAME|. Que tal obter recursos preciosos em nossa {mina} ajudando nossos arduos trabalhadores?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType)
end

npcType:addDialogOptions("bye")
npcType:register(npcConfig)