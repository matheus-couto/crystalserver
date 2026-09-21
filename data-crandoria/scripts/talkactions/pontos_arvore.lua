local pontosArvore = TalkAction("!pontos", "!points")

function pontosArvore.onSay(player, words, param)
	local storage = player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Geral)
	if storage < 1 then
		storage = 0
	end

	local arvore = getArvoreDeForcaValues(player)
	local storagelife = arvore.life
	local storagemana = arvore.mana
	local storagesorte = arvore.luck
	local storagerep = arvore.rep

	local pontos = math.floor(player:getLevel() / 50) - storage

	local factorLife = storagelife * 0.5
	local factorMana = storagemana * 0.5
	local factorSorte = storagesorte * 1
	local factorRep = storagerep * 25

	local msg = string.format([[
:: Arvore de Habilidades ::
Pontos disponiveis: %d 
Pontos distribuidos: %d 
Resiliencia: %d (Skills +%d%%)
Magia: %d (Magic Level +%d%%)
Sorte: %d (Loot +%d%%)
Reputacao: %d (+%d Pontos)

- CrandoriaOT -]], pontos, storage, storagelife, factorLife, storagemana, factorMana, storagesorte, factorSorte, storagerep, factorRep)
	player:sendTextMessage(MESSAGE_STATUS, msg)
	player:popupFYI(msg)
	return true
end

pontosArvore:groupType("normal")
pontosArvore:register()

-- local pontosArvore = TalkAction("!pontos", "!points")

-- function pontosArvore.onSay(player, words, param)

--     local storage = player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.Geral)
--     local storagelife = player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.LifeLevel)
--     local storagemana = player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.ManaLevel)
--     local storagesorte = player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.LuckLevel)
--     local storagerep = player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.RepLevel)



--     if storage < 1 then
-- 	storage = 0
--     end
--     if storagerep < 1 then
-- 	storagerep = 0
--     end
--     if storagelife < 1 then
-- 	storagelife = 0
--     end
--     if storagemana < 1 then
-- 	storagemana = 0
--     end
--     if storagesorte < 1 then
-- 	storagesorte = 0
--     end

--     local pontos = math.floor(player:getLevel() / 50) - storage

--     local factorLife = storagelife * 0.5
--     local factorMana = storagemana * 0.5
--     local factorSorte = storagesorte * 1
--     local factorRep = storagerep * 25

-- 	local msg = string.format([[
-- :: Arvore de Habilidades ::
-- Pontos disponiveis: %d (+%d%)
-- Pontos distribuidos: %d (+%d%)
-- Resiliencia: %d (Skills +%d%)
-- Magia: %d (Magic Level +%d%)
-- Sorte: %d (Loot +%d%)
-- Reputacao: %d (+%d Pontos)

-- - CrandoriaOT -]], pontos, storage, storagelife, factorLife, storagemana, factorMana, storagesorte, factorSorte, storagerep, factorRep)
-- 		player:sendTextMessage(MESSAGE_STATUS, msg)
-- 		player:popupFYI(msg)
-- 	return true
-- end

-- pontosArvore:groupType("normal")
-- pontosArvore:register()
