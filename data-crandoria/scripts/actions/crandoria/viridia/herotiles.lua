local heroesTile = MoveEvent()

function heroesTile.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    -- Define a área a ser checada
    local area = {
        fromPosition = Position(4472, 5266, 9),
        toPosition = Position(4476, 5270, 9)
    }

    -- Lista para armazenar os monstros encontrados
    local heroes = {}

    -- Busca por monstros "Hero" na área
    for x = area.fromPosition.x, area.toPosition.x do
        for y = area.fromPosition.y, area.toPosition.y do
            local tile = Tile(Position(x, y, area.fromPosition.z))
            if tile then
                local creatures = tile:getCreatures()
                for _, creature in pairs(creatures) do
                    if creature:getName():lower() == "hero" then
                        table.insert(heroes, creature) -- Adiciona o monstro na lista
                        if #heroes >= 2 then -- Para a busca se já houverem 2 "Hero"
                            break
                        end
                    end
                end
            end
            if #heroes >= 2 then break end
        end
        if #heroes >= 2 then break end
    end

    -- Se houver pelo menos 2 "Hero", teleportamos o jogador e removemos os monstros
    if #heroes >= 2 then
        player:teleportTo(Position(4474, 5257, 9))
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        for _, hero in pairs(heroes) do
            hero:getPosition():sendMagicEffect(CONST_ME_POFF) -- Efeito ao remover os "Hero"
            hero:remove()
        end
        return true
    end

    return true
end

-- Registra o MoveEvent
heroesTile:aid(13107)
heroesTile:register()
