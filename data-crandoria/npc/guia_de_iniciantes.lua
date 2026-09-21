local internalNpcName = "Guia de Iniciantes"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 746,
	lookHead = 115,
	lookBody = 68,
	lookLegs = 78,
	lookFeet = 114,
	lookAddons = 3
}

npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 30000,
	chance = 50,
	{text = 'Tem alguma duvida sobre Tibia ou sobre o servidor? Venha perto de mim e diga Hi.'}
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

    if MsgContains(message, "yes") and npcHandler:getTopic(playerId) < 1 then
        npcHandler:say("Otimo! Primeiramente, sempre que voce estiver interagindo com algum NPC no jogo, observe as palavras em negrito na conversa. Geralmente essas palavras indicam o que voce pode dizer para prosseguir com o dialogo. Se voce entendeu e deseja prosseguir, diga {yes}. Se o tutorial estiver muito basico, voce pode simplesmente me dizer e eu te direi como escolher uma {vocacao} e ir para a cidade de Crandoria.", npc, creature)
        npcHandler:setTopic(playerId, 1)
    elseif MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 1 then
        npcHandler:say("Excelente! Entao vamos prosseguir. Voce esta em uma ilha chamada Dawnport. Nessa ilha os jogadores devem selecionar qual vocacao eles desejam escolher para jogar. Voce ja conhece as vocacoes? Responda {yes} ou {no}.", npc, creature)
        npcHandler:setTopic(playerId, 2)
    elseif MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 2 then
        npcHandler:say("Otimo. Se voce deseja saber mais sobre as vocacoes ou sobre como selecionar sua vocacao e ir para Crandoria, diga {vocacao}. Mas se desejar, posso fornecer mais {informacoes} sobre o CrandoriaOT.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    elseif MsgContains(message, "no") and npcHandler:getTopic(playerId) == 2 then
        npcHandler:say("Vou te explicar: ao atingir o nivel 8 voce podera escolher uma entre quatro vocacoes: Knight, Paladin, Sorcerer e Druid. Knights sao guerreiros que lutam com armas de corpo a corpo, paladins atacam com flechas, lanças e bestas. Druids sao magos que possuem poderes de cura e suporte, alem de algum dano. Sorcerers sao magos com foco maior em magias de ataque e dano magico. Knights possuem muita vida e pouca mana, enquanto druid e sorcerers possuem muita mana para feiticos, porem nao tem muita vida para se defender. Paladins sao versateis e possuem quantidades moderadas de vida e mana. Voce sabe como selecionar sua vocacao?", npc, creature)
        npcHandler:setTopic(playerId, 3)
    elseif MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 3 then
        npcHandler:say("Otimo. Se voce deseja saber como ir para a cidade de Crandoria, diga {leave}. Mas se desejar, posso fornecer mais {informacoes} sobre o CrandoriaOT.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    elseif MsgContains(message, "no") and npcHandler:getTopic(playerId) == 3 then
        npcHandler:say("Para selecionar sua vocacao, primeiro voce precisa passar pelo {trial} de Dawnport. Ao sul, voce tem o teste dos druids, ao norte dos knights, para o oeste o teste dos sorcerers e para o leste dos paladins. Voce deve escolher um dos caminhos. Ao passar pela saida voce recebera alguns itens para matar os primeiros monstros e subir ate o nivel 8. Ao atingir o nivel 8 voce deve retornar aqui, descer as escadas no centro e falar com {Oressa} para finalmente escolher oficialmente sua {vocacao}. Voce gostaria de obter mais informacoes sobre as primeiras batalhas ate o nivel 8?", npc, creature)
        npcHandler:setTopic(playerId, 4)
    elseif MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 4 then
        npcHandler:say("A maioria dos monstros que voce matar te darao pontos de experiencia para subir de nivel. Sempre lembre de manter seu personagem alimentado. Comer regenera sua vida e sua mana por um tempo. Tente nao lutar contra muitos inimigos ao mesmo tempo, assim voce fica menos vulneravel. Matar monstros com um amigo do lado sempre ajuda a economizar recursos como pocoes e runas e ajuda no aumento de experiencia. Runas e spells sao sempre uma opcao nas batalhas. Voce quer saber mais sobre as spells iniciais de cada vocacao?.", npc, creature)
        npcHandler:setTopic(playerId, 5)
    elseif MsgContains(message, "no") and npcHandler:getTopic(playerId) == 4 then
        npcHandler:say("Tudo bem. Me avise se precisar de mais alguma coisa ou se quiser mais {informacoes} sobre o servidor!", npc, creature)
        npcHandler:setTopic(playerId, 0)
    elseif MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 5 then
        npcHandler:say("As spells no Tibia podem ser usadas pelas hotkeys ou o jogador pode digitar as palavras de seus encantamentos para que ela seja ativada. Em Dawnport, {knights} possuem a spell de cura exura infir ico, {paladins possuem} a spell de conjurar flechas exevo infir con, {druids} possuem a spell de ataque exevo infir frigo hur e {sorcerers} possuem a spell de ataque exori infir vis. ", npc, creature)
        npcHandler:setTopic(playerId, 6)
    elseif MsgContains(message, "no") and npcHandler:getTopic(playerId) == 5 then
        npcHandler:say("Tudo bem. Me avise se precisar de mais alguma coisa ou se quiser mais {informacoes} sobre o servidor!", npc, creature)
        npcHandler:setTopic(playerId, 0)
	return true
    end
    return true
end




-- Basic
keywordHandler:addKeyword({'trial'}, StdModule.say, {npcHandler = npcHandler, text = 'O trial sera a forma de voce testar a vocacao que deseja seguir no jogo. Na saida norte voce tera o trial dos knights, ,a saida do sul o trial dos druids, na saida oeste o trial dos sorcerers e na saida leste o trial dos paladins. Voce deve selecionar um caminho e seguir ate o nivel 8. Apos o nivel 8 volte ate o centro e converse com Oressa para seguir seu destino e escolher sua {vocacao}.'})
keywordHandler:addKeyword({'vocacoes'}, StdModule.say, {npcHandler = npcHandler, text = 'As quatro vocacoes base sao {knight}, {druid}, {paladin} e {sorcerer}. Basta dizer o nome de qualquer uma delas e eu darei mais informacoes sobre ela.'})
keywordHandler:addKeyword({'vocacao'}, StdModule.say, {npcHandler = npcHandler, text = 'As quatro vocacoes base sao {knight}, {druid}, {paladin} e {sorcerer}. Basta dizer o nome de qualquer uma delas e eu darei mais informacoes sobre ela.'})
keywordHandler:addKeyword({'sorcerers'}, StdModule.say, {npcHandler = npcHandler, text = 'Sorcerers sao magos poderosos que utilizam o poder do fogo, do raio e da morte para causar muito dano em seus oponentes. Possuem pouca vida e muita mana. Apesar de nao possuir spells para curar seus aliados, eles sao um pouco mais poderosos que druids no ataque.'})
keywordHandler:addKeyword({'sorcerer'}, StdModule.say, {npcHandler = npcHandler, text = 'Sorcerers sao magos poderosos que utilizam o poder do fogo, do raio e da morte para causar muito dano em seus oponentes. Possuem pouca vida e muita mana. Apesar de nao possuir spells para curar seus aliados, eles sao um pouco mais poderosos que druids no ataque.'})
keywordHandler:addKeyword({'druid'}, StdModule.say, {npcHandler = npcHandler, text = 'Druids sao feiticeiros que utilizam poderes da natureza para dar dano em seus oponentes e curar seus aliados. Possuem pouca vida e muita mana. Sao muito poderosos e importantes para missoes em grupo.'})
keywordHandler:addKeyword({'druids'}, StdModule.say, {npcHandler = npcHandler, text = 'Druids sao feiticeiros que utilizam poderes da natureza para dar dano em seus oponentes e curar seus aliados. Possuem pouca vida e muita mana. Sao muito poderosos e importantes para missoes em grupo.'})
keywordHandler:addKeyword({'paladins'}, StdModule.say, {npcHandler = npcHandler, text = 'Paladins sao lutadores precisos que utilizam arcos, bestas e lancas para dar um grande dano a distancia. Possuem quantidade moderada de vida e mana e spells com dano fisico e sagrado.'})
keywordHandler:addKeyword({'paladin'}, StdModule.say, {npcHandler = npcHandler, text = 'Paladins sao lutadores precisos que utilizam arcos, bestas e lancas para dar um grande dano a distancia. Possuem quantidade moderada de vida e mana e spells com dano fisico e sagrado.'})
keywordHandler:addKeyword({'knight'}, StdModule.say, {npcHandler = npcHandler, text = 'Knights sao guerreiros resistentes que lutam corpo a corpo. Eles podem optar por utilizar espadas, machados ou maces e sao otimos em segurar o dano de varias criaturas enquanto outros guerreiros lancam seus feiticos protegidos na retaguarda. Possuem muita vida, pouca mana e spells de ataque com dano fisico.'})
keywordHandler:addKeyword({'knights'}, StdModule.say, {npcHandler = npcHandler, text = 'Knights sao guerreiros resistentes que lutam corpo a corpo. Eles podem optar por utilizar espadas, machados ou maces e sao otimos em segurar o dano de varias criaturas enquanto outros guerreiros lancam seus feiticos protegidos na retaguarda. Possuem muita vida, pouca mana e spells de ataque com dano fisico.'})
keywordHandler:addKeyword({'oressa'}, StdModule.say, {npcHandler = npcHandler, text = 'Oressa fica no andar de baixo de Dawnport e ela possibilita a selecao de uma vocacao pelo jogador, para que em seguida ele possa finalmente deixar Dawnport.'})
keywordHandler:addKeyword({'itens iniciais'}, StdModule.say, {npcHandler = npcHandler, text = 'Apos selecionar sua vocacao com {Oressa} voce deve passar pela porta referente a sua vocacao. Do outro lado da porta de cada vocacao ha um bau com um conjunto de itens iniciais para ajudar seu personagem nos primeiros passos em Crandoria.'})
keywordHandler:addKeyword({'leave'}, StdModule.say, {npcHandler = npcHandler, text = 'Para sair de Dawnport basta selecionar sua vocacao falando com {Oressa}, no andar de baixo. Depois passe na porta da sua vocacao, pegue os {itens iniciais} no bau e va para a esquerda ate encontrar um navio. No navio, va ate Captain Dreadnought e diga hi, yes, yes, crandoria. Ele te levara para Crandoria.'})
keywordHandler:addKeyword({'informacoes'}, StdModule.say, {npcHandler = npcHandler, text = 'Posso te ajudar com informacoes e dicas importantes sobre o Crandoria OT, como meios de {transporte}, {itens}, {sistemas}, {comandos}, {promotion}, {treino} de skills, {cidades}, {NPC}s, {taxas} de exp e skills, {hunts} e {quests}. Sobre o que voce quer saber?'})
keywordHandler:addKeyword({'sistemas'}, StdModule.say, {npcHandler = npcHandler, text = 'No CrandoriaOT temos diversos sistemas que os jogadores podem utilizar, como o sistema {VIP}, a {pesca} especial no lago de crandoria, o sistema de {autoloot}, os {online tokens}, a {wheel of destiny}, as {tasks}, a {prisao}, a {roleta} ou o sistema de obtencao de {tibia coins} no jogo. Sobre qual voce gostaria de saber?'})
keywordHandler:addKeyword({'comando'}, StdModule.say, {npcHandler = npcHandler, text = 'Os principais comandos para jogadores sao: !autoloot para o sistema de {autoloot}, !bless comprar as blesses por gold coins, !aol para comprar um amulet of loss e !task para utilizar o sistema de {tasks}.'})
keywordHandler:addKeyword({'comandos'}, StdModule.say, {npcHandler = npcHandler, text = 'Os principais comandos para jogadores sao: !autoloot para o sistema de {autoloot}, !bless comprar as blesses por gold coins, !aol para comprar um amulet of loss e !task para utilizar o sistema de {tasks}.'})
keywordHandler:addKeyword({'cidades'}, StdModule.say, {npcHandler = npcHandler, text = 'O Novo Continente possui diversas cidades, sendo as principais {Crandoria}, {Anvillux}, {Elvenshire}, {Hakata}, {Icehold}, {Chaos}, {Valkesh}, {Magincia}, {Nivabi}, {Roshamuul} e {Nautis}.'})
keywordHandler:addKeyword({'hunts'}, StdModule.say, {npcHandler = npcHandler, text = 'Nosso servidor possui uma enorme quantidade de hunts, sendo a maior parte delas criadas pela equipe Crandoria OT. Apesar disso, voce tambem vai encontrar diversas hunts do global espalhadas pelo nosso mapa. Para saber um pouco mais sobre as hunts, voce pode checar o {mapa} em nosso {site} ou nos seguir no {instagram}.'})
keywordHandler:addKeyword({'pesca'}, StdModule.say, {npcHandler = npcHandler, text = 'No CrandoriaOT temos um sistema de pescaria único: Se voce possui uma {Mechanical Fishing Rod} e algumas minhocas, voce pode pescar no {Lago da Avareza} de Crandoria, com possibilidades de pescar ouro, {casino tickets}, itens de imbuement e muito mais!'})
keywordHandler:addKeyword({'itens'}, StdModule.say, {npcHandler = npcHandler, text = 'O CrandoriaOT possui alguns itens especiais, enter eles a {black candle}, os {online tokens}, os {casino tickets}, a {mechanical fishing rod}, o {boss eye}, as {crandoria boots} e a {teleport stone}. Sobre qual voce gostaria de saber?'})
keywordHandler:addKeyword({'mechanical fishing rod'}, StdModule.say, {npcHandler = npcHandler, text = 'A Mechanical Fishing Rod pode ser comprada por {Online Tokens} com o NPC Online Token Shop, localizado abaixo do Templo de {Crandoria}.'})
keywordHandler:addKeyword({'lago da avareza'}, StdModule.say, {npcHandler = npcHandler, text = 'O Lago da Avareza fica no sentido leste do Templo de {Crandoria}. Nesse lago jogadores podem pescar itens valiosos utilizando uma {Mechanical Fishing Rod}.'})
keywordHandler:addKeyword({'black candle'}, StdModule.say, {npcHandler = npcHandler, text = 'A black candle fornece regeneração de vida e mana por tres horas enquanto equipada. Ela pode ser comprada por {online tokens} ou {tibia coins}, ou ainda pode ser obtida na {roleta} e com o NPC {Gambler}.'})
keywordHandler:addKeyword({'online tokens'}, StdModule.say, {npcHandler = npcHandler, text = 'A cada uma hora online, todo jogador recebe um Online Token. Esses tokens podem ser utilizados para comprar itens valiosos com o NPC {Online Token Shop}.'})
keywordHandler:addKeyword({'casino tickets'}, StdModule.say, {npcHandler = npcHandler, text = 'Os Casino Tickets sao utilizados para girar a {roleta} acima do Templo de {Crandoria}, tendo a chance de receber itens valiosos.'})
keywordHandler:addKeyword({'casino ticket'}, StdModule.say, {npcHandler = npcHandler, text = 'Os Casino Tickets sao utilizados para girar a {roleta} acima do Templo de {Crandoria}, tendo a chance de receber itens valiosos.'})
keywordHandler:addKeyword({'boss eye'}, StdModule.say, {npcHandler = npcHandler, text = 'O Boss Eye pode ser obtido apenas pela Game Store. Com ele o jogador pode saber quando as alavancas de cada boss estarao disponiveis novamente.'})
keywordHandler:addKeyword({'crandoria boots'}, StdModule.say, {npcHandler = npcHandler, text = 'As Crandoria Boots fornecem defesa, velocidade de regeneracao moderada de vida e mana. Elas podem ser obtidas na Game Store por {tibia coins}. '})
keywordHandler:addKeyword({'teleport stone'}, StdModule.say, {npcHandler = npcHandler, text = 'A Teleport Stone teletransporta o jogador que a utilize para o templo de sua cidade. Para que ela funcione, o jogador nao pode estar em batalha.'})
keywordHandler:addKeyword({'tibia coins'}, StdModule.say, {npcHandler = npcHandler, text = 'As tibia coins podem ser obtidas por meio de gratificacao de doacoes realizadas ao servidor ou dentro do jogo, trocando por experiencia, com o NPC {Former Queen}, na {Ilha da Rainha}.'})
keywordHandler:addKeyword({'autoloot'}, StdModule.say, {npcHandler = npcHandler, text = 'O sistema de autoloot permite ao personagem obter itens de loot de criaturas sem que seja necessario abrir o corpo. Jogadores free possuem 10 espaços na lista do autoloot, enquanto jogadores {VIP} possuem 20 espaços. Esse sistema pode ser controlado pelo {comando} !autoloot. ATENCAO: Apenas o jogador que deu mais dano no monstro podera receber o loot por esse sistema.'})
keywordHandler:addKeyword({'prisao'}, StdModule.say, {npcHandler = npcHandler, text = 'Jogadores que cometerem pequenas infracoes dentro do jogo serao mandados para a cadeia ou prisao. Na cadeia eles devem passar por um sistema de alavanca para iniciar a contagem de tempo de 30 minutos ate serem liberados. Entre os motivos para ir para a cadeia estao o {bot} totalmente AFK e ofensas moderadas a outros jogadores e ao pessoal da staff.'})
keywordHandler:addKeyword({'vip'}, StdModule.say, {npcHandler = npcHandler, text = 'O sistema VIP garante vantagens aos jogadores, como atalhos para bosses, alguns acessos liberados, aumento de taxas de exp, loot e skills e acesso aos treiners com dummy. A VIP pode ser comprada com {tibia coins} ou obtida ingame por meio da {roleta} e com {online tokens}.'})
keywordHandler:addKeyword({'roleta'}, StdModule.say, {npcHandler = npcHandler, text = 'A Roleta de Premios fica localizada sobre o Templo de Crandoria. Cada aposta na roleta tem o custo de 01 {Casino Ticket}.'})
keywordHandler:addKeyword({'tasks'}, StdModule.say, {npcHandler = npcHandler, text = 'No Crandoria OT temos dois sistemas de Tasks: O sistema convencional do Tibia Global com o NPC {Grizzly Adams} e as tasks com o comando !tasks. Para as tasks do Grizzly Adams, temos wiki no nosso site com as informacoes de onde encontrar os bosses.'})
keywordHandler:addKeyword({'grizzly adams'}, StdModule.say, {npcHandler = npcHandler, text = 'O NPC Grizzly Adams fica no sideste de {Crandoria}. Ele fornece tasks da Killing in the name of... Quest. Seu sistema de tasks funciona da mesma forma que o sistema no Tibia Global e pode ser usado para enfrentar bosses como a Demodras.'})
keywordHandler:addKeyword({'crandoria'}, StdModule.say, {npcHandler = npcHandler, text = 'Crandoria foi o principal lugar escolhido pelos antigos moradores de Thais, Carlin e Venore quando eles fugiram de suas cidades em razão do ataque de terriveis demônios. Hoje a cidade vive em paz, com seguranca e tranquilidade. Voce pode acessar Crandoria por barco ou pelo {tapete} mágico.'})
keywordHandler:addKeyword({'elvenshire'}, StdModule.say, {npcHandler = npcHandler, text = 'Elvenshire foi criada por elfos que habitavam Ab\'Denriel antes do ataque dos demônios. A cidade pode ser acessada diretamente por Crandoria, passando pelo campo dos Elfos Rebeldes, ou pelo barco do {Captain Whitepatch}.'})
keywordHandler:addKeyword({'hakata'}, StdModule.say, {npcHandler = npcHandler, text = 'Hakata foi construída em meio a Selva de Jagunda, o que a torna uma cidade muito perigosa. Tarantulas, Apes e Hydras cercam a cidade e aterrorizam seus habitantes. Hakata pode ser acessada pelo barco do {Captain Whitepatch} ou caminhando a partir de {Crandoria} ou {Valkesh}.'})
keywordHandler:addKeyword({'valkesh'}, StdModule.say, {npcHandler = npcHandler, text = 'Há muitos anos, em meio a um enorme deserto, foi construída Valkesh. A cidade é pacífica, mas o deserto que a cerca esconde grandes perigos. Tumbas, mumias, faraós e demônios podem ser encontrados no deserto de Valkesh. {Baltazar} também pode ser encontrado no deserto, oferecendo uma missao a quem aparecer. Valkesh pode ser acessada pelo barco do {Captain Whitepatch}.'})
keywordHandler:addKeyword({'chaos'}, StdModule.say, {npcHandler = npcHandler, text = 'Chaos fica na ilha de Serpentis e deve ser a menor cidade do Novo Continente. Localizada em uma ilha, a cidade sofre constantes ataques de elfos rebeldes que vivem por perto. A area externa da cidade pode ser acessada pelo {tapete} magico.'})
keywordHandler:addKeyword({'nivabi'}, StdModule.say, {npcHandler = npcHandler, text = 'Nivabi significa Novo Inicio. A cidade foi fundada pelos ultimos moradores de Issavi apos a destruicao da antiga cidade e sua fuga para o Novo Continente. Urmahlulu vive por aquelas terras atualmente e aterrotiza a vida dali. A cidade pode ser acessada pelo barco do {Captain Whitepatch}'})
keywordHandler:addKeyword({'nautis'}, StdModule.say, {npcHandler = npcHandler, text = 'Nautis ja foi habitada por pescadores ha muitos anos, mas devido ao ataque de criaturas das profundezas a cidade atualmente esta praticamente abandonada. Para chegar a Nautis os jogadores devem utilizar o {tapete} magico.'})
keywordHandler:addKeyword({'magincia'}, StdModule.say, {npcHandler = npcHandler, text = 'Ah! A cidade dos magos... Magincia foi fundada por magos que estudaram em Edron no passado. A cidade fica sobre enormes rochas e tem um ar misterioso. Muitas criaturas magicas poderosas habitam a ilha de Magincia. Barcos sao proibidos na ilha, restando apenas o {tapete} magico como transporte ate o lugar.'})
keywordHandler:addKeyword({'icehold'}, StdModule.say, {npcHandler = npcHandler, text = 'Criada por antigos barbaros, Icehold acolheu os novos habitantes de Svargrond quando a cidade foi destruida. Apesar de estar sob constantes ataques de barbaros que vivem por perto, a cidade possui um ar acolhedor para todos os guerreiros que passam por ali. Voce pode chegar em Icehold pelo {barco} do {Captain Whitepatch} ou pelo {tapete} magico.'})
keywordHandler:addKeyword({'roshamuul'}, StdModule.say, {npcHandler = npcHandler, text = 'Roshamuul foi a única cidade que se manteve apos o ataque dos demonios no antigo continente Tibiano. Apesar disso, a cidade esta praticamente em ruinas e no esquecimento. Para chegar la basta falar com o {Captain Whitepatch} e utilizar o seu {barco}.'})
keywordHandler:addKeyword({'anvillux'}, StdModule.say, {npcHandler = npcHandler, text = 'A cidade dos anoes. Anvillux foi contruida em uma ilha abaixo de uma montanha. A cidade esta cercada de enormes perigos e so pode ser acessada pelo {tapete} magico.'})
keywordHandler:addKeyword({'barco'}, StdModule.say, {npcHandler = npcHandler, text = 'Os barcos sao um otimo meio de se locomover no Novo Continente. Os principais barcos utilizados são os {botes}, o barco do {Captain Whitepatch} e o barco do servico particular do {Captain Donahue}. Sobre qual voce gostaria de saber mais?'})
keywordHandler:addKeyword({'captain whitepatch'}, StdModule.say, {npcHandler = npcHandler, text = 'O Captain Whitepatch foi contratado por algumas cidades do novo continente para transportar os bravos guerreiros entre elas. Voce pode encontra-lo na praia ao sul de {Crandoria}, alem de {Chaos}, {Elvenshire}, {Hakata}, {Icehold}, {Nivabi}, {Roshamuul} e {Valkesh}.'})
keywordHandler:addKeyword({'captain donahue'}, StdModule.say, {npcHandler = npcHandler, text = 'Captain Donahue navega nas terras do Novo Continente descobrindo locais que as pessoas desconhecem. Ele fica na praia de Crandoria e oferece seus servicos para transportar qualquer um para seus destinos especiais em troca de uma missao. A maioria dos locais para onde Captain Donahue pode te levar nao sao acessiveis de nenhuma outra forma.'})
keywordHandler:addKeyword({'botes'}, StdModule.say, {npcHandler = npcHandler, text = 'Em diversos lugares do mapa voce vai encontrar botes ancorados. Varios desses botes podem te levar gratuitamente para algum lugar novo do mapa, basta utiliza-los sem medo.'})
keywordHandler:addKeyword({'wheel of destiny'}, StdModule.say, {npcHandler = npcHandler, text = 'A Wheel of Destiny funciona perfeitamente no CrandoriaOT, mas voce deve utilizar o Client 13 para manipular da forma que voce deseja.'})
keywordHandler:addKeyword({'bot'}, StdModule.say, {npcHandler = npcHandler, text = 'Os bots podem ser utilizados no nosso servidor, mas nao sera permitido utilizar bot 100% afk para hunts de loot e exp. O bot 100% afk so sera permitido para {treino} de skills, para o sistema de {pesca} especial e para mensagens no chat de comercio. Quem desrespeitar as regras podera ser enviado para a {prisao}.'})
keywordHandler:addKeyword({'treino'}, StdModule.say, {npcHandler = npcHandler, text = 'Voce pode treinar suas skills nos treiners de forma totalmente AFK. Voce vai encontrar treiners em {Crandoria}, {Hakata}, {Valkesh} e {Anvillux}. Jogadores {VIP} possuem acesso a training monks com dummys, permitindo que treinem com {exercise} weapons simultaneamente.'})
keywordHandler:addKeyword({'exercise'}, StdModule.say, {npcHandler = npcHandler, text = 'As exercise weapons sao armas de treino que auxiliam no progresos das skills. Elas devem ser utilizadas em um {dummy}. As exercise weapons podem ser obtidas por meio do sistema de {recompensa diaria}, por {online tokens}, por {tibia coins} e por gold no jogo.'})
keywordHandler:addKeyword({'dummy'}, StdModule.say, {npcHandler = npcHandler, text = 'O dummy pode ser utilizado para o {treino} de skills. Um deles pode ser encontrado no {Depot} de {Crandoria} com acesso livre. Alem disso, jogadores {VIP} possuem acesso a dummies nas salas de treino e eles podem ser adquiridos na Game Store por {tibia coins}.'})
keywordHandler:addKeyword({'depot'}, StdModule.say, {npcHandler = npcHandler, text = 'Os depots sao locais onde voce pode armazenar todos os seus itens. Todas as principais {cidades} possuem um depot e todos sao ligados, portanto voce pode guardar seus itens em uma cidade e depois retirar os mesmos itens no depot de outra cidade. Jogadores free podem ter ate 2000 itens no depot, enquanto jogadores VIP possuem limite de 10000 itens.'})
keywordHandler:addKeyword({'npc'}, StdModule.say, {npcHandler = npcHandler, text = 'Temos diversos NPCs no nosso servidor. Posso te direcionar para os {mercadores} de loot de Crandoria, para os sistemas de {transporte} da cidade, ou para comerciantes de {pocoes}, {municoes}, {joias} ou {ferramentas}. Onde voce deseja ir?'})
keywordHandler:addKeyword({'promotion'}, StdModule.say, {npcHandler = npcHandler, text = 'Voce pode obter sua promotion por 20000 gold coins com o King Tibianus a oeste do Templo de Crandoria. Ele esta em uma pequena torre, acima da loja de Haroun.'})
keywordHandler:addKeyword({'mercadores'}, StdModule.say, {npcHandler = npcHandler, text = 'Ao leste do Templo de Crandoria ha uma feira com diversos mercadores que comprar seu loot. Basta sair do templo e seguir para a direita.'})
keywordHandler:addKeyword({'pocoes'}, StdModule.say, {npcHandler = npcHandler, text = 'Voce pode comprar pocoes e outros itens magicos com Xodet. Ele esta localizado a oeste do templo de Crandoria, encostado no {depot}. Basta sair pelas escadas e seguir para a esquerda.'})
keywordHandler:addKeyword({'municoes'}, StdModule.say, {npcHandler = npcHandler, text = 'Para comprar municoes basta falar com Vincent. Sua loja fica encostada na muralha de Crandoria no sentido oeste. Basta sair do templo pelas escadas e seguir para a esquerda.'})
keywordHandler:addKeyword({'ferramentas'}, StdModule.say, {npcHandler = npcHandler, text = 'A loja de ferramentas fica logo ao lado do Templo de Crandoria, encostada na parte de cima do {Depot}. Para chegar, saia do templo pelas escadas de cima e siga para a esquerda.'})
keywordHandler:addKeyword({'joias'}, StdModule.say, {npcHandler = npcHandler, text = 'A loja de joias da Jessica pode ser encontrada saindo do Templo pelas escadas de cima e seguindo pela esquerda. Sua loja fica encostada na parte de cima da muralha de {Crandoria}.'})
keywordHandler:addKeyword({'transporte'}, StdModule.say, {npcHandler = npcHandler, text = 'Em Crandoria os principais meios de transporte são os {barco}s e o {tapete} magico. O barco do {Captain Whitepatch} fica na praia ao sul. O {tapete} magico de Uzon fica sobre o portão norte da cidade.'})
keywordHandler:addKeyword({'tapete'}, StdModule.say, {npcHandler = npcHandler, text = 'O tapete magico de Uzon transporte os jogadores entre diversos locais por um preço justo. Esse sistema de {transporte} liga as cidades de {Crandoria}, {Icehold}, {Chaos}, {Magincia} e {Nautis}.'})
keywordHandler:addKeyword({'baltazar'}, StdModule.say, {npcHandler = npcHandler, text = 'Baltazar fica no deserto de Valkesh e oferece acesso a Sociedade dos Magos. Eles possuem um sistema de {world teleports} que ligam oito pontos distintos do mapa. Se voce completar sua quest, voce podera utilizar esse sistema. Jogadores {VIP} possuem acesso a esse sistema mesmo sem ter completado a quest.'})
keywordHandler:addKeyword({'mapa'}, StdModule.say, {npcHandler = npcHandler, text = 'Nosso mapa foi criado durante quase um ano e possui centenas de hunts com dezenas de {quests}. Voce pode checar o mapa do Novo Continente com indicações de algumas {hunts} no nosso {site}.'})
keywordHandler:addKeyword({'quests'}, StdModule.say, {npcHandler = npcHandler, text = 'O CrandoriaOT manteve a maior parte das quests classicas do Tibia Global, como a Soul War, Annihilator, POI, Inquisition, Secret Library, Grave Danger, Rotten Blood, Warzones, etc. Para checar alguns spoiler de quests, visite a Wiki em nosso {site} ou acompanhe nossas postagens no {instagram}.'})
keywordHandler:addKeyword({'site'}, StdModule.say, {npcHandler = npcHandler, text = 'Acesse nosso Site: www.crandoriaot.com.br'})
keywordHandler:addKeyword({'instagram'}, StdModule.say, {npcHandler = npcHandler, text = 'Acesse nosso Instagram: www.instagram.com/crandoriaot'})
keywordHandler:addKeyword({'former queen'}, StdModule.say, {npcHandler = npcHandler, text = 'A Formen Queen, ou Rainha Aposentada, ja foi cohecida como Queen Eloise quando era a Rainha de Carlin. Hoje ela vive na {ilha da rainha}. Ela troca {tibia coins} por experiência com qualquer guerreiro que tenha nivel 1000 ou superior.'})
keywordHandler:addKeyword({'ilha da rainha'}, StdModule.say, {npcHandler = npcHandler, text = 'A Ilha da Rainha abriga a {Former Queen} e o {Gambler} e so pode ser acessada por tartarugas marinhas misteriosas. Dizem que apenas um anao que fica na taverna de {Anvillux} sabe como encontrar o caminho ate as tartarugas.'})
keywordHandler:addKeyword({'gambler'}, StdModule.say, {npcHandler = npcHandler, text = 'O apostador, ou Gambler, vive na {ilha da rainha}. Ele faz apostas com jogadores, trocando dinheiro por itens aleatorios variados.'})
keywordHandler:addKeyword({'taxas'}, StdModule.say, {npcHandler = npcHandler, text = 'No CrandoriaOT as taxas de experiencia, skills e magic level seguem stages. Exp inicia em 25x e cai ate 1x no nivel 750. A taxa de loot atual e de 1.25x.'})
keywordHandler:addKeyword({'online token shop'}, StdModule.say, {npcHandler = npcHandler, text = 'O online token shop é um NPC localizado abaixo do templo de Crandoria. Ele vende itens especiais em troca de {online tokens}.'})
keywordHandler:addKeyword({'transporte'}, StdModule.say, {npcHandler = npcHandler, text = 'No Crandoria OT ha transportes por {barco}, {tapete} magico ou os {world teleports} de {Baltazar}.'})
keywordHandler:addKeyword({'world teleports'}, StdModule.say, {npcHandler = npcHandler, text = 'Os World Teleports ligam oito pontos do Novo Continente, sendo eles: Roshamuul, a Floresta de {Crandoria}, as proximidades de {Nivabi}, a ilha de Ilshenar, a Selva de Jagunda perto de {Hakata}, uma ilha das Ice Lands, os Emerald Gardens perto de Marapur e o deserto de {Valkesh}, onde fica o NPC {Baltazar}. Os teleports sao acessiveis por players VIP ou por quem completar a quest de {Baltazar}.'})



npcHandler:setMessage(MESSAGE_GREET, 'Ola, |PLAYERNAME|. Caso ja seja experiente no Tibia, posso te oferecer {informacoes} sobre o servidor CrandoriaOT. Se voce comecou agora no jogo, posso te ajudar nos primeiros passos. Se voce deseja aprender o basico, diga {yes}.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye. Recommend us for all Crandorians if you were satisfied with our service.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')


npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)

