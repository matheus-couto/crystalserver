local internalNpcName = "Bozo"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 273,
	lookHead = 0,
	lookBody = 77,
	lookLegs = 80,
	lookFeet = 79,
	lookAddons = 3
}

npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{text = 'Veenha falar com o Bozo!'},
	{text = 'Ja ouviu aquela do dragao? Onde - quer dizer, quando ... hahahaha! Ah nao, estraguei tudo!'},
	{text = 'A Guilda dos Tolos? Ta falando serio? Nao, claro que nao! Hahaha!'},
	{text = 'Seja bem vindo! Chegue mais perto...'}
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

local config = {
	[1] = {
		text = {
			[1] = 'Voce trouxe uma flor adequada para mim?',
			[2] = 'Voce nao trouxe uma flor adequada! Por que apenas tolos entram para a Guilda dos Tolos?',
			[3] = 'Muito bem. Essa flor servira perfeitamente, por assim dizer. Pergunte sobre outra missao quando estiver pronto.'
		},
		yes = true,
		removeItem = {itemId = 102},
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission1, value = 2},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 2}
		}
	},
	[2] = {
		text = {
			[1] = {
				'A proxima tarefa sera um pouco mais dificil. Tenho orgulho de ser o maior fabricante de bombas de mau cheiro de toda Tibia. Pare de rir, aspirante a tolo...',
				'A pior parte e conseguir o cheiro perfeito. Sempre que um slime morre, ele deixa uma nuvem de gas extremamente fedida...',
				'Se voce conseguir coletar esse cheiro nos primeiros segundos apos a morte do slime, teremos a substancia ideal para fabricar dezenas de bombas de mau cheiro...',
				'Pegue este frasco especial e encha-o com o cheiro perfeito. Depois volte aqui e conversaremos sobre sua missao.'
			}
		},
		addItem = {itemId = 125},
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission2, value = 1},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 3}
		}
	},
	[3] = {
		text = {
			[1] = 'Voce conseguiu o requintado mau cheiro de que precisamos?',
			[2] = 'Nao, nao conseguiu! Por que apenas tolos entram para a Guilda dos Tolos?',
			[3] = 'Urgh. Voce trouxe um material realmente eficiente. Tenho que admitir que voce tem talento para assuntos tao desagradaveis. Talvez esteja pronto para outra missao. Basta perguntar sobre ela.'
		},
		yes = true,
		removeItem = {itemId = 107},
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission2, value = 2},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 4}
		}
	},
	[4] = {
		text = {
			[1] = {
				'Acho que voce esta pronto para uma pequena promocao. Desde que conclua mais uma missao, e claro...',
				'Como voce deve saber, nada quebra o gelo tao facilmente ao conhecer novas pessoas quanto uma torta jogada na cara...',
				'Claro, esse costume acaba causando uma enorme falta de tortas de vez em quando. E e exatamente para isso que precisamos de voce. Mirabell, em Hakata, faz as tortas mais cremosas e grudentas do mundo...',
				'Traga uma duzia delas para mim, ou seja, 12 tortas, seu tolo. Depois volte e fale comigo sobre sua missao.'
			}
		},
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission3, value = 1},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 5}
		}
	},
	[5] = {
		text = {
			[1] = 'Entao, voce trouxe uma caixa cheia de tortas para mim?',
			[2] = 'Nao, nao trouxe! Por que apenas tolos entram para a Guilda dos Tolos?',
			[3] = {
				'Excelente. Pobre Harsky, pobre Stutch. Eles vao lamentar o dia em que ousaram bocejar durante uma apresentacao do magnifico Bozo...',
				'Mesmo assim, concedo a voce o titulo de Tolo em Treinamento pelos seus esforcos. Apenas nao deixe isso subir a sua cabeca e nao use esse titulo tao prestigioso para se exibir...',
				'Se estiver interessado em outra missao, fale comigo.'
			}
		},
		yes = true,
		removeItem = {itemId = 119},
		pie = true,
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission3, value = 2},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 6}
		}
	},
	[6] = {
		text = {
			[1] = {
				'Ah, entao o Tolo em Treinamento quer um pouco de acao? Muito bem. Acho que voce esta pronto para uma grande pegadinha. Mas antes preciso de 18 frascos cheios de vinho...',
				'Consiga todos eles e depois volte aqui para falar sobre sua missao.'
			}
		},
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission4, value = 1},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 7}
		}
	},
	[7] = {
		text = {
			[1] = 'Voce trouxe os 18 frascos de vinho?',
			[2] = 'Nao, nao trouxe! Por que apenas tolos entram para a Guilda dos Tolos?',
			[3] = {
				'Vamos ver. Coloquei tudo nesta caixa, que e identica aquelas em que o velho Xodet recebe suas pocoes de mana [1]adas...',
				'Aqui, pegue esta caixa e leve ate a loja de Xodet em Crandoria. La dentro voce vera a remessa mais recente [1]a. Basta usar esta caixa na outra para troca-las...',
				'Depois traga a caixa trocada de volta e fale comigo sobre sua missao.'
			}
		},
		yes = true,
		removeItem = {itemId = 2874, count = 18, subType = 2},
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission4, value = 2},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 8}
		},
		addItem = {itemId = 117}
	},
	[8] = {
		text = {
			[1] = 'Voce trouxe a caixa trocada de Xodet?',
			[2] = 'Nao, nao trouxe! Por que apenas tolos entram para a Guilda dos Tolos?',
			[3] = 'Entendo. Acho que em breve veremos alguns magos completamente bebados! Ou sera que estou enganado e voce esta pronto para desafios ainda maiores? Basta perguntar se voce ainda estiver tolo o bastante.'
		},
		yes = true,
		removeItem = {itemId = 118},
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission4, value = 3},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 9}
		}
	},
	[9] = {
		text = {
			[1] = {
				'Tenho uma excelente pegadinha em mente, mas sem a preparacao adequada voce acabaria cortado em pedacos pelos anoes. Por sorte descobri um artefato que pode salvar o dia...',
				'Existe uma torre misteriosa, conhecida como Triangle Tower, a oeste de Magincia. Nessa torre voce encontrara um relogio magico de que precisaremos para nossa perigosa diversao...',
				'Bem, eu ficarei com a diversao e voce com o perigo, mas tente ver isso pelo lado positivo... ou melhor, pelo meu lado. Agora va buscar esse relogio e depois volte para falar sobre sua missao.'
			}
		},
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission5, value = 1},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.TriangleTowerDoor, value = 1},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 10}
		}
	},
	[10] = {
		text = {
			[1] = 'Voce conseguiu o relogio?',
			[2] = 'Nao, ainda nao! Por que apenas tolos entram para a Guilda dos Tolos?',
			[3] = {
				'Rapaz, voce vai se divertir muito com esse relogio... isso se nao for capturado e morto. Tenho muita inveja de voce... Bozo: Escute bem, meu pequeno tolo. Esse relogio tem o poder de fazer voce avancar no tempo. Ele sera muito util quando voce for roubar a barba do imperador dos anoes...',
				'Ah, pare com isso, nao desmaie como um bebe. E perfeitamente seguro usar esse relogio... bem, quase. Entre escondido no quarto do imperador quando ele estiver vazio. Use o relogio bem ao lado do travesseiro da cama...',
				'Isso fara voce avancar no tempo. Voce aparecera ao lado do imperador adormecido. Os guardas estarao do lado de fora, entao nao deverao incomodar voce. Use uma faca de cozinha bem afiada para cortar a barba dele...',
				'Depois use rapidamente o relogio mais uma vez para avancar no tempo novamente. Voce devera aparecer em um momento em que todos ja tenham deixado o quarto...',
				'Saia de fininho e volte aqui para falar sobre sua missao. Como o relogio funcionara apenas essas duas vezes, tenha certeza de estar com a barba quando retornar.'
			}
		},
		yes = true,
		checkItemCount = 112,
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission5, value = 2},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 11}
		}
	},
	[11] = {
		text = {
			[1] = 'Voce conseguiu a barba?',
			[2] = 'Nao, nao conseguiu! Por que apenas tolos entram para a Guilda dos Tolos?',
			[3] = {
				'Voce conseguiu a barba e sobreviveu. Acho que pela primeira vez em toda a minha vida estou impressionado... nao, espere, era apenas uma pedra no meu sapato...',
				'Mesmo assim, como um pequeno reconhecimento pelos seus feitos, vou lhe contar como conseguir sua propria roupa de bobo da corte. Se estiver interessado em mais diversao e aventuras, peca mais missoes.'
			}
		},
		yes = true,
		checkStorage = Storage.Quest.U8_1.WhatAFoolishQuest.EmperorBeardShave,
		removeItem = {itemId = 113},
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission5, value = 3},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 12}
		}
	},
	[12] = {
		text = {
			[1] = 'Nao consigo pensar em nada no momento. Talvez voce devesse tentar conseguir sua roupa de bobo da corte.'
		}
	},
	[13] = {
		text = {
			[1] = 'Sabe, nada trouxe mais diversao e alegria para a humanidade do que a almofada de pum. Porem, fabrica-la e uma tarefa delicada. Primeiro traga 4 pedacos de couro de minotauro, depois conversaremos sobre esta missao.'
		},
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission6, value = 1},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 14}
		}
	},
	[14] = {
		text = {
			[1] = 'Voce trouxe os quatro couros de minotauro?',
			[2] = 'Nao, nao trouxe! Por que apenas tolos entram para a Guilda dos Tolos?',
			[3] = 'Muito bem, essa foi a primeira parte. Agora as coisas ficam mais dificeis. Para costurar tudo, precisamos de um fio extremamente fino, tao fino quanto a seda de uma aranha gigante. Traga um pouco de seda de aranha gigante e fale comigo sobre sua missao.'
		},
		yes = true,
		removeItem = {itemId = 5878, count = 4},
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission6, value = 2},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 15}
		}
	},
	[15] = {
		text = {
			[1] = 'Voce trouxe a seda da aranha gigante?',
			[2] = 'Nao, nao trouxe! Por que apenas tolos entram para a Guilda dos Tolos?',
			[3] = 'Vamos ver... um ponto aqui, outro ali... Pronto! Uma almofada de pum! Esta preparado para a parte divertida? Entao fale comigo sobre sua proxima missao.'
		},
		yes = true,
		removeItem = {itemId = 5879},
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission6, value = 3},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 16}
		},
		effect = CONST_ME_POFF
	},
	[16] = {
		text = {
			[1] = {
				'Agora que temos esta almofada de pum, seria um desperdicio nao usa-la, voce nao acha ...',
				'Nao diga nada! Eu ja sei o que passa pela sua mente travessa, meu amigo, e concordo plenamente. Leve esta almofada para Crandoria e coloque-a bem em uma das cadeiras do sofa do Rei Tibianus! Depois volte aqui e fale comigo sobre sua missao.'
			}
		},
		addItem = {itemId = 121},
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission6, value = 4},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 17}
		}
	},
	[17] = {
		text = {
			[1] = 'Voce colocou a almofada de pum na cadeira em Crandoria?',
			[2] = 'Nao, voce nao colocou! Por que apenas tolos tentam entrar para a Guilda dos Tolos?',
			[3] = 'Isso vai causar uma grande confusao em Crandoria. Acho que deveriamos fazer pegadinhas em muitos outros lugares para espalhar o humor pelo mundo inteiro. Fale comigo sobre sua proxima missao para saber mais.'

		},
		yes = true,
		checkStorage = Storage.Quest.U8_1.WhatAFoolishQuest.WhoopeeCushion,
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission6, value = 5},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 18}
		}
	},
	[18] = {
		text = {
			[1] = {
				'Chegou a hora de pregar uma pegadinha em uma comerciante arrogante. Descobri que Carina, a joalheira, tem um medo terrivel de ratos ...',
				'Sua tarefa e bem simples. Roube o rato de brinquedo do gato da Rainha Eloise e mostre-o para Carina em Chaos para mata-la de susto. Depois volte e conte sobre sua missao.'
			}
		},
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission7, value = 1},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.QueenEloiseCatDoor, value = 1},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 19}
		}
	},
	[19] = {
		text = {
			[1] = 'Voce foi ate Venore e assustou Carina como eu pedi?',
			[2] = 'Nao, voce nao fez isso! Por que apenas tolos tentam entrar para a Guilda dos Tolos?',
			[3] = 'Excelente. Os moradores de Chaos ficaram seguros das minhas pegadinhas por tempo demais. Se estiver pronto para outra missao, fale comigo.'

		},
		yes = true,
		checkStorage = Storage.Quest.U8_1.WhatAFoolishQuest.ScaredCarina,
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission7, value = 2},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 20}
		}
	},
	[20] = {
		text = {
			[1] = {
				'Esses moradores de Chaos acham que estao a salvo de nos. Eles nao poderiam estar mais enganados. Faca-os sentir a furia dos tolos! Pegue uma colher e colete um pouco de enxofre de um buraco de lava inativo ...',
				'Tenha muito cuidado ao pegar essa substancia altamente inflamavel. Depois vamos conversar sobre a proxima parte da sua missao.'
			}
		},
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission8, value = 1},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 21}
		}
	},
	[21] = {
		text = {
			[1] = 'Voce coletou o enxofre?',
			[2] = 'Nao, voce nao coletou! Por que apenas tolos entram para a Guilda dos Tolos?',
			[3] = 'Muito bem, essa foi a primeira parte do meu plano genialmente tolo. Agora viaje para a Floresta de Jagunda, nos arredores de Hakata, e use uma faca de cozinha para cortar algumas folhas do arbusto jungle dweller para mim. Traga-as quando voltar para falar sobre sua missao.'
		},
		yes = true,
		removeItem = {itemId = 124},
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission8, value = 2},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 22}
		}
	},
	[22] = {
		text = {
			[1] = 'Voce trouxe as folhas?',
			[2] = 'Nao, voce nao trouxe! Por que apenas tolos entram para a Guilda dos Tolos?',
			[3] = 'Ate aqui tudo certo. Vou preparar uma surpresa bem desagradavel para sua proxima missao. Fale comigo sobre ela quando estiver pronto.'
		},
		yes = true,
		removeItem = {itemId = 3129},
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission8, value = 3},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 23}
		}
	},
	[23] = {
		text = {
			[1] = {
				'Veja so, alguem fez charutos explosivos usando o enxofre e as folhas! Coincidentemente, tive uma excelente ideia de como podemos usa-los ...',
				'Pegue este charuto e entregue-o para Theodore Loveless, o representante de Venore em Liberty Bay. Depois que voce [1] nosso pequeno "presente", volte aqui e conte como foi sua missao.'
			}
		},
		addItem = {itemId = 141},
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission8, value = 4},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 24}
		}
	},
	[24] = {
		text = {
			[1] = 'Voce [1] o charuto explosivo para Theodore Loveless?',
			[2] = 'Nao, voce nao fez isso! Por que apenas tolos entram para a Guilda dos Tolos?',
			[3] = 'Voce e um sujeito e tanto, aposto que se divertiu. Como representa tudo o que um verdadeiro tolo deve ser, vou lhe dar este ceptro do tolo para complementar sua roupa de bobo da corte. Se tiver interesse, ainda ha muitas outras missoes para um tolo como voce. Basta perguntar sobre elas.'
		},
		yes = true,
		checkStorage = Storage.Quest.U8_1.WhatAFoolishQuest.Cigar,
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission8, value = 5},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 25}
		},
		-- addItem = {itemId = 895},
		addon = 1
	},
	[25] = {
		text = {
			[1] = {
				'Bem, acho que um verdadeiro tolo deve pensar grande. Entao nossa proxima pequena pegadinha sera em grande escala. Claro que isso exigira alguma preparacao ...',
				'Primeiro, pegue este frasco e use-o em um stalker morto imediatamente apos sua morte para coletar seu sangue ainda quente. Volte para falar sobre sua missao quando terminar.'
			}
		},
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission9, value = 1},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 26}
		},
		addItem = {itemId = 125}
	},
	[26] = {
		text = {
			[1] = 'Voce conseguiu o sangue de que precisamos?',
			[2] = 'Nao, voce nao conseguiu! Por que apenas tolos entram para a Guilda dos Tolos?',
			[3] = {
				'Parabens! Agora vamos falar da parte complicada. Precisamos da tinta de um quara constrictor. Use este frasco em um cadaver fresco para coletar a tinta ...',
				'Pare de fazer essas caretas! Eu sei que e uma tarefa tola, mas e justamente isso que a torna divertida. Consiga a tinta e depois volte para falar comigo sobre sua missao.'
			}
		},
		yes = true,
		removeItem = {itemId = 19102},
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission9, value = 2},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 27}
		},
		addItem = {itemId = 125}
	},
	[27] = {
		text = {
			[1] = 'Voce conseguiu a tinta do quara constrictor?',
			[2] = 'Nao, voce nao conseguiu! Por que apenas tolos entram para a Guilda dos Tolos?',
			[3] = 'Excelente. Como um verdadeiro tolo, e claro que voce nao faz ideia para que servem esses ingredientes, mas eu vou esclarece-lo. Basta perguntar sobre sua proxima missao e eu lhe contarei tudo o que precisa saber.'
		},
		yes = true,
		removeItem = {itemId = 9149},
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission9, value = 3},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 28}
		}
	},
	[28] = {
		text = {
			[1] = {
				'O sangue de um stalker e a tinta de um quara sao os principais ingredientes para nossa proxima pegadinha. Misture os dois para obter uma excelente tinta que desaparece ...',
				'Ela parece exatamente igual a tinta comum, porem, quando exposta ao ar, desaparece em poucos minutos. Tenho certeza de que voce entende como essa tinta pode ser util ...',
				'Agora escute meu plano. Va ate Sam e encomende 2000 escudos de aco. Ele jamais aceitara se voce nao assinar um contrato ...',
				'Use a tinta que desaparece para assinar o contrato e depois entregue o papel de volta para ele. Isso mantera esse velho rabugento ocupado por um bom tempo. Fale comigo sobre sua missao quando terminar.'
			}
		},
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission9, value = 4},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 29}
		},
		addItem = {itemId = 127}
	},
	[29] = {
		text = {
			[1] = 'Entao, voce ja enganou o velho Sam?',
			[2] = 'Nao, voce ainda nao conseguiu! Por que apenas tolos entram para a Guilda dos Tolos?',
			[3] = 'Que pegadinha esplendida! Se estiver pronto para mais, pergunte-me sobre a proxima missao.'
		},
		yes = true,
		checkStorage = Storage.Quest.U8_1.WhatAFoolishQuest.Contract,
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission9, value = 5},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 30}
		}
	},
	[30] = {
		text = {
			[1] = {
				'Desta vez nao tenho uma missao de verdade para voce, apenas um pequeno favor. Aposto que esperava alguma aventura perigosa e cansativa, mas como gosto muito de voce, vou facilitar muuuuito as coisas ...',
				'Aqui estao alguns biscoitos. Mas cuidado, eles sao biscoitos de confete explosivo. Voce tera que [1] para 10 pessoas especiais. Depois volte aqui e conte como foi sua missao. Parece facil, nao e? Voce aceita esta missao?'
			},
			[3] = {
				'Otimo! Essas sao palavras de um verdadeiro tolo! Talvez seja melhor anotar os nomes. Vamos la: [1] um biscoito para: ...',
				'O pomposo heroi Avar Tar em Magincia, Simon o mendigo ganancioso em Hakata, a pirata Ariella na loja de comidas de Chaos, o suspeito Lorbas ao lado das Ruinas Abandonadas perto de Crandoria, o Rei Markwin no acampamento de minotauros de Magincia ...',
				'O xama Hjaern nas Ice Islands, a bruxa Wyda no Pantano de Murkwood, o macaco Hairycles nas Ruinas dos Macacos ...',
				'O rei dos orcs na Fortaleza Orc de Crandoria e o ultimo para OU Yaman, o djinn verde, OU Nah\'Bob, o djinn azul ...',
				'Moleza, nao e? Voce anotou tudo? Se precisar da lista novamente, e so me pedir. Caso contrario, va agora e volte para falar da missao quando terminar.'
			}
		},
		yes = true,
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission10, value = 1},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 31}
		},
		addItem = {itemId = 130, count = 10}
	},
	[31] = {
		text = {
			[1] = 'Voce terminou sua pequena missao de entrega?',
			[3] = 'De fato, voce terminou. A proposito, esta parecendo um pouco cansado e sujo. Mas, se ainda tiver um pouco de energia, pergunte-me sobre a proxima missao.'
		},
		yes = true,
		cookiesDelivery = true,
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission10, value = 2},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 32}
		}
	},
	[32] = {
		text = {
			[1] = {
				'Tenho certeza de que voce esta se perguntando quantas missoes cansativas o velho Bozo ainda tem para voce! Nao se preocupe! Voce esta quase terminando, resta apenas uma ultima missao ...',
				'Bem, isso depois que conseguir os materiais necessarios. Antes de tudo, traga-me 5 pedacos de pano branco. Depois conversaremos mais sobre sua missao.'
			}
		},
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission11, value = 1},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 33}
		}
	},
	[33] = {
		text = {
			[1] = 'Voce conseguiu 5 pedacos de pano branco?',
			[2] = 'Nao, voce nao conseguiu! Por que apenas tolos entram para a Guilda dos Tolos?',
			[3] = {
				'Muito bem. Porem, odeio muuuito dizer isso, mas... desse jeito, tao branco, ele nao nos serve. Nao se preocupe. Ha uma maneira de deixa-lo velho e desgastado ...',
				'O sol impiedoso do deserto, combinado com os vapores toxicos do Plague Spike no Deserto de Chaos, fara o servico ...',
				'Viaje para Chaos, va ate o deserto e procure um bom lugar para deixar a natureza fazer o trabalho. Talvez algo como um altar seja util. Quando terminar, volte aqui para saber qual e o proximo passo da sua missao.'
			}
		},
		yes = true,
		removeItem = {itemId = 5909, count = 5},
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission11, value = 2},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 34}
		},
		addItem = {itemId = 142}
	},
	[34] = {
		text = {
			[1] = 'Voce trouxe um pedaco de pano velho e desgastado?',
			[2] = 'Nao, voce nao trouxe! Por que apenas tolos entram para a Guilda dos Tolos?',
			[3] = {
				'Muito bem, muito bem. Agora vamos para a ultima etapa do nosso plano tolo. Como sou muito esperto, usei uma tesoura para fazer algumas faixas velhas e desgastadas com o pano que voce trouxe. NAO toque nelas ainda ...',
				'Viaje para Valkesh e visite o califa Kazzan. Use as faixas feitas do pano desgastado para se disfarcar de mumia ...',
				'Por fim, converse com o califa e de a ele o maior susto de sua vida. Depois volte aqui e conte-me como foi a diversao dessa missao.'
			}
		},
		yes = true,
		removeItem = {itemId = 143},
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission11, value = 3},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 35}
		},
		addItem = {itemId = 144}
	},
	[35] = {
		text = {
			[1] = 'Entao, meu dedicado aprendiz, voce ja assustou o califa?',
			[2] = 'Nao, voce nao assustou! Por que apenas tolos entram para a Guilda dos Tolos?',
			[3] = 'Por Kurik, eu sabia que voce tinha isso dentro de si. Voce e exatamente o tipo de tolo que eu admiro. Tome este chapeu de bobo da corte, voce o merece. Ele combinara perfeitamente com sua roupa de bobo da corte.'
		},
		yes = true,
		checkStorage = Storage.Quest.U8_1.WhatAFoolishQuest.ScaredKazzan,
		updateStorages = {
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Mission11, value = 4},
			{key = Storage.Quest.U8_1.WhatAFoolishQuest.Questline, value = 36}
		},
		addItem = {itemId = 894},
		addon = 2,
		last = true
	},
	[36] = {
		text = {
			[1] = 'Agora voce e um tolo totalmente treinado e se tornou um verdadeiro bobo da corte. Sua missao final e levar alegria e diversao para todo o mundo.'
		}
	}
}

