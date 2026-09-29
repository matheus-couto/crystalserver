--[[
	Apoio para eventos onDeath registrados em monstro.

	O onKill registrado no jogador esta depreciado: o servidor chama cada um
	deles em TODA morte que o jogador causa, e escreve um aviso no log a cada
	chamada. Com uma duzia registrados no login, matar um rotworm gerava doze
	linhas de aviso e doze chamadas Lua que so serviam para conferir o nome
	e sair.

	O onDeath registrado no proprio monstro so roda quando aquele monstro
	morre. Mas ele dispara em qualquer morte, enquanto o onKill so disparava
	quando um jogador tinha causado mais dano. Esta funcao reproduz essa
	condicao, para a conversao nao mudar quando os scripts rodam.
]]

--- Jogador que leva o credito pela morte, pela mesma regra do onKill antigo:
--- quem causou mais dano, ou o dono da invocacao que causou. nil se ninguem.
function getDeathCreditPlayer(mostDamageKiller)
	if not mostDamageKiller then
		return nil
	end

	local player = mostDamageKiller:getPlayer()
	if player then
		return player
	end

	local master = mostDamageKiller:getMaster()
	return master and master:getPlayer() or nil
end

--- Registra um evento de morte nos tipos de monstro indicados.
--- Chamada no onStartup, depois que os tipos ja foram carregados.
function registerDeathEvent(eventName, monsterNames)
	local ok = 0
	for _, name in ipairs(monsterNames) do
		local mType = MonsterType(name)
		if mType then
			mType:registerEvent(eventName)
			ok = ok + 1
		else
			logger.error("[{}] tipo de monstro nao encontrado: {}", eventName, name)
		end
	end
	return ok
end
