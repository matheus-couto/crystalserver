local destination = {
	[12335] = Position(5000,5000,6), -- Crandoria e Dawnport
}

local teleport = MoveEvent()

-- Área 1 trainers crandoria
local area1CenterPosition = Position(5004, 5000, 15)
local area1RangeX = 30
local area1RangeY = 15
-- Área 2 trainers crandoria
local area2CenterPosition = Position(5004, 5000, 14)
local area2RangeX = 30
local area2RangeY = 15
-- Área 3 hakata
local area3CenterPosition = Position(5612, 5159, 8)
local area3RangeX = 15
local area3RangeY = 10
-- Área 4 Anvillux1 
local area4CenterPosition = Position(5473, 4467, 11)
local area4RangeX = 15
local area4RangeY = 10
-- Área 5 Anvillux2
local area5CenterPosition = Position(5473, 4467, 12)
local area5RangeX = 18
local area5RangeY = 10
-- Área 6 Valkesh
local area6CenterPosition = Position(5351, 4684, 15)
local area6RangeX = 18
local area6RangeY = 15
-- Área 7 Magincia 1
local area7CenterPosition = Position(4757, 5229, 8)
local area7RangeX = 10
local area7RangeY = 5
-- Área 8 Magincia 2
local area8CenterPosition = Position(4758, 5229, 7)
local area8RangeX = 9
local area8RangeY = 5


function teleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local storage = player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.House)
	local house = player:getHouse()

	player:setStorageValue(STORAGEVALUE_EMOTE, 1)
	if player:getStorageValue(Storage.Quest.Crandoria.TibiaClash.Time) > 0 then
		player:setStorageValue(Storage.Quest.Crandoria.TibiaClash.Time, 0)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce saiu do Tibia Clash.")
	end

	player:setFaction(FACTION_PLAYER)
	player:setStorageValue(Storage.Quest.Crandoria.TheRedPath.House, 0)
	player:setStorageValue(Storage.Quest.Crandoria.TibiaClash.Time, 0)
	if player:getExpBoostStamina() > 3 * 60 * 60 then
		player:setExpBoostStamina(3 * 60 * 60)
	end 

	if Game.getStorageValue(GlobalStorage.Crandoria.Mensagens.Geral) < os.time() then
		local playersInArea1 = Game.getSpectators(area1CenterPosition, false, true, area1RangeX, area1RangeX, area1RangeY, area1RangeY)
		for _, playerInArea in ipairs(playersInArea1) do
			-- Verifica se o IP do jogador é 0
			if playerInArea:getIp() == 0 then
				-- Remove o jogador do jogo
				playerInArea:remove()
			end
		end
		local playersInArea2 = Game.getSpectators(area2CenterPosition, false, true, area2RangeX, area2RangeX, area2RangeY, area2RangeY)
		for _, playerInArea in ipairs(playersInArea2) do
			-- Verifica se o IP do jogador é 0
			if playerInArea:getIp() == 0 then
				-- Remove o jogador do jogo
				playerInArea:remove()
			end
		end
		local playersInArea3 = Game.getSpectators(area3CenterPosition, false, true, area3RangeX, area3RangeX, area3RangeY, area3RangeY)
		for _, playerInArea in ipairs(playersInArea3) do
			-- Verifica se o IP do jogador é 0
			if playerInArea:getIp() == 0 then
				-- Remove o jogador do jogo
				playerInArea:remove()
			end
		end
		local playersInArea4 = Game.getSpectators(area4CenterPosition, false, true, area4RangeX, area4RangeX, area4RangeY, area4RangeY)
		for _, playerInArea in ipairs(playersInArea4) do
			-- Verifica se o IP do jogador é 0
			if playerInArea:getIp() == 0 then
				-- Remove o jogador do jogo
				playerInArea:remove()
			end
		end
		local playersInArea5 = Game.getSpectators(area5CenterPosition, false, true, area5RangeX, area5RangeX, area5RangeY, area5RangeY)
		for _, playerInArea in ipairs(playersInArea5) do
			-- Verifica se o IP do jogador é 0
			if playerInArea:getIp() == 0 then
				-- Remove o jogador do jogo
				playerInArea:remove()
			end
		end
		local playersInArea6 = Game.getSpectators(area6CenterPosition, false, true, area6RangeX, area6RangeX, area6RangeY, area6RangeY)
		for _, playerInArea in ipairs(playersInArea6) do
			-- Verifica se o IP do jogador é 0
			if playerInArea:getIp() == 0 then
				-- Remove o jogador do jogo
				playerInArea:remove()
			end
		end
		local playersInArea7 = Game.getSpectators(area7CenterPosition, false, true, area7RangeX, area7RangeX, area7RangeY, area7RangeY)
		for _, playerInArea in ipairs(playersInArea7) do
			-- Verifica se o IP do jogador é 0
			if playerInArea:getIp() == 0 then
				-- Remove o jogador do jogo
				playerInArea:remove()
			end
		end
		local playersInArea8 = Game.getSpectators(area8CenterPosition, false, true, area8RangeX, area8RangeX, area8RangeY, area8RangeY)
		for _, playerInArea in ipairs(playersInArea8) do
			-- Verifica se o IP do jogador é 0
			if playerInArea:getIp() == 0 then
				-- Remove o jogador do jogo
				playerInArea:remove()
			end
		end

		local gameStorage = Game.getStorageValue(GlobalStorage.Crandoria.Mensagens.Count)
		
		if gameStorage < 1 then
			addEvent(Game.broadcastMessage, 30 * 1000, "Faca o download do Manual do servidor em nosso site: https://crandoriaot.com.br/?manual.", MESSAGE_GAME_HIGHLIGHT)
			Game.setStorageValue(GlobalStorage.Crandoria.Mensagens.Count, 2)
		elseif gameStorage == 2 then
			addEvent(Game.broadcastMessage, 30 * 1000, "Se encontrar algum bug, erro ou algum jogador abusando de erros no servidor, reporte imediatamente a Staff!", MESSAGE_GAME_HIGHLIGHT)
			Game.setStorageValue(GlobalStorage.Crandoria.Mensagens.Count, 3)
		elseif gameStorage == 3 then
			addEvent(Game.broadcastMessage, 30 * 1000, "Utilize o comando !coleta para checar suas skills de Coleta e se ha chance de obter Tibia Coins.", MESSAGE_GAME_HIGHLIGHT)
			Game.setStorageValue(GlobalStorage.Crandoria.Mensagens.Count, 4)
		elseif gameStorage == 4 then
			addEvent(Game.broadcastMessage, 30 * 1000, "Participe do grupo do WhatsApp do CrandoriaOT clicando no icone do aplicativo em nosso site.", MESSAGE_GAME_HIGHLIGHT)
			Game.setStorageValue(GlobalStorage.Crandoria.Mensagens.Count, 6)
		elseif gameStorage == 6 then
			addEvent(Game.broadcastMessage, 30 * 1000, "Voce pode encontrar muitas historias e pistas sobre quests nos livros e documentos da Biblioteca, na Peninsula de Crandoria.", MESSAGE_GAME_HIGHLIGHT)
			Game.setStorageValue(GlobalStorage.Crandoria.Mensagens.Count, 8)
		elseif gameStorage == 8 then
			addEvent(Game.broadcastMessage, 30 * 1000, "Contribua com o servidor com o comando !donate e receba Tibia Coins para gastar na nossa Store!", MESSAGE_GAME_HIGHLIGHT)
			Game.setStorageValue(GlobalStorage.Crandoria.Mensagens.Count, 9)
		elseif gameStorage == 9 then
			addEvent(Game.broadcastMessage, 30 * 1000, "Utilize o comando !pacote para checar e comprar pacotes de Itens disponiveis.", MESSAGE_GAME_HIGHLIGHT)
			Game.setStorageValue(GlobalStorage.Crandoria.Mensagens.Count, 0)
		end

		Game.setStorageValue(GlobalStorage.Crandoria.Mensagens.Geral, os.time() + 15 * 60)
	end

	-- if player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) >= 10 then
	-- 	player:addAchievement("Escudeiro de Crandoria")
	-- end

	return true
	-- end
end

teleport:aid(12335)
teleport:register()