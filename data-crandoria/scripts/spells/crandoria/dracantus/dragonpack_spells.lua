--[[
    "dragonpack spells" — usada por todos os bosses do Dragon Pack.
    Sorteia uma skill dentro da pool: a própria + as de bosses já mortos.
]]

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
    local pool = getDragonPackAvailableSkills(creature:getName())

    if #pool == 0 then
        return true -- segurança: não deveria acontecer, mas evita erro se a tabela estiver vazia
    end

    local chosenSkill = pool[math.random(1, #pool)]
    return chosenSkill:execute(creature, var)
end

spell:name("dragonpack spells")
spell:words("###802")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:needDirection(true)
spell:register()
