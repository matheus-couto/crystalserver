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
    player:setStamina(math.min(2520, stamina + 120))
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    player:sendCancelMessage("Voce regenerou 2 horas da sua stamina.")
    item:remove(1)
    return true
end

smallstaminarefill:id(20138)
smallstaminarefill:register()