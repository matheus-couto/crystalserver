local enchantEldritch = Action()

local items = {
    [36657] = { name = "eldritch claymore", upgrade = 36658 },
    [36661] = { name = "eldritch greataxe", upgrade = 36662 },
    [36659] = { name = "eldritch warmace", upgrade = 36660 },
    [36664] = { name = "eldritch bow", upgrade = 36665 },
    [36674] = { name = "eldritch rod", upgrade = 36675 },
    [36668] = { name = "eldritch wand", upgrade = 36669 },
    [50169] = { name = "eldritch crescent moon spade", upgrade = 50170 },
}

function enchantEldritch.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    local weaponPos = Position(5768, 4379, 7)
    local weaponTile = Tile(weaponPos)

    local storage = player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso)

    local gemaAntiga = player:getItemCount(33309)
    local gemaOnyx = player:getItemCount(33306)
    local gemaArcoIris = player:getItemCount(33307)
    local gemaLunar = player:getItemCount(33311)

    if not weaponTile then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Uma arma Eldritch precisa ser colocada no Pedestal.")
        return true
    end

    if storage < 27 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa da permissao da Naga Queen para realizar o encantamento.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    elseif storage > 27 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja realizou um encantamento.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    else
        local weapon = weaponTile:getTopDownItem()
        local weaponData = items[weapon:getId()]
        local newWeapon = weaponData.upgrade[gem:getId()]
        if not weapon or not weaponData then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Uma arma Eldritch precisa ser colocada no Pedestal.")
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            return true
        else
            if gemaAntiga < 1 or gemaOnyx < 1 or gemaArcoIris < 1 or gemaLunar < 1 then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa possuir as quatro gemas para encantar uma arma Eldritch.")
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
                return true
            else
                player:removeItem(33309, 1)
                player:removeItem(33306, 1)
                player:removeItem(33307, 1)
                player:removeItem(33311, 1)
                player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 28)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce usou o altar de encantamento com a permissao concedida pela Naga Queen.")
                weaponPos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
                weapon:transform(newWeapon) 
                return true
            end
        end
    end
end


enchantEldritch:aid(13131)
enchantEldritch:register()