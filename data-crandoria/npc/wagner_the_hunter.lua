local internalNpcName = "Wagner The Hunter"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 129,
	lookHead = 95,
	lookBody = 114,
	lookLegs = 55,
	lookFeet = 26,
	lookAddons = 3,
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
		if player:getStorageValue(Storage.Quest.U10_80.Grimvale.MissaoWagner) < 1 then
			npcHandler:say("Como voce pode ver, essa ilha esta tomada por monstros sanguinarios. Ha muito tempo estive buscando por formas de derrota-los e descobri algo interessante... \z
			Eles respondem a criaturas que eu chamo de 'mestres'. Eles sao 5, no total, e vivem nas profundezas das cavernas desta pequena ilha. \z
			Preciso de alguem que me ajude a derrota-los. Voce acha que da conta dessa missao?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif player:getStorageValue(Storage.Quest.U10_80.Grimvale.MissaoWagner) == 1 then
			npcHandler:say("Voce conseguiu os 5 Honeycombs e 5 Holy Orchids?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		elseif player:getStorageValue(Storage.Quest.U10_80.Grimvale.MissaoWagner) == 2 then
			npcHandler:say("Pergunte a Filandrel sobre o terceiro ingrediente do elixir.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.U10_80.Grimvale.MissaoWagner) == 3 then
			npcHandler:say("Frosty Hearts? Mesmo? Eu jamais imaginaria... Com certeza eu nao serviria para ser um alquimista. Ha ha ha! Voce trouxe os Frosty Hearts com voce?", npc, creature)
			npcHandler:setTopic(playerId, 3)
		elseif player:getStorageValue(Storage.Quest.U10_80.Grimvale.MissaoWagner) == 4 then
			npcHandler:say("Nao tenho mais missoes para voce.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Hum... nao senti muita firmeza em sua resposta, mas tudo bem. Preste atencao: Se conseguir passar pelos monstros, encontrara facilmente seus abrigos. \z
			Mas ha um problema: Uma maldicao impede que as pessoas passem pelos portais que levam ate esses 'mestres'. Filandrel, em Astralis, estava me ajudando a fazer um elixir para isso. \z
			De acordo com ele, seriam necessarios tres ingredientes, mas ele so me falou sobre dois deles: 5 Honeycombs e 5 Holy Orchids. Por favor, traga-os para mim.", npc, creature)
			player:setStorageValue(Storage.Quest.U10_80.Grimvale.MissaoWagner, 1)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 2 then
			if player:getItemCount(5902) >= 5 and player:getItemCount(5922) >= 5 then
				player:removeItem(5902, 5)
				player:removeItem(5922, 5)
				npcHandler:say("Muito bom! Estamos quase la. Porem, como eu te disse, Filandrel nao havia me dito qual seria o terceiro ingrediente. Na verdade nem ele mesmo sabia... \z
				Por favor, me ajude com isso. Va ate Astralis e pergunte a filandrel sobre o elixir. Estarei te esperando.", npc, creature)
				player:setStorageValue(Storage.Quest.U10_80.Grimvale.MissaoWagner, 2)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao possui os itens.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 3 then
			if player:getItemCount(9661) >= 3 then
				player:removeItem(9661, 3)
				player:addExperience(1000000)
				player:addItem(637, 1)
				player:addItem(637, 1)
				player:say("Gulp.", TALKTYPE_MONSTER_SAY)
				npcHandler:say("Otimo! Macera, macera, macera... agua... E aqui esta! Um, dois, tres... E VIRA! Otimo. Agora voce conseguira passar pelos portais e enfrentar aquelas criaturas malditas. \z
				Nao precisa retornar ao terminar, ja te darei sua recompensa agora mesmo. Faca bom uso.", npc, creature)
				player:setStorageValue(Storage.Quest.U10_80.Grimvale.MissaoWagner, 4)
			else
				npcHandler:say("Voce nao possui os itens.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
    end

end

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)


npcConfig.shop = {
	{ name = "closed silvered trap", clientId = 22074, buy = 8000 },


}


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

npcHandler:setMessage(MESSAGE_GREET, "Ola, jovem viajante. Vendo armadilhas para derrotar a Feroxa em troca de Silver Tokens. Se quiser comprar alguma, basta dizer {trade}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcType:addDialogOptions("bye")
npcType:register(npcConfig)