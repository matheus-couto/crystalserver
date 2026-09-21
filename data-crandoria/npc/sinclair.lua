local internalNpcName = "Sinclair"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 133,
	lookHead = 21,
	lookBody = 38,
	lookLegs = 19,
	lookFeet = 95,
	lookAddons = 1
}

npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = 'So oferecemos os melhores!' },
	{ text = 'Pare de se aventurar sozinho. Contrate um de nossos mercenarios!' },
	{ text = 'Temos mercenarios para jogadores iniciantes, veteranos e, claro, para os mais fortes!' },
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

local function releasePlayer(npc, creature)
	if not Player(creature) then
		return
	end

	npcHandler:removeInteraction(npc, creature)
	npcHandler:resetNpc(creature)
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local rep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
	local storageActive = player:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Active)
	local damage = player:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage)
	local cooldown = player:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Cooldown)
	local class = player:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Class)
	local category = player:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Category)
	local timeLeft = math.floor((player:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Cooldown) - os.time()) / 60)
	local life = player:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Life)
	local physRes = player:getStorageValue(Storage.Quest.Crandoria.Mercenarios.ResPhys)
	local eleRes = player:getStorageValue(Storage.Quest.Crandoria.Mercenarios.ResElement)
	local looktype = player:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Looktype)
	local addon = player:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Addon)

	local position = player:getPosition()

	local price1 = 250000
	local price2 = 1000000
	local price3 = 2500000
	local priceTC1 = 10
	local priceTC2 = 20
	local priceTC3 = 40

	local now = os.time()

	if MsgContains(message, 'merc') then
		if rep < 25 then
			npcHandler:say("Sinto muito, |PLAYERNAME|... Te considero uma pessoa muito boa, mas infelizmente so negocio com os mais Notaveis. \z
			Talvez, quando sua reputacao melhorar, possamos fazer negocio.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		else
			if storageActive < 1 then 
				if cooldown < now then
					npcHandler:say("Posso te oferecer um {guerreiro}, um {atirador} ou um {mago} por 24 horas. Caso ele desapareca sem morrer, voce pode retornar e convoca-lo novamente de graca. \z
					Qual deles voce deseja?", npc, creature)
					npcHandler:setTopic(playerId, 1)
				else
					npcHandler:say("Voce deve esperar "..timeLeft.." minutos para obter um novo mercenario ou pode solicitar uma contratacao {especial} por Tibia Coins. Basta dizer.", npc, creature)
					npcHandler:setTopic(playerId, 4)
				end
			else
				if storageActive == 1 then
					if cooldown > now then

						local summons = player:getSummons()
						local hasMercenary = false

						for _, summon in ipairs(summons) do
							local name = summon:getName()

							if name == "Guerreiro Mercenario Novato"
							or name == "Guerreiro Mercenario Veterano"
							or name == "Guerreiro Mercenario Elite"
							or name == "Atirador Mercenario Novato"
							or name == "Atirador Mercenario Veterano"
							or name == "Atirador Mercenario Elite"
							or name == "Mago Mercenario Novato"
							or name == "Mago Mercenario Veterano"
							or name == "Mago Mercenario Elite" then

								hasMercenary = true
								break
							end
						end

						if hasMercenary then
							npcHandler:say("Voce ja possui um mercenario ativo. Me fale caso queira {encerrar} esse contrato. Voce ainda tera que aguardar o tempo para contratar um novo mercenario.", npc, creature)
							npcHandler:setTopic(playerId, 2)
						else
							npcHandler:say("Deseja convocar seu mercenario ativo?", npc, creature)
							npcHandler:setTopic(playerId, 3)
						end

					else
						npcHandler:say("O tempo do seu mercenario terminou. Voce deseja pagar para {manter} sua ultima contratacao por 24 horas ou deseja {contratar} um novo mercenario?", npc, creature)
						npcHandler:setTopic(playerId, 9)
					end
				elseif storageActive == 2 then
					npcHandler:say("Infelizmente voce deixou um de meus mercenarios morrer. Sabemos que isso pode acontecer, mas sempre sera uma perda importante. \z
					Voce deve esperar "..timeLeft.." minutos para obter um novo mercenario ou pode solicitar uma contratacao {especial} por Tibia Coins. Basta dizer.", npc, creature)
					npcHandler:setTopic(playerId, 4)
				end
			end
		end
	elseif MsgContains(message, 'guerreiro') then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Guerreiros possuem muita vida e altas defesas, mas nao causam danos tao destrutivos e nao sao tao eficientes na cura. \z
			Voce pode entregar ultimate health potions a eles e eles se manterao firmes em combate. Posso te oferecer um {novato}, um {veterano} ou um mercenario de {elite}. \z
			Qual deles voce deseja hoje?", npc, creature)
			npcHandler:setTopic(playerId, 5)
		elseif npcHandler:getTopic(playerId) == 10 then
			npcHandler:say("Guerreiros possuem muita vida e altas defesas, mas nao causam danos tao destrutivos e nao sao tao eficientes na cura. \z
			Voce pode entregar ultimate health potions a eles e eles se manterao firmes em combate. Posso te oferecer um {novato}, um {veterano} ou um mercenario de {elite}. \z
			Qual deles voce deseja hoje?", npc, creature)
			npcHandler:setTopic(playerId, 12)
		end
	elseif MsgContains(message, 'atirador') then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Atiradores sao os mais fortes contra alvos isolados! Possuem vida mediana, se curam bem e tem boa resistencia a dano fisico, mas sofrem contra danos elementais. \z
			Entregue ultimate spirit potions a um atirador para garantir maior seguranca. Posso te oferecer um {novato}, um {veterano} ou um mercenario de {elite}. \z
			Qual deles voce deseja hoje?", npc, creature)
			npcHandler:setTopic(playerId, 6)
		elseif npcHandler:getTopic(playerId) == 10 then
			npcHandler:say("Atiradores sao os mais fortes contra alvos isolados! Possuem vida mediana, se curam bem e tem boa resistencia a dano fisico, mas sofrem contra danos elementais. \z
			Entregue ultimate spirit potions a um atirador para garantir maior seguranca. Posso te oferecer um {novato}, um {veterano} ou um mercenario de {elite}. \z
			Qual deles voce deseja hoje?", npc, creature)
			npcHandler:setTopic(playerId, 13)
		end
	elseif MsgContains(message, 'mago') then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Magos sao poderosos e atacam com spells de alvo unico e spells em area. Possuem pouca vida e sao fracos contra danos fisicos, mas suas curas sao poderosas e sao fortes contra danos elementais. \z
			Entregue ultimate mana potions a um mago e ele podera te curar. Posso te oferecer um {novato}, um {veterano} ou um mercenario de {elite}. \z
			Qual deles voce deseja hoje?", npc, creature)
			npcHandler:setTopic(playerId, 7)
		elseif npcHandler:getTopic(playerId) == 10 then
			npcHandler:say("Magos sao poderosos e atacam com spells de alvo unico e spells em area. Possuem pouca vida e sao fracos contra danos fisicos, mas suas curas sao poderosas e sao fortes contra danos elementais. \z
			Entregue ultimate mana potions a um mago e ele podera te curar. Posso te oferecer um {novato}, um {veterano} ou um mercenario de {elite}. \z
			Qual deles voce deseja hoje?", npc, creature)
			npcHandler:setTopic(playerId, 14)
		end
	elseif MsgContains(message, 'contratar') then
		if npcHandler:getTopic(playerId) == 9 then
			npcHandler:say("Posso te oferecer um {guerreiro}, um {atirador} ou um {mago} por 24 horas. Caso ele desapareca sem morrer, voce pode retornar e convoca-lo novamente de graca. \z
			Qual deles voce deseja?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
	elseif MsgContains(message, 'encerrar') then
		if npcHandler:getTopic(playerId) == 2 then
			npcHandler:say("Deseja mesmo encerrar o contrato atual?", npc, creature)
			npcHandler:setTopic(playerId, 8)
		end
	elseif MsgContains(message, 'especial') then
		if npcHandler:getTopic(playerId) == 4 then
			npcHandler:say("Posso te oferecer um {guerreiro}, um {atirador} ou um {mago} por 24 horas. Caso ele desapareca sem morrer, voce pode retornar e convoca-lo novamente de graca. \z
			Qual deles voce deseja?", npc, creature)
			npcHandler:setTopic(playerId, 10)
		end
	elseif MsgContains(message, 'manter') then
		if npcHandler:getTopic(playerId) == 9 then
			if category == 1 then
				npcHandler:say("Pagando um valor de 10 Tibia Coins voce pode manter seu ultimo mercenario por mais 24 horas. Voce aceita?", npc, creature)
				npcHandler:setTopic(playerId, 11)
			elseif category == 2 then
				npcHandler:say("Pagando um valor de 15 Tibia Coins voce pode manter seu ultimo mercenario por mais 24 horas. Voce aceita?", npc, creature)
				npcHandler:setTopic(playerId, 41)
			elseif category == 3 then
				npcHandler:say("Pagando um valor de 30 Tibia Coins voce pode manter seu ultimo mercenario por mais 24 horas. Voce aceita?", npc, creature)
				npcHandler:setTopic(playerId, 51)
			end
		end
	elseif MsgContains(message, 'novato') then
		if player:getLevel() >= 250 then
			if npcHandler:getTopic(playerId) == 5 then
				npcHandler:say("Voce pode contratar um Guerreiro Novato por "..price1.." gold coins. Voce aceita?", npc, creature)
				npcHandler:setTopic(playerId, 20)
			elseif npcHandler:getTopic(playerId) == 6 then
				npcHandler:say("Voce pode contratar um Atirador Novato por "..price1.." gold coins. Voce aceita?", npc, creature)
				npcHandler:setTopic(playerId, 23)
			elseif npcHandler:getTopic(playerId) == 7 then
				npcHandler:say("Voce pode contratar um Mago Novato por "..price1.." gold coins. Voce aceita?", npc, creature)
				npcHandler:setTopic(playerId, 26)
			elseif npcHandler:getTopic(playerId) == 12 then
				npcHandler:say("Voce pode contratar um Guerreiro Novato por "..priceTC1.." Tibia Coins. Voce aceita?", npc, creature)
				npcHandler:setTopic(playerId, 30)
			elseif npcHandler:getTopic(playerId) == 13 then
				npcHandler:say("Voce pode contratar um Atirador Novato por "..priceTC1.." Tibia Coins. Voce aceita?", npc, creature)
				npcHandler:setTopic(playerId, 33)
			elseif npcHandler:getTopic(playerId) == 14 then
				npcHandler:say("Voce pode contratar um Mago Novato por "..priceTC1.." Tibia Coins. Voce aceita?", npc, creature)
				npcHandler:setTopic(playerId, 36)
			end
		else
			npcHandler:say("Voce precisa de nivel 250 ou superior para contratar um Mercenario Novato.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, 'veterano') then
		if player:getLevel() >= 250 then
			if npcHandler:getTopic(playerId) == 5 then
				npcHandler:say("Voce pode contratar um Guerreiro Veterano por "..price2.." gold coins. Voce aceita?", npc, creature)
				npcHandler:setTopic(playerId, 21)
			elseif npcHandler:getTopic(playerId) == 6 then
				npcHandler:say("Voce pode contratar um Atirador Veterano por "..price2.." gold coins. Voce aceita?", npc, creature)
				npcHandler:setTopic(playerId, 24)
			elseif npcHandler:getTopic(playerId) == 7 then
				npcHandler:say("Voce pode contratar um Mago Veterano por "..price2.." gold coins. Voce aceita?", npc, creature)
				npcHandler:setTopic(playerId, 27)
			elseif npcHandler:getTopic(playerId) == 12 then
				npcHandler:say("Voce pode contratar um Guerreiro Veterano por "..priceTC2.." Tibia Coins. Voce aceita?", npc, creature)
				npcHandler:setTopic(playerId, 31)
			elseif npcHandler:getTopic(playerId) == 13 then
				npcHandler:say("Voce pode contratar um Atirador Veterano por "..priceTC2.." Tibia Coins. Voce aceita?", npc, creature)
				npcHandler:setTopic(playerId, 34)
			elseif npcHandler:getTopic(playerId) == 14 then
				npcHandler:say("Voce pode contratar um Mago Veterano por "..priceTC2.." Tibia Coins. Voce aceita?", npc, creature)
				npcHandler:setTopic(playerId, 37)
			end
		else
			npcHandler:say("Voce precisa de nivel 500 ou superior para contratar um Mercenario Veterano.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, 'elite') then
		if player:getLevel() >= 800 then
			if npcHandler:getTopic(playerId) == 5 then
				npcHandler:say("Voce pode contratar um Guerreiro de Elite por "..price3.." gold coins. Voce aceita?", npc, creature)
				npcHandler:setTopic(playerId, 22)
			elseif npcHandler:getTopic(playerId) == 6 then
				npcHandler:say("Voce pode contratar um Atirador de Elite por "..price3.." gold coins. Voce aceita?", npc, creature)
				npcHandler:setTopic(playerId, 25)
			elseif npcHandler:getTopic(playerId) == 7 then
				npcHandler:say("Voce pode contratar um Mago de Elite por "..price3.." gold coins. Voce aceita?", npc, creature)
				npcHandler:setTopic(playerId, 28)
			elseif npcHandler:getTopic(playerId) == 12 then
				npcHandler:say("Voce pode contratar um Guerreiro de Elite por "..priceTC3.." Tibia Coins. Voce aceita?", npc, creature)
				npcHandler:setTopic(playerId, 32)
			elseif npcHandler:getTopic(playerId) == 13 then
				npcHandler:say("Voce pode contratar um Atirador de Elite por "..priceTC3.." Tibia Coins. Voce aceita?", npc, creature)
				npcHandler:setTopic(playerId, 35)
			elseif npcHandler:getTopic(playerId) == 14 then
				npcHandler:say("Voce pode contratar um Mago de Elite por "..priceTC3.." Tibia Coins. Voce aceita?", npc, creature)
				npcHandler:setTopic(playerId, 38)
			end
		else
			npcHandler:say("Voce precisa de nivel 800 ou superior para contratar um Mercenario de Elite.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, 'yes') or MsgContains(message, 'sim') then
		if npcHandler:getTopic(playerId) == 3 then
			if class == 1 then
				local mercenario = Game.createMonster("Guerreiro Mercenario", position)
				if mercenario then
					mercenario:setMaster(player)
					mercenario:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
					mercenario:changeSpeed(math.max(player:getSpeed() + ((player:getSpeed() / 10) + 20), 0))
					mercenario:setOutfit({lookType = looktype, lookHead = player:getOutfit().lookHead, lookBody = player:getOutfit().lookBody, lookLegs = player:getOutfit().lookLegs, lookFeet = player:getOutfit().lookFeet, lookAddons = 3 })
					mercenario:setMaxHealth(life)
					mercenario:setHealth(life)
					local condition = Condition(CONDITION_ATTRIBUTES)
					condition:setParameter(CONDITION_PARAM_TICKS, -1)
					condition:setParameter(CONDITION_PARAM_ABSORB_PHYSICALPERCENT, physRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_FIREPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_ICEPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_ENERGYPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_HOLYPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_DEATHPERCENT, eleRes)
					mercenario:addCondition(condition)
				end
			elseif class == 2 then
				local mercenario = Game.createMonster("Atirador Mercenario", position)
				if mercenario then
					mercenario:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
					mercenario:changeSpeed(math.max(player:getSpeed() + ((player:getSpeed() / 10) + 20), 0))
					mercenario:setOutfit({lookType = looktype, lookHead = player:getOutfit().lookHead, lookBody = player:getOutfit().lookBody, lookLegs = player:getOutfit().lookLegs, lookFeet = player:getOutfit().lookFeet, lookAddons = 3 })
					mercenario:setMaxHealth(life)
					mercenario:setHealth(life)
					mercenario:setMaster(player)
					local condition = Condition(CONDITION_ATTRIBUTES)
					condition:setParameter(CONDITION_PARAM_TICKS, -1)
					condition:setParameter(CONDITION_PARAM_ABSORB_PHYSICALPERCENT, physRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_FIREPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_ICEPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_ENERGYPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_HOLYPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_DEATHPERCENT, eleRes)
					mercenario:addCondition(condition)
				end
			elseif class == 3 then
				local mercenario = Game.createMonster("Mago Mercenario", position)
				if mercenario then
					mercenario:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
					mercenario:changeSpeed(math.max(player:getSpeed() + ((player:getSpeed() / 10) + 20), 0))
					mercenario:setOutfit({lookType = looktype, lookHead = player:getOutfit().lookHead, lookBody = player:getOutfit().lookBody, lookLegs = player:getOutfit().lookLegs, lookFeet = player:getOutfit().lookFeet, lookAddons = 3 })
					mercenario:setMaxHealth(life)
					mercenario:setHealth(life)
					mercenario:setMaster(player)
					local condition = Condition(CONDITION_ATTRIBUTES)
					condition:setParameter(CONDITION_PARAM_TICKS, -1)
					condition:setParameter(CONDITION_PARAM_ABSORB_PHYSICALPERCENT, physRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_FIREPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_ICEPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_ENERGYPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_HOLYPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_DEATHPERCENT, eleRes)
					mercenario:addCondition(condition)
				end	
			end
		elseif npcHandler:getTopic(playerId) == 8 then
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
			player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Active, 0)
			npcHandler:say("Muito bem. Contrato finaliazdo!", npc, creature)
			local summons = player:getSummons()
			for _, summon in ipairs(summons) do
				if summon:getName() == "Guerreiro Mercenario Novato" or summon:getName() == "Guerreiro Mercenario Veterano" or summon:getName() == "Guerreiro Mercenario Elite" or summon:getName() == "Atirador Mercenario Novato" or summon:getName() == "Atirador Mercenario Veterano" or summon:getName() == "Atirador Mercenario Elite" or summon:getName() == "Mago Mercenario Novato" or summon:getName() == "Mago Mercenario Veterano" or summon:getName() == "Mago Mercenario Elite" then
					summon:remove()
				end
			end
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 11 then
			if player:removeTransferableCoins(10) then
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
				player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Cooldown, os.time() + 24 * 60 * 60)
				npcHandler:say("Muito bem. Contrato renovado! Fale comigo se quiser convocar seu {mercenario}.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao possui Tibia Coins suficientes.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 41 then
			if player:removeTransferableCoins(15) then
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
				player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Cooldown, os.time() + 24 * 60 * 60)
				npcHandler:say("Muito bem. Contrato renovado! Fale comigo se quiser convocar seu {mercenario}.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao possui Tibia Coins suficientes.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 51 then
			if player:removeTransferableCoins(30) then
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
				player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Cooldown, os.time() + 24 * 60 * 60)
				npcHandler:say("Muito bem. Contrato renovado! Fale comigo se quiser convocar seu {mercenario}.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao possui Tibia Coins suficientes.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 20 then
			if player:removeMoneyBank(price1) then
				local mercLooktype = {143, 147}
				local randomLooktype = mercLooktype[math.random(1, #mercLooktype)]
				local addon = 3
				local mercenario = Game.createMonster("Guerreiro Mercenario", position)
				if mercenario then
					local eleRes = math.random(10, 15)
					local physRes = eleRes
					local realLife = math.random(4000, 5500)
					local damage = math.random(15, 19)
					mercenario:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
					mercenario:changeSpeed(math.max(player:getSpeed() + ((player:getSpeed() / 10) + 20), 0))
					mercenario:setOutfit({lookType = randomLooktype, lookHead = player:getOutfit().lookHead, lookBody = player:getOutfit().lookBody, lookLegs = player:getOutfit().lookLegs, lookFeet = player:getOutfit().lookFeet, lookAddons = 3 })
					mercenario:setMaxHealth(realLife)
					mercenario:setHealth(realLife)
					mercenario:setMaster(player)
					local condition = Condition(CONDITION_ATTRIBUTES)
					condition:setParameter(CONDITION_PARAM_TICKS, -1)
					condition:setParameter(CONDITION_PARAM_ABSORB_PHYSICALPERCENT, physRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_FIREPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_ICEPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_ENERGYPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_HOLYPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_DEATHPERCENT, eleRes)
					mercenario:addCondition(condition)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Active, 1)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage, damage)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Cooldown, os.time() + 24 * 60 * 60)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Class, 1)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Category, 1)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Life, realLife)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.ResPhys, physRes)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.ResElement, eleRes)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Looktype, randomLooktype)
					npcHandler:say("Aqui esta seu mercenario! Boa sorte e, se possivel, traga-o vivo para mim... Ha ha ha!", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			else
				npcHandler:say("Voce nao possui dinheiro o suficiente...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 21 then
			if player:removeMoneyBank(price2) then
				local mercLooktype = {142, 134}
				local randomLooktype = mercLooktype[math.random(1, #mercLooktype)]
				local addon = 3
				local mercenario = Game.createMonster("Guerreiro Mercenario", position)
				if mercenario then
					local eleRes = math.random(16, 20)
					local physRes = eleRes
					local realLife = math.random(6000, 9000)
					local damage = math.random(20, 28)
					mercenario:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
					mercenario:changeSpeed(math.max(player:getSpeed() + ((player:getSpeed() / 10) + 20), 0))
					mercenario:setOutfit({lookType = randomLooktype, lookHead = player:getOutfit().lookHead, lookBody = player:getOutfit().lookBody, lookLegs = player:getOutfit().lookLegs, lookFeet = player:getOutfit().lookFeet, lookAddons = 3 })
					mercenario:setMaxHealth(realLife)
					mercenario:setHealth(realLife)
					mercenario:setMaster(player)
					local condition = Condition(CONDITION_ATTRIBUTES)
					condition:setParameter(CONDITION_PARAM_TICKS, -1)
					condition:setParameter(CONDITION_PARAM_ABSORB_PHYSICALPERCENT, physRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_FIREPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_ICEPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_ENERGYPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_HOLYPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_DEATHPERCENT, eleRes)
					mercenario:addCondition(condition)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Active, 1)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage, damage)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Cooldown, os.time() + 24 * 60 * 60)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Class, 1)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Category, 2)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Life, realLife)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.ResPhys, physRes)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.ResElement, eleRes)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Looktype, randomLooktype)
					npcHandler:say("Aqui esta seu mercenario! Boa sorte e, se possivel, traga-o vivo para mim... Ha ha ha!", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			else
				npcHandler:say("Voce nao possui dinheiro o suficiente...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 22 then
			if player:removeMoneyBank(price3) then
				local mercLooktype = {512, 513}
				local randomLooktype = mercLooktype[math.random(1, #mercLooktype)]
				local addon = 3
				local mercenario = Game.createMonster("Guerreiro Mercenario", position)
				if mercenario then
					local eleRes = math.random(21, 25)
					local physRes = eleRes
					local realLife = math.random(10000, 13000)
					local damage = math.random(29, 35)
					mercenario:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
					mercenario:changeSpeed(math.max(player:getSpeed() + ((player:getSpeed() / 10) + 20), 0))
					mercenario:setOutfit({lookType = randomLooktype, lookHead = player:getOutfit().lookHead, lookBody = player:getOutfit().lookBody, lookLegs = player:getOutfit().lookLegs, lookFeet = player:getOutfit().lookFeet, lookAddons = 3 })
					mercenario:setMaxHealth(realLife)
					mercenario:setHealth(realLife)
					mercenario:setMaster(player)
					local condition = Condition(CONDITION_ATTRIBUTES)
					condition:setParameter(CONDITION_PARAM_TICKS, -1)
					condition:setParameter(CONDITION_PARAM_ABSORB_PHYSICALPERCENT, physRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_FIREPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_ICEPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_ENERGYPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_HOLYPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_DEATHPERCENT, eleRes)
					mercenario:addCondition(condition)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Active, 1)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage, damage)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Cooldown, os.time() + 24 * 60 * 60)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Class, 1)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Category, 3)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Life, realLife)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.ResPhys, physRes)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.ResElement, eleRes)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Looktype, randomLooktype)
					npcHandler:say("Aqui esta seu mercenario! Boa sorte e, se possivel, traga-o vivo para mim... Ha ha ha!", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			else
				npcHandler:say("Voce nao possui dinheiro o suficiente...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 23 then
			if player:removeMoneyBank(price1) then
				local mercLooktype = {137, 129}
				local randomLooktype = mercLooktype[math.random(1, #mercLooktype)]
				local addon = 3
				local mercenario = Game.createMonster("Atirador Mercenario", position)
				if mercenario then
					local physRes = math.random(8, 12)
					local eleRes = math.random(5, 8)
					local realLife = math.random(3000, 4000)
					local damage = math.random(21, 29)
					mercenario:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
					mercenario:changeSpeed(math.max(player:getSpeed() + ((player:getSpeed() / 10) + 20), 0))
					mercenario:setOutfit({lookType = randomLooktype, lookHead = player:getOutfit().lookHead, lookBody = player:getOutfit().lookBody, lookLegs = player:getOutfit().lookLegs, lookFeet = player:getOutfit().lookFeet, lookAddons = 3 })
					mercenario:setMaxHealth(realLife)
					mercenario:setHealth(realLife)
					mercenario:setMaster(player)
					local condition = Condition(CONDITION_ATTRIBUTES)
					condition:setParameter(CONDITION_PARAM_TICKS, -1)
					condition:setParameter(CONDITION_PARAM_ABSORB_PHYSICALPERCENT, physRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_FIREPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_ICEPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_ENERGYPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_HOLYPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_DEATHPERCENT, eleRes)
					mercenario:addCondition(condition)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Active, 1)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage, damage)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Cooldown, os.time() + 24 * 60 * 60)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Class, 2)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Category, 1)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Life, realLife)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.ResPhys, physRes)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.ResElement, eleRes)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Looktype, randomLooktype)
					npcHandler:say("Aqui esta seu mercenario! Boa sorte e, se possivel, traga-o vivo para mim... Ha ha ha!", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			else
				npcHandler:say("Voce nao possui dinheiro o suficiente...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 24 then
			if player:removeMoneyBank(price2) then
				local mercLooktype = {1618, 1619}
				local randomLooktype = mercLooktype[math.random(1, #mercLooktype)]
				local addon = 3
				local mercenario = Game.createMonster("Atirador Mercenario", position)
				if mercenario then
					local physRes = math.random(13, 16)
					local eleRes = math.random(9, 11)
					local realLife = math.random(4500, 6000)
					local damage = math.random(30, 40)
					mercenario:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
					mercenario:changeSpeed(math.max(player:getSpeed() + ((player:getSpeed() / 10) + 20), 0))
					mercenario:setOutfit({lookType = randomLooktype, lookHead = player:getOutfit().lookHead, lookBody = player:getOutfit().lookBody, lookLegs = player:getOutfit().lookLegs, lookFeet = player:getOutfit().lookFeet, lookAddons = 3 })
					mercenario:setMaxHealth(realLife)
					mercenario:setHealth(realLife)
					mercenario:setMaster(player)
					local condition = Condition(CONDITION_ATTRIBUTES)
					condition:setParameter(CONDITION_PARAM_TICKS, -1)
					condition:setParameter(CONDITION_PARAM_ABSORB_PHYSICALPERCENT, physRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_FIREPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_ICEPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_ENERGYPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_HOLYPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_DEATHPERCENT, eleRes)
					mercenario:addCondition(condition)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Active, 1)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage, damage)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Cooldown, os.time() + 24 * 60 * 60)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Class, 2)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Category, 2)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Life, realLife)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.ResPhys, physRes)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.ResElement, eleRes)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Looktype, randomLooktype)
					npcHandler:say("Aqui esta seu mercenario! Boa sorte e, se possivel, traga-o vivo para mim... Ha ha ha!", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			else
				npcHandler:say("Voce nao possui dinheiro o suficiente...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 25 then
			if player:removeMoneyBank(price3) then
				local mercLooktype = {1102, 1103}
				local randomLooktype = mercLooktype[math.random(1, #mercLooktype)]
				local addon = 3
				local mercenario = Game.createMonster("Atirador Mercenario", position)
				if mercenario then
					local physRes = math.random(17, 20)
					local eleRes = math.random(12, 15)
					local realLife = math.random(6500, 8000)
					local damage = math.random(41, 50)
					mercenario:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
					mercenario:changeSpeed(math.max(player:getSpeed() + ((player:getSpeed() / 10) + 20), 0))
					mercenario:setOutfit({lookType = randomLooktype, lookHead = player:getOutfit().lookHead, lookBody = player:getOutfit().lookBody, lookLegs = player:getOutfit().lookLegs, lookFeet = player:getOutfit().lookFeet, lookAddons = 3 })
					mercenario:setMaxHealth(realLife)
					mercenario:setHealth(realLife)
					mercenario:setMaster(player)
					local condition = Condition(CONDITION_ATTRIBUTES)
					condition:setParameter(CONDITION_PARAM_TICKS, -1)
					condition:setParameter(CONDITION_PARAM_ABSORB_PHYSICALPERCENT, physRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_FIREPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_ICEPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_ENERGYPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_HOLYPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_DEATHPERCENT, eleRes)
					mercenario:addCondition(condition)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Active, 1)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage, damage)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Cooldown, os.time() + 24 * 60 * 60)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Class, 2)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Category, 3)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Life, realLife)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.ResPhys, physRes)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.ResElement, eleRes)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Looktype, randomLooktype)
					npcHandler:say("Aqui esta seu mercenario! Boa sorte e, se possivel, traga-o vivo para mim... Ha ha ha!", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			else
				npcHandler:say("Voce nao possui dinheiro o suficiente...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 26 then
			if player:removeMoneyBank(price1) then
				local mercLooktype = {141, 133}
				local randomLooktype = mercLooktype[math.random(1, #mercLooktype)]
				local addon = 3
				local mercenario = Game.createMonster("Mago Mercenario", position)
				if mercenario then
					local physRes = math.random(4, 7)
					local eleRes = math.random(11, 16)
					local realLife = math.random(2800, 3500)
					local damage = math.random(25, 29)
					mercenario:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
					mercenario:changeSpeed(math.max(player:getSpeed() + ((player:getSpeed() / 10) + 20), 0))
					mercenario:setOutfit({lookType = randomLooktype, lookHead = player:getOutfit().lookHead, lookBody = player:getOutfit().lookBody, lookLegs = player:getOutfit().lookLegs, lookFeet = player:getOutfit().lookFeet, lookAddons = 3 })
					mercenario:setMaxHealth(realLife)
					mercenario:setHealth(realLife)
					mercenario:setMaster(player)
					local condition = Condition(CONDITION_ATTRIBUTES)
					condition:setParameter(CONDITION_PARAM_TICKS, -1)
					condition:setParameter(CONDITION_PARAM_ABSORB_PHYSICALPERCENT, physRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_FIREPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_ICEPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_ENERGYPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_HOLYPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_DEATHPERCENT, eleRes)
					mercenario:addCondition(condition)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Active, 1)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage, damage)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Cooldown, os.time() + 24 * 60 * 60)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Class, 3)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Category, 1)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Life, realLife)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.ResPhys, physRes)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.ResElement, eleRes)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Looktype, randomLooktype)
					npcHandler:say("Aqui esta seu mercenario! Boa sorte e, se possivel, traga-o vivo para mim... Ha ha ha!", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			else
				npcHandler:say("Voce nao possui dinheiro o suficiente...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 27 then
			if player:removeMoneyBank(price2) then
				local mercLooktype = {149, 145}
				local randomLooktype = mercLooktype[math.random(1, #mercLooktype)]
				local addon = 3
				local mercenario = Game.createMonster("Mago Mercenario", position)
				if mercenario then
					local physRes = math.random(7, 9)
					local eleRes = math.random(16, 20)
					local realLife = math.random(3500, 5000)
					local damage = math.random(30, 38)
					mercenario:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
					mercenario:changeSpeed(math.max(player:getSpeed() + ((player:getSpeed() / 10) + 20), 0))
					mercenario:setOutfit({lookType = randomLooktype, lookHead = player:getOutfit().lookHead, lookBody = player:getOutfit().lookBody, lookLegs = player:getOutfit().lookLegs, lookFeet = player:getOutfit().lookFeet, lookAddons = 3 })
					mercenario:setMaxHealth(realLife)
					mercenario:setHealth(realLife)
					mercenario:setMaster(player)
					local condition = Condition(CONDITION_ATTRIBUTES)
					condition:setParameter(CONDITION_PARAM_TICKS, -1)
					condition:setParameter(CONDITION_PARAM_ABSORB_PHYSICALPERCENT, physRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_FIREPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_ICEPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_ENERGYPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_HOLYPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_DEATHPERCENT, eleRes)
					mercenario:addCondition(condition)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Active, 1)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage, damage)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Cooldown, os.time() + 24 * 60 * 60)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Class, 3)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Category, 2)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Life, realLife)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.ResPhys, physRes)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.ResElement, eleRes)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Looktype, randomLooktype)
					npcHandler:say("Aqui esta seu mercenario! Boa sorte e, se possivel, traga-o vivo para mim... Ha ha ha!", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			else
				npcHandler:say("Voce nao possui dinheiro o suficiente...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 28 then
			if player:removeMoneyBank(price3) then
				local mercLooktype = {1385, 1384}
				local randomLooktype = mercLooktype[math.random(1, #mercLooktype)]
				local addon = 3
				local mercenario = Game.createMonster("Mago Mercenario", position)
				if mercenario then
					local physRes = math.random(10, 13)
					local eleRes = math.random(21, 25)
					local realLife = math.random(3500, 5000)
					local damage = math.random(39, 45)
					mercenario:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
					mercenario:changeSpeed(math.max(player:getSpeed() + ((player:getSpeed() / 10) + 20), 0))
					mercenario:setOutfit({lookType = randomLooktype, lookHead = player:getOutfit().lookHead, lookBody = player:getOutfit().lookBody, lookLegs = player:getOutfit().lookLegs, lookFeet = player:getOutfit().lookFeet, lookAddons = 3 })
					mercenario:setMaxHealth(realLife)
					mercenario:setHealth(realLife)
					mercenario:setMaster(player)
					local condition = Condition(CONDITION_ATTRIBUTES)
					condition:setParameter(CONDITION_PARAM_TICKS, -1)
					condition:setParameter(CONDITION_PARAM_ABSORB_PHYSICALPERCENT, physRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_FIREPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_ICEPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_ENERGYPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_HOLYPERCENT, eleRes)
					condition:setParameter(CONDITION_PARAM_ABSORB_DEATHPERCENT, eleRes)
					mercenario:addCondition(condition)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Active, 1)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage, damage)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Cooldown, os.time() + 24 * 60 * 60)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Class, 3)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Category, 3)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Life, realLife)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.ResPhys, physRes)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.ResElement, eleRes)
					player:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Looktype, randomLooktype)
					npcHandler:say("Aqui esta seu mercenario! Boa sorte e, se possivel, traga-o vivo para mim... Ha ha ha!", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			else
				npcHandler:say("Voce nao possui dinheiro o suficiente...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end

	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. Espero que goste dos meus {mercenarios}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus, |PLAYERNAME|.")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcType:addDialogOptions("bye")
npcType:register(npcConfig)
