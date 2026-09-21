local condition = Condition(CONDITION_INVISIBLE)
condition:setParameter(CONDITION_PARAM_TICKS, 2000)

local spell = Spell("instant")
local MONSTER_NAME = "Tharkor the Double Shadow"
local MIN_HEALTH = 100000

-- Área segura para criação de clones
local fromArea = Position(5040, 5158, 14)
local toArea   = Position(5059, 5173, 14)

-- helpers
local function isInArea(pos, fromPos, toPos)
    return pos.x >= fromPos.x and pos.x <= toPos.x and
           pos.y >= fromPos.y and pos.y <= toPos.y and
           pos.z == fromPos.z
end

local function isSpawnableTile(pos)
    local tile = Tile(pos)
    if not tile then return false end
    if tile:hasProperty(CONST_PROP_BLOCKSOLID) then return false end
    if tile:getTopCreature() then return false end
    if tile:hasFlag(TILESTATE_PROTECTIONZONE) then return false end
    return true
end

-- coleta todas as posições livres dentro da área e ordena por distância ao centro
local function collectFreePositionsSorted(center, fromPos, toPos)
    local list = {}
    for x = fromPos.x, toPos.x do
        for y = fromPos.y, toPos.y do
            local p = Position(x, y, fromPos.z)
            if isSpawnableTile(p) then
                local dx = p.x - center.x
                local dy = p.y - center.y
                local dist2 = dx*dx + dy*dy
                table.insert(list, {pos = p, dist2 = dist2})
            end
        end
    end
    table.sort(list, function(a,b) return a.dist2 < b.dist2 end)
    local positions = {}
    for _, v in ipairs(list) do table.insert(positions, v.pos) end
    return positions
end

-- retorna duas posições livres preferencialmente próximas ao center.
-- Se center for livre e dentro da área, ele será escolhido como primeira posição.
local function getTwoPositionsForClones(center, fromPos, toPos)
    local positions = collectFreePositionsSorted(center, fromPos, toPos)
    if #positions == 0 then
        return nil, nil
    end

    -- se center estiver dentro da área e livre, tenta usá-lo como pos1
    if isInArea(center, fromPos, toPos) and isSpawnableTile(center) then
        local pos1 = center
        -- encontrar a posição mais próxima diferente de center
        for _, p in ipairs(positions) do
            if not (p.x == pos1.x and p.y == pos1.y) then
                return pos1, p
            end
        end
        -- se não houver outra posição
        return pos1, nil
    end

    -- caso center não possa ser usado, pega as duas primeiras posições da lista
    if #positions >= 2 then
        return positions[1], positions[2]
    elseif #positions == 1 then
        return positions[1], nil
    end
    return nil, nil
end

-- efeito visual entre posições
local function createShadowEffect(fromPos, toPos)
    local xDiff = toPos.x - fromPos.x
    local yDiff = toPos.y - fromPos.y
    local steps = math.max(math.abs(xDiff), math.abs(yDiff))
    if steps <= 0 then return end
    for i = 1, steps do
        local stepX = fromPos.x + math.floor(xDiff * (i / steps))
        local stepY = fromPos.y + math.floor(yDiff * (i / steps))
        local stepPos = Position(stepX, stepY, fromPos.z)
        addEvent(function()
            stepPos:sendMagicEffect(CONST_ME_MORTAREA)
        end, i * 30)
    end
end