local jesterOutfit = {
	[-1] = {
		text = {
			[1] = 'Primeiro precisaremos de um pedaco de tecido vermelho. Voce o trouxe?',
			[2] = 'Certo, agora precisamos de um pedaco de tecido azul. Voce tem um com voce por acaso?'
		},
		removeItemId = 5911,
		newValue = 1,
		choice = 1
	},
	[1] = {
		text = {
			[1] = 'Agora precisamos de um pedaco de tecido azul. Voce tem um com voce por acaso?',
			[2] = 'Certo, agora precisamos de um pedaco de tecido verde. Voce tem um com voce por acaso?'
		},
		removeItemId = 5912,
		newValue = 2,
		choice = 2
	},
	[2] = {
		text = {
			[1] = 'Agora precisamos de um pedaco de tecido verde. Voce tem um com voce por acaso?',
			[2] = 'Por fim precisamos de um pedaco de tecido amarelo. Voce tem um com voce por acaso?'
		},
		removeItemId = 5910,
		newValue = 3,
		choice = 3
	},
	[3] = {
		text = {
			[1] = 'Agora precisamos de um pedaco de tecido amarelo. Voce tem um com voce por acaso?',
			[2] = 'Perfeito. Aqui esta sua roupa de bobo da corte. Admito que ela e um pouco simples, mas talvez voce consiga alguns acessorios interessantes em breve. Pelo menos agora voce esta vestido de forma adequada para suas proximas missoes.'
		},
		removeItemId = 5914,
		newValue = 4,
		addOutfit = true,
		last = true
	}
}

