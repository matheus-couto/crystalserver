function onJoin(player)
    if not ANTIBOT.playerQuestion[player:getId()] then
        player:sendTextMessage(5, ANTIBOT.prefix .. ANTIBOT.messages.chat)
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
    return true
end

function onLeave(player)
    if ANTIBOT.playerQuestion[player:getId()] then
        return false
    end
    return true
end

function onSpeak(player, type, message)
    if not ANTIBOT.playerQuestion[player:getId()] then
        player:sendChannelMessage(player, ANTIBOT.prefix .. ANTIBOT.messages.chat, TALKTYPE_CHANNEL_O, 12)
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    local question = ANTIBOT.playerQuestion[player:getId()]

    if not question then
        player:sendChannelMessage(player, ANTIBOT.prefix .. ANTIBOT.messages.chat, TALKTYPE_CHANNEL_O, 12)
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    local correctAnswer = question.answer
    local verification = false

    if question.staticAnswer then
        message = message:lower()
        correctAnswer = correctAnswer:lower()
    end

    if message == correctAnswer then
        verification = true
    end

    -- NOVO: registra silenciosamente o tempo de resposta e o histórico de
    -- acerto/erro pra alimentar a detecção estatística. Não manda nenhuma
    -- mensagem nem efeito pro jogador — a coleta é 100% silenciosa.
    ANTIBOT:evaluateResponse(player:getId(), verification)

    if verification then
        player:sendChannelMessage(player, ANTIBOT.prefix .. ANTIBOT.messages.correctAnswer, TALKTYPE_CHANNEL_O, 12)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, ANTIBOT.messages.correctAnswer)

        if ANTIBOT.punishment.time.players[player:getId()] < 1 then
            if player:getStorageValue(Storage.Quest.Crandoria.BanAntiAfk) < 1 then
                player:setStorageValue(Storage.Quest.Crandoria.BanAntiAfk, 1)
            else
                player:setStorageValue(Storage.Quest.Crandoria.BanAntiAfk, player:getStorageValue(Storage.Quest.Crandoria.BanAntiAfk) + 1)
            end
        end

        ANTIBOT:reset(player:getId())

        local newTime = math.random(58, 120)
        player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 60 * newTime)

        local summons = player:getSummons()
        for _, summon in ipairs(summons) do
            if summon:getName() == "Anti Afk Orb Anti Noob" or summon:getName() == "" then
                summon:remove()
                player:setStorageValue(Storage.Quest.Crandoria.Antibot.LookType, 0)
            end
        end

        -- local timeNow = os.time()
        -- player:setStorageValue(Storage.Quest.Crandoria.BuffAntiAfk.Xp, timeNow + 15 * 60)

        -- local ring = player:getSlotItem(CONST_SLOT_RING)
        -- if ring and ring.itemid == 12670 then
        --     player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Bonus dobrado por possuir Star Ring.")
        --     player:setStorageValue(Storage.Quest.Crandoria.BuffAntiAfk.StarRing, timeNow + 15 * 60)
        -- else
        --     if player:getStorageValue(Storage.Quest.Crandoria.PasseAntiafk) > timeNow then
        --         player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Bonus dobrado pelo efeito do Passe Afk.")
        --     else
        --         -- CORRIGIDO: "timeNow()" chamava a variável como se fosse função.
        --         -- timeNow é um número (os.time()), não uma função — isso quebraria
        --         -- com "attempt to call a number value" toda vez que chegasse aqui.
        --         if player:getStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffAfk) > timeNow then
        --             player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Bonus dobrado pelo efeito do Buff da Sociedade de Astralis.")
        --         end
        --     end
        -- end
    else
        ANTIBOT:addTry(player:getId())
        addEvent(function()
            if ANTIBOT.punishment.try.players[player:getId()] and ANTIBOT.punishment.try.players[player:getId()] < ANTIBOT.punishment.try.max and player then
                player:sendChannelMessage(player, ANTIBOT.prefix .. ANTIBOT.messages.incorrectAnswer:format(ANTIBOT.punishment.try.max - ANTIBOT.punishment.try.players[player:getId()]), TALKTYPE_CHANNEL_O, 12)
            end
        end, 100)
    end

    return true
end


-- function onJoin(player)
--     if not ANTIBOT.playerQuestion[player:getId()] then
--         player:sendTextMessage(5, ANTIBOT.prefix .. ANTIBOT.messages.chat)
--         player:getPosition():sendMagicEffect(CONST_ME_POFF)
--         return false
--     end
--     return true
-- end

