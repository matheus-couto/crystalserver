local soulcageLifeChange = CreatureEvent("soulcageLifeChange")

local SOULCAGES = {
    ["Zharvorin's Soulcage"] = true,
    ["Scarith's Soulcage"] = true,
    ["Elyrax's Soulcage"] = true,
    ["Myzareth's Soulcage"] = true
}

local function syncSoulcageSummons(soulcageId)
    local soulcage = Creature(soulcageId)
    if not soulcage or not soulcage:isMonster() then
        return
    end

    local soulcageHealth = soulcage:getHealth()
    local summons = soulcage:getSummons()

    for _, summon in ipairs(summons) do
        if summon and summon:isMonster() then
            local summonMaxHealth = summon:getMaxHealth()
            local targetHealth = math.min(soulcageHealth, summonMaxHealth)
            local currentHealth = summon:getHealth()

            if currentHealth ~= targetHealth then
                summon:addHealth(targetHealth - currentHealth)
            end
        end
    end
end

function soulcageLifeChange.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature:isMonster() or not SOULCAGES[creature:getName()] then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    local soulcageId = creature:getId()

    addEvent(function()
        syncSoulcageSummons(soulcageId)
    end, 0)

    return primaryDamage, primaryType, secondaryDamage, secondaryType
end

soulcageLifeChange:register()

-- local soulcageLifeChange = CreatureEvent("soulcageLifeChange")

-- function soulcageLifeChange.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
--     if not creature:isMonster() or (creature:getName() ~= "Zharvorin's Soulcage" and creature:getName() ~= "Scarith's Soulcage" and creature:getName() ~= "Elyrax's Soulcage" and creature:getName() ~= "Myzareth's Soulcage") then
--         return primaryDamage, primaryType, secondaryDamage, secondaryType
--     end

--     local summons = creature:getSummons()

--     if summons then
--         for _, summon in ipairs(summons) do

--         end
--     end

--     return primaryDamage, primaryType, secondaryDamage, secondaryType
-- end

-- soulcageLifeChange:register()