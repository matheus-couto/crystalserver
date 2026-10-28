--[[
    Registre essa spell em monster.attacks nos 3 monstros (Pulsating Lava,
    Eruption, Flame Totem), por exemplo:
    { name = "lava stage transform", interval = 2000, chance = 100, target = false },

    Ela só checa a vida atual do monstro que a lançou e decide se troca de
    estágio, preservando a vida na transformação (a cura automática deles já
    cuida de fazer a vida subir; aqui só reagimos ao valor atual).
]]

local function transformTo(monster, newName)
	local position = monster:getPosition()
	local health = monster:getHealth()

	monster:remove()

	local newMonster = Game.createMonster(newName, position, true, true)
	if newMonster then
		local cappedHealth = math.min(health, newMonster:getMaxHealth())
		newMonster:setHealth(cappedHealth)
	end
end

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	if not creature or not creature:isMonster() then
		return true
	end

	local name = creature:getName():lower()
	local health = creature:getHealth()
	local thresholds = EldritchFight.thresholds

	if name == "pulsating lava" then
		if health > thresholds.eruption then
			transformTo(creature, "Eruption")
		end
	elseif name == "eruption" then
		if health > thresholds.flameTotem then
			transformTo(creature, "Flame Totem")
		elseif health < thresholds.eruption then
			transformTo(creature, "Pulsating Lava")
		end
	elseif name == "flame totem" then
		if health < thresholds.flameTotem then
			transformTo(creature, "Eruption")
		end
	end

	return true
end

spell:name("lava stage transform")
spell:words("###lavastage")
spell:isAggressive(false)
spell:needLearn(true)
spell:register()
