local outfits = {1303, 1304, 1305, 1306, 1307}

local function getRandomOutfit()
	return outfits[math.random(#outfits)]
end

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	if not creature:isMonster() then
		return false
	end

	local newOutfit = getRandomOutfit()
	local currentOutfit = creature:getOutfit()
	currentOutfit.lookType = newOutfit

	creature:setOutfit(currentOutfit)
	creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	return true
end

spell:name("aspect transform")
spell:words("###754") -- Palavra mágica opcional
spell:needLearn(false)
spell:isAggressive(false)
spell:register()