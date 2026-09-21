local potentDew = Action()
function potentDew.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not player then
        return true
    end

    local storage = player:getStorageValue(Storage.Quest.Crandoria.TheRiseOfPodzilla.Progresso)
    
    local chance = math.random(1, 4)
    if stoarge == 4 then
        if target.itemid == 48123 then
            if chance == 1 then
                item:remove(1)
                toPosition:sendMagicEffect(CONST_ME_POISONAREA)
                player:say('FSSSSSSSSSSSSS!', TALKTYPE_MONSTER_SAY)
                player:setStorageValue(Storage.Quest.Crandoria.TheRiseOfPodzilla.Progresso, 5)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce contaminou o coracao. Retorne a Two Lips e reporte sua missao.")
            else
                item:remove(1)
                toPosition:sendMagicEffect(CONST_ME_POISONAREA)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce usou o orvalho e enfraqueceu o coracao. Continue tentando contamina-lo.")
            end
        end
    end
    return true
end

potentDew:id(48422)
potentDew:register()