
local creatureNames = {"Draken Elite", "Draken Abomination", "Draken Warmaster", "Draken Spellweaver"}


local function hasCreatureInArea(fromPosition, toPosition, creatureNames)
    for x = fromPosition.x, toPosition.x do
        for y = fromPosition.y, toPosition.y do
            local pos = Position(x, y, fromPosition.z)
            local tile = Tile(pos)
            if tile then
                local creature = tile:getTopCreature()
                if creature and table.contains(creatureNames, creature:getName()) then
                    return true
                end
            end
        end
    end
    return false
end

local chestDrakenElite = Action()
function chestDrakenElite.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso) == 25 then
		if hasCreatureInArea(Position(4691, 5497, 15), Position(4706, 5512, 15), creatureNames) then
			player:say('Derrote todos os monstros antes de obter a recompensa.', TALKTYPE_MONSTER_SAY)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			return false
		else
			player:addItem(30060, 1)
			player:addItem(20138, 1)
			player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 26)
			player:say('Voce obteve o tesouro do Draken Abomination.', TALKTYPE_MONSTER_SAY)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			return false
		end
	end

end

chestDrakenElite:uid(12366)
chestDrakenElite:register()