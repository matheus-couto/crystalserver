local crandoriaTaskKill = CreatureEvent("crandoriaTaskKill")

function crandoriaTaskKill.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
    if not creature:isMonster() then
        return true
    end

    local monster = creature:getMonster()

    if not monster then
        return true
    end

    local raceId = monster:getRaceId()

    if not raceId or raceId == 0 then
        return true
    end

    local damageMap = monster:getDamageMap()

    for playerId, _ in pairs(damageMap) do
        local player = Player(playerId)

        if player then
            CrandoriaTaskSystem.onKill(player, raceId)
        end
    end

    return true
end

crandoriaTaskKill:register()