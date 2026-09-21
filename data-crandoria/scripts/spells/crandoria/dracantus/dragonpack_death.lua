--[[
    Marca a storage global do Dragon Pack quando um dos bosses morre,
    liberando a skill dele pra herança dos próximos.

    IMPORTANTE: registre esse script no arquivo .xml de CADA boss do pack
    (Maliz, Vengar, Bruton, Greedok, Vilear, Crultor, Despor) com:
    <script>
        <event name="DragonPackDeath"/>
    </script>
]]

local DragonPackDeath = CreatureEvent("DragonPackDeath")

function DragonPackDeath.onDeath(creature, corpse, killer, mostDamageKiller, unjustified, mostDamageUnjustified)
    markDragonPackBossDead(creature:getName())
    return true
end

DragonPackDeath:register()
