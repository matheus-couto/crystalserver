local internalNpcName = "Dedoras"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 1

npcConfig.outfit = {
	lookType = 146,
	lookHead = 76,
	lookBody = 57,
	lookLegs = 78,
	lookFeet = 77,
	lookAddons = 2
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
		if player:getLevel() < 250 then
			npcHandler:say("Me desculpe, mas nao posso ajudar jogadores pouco experientes. Volte quando tiver nivel 250 ou maior.", npc, creature) -- It needs to be revised, it's not the same as the global
			npcHandler:setTopic(playerId, 0)
		else
			if player:getStorageValue(Storage.Quest.Crandoria.BattleMageOutfits.Outfit) < 1 then
				npcHandler:say("Otimo! Eu sabia que voce nao escaparia do seu verdadeiro destino! Passando pelo portal voce entrara na Bibioteca Secreta. La dentro ha cinco terriveis monstros que tomaram conta do lugar e assolam a vida de todos que tentam acessar o local. Mate-os e eu te darei uma recompensa!", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.BattleMageOutfits.Outfit, 1)
				npcHandler:setTopic(playerId, 0)
			elseif player:getStorageValue(Storage.Quest.Crandoria.BattleMageOutfits.Outfit) == 1 then
				if player:getStorageValue(Storage.Quest.U11_80.TheSecretLibrary.ScourgeOfOblivionDoor) > 0 then
					npcHandler:say("Sensacional! Nao acredito que alguem realmente conseguiu derrotar todos eles! Aqui esta, como agradecimento vou te dar o meu traje de batalha. Com ele voce podera lutar e se movimentar rapidamente enquanto utiliza suas magias.", npc, creature)
					player:addOutfit(1069, 0)
					player:addOutfit(1070, 0)
					local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
					player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
					player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
					player:setStorageValue(Storage.Quest.Crandoria.BattleMageOutfits.Outfit, 2)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say({"Esta tentando me colocar em perigo? Por favor, volte apenas quando todos os cinco monstros tiverem sido derrotados!"}, npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			elseif player:getStorageValue(Storage.Quest.Crandoria.BattleMageOutfits.Outfit) == 2 then
				npcHandler:say({"Para o primeiro aprimoramento do seu traje de mago de batalha voce precisara me trazer Sturdy Books. Esses livros sao muito importantes e valiosos para colecionadores. Traga-me 5 deles e eu irei aprimorar seu traje."}, npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.BattleMageOutfits.Outfit, 3)
				npcHandler:setTopic(playerId, 0)
			elseif player:getStorageValue(Storage.Quest.Crandoria.BattleMageOutfits.Outfit) == 3 then
				npcHandler:say({"Posso aprimorar seus trajes agora mesmo. Voce trouxe os 5 Sturdy Books?"}, npc, creature)
				npcHandler:setTopic(playerId, 1)
			elseif player:getStorageValue(Storage.Quest.Crandoria.BattleMageOutfits.Outfit) == 4 then
				npcHandler:say({"Para o ultimo aprimoramento do seu traje dos magos de batalha, eu vou precisar de 20 Epaulletes. Voce pode conseguir esses itens dos mesmos monstros que voce me ajudou a derrotar anteriormente. Boa sorte!"}, npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.BattleMageOutfits.Outfit, 5)
				npcHandler:setTopic(playerId, 0)
			elseif player:getStorageValue(Storage.Quest.Crandoria.BattleMageOutfits.Outfit) == 5 then
				npcHandler:say({"Posso aprimorar seus trajes agora mesmo. Voce trouxe os 20 Epaulettes?"}, npc, creature)
				npcHandler:setTopic(playerId, 2)
			elseif player:getStorageValue(Storage.Quest.Crandoria.BattleMageOutfits.Outfit) >= 6 then
				npcHandler:say({"Nao tenho mais nenhuma missao para te oferecer agora."}, npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	elseif (MsgContains(message, "sim") or MsgContains(message, "yes")) then
		if npcHandler:getTopic(playerId) == 1 then
			if player:getItemCount(28792) >= 5 then
				player:removeItem(28792, 5)
				player:addOutfitAddon(1069, 1)
				player:addOutfitAddon(1070, 1)
				local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
				player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
				player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
				player:setStorageValue(Storage.Quest.Crandoria.BattleMageOutfits.Outfit, 4)
				npcHandler:say({"Muito bom... muito bom mesmo... Agradeco muito pelo tesour... digo, pelos livros! Como combinado, seus trajes foram aprimorados!"}, npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say({"Eu nao sei o que voce tem ai, mas com certeza nao sao os Sturdy Books que eu pedi."}, npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 2 then
			if player:getItemCount(28793) >= 20 then
				player:removeItem(28793, 20)
				player:addOutfitAddon(1069, 2)
				player:addOutfitAddon(1070, 2)
				local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
				player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
				player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
				player:setStorageValue(Storage.Quest.Crandoria.BattleMageOutfits.Outfit, 6)
				npcHandler:say({"Execlente! Aqui esta, seu novo traje totalmente aprimorado. Agora voce esta identico a um poderoso mago de batalha! Muito obrigado pela ajuda."}, npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say({"Eu nao sei o que voce tem ai, mas com certeza nao sao os Epaulettes que eu pedi."}, npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end
end

npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. O que faz por aqui?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais e boa sorte!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)

