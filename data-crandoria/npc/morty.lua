local internalNpcName = "Morty"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 128,
	lookHead = 96,
	lookBody = 0,
	lookLegs = 74,
	lookFeet = 26,
    	lookAddons = 3,
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

    local storage = player:getStorageValue(Storage.Quest.Crandoria.Eventos.DiaDosPais)

    if MsgContains(message, "desafio") or MsgContains(message, "sim") then
        npcHandler:say("Estou viajando pelo Novo Continente com meu pai para que ele possa desafiar guerreiros de todos os lugares. De acordo com ele, nenhum guerreiro pode vence-lo no mesmo estado que ele. Quando digo 'no mesmo estado', quero dizer bebado! Ha ha ha. \z
        Meu pai ama duas coisas na vida: Cerveja e lutas. Se quiser lutar contra ele tome 50 garrafas de {cerveja concentrada} e passe pelo portal no dia 14 de agosto, as 19:00h ou as 22:00h. Esse sera o horario do nosso proximo espetaculo. E fique sabendo: Se voce conseguir derrotar meu pai podera pegar tudo o que ele deixar cair consigo! \z
        Caso tenha perdido a conta de quantas cervejas tomou, venha ate mim e me pergunte sobre seu {progresso} e eu te direi se voce ja chegou la!", npc, creature)
        npcHandler:setTopic(playerId, 0)
    elseif MsgContains(message, "progresso") then
        if storage < 1 then
            npcHandler:say("Voce ainda nao tomou nenhuma cerveja, entao nao podera lutar contra meu pai no proximo espetaculo.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage > 0 and storage < 2 then
            npcHandler:say("Voce ja tomou " ..storage.. " cervejas. Ainda falta muito...", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage >= 2 and storage < 4 then
            npcHandler:say("Voce ja tomou " ..storage.. " cervejas. Talvez voce ja esteja comecando a se sentir levemente embriagado...", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage >= 4 and storage < 6 then
            npcHandler:say("Voce ja tomou " ..storage.. " cervejas. Muito bem, muito bem... Parece que voce esta mesmo disposto a cumprir esse desafio.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage >= 6 and storage < 8 then
            npcHandler:say("Voce ja tomou " ..storage.. " cervejas. Ainda tem um figado ai? Ha ha ha!", npc, creature)
            npcHandler:setTopic(playerId, 0)   
        elseif storage >= 8 and storage < 10 then
            npcHandler:say("Voce ja tomou " ..storage.. " cervejas!! Muito impressionante. Mas tome cuidado para nao ter um coma alcoolico antes mesmo da luta!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage >= 10 then
            npcHandler:say("Voce ja tomou " ..storage.. " cervejas!! Sensacional... voce conseguiu! Muito bem. As 22:00h do dia 10 de agosto estaremos esperando voce e qualquer outro que queira desafiar meu pai. Prepare-se e nao se atrase!!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "cerveja concentrada") then
        npcHandler:say("Pode-se dizer que a 'cerveja concentrada' sempre foi a bebida favorita entre os artistas circenses. Ela possui o sabor da cerveja, mas pode ser tao forte quanto rum ou vodka!", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola, habitante de Crandoria. Esta pronto para um grande {desafio}?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
