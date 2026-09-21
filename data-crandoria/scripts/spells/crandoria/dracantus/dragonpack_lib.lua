--[[
    DRAGON PACK - Crandoria
    Lib compartilhada: storages globais, skill (Combat) de cada boss, e a lógica
    de "herança" de habilidades entre bosses já mortos.

    Pra adicionar um boss novo:
    1. Adicione a storage dele em `DragonPackStorages`.
    2. Adicione o nome dele em `DragonPackOrder` (ordem só organizacional, não afeta a lógica).
    3. Monte o Combat dele em `DragonPackSkills.NomeDoBoss`.
    Nada mais precisa mudar — a seleção de spell já lida com isso sozinha.
]]

DragonPackStorages = {
    Maliz   = GlobalStorage.Crandoria.DragonPack.Effects.Maliz,
    Vengar  = GlobalStorage.Crandoria.DragonPack.Effects.Vengar,
    Bruton  = GlobalStorage.Crandoria.DragonPack.Effects.Bruton,
    Greedok = GlobalStorage.Crandoria.DragonPack.Effects.Greedok,
    Vilear  = GlobalStorage.Crandoria.DragonPack.Effects.Vilear,
    Crultor = GlobalStorage.Crandoria.DragonPack.Effects.Crultor,
    Despor  = GlobalStorage.Crandoria.DragonPack.Effects.Despor,
}

DragonPackOrder = { "Maliz", "Vengar", "Bruton", "Greedok", "Vilear", "Crultor", "Despor" }

-- Lê a storage NA HORA (não guarda em cache), pra sempre refletir mortes recentes
function isDragonPackBossDead(name)
    local storage = DragonPackStorages[name]
    if not storage then
        return false
    end
    return Game.getStorageValue(storage) == 2
end

-- Chama isso no onDeath de cada boss do pack (veja creaturescripts/dragonpack_death.lua)
function markDragonPackBossDead(name)
    local storage = DragonPackStorages[name]
    if storage then
        Game.setStorageValue(storage, 2)
    end
end

DragonPackSkills = {}

-- ================= MALIZ — dano em corrente =================
DragonPackSkills.Maliz = Combat()
DragonPackSkills.Maliz:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
DragonPackSkills.Maliz:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
DragonPackSkills.Maliz:setParameter(COMBAT_PARAM_CHAIN_EFFECT, CONST_ME_MORTAREA)
DragonPackSkills.Maliz:setFormula(COMBAT_FORMULA_DAMAGE, -800, 0, -2000, 0) 

function malizChainValue(creature)
    return 2, 3, false -- ajuste range/alcance da corrente conforme necessário
end
DragonPackSkills.Maliz:setCallback(CALLBACK_PARAM_CHAINVALUE, "malizChainValue")

-- ================= VENGAR — causa Fear =================
DragonPackSkills.Vengar = Combat()
DragonPackSkills.Vengar:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SOUND_PURPLE)
DragonPackSkills.Vengar:setArea(createCombatArea(AREA_CIRCLE3X3))

local conditionVengarFear = Condition(CONDITION_FEARED)
conditionVengarFear:setParameter(CONDITION_PARAM_TICKS, 3000)
DragonPackSkills.Vengar:addCondition(conditionVengarFear)

-- ================= BRUTON — cura alta (até ~7000 HP) =================
-- PLACEHOLDER: ajuste o tipo/fórmula de cura conforme a API de cura do seu server.
-- Exemplo com valor fixo de cura (self-heal, não é dano ao jogador):
DragonPackSkills.Bruton = Combat()
DragonPackSkills.Bruton:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
DragonPackSkills.Bruton:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
DragonPackSkills.Bruton:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
DragonPackSkills.Bruton:setParameter(COMBAT_PARAM_MINVALUE, 1000)
DragonPackSkills.Bruton:setParameter(COMBAT_PARAM_MAXVALUE, 7000)

-- ================= GREEDOK — Intense Hex =================
local crultorRootArea = {
    { 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
    { 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
    { 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
    { 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0 },
    { 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0 },
    { 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
    { 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
    { 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
    { 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
    { 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0 },
}

DragonPackSkills.Greedok = Combat()
DragonPackSkills.Greedok:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
DragonPackSkills.Greedok:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_WATERSPLASH)
DragonPackSkills.Greedok:setFormula(COMBAT_FORMULA_DAMAGE, -800, 0, -1500, 0) 
local conditionHex = Condition(CONDITION_INTENSEHEX)
conditionHex:setParameter(CONDITION_PARAM_BUFF_DAMAGEDEALT, 50)
conditionHex:setParameter(CONDITION_PARAM_BUFF_HEALINGRECEIVED, 50)
conditionHex:setParameter(CONDITION_PARAM_TICKS, 5000)
DragonPackSkills.Greedok:addCondition(conditionHex)
DragonPackSkills.Greedok:setArea(createCombatArea(crultorRootArea))

-- ================= VILEAR — Mana Drain alto =================
DragonPackSkills.Vilear = Combat()
DragonPackSkills.Vilear:setParameter(COMBAT_PARAM_TYPE, COMBAT_MANADRAIN)
DragonPackSkills.Vilear:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SOUND_PURPLE)
DragonPackSkills.Vilear:setFormula(COMBAT_FORMULA_DAMAGE, -800, 0, -2500, 0) 
DragonPackSkills.Vilear:setArea(createCombatArea(AREA_CIRCLE3X4))

-- ================= CRULTOR — Root =================

DragonPackSkills.Crultor = Combat()
DragonPackSkills.Crultor:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE) -- ajuste se necessário
DragonPackSkills.Crultor:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_WATERSPLASH)
DragonPackSkills.Crultor:setFormula(COMBAT_FORMULA_DAMAGE, -800, 0, -2000, 0) 
DragonPackSkills.Crultor:setArea(createCombatArea(crultorRootArea))

local conditionRoot = Condition(CONDITION_ROOTED)
conditionRoot:setParameter(CONDITION_PARAM_TICKS, 3000)
DragonPackSkills.Crultor:addCondition(conditionRoot)

-- ================= DESPOR — redução de skills =================
DragonPackSkills.Despor = Combat()
DragonPackSkills.Despor:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
DragonPackSkills.Despor:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SOUND_PURPLE)
local conditionDespor = Condition(CONDITION_ATTRIBUTES)
conditionDespor:setParameter(CONDITION_PARAM_TICKS, 7000)
conditionDespor:setParameter(CONDITION_PARAM_SKILL_MELEEPERCENT, 40)
conditionDespor:setParameter(CONDITION_PARAM_SKILL_DISTANCEPERCENT, 40)
conditionDespor:setParameter(CONDITION_PARAM_SKILL_FISTPERCENT, 40)
conditionDespor:setParameter(CONDITION_PARAM_STAT_MAGICPOINTSPERCENT, 40)
conditionDespor:setParameter(CONDITION_PARAM_SKILL_DEFENSEPERCENT, 40)
DragonPackSkills.Despor:setArea(createCombatArea(AREA_CIRCLE3X4))
DragonPackSkills.Despor:setFormula(COMBAT_FORMULA_DAMAGE, -800, 0, -2000, 0) 
DragonPackSkills.Despor:addCondition(conditionDespor)

function getDragonPackAvailableSkills(bossName)
    local pool = {}

    if DragonPackSkills[bossName] then
        pool[#pool + 1] = DragonPackSkills[bossName]
    end

    for _, name in ipairs(DragonPackOrder) do
        if name ~= bossName and isDragonPackBossDead(name) and DragonPackSkills[name] then
            pool[#pool + 1] = DragonPackSkills[name]
        end
    end

    return pool
end
