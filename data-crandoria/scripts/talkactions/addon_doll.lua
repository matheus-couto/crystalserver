local outfits = {
    ["arbalester"] = {1450, 1449},
    ["armoured archer"] = {1619, 1618},
    ["breezy garb"] = {1246, 1245},
    ["ceremonial garb"] = {694, 695},
    ["conjurer"] = {635, 634},
    ["death herald"] = {666, 667},
    ["entrepreneur"] = {471, 472},
    ["fencer"] = {1576, 1575},
    ["forest warden"] = {1416, 1415},
    ["frost tracer"] = {1613, 1612},
    ["ghost blade"] = {1490, 1489},
    ["herbalist"] = {1020, 1021},
    ["herder"] = {1280, 1279},
    ["merry garb"] = {1383, 1382},
    ["moth cape"] = {1339, 1338},
    ["nordic chieftain"] = {1501, 1500},
    ["owl keeper"] = {1174, 1173},
    ["pharaoh"] = {956, 955},
    ["philosopher"] = {874, 873},
    ["ranger"] = {683, 684},
    ["sea dog"] = {749, 750},
    ["seaweaver"] = {732, 733},
    ["shadowlotus disciple"] = {1582, 1581},
    ["siege master"] = {1050, 1051},
    ["spirit caller"] = {698, 699},
    ["sun priest"] = {1024, 1023},
    ["trailblazer"] = {1293, 1292},
    ["veteran paladin"] = {1205, 1204},
}

local addondoll_id = 8778

local addonDoll = TalkAction("!addon")

function addonDoll.onSay(player, words, param)
    if player:getItemCount(addondoll_id) < 1 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa possuir um Addon Doll!")
        return true
    end

    local outfitName = param:lower():trim()
    if not outfitName or not outfits[outfitName] then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Diga !addon seguido do nome do addon que voce deseja.")
        return true
    end

    local outfit = outfits[outfitName]

    if player:hasOutfit(outfit[1], 3) then -- Verifica se já possui ambos os addons
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja possui esse outfit e seus addons.")
        return true
    end

    player:removeItem(addondoll_id, 1)
    player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
    player:addOutfit(outfit[1])
    player:addOutfit(outfit[2])
    player:addOutfitAddon(outfit[1], 1) -- Adiciona ambos os addons (1 e 2)
    player:addOutfitAddon(outfit[2], 1)
    player:addOutfitAddon(outfit[1], 2) -- Adiciona ambos os addons (1 e 2)
    player:addOutfitAddon(outfit[2], 2)
    player:sendTextMessage(MESSAGE_INFO_DESCR, string.format('Você recebeu ambos os addons do outfit %s.', outfitName))
    return true
end

addonDoll:separator(" ")
addonDoll:groupType("normal")
addonDoll:register()






-- local statusDonates = TalkAction("!status")

-- function statusDonates.onSay(player, words, param)

--     local storage1 = Game.getStorageValue(GlobalStorage.Crandoria.Donates.Status1)
--     local storage2 = Game.getStorageValue(GlobalStorage.Crandoria.Donates.Status2)
--     local storageDay = Game.getStorageValue(GlobalStorage.Crandoria.Donates.Day)

--     -- evita valores inválidos
--     if storage1 < 0 then storage1 = 0 end
--     if storage2 < 0 then storage2 = 0 end
--     if storageDay < 0 then storageDay = 0 end

--     local now = os.date("*t")
--     local todayKey = now.day + (now.month * 100)

--     local lastMonth = math.floor(storageDay / 100)
--     local currentMonth = now.month

--     if storageDay > 0 and lastMonth ~= currentMonth then
--         storage1 = storage2
--         storage2 = 0
--         Game.setStorageValue(GlobalStorage.Crandoria.Donates.Status1, storage1)
--         Game.setStorageValue(GlobalStorage.Crandoria.Donates.Status2, 0)
--         Game.setStorageValue(GlobalStorage.Crandoria.Donates.Day, todayKey)
--     elseif storageDay ~= todayKey then
--         storage1 = storage1 + storage2
--         storage2 = 0
--         Game.setStorageValue(GlobalStorage.Crandoria.Donates.Status1, storage1)
--         Game.setStorageValue(GlobalStorage.Crandoria.Donates.Status2, 0)
--         Game.setStorageValue(GlobalStorage.Crandoria.Donates.Day, todayKey)
--     end

--     local meta = 1237
--     local percentage = math.min((storage1 / meta) * 100, 100)
--     local percentageEvent1 = math.min((storage1 / 2032) * 100, 100)
--     local percentageEvent2 = math.min((storage1 / 2509) * 100, 100)

--     if percentage < 1 then
--         percentage = 0
--     end

--     if percentageEvent1 < 1 then
--         percentageEvent1 = 0
--     end

--     if percentageEvent2 < 1 then
--         percentageEvent2 = 0
--     end

--     local msg = string.format(
--         "CrandoriaOT - Doacoes\n\n" ..
--         "Doacoes do mes: %.2f%%\n" ..
--         "Evento TC - Pesca: %.2f%%\n" ..
--         "Evento TC - Mining: %.2f%%\n\n" ..
--         "Utilize o comando !donate para doar e receba Tibia Coins!\n" ..
--         "Sua doacao e muito importante para o servidor.",
--         percentage, percentageEvent1, percentageEvent2
--     )

--     player:popupFYI(msg)

--     return true
-- end

-- statusDonates:register()