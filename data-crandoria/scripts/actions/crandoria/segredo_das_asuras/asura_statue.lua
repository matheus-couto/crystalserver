local asuraStatue = Action()

function asuraStatue.onUse(player, item, fromPosition, target, toPosition, isHotkey)
  if player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.StatuePortal) > 0 then
    player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    player:teleportTo(Position(5126, 4778, 15))
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce entrou no Inferno das Asuras.")
    if player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.Reward) < 0 then
      player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.Reward, 0)
    end
    return true
  else
    player:getPosition():sendMagicEffect(CONST_ME_POFF)
    return true
  end
end


asuraStatue:aid(12367)
asuraStatue:register()