local value = {}

local function greetCallback(npc, creature)
	local playerId = creature:getId()
	if Player(creature):getSex() == PLAYERSEX_MALE then
		npcHandler:setMessage(MESSAGE_GREET, 'Ola, como vai, |PLAYERNAME|! O que traz voce {aqui}? Gostaria de {entrar} para os Tolos?')
	else
		npcHandler:setMessage(MESSAGE_GREET, 'Ola, ola, ola, mocinha |PLAYERNAME|! O que traz voce {aqui}?')
	end
	value[playerId] = nil
	return true
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, 'join') then
		if player:getStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.Questline) ~= -1 then
			npcHandler:say('Uau, sua estupidez seria motivo de orgulho e alegria para todo tolo. Voce ja se candidatou como membro. Vamos falar sobre sua missao atual.', npc, creature)
			return true
		end

		npcHandler:say('Voce deseja se tornar um bobo da corte e se juntar a guilda dos tolos?', npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif MsgContains(message, 'mission') or MsgContains(message, 'missao') then
		local targetValue = config[player:getStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.Questline)]
		if not targetValue then
			return true
		end

		if not targetValue.yes then
			if targetValue.updateStorages then
				for i = 1, #targetValue.updateStorages do
					local storage = targetValue.updateStorages[i]
					player:setStorageValue(storage.key, storage.value)
				end
			end

			if targetValue.addItem then
				player:addItem(targetValue.addItem.itemId, targetValue.addItem.count or 1)
			end
		end

		npcHandler:say(targetValue.text[1], npc, creature)
		if targetValue.yes then
			npcHandler:setTopic(playerId, 3)
			value[playerId] = targetValue
		end
	elseif MsgContains(message, 'jester outfit') then
		if player:getStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.Questline) == 12 then
			local targetValue = jesterOutfit[player:getStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.JesterOutfit)]
			if not targetValue then
				return true
			end

			npcHandler:say(targetValue.text[1], npc, creature)
			npcHandler:setTopic(playerId, 4)
			value[playerId] = targetValue
		else
			npcHandler:say('Tenho certeza de que te serve muito bem.', npc, creature)
		end
	elseif MsgContains(message, 'flask') then
		if player:getStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.Questline) > 2 and player:getStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.Questline) < 8 then
			npcHandler:say('Voce precisa de um flask novo para a quest?', npc, creature)
			npcHandler:setTopic(playerId, 15)
		end
	elseif MsgContains(message, 'yes') then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say({
				'Entao voce quer fazer um completo idiota de si mesmo? Tudo bem por mim, mas saiba que se tornar um verdadeiro tolo significa mais do que ser apenas um tolo comum ...',
				'Voce tera que dominar uma serie de missoes desafiadoras, longas e, acima de tudo, totalmente tolas ...',
				'Voce tem certeza de que quer desperdicar uma parte do seu tempo de vida limitado em uma missao que fara voce parecer um tolo e que podera recompensa-lo com o prestigioso titulo de grande tolo em um futuro muito distante?'
			}, npc, creature)
			npcHandler:setTopic(playerId, 2)
		elseif npcHandler:getTopic(playerId) == 2 then
			player:setStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.Questline, 1)
			player:setStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.Questlog, 1)
			player:setStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.Mission1, 1)
			npcHandler:say({
				'Que decisao tola! Voce e realmente um candidato digno! Mas vamos falar sobre negocios ...',
				'Ser um bobo da corte nao se trata apenas de contar piadas. Um bom bobo da corte depende muito de seus acessorios ...',
				'Conseguir alguns acessorios sera seu primeiro trabalho. Antes de tudo, precisamos de um bom suprimento de flores esguichadoras de agua ...',
				'Eu mesmo as preparo no meu tempo livre, mas preciso do material certo. A leste de Magincia, ao lado do Templo da Flor Branca, voce encontrara as flores ideais ...',
				'Pegue uma faca de cozinha, corte a flor mais grossa e saudavel e traga-a ate aqui. Depois fale comigo sobre sua missao.'
			}, npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 3 then
			local targetValue = value[playerId]
			if targetValue.checkStorage then
				if player:getStorageValue(targetValue.checkStorage) ~= 1 then
					npcHandler:say(targetValue.text[2], npc, creature)
					npcHandler:setTopic(playerId, 0)
					return true
				end
			end

			if targetValue.removeItem then
				if not player:removeItem(targetValue.removeItem.itemId, targetValue.removeItem.count or 1, targetValue.removeItem.subType or -1) then
					npcHandler:say(targetValue.text[2], npc, creature)
					npcHandler:setTopic(playerId, 0)
					return true
				end
			end

			if targetValue.checkItemCount then
				if player:getItemCount(targetValue.checkItemCount) == 0 then
					npcHandler:say(targetValue.text[2], npc, creature)
					npcHandler:setTopic(playerId, 0)
					return true
				end
			end

			if targetValue.cookiesDeliveryy then
				if player:getCookiesDelivered() ~= 10 then
					npcHandler:say('Nao. Mentira! Por que apenas os mais tolos se aplicam a Guilda dos Tolos?...', npc, creature)
					npcHandler:setTopic(playerId, 0)
					return true
				end
			end

			if targetValue.pie then
				if player:getStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.PieBoxTimer) > 0
						and player:getStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.PieBoxTimer) < os.time() then
					npcHandler:say('Eeeeh! O que voce fez?? Aquelas tortas estao cheias de insetos! Devem ser os famosos insetos dos pacotes! Pegue outras tortas, seu tolo. E dessa vez tem que ser de qualidade!', npc, creature)
					npcHandler:setTopic(playerId, 0)
					return true
				end
			end

			if targetValue.updateStorages then
				for i = 1, #targetValue.updateStorages do
					local storage = targetValue.updateStorages[i]
					player:setStorageValue(storage.key, storage.value)
				end
			end

			if targetValue.addItem then
				player:addItem(targetValue.addItem.itemId, targetValue.addItem.count or 1)
			end

			if targetValue.addon then
				player:addOutfitAddon(270, targetValue.addon)
				player:addOutfitAddon(273, targetValue.addon)
				local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
				player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
				player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			end

			if targetValue.effect then
				npc:getPosition():sendMagicEffect(targetValue.effect)
			end

			if targetValue.last then
				player:addAchievement('Perfect Fool')
				player:addAchievement('Fool at Heart')
			end

			npcHandler:say(targetValue.text[3], npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 4 then
			local targetValue = value[playerId]
			if not player:removeItem(targetValue.removeItemId, 1) then
				npcHandler:say('Nao. Mentira! Por que apenas os mais tolos se aplicam a Guilda dos Tolos?...', npc, creature)
				npcHandler:setTopic(playerId, 0)
				return true
			end

			player:setStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.JesterOutfit, targetValue.newValue)
			if targetValue.addOutfit then
				player:addOutfit(270)
				player:addOutfit(273)
				local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
				player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
				player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
				player:setStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.Questline, 13)
			end
			npcHandler:say(targetValue.text[2], npc, creature)
			if not targetValue.last then
				value[playerId] = jesterOutfit[targetValue.choice]
			else
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 15 then
			npcHandler:say('Certo. Aqui esta voce!', npc, creature)
			player:addItem(125, 1)
		end
	elseif MsgContains(message, 'no') and npcHandler:getTopic(playerId) ~= 0 then
		if isInArray({1, 2}, npcHandler:getTopic(playerId)) then
			npcHandler:say('Que pena. Achei que voce tinha o necessario.', npc, creature)
		elseif isInArray({3, 4}, npcHandler:getTopic(playerId)) then
			if player:getStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.Questline) == 11
					and player:getStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.EmperorBeardShave) == 1 then
				player:setStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.Questline, 12)
				player:setStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.Mission5, 3)
				npcHandler:say({
					'Voce barbeou o imperador, mas perdeu a barba? Que tipo de tolo voce e? Bem, pelo menos ele tera uma bela surpresa quando acordar ...',
					'Ainda assim, como um pequeno reconhecimento pelas suas conquistas, estou disposto a dizer como conseguir sua propria roupa de bobo da corte. Se voce estiver interessado em mais diversao e aventuras, peca-me mais missoes.'
				}, npc, creature)
			elseif player:getStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.Questline) == 30 then
				npcHandler:say('You won\'t be successful in the fool\'s world with such an attitude.', npc, creature)
			elseif player:getStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.Questline) == 35
					and player:getStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.LostDisguise) ~= 1 then
				player:addItem(144, 1)
				player:setStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.LostDisguise, 1)
				npcHandler:say('Desperdicou o disfarce?? Voce deve ser o mais tolo de todos.. Aqui... tente novamente, mas tenha cuidado dessa vez.', npc, creature)
			else
				npcHandler:say('Nao. Mentira! Por que apenas os mais tolos se aplicam a Guilda dos Tolos?...', npc, creature)
			end
		end
		npcHandler:setTopic(playerId, 0)
	end
	return true
