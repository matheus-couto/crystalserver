local internalNpcName = "Hoggle"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 70
}

npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{text = 'Oh, this misery...'}
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
    
	local level = player:getLevel()
	local fee = player:getLevel() * 3
	local timePrison = player:getStorageValue(Storage.Quest.Crandoria.PrisonBan.Time)
	local timeLeft = 0

	if timePrison > os.time() then
		timeLeft = timePrison - os.time()

		days = math.floor(timeLeft / 86400)
		timeLeft = timeLeft % 86400

		hours = math.floor(timeLeft / 3600)
		timeLeft = timeLeft % 3600

		minutes = math.floor(timeLeft / 60)
	end

    if MsgContains(message, "fianca") then
		npcHandler:say("Sua fianca sera relativa ao seu nivel atual. No momento, o valor a ser pago sera de "..fee.." Tibia Coins. Gostaria de pagar para sair da prisao?", npc, creature)
        npcHandler:setTopic(playerId, 1)
	elseif MsgContains(message, "tempo") then
		npcHandler:say("Voce ainda precisa cumprir "..days.." dias, "..hours.." horas e "..minutes.." minutos da sua pena para sair da prisao pelo teleport.", npc, creature)
        npcHandler:setTopic(playerId, 0)
	elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
		if npcHandler:getTopic(playerId) == 1 then
			if player:getTransferableCoins() >= fee then
				player:removeTransferableCoins(fee)
				player:teleportTo(Position(4992, 5131, 7))
				player:setStorageValue(Storage.Quest.Crandoria.PrisonBan.Time, 0)
				player:setStorageValue(Storage.Quest.Crandoria.BanAntiAfk, 0)
				player:setStorageValue(Storage.Quest.Crandoria.PrisonBan.PrisonMoment, 0)
				npcHandler:say("Muito bem. Como combinado, voce esta livre agora!", npc, creature)
            	npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao possui Tibia Coins o suficiente. Esta tentando enganar um guarda da prisao? Se seguir com isso aumentarei a sua pena!", npc, creature)
            	npcHandler:setTopic(playerId, 0)
			end
		end
	end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola, prisioneiro. Fazendo coisas erradas nao e mesmo? Ha ha ha! Pague sua {fianca} ou cumpra seu {tempo} de prisao para sair da nossa Prisao.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
