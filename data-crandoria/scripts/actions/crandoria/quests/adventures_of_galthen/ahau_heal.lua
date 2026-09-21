AhauConfig = {
    Storage = {
        Life = 1,
        Exhaust = 2,
    },
    Monster = {
        "Cursed Ape",
        "Iks Chuka",
    },
    AmountLife = 3,
}

local function healAhau(monster)
    local storage = monster:getStorageValue(AhauConfig.Storage.Life)
    monster:setStorageValue(AhauConfig.Storage.Life, storage + 1)
    monster:addHealth(monster:getMaxHealth())
end

function SendHeal(monster)
    healAhau(monster)
    Game.createMonster(AhauConfig.Monster[math.random(#AhauConfig.Monster)], monster:getPosition(), true, true)
end


