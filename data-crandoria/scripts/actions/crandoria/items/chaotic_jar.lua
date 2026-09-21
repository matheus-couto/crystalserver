local bossNames = {
    "Abyssador",
    "Alptramun",
    "Ancient Wyrm",
    "Ayana the Crimson Curse",
    "Brokul",
    "Deathstrike",
    "Drume",
    "Gaia",
    "Gaffir",
    "Ghazbaran",
    "Gnomevil",
    "Goshnars Cruelty Jar",
    "Goshnars Greed Jar",
    "Goshnars Malice Jar",
    "Goshnars Megalomania Jar",
    "Goshnars Spite Jar",
    "Jaul",
    "Mad Mage",
    "Magma Bubble",
    "Malofur Mangrinder",
    "Maxxenius",
    "Morgaroth",
    "Obujos",
    "Omrafir",
    "Orobuus",
    "Orshabaal",
    "Plagueroot",
    "Prince Drazzak",
    "Ratmiral Blackwhiskers",
    "Ravenous Hunger",
    "Tamru the Black",
    "Tanjis",
    "Terofar",
    "The Baron from Below",
    "The Brainstealer",
    "The Count Of The Core",
    "The Duke Of The Depths",
    "Frozen King",
	"The Horned Fox",
    "Urmahlullu the Immaculate",
    "Ushuriel",
    "Zavarash",
}

local bossNames2 = {
	"Ferumbras",
	"The Horned Fox",
}

local spawnPos = Position(5109, 4874, 11)

local function hasBossInArea(fromPos, toPos)
    for x = fromPos.x, toPos.x do
        for y = fromPos.y, toPos.y do
            local tile = Tile(Position(x, y, fromPos.z))
            if tile then
                local creature = tile:getTopCreature()
                if creature and creature:isMonster() and creature:getType():isRewardBoss() then
                    return true
                end
            end
        end
    end
    return false
end

local chaoticJar = Action()

function chaoticJar.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    -- if player:getStorageValue(Storage.Quest.Crandoria.ArenaEspecial.Cooldown) > os.time() then
    --     fromPosition:sendMagicEffect(CONST_ME_POFF)
    --     player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce so pode quebrar um Chaotic Jar a cada 1 hora.")
    --     return true
    -- end

    if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) ~= 1 then
        local areaFrom = Position(5098, 4863, 11)
        local areaTo   = Position(5122, 4884, 11)

        if not isPlayerInArea(areaFrom, areaTo) then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
                "Voce so pode quebrar um Chaotic Jar na Arena Especial de Bosses.")
            fromPosition:sendMagicEffect(CONST_ME_POFF)
            return true
        end

        -- 🔒 impede uso se já existir boss
        if hasBossInArea(areaFrom, areaTo) then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
                "Derrote o boss que ja foi libertado.")
            fromPosition:sendMagicEffect(CONST_ME_POFF)
            return true
        end

        -- escolhe boss aleatório
        local bossName = bossNames[math.random(#bossNames)]
        local bossName2 = bossNames2[math.random(#bossNames2)]

        local chance = math.random(1, 500)
        local boss

        if chance < 500 then
            boss = Game.createMonster(bossName, spawnPos)
        else
            boss = Game.createMonster(bossName2, spawnPos)
            bossName = bossName2
        end

        if not boss then
            fromPosition:sendMagicEffect(CONST_ME_POFF)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nada aconteceu... o vaso permanece intacto.")
            return true
        end

        spawnPos:sendMagicEffect(CONST_ME_MORTAREA)
        fromPosition:sendMagicEffect(CONST_ME_AVATAR_APPEAR)
        item:remove(1)

        player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
            "O Chaotic Jar se quebrou, libertando " .. bossName .. "!")

        return true
    else
        local chance = math.random(1, 4)
        if chance == 1 then
            Game.startRaid("Jaul")
            player:setStorageValue(Storage.Quest.Crandoria.ArenaEspecial.Cooldown, os.time() + 60 * 60)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce quebrou o Chaotic Jar, invocando o temivel Jaul em seus aposentos!")
            return true
        elseif chance == 2 then
            Game.startRaid("Jungle Queen")
            player:setStorageValue(Storage.Quest.Crandoria.ArenaEspecial.Cooldown, os.time() + 60 * 60)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce quebrou o Chaotic Jar, invocando a Jungle Queen na selva de Viridia!")
            return true   
        elseif chance == 3 then
            local chanceBeaver = math.random(1, 3)
            if chanceBeaver == 1 then
                Game.createMonster("Giant Beaver", Position(4570, 5374, 6))
                player:setStorageValue(Storage.Quest.Crandoria.ArenaEspecial.Cooldown, os.time() + 60 * 60)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce quebrou o Chaotic Jar, atraindo um Giant Beaver para a ilha de Viridia.") 
                Game.broadcastMessage("Um Giant Beaver foi avistado em Viridia", MESSAGE_EVENT_ADVANCE) 
                return true
            elseif chanceBeaver == 2 then
                Game.createMonster("Giant Beaver", Position(4570, 5374, 6)) 
                Game.createMonster("Giant Beaver", Position(4571, 5374, 6))
                player:setStorageValue(Storage.Quest.Crandoria.ArenaEspecial.Cooldown, os.time() + 60 * 60)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce quebrou o Chaotic Jar, atraindo dois Giant Beavers para a ilha de Viridia.") 
                Game.broadcastMessage("Dois Giant Beavers foram avistados em Viridia", MESSAGE_EVENT_ADVANCE) 
                return true
            elseif chanceBeaver == 3 then
                Game.createMonster("Giant Beaver", Position(4570, 5374, 6)) 
                Game.createMonster("Giant Beaver", Position(4571, 5374, 6))
                Game.createMonster("Giant Beaver", Position(4576, 5372, 6))
                player:setStorageValue(Storage.Quest.Crandoria.ArenaEspecial.Cooldown, os.time() + 60 * 60)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce quebrou o Chaotic Jar, atraindo tres Giant Beavers para a ilha de Viridia.") 
                Game.broadcastMessage("Tres Giant Beavers foram avistados em Viridia", MESSAGE_EVENT_ADVANCE) 
                return true
            end
        elseif chance == 4 then
            player:addItem(14112, 1)
            player:setStorageValue(Storage.Quest.Crandoria.ArenaEspecial.Cooldown, os.time() + 60 * 60)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce quebrou o Chaotic Jar e encontrou dentro dele 1 Bar of Gold!") 
            Game.broadcastMessage("Um habitante de Viridia encontrou 1 Bar of Gold em um Chaotic Jar.", MESSAGE_EVENT_ADVANCE) 
            return true
        end
        return true
    end
end

chaoticJar:id(39707)
chaoticJar:register()