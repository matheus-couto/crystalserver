
local pocaoIzildor = Action()
function pocaoIzildor.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if target:isMonster() and target:getName() == "Monster Izildor" then
		local tile = Tile(target:getPosition())
		local position = target:getPosition()
		local monster = "Izildor"
		local health = target:getHealth()


		if tile:getItemById(2886) then
			item:remove(1)
			target:say('A pocao nao teve nenhum efeito.', TALKTYPE_MONSTER_SAY)
			return false
		else
			item:remove(1)
			target:remove()
			local newMonster = Game.createMonster(monster, position, true, true)

			if newMonster then
				local time = math.random(10000, 60000)
				newMonster:setHealth(health)
				addEvent(function()
					local posMonster = newMonster:getPosition()
					local lifeNewMonster = newMonster:getHealth()
					local oldMonster = Game.createMonster("Monster Izildor", posMonster, true, true)
					newMonster:remove()
					if oldMonster then
						local newItem = Game.createItem(2886, 6, posMonster)
						if newItem then
							newItem:setDuration(15, 30)
							oldMonster:setHealth(lifeNewMonster)
						end
					end
				end, time)
			end
		end
	end
end

pocaoIzildor:id(21803)
pocaoIzildor:register()