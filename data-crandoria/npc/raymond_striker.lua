local internalNpcName = "Raymond Striker"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 151,
	lookHead = 39,
	lookBody = 77,
	lookLegs = 98,
	lookFeet = 95,
	lookAddons = 1
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

    if MsgContains(message, "outfit") then
		if player:getStorageValue(Storage.Quest.U7_8.OutfitQuest.PirateBaseOutfit) <= 1 then
			npcHandler:say("HA! Eu sabia! Alguem que sempre sonhou em ser um pirata, nao e mesmo? Hickup! Eu posso te arrumar uns trapos de piratas, claro... Mas em troca quero um pagamento justo. Digamos... 10 Gold Tokens e uma Giant Sappfire. Voce tem esses itens com voce?", npc, creature)
			player:setStorageValue(Storage.Quest.U7_8.OutfitQuest.PirateBaseOutfit, 1)
			npcHandler:setTopic(playerId, 1)
		elseif player:getStorageValue(Storage.Quest.U7_8.OutfitQuest.PirateBaseOutfit) > 1 then
			npcHandler:say("Voce ja tem roupas de um desonrado pirata. Nao posso te ajudar com mais nada! Hickup!", npc, creature)
        	npcHandler:setTopic(playerId, 0)
		end
    elseif MsgContains(message, "yes") then
		if player:getStorageValue(Storage.Quest.U7_8.OutfitQuest.PirateBaseOutfit) == 1 and npcHandler:getTopic(playerId) == 1 then
			if player:getItemCount(22721) >= 10 and player:getItemCount(30061) >= 1 then
					npcHandler:say("Ora, ora... Olha o que temos aqui. Bom, como combinado, aqui estao suas novas roupas. Agora voce esta a poucos passos de se tornar um verdadeiro pirata! Ha ha ha...", npc, creature)
				player:removeItem(22721, 10)
				player:removeItem(30061, 1)
				player:addOutfit(151)
				player:addOutfit(155)
				local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
				player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
				player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
				player:setStorageValue(Storage.Quest.U7_8.OutfitQuest.PirateBaseOutfit, 2)
					npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Parece que voce nao entendeu o que eu preciso. Sao 10 Gold Tokens e 1 Giant Sapphire. Traga tudo pra mim e te darei suas roupas de pirata.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end
end


npcHandler:setMessage(MESSAGE_GREET, "Be greeted. A pirate is a pirate, and nothing else. Are you lost here or are you looking for a new {outfit}, aye?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Oh well.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
