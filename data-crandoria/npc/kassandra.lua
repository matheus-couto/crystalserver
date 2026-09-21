local internalNpcName = "Kassandra"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 149,
	lookHead = 2,
	lookBody = 114,
	lookLegs = 97,
	lookFeet = 2,
	lookAddons = 3
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

    local storage = player:getStorageValue(Storage.Quest.Crandoria.BakragoreTimer)

    if MsgContains(message, "info") or MsgContains(message, "informacao") then
        if storage < os.time() then
            npcHandler:say("Sabe... Voce esta em Viridia e sabe que por aqui as coisas nao vem tao facil. Ate mesmo informacoes tem seu preco... \z
            Faremos um trato: Me entregue 100.000 gold coins e te darei alguma informacao sobre este lugar. Mas atencao: Voce pode nao gostar do que eu te direi. \z
            Voce deve assumir este risco. Aceita minha proposta?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        else
            npcHandler:say("Eu sinto muito, mas nao posso passar muitas informacoes valiosas em um so dia. So os deuses sabem onde cada uma dessas informacoes vai parar... \z
            Se ainda estiver vivo, retorne amanha com mais ouro e talvez eu te darei uma nova informacao.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            if player:removeMoneyBank(100000) then
                local chance = math.random(1, 20)
                if chance == 1 then
                    npcHandler:say("As vezes o local da batalha pode ser mais importante que a maneira utilizada quando se pensa em derrotar demonios para alcancar uma recompensa... \z
                    De acordo com os antigos, cada um deve ser morto no local onde nasceu para que as pecas se encaixem...", npc, creature) 
                elseif chance == 2 then
                    npcHandler:say("Dizem que a temida Jungle Queen pode fornecer um item rarissimo. De acordo com os relatos ha uma criatura nessa ilha que busca incansavelmente por esse item. \z
                    Alguns pescadores disseram ter visto a tal criatura de longe, mas nao conseguiram definir que monstro ou animal ela poderia ser...", npc, creature)
                elseif chance == 3 then
                    npcHandler:say("Um dos animais mais raros de Viridia com certeza e o Giant Beaver, ou castor gigante. Um dia um homem disse ter encontrado um, mas o animal fugiu ao ve-lo. \z
                    O homem que relatou isso chegou na taverna um dia, estava assustado, como se tivesse visto um fantasma. Totalmente ensopado, de roupas rasgadas. Depois daquele dia nunca mais o vi...", npc, creature)
                elseif chance == 4 then
                    npcHandler:say("Uma das criaturas mais temidas de Viridia: Jaul, o Lorde das profundezas. Jaul na verdade reside em Crandoria, mas faz algumas visitas a Viridia para marcar seu territorio. \z
                    Ha uma lenda que diz que apenas aqueles que seguem em direcao a luz conseguem encontrar o verdadeiro caminho que leva ao esconderijo de Jaul em Viridia...", npc, creature)
                elseif chance == 5 then
                    npcHandler:say("Nas menores 'praias' podem estar escondidos os tesouros mais valiosos. Leve sempre uma pa com voce e cave por ai, quem sabe voce nao encontre algo de valor...", npc, creature)
                elseif chance == 6 then
                    npcHandler:say("O reino dos Deeplings fica escondido, mas alguns habitantes de Viridia sabem como encontra-lo. Ouvi dizer que o primeiro passo seria encontrar uma praia embaixo da terra...", npc, creature)
                elseif chance == 7 then
                    npcHandler:say("Algumas pedras preciosas sao ainda mais valiosas se usadas da maneira certa. De acordo com relatos de exploradores, diamantes carregam consigo magia e a habilidade de mostrar novos caminhos...", npc, creature)
                elseif chance == 8 then
                    npcHandler:say("Para domar um Water Buffalo voce precisara de um Leech. Ouvi dizer que ha uma piscina de slime nas profundezas da area dos macacos que pode ser perfeita para encontrar Leeches. \z
                    Leve sua vara de pesca e conte com a sorte!", npc, creature)
                elseif chance == 9 then
                    npcHandler:say("De acordo com historias de um velho guerreiro, o abrigo dos Vexclaws de Viridia pode ser acessado por meio de um portal por uma piscina de sangue. \z
                    Ele disse que o segredo para conseguir entrar na piscina esta nas estruturas do local...", npc, creature)
                elseif chance == 10 then
                    npcHandler:say("Em Viridia havia um anao chamado Trugok. Ele abriu alguns caminhos e escondeu suas entradas. Dizem que se voce bater sua picareta pelas rochas de cavernas pode encontrar um de seus caminhos. \z
                    Mas tenha cuidado! Um guerreiro contou que em uma dessas buscar se deparou com terriveis Elder Wyrms!", npc, creature)
                elseif chance == 11 then
                    npcHandler:say("Se visitar o castelo dos vampiros, fique atento a qualquer passagem secreta. Dizem que ha uma forma de abrir uma passagem secreta por um breve periodo de tempo no lugar...", npc, creature)
                elseif chance == 12 then
                    npcHandler:say("Ouvi rumores de que os acolitos, abaixo da antiga igreja, escondem uma passagem secreta para as masmorras dos Necromancers. Nao acha estranho? \z
                    De acordo com o que me disseram ha alguma forma de abrir a passagem no proprio local, mas nao sei exatamente qual seria...", npc, creature)
                elseif chance == 13 then
                    npcHandler:say("Dizem que entre os Assassins e os Dark Magincians ha uma passagem secreta para os Gazers. Uma velha cigana disse ter ouvido algo sobre um segredo escondido no local. \z
                    Infelizmente as historias acabam ai, mas vale a pena averiguar...", npc, creature)
                elseif chance == 14 then
                    npcHandler:say("Antigamente um velho feiticeiro vivia nas profundezas de Viridia. Diziam que ele era um dos responsaveis pela chegada dos demonios na cidade. \z
                    Um de seus esconderijos foi encontrado e uma coisa chamou a atencao de todos: Ele havia guardado varios Demon Horns. Com certeza eles eram uteis para alguma coisa...", npc, creature)
                elseif chance == 15 then
                    npcHandler:say("De acordo com as escrituras antigas das paredes da piramide de Viridia, Scarab Coins eram o maior tesouro do farao que ali habitava. \z
                    Era usada para negociacoes, para rituais religiosos e ate mesmo para magias de teletransporte...", npc, creature)
                elseif chance == 16 then
                    npcHandler:say("Os Heroes sao guerreiros que lutam com honra pela causa na qual acreditam. Muitos deles dao a vida para defender seus ideais e seus lideres. \z
                    Ha uma historia vagando pela ilha sobre um ritual de sacrificio que utiliza a vida de 2 Heroes em troca de uma magia de teletransporte. Algo realmente surpreendente e assustador...", npc, creature)
                elseif chance == 17 then
                    npcHandler:say("Alguns locais nao podem ser acessados apenas caminhando. Ja pensou em nadar ou utilizar uma montaria para chegar a algum destino? \z
                    Em Viridia essa dica pode ser a diferenca entre o sucesso e o fracasso...", npc, creature)
                elseif chance == 18 then
                    npcHandler:say("Ha um homem conhecido por Zannar que transporta pessoas para a Ilha das Sombras. Mas ha uma coisa que poucos sabem: A cada dia ele pede um item diferente pelo transporte. \z
                    Se voce se atentar bem, os itens mudam de acordo com os dias da semana. Com esse conhecimento em maos sera mais facil acessar o local quando precisar dos servicos de Zannar...", npc, creature)
                elseif chance == 19 then
                    npcHandler:say("Os Iks sempre utilizaram estatuas como condutores de magia. Ha uns dias me foi entregue um fragmento de pergaminho que dizia as seguintes palavras: \z
                    'So podera chegar a ilha dos Iks aqueles que tocarem a estatua correta...'", npc, creature) 
                elseif chance == 20 then
                    npcHandler:say("Cave a areia ao leste da piramide para acessar uma passagem secreta que leva aos mercadores Djinns. Mas nao fui eu quem te disse isso...", npc, creature)
                end
                player:setStorageValue(Storage.Quest.Crandoria.BakragoreTimer, os.time() + 20 * 60 * 60)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Sinto muito. Sem ouro, sem informacao.", npc, creature)
                npcHandler:setTopic(playerId, 0)  
            end
        end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) then
        npcHandler:say("Ah.. Tudo bem entao.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola, viajante. Parece que esta em busca de algo... Talvez eu possa te dar alguma {informacao}...")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)