end

keywordHandler:addKeyword({'sorcerer'}, StdModule.say, {npcHandler = npcHandler, text = 'I wanted to become a sorcerer, too, but I was overqualified!'}, function(player) return player:isSorcerer() end)
keywordHandler:addKeyword({'druid'}, StdModule.say, {npcHandler = npcHandler, text = 'I wanted to become a druid, too, but I was overqualified!'}, function(player) return player:isDruid() end)
keywordHandler:addKeyword({'paladin'}, StdModule.say, {npcHandler = npcHandler, text = 'I wanted to become a paladin, too, but I was overqualified!'}, function(player) return player:isPaladin() end)
keywordHandler:addKeyword({'knight'}, StdModule.say, {npcHandler = npcHandler, text = 'I wanted to become a knight, too, but I was overqualified!'}, function(player) return player:isKnight() end)
keywordHandler:addKeyword({'sorcerer'}, StdModule.say, {npcHandler = npcHandler, text = 'The good thing about them is that they can\'t be at two places at the same time.'})
keywordHandler:addKeyword({'druid'}, StdModule.say, {npcHandler = npcHandler, text = 'I wonder if they love my water squirt flowers as much as all other plants.'})
keywordHandler:addKeyword({'paladin'}, StdModule.say, {npcHandler = npcHandler, text = 'They are the king\'s favourites, because they know how to \'bow\'.'})
keywordHandler:addKeyword({'knight'}, StdModule.say, {npcHandler = npcHandler, text = 'Did you notice that old knights have their scars just on their backs?'})

