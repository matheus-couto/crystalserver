local internalNpcName = "Awarness Of The Emperor"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 231
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

local function greetCallback(npc, creature)
	if Player(creature):getStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Questline) < 31 then
		npcHandler:setMessage(MESSAGE_GREET, "Nao estou aqui para lutar com voce, tolo. Goste ou nao, teremos que trabalhar juntos para impedir a catastrofe que voce e aquele sacerdote iniciaram.")
	else
		npcHandler:setMessage(MESSAGE_GREET, "Saudacoes, mortal. Cuidado para nao abusar da minha paciencia enquanto estiver diante de mim.")
	end
	return true
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "mission") or MsgContains(message, "missao") then
		local player = Player(creature)
		if player:getStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Questline) == 30 and player:getStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.BossStatus) == 5 then
			npcHandler:say({
				"A forca amplificada do deus serpente esta destruindo estas terras. Ele esta usando meus cristais de forma invertida para drenar a energia vital da terra e de todos os seus habitantes, alimentando seu proprio poder. ...",
				"Farei o possivel para resistir a sua influencia e retardar esse processo. Porem, cabera a voce enfrentar sua encarnacao neste mundo. ...",
				"Ele ainda esta fraco e desorientado. Talvez voce tenha uma chance... esta e nossa unica oportunidade. Vou envia-lo para o local onde a energia vital esta sendo canalizada. Infelizmente, nao sei exatamente onde isso fica. ...",
				"Voce provavelmente tera que enfrentar algum tipo de receptaculo usado pelo deus serpente. Mesmo que consiga derrota-lo, isso provavelmente apenas enfraquecera a serpente. ...",
				"Talvez seja necessario derrotar varias encarnacoes ate que o deus serpente esteja enfraquecido o suficiente. Entao use o poder do proprio cetro da serpente contra ela. Use-o sobre seu corpo para conquistar sua vitoria. ...",
				"Prepare-se para a batalha de sua vida! Voce esta pronto?"
			}, npc, creature)
			npcHandler:setTopic(playerId, 1)

		elseif player:getStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Questline) == 32 then
			npcHandler:say({
				"Entao voce conseguiu superar a crise que provocou com sua propria imprudencia. Eu deveria destrui-lo aqui e agora por seu envolvimento. ...",
				"Mas agir dessa forma me colocaria no mesmo nivel barbaro que o seu e apenas alimentaria a corrupcao que esta destruindo as terras que governo. Por isso, nao apenas pouparei sua miseravel vida, como tambem demonstrarei a generosidade do Imperador Dragao. ...",
				"Eu o recompensarei muito alem dos seus maiores sonhos! ...",
				"Concedo a voce tres baus repletos de moedas de platina, uma casa na cidade para viver, um conjunto das melhores armaduras que Zao pode oferecer e um cofre contendo mana inesgotavel. ...",
				"Fale com o magistrado Izsh no ministerio para receber sua recompensa. Agora va embora, antes que eu mude de ideia!"
			}, npc, creature)

			player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.TeleportAccess.SleepingDragon, 2)
			player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Questline, 33)
			player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission12, 0) -- Questlog, Wrath of the Emperor "Mission 12: Just Rewards"
		end
	elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
		if npcHandler:getTopic(playerId) == 1 then
			local player = Player(creature)
			player:teleportTo(Position(4938, 4580, 12))
			player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.TeleportAccess.AwarnessEmperor, 1)
			player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.TeleportAccess.Wote10, 1)
			player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.TeleportAccess.BossRoom, 1)
			player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Questline, 31)
			player:addItem(11362, 1)
			player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission11, 1) --Questlog, Wrath of the Emperor "Mission 11: Payback Time"
			npcHandler:say("Que assim seja!", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
