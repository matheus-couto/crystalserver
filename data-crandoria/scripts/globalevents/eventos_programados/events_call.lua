local function removePlayersFromArea(area, exitPosition, participationStorage, exitRadius)
	exitRadius = exitRadius or 3

	local function isInArea(pos)
		return pos.z == area.from.z
			and pos.x >= area.from.x and pos.x <= area.to.x
			and pos.y >= area.from.y and pos.y <= area.to.y
	end

	local function getExitPosition()
		for _ = 1, 10 do
			local pos = Position(exitPosition.x + math.random(-exitRadius, exitRadius), exitPosition.y + math.random(-exitRadius, exitRadius), exitPosition.z)
			local tile = Tile(pos)
			if tile and not tile:hasFlag(TILESTATE_BLOCKSOLID) then
				return pos
			end
		end
		return exitPosition
	end

	-- 5 jogadores por lote, a cada 400 ms, cada um em um tile diferente
	local function teleportBatch(ids, startIndex)
		local lastIndex = math.min(startIndex + 4, #ids)
		for i = startIndex, lastIndex do
			local player = Player(ids[i])
			if player and isInArea(player:getPosition()) then
				player:teleportTo(getExitPosition())
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O evento terminou. Voce foi levado de volta ao templo.")
			end
		end
		if lastIndex < #ids then
			addEvent(teleportBatch, 400, ids, lastIndex + 1)
		end
	end

	local ids = {}
	local now = os.time()
	for _, player in ipairs(Game.getPlayers()) do
		if isInArea(player:getPosition()) then
			player:setStorageValue(participationStorage, 1)
			ids[#ids + 1] = player:getId()
		end
	end

	if #ids > 0 then
		teleportBatch(ids, 1)
	end
end

local eventosProgramados = GlobalEvent("eventosProgramados")

function eventosProgramados.onTime(interval)

	local day = os.date("%A")

	if day == "Saturday" then
		Game.setStorageValue(GlobalStorage.Crandoria.Eventos.EventoProgramado, 1)
		Game.broadcastMessage("O Evento do Boss Global sera iniciado em 5 minutos. Acessem o teleport de eventos na Peninsula de Crandoria para participar.", MESSAGE_EVENT_ADVANCE)
		addEvent(function()
			Game.broadcastMessage("O Evento do Boss Global sera iniciado em 3 minutos. Acessem o teleport de eventos na Peninsula de Crandoria para participar.", MESSAGE_EVENT_ADVANCE)
		end, 120000)
		addEvent(function()
			local boss = Game.createMonster("Hellsin", Position(4313, 6082, 7))
			if boss then
				Game.broadcastMessage("Hellsin surgiu na Arena do Boss Global! O servidor tem 20 minutos para tentar derrota-lo.", MESSAGE_EVENT_ADVANCE)
			end
			addEvent(function()
				Game.setStorageValue(GlobalStorage.Crandoria.Eventos.EventoProgramado, 0)
				if boss then
					boss:remove()
					Game.broadcastMessage("Hellsin fugiu antes de ser derrotado. Os jogadores que permaneceram ate o fim da luta poderao obter suas recompensas de participacao.", MESSAGE_EVENT_ADVANCE)
				end

				removePlayersFromArea(
					{ from = Position(4299, 6068, 7), to = Position(4330, 6097, 7) }, -- AJUSTE: cantos da arena
					Position(5000, 5000, 6), -- AJUSTE: saida (templo)
					Storage.Quest.Crandoria.EventoProgramado.BossGlobal -- AJUSTE: sua storage
				)
			end, 20 * 60 * 1000)
		end, 300000)
	elseif day == "Wednesday" then
		Game.setStorageValue(GlobalStorage.Crandoria.Eventos.EventoProgramado, 1)
		Game.broadcastMessage("O evento Artefato Perdido sera iniciado em 5 minutos. Acessem o Teleport de Eventos na peninsula de Crandoria para participar.", MESSAGE_EVENT_ADVANCE)
		addEvent(function()
			Game.broadcastMessage("O evento Artefato Perdido sera iniciado em 3 minutos. Acessem o Teleport de Eventos na peninsula de Crandoria para participar.", MESSAGE_EVENT_ADVANCE)
		end, 120000)
		addEvent(function()
			Game.broadcastMessage("O evento Artefato Perdido sera iniciado em 1 minuto. Acessem o Teleport de Eventos na peninsula de Crandoria para participar.", MESSAGE_EVENT_ADVANCE)
		end, 240000)
		addEvent(function()
			local gate1 = Tile(Position(4456, 6095, 7)):getItemById(20242)
			local gate2 = Tile(Position(4457, 6095, 7)):getItemById(20242)
			local gate3 = Tile(Position(4458, 6095, 7)):getItemById(20242)
			local gate4 = Tile(Position(4459, 6095, 7)):getItemById(20242)
			local gate5 = Tile(Position(4460, 6095, 7)):getItemById(20242)
			local gate6 = Tile(Position(4461, 6095, 7)):getItemById(20242)
			if gate1 then
				gate1:remove()
				gate2:remove()
				gate3:remove()
				gate4:remove()
				gate5:remove()
				gate6:remove()
			end
			Game.broadcastMessage("O evento Artefato Perdido foi iniciado!", MESSAGE_EVENT_ADVANCE)
		end, 300000)
	elseif day == "Sunday" then
		local chance = math.random(1, 4)
		local bossPos1 = Position(4317, 6256, 7)
		local bossPos2 = Position(4341, 6256, 7)
		Game.setStorageValue(GlobalStorage.Crandoria.Eventos.EventoProgramado, 1)
		if chance == 1 then
			Game.createMonster("Multog", bossPos1)
			Game.createMonster("Multog", bossPos2)
			Game.broadcastMessage("O evento Disputa de Poder sera iniciado em 5 minutos. Acessem o Teleport de Eventos. Boss do dia: Multog.", MESSAGE_EVENT_ADVANCE)
		elseif chance == 2 then
			Game.createMonster("Flamanzog", bossPos1)
			Game.createMonster("Flamanzog", bossPos2)
			Game.broadcastMessage("O evento Disputa de Poder sera iniciado em 5 minutos. Acessem o Teleport de Eventos. Boss do dia: Flamanzog.", MESSAGE_EVENT_ADVANCE)
		elseif chance == 3 then
			Game.createMonster("Shockanog", bossPos1)
			Game.createMonster("Shockanog", bossPos2)
			Game.broadcastMessage("O evento Disputa de Poder sera iniciado em 5 minutos. Acessem o Teleport de Eventos. Boss do dia: Shockanog.", MESSAGE_EVENT_ADVANCE)
		elseif chance == 4 then
			Game.createMonster("Crystalog", bossPos1)
			Game.createMonster("Crystalog", bossPos2)
			Game.broadcastMessage("O evento Disputa de Poder sera iniciado em 5 minutos. Acessem o Teleport de Eventos. Boss do dia: Crystalog.", MESSAGE_EVENT_ADVANCE)
		end
		addEvent(function()
			Game.broadcastMessage("O evento Artefato Perdido comecara em 3 minutos. Acessem o Teleport de Eventos na peninsula de Crandoria para participar.", MESSAGE_EVENT_ADVANCE)
		end, 120000)
		addEvent(function()
			Game.broadcastMessage("O evento Artefato Perdido comecara em 1 minuto. Acessem o Teleport de Eventos na peninsula de Crandoria para participar.", MESSAGE_EVENT_ADVANCE)
		end, 240000)
	end

end

eventosProgramados:time("19:55:00")
eventosProgramados:register()




local anuncioEventos = GlobalEvent("anuncioEventos")

function anuncioEventos.onTime(interval)

	local day = os.date("%A")

	if day == "Wednesday" then
		Game.broadcastMessage("Hoje as 20:00h ocorrera o evento Artefato Perdido. Para participar, acesse o portal de eventos na Peninsula de Crandoria.", MESSAGE_EVENT_ADVANCE)
		return true
	elseif day == "Saturday" then
		Game.broadcastMessage("Hoje as 20:00h ocorrera o evento Boss Global. Para participar, acesse o portal de eventos na Peninsula de Crandoria.", MESSAGE_EVENT_ADVANCE)
		return true
	elseif day == "Sunday" then
		Game.broadcastMessage("Hoje as 20:00h ocorrera o evento Disputa de Poder. Para participar, acesse o portal de eventos na Peninsula de Crandoria.", MESSAGE_EVENT_ADVANCE)
		return true
	end

end

anuncioEventos:time("10:00:00", "14:00:00", "18:00:00")
anuncioEventos:register()