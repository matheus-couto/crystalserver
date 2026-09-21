local monsterStatus = TalkAction("!checkmonster")

-------------------------------------------------
-- ELEMENTOS
-------------------------------------------------
local elementNames = {
    [COMBAT_PHYSICALDAMAGE] = "Physical",
    [COMBAT_ENERGYDAMAGE]   = "Energy",
    [COMBAT_EARTHDAMAGE]    = "Earth",
    [COMBAT_FIREDAMAGE]     = "Fire",
    [COMBAT_ICEDAMAGE]      = "Ice",
    [COMBAT_HOLYDAMAGE]     = "Holy",
    [COMBAT_DEATHDAMAGE]    = "Death",
    [COMBAT_LIFEDRAIN]      = "Life Drain",
    [COMBAT_MANADRAIN]      = "Mana Drain",
    [COMBAT_DROWNDAMAGE]    = "Drown"
}

-------------------------------------------------
-- RESISTÊNCIAS
-------------------------------------------------
local function getResistText(player, monsterType)
    local elements = monsterType:getElementList()
    if not elements then
        return "Nenhuma"
    end

    local text = ""

    if player:getClient().version < 1200 then
        local list = {}

        for combatType, value in pairs(elements) do
            local name = elementNames[combatType] or "Desconhecido"
            local line

            if value == 100 then
                line = name .. ": Imune"
            elseif value > 0 then
                line = name .. ": " .. value .. "% Resistente"
            elseif value < 0 then
                line = name .. ": " .. math.abs(value) .. "% Fraco"
            else
                line = name .. ": Normal"
            end

            table.insert(list, line)
        end

        for i = 1, #list, 2 do
            if list[i + 1] then
                text = text .. list[i] .. " | " .. list[i + 1] .. "\n"
            else
                text = text .. list[i] .. "\n"
            end
        end
    else
        for combatType, value in pairs(elements) do
            local name = elementNames[combatType] or "Desconhecido"

            if value == 100 then
                text = text .. name .. ": Imune\n"
            elseif value > 0 then
                text = text .. name .. ": " .. value .. "% Resistente\n"
            elseif value < 0 then
                text = text .. name .. ": " .. math.abs(value) .. "% Fraco\n"
            else
                text = text .. name .. ": Normal\n"
            end
        end
    end

    return text ~= "" and text or "Nenhuma"
end

-------------------------------------------------
-- DEFESAS
-------------------------------------------------
local function getDefenseText(monsterType)
    local defenses = monsterType:getDefenseList()
    local hasSpeed, hasHeal = false, false

    if defenses then
        for _, def in ipairs(defenses) do
            if def.speed and def.speed ~= 0 then
                hasSpeed = true
            end

            if (def.minCombatValue and def.minCombatValue > 0)
            or (def.maxCombatValue and def.maxCombatValue > 0) then
                hasHeal = true
            end
        end
    end

    local text = ""
    if hasSpeed then text = text .. "Velocidade\n" end
    if hasHeal then text = text .. "Cura\n" end

    return text ~= "" and text or "Nenhuma"
end

-------------------------------------------------
-- ATAQUES (APENAS ELEMENTOS)
-------------------------------------------------
local function getAttackText(monsterType)
    local attacks = monsterType:getAttackList()
    if not attacks or #attacks == 0 then
        return "Nenhum"
    end

    local map = {}

    for _, atk in ipairs(attacks) do
        if atk.isMelee == 1 then
            map["Physical"] = true
        elseif atk.isCombatSpell == 1 then
            map["Elemental"] = true
        end
    end

    local text = ""
    for name in pairs(map) do
        text = text .. name .. "\n"
    end

    return text ~= "" and text or "Nenhum"
end

-------------------------------------------------
-- SUMMONS
-------------------------------------------------
local function getSummonText(monsterType)
    local map = {}
    local summons = monsterType:getSummonList()

    if summons then
        for _, summon in ipairs(summons) do
            local name = summon.name
            local count = summon.count or summon.max or 1
            map[name] = (map[name] or 0) + count
        end
    end

    local text = ""
    for name, total in pairs(map) do
        text = text .. name .. " (" .. total .. ")\n"
    end

    return text ~= "" and text or "Nenhum"
end

-------------------------------------------------
-- JANELAS
-------------------------------------------------
function sendMainWindow(player, monsterType)
    local msg =
        "Nome: " .. monsterType:getName() .. "\n" ..
        "Experiencia: " .. monsterType:experience() .. "\n" ..
        "Vida: " .. monsterType:getMaxHealth() .. "\n\n" ..
        "Anda sobre:\n" ..
        "Fire: " .. (monsterType:canWalkOnFire() and "Sim" or "Nao") .. "\n" ..
        "Energy: " .. (monsterType:canWalkOnEnergy() and "Sim" or "Nao") .. "\n" ..
        "Poison: " .. (monsterType:canWalkOnPoison() and "Sim" or "Nao") .. "\n\n" ..
        "Summons:\n" .. getSummonText(monsterType)

    local window = ModalWindow{
        title = "Informacoes do Monstro",
        message = msg
    }

    window:addButton("Resistencias", function()
        sendResistWindow(player, monsterType)
    end)

    window:addButton("Defesas", function()
        sendDefenseWindow(player, monsterType)
    end)

    window:addButton("Ataques", function()
        sendAttackWindow(player, monsterType)
    end)

    window:addButton("Ok")
    window:sendToPlayer(player)
end

function sendResistWindow(player, monsterType)
    local window = ModalWindow{
        title = "Resistencias",
        message = getResistText(player, monsterType)
    }

    window:addButton("Voltar", function()
        sendMainWindow(player, monsterType)
    end)

    window:sendToPlayer(player)
end

function sendDefenseWindow(player, monsterType)
    local window = ModalWindow{
        title = "Habilidades de Defesa",
        message = getDefenseText(monsterType)
    }

    window:addButton("Voltar", function()
        sendMainWindow(player, monsterType)
    end)

    window:sendToPlayer(player)
end

function sendAttackWindow(player, monsterType)
    local window = ModalWindow{
        title = "Ataques",
        message = getAttackText(monsterType)
    }

    window:addButton("Voltar", function()
        sendMainWindow(player, monsterType)
    end)

    window:sendToPlayer(player)
end

-------------------------------------------------
-- COMANDO
-------------------------------------------------
function monsterStatus.onSay(player, words, param)
    if param == "" then
        player:sendCancelMessage("Use: !monster nome do monstro")
        return true
    end

    local monsterType = MonsterType(param)

    if not monsterType then
        player:sendCancelMessage("Nao existe monstro com esse nome.")
        return true
    end

    sendMainWindow(player, monsterType)
    return true
end

monsterStatus:separator(" ")
monsterStatus:groupType("normal")
monsterStatus:register()

