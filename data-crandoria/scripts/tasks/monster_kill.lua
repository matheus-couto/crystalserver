--[[
	Liga a morte dos monstros ao CrandoriaTaskSystem (tasks_global.lua).

	Este evento existia mas nunca era registrado em monstro nenhum, entao nada
	chegava ao contador: missoes de caca do Haldor, do Gerard, do Passe de
	Batalha e do Holtten nao contavam um kill sequer. E, mesmo registrado,
	quebraria em monster:getRaceId(), que nao existe nesta versao do servidor
	- o raceId mora no tipo do monstro.
]]
local crandoriaTaskKill = CreatureEvent("crandoriaTaskKill")

function crandoriaTaskKill.onDeath(creature, corpse, killer, mostDamageKiller)
	local monster = creature:getMonster()
	-- Invocacao nao conta, como no TaskCreature: senao um monstro que invoca
	-- outros viraria fonte infinita de kills de missao.
	if not monster or monster:getMaster() then
		return true
	end

	local raceId = monster:getType():raceId()
	if not raceId or raceId == 0 then
		return true
	end

	for playerId, _ in pairs(monster:getDamageMap()) do
		local player = Player(playerId)
		if player then
			CrandoriaTaskSystem.onKill(player, raceId)
		end
	end

	return true
end

crandoriaTaskKill:register()

-- Registra em todo monstro que tem raceId. Os alvos do Passe de Batalha e do
-- Holtten mudam por mes e por dia, entao uma lista fixa sempre acabaria
-- esquecendo algum. Monstro sem raceId nunca e alvo, porque a comparacao das
-- tarefas e justamente pelo raceId.
local startup = GlobalEvent("crandoriaTaskKillStartup")
function startup.onStartup()
	local total = 0
	for _, mType in pairs(Game.getMonsterTypes()) do
		local raceId = mType:raceId()
		if raceId and raceId > 0 then
			mType:registerEvent("crandoriaTaskKill")
			total = total + 1
		end
	end
	logger.info("[crandoriaTaskKill] evento de morte registrado em {} tipos de monstro", total)
	return true
end
startup:register()
