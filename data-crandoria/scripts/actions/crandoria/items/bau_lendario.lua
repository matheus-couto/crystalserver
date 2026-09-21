local bauLendario = Action()

function bauLendario.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    local storage = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
    local cooldown = player:getStorageValue(Storage.Quest.Crandoria.Reputation.BauLendario)
    local chance = math.random(1, 25)

    local rewards = {
	{ id = 22706, name = "Special Casino Ticket" },
    { id = 11372, name = "Experience Boost Potion" },
    { id = 20138, name = "Small Stamina Refill" },
    { id = 20139, name = "Full Stamina Refill" },
    { id = 39707, name = "Chaotic Jar" },
    { id = 11468, name = "Blessed Symbol" },
    { id = 8778, name = "Addon Doll" },
    { id = 22771, name = "Mount Certificate" },
    { id = 9099, name = "Black Candle" },
    { id = 36875, name = "Espelho do Mercador" },
    { id = 26186, name = "Exercise Stash" },
    { id = 36727, name = "Wealth Duplex" },
    { id = 12811, name = "Chaotic Gamble" },
    { id = 36728, name = "Bestiary Betterment" },
    { id = 36724, name = "Strike Enhancement" },
    { id = 20272, name = "Bronze Prison Key" },
    { id = 20270, name = "Silver Prison Key" },
    { id = 20273, name = "Golden Prison Key" },
    }

    local randId = math.random(1, #rewards)
	local rewardItem = rewards[randId]

    if storage >= 1000 then
        if cooldown < os.time() then
            if player:getFreeCapacity() >= 10000 and player:getFreeBackpackSlots() >= 1 then
                if chance > 0 and chance < 16 then
                    player:addItem(rewardItem.id, 1)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 " .. rewardItem.name .. ".")
                elseif chance == 16 then
                    local container = player:addItem(2863, 1)
                    if container then
                        container:addItem(9685, 25)
                        container:addItem(9633, 15)
                        container:addItem(9663, 5)
                        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 Kit de Imbuing - Powerful Vampirism.")
                    end
                elseif chance == 17 then
                    local container = player:addItem(2863, 1)
                    if container then
                        container:addItem(9685, 25)
                        container:addItem(9633, 15)
                        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 Kit de Imbuing - Intricate Vampirism.")
                    end
                elseif chance == 18 then
                    local container = player:addItem(2863, 1)
                    if container then
                        container:addItem(11444, 20)
                        container:addItem(10311, 25)
                        container:addItem(22728, 5)
                        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 Kit de Imbuing - Powerful Strike.")
                    end
                elseif chance == 19 then
                    local container = player:addItem(2863, 1)
                    if container then
                        container:addItem(11444, 20)
                        container:addItem(10311, 25)
                        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 Kit de Imbuing - Intricate Strike.")
                    end
                elseif chance == 20 then
                    local container = player:addItem(2863, 1)
                    if container then
                        container:addItem(11492, 25)
                        container:addItem(20200, 25)
                        container:addItem(22730, 5)
                        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 Kit de Imbuing - Powerful Void.")
                    end
                elseif chance == 21 then
                    local container = player:addItem(2863, 1)
                    if container then
                        container:addItem(11492, 25)
                        container:addItem(20200, 25)
                        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 Kit de Imbuing - Intricate Void.")
                    end
                elseif chance == 22 then
                    local prey = math.random(2, 4)
                    player:addPreyCards(prey)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu "..prey.." Prey Cards.")
                elseif chance == 23 then
                    local premium = math.random(2, 5)
                    player:addPremiumDays(premium)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu "..premium.." dias VIP.")
                elseif chance == 24 then
                    local values = {10, 20, 30, 40, 50}
                    local charm = values[math.random(#values)]
                    player:addCharmPoints(charm)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu "..charm.." Charm Points.")
                elseif chance == 25 then
                    player:addItem(14112, 1)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1kk!")
                end
                fromPosition:sendMagicEffect(CONST_ME_FIREWORK_BLUE)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storage - 2)
                player:say("- Reputacao", TALKTYPE_MONSTER_SAY)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.BauLendario, os.time() + 7 * 24 * 60 * 60)
                return false
            else
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa possuir 1 espaco no inventario e ao menos 100 de Cap disponiveis para receber a recompensa.")
                fromPosition:sendMagicEffect(CONST_ME_POFF)
                return false
            end
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce so pode obter 1 recompensa por semana no Bau Lendario.")
            fromPosition:sendMagicEffect(CONST_ME_POFF)
            return false
        end
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Apenas personagens com reputacao 'Lendario' podem abrir o bau.")
        fromPosition:sendMagicEffect(CONST_ME_POFF)
        return false
    end
    return false
end


bauLendario:aid(13198)
bauLendario:register()