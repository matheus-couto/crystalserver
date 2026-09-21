--[[
    Cache dos storages da Árvore de Força (LifeLevel, ManaLevel, LuckLevel, RepLevel).
    Evita chamar getStorageValue() repetidamente em scripts de alta frequência
    (treino a cada ~2s, mineração/coleta, etc.)

    IMPORTANTE: sempre que qualquer uma dessas storages for alterada (ex: no NPC
    que distribui pontos), chame updateArvoreDeForcaCache(player) logo em seguida,
    ou o jogador fica com valores desatualizados até relogar.
]]

ArvoreDeForcaCache = ArvoreDeForcaCache or {}

local arvoreStorages = {
	life = Storage.Quest.Crandoria.ArvoreDeForca.LifeLevel,
	mana = Storage.Quest.Crandoria.ArvoreDeForca.ManaLevel,
	luck = Storage.Quest.Crandoria.ArvoreDeForca.LuckLevel,
	rep = Storage.Quest.Crandoria.ArvoreDeForca.RepLevel,
}

-- Relê as 4 storages do jogador e atualiza o cache. Chame isso sempre que
-- qualquer uma delas for alterada em outro script (ex: NPC de pontos).
function updateArvoreDeForcaCache(player)
	local guid = player:getGuid()
	local values = {}

	for key, storage in pairs(arvoreStorages) do
		local value = player:getStorageValue(storage)
		if value < 1 then
			value = 0
		end
		values[key] = value
	end

	ArvoreDeForcaCache[guid] = values
	return values
end

-- Retorna { life = X, mana = X, luck = X, rep = X } do cache, populando se necessário.
function getArvoreDeForcaValues(player)
	local guid = player:getGuid()
	local cached = ArvoreDeForcaCache[guid]
	if cached then
		return cached
	end
	return updateArvoreDeForcaCache(player)
end

-- Popula o cache assim que o jogador loga
local arvoreCacheLogin = CreatureEvent("ArvoreDeForcaCacheLogin")
function arvoreCacheLogin.onLogin(player)
	updateArvoreDeForcaCache(player)
	return true
end
arvoreCacheLogin:register()

-- Limpa o cache no logout, pra não acumular entradas de jogadores offline
local arvoreCacheLogout = CreatureEvent("ArvoreDeForcaCacheLogout")
function arvoreCacheLogout.onLogout(player)
	ArvoreDeForcaCache[player:getGuid()] = nil
	return true
end
arvoreCacheLogout:register()