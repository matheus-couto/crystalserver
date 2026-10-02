local pointsArena = TalkAction("!arena")

function pointsArena.onSay(player, words, param)

	player:sendTextMessage(MESSAGE_LOOK, "Voce possui " .. player:getStorageValue(Storage.Quest.Crandoria.TibiaRoyale.WinPoints) .. " pontos de vitoria da Arena.")
    return true
end

pointsArena:groupType("normal")
pointsArena:register()