keywordHandler:addKeyword({'here'}, StdModule.say, {npcHandler = npcHandler, text = 'A fitting place for a {jester}. I guess there are worse {jobs} around.'})
keywordHandler:addKeyword({'king'}, StdModule.say, {npcHandler = npcHandler, text = 'Bozo: Nah, no jests about His Royal Highness.'})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, text = 'I rarely leave the castle. It\'s really stressful to be as popular as me.'})
keywordHandler:addKeyword({'castle'}, StdModule.say, {npcHandler = npcHandler, text = 'This castle is my home. A fitting place for a jester and all other fools. Feel welcome.'})
keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m a jester, not a doctor!'})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = 'My name is Bozo. But it\'s more than a name, it\'s a lifestyle for me!'})
keywordHandler:addKeyword({'bozo'}, StdModule.say, {npcHandler = npcHandler, text = 'That\'s me: Bozo, the jester!'})
keywordHandler:addKeyword({'guild'}, StdModule.say, {npcHandler = npcHandler, text = 'Ever since the first guild was created, there is a great demand of jesters and fools to join them.'})
keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, text = 'Sell? Hmm, I know a little about magic and by chance I can sell you a truly unusual {weapon}.'})
keywordHandler:addKeyword({'joke'}, StdModule.say, {npcHandler = npcHandler, text = 'I know some \'monstrous\' jokes!'})
keywordHandler:addKeyword({'news'}, StdModule.say, {npcHandler = npcHandler, text = 'I know the newest jokes in tibia.'})
keywordHandler:addKeyword({'how', 'are', 'you'}, StdModule.say, {npcHandler = npcHandler, text = 'Thank you, I\'m fine, the gods are with me.'})
keywordHandler:addKeyword({'necromant', 'nectar'}, StdModule.say, {npcHandler = npcHandler, text = 'Pheeew! That sounds disgusting! Are you a cook at Frodo\'s?'})
keywordHandler:addKeyword({'necromant'}, StdModule.say, {npcHandler = npcHandler, text = 'Don\'t feed the necromants.'})
keywordHandler:addKeyword({'dog'}, StdModule.say, {npcHandler = npcHandler, text = 'Are we talking about Noodles?'})
keywordHandler:addKeyword({'poodle'}, StdModule.say, {npcHandler = npcHandler, text = 'Are we talking about Noodles?'})
keywordHandler:addKeyword({'noodles'}, StdModule.say, {npcHandler = npcHandler, text = 'Hey, the little one is almost as funny as me!'})
keywordHandler:addKeyword({'muriel'}, StdModule.say, {npcHandler = npcHandler, text = 'Better don\'t mess with sorcerers!'})
keywordHandler:addKeyword({'elane'}, StdModule.say, {npcHandler = npcHandler, text = 'She\'s pretty but too serious for my taste.'})
keywordHandler:addKeyword({'marvik'}, StdModule.say, {npcHandler = npcHandler, text = 'Humourless old guy! Once, he turned me into a frog for painting his distasteful cave in pink.'})
keywordHandler:addKeyword({'gregor'}, StdModule.say, {npcHandler = npcHandler, text = 'A man of steel with a stomach of wax. Never offer him a beer!'})
keywordHandler:addKeyword({'quentin'}, StdModule.say, {npcHandler = npcHandler, text = 'He\'s my baby brother. If you tell him I sent you, he will grant you an extra spell or two.'})
keywordHandler:addKeyword({'gorn'}, StdModule.say, {npcHandler = npcHandler, text = 'He sells spell scrolls each day at midnight, but you have to address him that very second.'})
keywordHandler:addKeyword({'god'}, StdModule.say, {npcHandler = npcHandler, text = 'I better make no jokes about THIS matter.'})
keywordHandler:addKeyword({'sam'}, StdModule.say, {npcHandler = npcHandler, text = 'Did you know that he sells a \'power axe of doom\' now? Run and buy it, he only has got three in store.'})
keywordHandler:addKeyword({'benjamin'}, StdModule.say, {npcHandler = npcHandler, text = 'He would make a fine jester, too.'})
keywordHandler:addKeyword({'monster'}, StdModule.say, {npcHandler = npcHandler, text = 'I know a lot of monster jokes. Just tell me a monster\'s name, come on.'})
keywordHandler:addKeyword({'demon'}, StdModule.say, {npcHandler = npcHandler, text = 'Why are the experienced heroes quicker than others? ... The demons love fast food!'})
keywordHandler:addKeyword({'ghoul'}, StdModule.say, {npcHandler = npcHandler, text = 'Where do ghouls buy their robes? ... In a boooohtique!'})
keywordHandler:addKeyword({'dragon'}, StdModule.say, {npcHandler = npcHandler, text = 'Why do dragons breathe fire? ... They ate too many sorcerers in chilli sauce!'})
keywordHandler:addKeyword({'orc'}, StdModule.say, {npcHandler = npcHandler, text = 'Why do orcs have green skin? ... They ate at Frodo\'s!'})
keywordHandler:addKeyword({'cyclops'}, StdModule.say, {npcHandler = npcHandler, text = 'How many eyes does a cyclops have? ... One for each IQ point they have!'})
keywordHandler:addKeyword({'oswald'}, StdModule.say, {npcHandler = npcHandler, text = 'If you believe half the rumours he\'s spreading, you will get in a lot of trouble.'})
keywordHandler:addKeyword({'dungeon'}, StdModule.say, {npcHandler = npcHandler, text = 'If you are a bad jester, you get a chance to visit them now and then.'})
keywordHandler:addKeyword({'mino'}, StdModule.say, {npcHandler = npcHandler, text = 'What do all little minotaurs want to become when they are grown-ups? ... Cowboys, of course!'})
keywordHandler:addKeyword({'troll'}, StdModule.say, {npcHandler = npcHandler, text = 'Why do trolls live underground? ... Because there are so many pks on the surface!'})
keywordHandler:addKeyword({'bonelord'}, StdModule.say, {npcHandler = npcHandler, text = 'Why are bonelords so ugly? ... Because their mom and dad were bonelords, too!'})
keywordHandler:addKeyword({'rat'}, StdModule.say, {npcHandler = npcHandler, text = 'Why does the rat have a wooden leg? ... Because it is a former pirate!'})
keywordHandler:addKeyword({'spider'}, StdModule.say, {npcHandler = npcHandler, text = 'Why did the spider cross the road? ... Because it ... oh you already know this one!?'})
keywordHandler:addKeyword({'hugo'}, StdModule.say, {npcHandler = npcHandler, text = 'I had a cousin named like that.'})
keywordHandler:addKeyword({'cousin'}, StdModule.say, {npcHandler = npcHandler, text = 'He died some years ago.'})
keywordHandler:addKeyword({'durin'}, StdModule.say, {npcHandler = npcHandler, text = 'Isn\'t he the author of the book \'Fun with Demons\'?'})
keywordHandler:addKeyword({'stephan'}, StdModule.say, {npcHandler = npcHandler, text = 'He is kind of a father figure to me. Of course he denies all kinship to me.'})
keywordHandler:addKeyword({'steve'}, StdModule.say, {npcHandler = npcHandler, text = 'He\'s a smart one. I heared he hid in a foreign country as the first bugs showed up.'})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, text = 'I am not foolish enough to believe in the existence of this weapon.'})
keywordHandler:addKeyword({'wall', 'carving'}, StdModule.say, {npcHandler = npcHandler, text = 'Oh, I saw some demon carvings in the dungeons as I hid there after a little joke on old Stutch.'})
keywordHandler:addKeyword({'demon', 'carving'}, StdModule.say, {npcHandler = npcHandler, text = 'Yes, they showed demons, seven actually, dancing around a sword! In something like a flaming pit.'})
keywordHandler:addKeyword({'flaming', 'pit'}, StdModule.say, {npcHandler = npcHandler, text = 'Ah, don\'t ask me! Usually mages and mystics know more about such stuff.'})

