local internalNpcName = "Pyromental"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 242
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

    if MsgContains(message, "fogo") then
			npcHandler:say("Tem medo do fogo? Muitos o temem por ser um elemento tao instavel e agressivo. Mas na verdade as pessoas nao entendem o fogo.\z
			As chamas tambem sao vida e representam parte do equilibrio entre o caos e a ordem. So aqueles dignos de grandes feitos poderao dominar de verdade o fogo. \z
			Ate la, o Flame Guardian segue sendo o eleito a abracar o caos das chamas e garantir o poder supremo do fogo no mundo.", npc, creature)
			npcHandler:setTopic(playerId, 0)
    elseif MsgContains(message, "caos") then
		npcHandler:say("Ha quem diga que o caos deve ser extinto, outros o abracam como necessario para o equilibrio do mundo. Eu faco parte do segundo grupo... \z
		Assim como a ordem, o caos tambem estrutura o mundo no qual vivemos, alem de possuir uma natureza altamente subjetiva. Para alguns, uma chuva pode ser caotica, enquanto outros oram por ela. \z
		O importante nessa questao sempre foi a visao de mundo que se tem e como acreditamos que o mundo deve ser regido.", npc, creature)
		npcHandler:setTopic(playerId, 0)
    elseif MsgContains(message, "flame") then
		npcHandler:say("O grande Guardiao das Chamas... um ser totalmente tomado pelo fogo, um dos mais poderosos guardioes que ja existiu. Alguns dizem que ja o derrotaram. \z
		Mas pra ser sincero, eu so acreditarei no dia que eu puder ver com meus proprios olhos! Rezam as lendas que aquele que derrotar o Flame Guardian podera obter um item especial. \z
		Esse item permite que a pessoa dome o proprio fogo! Mas ninguem sabe se isso realmente pode ser possivel ou se nao passa de uma lenda.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "missao") or MsgContains(message, "mission") then
		npcHandler:say("Eu sabia... os humanos acham que tudo se baseia em missoes e recompensas. Lucros e luxo! Voces sao todos iguais... Nao, eu nao tenho missoes para voce. \z
		Boa sorte em sua jornada ate a morte.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "por que") then
		npcHandler:say("'POR QUE?'... Ha! Olhe a sua volta, humano! Nao ha nada para voce aqui alem de medo, caos e fogo. Nao ha espaco para historias sobre honra e gloria em Ilshenar. \z
		Mas voces, mortais, nao mudam. Sempre em busca de recompensas para as quais voces atribuiram tamanho valor... Enfim, o conselho esta dado!", npc, creature)
		npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Com certeza voce nao devia estar aqui..")
npcHandler:setMessage(MESSAGE_FAREWELL, "Desvie das chamas no caminho!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Cuidado para nao se queimar.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
