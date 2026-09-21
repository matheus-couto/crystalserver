local internalNpcName = "Zoltan"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 130,
	lookHead = 95,
	lookBody = 94,
	lookLegs = 95,
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


	-- The paradox tower quest
	if MsgContains(message, "yenny the gentle") then
		npcHandler:say("Ah, Yenny, a Gentil, foi uma das fundadoras da ordem druida chamada Crunor's Caress, que se originou em sua cidade natal, Carlin.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "crunors caress") then
		if player:getStorageValue(Storage.Quest.U7_24.TheParadoxTower.TheFearedHugo) == 1 then
			-- Questlog: The Feared Hugo (Padreia)
			player:setStorageValue(Storage.Quest.U7_24.TheParadoxTower.TheFearedHugo, 2)
		end
		npcHandler:say("Eles eram uma ordem de druidas bastante esoterica, ate onde sabemos. Nao tenho conhecimento mais esclarecedor sobre eles.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "kozlon") or MsgContains(message, "documentos") or MsgContains(message, "carta") or MsgContains(message, "documents") or MsgContains(message, "letter") or MsgContains(message, "mission") or MsgContains(message, "missao") then
		if player:getStorageValue(Storage.Quest.Crandoria.WarlocksConspiracy.Progresso) == 2 then
			if player:getItemCount(348) >= 1 then
				player:setStorageValue(Storage.Quest.Crandoria.WarlocksConspiracy.Progresso, 3)
				npcHandler:say("O que seria esse documento que voce... espere um pouco... isso nao pode ser o que parece ser! Espero que nao tenha mostrado isso a mais ninguem. \z
				Olha, eu acredito no conteudo desse documento. Kozlon foi um grande amigo ha muito tempo e sei que ele sempre foi bom. Mas eu nao posso tomar nenhuma decisao. \z
				Se quiser posso te dar um item como simbolo da minha aprovacao para que voces possam entrar no local, mas para isso precisarei de algo em troca. Nada demais. Apenas \z
				10 dragonfruits e 25 pineapples, para algumas pocoes. Voce conseguira esses frutos cultivando em Astralis. Volte quando estiver com tudo. E NAO PERCA O DOCUMENTO!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Eu sinto muito, mas se nao tiver algo palpavel com voce, nao posso acreditar em nada que diz sobre isso.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif player:getStorageValue(Storage.Quest.Crandoria.WarlocksConspiracy.Progresso) == 3 then
			npcHandler:say("Conseguiu as 10 dragonfuits e 25 pineapples?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif player:getStorageValue(Storage.Quest.Crandoria.WarlocksConspiracy.Progresso) == 4 then
			npcHandler:say("Leve o documento e minha pena magica para Spectulus e explique para ele toda a situacao com os Warlocks. Sei que ele vai entender.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
		if npcHandler:getTopic(playerId) == 1 then
			if player:getItemCount(11682) >= 10 and player:getItemCount(11460) >= 25 then
				player:removeItem(11682, 10)
				player:removeItem(11459, 25)
				npcHandler:say("Otimo! Realmente muito bom. Aqui esta, enregue essa pena magica para Spectulus juntamente ao documento que voce possui e ele sabera que tem minha aprovacao. \z
				Entregue tudo a ele e diga {warlocks}. Isso vai chamar sua atencao. Te desejo muita sorte e estarei torcendo para que voces consigam deter Zarabastan de uma vez por todas!", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.WarlocksConspiracy.Progresso, 4)
				player:addItem(43894, 1)
			else
				npcHandler:say("Desculpe, mas voce nao possui tudo o que eu pedi. Sao 10 dragonfruits e 25 pineapples. Retorne quando estiver com tudo.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end
	return true
end

-- Female Summoner and Male Mage Hat Addon (needs to be rewritten)
local hatKeyword = keywordHandler:addKeyword({'proof'}, StdModule.say, {npcHandler = npcHandler, text = '... I cannot believe my eyes. You retrieved this hat from Ferumbras\' remains? That is incredible. If you give it to me, I will grant you the right to wear this hat as addon. What do you say?'},
		function(player) return not player:hasOutfit(player:getSex() == PLAYERSEX_FEMALE and 141 or 130, 2) end
	)
	hatKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Sorry you don\'t have the Ferumbras\' hat.'}, function(player) return player:getItemCount(5903) == 0 end)
	hatKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'I bow to you, player, and hereby grant you the right to wear Ferumbras\' hat as accessory. Congratulations!'}, nil,
		function(player)
			player:removeItem(5903, 1)
			player:addOutfitAddon(141, 2)
			player:addOutfitAddon(130, 2)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
		end
	)
	-- hatKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = ''})

keywordHandler:addKeyword({'myra'}, StdModule.say, {npcHandler = npcHandler,
	text = {
		'Bah, I know. I received some sort of \'nomination\' from our outpost in Port Hope. ...',
		'Usually it takes a little more than that for an award though. However, I honour Myra\'s word. ...',
		'I hereby grant you the right to wear a special sign of honour, acknowledged by the academy of Edron. Since you are a man, I guess you don\'t want girlish stuff. There you go.'
	}},
	function(player) return player:getStorageValue(Storage.Quest.U7_8.MageAndSummonerOutfits.AddonHatCloak) == 10 end,
	function(player)
		player:addOutfitAddon(138, 2)
		player:addOutfitAddon(133, 2)
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		player:setStorageValue(Storage.Quest.U7_8.MageAndSummonerOutfits.AddonHatCloak, 11)
		player:setStorageValue(Storage.Quest.U7_8.MageAndSummonerOutfits.MissionHatCloak, 0)
		player:setStorageValue(Storage.Quest.U7_8.OutfitQuest.Ref, math.min(0, player:getStorageValue(Storage.Quest.U7_8.OutfitQuest.Ref) - 1))
	end
)

keywordHandler:addKeyword({'myra'}, StdModule.say, {npcHandler = npcHandler, text = 'Stop bothering me. I am a far too busy man to be constantly giving out awards.'}, function(player) return player:getStorageValue(Storage.Quest.U7_8.MageAndSummonerOutfits.AddonHatCloak) == 11 end)
keywordHandler:addKeyword({'myra'}, StdModule.say, {npcHandler = npcHandler, text = 'What the hell are you talking about?'})

npcHandler:setMessage(MESSAGE_GREET, 'Saudacoes |PLAYERNAME|, estudante das artes arcanas.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Use your knowledge wisely, |PLAYERNAME|.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