local jobKeyword = keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m the royal jes ... uhm ... the royal tax-collector! Do you want to pay your taxes?'})
	jobKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Come back, when you have enough money.', reset = true}, function(player) return player:getMoney() < 50 end)
	jobKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Thank you very much. I will have a drink or two on your health!', reset = true}, nil, function(player) if player:removeMoneyBank(50) then end end)
	jobKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'Well, perhaps later.', reset = true})

local magicKeyword = keywordHandler:addKeyword({'magic'}, StdModule.say, {npcHandler = npcHandler, text = 'I actually know some spells! Do you want to learn how to \'lessen your load\' for 200 gold?'})
	magicKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Come back, when you have enough money.', reset = true}, function(player) return player:getMoney() < 200 end)
	magicKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Here you are, I already lessened your load.', reset = true}, nil, function(player) if player:removeMoneyBank(200) then end end)
	magicKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'You don\'t know what offer you are missing!', reset = true})
keywordHandler:addAliasKeyword({'spell'})

local weaponKeyword = keywordHandler:addKeyword({'weapon'}, StdModule.say, {npcHandler = npcHandler, text = 'Do you want to buy a \'mace of the fury\' for 250 gold?'})
	weaponKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Come back, when you have enough money.', reset = true}, function(player) return player:getMoney() < 250 end)
	weaponKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'And here it is, it suits you well!', reset = true}, nil, function(player) if player:removeMoneyBank(250) then player:addItem(3473, 1) end end)
	weaponKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'You dont know what offer you have passed!', reset = true})

