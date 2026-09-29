-- CRANDORIA EDIT -- NEW --
--[[
	Contagem de kills das missoes de caca: Passe de Batalha, Almirante Haldor,
	Gerard e Holtten. Quem chama e o evento de morte em monster_kill.lua.

	O contador so CONTA. Quem avanca a missao e entrega a recompensa e o NPC.

	Antes o contador tambem avancava o progresso ao bater o alvo, e isso
	pulava a recompensa: o NPC so paga quando encontra o jogador na etapa da
	caca (Haldor 2 -> 3, Gerard 1 -> 2, Passe 2 -> 3), e o jogador ja chegava
	na etapa seguinte. Tambem para no alvo em vez de seguir contando, porque o
	NPC do Passe confere `== 1000` e passaria direto por 1001.
]]
CrandoriaTaskSystem = {}

local HALDOR = Storage.Quest.Crandoria.Viridia.Haldor
local WARMASTER = Storage.Quest.Crandoria.Viridia.WarmasterOutfits
local ALVO_ANTIGO = Storage.Quest.Crandoria.Estacoes.QuestPrimaveraRaceId

-- Monstros possiveis em cada etapa de caca do Haldor, para validar o alvo
-- herdado do contador antigo.
local HALDOR_ALVOS = {
	[2] = { "Dwarf", "Rotworm", "Minotaur", "Orc" },
	[6] = { "Cyclops", "Elf Scout", "Tarantula" },
	[16] = { "Dragon" },
}

-- Quem ja estava no meio de uma caca quando o contador mudou de chave tem o
-- alvo no contador antigo. O NPC migra ao conversar, mas o jogador pode sair
-- cacando antes disso; entao migra aqui tambem, no primeiro kill.
local function migrarHaldor(player)
	if player:getStorageValue(HALDOR.CacaRaca) > 0 then
		return
	end
	local nomes = HALDOR_ALVOS[player:getStorageValue(HALDOR.Progresso)]
	if not nomes then
		return
	end
	-- So aceita o alvo antigo se ele for valido para a etapa: o Gerard usava a
	-- mesma chave, e um Dragon Lord dele nao pode virar alvo do Haldor. Se nao
	-- for valido, nada acontece aqui e o NPC sorteia um ao conversar.
	local antiga = player:getStorageValue(ALVO_ANTIGO)
	for _, nome in ipairs(nomes) do
		local mType = MonsterType(nome)
		if mType and mType:raceId() == antiga then
			player:setStorageValue(HALDOR.CacaRaca, antiga)
			player:setStorageValue(HALDOR.CacaContagem, 0)
			return
		end
	end
end

local function migrarGerard(player)
	if player:getStorageValue(WARMASTER.Progresso) ~= 1 or player:getStorageValue(WARMASTER.CacaRaca) > 0 then
		return
	end
	local mType = MonsterType("Dragon Lord")
	if mType then
		player:setStorageValue(WARMASTER.CacaRaca, mType:raceId())
		player:setStorageValue(WARMASTER.CacaContagem, 0)
	end
end

-- Cada tarefa: em que etapas do progresso ela conta, quantos kills pede em
-- cada uma, e onde ficam o monstro-alvo e o contador.
local TAREFAS = {
	{
		rotulo = "Battle Pass",
		progresso = Storage.Quest.Crandoria.PasseDeBatalha.Progresso,
		raca = Storage.Quest.Crandoria.PasseDeBatalha.Hunt,
		contagem = Storage.Quest.Crandoria.PasseDeBatalha.HuntCount,
		etapas = { [2] = 1000, [6] = 1000, [10] = 1000, [14] = 1500, [23] = 2500 },
		concluido = "Voce concluiu a missao do Passe de Batalha! Retorne ao NPC para receber sua recompensa.",
	},
	{
		rotulo = "Haldor Quest",
		progresso = Storage.Quest.Crandoria.Viridia.Haldor.Progresso,
		raca = Storage.Quest.Crandoria.Viridia.Haldor.CacaRaca,
		contagem = Storage.Quest.Crandoria.Viridia.Haldor.CacaContagem,
		etapas = { [2] = 25, [6] = 50, [16] = 100 },
		concluido = "Voce concluiu a missao. Fale com o Almirante Haldor.",
		migrar = migrarHaldor,
	},
	{
		rotulo = "Task Gerard",
		progresso = Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Progresso,
		raca = Storage.Quest.Crandoria.Viridia.WarmasterOutfits.CacaRaca,
		contagem = Storage.Quest.Crandoria.Viridia.WarmasterOutfits.CacaContagem,
		etapas = { [1] = 1000 },
		concluido = "Voce concluiu a tarefa de Gerard. Fale com ele para receber sua recompensa.",
		-- A task do Gerard tem prazo; depois dele os kills nao contam.
		dentroDoPrazo = function(player)
			return player:getStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Timer) > os.time()
		end,
		foraDoPrazo = "O tempo da missao esgotou. Fale com Gerard novamente.",
		migrar = migrarGerard,
	},
}

local function contar(player, raceId, t)
	if t.migrar then
		t.migrar(player)
	end

	local alvo = t.etapas[player:getStorageValue(t.progresso)]
	if not alvo or player:getStorageValue(t.raca) ~= raceId then
		return
	end

	if t.dentroDoPrazo and not t.dentroDoPrazo(player) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, t.foraDoPrazo)
		return
	end

	local count = math.max(0, player:getStorageValue(t.contagem))
	if count >= alvo then
		return
	end

	count = count + 1
	player:setStorageValue(t.contagem, count)

	if count >= alvo then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, t.concluido)
	else
		player:sendTextMessage(MESSAGE_STATUS_SMALL, string.format("[%s] %d/%d", t.rotulo, count, alvo))
	end
end

-- Holtten e diaria e nao tem etapa de progresso: conta enquanto o dia da
-- missao for hoje, ate o total sorteado.
local holttenStorage = {
	day = Storage.Quest.Crandoria.QuestHoltten.Dia,
	count = Storage.Quest.Crandoria.QuestHoltten.Contagem,
	total = Storage.Quest.Crandoria.QuestHoltten.ContagemTotal,
	race = Storage.Quest.Crandoria.QuestHoltten.MonsterRace,
}

local function contarHoltten(player, raceId)
	if player:getStorageValue(holttenStorage.day) ~= os.date("*t").day then
		return
	end
	if player:getStorageValue(holttenStorage.race) ~= raceId then
		return
	end

	local count = math.max(0, player:getStorageValue(holttenStorage.count))
	local total = player:getStorageValue(holttenStorage.total)
	if count >= total then
		return
	end

	count = count + 1
	player:setStorageValue(holttenStorage.count, count)
	player:sendTextMessage(MESSAGE_STATUS_SMALL, string.format("[Holtten Quest] %d/%d", count, total))
end

function CrandoriaTaskSystem.onKill(player, raceId)
	for _, t in ipairs(TAREFAS) do
		contar(player, raceId, t)
	end
	contarHoltten(player, raceId)
end

--- Contagem atual de uma tarefa, para o NPC e o quest log mostrarem.
function CrandoriaTaskSystem.getCount(player, rotulo)
	for _, t in ipairs(TAREFAS) do
		if t.rotulo == rotulo then
			return math.max(0, player:getStorageValue(t.contagem))
		end
	end
	return 0
end