-- function onLeave(player)
--     if ANTIBOT.playerQuestion[player:getId()] then
--         return false
--     end
--     return true
-- end


-- function onSpeak(player, type, message)
--     if not ANTIBOT.playerQuestion[player:getId()] then
--         player:sendChannelMessage(player, ANTIBOT.prefix .. ANTIBOT.messages.chat, TALKTYPE_CHANNEL_O, 12)
--         -- sendChannelMessage(12, TALKTYPE_CHANNEL_O, ANTIBOT.prefix .. ANTIBOT.messages.chat)
--         player:getPosition():sendMagicEffect(CONST_ME_POFF)
--         return false
--     end

--     local question = ANTIBOT.playerQuestion[player:getId()]
    
--     if not question then
--         player:sendChannelMessage(player, ANTIBOT.prefix .. ANTIBOT.messages.chat, TALKTYPE_CHANNEL_O, 12)
--         player:getPosition():sendMagicEffect(CONST_ME_POFF)
--         return false
--     end
    
--     local correctAnswer = question.answer
--     local verification = false

--     if question.staticAnswer then
--         message = message:lower()
--         correctAnswer = correctAnswer:lower()
--     end

--     if message == correctAnswer then
--         verification = true
--     end

--     if verification then
   
--         -- addEvent(sendChannelMessage, 200, 12, TALKTYPE_CHANNEL_O, ANTIBOT.prefix .. ANTIBOT.messages.correctAnswer)
--         player:sendChannelMessage(player, ANTIBOT.prefix .. ANTIBOT.messages.correctAnswer, TALKTYPE_CHANNEL_O, 12)
--         player:sendTextMessage(MESSAGE_EVENT_ADVANCE, ANTIBOT.messages.correctAnswer)
--         if ANTIBOT.punishment.time.players[player:getId()] < 1 then
--             local idxMensagemAleatoria = math.random(1, 6)
          
--             -- player:sendChannelMessage(player, ANTIBOT.fastAnswer[idxMensagemAleatoria].mensagem, TALKTYPE_CHANNEL_O, 12)  
--             if player:getStorageValue(Storage.Quest.Crandoria.BanAntiAfk) < 1 then
--                 player:setStorageValue(Storage.Quest.Crandoria.BanAntiAfk, 1)
--             else
--                 player:setStorageValue(Storage.Quest.Crandoria.BanAntiAfk, player:getStorageValue(Storage.Quest.Crandoria.BanAntiAfk) + 1)
--             end
--         end
--         ANTIBOT:reset(player:getId())

--         min, max = ANTIBOT.verification[1], ANTIBOT.verification[2]
--         random = math.random(min, max)

--         local newTime = math.random(58, 120)

--         -- player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + (60 - ((player:getLevel() / 50) + (player:getStamina() / 300))) * 60)
--         player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 60 * newTime )
--         local summons = player:getSummons()
--         for _, summon in ipairs(summons) do
--             if summon:getName() == "Anti Afk Orb Anti Noob" or summon:getName() == "" then
--                 summon:remove()
--             player:setStorageValue(Storage.Quest.Crandoria.Antibot.LookType, 0)
--             end
--         end

--         local timeNow = os.time()
--         player:setStorageValue(Storage.Quest.Crandoria.BuffAntiAfk.Xp, timeNow + 15 * 60)

--         local timeRandom = math.random(38, 75)
--         local ring = player:getSlotItem(CONST_SLOT_RING)
--         if ring and ring.itemid == 12670 then
--             player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Bonus dobrado por possuir Star Ring.")
--             player:setStorageValue(Storage.Quest.Crandoria.BuffAntiAfk.StarRing, timeNow + 15 * 60)
--         else
--             if player:getStorageValue(Storage.Quest.Crandoria.PasseAntiafk) > timeNow then
--                 player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Bonus dobrado pelo efeito do Passe Afk.")
--             else
--                 if player:getStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffAfk) > timeNow() then
--                     player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Bonus dobrado pelo efeito do Buff da Sociedade de Astralis.")
--                 end
--             end
--         end
--         -- verification = false
--     else
--         ANTIBOT:addTry(player:getId())
--         addEvent(function()
--             if ANTIBOT.punishment.try.players[player:getId()] and ANTIBOT.punishment.try.players[player:getId()] < ANTIBOT.punishment.try.max and player then
--                 player:sendChannelMessage(player, ANTIBOT.prefix .. ANTIBOT.messages.incorrectAnswer:format(ANTIBOT.punishment.try.max - ANTIBOT.punishment.try.players[player:getId()]), TALKTYPE_CHANNEL_O, 12)
--                 -- sendChannelMessage(12, TALKTYPE_CHANNEL_O, ANTIBOT.prefix .. ANTIBOT.messages.incorrectAnswer:format(ANTIBOT.punishment.try.max - ANTIBOT.punishment.try.players[player:getId()]))
--             end
--         end, 100)
--     end

