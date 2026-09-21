local fireFieldId = 33877

-- Posições possíveis onde o fire field pode aparecer
local possiblePositions = {
    Position(33742, 31637, 14),
    Position(33742, 31628, 14),
    Position(33737, 31632, 14),
    Position(33747, 31632, 14)
}

-- Centro para checagem de boss e range de busca
local bossSearchCenter = Position(33742, 31632, 14)
local bossSearchRange = {x = 10, y = 10}

-- Função que troca o boss
local function tryTransformBoss()
    local spectators = Game.getSpectators(bossSearchCenter, false, false, bossSearchRange.x, bossSearchRange.x, bossSearchRange.y, bossSearchRange.y)
    for _, creature in pairs(spectators) do
        if creature:isMonster() then
            local name = creature:getName()
            if name == "Goshnar's Spite" then
                local health = creature:getHealth()
                local maxHealth = creature:getMaxHealth()
                local position = creature:getPosition()
                creature:remove()
                local newBoss = Game.createMonster("Goshnar's Spite 2", position)
                if newBoss then
                    newBoss:setMaxHealth(maxHealth)
                    newBoss:addHealth(-(maxHealth - health)) -- Ajusta a vida
                    newBoss:say("Goshnar's Spite absorbs the soulfire!", TALKTYPE_MONSTER_SAY)
                end
                break
            elseif name == "Goshnar's Spite 2" then
                local health = creature:getHealth()
                local maxHealth = creature:getMaxHealth()
                local position = creature:getPosition()
                creature:remove()
                local newBoss = Game.createMonster("Goshnar's Spite 3", position)
                if newBoss then
                    newBoss:setMaxHealth(maxHealth)
                    newBoss:addHealth(-(maxHealth - health)) -- Ajusta a vida
                    newBoss:say("Goshnar's Spite absorbs the soulfire!", TALKTYPE_MONSTER_SAY)
                end
                break
            end
        end
    end
end

local spell = Spell("instant")
function spell.onCastSpell(creature, variant)
    -- Escolhe uma posição aleatória e cria o fire field
    local pos = possiblePositions[math.random(#possiblePositions)]
    local tile = Tile(pos)
    if tile then
        local item = tile:getItemById(fireFieldId)
        if not item then
            local field = Game.createItem(fireFieldId, 1, pos)
            if field then
                creature:say("A soulfire is blazing! Stomp it out in time!", TALKTYPE_ORANGE_2)
                -- Após 14 segundos, remove o fire field se ainda existir e tenta transformar o boss
                addEvent(function()
                    local tileCheck = Tile(pos)
                    if tileCheck then
                        local fire = tileCheck:getItemById(fireFieldId)
                        if fire then
                            fire:remove()
                            tryTransformBoss()
                        end
                    end
                end, 14000)
            end
        end
    end
    return true
end

spell:name("spite flames")
spell:words("###743")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()