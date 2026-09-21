local internalNpcName = "Pompan"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 132,
	lookHead = 78,
	lookBody = 13,
	lookLegs = 32,
	lookFeet = 108,
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

local outfits = {
    ["arbalester"] = {1450, 1449},
    ["armoured archer"] = {1619, 1618},
    ["breezy garb"] = {1246, 1245},
    ["ceremonial garb"] = {694, 695},
    ["conjurer"] = {635, 634},
    ["death herald"] = {666, 667},
    ["entrepreneur"] = {471, 472},
    ["fencer"] = {1576, 1575},
    ["forest warden"] = {1416, 1415},
    ["frost tracer"] = {1613, 1612},
    ["ghost blade"] = {1490, 1489},
    ["herbalist"] = {1020, 1021},
    ["herder"] = {1280, 1279},
    ["merry garb"] = {1383, 1382},
    ["moth cape"] = {1339, 1338},
    ["nordic chieftain"] = {1501, 1500},
    ["owl keeper"] = {1174, 1173},
    ["pharaoh"] = {956, 955},
    ["philosopher"] = {874, 873},
    ["ranger"] = {683, 684},
    ["sea dog"] = {749, 750},
    ["seaweaver"] = {732, 733},
    ["shadowlotus disciple"] = {1582, 1581},
    ["siege master"] = {1050, 1051},
    ["spirit caller"] = {698, 699},
    ["sun priest"] = {1024, 1023},
    ["trailblazer"] = {1293, 1292},
    ["veteran paladin"] = {1205, 1204},
}

