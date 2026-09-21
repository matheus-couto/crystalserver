-- local lagartaEffect = GlobalEvent("LagartaAzulSmoke")

-- local position = Position(4498, 4689, 14)
-- local magicEffects = {
--     CONST_ME_PURPLESMOKE,
--     CONST_ME_REDSMOKE,
--     CONST_ME_GREENSMOKE,
--     CONST_ME_PURPLESMOKE,
--     CONST_ME_YELLOWSMOKE
-- }

-- function lagartaEffect.onThink(interval)
--     local randomEffect = magicEffects[math.random(1, #magicEffects)]
--     position:sendMagicEffect(randomEffect)
--     return true
-- end

-- lagartaEffect:interval(2000)
-- lagartaEffect:register()

local lagartaEffect = GlobalEvent("LagartaAzulSmoke")

local position = Position(4498, 4689, 14)
local magicEffects = {
    CONST_ME_PURPLESMOKE,
    CONST_ME_REDSMOKE,
    CONST_ME_GREENSMOKE,
    CONST_ME_PURPLESMOKE,
    CONST_ME_YELLOWSMOKE
}

function lagartaEffect.onThink(interval)
    local creatures = Tile(position):getCreatures()
    for _, creature in ipairs(creatures) do
        if creature:getName():lower() == "lagarta azul" then
            local randomEffect = magicEffects[math.random(1, #magicEffects)]
            position:sendMagicEffect(randomEffect)
            break
        end
    end
    return true
end

lagartaEffect:interval(2000)
lagartaEffect:register()
