local internalNpcName = "Santa Claus"
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
	lookBody = 112,
	lookLegs = 93,
	lookFeet = 95
}

npcConfig.flags = {
	floorchange = false
}

 local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

local talkState = {}
npcType.onAppear = function(npc, creature)
	 npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	 npcHandler:onDisappear(npc, creature)
end

npcType.onSay = function(npc, creature, type, message)
	 npcHandler:onSay(npc, creature, type, message)
end

npcType.onThink = function(npc, interval)
	 npcHandler:onThink(npc, interval)
end


-- local normalItems = {
-- 	 {7439, 7440, 7443},
-- 	 {3599, 6507},
-- 	 {3599, 6508},
-- 	 {3599, 6506},
-- 	 {3599, 2995},
-- 	 {3599, 2992},
-- 	 {3051, 3097, 3098},
-- 	 {10310},
-- 	 {3039},
-- 	 {3036}
-- }

-- local semiRareItems = {
-- 	 {3057},
-- 	 {9040},
-- 	 {9058},
-- 	 {5080}
-- }

-- local rareItems = {
-- 	 {2991},
-- 	 {5919},
-- 	 {6567},
-- 	 {10338},
-- 	 {10339},
-- 	 {6566},
-- 	 {2993},
-- 	 {9099},
-- 	 {637}
-- }

-- local veryRareItems = {
-- 	 {3570},
-- 	 {3001},
-- 	 {3553},
-- 	 {9604},
-- 	 {5804},
-- 	 {23682},
-- 	 {9306}
-- }

local normalItems = {
	{6508},
}

local semiRareItems = {
	 {6508},
}

local rareItems = {
	 {6507},
}

local veryRareItems = {
	 {6506},
}

-- local function getReward()
-- 	 local rewardTable = {}
-- 	 local random = math.random(100)
-- 	 if (random <= 90) then
-- 		  rewardTable = normalItems
-- 	 elseif (random <= 70) then
-- 		  rewardTable = semiRareItems
-- 	 elseif (random <= 35) then
-- 		  rewardTable = rareItems
-- 	 elseif (random <= 5) then
-- 		  rewardTable = veryRareItems
-- 	 end

