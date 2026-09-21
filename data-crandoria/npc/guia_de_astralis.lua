local internalNpcName = "Guia de Astralis"
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
	lookBody = 119,
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
	{text = 'Tem alguma duvida sobre Astralis e os sistemas de fazenda? Mais informacoes aqui!'}
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
keywordHandler:addKeyword({'cultivo'}, StdModule.say, {npcHandler = npcHandler, text = 'O sistema de cultivo permite ao jogador cultivar plantas para colher e vender aos {NPC}s de Astralis. Voce pode trocar os produtos de seu cultivo por {foods especiais} que fornecem buffs unicos. Existem quatro tipos de {colheitas} possiveis no sistema de cultivo e as chances para se obter cada uma delas variam de acordo com a skill de {fist fighting}. Para cultivar sera necessario possuir um {Watering Can} e um scythe. As plantas possuem tres fases e o jogador precisa aguardar 15 miutos antes de irrigar as plantas da proxima fase.'})
keywordHandler:addKeyword({'foods especiais'}, StdModule.say, {npcHandler = npcHandler, text = 'A dona da padaria, Christine, e os {NPC}s do centro de Astralis oferecem alimentos especiais em troca de protudos da fazenda, ou seja, produtos de {colheita} ou {leite} de {vacas}.'})
keywordHandler:addKeyword({'foods'}, StdModule.say, {npcHandler = npcHandler, text = 'A dona da padaria, Christine, e os {NPC}s do centro de Astralis oferecem alimentos especiais em troca de protudos da fazenda, ou seja, produtos de {colheita} ou {leite} de {vacas}.'})
keywordHandler:addKeyword({'colheitas'}, StdModule.say, {npcHandler = npcHandler, text = 'As colheitas possiveis sao Raspberries, muito comuns, Peas, comuns, Aubergines, um pouco mais raras, e Dragonfruits, as mais raras de todas. As chances para pegar as melhores colheitas aumentam de acordo com as skills de {fist fighting}. Cada um dos {NPC}s no centro de Astralis negocia itens em troca de alguma das colheitas.'})
keywordHandler:addKeyword({'colheita'}, StdModule.say, {npcHandler = npcHandler, text = 'As colheitas possiveis sao Raspberries, muito comuns, Peas, comuns, Aubergines, um pouco mais raras, e Dragonfruits, as mais raras de todas. As chances para pegar as melhores colheitas aumentam de acordo com as skills de {fist fighting}. Cada um dos {NPC}s no centro de Astralis negocia itens em troca de alguma das colheitas.'})
keywordHandler:addKeyword({'fist fighting'}, StdModule.say, {npcHandler = npcHandler, text = 'A skill de fist fighting desempenha um papel importante em Astralis. O fist fighting aumenta as chances de pegar melhores {colheitas} no sistema de {cultivo}, melhora as chances de se obter minerais mais valiosos ao minerar {Living Crystals} e ainda aumenta suas chances de ter sucesso ao tentar tirar {leite} uma {vaca}.'})
keywordHandler:addKeyword({'npc'}, StdModule.say, {npcHandler = npcHandler, text = 'Calante, Gondariel, Taburok e Romira ficam no centro da cidade e compram produtos de {colheita} dos jogadores em troca de {foods especiais}, ouro ou {astralis coins}. Ao norte da cidade, Christine oferece astralis coins ou alguns cupcakes que fornecem buffs em troca de {leite}. Nos fundos do celeiro, {Sir Bowser} negocia itens muito valiosos por astralis coins. Proximo a entrada das {minas} de Astralis vive Kradok, um anao que pode forjar armas muito poderosas.'})
keywordHandler:addKeyword({'leite'}, StdModule.say, {npcHandler = npcHandler, text = 'Leite pode ser obtido de {vacas} utilizando um {Milk Churn} pelo sistema de {ordenha}. Esse produto valioso pode ser vendido para a {NPC} Christine, dona da padaria, em troca de astralis coins ou algumas {foods especiais}.'})
keywordHandler:addKeyword({'vaca'}, StdModule.say, {npcHandler = npcHandler, text = 'As vacas podem ser encontradas em algumas das casas da area VIP de Astralis ou no curral aberto ao norte de Astralis. Para acessar o curral aberto da cidade os jogadores precisam possuir nivel 600 ou superior. Jogadores podem obter leite de vacas pelo sistema de {ordenha}.'})
keywordHandler:addKeyword({'vacas'}, StdModule.say, {npcHandler = npcHandler, text = 'As vacas podem ser encontradas em algumas das casas da area VIP de Astralis ou no curral aberto ao norte de Astralis. Para acessar o curral aberto da cidade os jogadores precisam possuir nivel 600 ou superior. Jogadores podem obter leite de vacas pelo sistema de {ordenha}.'})
keywordHandler:addKeyword({'ordenha'}, StdModule.say, {npcHandler = npcHandler, text = 'O sistema de ordenha permie ao jogador obter leite de {vacas} utiliazndo um {milk churn}. Qualquer jogador com acesso a alguma vaca pode tirar leite a cada 4 horas. A chance de sucesso a cada tentativa depende das skills de {fist fighting} do jogador: quanto maior a skill, maior a chance de sucesso.'})
keywordHandler:addKeyword({'living crystals'}, StdModule.say, {npcHandler = npcHandler, text = 'Living Crystals sao cristais magicos encontrados nas {minas} de astralis. Jogadores podem minerar esses cristais em busca de pedras preciosas e itens magicos destinados a forjar {armas magicas}.'})
keywordHandler:addKeyword({'living crystal'}, StdModule.say, {npcHandler = npcHandler, text = 'Living Crystals sao cristais magicos encontrados nas {minas} de astralis. Jogadores podem minerar esses cristais em busca de pedras preciosas e itens magicos destinados a forjar {armas magicas}.'})
keywordHandler:addKeyword({'cristais magicos'}, StdModule.say, {npcHandler = npcHandler, text = 'Living Crystals sao cristais magicos encontrados nas {minas} de astralis. Jogadores podem minerar esses cristais em busca de pedras preciosas e itens magicos destinados a forjar {armas magicas}.'})
keywordHandler:addKeyword({'astralis coins'}, StdModule.say, {npcHandler = npcHandler, text = 'Astralis Coins são uma moeda especial criado pelo povo de Astralis. Com essas moedas voce pode comprar itens especiais de {Sir Bowser}, nos fundos do celeiro da cidade.'})
keywordHandler:addKeyword({'astralis coin'}, StdModule.say, {npcHandler = npcHandler, text = 'Astralis Coins são uma moeda especial criado pelo povo de Astralis. Com essas moedas voce pode comprar itens especiais de {Sir Bowser}, nos fundos do celeiro da cidade.'})
keywordHandler:addKeyword({'sir bowser'}, StdModule.say, {npcHandler = npcHandler, text = 'Sir Bowser vende itens valiosos em troca de {Astralis Coins}. Mas nao pense que esses itens serao baratos! Voce tera que gerar muito alimento de {colheitas} para os mercadores de Astralis para conseguir um desses tesouros inestimaveis.'})
keywordHandler:addKeyword({'historia'}, StdModule.say, {npcHandler = npcHandler, text = 'Astralis era uma ilha conhecida apenas por alguns elfos de Elvenshire e todos mantinham segredo de sua existencia. Quando Captain Donahue encontrou o lugar em suas navegacoes, o segredo foi revelado e todos quiseram vir para Astralis. Elfos, anoes e humanos encontraram juntos as terras onde estamos hoje. Terras ferteis e hoje produtivas, que fornecem alimento a todas as cidades do Novo Continente. Dizem que os moradores dessa cidade se sentem honrados por poderem morar aqui.'})
keywordHandler:addKeyword({'milk churn'}, StdModule.say, {npcHandler = npcHandler, text = 'O milk churn é um recipiente utilizado para coletar {leite} de {vacas} em Astralis. Ele pode ser obtido com a {NPC} Romira, no centro de Astralis, ou na Gamestore.'})
keywordHandler:addKeyword({'watering can'}, StdModule.say, {npcHandler = npcHandler, text = 'O watering can é uma ferramenta utilizada para irrigar as plantas nas fazendas de Astralis. Voce pode irrigar as plantas de cada etapa a cada 15 minutos ate poder colher todas com ums scythe.'})
keywordHandler:addKeyword({'minas'}, StdModule.say, {npcHandler = npcHandler, text = 'As minas de Astralis sao habitadas por {cristais magicos} que aparecem pelo local frequentemente. Jogadores de nivel 200 ou superior podem utilizar uma {crystal pickaxe} para minerar esses cristais em busca de pedras preciosas ou minerais magicos utilizados para forjar {armas magicas}. Quanto maior for seu {fist fighting}, maior a chance de conseguir minerais mais valiosos.'})
keywordHandler:addKeyword({'mineracao'}, StdModule.say, {npcHandler = npcHandler, text = 'As minas de Astralis sao habitadas por {cristais magicos} que aparecem pelo local frequentemente. Jogadores de nivel 200 ou superior podem utilizar uma {crystal pickaxe} para minerar esses cristais em busca de pedras preciosas ou minerais magicos utilizados para forjar {armas magicas}. Quanto maior for seu {fist fighting}, maior a chance de conseguir minerais mais valiosos.'})
keywordHandler:addKeyword({'crystal pickaxe'}, StdModule.say, {npcHandler = npcHandler, text = 'Para minerar os {living crystals} nas {minas} de Astralis sera necessario possuir uma crystal pickaxe. Ela pode ser obtida do NPC Gulok em sua loja, na entrada das minas.'})
keywordHandler:addKeyword({'armas magicas'}, StdModule.say, {npcHandler = npcHandler, text = 'O ferreiro {Kradok} foi o unico a descobrir os segredos de como fortalecer as armas Eldritch e transformar cada uma delas em uma Gilded Eldritch Weapon. Mas fazer isso nao sera facil nem barato, pelo que dizem...'})
keywordHandler:addKeyword({'kradok'}, StdModule.say, {npcHandler = npcHandler, text = 'Kradok e seu irmao, Gulok, se mudaram para Astralis assim que souberam das {minas} magicas da cidade. Uma vez estabelecidos, Gulok descobriu como minerar os {living crystals} enquanto Kradok aprendeu como manipular os minerais obtidos desses cristais para criar o que ele diz serem as {armas magicas} mais poderosas do Novo Continente.'})

npcHandler:setMessage(MESSAGE_GREET, 'Ola, |PLAYERNAME|. Bem vindo a Astralis, a cidade mais produtiva do Novo Continente. Posso te dar algumas informacoes sobre os sistemas de {cultivo}, {ordenha} e {mineracao). Tambem posso te falar mais sobre as {astralis coins}, o dinheiro de Astralis. Ou posso te falar um pouco sobre a {historia} ou sobre os {NPC}s da cidade. O que voce quer saber?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Ate mais! Se precisar de algo, sabe onde me encontrar.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Ate mais! Se precisar de algo, sabe onde me encontrar.')

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)