keywordHandler:addKeyword({'kiss'}, StdModule.say, {npcHandler = npcHandler, text = 'Uh, go away!', ungreet = true}, function(player) return player:getSex() == PLAYERSEX_MALE end)

local kissKeyword = keywordHandler:addKeyword({'kiss'}, StdModule.say, {npcHandler = npcHandler, text = 'Do you want to kiss me?'})
	kissKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Uh, oh! ... I am seeing stars!', reset = true}, nil, function(player) player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE) end)
	kissKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'Pah, I didn\'t want to kiss you anyway!', reset = true})

keywordHandler:addKeyword({'lady'}, StdModule.say, {npcHandler = npcHandler, text = 'Well, women don\'t behave necessarily in a ladylike way just because they dress like one!'}, function(player) return player:getSex() == PLAYERSEX_MALE end)

local ladyKeyword = keywordHandler:addKeyword({'lady'}, StdModule.say, {npcHandler = npcHandler, text = 'Has any man said to you that you\'re not only beautiful but also intelligent?'})
	ladyKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'This is a world of fantasy and full of surprises!', reset = true})
	ladyKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'Well, think about it!', reset = true})

npcHandler:setMessage(MESSAGE_FAREWELL, 'Ate mais! E lembre-se: a vida sempre sera uma piada!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Ei! Nao va embora sem se despedir!')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