function spell.onCastSpell(creature, var)
    local health = creature:getHealth()
    local pos = creature:getPosition()

    if health < MIN_HEALTH then
        return true
    end

    pos:sendMagicEffect(CONST_ME_MAGIC_BLUE)

    -- remove o boss original *antes* de tentar criar clones
    creature:remove()

    -- pequeno delay para o servidor atualizar o tile do boss removido
    addEvent(function()
        -- busca duas posições válidas para os clones
        local pos1, pos2 = getTwoPositionsForClones(pos, fromArea, toArea)

        if not pos1 then
            print("[Tharkor Clone] Falha: nenhuma posição disponível na area.")
            return
        end
        if not pos2 then
            print("[Tharkor Clone] Atenção: apenas 1 posição livre encontrada na area; abortando criação dupla.")
            -- Se você quiser forçar a criação de 1 clone quando só houver 1 posição livre,
            -- descomente abaixo (mas conforme solicitado, você queria 2 clones).
            -- local c1 = Game.createMonster(MONSTER_NAME, pos1)
            -- if c1 then c1:setHealth(health); pos1:sendMagicEffect(CONST_ME_MORTAREA) end
            return
        end

        -- tenta criar os dois clones *simultaneamente* (sequencialmente, mas sem delays entre as criações)
        local clone1 = Game.createMonster(MONSTER_NAME, pos1)
        local clone2 = Game.createMonster(MONSTER_NAME, pos2)

        if not clone1 or not clone2 then
            print("[Tharkor Clone] Falha ao criar clones (clone1, clone2):", tostring(clone1) .. ", " .. tostring(clone2))
            -- tentativa de fallback: tente outras posições disponíveis ordenadas
            local fallbackPositions = collectFreePositionsSorted(pos, fromArea, toArea)
            -- remove pos1 and pos2 if present
            local used = {}
            if pos1 then used[pos1.x .. "," .. pos1.y] = true end
            if pos2 then used[pos2.x .. "," .. pos2.y] = true end
            local alt1, alt2
            for _, p in ipairs(fallbackPositions) do
                if not used[p.x .. "," .. p.y] then
                    if not alt1 then alt1 = p
                    elseif not alt2 then alt2 = p; break
                    end
                end
            end
            if alt1 and alt2 then
                clone1 = clone1 or Game.createMonster(MONSTER_NAME, alt1)
                clone2 = clone2 or Game.createMonster(MONSTER_NAME, alt2)
                if clone1 then clone1:setHealth(health); alt1:sendMagicEffect(CONST_ME_MORTAREA) end
                if clone2 then clone2:setHealth(health); alt2:sendMagicEffect(CONST_ME_MORTAREA) end
            else
                print("[Tharkor Clone] Fallback falhou - posicoes alternativas insuficientes.")
                return
            end
        end

        -- se ambos foram criados com sucesso, seta vida e efeitos
        if clone1 then
            clone1:setHealth(health)
            pos1:sendMagicEffect(CONST_ME_MORTAREA)
        end
        if clone2 then
            clone2:setHealth(health)
            pos2:sendMagicEffect(CONST_ME_MORTAREA)
        end

        -- cria trilha/efeito entre os dois (opcional)
        if clone1 and clone2 then
            createShadowEffect(pos1, pos2)
        end

        -- remove aleatoriamente um dos dois após 5s
        if clone1 and clone2 then
            local targetClone = (math.random(1, 2) == 1) and clone1 or clone2
            addEvent(function()
                if targetClone and targetClone:isMonster() then
                    targetClone:getPosition():sendMagicEffect(CONST_ME_POFF)
                    targetClone:remove()
                end
            end, 5000)
        end
    end, 1000) -- delay após remover o boss (300ms)
end

spell:name("tharkor clone")
spell:words("###763")
spell:needLearn(true)
spell:cooldown(2000)
spell:isSelfTarget(true)
spell:register()


-- local condition = Condition(CONDITION_INVISIBLE)
-- condition:setParameter(CONDITION_PARAM_TICKS, 2000)

-- local spell = Spell("instant")

-- local combats = {combatTiny, combatSmaller, combatSmall, combatMedium, combatLarge, combatBigger, combatSuper, combatGiant }

-- function spell.onCastSpell(creature, var)
--     local health = creature:getHealth()
--     local pos = creature:getPosition()

--     if health < 100000 then
--         return true
--     end

--     -- creature:addCondition(condition)
--     pos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
--     creature:remove()

--     addEvent(function()
--         local clone = Game.createMonster("Tharkor the Double Shadow", pos)
--         pos:sendMagicEffect()
--         if clone then
--             clone:setHealth(health)
--             local clone2 = Game.createMonster("Tharkor the Double Shadow", clone:getPosition())
--             if clone2 then
--                 clone2:setHealth(clone:getHealth())
--                 local chance = math.random(1, 2)
--                 if chance == 1 then
--                     addEvent(function()
--                         clone:getPosition():sendMagicEffect(CONST_ME_POFF)
--                         clone:remove()
--                     end, 5000)
--                 else
--                     addEvent(function()
--                         clone2:getPosition():sendMagicEffect(CONST_ME_POFF)
--                         clone2:remove()
--                     end, 5000)
--                 end
--             end
--         end
--     end, 1000)

-- end

-- spell:name("tharkor clone")
-- spell:words("###763")
-- spell:needLearn(true)
-- spell:cooldown("2000")
-- spell:isSelfTarget(true)
-- spell:register()