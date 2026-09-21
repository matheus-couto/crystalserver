local goldCoinThrow = MoveEvent()

function goldCoinThrow.onAddItem(moveitem, tileitem, position)
	local creature = Tile(position):getTopCreature()
	if not creature or not creature:isMonster() or moveitem.itemid ~= 3031  then
		return true 
	end

	local damage = 1000 
	local health = creature:getHealth()
	local newHealth = math.max(0, health - 1000)

	if creature and creature:getName() == "Power Generator" then
		creature:setHealth(newHealth)
		moveitem:remove()
		position:sendMagicEffect(CONST_ME_HITAREA)
		if newhealth < 1 then
			local brokeGenerator = Game.createItem(20784, position)
			addEvent(function()
				if brokeGenerator then
					brokeGenerator:remove()
					Game:createMonster("Power Generator", position)
				end
			end, 30000)
		end
	end

	return true
end

goldCoinThrow:type("additem")
goldCoinThrow:aid(13221)
goldCoinThrow:register()