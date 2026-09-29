-- onDeath registrado nos monstros de task, em vez de onKill no jogador.
--
-- O onKill rodava em toda morte que qualquer jogador causasse, e cada chamada
-- percorria a taskConfiguration inteira so para descobrir que aquele monstro
-- nao era de task. Agora o evento so existe nos monstros que estao na lista,
-- entao a conferencia ja foi feita no registro.
local taskCreature = CreatureEvent("TaskCreature")

function taskCreature.onDeath(creature, corpse, killer, mostDamageKiller)
	if creature:getMaster() or not getDeathCreditPlayer(mostDamageKiller) then
		return true
	end

	local data = getTaskByMonsterName(creature:getName():lower())
	if not data then
		return true
	end

	local damageMap = creature:getDamageMap()
	if not damageMap then
		return true
	end

	for cid, damage in pairs(damageMap) do
		local participant = Player(cid)
		if participant and participant:isPlayer() and participant:hasStartedTask(data.storage) then
			if participant:getStorageValue(10102) >= os.time() then
				participant:addTaskKill(data.storage, 2)
			else
				participant:addTaskKill(data.storage, 1)
			end
		end
	end

	return true
end

taskCreature:register()

local startup = GlobalEvent("TaskCreatureStartup")
function startup.onStartup()
	-- A mesma criatura pode aparecer em mais de uma task; registrar duas
	-- vezes faria o kill contar em dobro.
	local vistos, nomes = {}, {}
	for _, data in pairs(taskConfiguration) do
		local chave = data.name:lower()
		if not vistos[chave] then
			vistos[chave] = true
			nomes[#nomes + 1] = data.name
		end
	end
	local ok = registerDeathEvent("TaskCreature", nomes)
	logger.info("[TaskCreature] evento de morte registrado em {} de {} monstros de task", ok, #nomes)
	return true
end
startup:register()
