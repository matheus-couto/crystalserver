--[[
    Quando o Vladrukh cai pra 25000 de vida ou menos, ele é substituído por um
    Poison Gas com a mesma vida. 20 segundos depois, o Poison Gas é removido e
    o Vladrukh volta no mesmo lugar, com a mesma vida de quando virou gás.

    Isso só pode acontecer 1 VEZ por luta — controlado pela storage global
    "globalVladrukhPoisonTransform". IMPORTANTE: essa storage precisa ser
    resetada pra 0 sempre que uma nova luta contra o Vladrukh começar (no
    script da alavanca/criação do boss), ou a transformação só vai funcionar
    na primeira luta que qualquer jogador fizer contra ele, ficando travada
    pra sempre depois disso.

    Referencie essa spell na tabela monster.attacks do Vladrukh, por exemplo:
    { name = "vladrukh poison transform", interval = 2000, chance = 100, target = false },
]]

local function transformBackToVladrukh(position, health)
	-- Remove o Poison Gas se ele ainda estiver lá (pode já ter sido morto pelos jogadores)
	local tile = Tile(position)
	if tile then
		local creatures = tile:getCreatures()
		for _, creature in ipairs(creatures) do
			if creature:isMonster() and creature:getName():lower() == "poison gas" then
				creature:remove()
				break
			end
		end
	end

	local vladrukh = Game.createMonster("Vladrukh", position, true, true)
	if vladrukh then
		local cappedHealth = math.min(health, vladrukh:getMaxHealth())
		vladrukh:setHealth(cappedHealth)
	end
end

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	if not creature or not creature:isMonster() then
		return true
	end

	local alreadyTransformed = Game.getStorageValue("globalVladrukhPoisonTransform")
	if alreadyTransformed and alreadyTransformed >= 1 then
		return true
	end

	if creature:getHealth() <= 25000 then
		local position = creature:getPosition()
		local health = creature:getHealth()

		Game.setStorageValue("globalVladrukhPoisonTransform", 1)

		creature:remove()

		local poisonGas = Game.createMonster("Poison Gas", position, true, true)
		if poisonGas then
			local cappedHealth = math.min(health, poisonGas:getMaxHealth())
			poisonGas:setHealth(cappedHealth)
		end

		addEvent(transformBackToVladrukh, 15 * 1000, position, health)
	end

	return true
end

spell:name("vladrukh poison transform")
spell:words("###777") -- ajuste se seu fork exigir outro identificador
spell:isAggressive(false)
spell:register()