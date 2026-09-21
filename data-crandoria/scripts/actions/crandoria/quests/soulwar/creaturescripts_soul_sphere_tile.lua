local soulSphereTile = MoveEvent()

function soulSphereTile.onStepIn(creature, item, position, fromPosition)
	local pos = creature:getPosition()
	local bossPos = Position(pos.x - 1, pos.y, pos.z)
	local tileBoss = Tile(bossPos)

	if item.itemid == 15469 then
		if creature:getName() == "Soul Sphere" then
			if tileBoss then
				local boss = tileBoss:getTopCreature()
				if boss and boss:isMonster() and boss:getName() == "Goshnar's Greed" then
					addEvent(function()
						boss:addHealth(boss:getMaxHealth() - boss:getHealth())
						-- Remove a esfera
						creature:remove()
					end, 1000)
					return true
				end
			end

			-- Caso contrário, executa o movimento
			addEvent(function()
				if creature and creature:isMonster() then
					creature:changeSpeed(35)
					creature:move(DIRECTION_WEST)
					addEvent(function()
						if creature and creature:isMonster() then
							creature:changeSpeed(-35)
						end
					end, 250)
				end
			end, 4500)
		end
		return true
	elseif item.itemid == 20121 then
		if creature:getName() == "Weak Soul" or creature:getName() == "Strong Soul" or creature:getName() == "Powerful Soul" or creature:getName() == "Soulsnatcher" then
			creature:remove()
			item:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		end
	end
end

soulSphereTile:aid(13145)
soulSphereTile:register()