local mounts = {
    ["battle badger"] = {153},
    ["black stag"] = {73},
    ["blackpelt"] = {58},
    ["bloodcurl"] = {92},
    ["brass speckled koi"] = {208},
    ["cave tarantula"] = {117},
    ["cinnamon ibex"] = {200},
    ["coral rhea"] = {169},
    ["coralripper"] = {79},
    ["cranium spider"] = {116},
    ["cunning hyaena"] = {172},
    ["dandelion"] = {187},
    ["death crawler"] = {46},
    ["desert king"] = {41},
    ["doombringer"] = {53},
    ["ebony tiger"] = {123},
    ["ember saurian"] = {111},
    ["emerald raven"] = {191},
    ["emerald sphinx"] = {108},
    ["emerald waccoon"] = {70},
    ["emperor deer"] = {74},
    ["ether badger"] = {154},
    ["eventine nandu"] = {170},
    ["feral tiger"] = {124},
    ["festive mammoth"] = {178},
    ["frostbringer"] = {210},
    ["glacier vagaband"] = {64},
    ["gloom widow"] = {118},
    ["gold sphinx"] = {107},
    ["golden dragonfly"] = {59},
    ["gorongra"] = {81},
    ["hailstorm fury"] = {55},
    ["highland yak"] = {63},
    ["holiday mammoth"] = {177},
    ["hyacinth"] = {185},
    ["icebreacher"] = {212},
    ["ink spotted koi"] = {209},
    ["ivory fang"] = {100},
    ["jade lion"] = {48},
    ["jade pincer"] = {49},
    ["jade shrine"] = {196},
    ["jungle saurian"] = {110},
    ["jungle tiger"] = {125},
    ["lagoon saurian"] = {112},
    ["leafscuttler"] = {93},
    ["marsh toad"] = {120},
    ["merry mammoth"] = {176},
    ["mint ibex"] = {199},
    ["mould shell"] = {96},
    ["mouldpincer"] = {91},
    ["mystic raven"] = {192},
    ["night waccoon"] = {69},
    ["nightmarish crocovile"] = {143},
    ["nightstinger"] = {85},
    ["noctungra"] = {82},
    ["obsidian shrine"] = {197},
    ["peony"] = {186},
    ["plumfish"] = {80},
    ["poisonbane"] = {57},
    ["poppy ibex"] = {198},
    ["radiant raven"] = {193},
    ["razorcreep"] = {86},
    ["reed lurker"] = {97},
    ["ringtail raccoon"] = {68},
    ["river crocovile"] = {141},
    ["sanguine frog"] = {121},
    ["savanna ostrich"] = {168},
    ["scruffy hyaena"] = {173},
    ["sea devil"] = {78},
    ["shadow claw"] = {101},
    ["shadow hart"] = {72},
    ["shadow sphinx"] = {109},
    ["siegebreaker"] = {56},
    ["silverneck"] = {83},
    ["slagnare"] = {84},
    ["snow pelt"] = {102},
    ["steel bee"] = {60},
    ["swamp crocovile"] = {142},
    ["swamp snapper"] = {95},
    ["tangerine speckled koi"] = {207},
    ["tombstinger"] = {36},
    ["topaz shrine"] = {195},
    ["toxic toad"] = {122},
    ["tundra rambler"] = {62},
    ["voracious hyaena"] = {171},
    ["winter king"] = {52},
    ["winterstride"] = {211},
    ["woodland prince"] = {54},
    ["zaoan badger"] = {155},
}

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

    local progresso = player:getStorageValue(Storage.Quest.Crandoria.TasksPompan.Progresso)
	local active = player:getStorageValue(Storage.Quest.Crandoria.TasksPompan.Active)
	local count = player:getStorageValue(Storage.Quest.Crandoria.TasksPompan.Count)
	local taskType = player:getStorageValue(Storage.Quest.Crandoria.TasksPompan.Type)

    if MsgContains(message, "task") or MsgContains(message, "missao") or MsgContains(message, "tarefa") or MsgContains(message, "mission") then
		if active < 1 then
			npcHandler:say("Eu ofereco tasks de nivel {facil}, {normal} e {dificil}. Nao tem dificuldade: Voce compra uma task por Tibia Coins e recebe, em troca, muita experiencia e um addon ou uma montaria. \z
			Cada nivel de dificuldade fornece recursos limitados de acordo com seu valor na Store. Se quiser saber mais, basta escolher a dificuldade da task que deseja.", npc, creature)
			npcHandler:setTopic(playerId, 1)
		else
			if taskType == 1 then
				if count < 1000 then
					npcHandler:say("Voce precisa derrotar 1000 monstros para completar a sua task.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Muito bom! Muito bom mesmo! Como combinado, voce pode escolher. O que deseja, um {addon} ou uma {montaria}?", npc, creature)
					npcHandler:setTopic(playerId, 14)
				end
			elseif taskType == 2 then
				if count < 2500 then
					npcHandler:say("Voce precisa derrotar 2500 monstros para completar a sua task.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Muito bom! Muito bom mesmo! Como combinado, voce pode escolher. O que deseja, um {addon} ou uma {montaria}?", npc, creature)
					npcHandler:setTopic(playerId, 15)
				end
			elseif taskType == 3 then
				if count < 2500 then
					npcHandler:say("Voce precisa derrotar 2500 monstros para completar a sua task.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Muito bom! Muito bom mesmo! Como combinado, voce pode escolher. O que deseja, um {addon} ou uma {montaria}?", npc, creature)
					npcHandler:setTopic(playerId, 16)
				end
			end
		end
	elseif MsgContains(message, "facil") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("As tasks faceis sao mais tranquilas e exigem menos esforcos. Ao completar voce podera escolher uma montaria ou um addon da Store de ate 400 Tibia Coins. \z
			O valor para iniciar uma Task sera de 200 Tibia Coins ou 15.000.000 gold coins e a task sera selecionada ao acaso. Voce aceita?", npc, creature)
            npcHandler:setTopic(playerId, 2)
		end
	elseif MsgContains(message, "normal") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("As tasks de nivel normal sao desafiadoras e exigem um pouco de paciencia. Ao completar voce podera escolher uma montaria ou um addon da Store de ate 550 Tibia Coins. \z
			O valor para iniciar uma Task sera de 250 Tibia Coins ou 20.000.000 gold coins e a task sera selecionada ao acaso. Voce aceita?", npc, creature)
            npcHandler:setTopic(playerId, 3)
		end
	elseif MsgContains(message, "dificil") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("As tasks dificeis exigirao muito dos jogadores, porem ao completar voce podera escolher uma montaria ou um addon da Store de ate 700 Tibia Coins. \z
			O valor para iniciar uma Task sera de 300 Tibia Coins ou 30.000.000 gold coins e a task sera selecionada ao acaso. Voce aceita?", npc, creature)
            npcHandler:setTopic(playerId, 4)
		end
	elseif MsgContains(message, "gold") then
		if npcHandler:getTopic(playerId) == 5 then
			npcHandler:say("Deseja receber uma task facil por 15.000.000 gold coins?", npc, creature)
            npcHandler:setTopic(playerId, 8)
		elseif npcHandler:getTopic(playerId) == 6 then
			npcHandler:say("Deseja receber uma task normal por 20.000.000 gold coins?", npc, creature)
            npcHandler:setTopic(playerId, 9)
		elseif npcHandler:getTopic(playerId) == 7 then
			npcHandler:say("Deseja receber uma task dificil por 25.000.000 gold coins?", npc, creature)
            npcHandler:setTopic(playerId, 10)
		end
	elseif MsgContains(message, "coins") then
		if npcHandler:getTopic(playerId) == 5 then
			npcHandler:say("Deseja receber uma task facil por 200 tibia coins?", npc, creature)
            npcHandler:setTopic(playerId, 11)
		elseif npcHandler:getTopic(playerId) == 6 then
			npcHandler:say("Deseja receber uma task normal por 250 tibiad coins?", npc, creature)
            npcHandler:setTopic(playerId, 12)
		elseif npcHandler:getTopic(playerId) == 7 then
			npcHandler:say("Deseja receber uma task dificil por 300 tibia coins?", npc, creature)
            npcHandler:setTopic(playerId, 13)
		end
	elseif MsgContains(message, "addon") then
		if npcHandler:getTopic(playerId) == 14 then
			npcHandler:say("Voce pode selecionar os addons: {arbalester}, {breezy garb}, {death herald}, {ghost blade}, {merry garb}, {moth cape}, {owl keeper}, {sea dog}, {seaweaver}, {shadowlotus disciple}, {siege master}, {spirit caller} ou {trailblazer}. \z
			Qual deles voce escolhe?", npc, creature)
            npcHandler:setTopic(playerId, 17)
		elseif npcHandler:getTopic(playerId) == 6 then
			npcHandler:say("Voce pode selecionar os addons: {arbalester}, {breezy garb}, {death herald}, {ghost blade}, {merry garb}, {moth cape}, {owl keeper}, {sea dog}, {seaweaver}, {shadowlotus disciple}, {siege master}, {spirit caller}, {trailblazer}, \z
			", npc, creature) --- INACABADO
            npcHandler:setTopic(playerId, 12)
		elseif npcHandler:getTopic(playerId) == 7 then
			npcHandler:say("Deseja receber uma task dificil por 300 tibia coins?", npc, creature)
            npcHandler:setTopic(playerId, 13)
		end
	elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 2 then
			npcHandler:say("E o que vai ser? Tibia {coins} ou {gold}?", npc, creature)
            npcHandler:setTopic(playerId, 5)
		elseif npcHandler:getTopic(playerId) == 3 then
			npcHandler:say("E o que vai ser? Tibia {coins} ou {gold}?", npc, creature)
            npcHandler:setTopic(playerId, 6)
		elseif npcHandler:getTopic(playerId) == 4 then
			npcHandler:say("E o que vai ser? Tibia {coins} ou {gold}?", npc, creature)
            npcHandler:setTopic(playerId, 7)
		end
    end
end

npcHandler:setMessage(MESSAGE_GREET, 'Quer ganhar um desconto em addons e montarias da Store? Entao ta no lugar certo! Basta completar alguma das minhas {tasks}.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'It was a pleasure to help you, |PLAYERNAME|.')
npcHandler:setMessage(MESSAGE_SENDTRADE, "Keep in mind you won't find better offers here. Just browse through my wares.")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