-- 	 local rewardItem = rewardTable[math.random(#rewardTable)]
-- 	 return rewardItem
-- end

local accessedIPs = {}

local function creatureSayCallback(npc, creature, type, message)
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or creature
	local player = Player(creature)
	local timeLeft = math.floor((player:getStorageValue(Storage.Quest.Crandoria.EventoNatal.Cooldown) - os.time()) / 60)
	local missao = player:getStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao)
	local playerId = player:getId()
	local count = player:getStorageValue(Storage.Quest.Crandoria.EventoNatal.Count)

    local playerIP = player:getIp()

	if MsgContains(message, 'present') or MsgContains(message, 'missao') then
		if accessedIPs[playerIP] and accessedIPs[playerIP] ~= player:getGuid() then
			npcHandler:say("Parece que voce ja recebeu um presente hoje com outro personagem...", npc, creature)
			npcHandler:setTopic(playerId, 0)
		else
			if player:getLevel() >= 100 then
				if player:getStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao) < 1 then
					if player:getStorageValue(Storage.Quest.Crandoria.EventoNatal.Cooldown) < os.time() then
						npcHandler:say("Este ano estou distribuindo presentes apenas para boas pessoas que consigam me ajudar com simples missoes. \z
						Voce poderia me ajudar?", npc, creature)
						npcHandler:setTopic(playerId, 1)
					else
						npcHandler:say("Retorne em "..timeLeft.." minutos e talvez consiga me ajudar em troca de um presente.", npc, creature)
						npcHandler:setTopic(playerId, 0)
					end
				else
					local chanceGift = math.random(1, 100)
					if missao == 1 then
						npcHandler:say("Por favor, leve os 5 cookies que te entreguei para o Comandante Crassus ou para o Almirante Haldor.", npc, creature)
						npcHandler:setTopic(playerId, 0)
					elseif missao == 2 then
						if player:getLevel() < 100 or player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
							if chanceGift < 65 then
								player:addItem(6508, 1)
							else
								player:addItem(6507, 1)
							end
						else
							if chanceGift <= 50 then
								player:addItem(6508, 1)
							elseif chanceGift > 50 and chanceGift <= 85 then
								player:addItem(6507, 1)
							else
								player:addItem(6506, 1)
							end
						end
						accessedIPs[playerIP] = player:getGuid()
						npcHandler:say("Excelente, jovem! Voce mostrou ser uma boa pessoa. Aqui esta seu presente. Feliz Natal! Ho ho ho!", npc, creature)
						player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Cooldown, os.time() + 20 * 60 * 60)
						player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao, 0)
						if count < 1 then
							player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, 1)
						elseif count == 6 then
							player:addItem(6526, 5)
							player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, count + 1)
						else
							player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, count + 1)
						end
						npcHandler:setTopic(playerId, 0)
					elseif missao == 3 then
						if player:getItemCount(3357) >= 1 then
							if player:getLevel() < 100 or player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
								if chanceGift < 65 then
									player:addItem(6508, 1)
								else
									player:addItem(6507, 1)
								end
							else
								if chanceGift <= 50 then
									player:addItem(6508, 1)
								elseif chanceGift > 50 and chanceGift <= 85 then
									player:addItem(6507, 1)
								else
									player:addItem(6506, 1)
								end
							end
							accessedIPs[playerIP] = player:getGuid()
							player:removeItem(3357, 1)
							npcHandler:say("Excelente, jovem! Voce mostrou ser uma boa pessoa. Aqui esta seu presente. Feliz Natal! Ho ho ho!", npc, creature)
							player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Cooldown, os.time() + 20 * 60 * 60)
							player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao, 0)
							if count < 1 then
								player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, 1)
							elseif count == 6 then
								player:addItem(6526, 5)
								player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, count + 1)
							else
								player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, count + 1)
							end
							npcHandler:setTopic(playerId, 0)
						else
							npcHandler:say("Preciso muito de uma plate armor para me sentir seguro em minha proxima viagem. Traga uma e te darei um presente.", npc, creature)
							npcHandler:setTopic(playerId, 0)
						end
					elseif missao == 4 then
						if player:getItemCount(3603) >= 5 then
							if player:getLevel() < 100 or player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
								if chanceGift < 65 then
									player:addItem(6508, 1)
								else
									player:addItem(6507, 1)
								end
							else
								if chanceGift <= 50 then
									player:addItem(6508, 1)
								elseif chanceGift > 50 and chanceGift <= 85 then
									player:addItem(6507, 1)
								else
									player:addItem(6506, 1)
								end
							end
							accessedIPs[playerIP] = player:getGuid()
							player:removeItem(3603, 5)
							npcHandler:say("Excelente, jovem! Voce mostrou ser uma boa pessoa. Aqui esta seu presente. Feliz Natal! Ho ho ho!", npc, creature)
							player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Cooldown, os.time() + 20 * 60 * 60)
							player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao, 0)
							if count < 1 then
								player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, 1)
							elseif count == 6 then
								player:addItem(6526, 5)
								player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, count + 1)
							else
								player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, count + 1)
							end
							npcHandler:setTopic(playerId, 0)
						else
							npcHandler:say("Por favor, traga 5 unidades de farinha (flour) para que eu possa fazer mais cookies. Ho ho ho!", npc, creature)
							npcHandler:setTopic(playerId, 0)
						end
					elseif missao == 5 then
						npcHandler:say("Por favor, leve os 5 cookies para Lady Vandart, em Hakata. Retorne ate mim e recebera um presente! Ho ho ho!", npc, creature)
						npcHandler:setTopic(playerId, 0)
					elseif missao == 6 then
						if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
							if chanceGift < 65 then
								player:addItem(6508, 1)
							else
								player:addItem(6507, 1)
							end
							accessedIPs[playerIP] = player:getGuid()
							npcHandler:say("Muito bom! Espero que ele tenha gostado. Aqui esta seu presente. Feliz Natal! Ho ho ho!", npc, creature)
							player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Cooldown, os.time() + 20 * 60 * 60)
							player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao, 0)
							if count < 1 then
								player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, 1)
							else
								player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, count + 1)
							end
							npcHandler:setTopic(playerId, 0)
						else
							if player:getLevel() < 100 then
								if chanceGift < 65 then
									player:addItem(6508, 1)
								else
									player:addItem(6507, 1)
								end
							else
								if chanceGift <= 50 then
									player:addItem(6508, 1)
								elseif chanceGift > 50 and chanceGift <= 85 then
									player:addItem(6507, 1)
								else
									player:addItem(6506, 1)
								end
							end
							accessedIPs[playerIP] = player:getGuid()
							npcHandler:say("Muito bom! Espero que ela tenha gostado. Aqui esta seu presente. Feliz Natal! Ho ho ho!", npc, creature)
							player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Cooldown, os.time() + 20 * 60 * 60)
							player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao, 0)
							if count < 1 then
								player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, 1)
							elseif count == 6 then
								player:addItem(6526, 5)
								player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, count + 1)
							else
								player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, count + 1)
							end
							npcHandler:setTopic(playerId, 0)
						end
					elseif missao == 7 then
						if player:getItemCount(11444) >= 5 then
							player:removeItem(11444, 5)
							if player:getLevel() < 100 or player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
								if chanceGift < 65 then
									player:addItem(6508, 1)
								else
									player:addItem(6507, 1)
								end
							else
								if chanceGift <= 50 then
									player:addItem(6508, 1)
								elseif chanceGift > 50 and chanceGift <= 85 then
									player:addItem(6507, 1)
								else
									player:addItem(6506, 1)
								end
							end
							accessedIPs[playerIP] = player:getGuid()
							npcHandler:say("Que maravilha! Farei cinco lindos presentes com elas. Aqui, seu presente! Ho ho ho!", npc, creature)
							player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Cooldown, os.time() + 20 * 60 * 60)
							player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao, 0)
							if count < 1 then
								player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, 1)
							elseif count == 6 then
								player:addItem(6526, 5)
								player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, count + 1)
							else
								player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, count + 1)
							end
							npcHandler:setTopic(playerId, 0)
						else
							npcHandler:say("Por favor, traga as 5 protective charms para mim.", npc, creature)
							npcHandler:setTopic(playerId, 0)
						end
					elseif missao == 8 then
						if player:getItemCount(3723) >= 5 then
							player:removeItem(3723, 5)
							if player:getLevel() < 100 or player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
								if chanceGift < 65 then
									player:addItem(6508, 1)
								else
									player:addItem(6507, 1)
								end
							else
								if chanceGift <= 50 then
									player:addItem(6508, 1)
								elseif chanceGift > 50 and chanceGift <= 85 then
									player:addItem(6507, 1)
								else
									player:addItem(6506, 1)
								end
							end
							accessedIPs[playerIP] = player:getGuid()
							npcHandler:say("Eles estao com uma cara otima! Muito bem, voce realmente se mostrou uma boa pessoa. Aqui esta seu presente! Ho ho ho!", npc, creature)
							player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Cooldown, os.time() + 20 * 60 * 60)
							player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao, 0)
							if count < 1 then
								player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, 1)
							elseif count == 6 then
								player:addItem(6526, 5)
								player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, count + 1)
							else
								player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, count + 1)
							end
							npcHandler:setTopic(playerId, 0)
						else
							npcHandler:say("Por favor, traga os 5 White Mushrooms para me ajudar com minha receita.", npc, creature)
							npcHandler:setTopic(playerId, 0)
						end
					elseif missao == 9 then
						if player:getItemCount(1781) >= 25 then
							player:removeItem(1781, 25)
							if player:getLevel() < 100 or player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
								if chanceGift < 65 then
									player:addItem(6508, 1)
								else
									player:addItem(6507, 1)
								end
							else
								if chanceGift <= 50 then
									player:addItem(6508, 1)
								elseif chanceGift > 50 and chanceGift <= 85 then
									player:addItem(6507, 1)
								else
									player:addItem(6506, 1)
								end
							end
							accessedIPs[playerIP] = player:getGuid()
							npcHandler:say("Muito bem! Eles vao aprender a serem pessoas melhores depois desses 'presentinhos'... Ho ho ho! Aqui esta seu presente!", npc, creature)
							player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Cooldown, os.time() + 20 * 60 * 60)
							player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao, 0)
							if count < 1 then
								player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, 1)
							elseif count == 6 then
								player:addItem(6526, 5)
								player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, count + 1)
							else
								player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, count + 1)
							end
							npcHandler:setTopic(playerId, 0)
						else
							npcHandler:say("Por favor, traga as 25 Small Stones para os presentes dos jovens levados. Ho ho ho!", npc, creature)
							npcHandler:setTopic(playerId, 0)
						end
					elseif missao == 10 then
						if player:getItemCount(11464) >= 5 then
							player:removeItem(11464, 5)
							if player:getLevel() < 100 or player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
								if chanceGift < 65 then
									player:addItem(6508, 1)
								else
									player:addItem(6507, 1)
								end
							else
								if chanceGift <= 50 then
									player:addItem(6508, 1)
								elseif chanceGift > 50 and chanceGift <= 85 then
									player:addItem(6507, 1)
								else
									player:addItem(6506, 1)
								end
							end
							accessedIPs[playerIP] = player:getGuid()
							npcHandler:say("Excelente! Os arqueiros de Crandoria vao gostar muito do presente. Ho ho ho! Aqui esta seu presente!", npc, creature)
							player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Cooldown, os.time() + 20 * 60 * 60)
							player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao, 0)
							if count < 1 then
								player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, 1)
							elseif count == 6 then
								player:addItem(6526, 5)
								player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, count + 1)
							else
								player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, count + 1)
							end
							npcHandler:setTopic(playerId, 0)
						else
							npcHandler:say("Por favor, traga as 5 Elven Scounting Glass para os presentes dos jovens arqueiros. Ho ho ho!", npc, creature)
							npcHandler:setTopic(playerId, 0)
						end
					elseif missao == 11 then
						if player:getItemCount(9633) >= 3 then
							player:removeItem(9633, 3)
							if player:getLevel() < 100 or player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
								if chanceGift < 65 then
									player:addItem(6508, 1)
								else
									player:addItem(6507, 1)
								end
							else
								if chanceGift <= 50 then
									player:addItem(6508, 1)
								elseif chanceGift > 50 and chanceGift <= 85 then
									player:addItem(6507, 1)
								else
									player:addItem(6506, 1)
								end
							end
							accessedIPs[playerIP] = player:getGuid()
							npcHandler:say("Excelente! Agora tenho o que preciso. Ho ho ho! Aqui esta seu presente!", npc, creature)
							player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Cooldown, os.time() + 20 * 60 * 60)
							player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao, 0)
							if count < 1 then
								player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, 1)
							elseif count == 6 then
								player:addItem(6526, 5)
								player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, count + 1)
							else
								player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Count, count + 1)
							end
							npcHandler:setTopic(playerId, 0)
						else
							npcHandler:say("Por favor, traga as 3 Bloody Pincers para o ensopado de carangueijo que estou fazendo. Ho ho ho!", npc, creature)
							npcHandler:setTopic(playerId, 0)
						end
					end
				end
			else
				if player:getStorageValue(Storage.Quest.Crandoria.EventoNatal.Cooldown) < os.time() then
					npcHandler:say("Sinto muito, jovem, mas nesse nivel voce nao saberia nem o que fazer com um de meus presentes. Me mostre que voce pode ser um bom garoto e retorne apos o nivel 100. \z
					Aqui, nao fique triste, pegue alguns cookies.", npc, creature)
					player:addItem(3598, 5)
					player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Cooldown, os.time() + 60 * 60)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Sinto muito, jovem, mas nesse nivel voce nao saberia nem o que fazer com um de meus presentes. Me mostre que voce pode ser um bom garoto e retorne apos o nivel 100.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			end
		end

	elseif MsgContains(message, 'yes') or MsgContains(message, 'sim') then
		if npcHandler:getTopic(playerId) == 1 then
			local chance = math.random(1, 9)
			if chance == 1 then
				npcHandler:say("Poderia me ajudar com uma boa acao? Aqui estao 5 cookies, leve-os para o Comandante Crassus ou para o Almirante Haldor. \z
				Basta dizer 'cookies' e eles saberao quem os enviou. Retorne ate mim e recebera sua recompensa. Ho ho ho!", npc, creature)
				player:addItem(3598, 5)
				player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao, 1)
				npcHandler:setTopic(playerId, 0)
			elseif chance == 2 then
				npcHandler:say("Preciso me preparar para viajar novamente em alguns dias. Traga-me uma plate armor para que eu me sinta mais seguro! Ho ho ho!", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao, 3)
				npcHandler:setTopic(playerId, 0)
			elseif chance == 3 then
				npcHandler:say("Preciso de farinha para fazer mais cookies de Natal. Leve este trigo para algum moinho e transforme-o em farinha para mim, por favor. \z
				Retorne com a farinha e te darei um presente! Ho ho ho!", npc, creature)
				player:addItem(3605, 5)
				player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao, 4)
				npcHandler:setTopic(playerId, 0)
			elseif chance == 4 then
				if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) ~= 1 then
					npcHandler:say("Lady Vandart sempre foi uma guerreira solitaria. Atualmente ela guarda os muros de Hakata e merece ser recompensada pelo seu bom trabalho. \z
					Por favor, leve estes 5 cookies para ela. Nao precisa dizer quem mandou, apenas diga 'cookies' e ela entendera. Retorne e te darei um presente! Ho ho ho!", npc, creature)
					player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao, 5)
					player:addItem(3598, 5)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Barter controla a area dos insetos gigantes em Viridia e faz um otimo trabalho, mas muitos nao o valorizam. Mudaremos isso hoje! \z
					Por favor, leve estes 5 cookies para ele. Nao precisa dizer quem mandou, apenas diga 'cookies' e entregue a ele. Retorne e te darei um presente! Ho ho ho!", npc, creature)
					player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao, 5)
					player:addItem(3598, 5)
					npcHandler:setTopic(playerId, 0)
				end
			elseif chance == 5 then
				npcHandler:say("Traga 5 Protective Charms para mim. Preciso deles para montar alguns presentes. Se trouxer todos te darei um presente. Ho ho ho!", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao, 7)
				npcHandler:setTopic(playerId, 0)
			elseif chance == 6 then
				npcHandler:say("Quero cozinhar uma torta de cogumelos e estou precisando de alguns White Mushrooms. Poderia trazer 5 para mim? \z
				Te darei um presente especial se conseguir me ajudar. Estarei esperando! Ho ho ho!", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao, 8)
				npcHandler:setTopic(playerId, 0)
			elseif chance == 7 then
				npcHandler:say("As vezes gosto de pregar pecas nas pessoas que nao merecem bons presentes... Faz parte do trabalho, certo? Ho ho ho! \z
				Traga para mim 25 Small Stones para que eu possa colocar em sacos de presentes para esses danadinhos... Estarei esperando e te darei um presente em troca! Ho ho ho!", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao, 9)
				npcHandler:setTopic(playerId, 0)
			elseif chance == 8 then
				npcHandler:say("Alguns arqueiros pediram por alguns Elven Scouting Glass dos elfos para seus arcos. Quem diria, nao e mesmo?! Ho ho ho! \z
				Por favor, traga 5 deles para mim e te darei um presente de Natal. Estarei esperando! Ho ho ho!", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao, 10)
				npcHandler:setTopic(playerId, 0)
			elseif chance == 9 then
				npcHandler:say("Quero fazer um ensopado de carangueiro para servir como presente aos amantes de culinaria. O que acha? Ho ho ho! \z
				Por favor, me ajude com alguns Bloody Pincers. Uns 3 deles sera o suficiente. Que tal? Traga para mim e te darei um presente de natal! Ho ho ho!", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao, 11)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end


	-- if MsgContains(message, 'present') or MsgContains(message, 'missao') and player:getLevel() > 50 then
	-- 	local player = Player(creature)
	-- 	if (player:getStorageValue(840293) == 1) then
	-- 		npcHandler:say("Voce nao pode obter mais presentes", npc, creature)
	-- 		return false
	-- 	end
		
	-- 	local reward = getReward()
	-- 	local cont = Container(Player(creature):addItem(6510):getUniqueId())
	-- 	local count = 1
		
	-- 	for i = 1, #reward do
	-- 		if (reward[i] == 2992 or
	-- 		reward[i] == 3599) then
	-- 			count = 10
	-- 		end
			
	-- 		cont:addItem(reward[i], count)
	-- 	end
		
	-- 	player:setStorageValue(840293, 1)
	-- 	npcHandler:say("Merry Christmas!", npc, creature)
	-- end
	
	-- return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
