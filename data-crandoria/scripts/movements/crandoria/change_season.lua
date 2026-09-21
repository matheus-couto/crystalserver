-- local changeSeason = MoveEvent()


-- function changeSeason.onStepIn(creature, item, position, fromPosition)

-- 	local player = creature:getPlayer()
-- 	if not player then
-- 		return false
-- 	end

-- -- 		local msg = [[:: OUTONO EM CRANDORIA
-- -- Estamos no outono na cidade de Crandoria.
-- -- Durante essa estacao ocorrem algumas mudancas na principal cidade do Novo Coninente,
-- -- entao fique atento a tudo isso!

-- -- Mudancas no Outono:

-- -- >> Taxas de up de Skills e ML: 10% maiores.

-- -- >> Colheita: Dificultada.

-- -- >> Ordenha: Facilitada.

-- -- NPC Wilfred Storm entregara quests diarias da estacao. Ele fica a oeste da loja da Jessica.

-- -- 'As folhas das arvores estao caindo e Crandoria passa por uma nova fase de sua breve e magica
-- -- historia. Ha folhas por todo o chao, deixando a cidade imersa em uma quietude calorosa e
-- -- intensa que antecede o frio do inverno. O outono lembra aos moradores de Crandoria que a paz
-- -- reside em sua cidade, entre suas ruas e dentro de suas casas.  - Quentin.'
-- -- ]]

-- -- 	local msg = [[:: INVERNO EM CRANDORIA
-- -- O inverno chegou na cidade de Crandoria.
-- -- Mudancas no Inverno:

-- -- >> Pesca Custom: dificultada

-- -- >> Mineracao: facilitada

-- -- 'Os ventos frios e as noites longas trazem consigo sentimentos obscuros e medos ha
-- -- muito tempo esquecidos. As ruas, cobertas pela neve, sao marcadas pelos passos dos guerreiros
-- -- da cidade que nunca para. Sao os bravos defensores do Novo Continente, que dedicam seus dias mais 
-- -- frios a defesa de seu lar para que uma proxima primavera venha a florescer.  - Quentin.'
-- -- ]]

-- -- local msg = [[:: PRIMAVERA EM CRANDORIA
-- -- A primavera floresceu na cidade de Crandoria.

-- -- Mudancas na Primavera:

-- -- >> Taxa de Experiencia: +5%

-- -- >> Cultivo: facilitado

-- -- >> Ordenha: dificultada

-- -- 'A primavera traz consigo o renascimento de antigas esperancas e a renovacao das forcas dos guerreiros de Crandoria.
-- -- As flores desabrocham pelos campos, e os ventos suaves carregam o aroma das arvores floridas, enquanto a cidade desperta de seu frio repouso. 
-- -- E uma epoca de novos comecos, onde as cicatrizes deixadas pelo inverno sao curadas, e o povo caminha com leveza,
-- -- guiado pelo brilho dos primeiros raios do sol que anunciam tempos de paz e crescimento. - Quentin.'
-- -- ]]



-- local msg = [[:: VERAO EM CRANDORIA

-- O Verao chegou na cidade de Crandoria!

-- Mudancas no Verao:

-- >> Taxa de Loot: +5%

-- >> Mineracao: Dificultada

-- >> Pesca: Facilitada

-- 'O Verao traz novos ares para a cidade de Crandoria.
-- Enquanto alguns reclamam do extremo calor, outros aproveitam o clima para curtir na praia da cidade. 
-- Para aqueles que buscam por riquezas, o verao traz a possibilidade de grandes ganhos! - Quentin.'
-- ]]

-- 	if player:getStorageValue(Storage.Quest.Crandoria.Estacoes.MensagemLogin) < os.time() then
-- 		player:popupFYI(msg)
-- 		player:setStorageValue(Storage.Quest.Crandoria.Estacoes.MensagemLogin, os.time() + 14 * 24 * 60 * 60)
-- 		return true
-- 	else
-- 		return false
-- 	end

-- end

-- changeSeason:aid(12370)
-- changeSeason:register()