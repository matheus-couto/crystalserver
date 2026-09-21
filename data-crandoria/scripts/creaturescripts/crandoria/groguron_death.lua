-- local config = {
--     centerPosition = Position(4827, 5053, 7),
--     rangeX = 11,
--     rangeY = 20,
-- }

-- local event = CreatureEvent("groguronDeath")

-- function event.onPrepareDeath(creature)
--     local spectators = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
--     local players = {}

--     local msg = "" ..luckyName.. " recebeu um Chaotic Gamble de Groguron."
--     local luckyPlayer = players[math.random(#players)]
--     local positionPlayer = luckyPlayer:getPosition()
--     local luckyName = luckyPlayer:getName()

--     -- Filtrar apenas os jogadores
--     for _, specCreature in pairs(spectators) do
--         if specCreature:isPlayer() then
--             table.insert(players, specCreature)
--         end
--     end

--     if creature:getName() == "Groguron" then
--     -- Selecionar um jogador aleatoriamente para receber o prêmio
--         if #players > 0 then
--             if Game.getStorageValue(GlobalStorage.Crandoria.Eventos.SaoJoao) < os.time() then
--                 Game.setStorageValue(GlobalStorage.Crandoria.Eventos.SaoJoao, os.time() + 48 * 60 * 60)
--                 luckyPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Parabens, voce recebeu um Chaotic Gamble como recompensa!")
--                 -- luckyPlayer:say("|PLAYERNAME| recebeu um Chaotic Gamble do Groguron!", TALKTYPE_MONSTER_SAY, false, nil, positionPlayer)
--                 luckyPlayer:say(msg, TALKTYPE_MONSTER_SAY)
--                 luckyPlayer:addItem(23683, 1)
--             else
--                 luckyPlayer:say("Um jogador ja recebeu um Chaotic Gamble hoje.", TALKTYPE_MONSTER_SAY)
--             end
--         end
--     end

--     return true
-- end

-- event:register()


local config = {
    centerPosition = Position(4827, 5053, 7),
    rangeX = 11,
    rangeY = 20,
}

local event = CreatureEvent("groguronDeath")

-- function event.onPrepareDeath(creature)
function event.onDeath(creature)
    local spectators = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
    local players = {}

    -- Filtrar apenas os jogadores
    for _, specCreature in pairs(spectators) do
        if specCreature:isPlayer() then
            table.insert(players, specCreature)
        end
    end

    -- Selecionar um jogador aleatoriamente para receber o prêmio
    if creature:getName() == "Groguron" then
        if #players > 0 then
            local luckyPlayer = players[math.random(#players)]
            local luckyName = luckyPlayer:getName()
            local positionPlayer = luckyPlayer:getPosition()
            local msg = luckyName .. " recebeu um Chaotic Gamble de Groguron."

            if Game.getStorageValue(GlobalStorage.Crandoria.Eventos.SaoJoao) < os.time() then
                Game.setStorageValue(GlobalStorage.Crandoria.Eventos.SaoJoao, os.time() + 48 * 60 * 60)
                luckyPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Parabens, voce recebeu um Chaotic Gamble como recompensa!")
                luckyPlayer:say(msg, TALKTYPE_MONSTER_SAY)
                luckyPlayer:addItem(23683, 1)
            else
                luckyPlayer:say("Um jogador ja recebeu um Chaotic Gamble hoje.", TALKTYPE_MONSTER_SAY)
            end
            addEvent(function()
                for _, player in pairs(players) do
                    player:teleportTo(Position(5014, 4979, 7))
                end
            end, 3000)
        end
    end

    return true
end

event:register()
