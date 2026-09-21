local antiafk = TalkAction("!antiafk")

function antiafk.onSay(player, words, param)
	local playerId = player:getId()
	if ANTIBOT.playerQuestion[playerId] then
		player:openChannel(12)
		-- player:sendChannelMessage(player, ANTIBOT.prefix .. ANTIBOT.messages.howAnswer:format(os.date("%d")), TALKTYPE_CHANNEL_O, 12)
		-- player:sendChannelMessage(player, ANTIBOT.prefix .. ANTIBOT.messages.incorrectAnswer:format(ANTIBOT.punishment.try.max - ANTIBOT.punishment.try.players[player:getId()]), TALKTYPE_CHANNEL_O, 12)
		player:sendChannelMessage(player, ANTIBOT.prefix .. ANTIBOT.playerQuestion[playerId].question, TALKTYPE_CHANNEL_O, 12)
	else
		local summons = player:getSummons()
		local foundOrb = false
		
		if summons then
			for _, summon in ipairs(summons) do
				if summon:getName() == "Anti Afk Orb Anti Noob" or summon:getName() == "" then
					summon:remove()
					foundOrb = true
					break
				end
			end
		end
		
		if foundOrb then
			player:sendTextMessage(MESSAGE_GAME_HIGHLIGHT, "Anti Afk Orb removido com sucesso.")
		else
			player:sendTextMessage(MESSAGE_GAME_HIGHLIGHT, "Voce nao esta sob efeitos do AntiAfk Check.")
		end
	end
	return true
end

antiafk:groupType("normal")
antiafk:register()


---------------- VERSAO ANTERIOR A 05-01-2026 ----------------


-- local antiafk = TalkAction("!antiafk")

-- function antiafk.onSay(player, words, param)
-- 	local playerId = player:getId()
-- 	if ANTIBOT.playerQuestion[playerId] then
-- 		player:openChannel(12)
-- 		-- player:sendChannelMessage(player, ANTIBOT.prefix .. ANTIBOT.messages.howAnswer:format(os.date("%d")), TALKTYPE_CHANNEL_O, 12)
-- 		-- player:sendChannelMessage(player, ANTIBOT.prefix .. ANTIBOT.messages.incorrectAnswer:format(ANTIBOT.punishment.try.max - ANTIBOT.punishment.try.players[player:getId()]), TALKTYPE_CHANNEL_O, 12)
-- 		player:sendChannelMessage(player, ANTIBOT.prefix .. ANTIBOT.playerQuestion[playerId].question, TALKTYPE_CHANNEL_O, 12)
-- 	else
-- 		local summons = player:getSummons() -- Verifica se o jogador possui summons
-- 		if summons then
-- 			for _, summon in ipairs(summons) do
-- 				if summon:getName() == "Anti Afk Orb Anti Noob" or summon:getName() == "" then
-- 					summon:remove()
-- 				end
-- 			end
-- 		end
-- 		player:sendTextMessage(MESSAGE_GAME_HIGHLIGHT, "Voce nao esta sob efeitos do AntiAfk Check.")
-- 	end
-- 	return true
-- end

-- antiafk:groupType("normal")
-- antiafk:register()
