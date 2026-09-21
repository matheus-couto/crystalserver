local spell = Spell("instant")

-- ⚙️ Configurações
local teleportPos = Position(4840, 5249, 11)
local areaSize = 8

-- Cria área de efeito 8x8
local area = {}
for y = -areaSize, areaSize do
    local row = {}
    for x = -areaSize, areaSize do
        table.insert(row, 1)
    end
    table.insert(area, row)
end

local combat = Combat()
local areaSpell = createCombatArea(area)
combat:setArea(areaSpell)

-- Função principal da spell
function spell.onCastSpell(creature, var)
    local center = creature:getPosition()
    local players = {}

    -- 🔹 Coleta todos os jogadores na área 8x8
    for x = center.x - areaSize, center.x + areaSize do
        for y = center.y - areaSize, center.y + areaSize do
            local tile = Tile(Position(x, y, center.z))
            if tile then
                local top = tile:getTopCreature()
                if top and top:isPlayer() then
                    table.insert(players, top)
                end
            end
        end
    end

    -- 🔹 Agrupa jogadores por IP
    local ipGroups = {}
    for _, player in pairs(players) do
        local ip = player:getIp()
        if ip then
            ipGroups[ip] = ipGroups[ip] or {}
            table.insert(ipGroups[ip], player)
        end
    end

    -- 🔹 Para cada grupo com mais de um jogador, remove o de maior nível
    for ip, group in pairs(ipGroups) do
        if #group > 1 then
            local highestLevelPlayer = group[1]
            for i = 2, #group do
                if group[i]:getLevel() > highestLevelPlayer:getLevel() then
                    highestLevelPlayer = group[i]
                end
            end

            -- Teleporta o jogador com maior nível
            highestLevelPlayer:teleportTo(teleportPos)
            teleportPos:sendMagicEffect(CONST_ME_TELEPORT)
            highestLevelPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce foi removido da área por estar com outro jogador do mesmo IP.")
        end
    end

    return combat:execute(creature, var)
end

spell:name("check ip")
spell:words("###767")
spell:needLearn(true)
spell:cooldown(2000)
spell:isSelfTarget(true)
spell:register()