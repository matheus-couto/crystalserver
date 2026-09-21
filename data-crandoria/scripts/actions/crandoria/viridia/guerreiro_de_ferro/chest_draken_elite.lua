
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

	if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso) == 24 then
		if hasCreatureInArea(Position(4656, 5497, 15), Position(4671, 5512, 15), creatureNames) then
			player:say('Derrote todos os monstros antes de obter a recompensa.', TALKTYPE_MONSTER_SAY)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			return false
		else
			player:addItem(3043, 5)
			player:addItem(9099, 1)
			player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 25)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			return false
		end
	end

end

chestDrakenElite:uid(12365)
chestDrakenElite:register()