--     return true
-- end




-- ---------------- VERSAO ANTERIOR A 05-01-2026 ---------------------

-- -- function onJoin(player)
-- --     if not ANTIBOT.playerQuestion[player:getId()] then
-- --         player:sendTextMessage(5, ANTIBOT.prefix .. ANTIBOT.messages.chat)
-- --         player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- --         return false
-- --     end
-- --     return true
-- -- end

-- -- function onLeave(player)
-- --     if ANTIBOT.playerQuestion[player:getId()] then
-- --         return false
-- --     end
-- --     return true
-- -- end



-- -- function onSpeak(player, type, message)
-- --     if not ANTIBOT.playerQuestion[player:getId()] then
-- --         player:sendChannelMessage(player, ANTIBOT.prefix .. ANTIBOT.messages.chat, TALKTYPE_CHANNEL_O, 12)
-- --         -- sendChannelMessage(12, TALKTYPE_CHANNEL_O, ANTIBOT.prefix .. ANTIBOT.messages.chat)
-- --         player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- --         return false
-- --     end

-- --     local question = ANTIBOT.playerQuestion[player:getId()]

-- --     if question.staticAnswer then
-- --         message = message:lower()
-- --         correctAnswer = question.answer:lower()
-- --     end

-- --     verification = false

-- --     if message == correctAnswer then
-- --         verification = true
-- --     end

-- --     if verification then
   
-- --         -- addEvent(sendChannelMessage, 200, 12, TALKTYPE_CHANNEL_O, ANTIBOT.prefix .. ANTIBOT.messages.correctAnswer)
-- --         player:sendChannelMessage(player, ANTIBOT.prefix .. ANTIBOT.messages.correctAnswer, TALKTYPE_CHANNEL_O, 12)
-- --         if ANTIBOT.punishment.time.players[player:getId()] < 2 then
-- --             local idxMensagemAleatoria = math.random(1, 6)
          
-- --             -- player:sendChannelMessage(player, ANTIBOT.fastAnswer[idxMensagemAleatoria].mensagem, TALKTYPE_CHANNEL_O, 12)  
-- --             if player:getStorageValue(Storage.Quest.Crandoria.BanAntiAfk) < 1 then
-- --                 player:setStorageValue(Storage.Quest.Crandoria.BanAntiAfk, 1)
-- --             else
-- --                 player:setStorageValue(Storage.Quest.Crandoria.BanAntiAfk, player:getStorageValue(Storage.Quest.Crandoria.BanAntiAfk) + 1)
-- --             end
-- --         end
-- --         ANTIBOT:reset(player:getId())

-- --         min, max = ANTIBOT.verification[1], ANTIBOT.verification[2]
-- --         random = math.random(min, max)

-- --         local newTime = math.random(28, 56)

-- --         -- player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + (60 - ((player:getLevel() / 50) + (player:getStamina() / 300))) * 60)
-- --         player:setStorageValue(Storage.Quest.Crandoria.Antibot.Timer, os.time() + 60 * newTime )
-- --         local summons = player:getSummons()
-- --         for _, summon in ipairs(summons) do
-- --             if summon:getName() == "Anti Afk Orb Anti Noob" or summon:getName() == "" then
-- --                 summon:remove()
-- --         	player:setStorageValue(Storage.Quest.Crandoria.Antibot.LookType, 0)
-- --             end
-- --         end
-- --         -- verification = false
-- --     else
-- --         ANTIBOT:addTry(player:getId())
-- --         addEvent(function()
-- --             if ANTIBOT.punishment.try.players[player:getId()] and ANTIBOT.punishment.try.players[player:getId()] < ANTIBOT.punishment.try.max and player then
-- --                 player:sendChannelMessage(player, ANTIBOT.prefix .. ANTIBOT.messages.incorrectAnswer:format(ANTIBOT.punishment.try.max - ANTIBOT.punishment.try.players[player:getId()]), TALKTYPE_CHANNEL_O, 12)
-- --                 -- sendChannelMessage(12, TALKTYPE_CHANNEL_O, ANTIBOT.prefix .. ANTIBOT.messages.incorrectAnswer:format(ANTIBOT.punishment.try.max - ANTIBOT.punishment.try.players[player:getId()]))
-- --             end
-- --         end, 100)
-- --     end

-- --     return true
-- -- end
