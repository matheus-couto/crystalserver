local espelhoNPC = Action()

-- Função para verificar se há bosses na área
local function isBossNearby(centerPosition, range)
    local spectators = Game.getSpectators(centerPosition, false, false, range, range, range, range)
    for _, creature in ipairs(spectators) do
        if creature:isMonster() and creature:getType():isRewardBoss() then
            return true
        end
    end
    return false
end

function espelhoNPC.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not player then
        return true
    end

    if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) == 1 then
        player:say('Este item nao funciona em Viridia.', TALKTYPE_MONSTER_SAY)
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end 

    -- Verifica se há boss na área de 15x15 sqm
    if isBossNearby(player:getPosition(), 15) then
		player:say('Voce nao pode usar este item agora. Ha um boss perto daqui.', TALKTYPE_MONSTER_SAY)
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end

    local npcPos = player:getPosition()
    local npc = Game.createNpc("Eist, o Mercador", npcPos)
    if npc then
        item:remove(1)
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
        addEvent(function()
            npc:remove(1)
        end, 180 * 1000)
        return true
    else
        player:sendCancelMessage("Algo deu errado. Contate um administrador.")
        return true
    end
end

espelhoNPC:id(36875)
espelhoNPC:register()


-- local espelhoNPC = Action()

-- function espelhoNPC.onUse(player, item, fromPosition, target, toPosition, isHotkey)

-- 	if not player then
-- 		return true
-- 	end

-- 	local npcPos = player:getPosition()

-- 	local npc = Game.createNpc("Eist, o Mercador", npcPos)
-- 	if npc then
-- 		item:remove(1)
-- 		addEvent(function()
-- 			npc:remove(1)
-- 		end, 180 * 1000)
-- 		return true
-- 	else
-- 		player:sendCancelMessage("Algo deu errado. Contate um administrador.")
-- 		return true
-- 	end
	
-- end

-- espelhoNPC:id(36875)
-- espelhoNPC:register()