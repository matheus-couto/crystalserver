local internalNpcName = "Guia de Crandoria"
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
	lookBody = 94,
	lookLegs = 78,
	lookFeet = 114,
	lookAddons = 3
}

npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 60000,
	chance = 50,
	{text = 'Tem alguma duvida sobre o servidor? Informacoes importantes sobre o CrandoriaOT aqui!'}
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


-- Basic
keywordHandler:addKeyword({'anti afk orb'}, StdModule.say, {npcHandler = npcHandler, text = 'O Anti Afk Orb sera um monstro que surge junto com a mensagem do sistema anti afk, ao lado do jogador. Se ele for morto antes do jogador responder a pergunta, o jogador sera preso. Dessa forma outros jogadores podem ajudar no controle de abuso de bot.'})
keywordHandler:addKeyword({'antiafk'}, StdModule.say, {npcHandler = npcHandler, text = 'O sistema antiafk impede que jogadores abusem dos bots de forma remota. Ele se consiste no envio de perguntas ao jogador a cada intervalo de tempo. O jogador ao receber a pergunta devera reponder em ate 15 minutos, ou sera enviado para a prisao. Alem disso, ha um sistema de {anti afk orb} importante no antiafk check.'})
keywordHandler:addKeyword({'sistemas'}, StdModule.say, {npcHandler = npcHandler, text = 'No CrandoriaOT temos diversos sistemas que os jogadores podem utilizar, como o sistema {VIP}, a {pesca} especial no lago de crandoria, o sistema de {autoloot}, os {online tokens}, a {wheel of destiny}, as {tasks}, a {prisao}, a {roleta} ou o sistema de obtencao de {tibia coins} no jogo. Sobre qual voce gostaria de saber?'})
keywordHandler:addKeyword({'comando'}, StdModule.say, {npcHandler = npcHandler, text = 'Os principais comandos para jogadores sao: !autoloot para o sistema de {autoloot}, !bless comprar as blesses por gold coins, !aol para comprar um amulet of loss e !task para utilizar o sistema de {tasks}.'})
keywordHandler:addKeyword({'comandos'}, StdModule.say, {npcHandler = npcHandler, text = 'Os principais comandos para jogadores sao: !autoloot para o sistema de {autoloot}, !bless comprar as blesses por gold coins, !aol para comprar um amulet of loss e !task para utilizar o sistema de {tasks}.'})
keywordHandler:addKeyword({'cidades'}, StdModule.say, {npcHandler = npcHandler, text = 'O Novo Continente possui diversas cidades, sendo as principais {Crandoria}, {Anvillux}, {Elvenshire}, {Hakata}, {Icehold}, {Chaos}, {Valkesh}, {Magincia}, {Nivabi}, {Roshamuul} e {Nautis}.'})
keywordHandler:addKeyword({'hunts'}, StdModule.say, {npcHandler = npcHandler, text = 'Nosso servidor possui uma enorme quantidade de hunts, sendo a maior parte delas criadas pela equipe Crandoria OT. Apesar disso, voce tambem vai encontrar diversas hunts do global espalhadas pelo nosso mapa. Para saber um pouco mais sobre as hunts, voce pode checar o {mapa} em nosso {site} ou nos seguir no {instagram}.'})
keywordHandler:addKeyword({'pesca'}, StdModule.say, {npcHandler = npcHandler, text = 'No CrandoriaOT temos um sistema de pescaria único: Se voce possui uma {Mechanical Fishing Rod} e algumas minhocas, voce pode pescar no {Lago da Avareza} de Crandoria, com possibilidades de pescar ouro, {casino tickets}, itens de imbuement e muito mais!'})
keywordHandler:addKeyword({'itens'}, StdModule.say, {npcHandler = npcHandler, text = 'O CrandoriaOT possui alguns itens especiais, enter eles a {black candle}, os {online tokens}, os {casino tickets}, a {mechanical fishing rod}, o {boss eye}, as {crandoria boots} e a {teleport stone}. Sobre qual voce gostaria de saber?'})
keywordHandler:addKeyword({'mechanical fishing rod'}, StdModule.say, {npcHandler = npcHandler, text = 'A Mechanical Fishing Rod pode ser comprada por {Online Tokens} com o NPC Online Token Shop, localizado no {Cassino}.'})
keywordHandler:addKeyword({'cassino'}, StdModule.say, {npcHandler = npcHandler, text = 'O Casino fica na Peninsula de Crandoria. Uma pequena ilha a sudoeste da cidade. Ela pode ser acessada por um pequeno bote na praia ou por um portal acima do templo de Crandoria.'})
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
keywordHandler:addKeyword({'promotion'}, StdModule.say, {npcHandler = npcHandler, text = 'Voce pode obter sua promotion por 20000 gold coins com o King Tibianus a leste do Templo de Crandoria. Ele esta em uma pequena torre, acima da loja de Haroun.'})
keywordHandler:addKeyword({'mercadores'}, StdModule.say, {npcHandler = npcHandler, text = 'Ao leste do Templo de Crandoria ha uma feira com diversos mercadores que comprar seu loot. Basta sair do templo e seguir para a direita.'})
keywordHandler:addKeyword({'pocoes'}, StdModule.say, {npcHandler = npcHandler, text = 'Voce pode comprar pocoes e outros itens magicos com Xodet. Ele esta localizado a oeste do templo de Crandoria, encostado no {depot}. Basta sair pelas escadas e seguir para a esquerda.'})
keywordHandler:addKeyword({'municoes'}, StdModule.say, {npcHandler = npcHandler, text = 'Para comprar municoes basta falar com Vincent. Sua loja fica encostada na muralha de Crandoria no sentido oeste. Basta sair do templo pelas escadas e seguir para a esquerda.'})
keywordHandler:addKeyword({'ferramentas'}, StdModule.say, {npcHandler = npcHandler, text = 'A loja de ferramentas fica logo ao lado do Templo de Crandoria, encostada na parte de cima do {Depot}. Para chegar, saia do templo pelas escadas de cima e siga para a esquerda.'})
keywordHandler:addKeyword({'joias'}, StdModule.say, {npcHandler = npcHandler, text = 'A loja de joias da Jessica pode ser encontrada saindo do Templo pelas escadas de cima e seguindo pela esquerda. Sua loja fica encostada na parte de cima da muralha de {Crandoria}.'})
keywordHandler:addKeyword({'transporte'}, StdModule.say, {npcHandler = npcHandler, text = 'Em Crandoria os principais meios de transporte são os {barco}s e o {tapete} magico. O barco do {Captain Whitepatch} fica na praia ao sul. O {tapete} magico de Uzon fica sobre o portão norte da cidade.'})
keywordHandler:addKeyword({'tapete'}, StdModule.say, {npcHandler = npcHandler, text = 'O tapete magico de Uzon transporte os jogadores entre diversos locais por um preço justo. Esse sistema de {transporte} liga as cidades de {Crandoria}, {Icehold}, {Chaos}, {Magincia} e {Nautis}.'})
keywordHandler:addKeyword({'baltazar'}, StdModule.say, {npcHandler = npcHandler, text = 'Baltazar fica no deserto de Valkesh e oferece acesso a Sociedade dos Magos. Eles possuem um sistema de {world teleports} que ligam oito pontos distintos do mapa. Se voce completar sua quest, voce podera utilizar esse sistema. Jogadores {VIP} possuem acesso a esse sistema mesmo sem ter completado a quest.'})
keywordHandler:addKeyword({'mapa'}, StdModule.say, {npcHandler = npcHandler, text = 'Nosso mapa foi criado durante quase um ano e possui centenas de hunts com dezenas de {quests}. Voce pode checar o mapa do Novo Continente com indicações de algumas {hunts} no nosso {site}.'})
keywordHandler:addKeyword({'quests'}, StdModule.say, {npcHandler = npcHandler, text = 'O CrandoriaOT manteve a maior parte das quests classicas do Tibia Global, como a Soul War, Annihilator, POI, Inquisition, Secret Library, Grave Danger, Rotten Blood, Warzones, etc. Voce tambem pode seguir os desafios dos Defensores de Crandoria com o {Comandante Crassus}.'})
keywordHandler:addKeyword({'site'}, StdModule.say, {npcHandler = npcHandler, text = 'Acesse nosso Site: www.crandoriaot.com.br'})
keywordHandler:addKeyword({'comandante crassus'}, StdModule.say, {npcHandler = npcHandler, text = 'O Comandante Crassus oferece diversas missoes para os guerreiros de Crandoria, auxiliando no seu progresso no jogo e ajudando os jogadores entregando experiencia e itens valiosos a cada missao finalizada.'})
keywordHandler:addKeyword({'instagram'}, StdModule.say, {npcHandler = npcHandler, text = 'Acesse nosso Instagram: www.instagram.com/crandoriaot'})
keywordHandler:addKeyword({'former queen'}, StdModule.say, {npcHandler = npcHandler, text = 'A Formen Queen, ou Rainha Aposentada, ja foi cohecida como Queen Eloise quando era a Rainha de Carlin. Hoje ela vive na {ilha da rainha}. Ela troca {tibia coins} por experiência com qualquer guerreiro que tenha nivel 1000 ou superior.'})
keywordHandler:addKeyword({'ilha da rainha'}, StdModule.say, {npcHandler = npcHandler, text = 'A Ilha da Rainha abriga a {Former Queen} e o {Gambler} e so pode ser acessada por tartarugas marinhas misteriosas. Dizem que apenas um anao que fica na taverna de {Anvillux} sabe como encontrar o caminho ate as tartarugas.'})
keywordHandler:addKeyword({'gambler'}, StdModule.say, {npcHandler = npcHandler, text = 'O apostador, ou Gambler, vive na {ilha da rainha}. Ele faz apostas com jogadores, trocando dinheiro por itens aleatorios variados.'})
keywordHandler:addKeyword({'taxas'}, StdModule.say, {npcHandler = npcHandler, text = 'No CrandoriaOT as taxas de experiencia, skills e magic level seguem stages. Exp inicia em 25x e cai ate 1x no nivel 750. A taxa de loot atual e de 1.25x.'})
keywordHandler:addKeyword({'online token shop'}, StdModule.say, {npcHandler = npcHandler, text = 'O online token shop é um NPC localizado no {Cassino}. Ele vende itens especiais em troca de {online tokens}.'})
keywordHandler:addKeyword({'transporte'}, StdModule.say, {npcHandler = npcHandler, text = 'No Crandoria OT ha transportes por {barco}, {tapete} magico ou os {world teleports} de {Baltazar}.'})
keywordHandler:addKeyword({'world teleports'}, StdModule.say, {npcHandler = npcHandler, text = 'Os World Teleports ligam oito pontos do Novo Continente, sendo eles: Roshamuul, a Floresta de {Crandoria}, as proximidades de {Nivabi}, a ilha de Ilshenar, a Selva de Jagunda perto de {Hakata}, uma ilha das Ice Lands, os Emerald Gardens perto de Marapur e o deserto de {Valkesh}, onde fica o NPC {Baltazar}. Os teleports sao acessiveis por players VIP ou por quem completar a quest de {Baltazar}.'})



npcHandler:setMessage(MESSAGE_GREET, 'Olá, |PLAYERNAME|. Posso te ajudar com informacoes e dicas importantes sobre o Crandoria OT, como meios de {transporte}, sistema {antiafk}, {itens}, {sistemas}, {comandos}, {promotion}, {treino} de skills, {cidades}, {NPC}s, {taxas} de exp e skills, {hunts} e {quests}. Sobre o que voce quer saber?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye. Recommend us for all Crandorians if you were satisfied with our service.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)

