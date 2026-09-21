-- -- local spell = Spell("instant")

-- -- function spell.onCastSpell(player, variant)
-- -- 	local position = player:getPosition()
-- -- 	local monsterName = variant:getString()
-- -- 	local monsterType = MonsterType(monsterName)
-- -- 	local tile = Tile(position)
-- -- 	local corpse = tile:getTopDownItem()
-- -- 	local itemType = corpse:getType()	


-- -- 	if tile then
-- -- 		if corpse then
-- -- 			local itemType = corpse:getType()
-- -- 			if itemType:isCorpse() and itemType:isMovable() then
-- -- 				if #player:getSummons() < 2 and player:getSkull() ~= SKULL_BLACK and not MonsterType:isRewardBoss() then
-- -- 					local summon = Game.createMonster(monsterName, position, true, true)
-- -- 					if summon then
-- -- 						corpse:remove()
-- -- 						player:setSummon(summon)
-- -- 						position:sendMagicEffect(CONST_ME_MAGIC_BLUE)
-- -- 						return true
-- -- 					end
-- -- 				else
-- -- 					player:sendCancelMessage("You cannot control more creatures.")
-- -- 					player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- -- 					return false
-- -- 				end
-- -- 			end
-- -- 		end
-- -- 	end
-- -- end


-- local spell = Spell("instant")

-- -- Lista de ID de corpo permitidos e os monstros correspondentes
-- local allowedCorpses = {
--     [5995] = "Demon",
--     [9009] = "Hellspawn",
--     [6331] = "Hellhound",
--     [6305] = "Undead Dragon",
--     [5284] = "Dragon Lord",
--     [6363] = "Diabolic Imp"
-- }

-- function spell.onCastSpell(player, variant)
--     local position = player:getPosition()
--     local monsterName = variant:getString()
--     local monsterType = MonsterType(monsterName)
--     local tile = Tile(position)
--     local corpse = tile:getTopDownItem()
    
--     if tile and corpse then
--         local corpseID = corpse:getId()
        
--         -- Verifica se o ID do corpo está na lista de ID permitidos
--         if allowedCorpses[corpseID] then
--             local itemType = corpse:getType()
            
--             if itemType:isCorpse() and not itemType:isMovable() then
--                 if #player:getSummons() < 2 and player:getSkull() ~= SKULL_BLACK and not MonsterType:isRewardBoss() then
--                     local summon = Game.createMonster(allowedCorpses[corpseID], position, true, true)
                    
--                     if summon then
--                         corpse:remove()
--                         player:setSummon(summon)		
--                         position:sendMagicEffect(CONST_ME_MAGIC_BLUE)
--                         return true
--                     end
--                 else
--                     player:sendCancelMessage("You cannot control more creatures.")
--                     position:sendMagicEffect(CONST_ME_POFF)
--                     return false
--                 end
-- 			else
-- 				player:sendCancelMessage("You cannot summon a creature from this.")
-- 				position:sendMagicEffect(CONST_ME_POFF)
--             end
--         else
--             player:sendCancelMessage("You cannot summon a creature from this corpse.")
--             position:sendMagicEffect(CONST_ME_POFF)
--             return false
--         end
--     end
-- end


-- spell:group("support")
-- spell:id(305)
-- spell:name("Ressurrect Creature")
-- spell:words("onora res")
-- spell:castSound(SOUND_EFFECT_TYPE_SPELL_SUMMON_CREATURE)
-- spell:level(20)
-- spell:hasParams(true)
-- spell:cooldown(4 * 1000)
-- spell:groupCooldown(2 * 1000)
-- spell:needLearn(false)
-- spell:vocation("summoner;true", "ancient summoner;true")
-- spell:register()


