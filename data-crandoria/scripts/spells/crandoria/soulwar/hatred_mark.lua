local spell = Spell("instant")

-- Posição central da área
local centerPos = Position(33743, 31599, 14)
local radius = 10
local damageMin, damageMax = -1000, -2000
local effect = CONST_ME_SMALLCLOUDS

-- Storage de contagem
local storageKey = Storage.Quest.U12_40.SoulWar.TimerDeathHatred

function spell.onCastSpell(creature, variant)
    -- Verifica todas as posições num raio de 10
    for x = -radius, radius do
        for y = -radius, radius do
            local pos = Position(centerPos.x + x, centerPos.y + y, centerPos.z)
            local tile = Tile(pos)
            if tile then
                for _, target in ipairs(tile:getCreatures()) do
                    if target:isPlayer() then
                        local count = target:getStorageValue(storageKey)
                        if count < 0 then count = 0 end

                            -- Já atingiu o limite anteriormente, não faz nada
                        if count >= 29 then
                            -- Atingiu a 30ª vez: aplica dano e efeito
                            doTargetCombatHealth(creature, target, COMBAT_DEATHDAMAGE, damageMin, damageMax, effect)
                            target:setStorageValue(storageKey, 30)
                            target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "30!")
                        else
                            -- Apenas incrementa o contador
                            count = count + 1
                            target:setStorageValue(storageKey, count)
                            target:sendTextMessage(MESSAGE_EVENT_ADVANCE, tostring(count))
                        end
                    end
                end
            end
        end
    end

    return true
end

spell:name("hatred mark")
spell:words("###752")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()