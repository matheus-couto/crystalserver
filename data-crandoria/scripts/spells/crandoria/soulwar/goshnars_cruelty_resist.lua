-- mesma tabela e storage
local RESISTANCE_POSITION = Position(33708, 31675, 14)
local RESISTANCE_BONUSES = {
	[33890] = {min = 1, max = 2},
	[33951] = {min = 0, max = 1}
}
local STORAGE_RESISTANCE = 66625 -- acumulador

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)

	if not creature or not creature:isMonster() then
		return false
	end

	local tile = Tile(RESISTANCE_POSITION)
	if not tile then return false end

	local item = tile:getItemById(33890) or tile:getItemById(33951)
	if not item then return false end

	local bonus = RESISTANCE_BONUSES[item:getId()]
	if not bonus then return false end

	local newValue = math.random(bonus.min, bonus.max)
	local current = creature:getStorageValue(STORAGE_RESISTANCE)
	if current < 0 then current = 0 end

	local total = current + newValue

	-- Opcional: capar em 50% por exemplo
	if total > 90 then total = 90 end

	creature:setStorageValue(STORAGE_RESISTANCE, total)

	-- Remove condição anterior (com mesmo subID)
	creature:removeCondition(CONDITION_ATTRIBUTES, false, 1000)

	local condition = Condition(CONDITION_ATTRIBUTES)
	condition:setParameter(CONDITION_PARAM_TICKS, -1)
	condition:setParameter(CONDITION_PARAM_SUBID, 1000)

	-- Aplica o TOTAL acumulado
	condition:setParameter(CONDITION_PARAM_ABSORB_FIREPERCENT, total)
	condition:setParameter(CONDITION_PARAM_ABSORB_ICEPERCENT, total)
	condition:setParameter(CONDITION_PARAM_ABSORB_EARTHPERCENT, total)
	condition:setParameter(CONDITION_PARAM_ABSORB_ENERGYPERCENT, total)
	condition:setParameter(CONDITION_PARAM_ABSORB_HOLYPERCENT, total)
	condition:setParameter(CONDITION_PARAM_ABSORB_DEATHPERCENT, total)
	condition:setParameter(CONDITION_PARAM_ABSORB_PHYSICALPERCENT, total)

	creature:addCondition(condition)
	creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)

	return true
end

spell:name("goshnars cruelty resist")
spell:words("###746")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()