local internalNpcName = "Alice"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookTypeEx = 694
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

    if MsgContains(message, "ajuda") or MsgContains(message, "help") or MsgContains(message, "mission") or MsgContains(message, "missao") then
		if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) == 5 then
			npcHandler:say("Aquele remedio que voce conseguiu com a bruxa do pantano realmene me ajudou muito. Estou lembrando cada vez mais do que me ocorreu aquele dia. \z
			Ainda estou um pouco confusa sobre algumas coisas, mas me lembro que havia um coelho branco e... Havia uma rainha. E alguem roubou meu... MEU {TESOURO}!", npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) == 6 then
				npcHandler:say("Por favor, recupere minha boneca. Aquela boneca representa tudo para mim...", npc, creature)
				npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) == 16 then
			if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Coelho) == 2 then
				if player:removeItem(25981, 1) then
					npcHandler:say("Minha boneca!! Eu nao acredito. Muito obrigada! Voce realmente me deixou muito contente. Por favor, aceite esse presente como recompensa. Eu peguei quando estive naquele lugar. Espero que sirva de algo.", npc, creature)
					player:addItem(35909, 1, true)
					player:addExperience(player:getLevel() * 25000, true)
					player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Coelho, 3)
					player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress, 17)
					player:addOutfitAddon(575, 2)
					player:addOutfitAddon(574, 2)
					local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                    player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 28)
                    player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Por favor, recupere minha boneca. Aquela boneca representa tudo para mim...", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			end
		end
	elseif MsgContains(message, "tesouro") or MsgContains(message, "treasure") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say({"Um dia eu estava andando pela plantacao de trigo quando avistei um coelho branco correndo entre as plantas. Ao me aproximar reparei que ele estava segurando uma das bonecas que eu estava fazendo! ...",
			"Uma muito importante para mim. Meu tesouro mais precioso... E, bom... Ao notar a boneca corri atras do coelho e acabei caindo dentro de um {buraco}, no meio da plantaco. Nao me lembro de muita coisa alem disso. ...",
			"Eu sei que voce ja me ajudou muito, mas voce poderia tentar recuperar a minha boneca?"}, npc, creature)
			npcHandler:setTopic(playerId, 2)
		end
	elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
		if npcHandler:getTopic(playerId) == 2 then
			npcHandler:say("Oba! Sabia que poderia contar com alguem forte como voce. Nao sera dificil achar o buraco do coelho. Hoje a plantacao de trigo de Crandoria esta muito menor que na epoca em que tudo aconteceu. \z
			De qualquer forma, te desejo muita sorte. Obrigada!!", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress, 6)
		end
	elseif MsgContains(message, "hole") or MsgContains(message, "buraco") then
		if npcHandler:getTopic(playerId) == 2 then
			npcHandler:say("O buraco estava no..  meio... *cof cof*... de uma plantacao de uma plantacao de trigo... \z
			Eu sei que voce ja me ajudou muito, mas voce poderia tentar recuperar a minha boneca?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		end
	end


end


npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. Obrigada pela {ajuda}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais e muito obrigada!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
