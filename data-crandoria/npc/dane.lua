local internalNpcName = "Dane"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 140,
	lookHead = 95,
	lookBody = 97,
	lookLegs = 114,
	lookFeet = 96,
	lookAddons = 3
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

local accessedIPs = {}

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()
	local playerIP = player:getIp()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

	local storageAposta = player:getStorageValue(Storage.Quest.Crandoria.Aposta.Active)
	local apostaDay = player:getStorageValue(Storage.Quest.Crandoria.Aposta.Day)
	local apostaValor = Game.getStorageValue(GlobalStorage.Crandoria.Apostas.Value)
	local apostaDiaria = Game.getStorageValue(GlobalStorage.Crandoria.Apostas.Day)
	local now = os.date("*t")
    local day = now.day
	local hour = tonumber(os.date("%H"))

	if apostaValor < 1 then
		apostaValor = 0
	end

    if MsgContains(message, "aposta") then
		if accessedIPs[playerIP] and accessedIPs[playerIP] ~= player:getGuid() then
			npcHandler:say("Voce so pode apostar com um personagem por dia.", npc, creature)
            npcHandler:setTopic(playerId, 0)
		else
			if storageAposta > 0 and apostaDay == day then
				npcHandler:say("Voce ja realizou uma aposta hoje. Volte amanha antes das 20:00h para uma nova aposta!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				if hour >= 20 or apostaDiaria == day then
					npcHandler:say("As apostas so podem ser realizadas ate as 20:00h. Sinto muito, mas tera que voltar amanha.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Nosso sistema funciona da seguinte forma: Cada jogador pode apostar 25 Tibia Coins diariamente, entregando as coins para mim. \z
					As 20:00h de cada dia eu realizarei um sorteio entre todos os participantes online e aquele que for sorteado levara 90% do valor total de Tibia Coins. \z
					Se apenas um jogador apostar no dia, ele recebera as 25 coins de volta. E entao, quer fazer uma aposta?", npc, creature)
					npcHandler:setTopic(playerId, 1)
				end
			end
		end
	elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
		if npcHandler:getTopic(playerId) == 1 then
			if hour < 20 then
				if player:removeTransferableCoins(25) then
					npcHandler:say("Esplendido! Seu nome sera registrado para o proximo sorteio que acontecera as 20:00h.", npc, creature)
					player:setStorageValue(Storage.Quest.Crandoria.Aposta.Active, 1)
					player:setStorageValue(Storage.Quest.Crandoria.Aposta.Day, day)
					Game.setStorageValue(GlobalStorage.Crandoria.Apostas.Value, apostaValor + 25)
					accessedIPs[playerIP] = player:getGuid()
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Voce precisa de 25 Tibia Coins tranferiveis para realizar uma aposta.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			else
				npcHandler:say("As apostas so podem ser realizadas ate as 20:00h. Sinto muito, mas tera que voltar amanha.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end
end


npcHandler:setMessage(MESSAGE_GREET, "Oi, |PLAYERNAME|. Se sentindo com sorte hoje? Por que nao faz uma {aposta} para multiplicar seus Tibia Coins?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais! Volte quando quiser apostar!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
