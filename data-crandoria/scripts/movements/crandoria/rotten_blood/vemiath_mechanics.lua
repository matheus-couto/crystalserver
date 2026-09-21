local rottenBloodDarklightVemiath = MoveEvent()

function rottenBloodDarklightVemiath.onStepIn(creature, item, position, fromPosition)
    local monster = creature:getMonster()
    local player = creature:getPlayer()
    if player then
        player:addHealth(-1000)
        player:getPosition():sendMagicEffect(CONST_ME_BLACK_BLOOD)
    end
    if monster then
        if monster:getName() == "Vemiath" then
            monster:addHealth(3000)
            monster:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
        else
            return false
        end
    end
end

rottenBloodDarklightVemiath:id(43626)
rottenBloodDarklightVemiath:register()