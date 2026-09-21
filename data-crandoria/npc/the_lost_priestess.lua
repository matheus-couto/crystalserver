-- ATUALIZAR --

local internalNpcName = "The Lost Priestess"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 1681,
	lookHead = 0,
	lookBody = 75,
	lookLegs = 0,
	lookFeet = 0,
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

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

	local knight = player:getVocation():getBaseId() == VOCATION.BASE_ID.KNIGHT
	local paladin = player:getVocation():getBaseId() == VOCATION.BASE_ID.PALADIN
	local druid = player:getVocation():getBaseId() == VOCATION.BASE_ID.DRUID
	local sorcerer = player:getVocation():getBaseId() == VOCATION.BASE_ID.SORCERER
    local monk = player:getVocation():getBaseId() == VOCATION.BASE_ID.MONK

	local level = player:getLevel()


    local storage1 = player:getStorageValue(Storage.Quest.Crandoria.Spells.Spell1)
	local storage2 = player:getStorageValue(Storage.Quest.Crandoria.Spells.Spell2)
	local storage3 = player:getStorageValue(Storage.Quest.Crandoria.Spells.Spell3)
	local storage4 = player:getStorageValue(Storage.Quest.Crandoria.Spells.Spell4)

    if MsgContains(message, "spell") then
		if level < 500 then
			npcHandler:say("Sinto muito, jovem alma... mas voce nao possui forca o suficiente para controlar nenhuma de minhas magias.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		else
			if level >= 500 then
				npcHandler:say("No seu nivel atual, posso ensinar as spells {death hug}(MS), {despair roots}(ED), {holy chant}(RP), {root wave}(AS), {fighter jump}(CG) and {revenge berserk}(EK).", npc, creature)
				npcHandler:setTopic(playerId, 1)
			end
		end
	elseif MsgContains(message, "death hug") then
		if npcHandler:getTopic(playerId) == 1 then
			if sorcerer then
				npcHandler:say("Deseja aprender a usar a spell Death Hug (exevo gran mort vex) por 2.500.000 gold coins?", npc, creature)
				npcHandler:setTopic(playerId, 2)
			else
				npcHandler:say("Apenas Sorcerers podem aprender a spell Death Hug.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	elseif MsgContains(message, "despair roots") then		
		if npcHandler:getTopic(playerId) == 1 then
			if druid then
				npcHandler:say("Deseja aprender a usar a spell Despair Roots (exevo gran root tera) por 2.500.000 gold coins?", npc, creature)
				npcHandler:setTopic(playerId, 2)
			else
				npcHandler:say("Apenas Druids podem aprender a spell Despair Roots.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	elseif MsgContains(message, "holy chant") then		
		if npcHandler:getTopic(playerId) == 1 then
			if paladin then
				npcHandler:say("Deseja aprender a usar a spell Holy Chant (exori chant san) por 2.500.000 gold coins?", npc, creature)
				npcHandler:setTopic(playerId, 2)
			else
				npcHandler:say("Apenas Paladins podem aprender a spell Holy Chant.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	elseif MsgContains(message, "root wave") then		
		if npcHandler:getTopic(playerId) == 1 then
			if summoner then
				npcHandler:say("Deseja aprender a usar a spell Root Wave (onora root) por 2.500.000 gold coins?", npc, creature)
				npcHandler:setTopic(playerId, 2)
			else
				npcHandler:say("Apenas Summoners podem aprender a spell Root Wave.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	elseif MsgContains(message, "jump") then		
		if npcHandler:getTopic(playerId) == 1 then
			if monk then
				npcHandler:say("Deseja aprender a usar a spell Fighter Jump (exeta hur) por 2.500.000 gold coins?", npc, creature)
				npcHandler:setTopic(playerId, 2)
			else
				npcHandler:say("Apenas Monks podem aprender a spell Fighter Jump.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	elseif MsgContains(message, "revenge berserk") then		
		if npcHandler:getTopic(playerId) == 1 then
			if knight then
				npcHandler:say("Deseja aprender a usar a spell Revenge Berserk (exori gran rev) por 2.500.000 gold coins?", npc, creature)
				npcHandler:setTopic(playerId, 2)
			else
				npcHandler:say("Apenas Knights podem aprender a spell Revenge Berserk.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
    elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
        if npcHandler:getTopic(playerId) == 2 then
			if storage1 < 1 then
				if player:removeMoneyBank(2500000) then
					player:setStorageValue(Storage.Quest.Crandoria.Spells.Spell1, 1)
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce aprendeu uma nova spell.")
					npcHandler:say("Muito bem, aqui esta o segredo da spell. Boa sorte!", npc, creature)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Voce nao possui dinheiro o suficiente.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			else
				npcHandler:say("Voce ja aprendeu essa spell.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola... Veio ate mim em busca de novas {spells}, eu presumo...")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)





-- keywordHandler:addSpellKeyword({'revenge berserk'},
-- 	{
-- 		npcHandler = npcHandler,
-- 		spellName = 'Revenge Berserk',
-- 		price = 2500000,
-- 		level = 700,
-- 		vocation = VOCATION.BASE_ID.KNIGHT
-- 	}
-- )
-- keywordHandler:addSpellKeyword({'despair roots'},
-- 	{
-- 		npcHandler = npcHandler,
-- 		spellName = 'Despair Roots',
-- 		price = 2500000,
-- 		level = 700,
-- 		vocation = VOCATION.BASE_ID.DRUID
-- 	}
-- )
-- keywordHandler:addSpellKeyword({'holy chant'},
-- 	{
-- 		npcHandler = npcHandler,
-- 		spellName = 'Holy Chant',
-- 		price = 2500000,
-- 		level = 700,
-- 		vocation = VOCATION.BASE_ID.PALADIN
-- 	}
-- )
-- keywordHandler:addSpellKeyword({'death hug'},
-- 	{
-- 		npcHandler = npcHandler,
-- 		spellName = 'Death Hug',
-- 		price = 2500000,
-- 		level = 700,
-- 		vocation = VOCATION.BASE_ID.SORCERER
-- 	}
-- )
-- keywordHandler:addSpellKeyword({'fighter jump'},
-- 	{
-- 		npcHandler = npcHandler,
-- 		spellName = 'Divine Rings',
-- 		price = 2500000,
-- 		level = 700,
-- 		vocation = VOCATION.BASE_ID.CELESTIAL_GUARDIAN
-- 	}
-- )
-- keywordHandler:addSpellKeyword({'root wave'},
-- 	{
-- 		npcHandler = npcHandler,
-- 		spellName = 'Root Wave',
-- 		price = 2500000,
-- 		level = 700,
-- 		vocation = VOCATION.BASE_ID.ANCIENT_SUMMONER
-- 	}
-- )
-- keywordHandler:addKeyword({'spells'}, StdModule.say,
-- 	{
-- 		npcHandler = npcHandler,
-- 		text = 'I can teach you {death hug}(MS), {despair roots}(ED), {holy chant}(RP), {root wave}(AS), {fighter jump}(CG) and {revenge berserk}(EK). What kind of spell do you wish to learn? You can also tell me for which level you would like to learn a spell, if you prefer that.'
-- 	}
-- )

-- npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- -- npcType registering the npcConfig table
-- npcType:register(npcConfig)
