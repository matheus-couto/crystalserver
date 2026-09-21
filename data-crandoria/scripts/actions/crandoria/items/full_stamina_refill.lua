local smallstaminarefill = Action()
function smallstaminarefill.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local stamina = player:getStamina()

    if target ~= player then
        player:sendCancelMessage("voce so pode utilizar esse item no seu personagem.")
        return true
    end

    if stamina >= 2520 then
        player:sendCancelMessage("Voce ja esta com a Stamina cheia.")
        return true
    end
    player:setStamina(2520)
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    player:sendCancelMessage("Voce encheu toda a sua stamina.")
    item:remove(1)
    return true
end

smallstaminarefill:id(20139)
smallstaminarefill:register()