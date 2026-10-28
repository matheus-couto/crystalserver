local soulTrap = Action()
function soulTrap.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    local storage = player:getStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.BoneOverlordTimer)

    if storage > os.time() then
        player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.BoneOverlordTimer, 0)
        item:remove(1)
        fromPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce reiniciou o seu cooldown para enfrentar o Bone Overlord.")
        return true
    else
        fromPosition:sendMagicEffect(CONST_ME_POFF)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O item nao parece ser necessario no momento.")
        return true
    end
    return true

end

soulTrap:id(52714)
soulTrap:register()