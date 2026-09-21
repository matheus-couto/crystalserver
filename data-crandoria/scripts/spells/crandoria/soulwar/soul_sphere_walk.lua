-- local spell = Spell("instant")

-- function spell.onCastSpell(creature, variant)
--     if not creature:isMonster() or creature:getName() ~= "Soul Sphere" then
--         return false
--     end

--     local pos = creature:getPosition()
--     local westPos = Position(pos.x - 1, pos.y, pos.z)

--     local tile = Tile(westPos)
--     if tile then
--         for _, thing in ipairs(tile:getCreatures()) do
--             if thing:isMonster() and thing:getName() == "Goshnar's Greed" then
--                 thing:addHealth(thing:getMaxHealth())
--                 thing:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
--                 creature:remove()
--                 return true
--             end
--         end
--     end

--     creature:changeSpeed(35) -- velocidade temporária
--     creature:move(DIRECTION_WEST)
--     addEvent(function()
--         if creature and creature:isMonster() then
--             creature:changeSpeed(-35) -- zera a velocidade novamente
--         end
--     end, 500)

--     return true
-- end

-- spell:name("soul sphere walk")
-- spell:words("###742")
-- spell:isAggressive(true)
-- spell:blockWalls(true)
-- spell:needLearn(true)
-- spell:register()